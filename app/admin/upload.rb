ActiveAdmin.register Upload do
  belongs_to :user, optional: true

  permit_params :user_id, :image

  index do
    id_column
    column :created_at
    column :updated_at
    column :image do |upload|
      a href: upload.image.url do
        img src: upload.image.thumb.url
      end
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :created_at
      row :updated_at
      row :image_secure_token
      row(:image_file_path) { upload.image.path }
      row :image do
        a href: upload.image.url do
          img src: upload.image.thumb.url
        end
      end
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs :user, :image
    f.actions
  end
end
