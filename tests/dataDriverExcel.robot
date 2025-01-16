*** Settings ***
Resource                        ../resources/common.robot
Library                         DataDriver    file=../data/leads.xlsx    sheet_name=Leads
Library                         ExcelLibrary
Library                         Collections
Suite Setup                     Run Keywords    Setup Browser    Setup Excel
Suite Teardown                  Run Keywords    Close All Browsers    Close All Excel Documents
Test Template                   Create Verify and Delete Lead End to End

*** Variables ***
${EXCEL_FILE}                   ${CURDIR}${/}../data/leads.xlsx
${SHEET_NAME}                   Leads

*** Test Cases ***
Create Lead using Excel data    ${LastName}    ${Phone}    ${Company}    ${FirstName}    ${Email}    ${Salutation}    ${Title}

*** Keywords ***
Setup Excel
    Open Excel Document    ${EXCEL_FILE}    doc_id=leads
    Set Test Variable    ${CURRENT_ROW}    1

Create Verify and Delete Lead End to End
    [Arguments]    ${LastName}    ${Phone}    ${Company}    ${FirstName}    ${Email}    ${Salutation}    ${Title}
    ${result}=    Create and Delete Lead    ${LastName}    ${Phone}    ${Company}    ${FirstName}    ${Email}    ${Salutation}    ${Title}
    # Optional: Write results back to Excel
    Write To Excel Cell    ${CURRENT_ROW}    8    ${result}    ${SHEET_NAME}
    ${CURRENT_ROW}=    Evaluate    ${CURRENT_ROW} + 1
    Set Test Variable    ${CURRENT_ROW}

Create and Delete Lead
    [Arguments]    ${LastName}    ${Phone}    ${Company}    ${FirstName}    ${Email}    ${Salutation}    ${Title}
    TRY
        Authenticate    ${client_id}    ${client_secret}    ${username}    ${password}
        ${response}=    Create Record    Lead
        ...    LastName=${LastName}
        ...    Phone=${Phone}
        ...    Company=${Company}
        ...    FirstName=${FirstName}
        ...    Email=${Email}
        ...    Salutation=${Salutation}
        ...    Title=${Title}
        Log    Created Lead with ID: ${response}
        Verify Lead    ${response}    ${LastName}    ${Company}
        Delete Record    Lead    ${response}
        Log    Deleted Lead with ID: ${response}
        RETURN    PASS
    EXCEPT    AS    ${error}
        Log    Failed to process lead: ${LastName} - ${error}    WARN
        RETURN    FAIL
    END

Verify Lead
    [Arguments]        ${lead_id}    ${LastName}    ${Company}
    ${lead}=           Get Record    Lead    ${lead_id}
    Should Be Equal    ${lead}[LastName]     LastName}
    Should Be Equal    ${lead}[Company]      ${Company}