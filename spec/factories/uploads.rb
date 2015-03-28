FactoryGirl.define do
  factory :upload do |u|
    u.image { Rack::Test::UploadedFile.new(File.join(Rails.root, *%w(spec support images foo.png))) }
    user
  end
end
