require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:upload) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.not_to allow_value('').for(:body) }
    it { is_expected.to validate_length_of(:body).is_at_most(1024) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:upload) }
  end
end
