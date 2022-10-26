# *** Settings ***
# Resource                      ../resources/common.robot
# Suite Setup                   Setup Browser
# Suite Teardown                End suite


# *** Test Cases ***

# Create CPQ Quote
#     [Documentation]             Create quote against existing opportunity
#     [Tags]                      Lead                        Regression
#     Appstate                    Home
#     LaunchApp                   Salesforce CPQ
#     ClickText                   Opportunities
#     ClickText                   Robotic Testing             delay=2
#     VerifyText                  Mark Stage as Complete
#     VerifyStage                 Qualification
#     ClickText                   Details
#     VerifyField                 Opportunity Name            Robotic Testing
#     ClickText                   Create Quote

#     UseModal
#     VerifyText                  Create Quote
#     ${date}                     Get Current Date            result_format=%-m/%-d/%Y
#     Set Suite Variable          ${date}
#     TypeText                    Quote Start Date            ${date}
#     TypeText                    Contract Length (months)    12
#     ClickText                   Next
#     UseModal                    Off

# Edit CPQ Quote
#     ${quoteID}                  GetText                     Q-
#     Set Suite Variable          ${quoteID}
#     ClickText                   ${quoteID}
#     VerifyField                 Quote Number                ${quoteID}
#     ClickText                   Edit                        anchor=Delete
#     UseModal
#     VerifyText                  Edit ${quoteID}
#     PickList                    Approval Status             Pending
#     TypeText                    Notes                       Must Win Deal!
#     ClickText                   Save                        partial_match=false
#     Sleep                       3

#     VerifyField                 Primary Contact             Martha Vineyard             partial_match=true
#     VerifyField                 Approval Status             Pending
#     LogScreenshot

# Edit Lines in CPQ Quote
#     ClickText                   Quotes
#     ClickUntil                  Details                     ${quoteID}                  delay=2
#     ClickText                   Show more actions
#     ClickText                   Edit Lines
#     Sleep                       10

#     Log                         Entering the ShadowDOM, duh duh duh
#     SetConfig                   ShadowDOM                   True

#     ${startDate}                GetInputValue               Start Date
#     Set Suite Variable          ${startDate}
#     Should Be Equal             ${startDate}                ${date}

#     ${subTerm}                  GetInputValue               Subscription Term
#     Set Suite Variable          ${subTerm}
#     Should Be Equal             ${subTerm}                  12
#     LogScreenshot

#     ClickText                   Add Products                anchor=Add Group
#     VerifyText                  Guided Selling
#     QVision.ClickText           Cloud platform or individual product?                   below=2
#     QVision.ClickText           Cloud Platform              anchor=Cloud Product
#     ClickText                   Suggest
#     ClickCheckbox               BigQuery                    On
#     ClickText                   Save                        anchor=Cancel

#     ClickText                   Calculate                   delay=3
#     ClickText                   Quick Save
#     VerifyRow                   USD 120,000.00              row_text=Google Cloud
#     ClickText                   Save                        anchor=Cancel
#     LogScreenshot
#     Sleep                       30

#     VerifyField                 List Amount                 USD 120,000.00              partial_match=true
#     VerifyField                 Price Book                  Google Cloud Platform       partial_match=true

# Preview & Validate PDF Document
#     ClickText                   Show more actions
#     ClickText                   Preview Document
#     ClickText                   Preview                     anchor=Cancel               delay=10
#     QVision.VerifyText          Quotation                   timeout=60
#     VerifyRow                   Net 30                      row_text=TEST ROBOT
#     VerifyRow                   slockard@copado.com         row_text=TEST ROBOT
#     VerifyRow                   USD 120,000.00              row_text=TOTAL
#     LogScreenshot

# Submit and Approve Opportunity 
#     ClickText                   Opportunities
#     ClickText                   Robotic Testing             delay=2
#     ClickText                   ${quoteID}
#     ClickText                   Show more actions
#     ClickText                   Submit for Approval
#     VerifyField                 Approval Status             Approved

# Delete Test Data
#     [tags]                      Test data
#     SetConfig                   ShadowDOM                   False
#     Home
#     LaunchApp                   Salesforce CPQ
#     ClickText                   Quotes
#     VerifyText                  ${quoteID}                  delay=3
#     ClickText                   ${quoteID}
#     ClickText                   Delete                      Clone
#     ClickText                   Delete                      Cancel

#     LaunchApp                   Sales
#     ClickText                   Accounts

#     Set Suite Variable          ${data}                     Salesforce
#     RunBlock                    NoData                      timeout=180s                exp_handler=DeleteAccounts
#     Set Suite Variable          ${data}                     Copado
#     RunBlock                    NoData                      timeout=180s                exp_handler=DeleteAccounts

#     ClickText                   Opportunities
#     VerifyNoText                Robotic Testing
#     VerifyNoText                Martha Vineyard

#     ClickText                   Leads
#     VerifyText                  Change Owner
#     Set Suite Variable          ${data}                     Martha Vineyard
#     RunBlock                    NoData                      timeout=180s                exp_handler=DeleteLeads
