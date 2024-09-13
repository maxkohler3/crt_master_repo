*** Settings ***
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite
# Library           DataDriver    reader_class=TestDataApi    name=organized_user_stories_with_separate_columns_output_from_ChatGPT_-_organized_user_stories_with_separate_columns_output_from_ChatGPT.csv
Library    DataDriver    reader_class=TestDataApi    name=Insurance_US.xlsx
Test Template     Create US via UI

*** Test Cases ***

User Story: ${Title}
    [Documentation]    Creating User Stories from csv file using data driver lib
    [Tags]        data 
    


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

Create US via API
    [Arguments]    ${User Story Number}    ${Title}    ${As a}    ${Want to}    ${So that}    ${Functional Specifications}    ${Technical Specifications}    ${Acceptance Criteria}    ${Object}    ${Field API Name}    ${Data Type}    ${Development Steps}
    Authenticate   ${consumer_key}  ${consumer_secret}  ${user}   ${pass}   
    ${response}=   Create Record   copado__User_Story__c         
    ...            copado__User_Story_Title__c=${Title}       
    ...            RecordTypeId=012am000000jAeZAAU               
    ...            copado__Project__c=a15am000000pvwGAAQ
    ...            copado__Acceptance_Criteria__c=${Acceptance Criteria}   
    ...            copado__Functional_Specifications__c=${Functional Specifications}   
    ...            copado__userStory_Role__c=${As a}             
    ...            copado__userStory_need__c=${Want to}                 
    ...            copado__userStory_reason__c=${So that}        
    ...            copado__Technical_Specifications__c=${Technical Specifications} 
    Delete Record   copado__User_Story__c      ${response}

Create US via UI
    Login Playground
    LaunchApp    User Stories
    ClickText    New 
    UseModal
    ClickText    User Story     Investigation 
    ClickText    Next
    TypeText     Title                        ${Title}
    TypeText     As a...                      ${As a}
    TypeText     Want to...                   ${Want to} 
    TypeText     So that...                   ${So that} 
    TypeText     Acceptance Criteria          ${Acceptance Criteria}

    ScrollTo     Functional Specifications
    QVision.ClickText    Functional Specifications         below=10
    WriteText            ${Functional Specifications}  
    QVision.ClickText    Technicnal Specifications         below=10   
    WriteText            ${Technical Specifications} 
    ClickText            Cancel    

 
Example Test
    [Arguments]    ${User Story}    ${Title}    ${As a}    ${Want to}    ${So that}    ${Functional Specifications}    ${Technical Specifications}    ${Acceptance Criteria}    ${Metadata Components}    ${Development Steps}
    # Your tests here, this is just an example
    # just use the values from excel using variable names
    # ClickText     ${User Story}
    # VerifyText    ${Title}
    # VerifyText    ${As a}
    # VerifyText    ${Want to}
    # VerifyText    ${So that}

  