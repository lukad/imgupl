Then(/^"(.*?)"s password was changed to "(.*?)"$/) do |login, password|
  expect(User.find_for_authentication(login: login).valid_password?(password)).to be(true)
end

Then(/^I am logged in as "(.*?)"$/) do |login|
  user = User.find_for_authentication(login: login)
  expect(page).to have_content(user.username)
  expect(page).not_to have_content('Sign In')
  expect(page).to have_content('Sign Out')
end
