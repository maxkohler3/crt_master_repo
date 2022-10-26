*** Settings ***
Resource                      ../resources/common.robot
Library                       QVision
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Create CPQ Quote
    [Documentation]             Create quote against existing opportunity
    Home
    LaunchApp                   Salesforce CPQ
    ClickText                   Opportunities
    ClickText                   Robotic Testing             delay=2
    VerifyStage                 Qualification
    ClickText                   Create Quote

    UseModal
    VerifyText                  Create Quote
    ${date}=                    Get Current Date            result_format=%-d/%-m/%Y
    TypeText                    Quote Start Date            ${date}
    TypeText                    Contract Length (months)    12
    ClickText                   Next
    UseModal                    Off

Edit CPQ Quote
    ${quoteID}=                 GetText               Q-
    ClickText                   ${quoteID}
    ClickText                   Show more actions
    ClickText                   Edit Lines
    Sleep                       10
    SetConfig                   ShadowDOM             True

    ${startDate}=               GetInputValue         Start Date
    Should Be Equal             ${startDate}          ${date}

    ${subTerm}=                 GetInputValue         Subscription Term
    Should Be Equal             ${subTerm}            12
    LogScreenshot

    ClickText                   Add Products          anchor=Add Group
    VerifyText                  Guided Selling
    DropDown                    Cloud platform or individual product?    Cloud Platform
    ClickText                   Suggest
    ClickCheckbox               BigQuery              On
    ClickText                   Save                  anchor=Cancel
    
    ClickItem                   Reconfigure Line
    ClickText                   Cancel

    UseFrame                    //iframe
    VerifyTableCell             Net Unit Price   1    120.000,00 USD
    ClickText                   Save                  anchor=Cancel
    Sleep                       20

Preview & Validate PDF Document
    ClickText                   Show more actions
    ClickText                   Preview Document
    ClickText                   Preview                     anchor=Cancel               delay=10
    QVision.VerifyText          Quotation                   timeout=60
    VerifyRow                   Net 30                      row_text=TEST ROBOT
    VerifyRow                   slockard@copado.com         row_text=TEST ROBOT
    VerifyRow                   USD 120,000.00              row_text=TOTAL
    LogScreenshot

Submit and Approve Opportunity 
    ClickText                   Opportunities
    ClickText                   Robotic Testing             delay=2
    ClickText                   ${quoteID}
    ClickText                   Show more actions
    ClickText                   Submit for Approval
    VerifyField                 Approval Status             Approved

Delete Test Data
    [tags]                      Test data
    SetConfig                   ShadowDOM                   False
    Home
    LaunchApp                   Salesforce CPQ
    ClickText                   Quotes
    VerifyText                  ${quoteID}                  delay=3
    ClickText                   ${quoteID}
    ClickText                   Delete                      Clone
    ClickText                   Delete                      Cancel

    LaunchApp                   Sales
    ClickText                   Accounts

    Set Suite Variable          ${data}                     Salesforce
    RunBlock                    NoData                      timeout=180s                exp_handler=DeleteAccounts
    Set Suite Variable          ${data}                     Copado
    RunBlock                    NoData                      timeout=180s                exp_handler=DeleteAccounts

    ClickText                   Opportunities
    VerifyNoText                Robotic Testing
    VerifyNoText                Martha Vineyard

    ClickText                   Leads
    VerifyText                  Change Owner
    Set Suite Variable          ${data}                     Martha Vineyard
    RunBlock                    NoData                      timeout=180s                exp_handler=DeleteLeads
