@3.0.2

Feature: API Projects


  Background:  User logs back into portal

    Given selenium is required
    And user navigates to "OMSEUrl"
    And user is on "Dashboard" screen
    When user clicks on "SignIn_Button"
    And user enter "seleniumtest@mailinator.com" in "Email_Address_Field"
    And user enter "Password1" in "Password_Field"
    Then user clicks on "Sign_In_Button"


  Scenario: Regenerates API Key

    Given user clicks on "API_Projects"
    And user clicks on "1stProject"
    And user clicks on "Project_ActionButton"
    And user clicks on "RegenerateApiKey"
    And user copies the "Confirmationcode"
    And user enter "Confirmationcode" in "confirmationCodeInputField"
    When user clicks on "RegenerateAPIKeyButton"
    Then "New_API_Key" is displayed on the "Project_API_Key_field"
    And user close the browser
