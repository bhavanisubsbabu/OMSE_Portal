@2.0.5.E2E

Feature:Support

  Background: User logs back into portal
    Given selenium is required

  Scenario: Support pages before sign in

    Given user is on "Dashboard" page
    Then "Support" is displayed in "Support_Menu" area
    When user clicks on "Support_Menu"
    Then "Support" is displayed in "page_Title" area
    And "FAQs" is displayed in "FAQ_subTitle" area
    And FAQ links are displayed in "FAQ_link" area
      | How do I sign up for an account? |
      | How do I change my password?     |
      | How do I change my display name? |
      | How do I generate API key?       |
      | Where is my API endpoint?        |
    And "Contact us" is displayed in "Contact_Us_subTitle" area
    And "businessenquiries@os.uk" is displayed in "Contact_Us_Email" area
    And "How do I sign up for an account?" is displayed in "How_do_I_signup_subTitle" area
    And "How do I change my password?" is displayed in "How_do_I_change_my_password_subTitle" area
    Then "How do I change my display name?" is displayed in "How_do_I_change_my_display_name_subTitle" area
    Then "How do I generate API key?" is displayed in "How_do_I_generate_API_key_subTitle" area
    Then "Where is my API endpoint?" is displayed in "Where_is_my_API_endpoint_subTitle" area
    And user close the browser

  Scenario: Support pages after sign in
    # User Sigin
    Given user is on "Dashboard" page
    When user clicks on "SignIn_Button"
    And user enter "seleniumtest@mailinator.com" in "Email_Address_Field"
    And user enter "Password1" in "Password_Field"
    And user clicks on "Sign_In_Button"

  #User verifies support pages
    Given user is on "Dashboard" page
    Then "Support" is displayed in "Support_Menu" area
    When user clicks on "Support_Menu"
    Then "Support" is displayed in "page_Title" area
    And "FAQs" is displayed in "FAQ_subTitle" area
    And FAQ links are displayed in "FAQ_link" area
      | How do I change my password?     |
      | How do I change my display name? |
      | How do I generate API key?       |
      | Where is my API endpoint?        |
    And "Contact us" is displayed in "Contact_Us_subTitle" area
    And "businessenquiries@os.uk" is displayed in "Contact_Us_Email" area
    And "How do I sign up for an account?" is not displayed in "full_Content" area
    And "How do I change my password?" is displayed in "How_do_I_change_my_password_subTitle" area
    And "How do I change my display name?" is displayed in "How_do_I_change_my_display_name_subTitle" area
    And "How do I generate API key?" is displayed in "How_do_I_generate_API_key_subTitle" area
    And "Where is my API endpoint?" is displayed in "Where_is_my_API_endpoint_subTitle" area
    And user close the browser