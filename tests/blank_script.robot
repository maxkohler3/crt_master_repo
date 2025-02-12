*** Settings ***
Resource                      ../resources/common.robot
Library                       QWeb
Library                       QForce
Library                       DataDriver    file=../data/leads.csv    encoding=utf-8
Suite Setup                   Setup Browser
Suite Teardown               End suite
Test Template                Create Lead Using CSV Data

*** Test Cases ***
Create Lead using ${salutation}    ${first_name}    ${last_name}    ${email}    ${phone}    ${company}    ${title}

*** Keywords ***
Create Lead Using CSV Data
    [Arguments]    ${salutation}    ${first_name}    ${last_name}    ${email}    ${phone}    ${company}    ${title}
    Home
    PickList    Salutation    ${salutation}
    TypeText    First Name    ${first_name}
    TypeText    Last Name     ${last_name}
    TypeText    Email         ${email}
    TypeText    Phone         ${phone}
    TypeText    Company       ${company}
    TypeText    Title         ${title}
