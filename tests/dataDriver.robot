*** Settings ***
Resource                        ../resources/common.robot
Resource                        ../resources/leads.robot
Library                         FakerLibrary
Suite Setup                     Setup Browser
Test Setup                      Run Keywords                Home                        Unique Test Data
Suite Teardown                  Close All Browsers
Test Template                   Create Verify and Delete Lead End to End

# In this exercise we use the same salesforce scenario built with exercise 6 and 12.

*** Test Cases ***                                                                            lead_status         last_name                      company        first_name     salutation
Exercise 14 - Data Driven Testing - Create Lead using Suite Test Template Unique Data         Working              ${last_name}                  ${company}     ${first_name}  Ms.
Exercise 14 - Data Driven Testing - Create Lead using Suite Test Template Fixed Data          Working              Smith                         Growmore       Tina           Ms.


*** Keywords ***

Create Verify and Delete Lead End to End
    [Arguments]             ${LastName}   ${Phone}   ${Company}   ${FirstName}   ${Email}   ${Salutation}   ${Title} 
    Create and Delete Lead  ${LastName}   ${Phone}   ${Company}   ${FirstName}   ${Email}   ${Salutation}   ${Title}    

Unique Test Data
    ${LastName}             Last Name
    Set Suite Variable      ${LastName}
    ${Phone}                Phone Number
    Set Suite Variable      ${Phone}
    ${Company}              Company
    Set Suite Variable      ${Company}
    ${FirstName}            First Name
    Set Suite Variable      ${FirstName}
    ${Email}                Email
    Set Suite Variable      ${Email} 
    ${Salutation}           Set Variable                Mr.
    Set Suite Variable      ${Salutation} 
    ${Title}                Set Variable                Engineer
    Set Suite Variable      ${Title} 


Create and Delete Lead
    Authenticate                ${client_id}                ${client_secret}            ${username}                 ${password}
    ${response}=            Create Record               Lead                        LastName=${LastName}        Phone=${Phone}              Company=${Company}
    ...                     FirstName=${FirstName}      Email=${Email}              Salutation=${Salutation}    Title=${Title}

    Delete Record   Lead       ${response}