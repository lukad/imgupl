class Upload < ActiveRecord::Base
  MAX_FILE_SIZE = 2.megabytes.to_i

  mount_uploader :image, ImageUploader

  belongs_to :user

  validates :image, presence: true
  validates :image, integrity: true
  validates :image, processing: true
  validates :user, presence: true
  validate :file_size

  def file_size
    errors.add :image, "The image is bigger than the maximum file size of #{MAX_FILE_SIZE}" if image.size > MAX_FILE_SIZE
  end
end
