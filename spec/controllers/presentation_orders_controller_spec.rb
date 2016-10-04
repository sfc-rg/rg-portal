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
end
