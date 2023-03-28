*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite
Library                       ../libraries/custom_library.py


*** Test Cases ***

# Test Sample
#     ${next_button}=           IsText                      Next    anchor=Cancel
#     IF                          ${next_button}
#         ClickText               Next
#     END

#     # VerifyTable                     r?text/c?text          Account 1
#     # VerifyTable                     r2/c4                  Account 2
    
#     # GetText 
#     # GetInputValue

#     # Exception handler to continue testing upon failure
#     Run Keyword And Continue On Failure                    ClickText    asdfkgjh
#     ClickText                        Chatter
