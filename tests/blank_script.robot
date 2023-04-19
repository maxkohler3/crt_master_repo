*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***

Excel Handling
    [Documentation]     Read product names from excel sheet and verify that those can be found from a webshop page
    [Tags]              excel    products    verify
    Home
    LaunchApp    Sales
    ClickText    Opportunities 
    ClickUntil   Activity      Robotic Testing
    ClickUntil   Title         Notes & Attachments
    
    UseTable     Title
    ClickCell    r1c5
    ExpectFileDownload
    ClickText               Download
    VerifyFileDownload
	 
    ${document}=        Open Excel Document    /home/executor/Downloads/new_accounts.xlsx  doc_id=doc1
    @{account_names}=   Read Excel Column    col_num=1    max_num=3  row_offset=1   sheet_name=Data sheet 1
    @{account_data}=    Read Excel Row       row_num=2    max_num=8   sheet_name=Data sheet 1

    FOR    ${item}    IN    @{account_names}
        Log to console           ${item}
    END














# *** Settings ***
# Resource                      ../resources/common.robot
# Suite Setup                   Setup Browser
# Suite Teardown                End suite
# # Library                       ../libraries/custom_library.py
# Library        Collections

# *** Test Cases ***


# Scratchwork Test 
#     ${date}=     Get Current Date    result_format=%m/%d/%Y
#     ${20yo_date}=  Subtract Time From Date    ${date}          7300 days     date_format=%m/%d/%Y    result_format=%m/%d/%Y
#     ${50yo_date}=  Subtract Time From Date    ${date}          18263 days     date_format=%m/%d/%Y    result_format=%m/%d/%Y
    
