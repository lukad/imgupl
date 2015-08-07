include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :upload do |u|
    u.image { fixture_file_upload(File.join(Rails.root, *%w(spec support images foo.png))) }
    user
  end
end
