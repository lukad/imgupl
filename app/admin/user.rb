ActiveAdmin.register User do
  permit_params :username, :email, :password, :role

  filter :username
  filter :email
  filter :role, as: :select, collection: User.role.values
  filter :created_at
  filter :updated_at
  filter :confirmed_at
  filter :unconfirmed_email

  member_action :reset_password, method: :post do
    resource.send_reset_password_instructions
    redirect_to admin_user_path(resource), flash: { notice: 'Email was sent.' }
  end

  action_item :reset_password_link, only: :show do
    link_to 'Reset password',
            reset_password_admin_user_path(user),
            method: :post,
            data: { confirm: 'Send Email with password reset instructions?' }
  end

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
    column :role
    column :created_at
    column :confirmed_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :username
      row :email
      row :role
      row :created_at
      row :updated_at
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
    f.inputs do
      f.input :username
      f.input :email
      f.input :password
      f.input :role, as: :select, collection: User.role.values, include_blank: false
    end
    f.actions
  end
end
