Feature: Registration
  In order start uploading pictures and posting comments
  As an unregistered User
  I want to be able to sign up via email, username and password

  Scenario: Receiving an confirmation mail
    Given I sign up with "foo", "foo@example.com" and "1234qwer"
    Then "foo@example.com" has received an email

  Scenario: Confirming the email address
    Given I sign up with "foo", "foo@example.com" and "1234qwer"
    And "foo@example.com" follows "Confirm my account" in the email
    Then "foo@example.com" Is confirmed

  Scenario Outline: Signing up with invalid data
    Given I sign up with "foo", "foo@example.com" and "1234qwer"
    And no emails have been sent
    And I sign up with "<username>", "<email>" and "<password>"
    Then I see "<message>"
    And "<email>" has received no emails

    Examples:
      | username | email           | password | message                         |
      |          | foo@example.org | 1234qwer | Username can't be blank         |
      | foo      | foo@example.org | 1234qwer | Username has already been taken |
      | bar      |                 | 1234qwer | Email can't be blank            |
      | bar      | foo@example.com | 1234qwer | Email has already been taken    |
      | bar      | foo@example.org | 1234     | Password is too short           |
      | bar      | foo@example.org | 1234     | Password is too short           |
      | bar      | foo@example.org |          | Password can't be blank         |
