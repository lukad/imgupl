require 'rails_helper'

RSpec.describe Upload, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to validate_presence_of(:user) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  context 'navigation' do
    describe '#next' do
      let!(:upload1) { create(:upload) }
      let!(:upload2) { create(:upload) }

      it { expect(upload1.next).to eq(upload2) }
      it { expect(described_class.last.next).to be(nil) }
    end

    describe '#previous' do
      let!(:upload1) { create(:upload) }
      let!(:upload2) { create(:upload) }

      it { expect(described_class.first.previous).to be(nil) }
      it { expect(upload2.previous).to eq(upload1) }
    end
  end
end
