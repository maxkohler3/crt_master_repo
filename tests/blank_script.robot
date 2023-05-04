# *** Settings ***
# Library         QWeb
# Library         QImage
# Suite Setup     OpenBrowser     about:blank     chrome
# Suite Teardown  CloseAllBrowsers

# *** Test Cases ***
# Verify Boat Color
#     GoTo                        https://www.lundboats.com/build/boat-configurator.Z17IXSS.html
#     # capture first boat image
#     ${boat1}=     CaptureIcon                 //img[@alt\="boat-color"] 
    
#     # select another boat color
#     ClickItem     Cobalt Blue / Silver Stone  tag=label
#     Sleep         2  # make sure new boat image is loaded
#     ${boat2}=     CaptureIcon                 //img[@alt\="boat-color"] 

#     CompareImages     ${boat1}       ${boat2}   tolerance=0.99  







# *** Settings ***
# Resource                      ../resources/common.robot
# Suite Setup                   Setup Browser
# Suite Teardown                End suite


# *** Test Cases ***

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


# # Scratchwork Test 
# #     ${date}=     Get Current Date    result_format=%m/%d/%Y
# #     ${20yo_date}=  Subtract Time From Date    ${date}          7300 days     date_format=%m/%d/%Y    result_format=%m/%d/%Y
# #     ${50yo_date}=  Subtract Time From Date    ${date}          18263 days     date_format=%m/%d/%Y    result_format=%m/%d/%Y
    
