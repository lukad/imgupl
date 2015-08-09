Given(/^I am on the "(.*?)" page$/) do |page_name|
  paths = {
    'registration' => new_user_registration_path,
    'reset password' => new_user_password_path
  }
  visit paths[page_name]
end
