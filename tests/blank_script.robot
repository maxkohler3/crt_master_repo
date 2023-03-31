*** Settings ***
Library    QWeb
Library    DataDriver    reader_class=TestDataApi    name=acis_intake.csv

Suite Setup       Open Browser        about:blank     Chrome
Suite Teardown    Close All Browsers
Test Template     Example Test

*** Test Case ***
Example Test with ${first_name}

*** Keywords ***
Data Template Test
    [Arguments]    ${first_name}    ${last_name}    ${gender}    ${ethnicity}    ${dob}    ${role}

    FOR                   ${item}          IN         @{first_name}   

        Log                 ${first_name}
        Log                 ${last_name}
        Log                 ${gender}                  
        Log                 ${ethnicity}
        
    END











# *** Settings ***
# Resource                      ../resources/common.robot
# Suite Setup                   Setup Browser
# Suite Teardown                End suite
# Library                       ../libraries/custom_library.py


*** Test Cases ***

# Test Sample
#     Home
#     LaunchApp    Sales 
#     ClickText    Opportunities

#     RunBlock     Validate Table Cell        exp_handler=Click Next Page in Table   
#     #create custom keyword for exception handler if additional action is needed
    
#     # GetText | GetInputValue | GetCellText are 3 commonly used keywords to capture data from the UI
#     ${data_from_ui}=           GetText                    Robotic
#     Should Be Equal            ${data_from_ui}            Robotic Testing 

#     ${next_button}=           IsText                      Next    anchor=Cancel
#     IF                          ${next_button}
#         ClickText               Next
#     END                                                         

#     Run Keyword And Continue On Failure               ClickText    asdfkgjh     
#     Log                        This step worked
