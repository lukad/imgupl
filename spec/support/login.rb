module Login
  %i(guest user mod admin).each do |role|
    define_method("login_#{role}") do
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in create(role)
      end
    end
  end
end
