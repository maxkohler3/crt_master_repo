*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite
Library                       String


*** Test Cases ***
    Home
    ${string}=    Set Variable    lake ocean river mountain sky
    
    @{split}=     Split String    ${string}

    ${third}=          Get From List             ${split}    3 

    FOR           ${x}            IN RANGE       0  5
        Log to console       ${split}[${x}]
    END


    FOR           ${x}            IN             ${split}
        Log to console       ${x}[0]
        Log to console       ${x}[1]
        Log to console       ${x}[2]
        Log to console       ${x}[3]
        Log to console       ${x}[4]
    END

    ${third}=          Get From List             ${split}    3  







# *** Settings ***
# Resource                      ../resources/common.robot
# Suite Setup                   Setup Browser
# Suite Teardown                End suite
# # Library                       ../libraries/custom_library.py
# Library        Collections

# *** Variables *** 
# @{first_name}=    Xarl    Monty    Magnolia
# @{last_name}=    Chin    Maguire    Blossom
# @{gender}=    Female    Male     Female
# @{ethnicity}=    American Indian or Alaska Native    Asian    American Indian or Alaska Native
# @{role}=    Observer    Alleged Maltreator    Alleged Victim
# @{dob}=    01/02/1978    03/05/1981    10/15/2006

# &{persons}=

# *** Test Cases ***


# Scratchwork Test 
#     ${date}=     Get Current Date    result_format=%m/%d/%Y
#     ${20yo_date}=  Subtract Time From Date    ${date}          7300 days     date_format=%m/%d/%Y    result_format=%m/%d/%Y
#     ${50yo_date}=  Subtract Time From Date    ${date}          18263 days     date_format=%m/%d/%Y    result_format=%m/%d/%Y
    

#     FOR                   ${person}          IN         @{first_name}   

#         Log to console                 ${first_name}
#         Log to console                 ${last_name}
#         Log to console                 ${gender}                  
#         Log to console                 ${ethnicity}
#         Log to console                 ${role} 
#         Log to console                 ${dob}
        
#     END

    
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
#     Log to console                        This step worked

