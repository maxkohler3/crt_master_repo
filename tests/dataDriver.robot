*** Settings ***
Resource                        ../resources/common.robot
Library                         FakerLibrary
Suite Setup                     Setup Browser
Test Setup                      Run Keywords                Home                        Unique Test Data
Suite Teardown                  Close All Browsers
Test Template                   Create Verify and Delete Lead End to End


*** Test Cases ***                                                                            
Data Driver Test Template Case      ${LastName}   ${Phone}   ${Company}   ${FirstName}   ${Email}   ${Salutation}   ${Title} 


*** Keywords ***

Create Verify and Delete Lead End to End
    [Arguments]             ${LastName}   ${Phone}   ${Company}   ${FirstName}   ${Email}   ${Salutation}   ${Title} 
    Create and Delete Lead  
    
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
    Authenticate            ${client_id}                ${client_secret}            ${username}                 ${password}
    ${response}=            Create Record               Lead                        LastName=${LastName}        Phone=${Phone}              Company=${Company}
    ...                     FirstName=${FirstName}      Email=${Email}              Salutation=${Salutation}    Title=${Title}
    Delete Record   Lead    ${response}