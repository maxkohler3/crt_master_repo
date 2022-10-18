*** Settings ***
Library                   QWeb
Library                   QForce
Library                   String
Library                   DateTime 
Library                   Collections
Library                   RequestsLibrary
Library                   FakerLibrary


*** Variables ***
${login_url}              https://slockard-dev-ed.lightning.force.com/          
${home_url}               ${login_url}/lightning/page/home
${api}                    https://slockard-dev-ed.my.salesforce.com/ 
${account_name}           Acme Inc


*** Keywords ***
Setup Browser
    Set Library Search Order                          QWeb
    Evaluate              random.seed()
    Open Browser          about:blank                 ${BROWSER}
    SetConfig             LineBreak                   ${EMPTY}               #\ue000
    SetConfig             DefaultTimeout              20s                    #sometimes salesforce is slow


End suite
    Set Library Search Order                          QWeb
    Close All Browsers


Login
    [Documentation]       Login to Salesforce instance
    GoTo                  ${login_url}
    TypeText              Username                    ${username}             delay=1
    TypeText              Password                    ${password}
    ClickText             Log In


Home
    [Documentation]       Navigate to homepage, login if needed
    GoTo                  ${home_url}
    Sleep                 2
    ${login_status} =     IsText                      To access this page, you have to log in to Salesforce.    2
    Run Keyword If        ${login_status}             Login
    ClickText             Home
    VerifyTitle           Home | Salesforce
    Sleep                 2


# Example of custom keyword with robot fw syntax
VerifyStage
    [Documentation]       Verifies that stage given in ${text} is at ${selected} state; either selected (true) or not selected (false)
    [Arguments]           ${text}                     ${selected}=true
    VerifyElement         //a[@title\="${text}" and @aria-checked\="${selected}"]


Login As
    [Documentation]       Login As different persona. User needs to be logged into Salesforce with Admin rights
    ...                   before calling this keyword to change persona.
    ...                   Example:
    ...                   LoginAs    Chatter Expert
    [Arguments]           ${persona}
    ClickText             Setup
    ClickText             Setup for current app
    CloseWindow
    SwitchWindow          NEW
    TypeText              Search Setup                ${persona}             delay=2
    ClickText             User                        anchor=${persona}      delay=5    # wait for list to populate, then click
    VerifyText            Freeze                      timeout=45                        # this is slow, needs longer timeout          
    ClickText             Login                       anchor=Freeze          delay=1  


NoData
    VerifyNoText          ${data}                     timeout=3                        delay=2


DeleteAccounts
    [Documentation]       RunBlock to remove all data until it doesn't exist anymore
    ClickText             ${data}
    ClickText             Show more actions
    ClickText             Delete
    VerifyText            Are you sure you want to delete this account?
    ClickText             Delete                      2
    VerifyText            Undo
    VerifyNoText          Undo
    ClickText             Accounts                    partial_match=False


DeleteLeads
    [Documentation]       RunBlock to remove all data until it doesn't exist anymore
    ClickText             ${data}
    ClickText             Show more actions
    ClickText             Delete
    VerifyText            Are you sure you want to delete this lead?
    ClickText             Delete                      2
    VerifyText            Undo
    VerifyNoText          Undo
    ClickText             Leads                    partial_match=False


GetUserData
    [Documentation]       Get user information from CRT API
    ${session}=           Create Session        crt  ${api}     debug=3  verify=true
    ${resp}=              Get On Session
    ...                   crt
    ...                   /new/ui/user/me
    ...                   headers=&{ext_api_headers}  timeout=10
    Log                   ${resp.status_code}
    Log                   ${resp.json()}
    [Return]              ${resp.json()}
