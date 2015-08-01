ActiveAdmin.register Comment do
  belongs_to :user, optional: true
  belongs_to :upload, optional: true

  permit_params :body, :user_id

  remove_filter :parent,
                :children,
                :ancestor_hierarchies,
                :descendant_hierarchies,
                :self_and_ancestors,
                :self_and_descendants,
                :upload

  index do
    selectable_column
    id_column
    column :body
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :user, include_blank: false
      f.input :body
    end
    f.actions
  end
end
