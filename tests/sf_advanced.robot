*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
 

E2E Data Driven Test
    [Arguments]    ${first_name}    ${last_name}    ${email}    ${phone}    ${company}    ${employees}    ${title}    ${website}
    GoTo              https://www.copado.com
    ClickText         GET A DEMO      
    TypeText          First Name*       ${first_name}
    TypeText          Last Name*        ${last_name}
    TypeText          Business Email*   ${email}
    TypeText          Phone*            ${phone} 
    TypeText          Company*          ${company}
    DropDown          Employee Size*    1-2,500
    TypeText          Job Title*        ${title}
    DropDown          Country           United States

    Home
    LaunchApp         Sales
    ClickText         Leads
    ClickText         New
    UseModal          On                          

    Picklist          Salutation        Ms.
    TypeText          First Name        Tina
    TypeText          Last Name         Smith
    PickList          Lead Status       Open - Not Contacted
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



