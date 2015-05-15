ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'New Users' do
          table do
            thead do
              th User.human_attribute_name(:username)
              th User.human_attribute_name(:created_at)
              th 'confirmed'
            end
            tbody do
              User.order(created_at: 'desc').limit(10).map do |user|
                tr do
                  td link_to(user.username, admin_user_path(user))
                  td user.created_at
                  td(span user.confirmed? ? 'Yes' : 'No', class: "status_tag #{user.confirmed? ? 'yes' : 'no'}")
                end
              end
            end
          end
        end
      end

      column do
        panel 'Stats' do
          div class: 'attributes_table' do
            table do
              tr do
                th 'Confirmed registrations'
                td User.confirmed.count
              end
              tr do
                th 'Unconfirmed registrations'
                td User.unconfirmed.count
              end
              tr do
                th 'Uploads'
                td Upload.count
              end
            end
          end
        end
      end
    end
  end
end
