*** Settings ***
Resource                  ../resources/common.robot
Suite Setup               Setup Browser
Suite Teardown            End suite


*** Test Cases ***
ServiceCloud Example
    Home
    LaunchApp             Service
    ClickText             Cases                       partial_match=False
    ClickText             New                         partial_match=False
    UseModal              On
    TypeText              Search Contacts...          Tina
    ClickText             Tina Smith
    TypeText              Account Name                Robotic Testing
    ClickText             Robotic Testing             anchor=2
    PickList              Status                      New
    PickList              Case Origin                 Email
    PickList              Priority                    Medium
    TypeText              Subject                     Bug Found
    TypeText              Description                 Something broken
    ClickText             Save                        partial_match=False
    VerifyText            Subject: Bug Found
    VerifyText            Priority: Medium
    VerifyText            Status: New
    ${case_number}        GetText                     Case Number:           from_end=8
    Set Suite Variable    ${case_number}


ExperienceCloud Example
    Home
    LaunchApp             Community
    ClickText             Accounts
    ClickText             New
    UseModal              On
    TypeText              Phone                       4045551234
    TypeText              *Account Name               I Love Copado
    PickList              *Account Currency           USD - U.S. Dollar
    TypeText              Website                     https://copado.com
    PickList              Type                        Customer - Direct
    PickList              Industry                    Technology
    ClickCheckbox         Combine Asset Quantities    on
    ClickText             Save                        partial_match=False
    UseModal              Off
    ClickText             Close
    ClickText             Details
    VerifyText            4045551234
    VerifyText            I Love Copado
    VerifyText            https://copado.com
    VerifyText            USD - U.S. Dollar
    ClickText             Related
    ClickText             New                         anchor=Contracts(0)
    UseModal              On
    TypeText              Contract Term (months)*     12
    PickList              Owner Expiration Notice     30 Days
    PickList              Contract Currency           USD - U.S. Dollar
    ClickText             Save                        partial_match=False
    UseModal              Off
    ClickText             (1)


Delete Case
    ClickText             Cases
    VerifyText            ${case_number}
    ClickText             ${case_number}
    ClickText             Delete
    UseModal              On
    ClickText             Delete
    UseModal              Off
    LogScreenshot