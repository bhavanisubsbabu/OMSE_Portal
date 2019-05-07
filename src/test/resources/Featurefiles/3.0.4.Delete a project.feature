@3.0.4

Feature: API Projects


  Background:  User logs back into portal

    Given selenium is required
    And user navigates to "OMSEUrl"
    And user is on "Dashboard" screen
    When user clicks on "SignIn_Button"
    And user enter "seleniumtest@mailinator.com" in "Email_Address_Field"
    And user enter "Password1" in "Password_Field"
    Then user clicks on "Sign_In_Button"


  Scenario: User Creates a new project

    Given user is on "Dashboard" screen
    When user clicks on "API_Projects"
    Then "API projects" page is displayed


  Scenario: Delete a project

    Given user is on "project" page
    And user clicks on "2ndProject"
    And user clicks on "Project_ActionButton"
    And user clicks on "Delete_Project"
    And user copies the "DeleteConfirmationCode"
    And user enter "DeleteConfirmationCode" in "DeleteconfirmationCodeInputField"
    When user clicks on "PermanentlyRemoveProjectButton"
    Then User deletes the "project"
    And user close the browser
