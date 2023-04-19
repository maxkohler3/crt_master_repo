*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***

Verify Products
    [Documentation]     Read product names from excel sheet and verify that those can be found from a webshop page
    [Tags]              excel    products    verify
    Home
    LaunchApp    Sales
    ClickText    Opportunities 
    ClickText    Robotic Testing
    ClickText    Notes & Attachments
    
    UseTable     Title
    ClickCell    r1c5
    ExpectFileDownload
    ClickText               Download
    VerifyFileDownload

    ${document}=        Open Excel Document    ../home/services/Downloads    new_accounts.xlsx





    GoTo                ${webshop}
    VerifyText          Find your spirit animal

    # Open existing workbook
    ${document}=        Open Excel Document    ${excel_worksheet}    products

    # Start reading values from the second row, max number needs to be provided with offset
    ${product_names}=   Read Excel Column    col_num=1    max_num=6    row_offset=1    sheet_name=Fur

    # Check that we can find all the products from the web page
    FOR    ${item}    IN    @{product_names}
        VerifyText           ${item}
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
    
