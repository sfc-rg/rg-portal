class PresentationOrdersController < ApplicationController
  before_action :require_active_current_user
  before_action :require_privilege, only: :create
  before_action :set_meeting

  def index
  end

  def create
    Presentation.transaction do
      settle_presentation_order!
    end
    redirect_to meeting_path(@meeting), flash: { success: 'プレゼンテーション順を変更しました' }
  rescue => e
    redirect_to meeting_path(@meeting), flash: { error: "プレゼンテーション順の変更に失敗しました\nエラー: #{e.message}" }
  end

  private

  def settle_presentation_order!
    orders = presentation_order_params[:order]
    randoms = presentation_order_params[:random]
    available_orders = Array(1..@meeting.presentations.size)
    available_orders -= orders.values.map(&:to_i)
    randoms.select { |_, random| !random.to_i.zero? }.each do |id, order|
      orders[id] = available_orders.delete(available_orders.sample)
    end
    Presentation.where(meeting: @meeting, id: orders.keys.map(&:to_i)).each do |presentation|
      presentation.update!(order: orders[presentation.id.to_s].to_i)
    end
  end

  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end

  def presentation_order_params
    @presentation_order_params ||=
      params.require(:presentation_order).tap do |list|
        list[:order] = list[:order].is_a?(Hash) ? list[:order] : Hash.new
        list[:random] = list[:random].is_a?(Hash) ? list[:random] : Hash.new
      end
  end
end
