Given(/^I am on the "(.*?)" page$/) do |page_name|
  paths = {
    'registration' => new_user_registration_path
  }
  visit paths[page_name]
end
