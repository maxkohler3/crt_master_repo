*** Settings ***
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite
Library           QVision
Library           DataDriver    reader_class=TestDataApi    name=Insurance_US.xlsx   #organized_user_stories_with_separate_columns_output_from_ChatGPT_-_organized_user_stories_with_separate_columns_output_from_ChatGPT.csv
Test Template     Create US via UI  #Create US via API

*** Test Cases ***

User Story: ${Title}
    [Documentation]    Creating User Stories from csv file using data driver lib
    [Tags]        data 
    
*** Variables ***

${user}    mkohler@copado.com.one
${pass}    Copado12#$
${sf_url}    https://copadotrial134754419.my.salesforce.com/
${consumer_key}    3MVG9bYGb9rFSjxRsBkkBHkPT95eY_PdmOQS.4E_iewov_A1.nLNP6oqJTIz9NMvuwR80lH9YgJ74BuxuQHGq
${consumer_secret}    908B451920D457EFCC4885885DACAFC90A96C9287FE249CC4AEE1D4F2D631440

*** Keywords ***

Login Playground
    GoTo         ${sf_url}
    TypeText     Username        ${user}
    TypeText     Password        ${pass}
    ClickText    Log In

Create US via API
    # [Arguments]    ${User Story Number}    ${Title}    ${As_a}    ${Want_to}    ${So_that}    
    # ...            ${Functional_Specifications}    ${Technical_Specifications}    ${Acceptance_Criteria}    ${Object}    ${Field API Name}    ${Data Type}    ${Development Steps}
    Authenticate   ${consumer_key}  ${consumer_secret}  ${user}   ${pass}   
    ${response}=   Create Record   copado__User_Story__c         
    ...            copado__User_Story_Title__c=${Title}       
    ...            RecordTypeId=012am000000jAeZAAU               
    ...            copado__Project__c=a15am000000pvwGAAQ
    ...            copado__Acceptance_Criteria__c=${Acceptance_Criteria}   
    ...            copado__Functional_Specifications__c=${Functional_Specifications}   
    ...            copado__userStory_Role__c=${As_a}             
    ...            copado__userStory_need__c=${Want_to}                 
    ...            copado__userStory_reason__c=${So_that}        
    ...            copado__Technical_Specifications__c=${Technical_Specifications} 
    # Delete Record   copado__User_Story__c      ${response}

Create US via UI
    Login Playground
    LaunchApp    User Stories
    ClickText    New 
    UseModal
    ClickText    User Story     Investigation 
    ClickText    Next
    TypeText     Title                        ${Title}
    TypeText     As a...                      ${As_a}
    TypeText     Want to...                   ${Want_to} 
    TypeText     So that...                   ${So_that} 
    TypeText     Acceptance Criteria          ${Acceptance_Criteria}

    ScrollTo     Functional Specifications
    QVision.ClickText    Functional Specifications         below=10
    WriteText            ${Functional_Specifications}  
    QVision.ClickText    Technicnal Specifications         below=10   
    WriteText            ${Technical_Specifications} 
    ClickText            Save    


  
