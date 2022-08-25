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



