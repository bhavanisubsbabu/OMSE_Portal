@2.0.2.E2E
Feature:User Verifies Requests for WMTS and WFS via Browser

  Scenario:Sigin
    Given selenium is required
    And user navigates to "OMSEUrl"
    And user is on "Dashboard" page
    When user clicks on "SignIn_Button"
    And user enter "seleniumtest@mailinator.com" in "Email_Address_Field"
    And user enter "Password1" in "Password_Field"
    Then user clicks on "Sign_In_Button"


  Scenario: Retrieve and Verify Responses from Services
    Given user is on "project" page
    And user clicks on "1stProject"
    And user copies the "APIEndPoint"
    Then user verifies the "APIEndPoint" work for "GetFeature" link in browser and verifies for the following response "TopographicArea"
    And user verifies the "APIEndPoint" work for "GetCapabilities_WFS" link in browser and verifies for the following response "TopographicArea"
    And user verifies the "APIEndPoint" work for "Describefeaturetype_WFS" link in browser and verifies for the following response "TopographicArea"
    And user is on "project" page
    And user clicks on "2ndProject"
    And user copies the "APIEndPoint"
    Then user verifies the "APIEndPoint" work for "GetCapabilities_Wmts" link in browser and verifies for the following response "WMTS"
    Then user verifies the "APIEndPoint" work for "getTile_1" link in browser and verifies for the following response "Tile"
    And user close the browser