*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***

Test Sample
    ${next_button}=           IsText                      Next    anchor=Cancel
    IF                          ${next_button}
        ClickText               Next
    END

    # VerifyTable                     r?text/c?text          Account 1
    # VerifyTable                     r2/c4                  Account 2
    
    # GetText 
    # GetInputValue

    # Exception handler to continue testing upon failure
    Run Keyword And Continue On Failure                    ClickText    asdfkgjh
    ClickText                        Chatter



Entering A Lead
    [tags]                    Lead
    Home
    LaunchApp                 Sales
    ClickText                 Leads
    VerifyText                Change Owner
    ClickText                 New
    VerifyText                Lead Information
    UseModal                  On                          # Only find fields from open modal dialog

    Picklist                  Salutation                  Ms.
    TypeText                  First Name                  Tina
    TypeText                  Last Name                   Smith
    PickList                  Lead Status                 Open - Not Contacted
    TypeText                  Phone                       +12234567858449             First Name
    TypeText                  Company                     Growmore                    Last Name
    TypeText                  Title                       Manager                     Address Information
    TypeText                  Email                       tina.smith@gmail.com        Rating
    TypeText                  Website                     https://www.growmore.com/

    ClickText                 Save                        partial_match=False
    UseModal                  Off
    Sleep                     1
    
    ClickText                 Details
    VerifyField               Name                        Ms. Tina Smith
    VerifyField               Lead Status                 Open - Not Contacted
    VerifyField               Phone                       +12234567858449
    VerifyField               Company                     Growmore
    VerifyField               Website                     https://www.growmore.com/
    
    ClickText                 Leads
    VerifyText                Tina Smith
    VerifyText                Manager
    VerifyText                Growmore


Converting A Lead To Opportunity
    [tags]                    Lead
    Home
    LaunchApp                 Sales
    ClickText                 Leads
    ClickUntil                Convert                 Tina Smith

    ClickUntil                Convert Lead                Convert
    ClickText                 Opportunity                 2
    TypeText                  Opportunity Name            Growmore Pace
    ClickText                 Convert                     2
    VerifyText                Your lead has been converted                            timeout=30

    ClickText                 Go to Leads
    ClickText                 Opportunities
    VerifyText                Growmore Pace
    ClickText                 Accounts
    VerifyText                Growmore
    ClickText                 Contacts
    VerifyText                Tina Smith

Expected Failed Test 
    Home 
    LaunchApp                 Sales
    ClickText                 Opportunitys                timeout=5

Delete Test Data
    [tags]                    Test data
    Home
    LaunchApp                 Sales
    ClickText                 Accounts

    Set Suite Variable        ${data}                     Growmore
    RunBlock                  NoData                      timeout=180s                exp_handler=DeleteAccounts

    ClickText                 Opportunities
    VerifyNoText              Safesforce Pace
    VerifyNoText              Growmore Pace
    VerifyNoText              Richard Brown
    VerifyNoText              Tina Smith

    # Delete Leads
    ClickText                 Leads
    VerifyText                Change Owner
    Set Suite Variable        ${data}                     Tina Smith
    RunBlock                  NoData                      timeout=180s                exp_handler=DeleteLeads
    Set Suite Variable        ${data}                     John Doe
    RunBlock                  NoData                      timeout=180s                exp_handler=DeleteLeads
    
