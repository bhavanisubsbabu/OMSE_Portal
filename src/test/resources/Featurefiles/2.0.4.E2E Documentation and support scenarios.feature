@2.0.4.E2E

Feature:Documentation

 Background: :User logs back into portal
Given selenium is required


  Scenario: Documentation pages before sign in

    Given user is on "Dashboard" page
    Then "Documentation" is displayed in "Documentation_Menu" area
    When user clicks on "Documentation_Menu"
    Then "Documentation" is displayed in "page_Title" area
    And "OS Data Hub documentation" is displayed in "OS_Data_Hub_Documentation_subTitle" area
    And API product links are displayed in "Documents_link" area
      | OS Features API: Overview    |
      | OS Maps API: Overview        |
      | OS Vector Tile API: Overview |
    #Verify OS Features API: Overview
    When user clicks on "OS_Features_API_Overview_Link"
    Then "OS Features API: Overview" is displayed in "Title" area
    And user clicks on "Breadcrump_link"
    #Verify OS Maps API: Overview
    When user clicks on "OS_Maps_API_Overview_Link"
    Then "OS Maps API: Overview" is displayed in "Title" area
    And user clicks on "Breadcrump_link"
    #Verify OS Vector Tile API: Overview
    When user clicks on "OS_Vector_Tile_API_Overview_Link"
    Then "OS Vector Tile API: Overview" is displayed in "Title" area
    And user clicks on "Breadcrump_link"
    And user close the browser

  Scenario: Documentation pages after sign in
    # User Sigin
    Given user is on "Dashboard" page
    When user clicks on "SignIn_Button"
    And user enter "seleniumtest@mailinator.com" in "Email_Address_Field"
    And user enter "Password1" in "Password_Field"
    And user clicks on "Sign_In_Button"

    #User verifies Documentation
    Given user is on "Dashboard" page
    Then "Documentation" is displayed in "Documentation_Menu" area
    When user clicks on "Documentation_Menu"
    Then "Documentation" is displayed in "page_Title" area
    And "OS Data Hub documentation" is displayed in "OS_Data_Hub_Documentation_subTitle" area
    And API product links are displayed in "Documents_link" area
      | OS Features API: Overview                   |
      | OS Features API: Getting started guide      |
      | OS Features API: Technical specification    |
      | OS Maps API: Overview                       |
      | OS Maps API: Getting started guide          |
      | OS Maps API: Technical specification        |
      | OS Vector Tile API: Overview                |
      | OS Vector Tile API: Getting started guide   |
      | OS Vector Tile API: Technical specification |
    #WFS documentation
    #Verify OS Features API: Overview
    When user clicks on "OS_Features_API_Overview_Link"
    Then "OS Features API: Overview" is displayed in "Title" area
    And user clicks on "Breadcrump_link"
     #Verify OS Features API: Getting started guide
    When user clicks on "OS_Features_Api_Getting_Started_Guide_Link"
    Then "OS Features API: Getting started guide" is displayed in "Title" area
    And user clicks on "Breadcrump_link"
     #Verify OS Features API: Technical specification
    When user clicks on "OS_Features_API_Technical_Specification_Link"
    Then "OS Features API: Technical specification" is displayed in "Title" area
    And user clicks on "Breadcrump_link"

    #WMTS documentation
    #Verify OS Maps API: Overview
    When user clicks on "OS_Maps_API_Overview_Link"
    Then "OS Maps API: Overview" is displayed in "Title" area
    And user clicks on "Breadcrump_link"
    #Verify OS Maps API: Getting started guide
    When user clicks on "OS_Maps_Api_Getting_Started_Guide_Link"
    Then "OS Maps API: Getting started guide" is displayed in "Title" area
    And user clicks on "Breadcrump_link"
     #Verify OS Maps API: Technical specification
    When user clicks on "OS_Maps_API_Technical_Specification_Link"
    Then "OS Maps API: Technical specification" is displayed in "Title" area
    And user clicks on "Breadcrump_link"

    #VTS documentation
    #Verify OS Vector Tile API: Overview
    When user clicks on "OS_Vector_Tile_API_Overview_Link"
    Then "OS Vector Tile API: Overview" is displayed in "Title" area
    And user clicks on "Breadcrump_link"
     #Verify OS Vector Tile API: Getting started guide
    When user clicks on "OS_Vector_Tile_Api_Getting_Started_Guide_Link"
    Then "OS Vector Tile API: Getting started guide" is displayed in "Title" area
    And user clicks on "Breadcrump_link"
     #Verify OS Vector Tile API: Technical specification
    When user clicks on "OS_Vector_Tile_API_Technical_Specification_Link"
    Then "OS Vector Tile API: Technical specification" is displayed in "Title" area
    And user clicks on "Breadcrump_link"

    And user close the browser




