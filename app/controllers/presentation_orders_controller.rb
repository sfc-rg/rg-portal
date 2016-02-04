class PresentationOrdersController < ApplicationController
  before_action :require_active_current_user
  before_action :require_privilege, only: :create
  before_action :set_meeting

  def index
  end

  def create
    Presentation.transaction do
      orders = Array(1..@meeting.presentations.size)
      randomize_presentations = []
      presentation_order_params[:order].each do |presentation_id, order|
        order = order.to_i
        presentation = Presentation.find(presentation_id)
        unless order > 0
          # delay the determination of randomized order
          randomize_presentations.push(presentation)
          next
        end
        # update order fixed presentation
        presentation.update_attributes!(order: order)
        orders.delete(order)
      end
      # update order randomized presentation
      randomize_presentations.each do |presentation|
        order = orders.delete_at(rand(orders.size))
        presentation.update_attributes!(order: order)
      end
    end
    redirect_to meeting_path(@meeting), flash: { success: 'プレゼンテーション順を変更しました' }
  rescue => e
    redirect_to meeting_path(@meeting), flash: { error: "プレゼンテーション順の変更に失敗しました\nエラー: #{e.message}" }
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end

  def presentation_order_params
    params.require(:presentation_order).tap do |list|
      list[:order] = params[:order] if params[:order].is_a?(Hash)
    end
  end
end
