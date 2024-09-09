*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***

Create 3 User Stories via API          
    @{ids}                      Create List 
    Authenticate                ${consumer_key}  ${consumer_secret}  ${user}   ${pass}   
    FOR                         ${i}                        IN RANGE                    3
        ${LastName}             Last Name
        ${Phone}                Phone Number
        ${Company}              Company
        ${FirstName}            First Name
        ${Email}                Email
        ${Salutation}           Set Variable          Mr.
        ${Title}                Set Variable          Engineer
        ${response}=            Create Record   copado__User_Story__c       copado__User_Story_Title__c=CRT via API   
        ...                     copado__Acceptance_Criteria__c=${LastName}    copado__Functional_Specifications__c=${Phone}     
        ...                     copado__userStory_Role__c=${FirstName}        copado__userStory_need__c=${Email}                  
        ...                     copado__userStory_reason__c=${Salutation}     copado__Technical_Specifications__c=${Company}
        Append To List          ${ids}                      ${response}
    END

    FOR                 ${id}      IN       @{ids}
        Delete Record   Lead       ${id}
    END
    Login Playground
    

Create User Stories in Copado 
    Login Playground
    LaunchApp    User Stories
    ClickText    New 
    ClickText    User Story 
    ClickText    Next
    UseModal
    TypeText     Title                        Test US  #${title}
    TypeText     As a...                      Tester   #${role}
    TypeText     Want to...                   Test Something  #${action}
    TypeText     So that...                   It Works        #${result}
    TypeText     Acceptance Criteria          Nothing breaks  #${acc_crit}

    ScrollTo     Functional Specifications
    QVision.ClickText    Functional Specifications         below=10
    WriteText            Spec A, B, C                      #${func_specs}
    QVision.ClickText    Technicnal Specifications         below=10   
    WriteText            Spec D, E, F                      #${tech_specs}
    ClickText            Cancel    #Save


Create User Stories using Data Loader 
    Login Playground
    GoTo    ${sf_url}/lightning/setup/SetupOneHome/home
    TypeText    Quick Find    Data import
    ClickText                 Data Import Wizard
    ClickText                 Launch Wizard!
    ClickText                 Custom Objects   
    ClickText                 User Stories   
    ClickText                 Add new records



*** Variables ***
${user}    mkohler@copado.com.one
${pass}    Copado1234%
${sf_url}    https://copadotrial134754419.my.salesforce.com/

*** Keywords ***

Login Playground
    GoTo         ${sf_url}
    TypeText     Username        ${user}
    TypeText     Password        ${pass}
    ClickText    Log In

