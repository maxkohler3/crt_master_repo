*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
 
Create Lead on Website
    [Documentation]   E2E Test Scenario: Create Lead on company website; verify record in SFDC
    GoTo              https://www.copado.com
    ClickText         GET A DEMO      
    TypeText          First Name*       ${first_name}
    TypeText          Last Name*        ${last_name}
    TypeText          Business Email*   ${email}
    TypeText          Phone*            ${phone} 
    TypeText          Company*          ${company}
    DropDown          Employee Size*    ${employees}
    TypeText          Job Title*        ${title}
    DropDown          Country           ${country}

Verify Lead in SFDC
    Home                        
    LaunchApp         Sales
    ClickText         Leads
    ClickText         New
    UseModal          On                          

    Picklist          Salutation        ${salutation}
    TypeText          First Name        ${first_name}
    TypeText          Last Name         ${last_name}
    TypeText          Phone             ${phone}             
    TypeText          Company           ${company}                   
    TypeText          Title             ${title}                  
    TypeText          Email             ${email}       
    TypeText          Website           ${website}
    ClickText         Cancel 
    

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


Browser Examples
    OpenWindow
    SwitchWindow    1
    OpenBrowser     https://www.copado.com      firefox
    OpenBrowser     about:chrome                chrome
    OpenBrowser     about:chrome     chrome    options=incognito


