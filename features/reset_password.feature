Feature: Reset password
  In order to recover my account when I have forgotten my password
  As a registered User
  I want to be able to reset my password using my email address

  Background:
    Given I sign up with "foo", "foo@example.com" and "1234qwer" and confirm my account
    And no emails have been sent

  Scenario Outline: Resetting the password
    Given I am on the "reset password" page
    And I fill in "Login" with "<login>"
    And I click "Send me reset password instructions"
    And "foo@example.com" follows "Change my password" in the email
    And I fill in "New password" with "qwer1234"
    And I fill in "Confirm new password" with "qwer1234"
    And I click "Change my password"
    Then I see "Your password has been changed successfully"
    And "foo"s password was changed to "qwer1234"
    And I am logged in as "foo"

    Examples:
      | login           |
      | foo             |
      | foo@example.com |
