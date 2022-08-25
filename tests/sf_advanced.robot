*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***

E2E Data Driven Test
    GoTo              https://www.copado.com
    ClickText         GET A DEMO      
    TypeText          First Name*       Marty
    TypeText          Last Name*        McFly
    TypeText          Business Email*   delorean88@copado.com
    TypeText          Phone*            1234567890
    TypeText          Company*          Copado
    DropDown          Employee Size*    1-2,500
    TypeText          Job Title*        Sales Engineer
    DropDown          Country           United States

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

    
    Home
    LaunchApp    Sales
    ClickText    Accounts
    ClickText    New
    UseModal

    TypeText     Account Name    ${account_name}
    TypeText     Phone           ${phone}
    TypeText     Fax             ${fax}
    TypeText     Website         ${website}
    PickList     Industry        ${industry}
    TypeText     Employees       ${employees}
    TypeText     Annual Revenue  ${annual_revenue}
    ClickText    Cancel  

Verify Picklist Options    
    Home
    LaunchApp             Sales
    ClickText             Leads
    ClickText             New
    UseModal
    ${salutation_options}=            GetPickList           Salutation 
    @{salutation_list}=                Convert to List           ${salutation_options}
    FOR    ${salutation}      IN    @{salutation_list}             
        PickList            Salutation           ${salutation}
        VerifyPickList      Salutation           ${salutation}
        LogScreenshot
    END



