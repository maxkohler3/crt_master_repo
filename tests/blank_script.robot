*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Test Case 1
    Home
    # slow down
    # Cleanup steps
     # Close Tabs 
    # iFrames
     # While loop > checkbox keyword w/table
    # presskey vs hotkey vs \n
    # Create records / Loop + APIs / exclude_millis concatenate
    # Live test single step + headless
    ClickText    New    tag=button 
    TypeText    Search Contacts    tag=input
    GetFieldValue   Owner   tag=a 

    UseTable        Record
    ${var}          VerifyCheckboxValue    r?accountName/c?checkboxColumnOne   on 








































    # Launchapp    Salesforce Chatter
    # Execute JavaScript    document.body.style.zoom = "120%"
    # ClickIcon    refresh.png    tolerance=.8
    # Execute JavaScript    document.body.style.zoom = "100%"


# Email
#     GoTo         https://mail.tm
#     ${temp_em}   GetText    //*[@title\="Your temporary Email address, click to copy to clipboard!"]
#     Log To Console          ${temp_em}
#     GoTo                    https://copado.com
#     ClickText    Talk to Sales   
#     TypeText                Business Email    ${temp_em}

   

# LoginAs Example
#     [Documentation]             Example how to impersonate another user. Note: Admin rights needed
#     ...                         for the user who tries to impersonate another user
#     Home
#     LoginAs                     Evan Bartlik
#     VerifyText                  Evan Bartlik
#     ClickText                   Log out as Evan Bartlik


    # ${url}=           GetUrl
    # ${record_id}=     Evaluate    $url.split("/")[6]


# ${text}=         IsText     Show Actions 
#     WHILE            ${text} == True 
#         ClickText    Show Actions                delay=2
#         ClickText    Delete     delay=2
#         ClickText    Delete     anchor=Cancel    delay=2
#         ${text}=     IsText     Show Actions
#     END



# Get Links List
#     [Documentation]      Test getting links from a page
#     GoTo                 https://test.salesforce.com/
#     Sleep                2
    # ${links}=            Get Links
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


# Validate Table Cell 
#     ${opp_name}=                Set Variable       Robotic Testing
#     ${opp_name_visible}=        IsText                    ${opp_name}

#     IF                         ${opp_name_visible}
#         UseTable               Opportunity Name     #target a table using unique text
#         VerifyTable            r?${opp_name}/c?Stage      Qualification 
#     END  

# Click Next Page in Table 
#     ClickText    Next Page



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


# Upload file 
#     Home
#     ClickText    Accounts
#     ClickText    KindCorp
#     ScrollTo     Upload Files
#     UploadFile    Upload Files    ../files/dummy.png   anchor=2
#     VerifyText    1 of 1 file uploaded
#     ClickText     Done
#     ClickText    Image file
#     ClickText    Show More    partial_match=False
#     ClickText    Delete    
#     UseModal    On
#     ClickText    Delete
#     UseModal    Off


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


    # GoTo    https://docs.google.com/spreadsheets/d/1pXRsCuik6Dz-epcWmevFzJgFgMLS00QYBdaiAkSyJDw/edit?usp=sharing
    # QVision.ClickCell     Account ABC   Record ID    # Account ABC targets row text ; Record ID targets the column header
    # WriteText             218570825760876543134\n    # replace the strong of numbers with the  ${record_id} ; '\n' hits the enter key
    # ClickText             File
    # ExpectFileDownload
    # ClickText             Download
    # ClickText             Microsoft Excel (.xlsx)
    # VerifyFileDownload

    # Home
    # ClickText    Accounts
    # ClickText    Account 123 
    # UploadFile    Upload Files    /home/services/Downloads/CRT Demo Sheet.xlsx   anchor=2

    # this path works in live testing
    # /home/services/Downloads/CRT Demo Sheet.xlsx
    
    #  this path works in headless execution 
    #  /home/executor/Downloads/CRT Demo Sheet.xlsx




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
    




