ActiveAdmin.register User do
  permit_params :username, :email, :password, :admin

  sidebar 'Details', only: [:show, :edit] do
    ul do
      li link_to 'Uploads', admin_user_uploads_path(user)
    end
  end

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :created_at
    column :confirmed_at
    column :admin
    actions
  end

  show do
    attributes_table do
      row :id
      row :username
      row :email
      row :created_at
      row :updated_at
      row :admin
      row(:uploads) { user.uploads.count }
      row :confirmed_at
      row :confirmation_sent_at
      row :unconfirmed_email
      row :reset_password_token
      row :reset_password_sent_at
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs :username, :email, :password, :admin
    f.actions
  end
end
