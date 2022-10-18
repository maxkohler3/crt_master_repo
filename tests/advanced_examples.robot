*** Settings ***
Resource                 ../resources/common.robot
Resource                 ../resources/advanced.robot
Suite Setup              Setup Browser
Suite Teardown           End suite


*** Test Cases ***
Create Lead on Website
    [Documentation]   E2E Test Scenario: Create Lead on company website; verify record in SFDC
    [Tags]            Data Driven
    GoTo              https://www.copado.com
    ClickText         GET A DEMO
    TypeText          First Name*         ${first_name}
    TypeText          Last Name*          ${last_name}
    TypeText          Business Email*     ${email}
    TypeText          Phone*              ${phone}
    TypeText          Company*            ${company}
    DropDown          Employee Size*      ${employees}
    TypeText          Job Title*          ${title}
    DropDown          Country             ${country}

Verify Lead in SFDC
    Home
    LaunchApp         Sales
    ClickText         Leads
    ClickText         New
    UseModal          On

    Picklist          Salutation          ${salutation}
    TypeText          First Name          ${first_name}
    TypeText          Last Name           ${last_name}
    TypeText          Phone               ${phone}
    TypeText          Company             ${company}
    TypeText          Title               ${title}
    TypeText          Email               ${email}
    TypeText          Website             ${website}
    ClickText         Cancel

Advanced Logic & Conditionals


Fake Data Generator 
    ${address} =      FakerLibrary.address
    ${country} =      FakerLibrary.country
    ${email} =        FakerLibrary.email
    ${first_name} =   FakerLibrary.first_name
    ${last_name} =    FakerLibrary.last_name
    ${phone_number} = FakerLibrary.phone_number
    Log               ${address}  ${country}  ${email}  ${first_name}  ${last_name}  ${phone_number}
