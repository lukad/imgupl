require 'rails_helper'

RSpec.describe Upload, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to validate_presence_of(:user) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
