*** Settings ***
Resource                  ../resources/common.robot
Resource                  ../resources/api.resource
Suite Setup               Setup Browser
Suite Teardown            End suite


*** Test Cases ***
Get User Data from CRT REST API
    [Documentation]       Query data from Copado Robotic Testing API
    ${data}=              GetUserData
    ${title}=             Get From Dictionary         ${data}                     title
    ${email}=             Get From Dictionary         ${data}                     email
    ${phone}=             Get From Dictionary         ${data}                     phone
    Set Suite Variable    ${title}
    Set Suite Variable    ${email}
    Set Suite Variable    ${phone}

Enter A Lead in SFDC with CRT User Data
    [tags]                Lead                        Smoke                       Regression
    Home
    LaunchApp             Sales
    ClickText             Leads
    VerifyText            Change Owner
    ClickUntil            Lead Information            New

    UseModal              On                          #Only find fields from open modal dialog
    Picklist              Salutation                  Mr.
    TypeText              First Name                  Maximus
    TypeText              Last Name                   Aurelius
    TypeText              Title                       ${title}
    TypeText              Phone                       ${phone}
    TypeText              Email                       ${email}
    TypeText              Company                     Copado
    Picklist              Lead Status                 Open - Not Contacted
    ClickText             Cancel                      partial_match=False
    UseModal              Off


Verify Email sent to new SFDC User
    OpenWindow
    GoTo                  https://www.gmail.com       
    TypeText              Email or phone              CopadoTester@gmail.com
    ClickText             Next
    TypeText              Enter your password         ${emailPass}
    ClickText             Next

    ${crt_email}=   IsText   CRT Demo Email
    IF              ${crt_email} == True
        ClickText   CRT Demo Email
    ELSE IF         ${crt_email} == False
        ClickItem   Older
        ClickText   CRT Demo Email
    ELSE            
        ClickItem   Older
        ClickText   CRT Demo Email
    END  

    VerifyText            ${email}
    VerifyText            ${title}
    ${accountID}=         GetText                     CRT-       
    Log                   ${accountID}   
