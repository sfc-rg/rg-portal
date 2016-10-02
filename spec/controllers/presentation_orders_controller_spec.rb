require 'rails_helper'

RSpec.describe PresentationOrdersController, type: :controller do
  render_views
  let(:user) { FactoryGirl.create(:user) }
  let(:meeting) { FactoryGirl.create(:meeting) }
  before { login_as_user(user) }

  describe '#index' do
    subject { get :index, meeting_id: meeting.id }
    it { is_expected.to render_template :index }
  end
  #
  describe '#create' do
    let(:presentation1) { FactoryGirl.create(:presentation, meeting: meeting, order: 1) }
    let(:presentation2) { FactoryGirl.create(:presentation, meeting: meeting, order: 2) }
    let(:presentation3) { FactoryGirl.create(:presentation, meeting: meeting, order: 3) }
    let(:presentations) { [presentation1, presentation2, presentation3] }
    let(:order) { Hash[presentations.map.with_index {|item, i| [item.id.to_s, (i + 1).to_s]}] }
    let(:random) { Hash[presentations.map {|item| [item.id.to_s, "0"]}] }

    subject { post :create, meeting_id: meeting.id, presentation_order: { order: order, random: random } }

    context 'with privilege' do
      before { FactoryGirl.create(:privilege, user: user, model: 'presentation_orders', action: 'create') }
      before do
        random[presentation1.id.to_s] = "1"
        order[presentation2.id.to_s] = "1"
        order[presentation3.id.to_s] = "2"
      end
      it { is_expected.to redirect_to meeting_path(meeting) }

      it 'change presentation orders' do
        expect { subject }.to change{ presentation1.reload.order }.from(1).to(3)
                          .and change{ presentation2.reload.order }.from(2).to(1)
                          .and change{ presentation3.reload.order }.from(3).to(2)
      end
    end

    context 'without privilege' do
      it { is_expected.to be_forbidden }
    end
  end
  #   let(:presentation) { FactoryGirl.create(:presentation, meeting: meeting) }
  #   subject { get :new, meeting_id: meeting.id }
  #
  #   context 'when accepting' do
  #     let(:meeting) { FactoryGirl.create(:meeting) }
  #     it { is_expected.to render_template :new }
  #   end
  #
  #   context 'when not accepting' do
  #     let(:meeting) { FactoryGirl.create(:meeting, accepting: false) }
  #     it { is_expected.to redirect_to meeting_path(meeting) }
  #   end
  # end
  #
  # describe '#create' do
  #   subject { post :create, meeting_id: meeting.id, presentation: FactoryGirl.attributes_for(:presentation) }
  #
  #   context 'when accepting' do
  #     let(:meeting) { FactoryGirl.create(:meeting) }
  #     it 'create a presentation' do
  #       expect { subject }.to change(Presentation, :count).by(1)
  #     end
  #     it { is_expected.to redirect_to meeting_path(meeting) }
  #   end
  #
  #   context 'when not accepting' do
  #     let(:meeting) { FactoryGirl.create(:meeting, accepting: false) }
  #     it 'do not create a presentation' do
  #       expect { subject }.to change(Presentation, :count).by(0)
  #     end
  #     it { is_expected.to redirect_to meeting_path(meeting) }
  #   end
  # end
  #
  # describe '#edit' do
  #   let(:meeting) { FactoryGirl.create(:meeting) }
  #   subject { get :edit, id: presentation.id }
  #   context 'when having an ownership' do
  #     let(:presentation) { FactoryGirl.create(:presentation, meeting: meeting, user: user) }
  #     it { is_expected.to render_template :edit }
  #   end
  #
  #   context 'when not having an ownership' do
  #     let(:presentation) { FactoryGirl.create(:presentation, meeting: meeting) }
  #     it { is_expected.to redirect_to meeting_path(meeting) }
  #   end
  # end
  #
  # describe '#update' do
  #   let(:meeting) { FactoryGirl.create(:meeting) }
  #   subject { patch :update, id: presentation.id, presentation: FactoryGirl.attributes_for(:presentation) }
  #   context 'when having an ownership' do
  #     let(:presentation) { FactoryGirl.create(:presentation, meeting: meeting, user: user) }
  #     it { is_expected.to redirect_to meeting_path(presentation.meeting) }
  #   end
  #
  #   context 'when not having an ownership' do
  #     let(:presentation) { FactoryGirl.create(:presentation, meeting: meeting) }
  #     it { is_expected.to redirect_to meeting_path(meeting) }
  #   end
  # end
  #
  # describe '#destroy' do
  #   let(:meeting) { FactoryGirl.create(:meeting) }
  #   subject { delete :destroy, id: presentation.id }
  #   context 'when having an ownership' do
  #     let!(:presentation) { FactoryGirl.create(:presentation, meeting: meeting, user: user) }
  #     it 'delete the presentation' do
  #       expect { subject }.to change(Presentation, :count).by(-1)
  #     end
  #     it { is_expected.to redirect_to meeting_path(presentation.meeting) }
  #   end
  #
  #   context 'when not having an ownership' do
  #     let!(:presentation) { FactoryGirl.create(:presentation, meeting: meeting) }
  #     it 'do not delete the presentation' do
  #       expect { subject }.not_to change(Presentation, :count)
  #     end
  #     it { is_expected.to redirect_to meeting_path(meeting) }
  #   end
  # end
end
