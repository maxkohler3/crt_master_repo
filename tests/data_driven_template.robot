*** Settings ***
Resource          ../resources/common.robot
Library           QWeb
Library           DataDriver    reader_class=TestDataApi    name=new_accounts.xlsx
Suite Setup       Open Browser        about:blank     Chrome
Suite Teardown    Close All Browsers
Test Template     Create Account

*** Test Case ***
Test feature with ${account_name}
    [Tags]        data          testgen    nwise=2    numtests=2   


*** Keywords ***
Create Account
    [Arguments]    ${account_name}    ${phone}    ${fax}    ${website}    ${type}    ${industry}    ${employees}    ${annual_revenue}
    Home 
    ClickText    Accounts
    ClickText    New
    UseModal
    TypeText     Account Name   ${account_name}
    TypeText     Phone           ${phone}
    TypeText     Fax             ${fax}
    TypeText     Website         ${website}
    PickList     Industry        ${industry}
    TypeText     Employees       ${employees}
    TypeText     Annual Revenue  ${annual_revenue}
    ClickText    Cancel  