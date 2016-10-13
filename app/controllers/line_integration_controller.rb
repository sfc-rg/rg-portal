class LineIntegrationController < ApplicationController
  before_action :verify_singature, only: :callback
  before_action :require_current_user, only: [:associate, :do_associate]
  before_action :set_line_credential, only: [:associate, :do_associate]
  protect_from_forgery except: :callback

  def associate

  end

  def do_associate
    @line_credential.update(user: @current_user)
    message = {
      type: 'text',
      text: "Portalアカウント(#{@current_user.nickname})と連携しました"
    }
    LineClient.push_message(@line_credential.encrypted_line_user_id, message)
  end

  def callback
    LineClient.parse_events_from(request.raw_post).each do |event|
      encrypted_line_user_id = event['source']['userId']
      logger.debug(" line_integration#callback >> type=#{event['type']}, id=#{encrypted_line_user_id}")

      case event
      when Line::Bot::Event::Follow
        profile = LineClient.get_profile(encrypted_line_user_id)
        line_credential = LineCredential.find_or_initialize_by(encrypted_line_user_id: encrypted_line_user_id)
        line_credential.update(
          display_name: profile['displayName'],
          encrypted_line_user_id: encrypted_line_user_id,
          picture_url: profile['pictureUrl'],
          unfollowed_at: nil
        )
        if line_credential.user.blank?
          message = {
            type: 'text',
            text: "以下のURLを開いてRG Portalアカウントとの連携処理を行ってください\n#{associate_line_url(ak: line_credential.associate_key)}"
          }
          LineClient.reply_message(event['replyToken'], message)
        end

      when Line::Bot::Event::Unfollow
        line_credential = LineCredential.find_or_initialize_by(encrypted_line_user_id: encrypted_line_user_id)
        line_credential.update(unfollowed_at: Time.now)

      when Line::Bot::Event::Beacon
        line_credential = LineCredential.find_by(encrypted_line_user_id: encrypted_line_user_id)
        if line_credential.present?
          attendance = MeetingAttendance.create(user: line_credential.user, meeting: Meeting.current)
          if attendance.persisted?
            message = {
              type: 'text',
              text: "#{attendance.meeting.name}に出席しました！"
            }
            LineClient.reply_message(event['replyToken'], message)
          end
        end
      end
    end

    head :ok
  end

  private

  def verify_singature
    signature = request.headers['HTTP_X_LINE_SIGNATURE']
    p signature
    p request.raw_post
    unless LineClient.validate_signature(request.raw_post, signature)
      head :bad_request
    end
  end

  def set_line_credential
    @line_credential = LineCredential.find_by!(associate_key: params[:ak], user_id: nil)
  rescue
    render text: 'Invalid params', layout: true, status: :forbidden
  end
end
