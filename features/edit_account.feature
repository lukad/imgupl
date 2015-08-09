Feature: Edit Account

  Background:
    Given I sign up with "foo", "foo@example.com" and "1234qwer" and confirm my account
    And I sign in with "foo" and "1234qwer"

  Scenario: Change email address
    Given I edit my account
    And I fill in "Email" with "new@example.com"
    And I fill in "Current password" with "1234qwer"
    And I click "Update"
    And "new@example.com" follows "Confirm my account" in the email
    Then "foo"s email address is "new@example.com"
