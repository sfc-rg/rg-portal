require 'rails_helper'

shared_examples_for 'emojifier' do
  let(:model) { described_class }
  let(:factory) { model.to_s.underscore.to_sym }

  subject { object.emojify }

  context 'contents do not include any emojis' do
    let(:object) { FactoryGirl.create(factory, content: 'Example content') }
    it { should eq(object.content) }
  end

  context 'contents include some emojis' do
    let(:object) { FactoryGirl.create(factory, content: 'Example content :smile: :+1:') }

    it { should_not match(/:[\w+-]+:/) }
    it { should match(/<img/) }
  end
end
