*** Settings ***
Resource                 ../resources/common.robot
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

Loop Testing
    GoTo                        https://qentinelqi.github.io/shop/
    @{animals}                  Create List                 Sacha the Deer              Bumble the Elephant         Gerald the Giraffe
    FOR                         ${item}                     IN                          @{animals}
        ClickText               ${item}
        VerifyText              Slim Fit, 5oz 100% Cotton T-Shirt.
        ClickText               Add to cart
        VerifyText              Shipping and taxes will be calculated at checkout.
        ClickText               Products
        VerifyText              Find your spirit animal
    END



Loop Over a List with Nested If Statement
    @{users}                    Create List                 Guest                       Sales                       Admin
    FOR                         ${user}                     IN                          @{users}
        Log                     This is a success message.
        IF                      '${user}' == 'Admin'
            Log                 The current user is an Admin
        ELSE IF                 '${user}' == 'Guest'
            Log                 The current user is an Guest
        ELSE
            Log                 The current user is someone else
        END
    END


Mathematical Expressions
    ${discount_percentage}=     Set Variable                .2
    ${list_price}=              Set Variable                100000
    ${total_cost}=              Set Variable                5000
    ${currency}=                Set Variable                USD

        #Calculate Net Price at 20% discount of List Price
    ${net_price}=               Evaluate                    int(${list_price}-(${list_price}*${discount_percentage}))
    Should Be Equal As Integers                             ${net_price}                80000

        #Convert 80000 to USD 80,000
    ${net_price_formatted}=     Format String               {:,}                        ${net_price}
    Should Be Equal             ${currency} ${net_price_formatted}                      USD 80,000


Fake Data Generator 
    ${address} =       FakerLibrary.address
    ${country} =       FakerLibrary.country
    ${email} =         FakerLibrary.email
    ${first_name} =    FakerLibrary.first_name
    ${last_name} =     FakerLibrary.last_name
    ${phone_number} =  FakerLibrary.phone_number
    Log               ${address} ${country} ${email} ${first_name} ${last_name} ${phone_number}   formatter=repr
