*** Settings ***
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite
Library           QVision


*** Test Cases ***

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
    GoTo        ${sf_url}/lightning/setup/SetupOneHome/home
    TypeText    Quick Find    Data import
    ClickText                 Data Import Wizard
    ClickText                 Launch Wizard!
    # ClickText                 Custom Objects   
    # ClickText                 User Stories  
    ClickText                 Leads
    ClickText                 Add new records
    ClickText                 CSV    partial_match=false
    QVision.ClickText         Choose File    tol=.5
    QVision.DoubleClick       suite
    QVision.DoubleClick       files
    QVision.DoubleClick       Leads.csv
    ClickText                 Next
    ClickText                 Next
    ClickText                 Start Import 
    ClickText                 OK
    UseTable                  Job ID
    ${jobID}                  GetCellText  r1/c2
    GoTo                      ${sf_url}
    LaunchApp                 Leads
    VerifyText                Eleanor Camish
    VerifyText                Monty Maguire 
    VerifyText                Magnolia Blossom
    ClickText                 Magnolia Blossom 
    ClickText                 Details 
    VerifyField               Company    Flowery  
    #verify all fields imported correctly

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
        ${response}=            Create Record   copado__User_Story__c        copado__User_Story_Title__c=CRT via API      
        ...                     copado__Acceptance_Criteria__c=${LastName}   copado__Functional_Specifications__c=${Phone}     
        ...                     copado__userStory_Role__c=${FirstName}       copado__userStory_need__c=${Email}                  
        ...                     copado__userStory_reason__c=${Salutation}    copado__Technical_Specifications__c=${Company}
        ...                     RecordTypeId=012am000000jAeZAAU              copado__Project__c=a15am000000pvwGAAQ
        Append To List          ${ids}                      ${response}
    END

    FOR                 ${id}      IN       @{ids}
        Delete Record   copado__User_Story__c      ${id}
    END


Create US
    Authenticate   ${consumer_key}  ${consumer_secret}  ${user}   ${pass}   
    ${response}=   Create Record   copado__User_Story__c         copado__User_Story_Title__c=${Title}       
    ...            RecordTypeId=012am000000jAeZAAU               copado__Project__c=a15am000000pvwGAAQ
    ...            copado__Acceptance_Criteria__c=${Acceptance Criteria}   copado__Functional_Specifications__c=${Functional Specifications}   
    ...            copado__userStory_Role__c=${As a}             copado__userStory_need__c=${Want to}                 
    ...            copado__userStory_reason__c=${So that}        copado__Technical_Specifications__c=${Technical Specifications} 
    Delete Record   copado__User_Story__c      ${response}


*** Variables ***
${user}    mkohler@copado.com.one
${pass}    Copado1234%
${sf_url}    https://copadotrial134754419.my.salesforce.com/
${consumer_key}    3MVG9bYGb9rFSjxRsBkkBHkPT95eY_PdmOQS.4E_iewov_A1.nLNP6oqJTIz9NMvuwR80lH9YgJ74BuxuQHGq
${consumer_secret}    908B451920D457EFCC4885885DACAFC90A96C9287FE249CC4AEE1D4F2D631440

*** Keywords ***

Login Playground
    GoTo         ${sf_url}
    TypeText     Username        ${user}
    TypeText     Password        ${pass}
    ClickText    Log In
