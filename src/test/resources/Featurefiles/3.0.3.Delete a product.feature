@3.0.3

Feature: API Projects


  Background:  User logs back into portal

    Given selenium is required
    And user navigates to "OMSEUrl"
    And user is on "Dashboard" screen
    When user clicks on "SignIn_Button"
    And user enter "seleniumtest@mailinator.com" in "Email_Address_Field"
    And user enter "Password1" in "Password_Field"
    Then user clicks on "Sign_In_Button"


  Scenario: User Deletes product

    Given user is on "Dashboard" screen
    When user clicks on "API_Projects"
    Then "API projects" page is displayed
    When user clicks on "1stProject"
    Then User deletes the "DeleteWFSProduct" product
    And  user close the browser


