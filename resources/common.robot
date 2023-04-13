*** Settings ***
Library                   QWeb
Library                   QForce
Library                   String
Library                   DateTime 
Library                   Collections
Library                   RequestsLibrary
Library                   FakerLibrary


*** Variables ***
${BROWSER}                chrome
${username}               crt-short@copado.com
${login_url}              https://slockard-dev-ed.lightning.force.com/          
${home_url}               ${login_url}/lightning/page/home
${api}                    https://slockard-dev-ed.my.salesforce.com/ 


*** Keywords ***
Setup Browser
    Set Library Search Order                   QWeb    QForce    QVision
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
    Fill MFA
    

Home
    [Documentation]       Navigate to homepage, login if needed
    GoTo                  ${home_url}
    Sleep                 2
    ${login_status} =     IsText                      To access this page, you have to log in to Salesforce.    2
    Run Keyword If        ${login_status}             Login
    ClickText             Home
    VerifyTitle           Home | Salesforce
    Sleep                 2

Fill MFA
    ${isMFA}=  IsText     Verify Your Identity                            #Determines MFA is prompted
     IF   ${isMFA}                                                        #Conditional Statement for if MFA verification is required to proceed
          ${mfa_code}=    GetOTP    ${username}    ${MY_SECRET}    ${password}
          TypeSecret      Code      ${mfa_code}
          ClickText       Verify
    END

VerifyStage
    # Example of custom keyword with robot fw syntax
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

InsertRandomValue
    [Documentation]       This keyword accepts a character count, suffix, and prefix. It then types a random string into the given field.
    [Arguments]           ${field}                    ${charCount}=5              ${prefix}=                  ${suffix}=
    ${testRandom}=        Generate Random String      ${charCount}
    TypeText              ${field}                    ${prefix}${testRandom}${suffix}
    
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

    
# Validate Table Cell 
#     ${opp_name}=                Set Variable       Robotic Testing
#     ${opp_name_visible}=        IsText                    ${opp_name}

#     IF                         ${opp_name_visible}
#         UseTable               Opportunity Name     #target a table using unique text
#         VerifyTable            r?${opp_name}/c?Stage      Qualification 
#     END  

# Click Next Page in Table 
#     ClickText    Next Page

Close All Salesforce Tabs
    HotKey                      shift                       w
    ${multiple_tabs}=           IsText                      Close all tabs?             5s
    IF                          ${multiple_tabs}
        ClickText               Close All
    END