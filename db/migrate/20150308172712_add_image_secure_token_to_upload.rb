class AddImageSecureTokenToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :image_secure_token, :string
  end
end
