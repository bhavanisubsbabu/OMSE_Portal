@3.0.1

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


  Scenario: User renames the project

    Given user clicks on "API_projects"
    And user clicks on "1stProject"
    When user renames the project to "Selenium WMTS Project"
    Then user clicks on "API_Projects"
    Then "Selenium WFS Project" is displayed as "1stProject" in the projects page


  Scenario: Add an API and WMTS product

    Given user clicks on "1stProject"
    And user clicks on "AddAPI_Button"
    When user clicks on "Add_To_Project" next to "OS_Maps_API_(WMTS)" on the "API_popup_Window"
    And user clicks on "Done"
    And "Selenium WMTS Project" is displayed as "2ndProject" in the projects page


  Scenario: Creates a project from WFS product

    Given user clicks on "Add_API_Left_Menu"
    And user clicks on "cookie"
    Then user clicks on "Add_To_API_Project" next to "OS_Features_API_(WFS)" on the "API_Product_List_page"
    And user selects "Add_to_NEW_PROJECT"
    And user renames the project to "Selenium WFS Project"
    And user clicks on "API_Projects"


  Scenario: user log out

    And user logout
    And user close the browser










