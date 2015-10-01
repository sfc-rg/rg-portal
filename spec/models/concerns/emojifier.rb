require 'rails_helper'

shared_examples_for 'emojifier' do
  let(:model) { described_class }
  let(:factory) { model.to_s.underscore.to_sym }
  let(:object) { FactoryGirl.create(factory, content: content, user: nil) }

  subject { object.emojify }

  context 'content does not include any emojis' do
    let(:content) { 'Example content' }
    it { should eq(object.content) }
  end

  context 'content includes some emojis' do
    let(:content) { 'Example content :smile: :+1:' }
    it { should_not match(/:[\w+-]+:/) }
    it { should match(/<img/) }
  end

  context 'content includes invalid emojis' do
    let(:content) { 'Example content :--: | :sfc:' }
    it { should eq(object.content) }
  end
end
