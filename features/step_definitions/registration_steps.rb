Given(/^I sign up with "(.*?)", "(.*?)" and "(.*?)"$/) do |username, email, password|
  step %(I am on the "registration" page)
  step %(I fill in "Username" with "#{username}")
  step %(I fill in "Email" with "#{email}")
  step %(I fill in "Password" with "#{password}")
  step %(I click "Sign Up")
end

Given(/^I sign up with "(.*?)", "(.*?)" and "(.*?)" and confirm my account$/) do |username, email, password|
  step 'I am on the "registration" page'
  step %(I fill in "Username" with "#{username}")
  step %(I fill in "Email" with "#{email}")
  step %(I fill in "Password" with "#{password}")
  step 'I click "Sign Up"'
  step %("#{email}" follows "Confirm my account" in the email)
end

Then(/^"(.*?)" Is confirmed$/) do |email|
  expect(User.find_by(email: email)).to be_confirmed
end
