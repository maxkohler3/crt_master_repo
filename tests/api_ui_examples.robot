*** Settings ***
Resource                      ../resources/common.robot
Resource                      ../resources/api.resource  
Suite Setup                   Run Keywords 
...                           Setup Browser  
...                           Authenticate   
Suite Teardown                End suite


*** Test Cases ***
Get User Data from CRT REST API
    [Documentation]           Query data from ext API
    ${data}=                  GetUserData
    ${title}=                 Get From Dictionary  ${data}  title
    ${email}=                 Get From Dictionary  ${data}  email
    ${phone}=                 Get From Dictionary  ${data}  phone
    Set Suite Variable        ${title}
    Set Suite Variable        ${email}
    Set Suite Variable        ${phone}
    

Enter A Lead
    [tags]               Lead   Smoke   Regression
    Home
    LaunchApp            Sales
    ClickText            Leads
    VerifyText           Change Owner
    ClickUntil           Lead Information        New

    UseModal             On                      #Only find fields from open modal dialog
    Picklist             Salutation              Mr.
    TypeText             First Name              Maximus
    TypeText             Last Name               Aurelius
    TypeText             Title                   ${title}
    TypeText             Phone                   ${phone}
    TypeText             Email                   ${email}
    TypeText             Company                 Copado
    Picklist             Lead Status             Open - Not Contacted
    ClickText            Save                    partial_match=False
    UseModal             Off

    ClickText            Details                 delay=1
    VerifyField          Name                    Mr. Maximus Aurelius
    VerifyField          Email                   ${email}
    VerifyField          Title                   ${title}
    VerifyField          Phone                   ${phone}
    VerifyField          Company                 Copado  
    VerifyField          Lead Status             Open - Not Contacted  

Delete Test Data
    ClickText             Leads
    VerifyText            Change Owner
    Set Suite Variable    ${data}                     Maximus Aurelius
    RunBlock              NoData                      timeout=180s                exp_handler=DeleteLeads