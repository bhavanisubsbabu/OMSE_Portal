@2.0.3.E2E

Feature:Edit and delete projects

  Background: :User logs back into portal
    Given selenium is required
    And user navigates to "OMSEUrl"
    And user is on "Dashboard" page
    When user clicks on "SignIn_Button"
    And user enter "seleniumtest@mailinator.com" in "Email_Address_Field"
    And user enter "Password1" in "Password_Field"
    Then user clicks on "Sign_In_Button"

#  - User checks the usage of their projects and keys (should show that some requests have been made).

  Scenario: User regenerates API key for WMTS project

#    Copy the old Key
    Given user is on "project" page
    And user clicks on "2ndProject"
    And user copies the "WMTSAPIEndPoint"

#    Regenerate the Key
    When User regenerates the APIKey

#    Verifies the old key
    Then user verifies the "WMTSAPIEndPoint" doesn't work for "GetCapabilities_Wmts" link in browser and verifies for the following response "Invalid ApiKey"
    Then user verifies the "WMTSAPIEndPoint" doesn't work for "getTile_2" link in browser and verifies for the following response "Invalid ApiKey"

#    Copy the new Key
    And user is on "project" page
    And user clicks on "2ndProject"
    And user copies the "WMTSAPIEndPoint"

#    Verifies the New key
    Then user verifies the "WMTSAPIEndPoint" work for "GetCapabilities_Wmts" link in browser and verifies for the following response "WMTS"
    Then user verifies the "WMTSAPIEndPoint" work for "getTile_1" link in browser and verifies for the following response "Tile"
    And user close the browser

  Scenario: User now deletes the project that has the WMTS product.
    Given user is on "project" page
    And user clicks on "2ndProject"
    And user copies the "WMTSAPIEndPoint"
    Then User deletes the "2ndProject"
    Then user verifies the "WMTSAPIEndPoint" doesn't work for "GetCapabilities_Wmts" link in browser and verifies for the following response "Invalid ApiKey"
    Then user verifies the "WMTSAPIEndPoint" doesn't work for "getTile_1" link in browser and verifies for the following response "Invalid ApiKey"
    And user close the browser

  Scenario: User now adds the WMTS product to the project that has the WFS product associated to it.
    Given user is on "project" page
    And user clicks on "1stProject"
    And user clicks on "AddAPI_Button"
    Then user clicks on "Add_To_Project" next to "OS_Maps_API_(WMTS)" on the "API_popup_Window"
    And user close the browser

  Scenario: User verifies both getcapabilities and gettile requests work for the WMTS service using the APIkey for the project that originally had the WFS product associated to it. And verifies that the WFS requests still work using the APIkey for that project.
    Given user is on "project" page
    And user clicks on "1stProject"
    And user copies the "WFSAPIEndPoint"
    Then user verifies the "WFSAPIEndPoint" work for "GetFeature" link in browser and verifies for the following response "TopographicArea"
    And user verifies the "WFSAPIEndPoint" work for "GetCapabilities_WFS" link in browser and verifies for the following response "TopographicArea"
    And user verifies the "WFSAPIEndPoint" work for "Describefeaturetype_WFS" link in browser and verifies for the following response "TopographicArea"
    And user is on "project" page
    And user clicks on "1stProject"
    And user copies the "WMTSAPIEndPoint"
    #Then user verifies the "WMTSAPIEndPoint" work for "GetCapabilities_Wmts" link in browser and verifies for the following response "WMTS"
    Then user verifies the "WMTSAPIEndPoint" work for "getTile_1" link in browser and verifies for the following response "Tile"
    And user close the browser


  Scenario: User now deletes the WFS product from the project.
    Given user is on "project" page
    When user clicks on "1stProject"
    And user copies the "WFSAPIEndPoint"
    Then User deletes the "DeleteWFSProduct" product
    Then user verifies the "WFSAPIEndPoint" doesn't work for "GetFeature" link in browser and verifies for the following response "Invalid ApiKey"
    And user verifies the "WFSAPIEndPoint" doesn't work for "GetCapabilities_WFS" link in browser and verifies for the following response "Invalid ApiKey"
    And user verifies the "WFSAPIEndPoint" doesn't work for "Describefeaturetype_WFS" link in browser and verifies for the following response "Invalid ApiKey"
    And user close the browser

  Scenario: User verifies that the WMTS requests still work.
    Given user is on "project" page
    And user clicks on "1stProject"
    And user copies the "WMTSAPIEndPoint"
    #Then user verifies the "WMTSAPIEndPoint" work for "GetCapabilities_Wmts" link in browser and verifies for the following response "WMTS"
    And user verifies the "WMTSAPIEndPoint" work for "getTile_1" link in browser and verifies for the following response "Tile"
    And user close the browser

  Scenario: User now deletes remaining project to leave their account empty.
    Given user is on "project" page
    And user clicks on "1stProject"
    And user copies the "WMTSAPIEndPoint"
    Then User deletes the "1stProject"
    Then user verifies the "WMTSAPIEndPoint" doesn't work for "getTile_3" link in browser and verifies for the following response "Invalid ApiKey"
    Then user verifies the "WMTSAPIEndPoint" doesn't work for "GetCapabilities_Wmts" link in browser and verifies for the following response "Invalid ApiKey"
    And user close the browser
