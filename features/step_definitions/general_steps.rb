And(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in field, with: value
end

And(/^I click "(.*?)"$/) do |button_name|
  click_button button_name
end

Then(/^I see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end
