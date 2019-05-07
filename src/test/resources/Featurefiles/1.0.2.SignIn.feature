@SignIn
Feature:User Sign In to OSME portal

  Background: User is on OSME Homepage
    Given selenium is required
    And user navigates to "OMSEUrl"

  Scenario: SignUp Functionality
    # Verify Sign in screen
    Given user is on "Dashboard" screen
    When user clicks on "SignIn_Button"
    Then Sign-in screen is displayed

    #Verify Sign In with valid credentials
    And user enter "seleniumtest@mailinator.com" in "Email_Address_Field"
    And user enter "Password1" in "Password_Field"
    And user clicks on "Sign_In_Button"
    Then dashboard displays with users display name indicating successful login
    And user logout


# Sign in with invalid email id
    When user clicks on "SignIn_Button"
    And user enter "seleniumtest@test.com" in "Email_Address_Field"
    And user enter "Password1" in "Password_Field"
    And user clicks on "Sign_In_Button"
    Then an error message "We can't seem to find your account" displays

#  Sign in screen -Invalid Password
    When user enter correct emailId "seleniumtest@mailinator.com" in "Email_Address_Field"
    And user enter "Password" in "Password_Field"
    And user clicks on "Sign_In_Button"
    Then an error message "Your password is incorrect" displays

  # Verify Sign Up Link
    And "don't have an account?" text is displayed
  And "Sign up now" link is displayed
    When user clicks on "Sign_Up_Now_Link"
    Then Sign up screen is displayed
    #  Given User is on Sign in Screen
#    When the deleted user enters valid user id and password
#    And clicks on Sign in button
#    Then the user shouldn't be allowed to login
#    And a relevant message should be displayed ( Actual message "" We can't seem to find your account"")
