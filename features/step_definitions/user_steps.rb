Then(/^"(.*?)"s password was changed to "(.*?)"$/) do |login, password|
  expect(User.find_for_authentication(login: login).valid_password?(password)).to be(true)
end

Given(/^I sign in with "(.*?)" and "(.*?)"$/) do |login, password|
  visit new_user_session_path
  fill_in 'Username or Email', with: login
  fill_in 'Password', with: password
  click_button 'Sign In'
end

Given(/^I edit my account$/) do
  visit edit_user_registration_path
end

Then(/^"(.*?)"s email address is "(.*?)"$/) do |login, email|
  expect(User.find_for_authentication(login: login).email).to eq(email)
end

Then(/^I am logged in as "(.*?)"$/) do |login|
  user = User.find_for_authentication(login: login)
  expect(page).to have_content(user.username)
  expect(page).not_to have_content('Sign In')
  expect(page).to have_content('Sign Out')
end
