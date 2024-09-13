*** Settings ***
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite
Library           QVision
Library           ExcelLibrary


*** Test Cases ***


Create User Stories using Data Loader 
    Login Playground
    GoTo        ${sf_url}/lightning/setup/SetupOneHome/home
    TypeText    Quick Find    Data import
    ClickText                 Data Import Wizard
    ClickText                 Launch Wizard!
    ClickText                 Custom Objects   
    ClickText                 User Stories  
    ClickText                 Add new records
    DropDown                  798:0    Project Name
    DropDown                  1110:0    User Story
    ClickText                 CSV    partial_match=false
    QVision.ClickText         Choose File    tol=.5
    QVision.DoubleClick       suite
    QVision.DoubleClick       files
    QVision.DoubleClick       user_story.csv
    ClickText                 Next

    ${document}=       Open Excel Document    ${excel_worksheet}   user_story
    ${api_label}=      Read Excel Row         max_num=7  row_num=1   sheet_name=user_story (1)
    ${us_data}=        Read Excel Row         max_num=7  row_num=2   sheet_name=user_story (1)
    ${sf_object}=      Set Variable   Title  Project  Functional Specifications  Technical Specifications  As a...  Want to...  So that...              

    FOR          ${x}   IN RANGE  0  7   
        UseTable                  Map        
        ClickCell                 r?${api_label}[${x}]/c1   
        ClickText                 ${sf_object}[${x}]        
        ClickText                 Map            Cancel
    END

    ClickText                 Next
    ClickText                 Start Import 
    ClickText                 OK

    GoTo                      ${sf_url}
    LaunchApp                 User Stories
    VerifyText                ${us_data}[0]
    UseTable                  Title
    ClickCell                 r?${us_data}[0]/c13
    ClickText                 Delete
    ClickText                 Delete   Cancel

    # ClickCell                 r?${us_data}[0]/c?User Story Reference
    # verify all fields imported correctly

 

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






# Create 3 User Stories via API          
#     ${document}=       Open Excel Document    ${excel_worksheet}   user_story
#     ${api_label}=      Read Excel Row         max_num=7  row_num=1   sheet_name=user_story (1)
#     ${us_data}=        Read Excel Row         max_num=7  row_num=2   sheet_name=user_story (1)
#     @{ids}                      Create List 
#     Authenticate                ${consumer_key}  ${consumer_secret}  ${user}   ${pass}   
#     FOR                         ${i}                        IN       @{api_label}
#         ${response}=   Create Record   copado__User_Story__c         
#         ...            ${api_label}=${us_data}[${i}]       
#         ...            RecordTypeId=012am000000jAeZAAU               
#         ...            copado__Project__c=a15am000000pvwGAAQ
#         Append To List          ${ids}                      ${response}
#     END

#     FOR                 ${id}      IN       @{ids}
#         Delete Record   copado__User_Story__c      ${id}
#     END


# Create 3 User Stories via API          
#     @{ids}                      Create List 
#     Authenticate                ${consumer_key}  ${consumer_secret}  ${user}   ${pass}   
#     FOR                         ${i}                        IN       @{api_label}
#         ${response}=   Create Record   copado__User_Story__c         
#         ...            copado__User_Story_Title__c=${Title}[${i}]       
#         ...            RecordTypeId=012am000000jAeZAAU               
#         ...            copado__Project__c=a15am000000pvwGAAQ
#         ...            copado__Acceptance_Criteria__c=${Acceptance_Criteria}[${i}]   
#         ...            copado__Functional_Specifications__c=${Functional_Specifications}[${i}]   
#         ...            copado__userStory_Role__c=${As_a}[${i}]             
#         ...            copado__userStory_need__c=${Want_to}[${i}]                 
#         ...            copado__userStory_reason__c=${So_that}[${i}]        
#         ...            copado__Technical_Specifications__c=${Technical_Specifications}[${i}] 
#         Append To List          ${ids}                      ${response}
#     END

#     FOR                 ${id}      IN       @{ids}
#         Delete Record   copado__User_Story__c      ${id}
#     END