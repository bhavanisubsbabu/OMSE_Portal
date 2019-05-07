@smoke
@signUp
Feature:User Sign up access OSME

  Background: User is on OSME Homepage
    Given selenium is required
    And user navigates to "OMSEUrl"


  Scenario: SignUp Functionality
    # user Sign up dashboard
    Given user is on "Dashboard" screen
    When user clicks on "SignUp_Button"
    Then Sign-up screen displays with Sign up with Email link
    And Sign-up screen displays with Sign in link
    #Verify Sign up with email link
    Given user is on "SignUp" screen
    And Sign-up screen displays with Sign up with Email link
    And Sign-up screen displays with Sign in link
    When user clicks on "SignUp_with_Email_Button"
#    #### Additional step to bypass the signup flow ####
#    And user clicks on "Sign_Up_Now_Link"
#    Then Sign up screen is displayed
    #Verify sign in link
    Given user is on "SignUp" screen
    And Sign-up screen displays with Sign up with Email link
    And Sign-up screen displays with Sign in link
    When user clicks on "SignIn_Link"
    Then Sign in screen is displayed
    #user Sign up with Valid Email
    Given user is on "SignUp" screen
    When user clicks on "SignUp_with_Email_Button"
#    #### Additional step to bypass the signup flow ####
#    And user clicks on "Sign_Up_Now_Link"
    And user enter username in "Email_Field"
    And user clicks on "Send_Validation_Code_Button"
    And text field for verification code is displayed
    Then email is sent to email ID provided

#    When user enter "verification code" in "Verification_Code_Field"
    And user clicks on "verify_Code_Button"
    And user enter "Password1" in "newPassword_Field"
    And user enter "Password1" in "reenterPassword_Field"
    And user enter "Pradeep002" in "displayName_Field"
    And user clicks on "Create_Button"
    Then user account is created
    And dashboard displays with user display name



