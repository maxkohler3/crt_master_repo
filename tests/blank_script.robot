*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***


*** Settings ***
Resource                  ../resources/common.robot
Library                   QVision
Suite Setup               Setup Browser
Suite Teardown            End suite


*** Test Cases ***
Create CPQ Quote  
    Home 
    LaunchApp             Salesforce CPQ
    ClickText             Opportunities
    ClickText             Robotic Testing             delay=2
    ClickText             Create Quote

    UseModal
    VerifyText            Create Quote
    ${date}=              Get Current Date            result_format=%-d/%-m/%Y
    Set Suite Variable    ${date}
    TypeText              Quote Start Date            ${date}
    TypeText              Contract Length (months)    12
    ClickText             Next
    UseModal              Off

Edit CPQ Quote
    ${quoteID}=           GetText                     Q-
    Set Suite Variable    ${quoteID}
    ClickText             ${quoteID}
    ClickText             Show more actions
    ClickText             Edit Lines
    Sleep                 5
    SetConfig             ShadowDOM                   True

    ${startDate}=         GetInputValue               Start Date
    Should Be Equal       ${startDate}                ${date}

    ${subTerm}=           GetInputValue               Subscription Term
    Should Be Equal       ${subTerm}                  12

    ClickText             Add Products                anchor=Add Group
    VerifyText            Guided Selling
    DropDown              Cloud platform or individual product?                   Cloud Platform
    ClickText             Suggest
    ClickCheckbox         BigQuery                    On
    ClickText             Save                        anchor=Cancel

    ClickItem             Reconfigure Line            #engage icons with associative text
    ClickText             Cancel

    UseFrame              //iframe                    # some CPQ tables are embedded in iFrames
    VerifyTableCell       Net Unit Price              1                           120.000,00 USD
    ClickText             Save                        anchor=Cancel
    Sleep                 10

Preview & Validate PDF Document
    ClickText             Show more actions           timeout=60
    ClickText             Preview Document
    ClickText             Preview                     anchor=Cancel               delay=10
    Sleep                 30
    VerifyRow             Net 30                      row_text=mkohler@copado.com
    VerifyRow             USD 120,000.00              row_text=TOTAL
    LogScreenshot

Submit and Approve Opportunity 
    ClickText             Opportunities
    ClickText             Robotic Testing             delay=2
    ClickText             ${quoteID}
    ClickText             Show more actions
    ClickText             Submit for Approval
    VerifyField           Approval Status             Approved

Delete CPQ Quote Data
    [tags]                Test data
    SetConfig             ShadowDOM                   False
    Home
    LaunchApp             Salesforce CPQ
    ClickText             Quotes
    VerifyText            ${quoteID}                  delay=3
    ClickText             ${quoteID}
    ClickText             Delete                      Clone
    ClickText             Delete                      Cancel

    ClickText             Opportunities               anchor=Accounts             delay=2
    ClickText             Robotic Testing                                         delay=2
    ClickText             Products                    partial_match=true          anchor=Related    delay=5

    ClickText             Google Cloud Platform       partial_match=false
    ClickText             Delete
    ClickText             Delete                      anchor=Cancel

    ClickText             BigQuery
    ClickText             Delete
    ClickText             Delete                      anchor=Cancel

    ClickText             Opportunities
    ClickText             Robotic Testing
    VerifyNoText          ${quoteID}
    VerifyNoText          Google Cloud Platform
    VerifyNoText          BigQuery


    # Below script shows how to login as a different user to approve a quote, for example

    # LoginAs Example
    #                     [Documentation]             Example how to impersonate another user. Note: Admin rights needed
    #                     ...                         for the user who tries to impersonate another user
    #                     Home
    #                     LoginAs                     Evan Bartlik
    #                     VerifyText                  Evan Bartlik
    #                     ClickText                   Log out as Evan Bartlik






































# Get Links List
#     [Documentation]      Test getting links from a page
#     GoTo                 https://test.salesforce.com/
#     Sleep                2
#     ${links}=            Get Links
#     Log List             ${links}
#     SwitchWindow         NEW

#     FOR                         ${url}        IN           @{links}
#         ClickText               ${url}
#         SwitchWindow            NEW
#         VerifyNoText            404 error    partial_match=true
#         LogScreenshot           fullpage=true
#         CloseOthers
#         GoTo                 https://test.salesforce.com/
#     END             

    #     IF                      ${verification} == True
    #         Log                 The current user is an Admin
    #     ELSE IF                 '${user}' == 'Guest'
    #         Log 
    #     END
    # END

    


# Testing 
#     Home
#     LaunchApp    Service
#     ClickText    Cases
#     UseTable       Subject
#     If             IsText         

#     UseTable    Subject
#     ${row}=     GetTableRow    //last

#     FOR         ${x}      IN RANGE     2  ${row}    
#         ClickCell    r${x}/c8
#         ClickText    Delete     delay=3
#         ClickText    Delete     anchor=Cancel    delay=3
#     END

#     ${text}=         IsText     Show Actions 
#     WHILE            ${text} == True 
#         ClickText    Show Actions                delay=2
#         ClickText    Delete     delay=2
#         ClickText    Delete     anchor=Cancel    delay=2
#         ${text}=         IsText     Show Actions
#     END

#     UseTable                    Case Number
#     ${tabRows}                  GetTableRow          //last
#     FOR                         ${x}                 IN RANGE         1           ${tabRows}
#         ClickCell               r1c8                 timeout=5
#         ClickText               Delete
#         ClickText               Delete               anchor=Cancel
#         VerifyText              was deleted
#         Sleep                   2
#     END

#         @{list}     Create List    
    # WHILE       ${row} != 0 1



    # ${number}=    Set Variable    1000
    # FOR   ${x}    IN RANGE   1  13
    #    ${number_end}=      Evaluate     ${number}*(${x} + 0.02)
    # END 
    # Log to console     ${number_end}


# Upload PDF file 
#     Home
#     ClickText    Accounts
#     ClickText    Account 123 
#     UploadFile    Upload Files    ../files/new_accounts.xlsx   anchor=2

# Download and Validate Excel
#     Home
#     LaunchApp    Sales
#     ClickText    Opportunities 
#     ClickUntil   Activity      Robotic Testing
#     ClickUntil   Title         Notes & Attachments
    
#     UseTable     Title
#     ClickCell    r1c5

#     ExpectFileDownload
#     ClickText               Download
#     VerifyFileDownload

#     #this path works in headless execution 
#     ${document}=        Open Excel Document    /home/executor/Downloads/new_accounts.xlsx  doc_id=doc1
    
#     #this path works in live testing
#     ${document}=        Open Excel Document    /home/services/Downloads/new_accounts.xlsx  doc_id=doc1

#     @{account_names}=   Read Excel Column    col_num=1    max_num=3  row_offset=1   sheet_name=Data sheet 1
#     @{account_data}=    Read Excel Row       row_num=2    max_num=8   sheet_name=Data sheet 1

#     FOR    ${item}    IN    @{account_names}
#         Log to console           ${item}
#     END




# # *** Settings ***
# # Resource                      ../resources/common.robot
# # Suite Setup                   Setup Browser
# # Suite Teardown                End suite
# # # Library                       ../libraries/custom_library.py
# # Library        Collections

# # *** Test Cases ***


# Scratchwork Test 
#     ${date}=     Get Current Date    result_format=%b %d, %Y
#     ${20yo_date}=  Subtract Time From Date    ${date}          7300 days     date_format=%-m/%-d/%Y    result_format=%m/%d/%Y
#     ${50yo_date}=  Subtract Time From Date    ${date}          18263 days     date_format=%m/%d/%Y    result_format=%m/%d/%Y
    
