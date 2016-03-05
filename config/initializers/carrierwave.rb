if Rails.env.production?
  require 'carrierwave/storage/fog'
  Fog.credentials = { path_style: true }
end

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV.fetch('S3_KEY'),
      aws_secret_access_key: ENV.fetch('S3_SECRET'),
      region: ENV.fetch('S3_REGION'),
      endpoint: ENV['S3_ENDPOINT']
    }
    config.fog_public = true
    config.fog_directory = ENV['S3_BUCKET']
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  elsif Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
  else
    config.storage = :file
  end
end
