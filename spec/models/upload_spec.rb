require 'rails_helper'

RSpec.describe Upload, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:image) }
  end
end
