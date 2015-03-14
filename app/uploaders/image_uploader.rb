class ImageUploader < CarrierWave::Uploader::Base
  # include CarrierWave::RMagick

  storage :file
  # storage :fog

  def filename
    "#{secure_token}.#{file.extension}"
  end

  def secure_token(length = 10)
    model.image_secure_token ||= SecureRandom.hex(length / 2)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [50, 50]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
