require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#bootstrap_class_for(flash_type)' do
    it { expect(bootstrap_class_for('success')).to eq 'alert-success' }
    it { expect(bootstrap_class_for('notice')).to eq 'alert-info' }
    it { expect(bootstrap_class_for('alert')).to eq 'alert-warning' }
    it { expect(bootstrap_class_for('error')).to eq 'alert-danger' }
    it { expect(bootstrap_class_for('foobar')).to eq 'foobar' }
  end
end
