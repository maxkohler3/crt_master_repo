*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***





































#LeftMain
    # ${str}    Set Variable    Click to dial disabled (480) 123-1234
    # ${str_strip}              Remove String    ${str}    Click to dial disabled (  )  -  ${SPACE}
    # Should be equal    ${str_strip}        4801231234       













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
    




# *** Test Cases ***
# Axalta Test Script
#     [Tags]    WebApp
#     Open Browser    ${url}    chrome

#     # Select a catalog and verify the label text changes from gray to black
#     Click Text    Catalog
#     Verify Element Text    Catalog    black

#     # Click the label a second time to unselect it
#     Click Text    Catalog
#     Verify Element Text    Catalog    gray

#     # Select a catalog and verify the results list is refreshed
#     Click Text    Catalog
#     Verify Text    Results updated

#     # Select a category and subcategory
#     Click Text    Category
#     Click Text    Subcategory
#     Verify Text    Subcategory selected

#     # Change quantity of an item
#     Type Text    Quantity    1
#     Verify Input Value    Quantity    1

#     # Select a catalog and verify 'Clear all Filters' link is displayed
#     Click Text    Catalog
#     Verify Text    Clear all Filters

#     # Click 'Clear all Filters' and verify all filters are deselected
#     Click Text    Clear all Filters
#     Verify No Text    Catalog selected

#     # Mouseover a row and verify the color changes
#     Hover Element    Row
#     Verify Element Text    Row    light gray

#     # Move mouse away and verify the color changes back to white
#     Hover Element    Header
#     Verify Element Text    Row    white

#     # Change quantity and attempt to leave the page
#     Type Text    Quantity    1
#     Click Text    Leave Page
#     Verify Text    Are you sure you want to leave this page?

#     # Stay on the page
#     Click Text    Stay on this page
#     Verify Text    You are still on this page

#     # Search for 'red' and verify results are filtered
#     Type Text    Search    red
#     Press Key    Search    ENTER
#     Verify Text    Results for 'red'

#     # Add a second search term 'oxide' and verify results are filtered
#     Type Text    Search    oxide
#     Press Key    Search    ENTER
#     Verify Text    Results for 'red oxide'

#     # Select a manufacturer and verify results are filtered
#     Click Text    Manufacturer
#     Click Text    ADT Tools
#     Verify Text    Results for ADT Tools

#     # Scroll to Category, select a category and subcategory, and verify results are filtered
#     Scroll    Category    down
#     Click Text    Category
#     Click Text    Paint
#     Click Text    Activator/Hardener
#     Verify Text    Results for Paint - Activator/Hardener

#     # Verify 'No results were found for that search.' appears for a search with no results
#     Type Text    Search    No results
#     Press Key    Search    ENTER
#     Verify Text    No results were found for that search.

#     Close Browser