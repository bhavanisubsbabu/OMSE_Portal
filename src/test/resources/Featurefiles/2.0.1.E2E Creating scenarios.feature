@2.0.1.E2E
Feature:Positive End to End user journeys

  Background: User is on OSME Homepage
    Given selenium is required
    And user navigates to "OMSEUrl"

  Scenario: Positive End to End user journeys
#     Verify portal status is 200
#    Given user is on "Dashboard" screen
#    Then page returns "200" response
#    # Verify create a new account
#    When user clicks on "Get_Started_Button"
#    Then Sign-up screen displays with Sign up with Email link
#    And Sign-up screen displays with Sign in link
#    And user clicks on "SignUp_with_Email_Button"
#    And user enter "seleniumtest@mailinator.com" in "Email_Field"
#    And user clicks on "Send_Validation_Code_Button"
#    And email is sent to email ID provided
#    And user clicks on "verify_Code_Button"
#    And user enter "Password1" in "newPassword_Field"
#    And user enter "Password1" in "reenterPassword_Field"
#    And user enter "Selenium test user" in "displayName_Field"
#    And user clicks on "Create_Button"
#    And user account is created
#    And dashboard displays with user display name

    # Verify Sign in screen
    Given user is on "Dashboard" page
    When user clicks on "SignIn_Button"
    And user enter "seleniumtest@mailinator.com" in "Email_Address_Field"
    And user enter "Password1" in "Password_Field"
    And user clicks on "Sign_In_Button"

  # User is on the Dashboard page

    Given user is on "Dashboard" page
    When user clicks on "API_Projects"
    Then "API projects" page is displayed

     # User creates a new project

    When user clicks on "Create_new_project"
    And user enter "My project" in "project_name_field"
    And user clicks on "create_project_button"
    Then new project is created

      # User renames the Project

    Given user clicks on "API_Projects"
    And user clicks on "1stProject"
    When user renames the project to "Selenium WMTS Project"
    And user clicks on "API_Projects"

      # Products display & Add an API to your project

    And user clicks on "1stProject"
    And user clicks on "AddAPI_Button"
      # Add a WMTS Product to the Project
    Then user clicks on "Add_To_Project" next to "OS_Maps_API_(WMTS)" on the "API_popup_Window"
    And user clicks on "Done"

      # Creates a project from WFS product

    Given user clicks on "Add_API_Left_Menu"
    And user clicks on "cookie"
    Then user clicks on "Add_To_API_Project" next to "OS_Features_API_(WFS)" on the "API_Product_List_page"
    And user selects "Add_to_NEW_PROJECT"
    And user enter "Selenium WFS Project" in "project_name_field"
    And user clicks on "create_project_button"
    And user clicks on "API_Projects"

    # Verify both projects available in the Portal/ API projects

    Then "Selenium WFS Project" is displayed as "1stProject" in the projects page
    And "Selenium WMTS Project" is displayed as "2ndProject" in the projects page

    # Log out of the portal

    And user logout
    And user close the browser
