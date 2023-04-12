*** Settings ***
Resource                      ../resources/common.robot
Resource                      ../resources/api.resource  
Suite Setup                   Setup Browser  
Suite Teardown                End suite


*** Test Cases ***
QForce API Examples (Salesforce)
    Authenticate    ${client_id}   ${client_secret}   ${username}    ${password}    
    ${contact}=      Create Record  Contact       FirstName=Jane   LastName=Doe
    ${account}=      Create Record  Account       Name=KindCorp
    
    ${account1}=     Get Record     Account       ${account}

    Update Record    Contact        ${contact}    FirstName=Jamie   Email=jamie.doe@fake.com
    Verify Record    Contact        ${contact}    FirstName=Jamie   LastName=Doe   Email=jamie.doe@fake.com
    
    ${results}=      QueryRecords   SELECT id,name from Contact WHERE name LIKE 'Jane%'

    Delete Record    Contact        ${contact}
    Delete Record    Account        ${account}

    ListObjects
    Revoke



Date Time examples

    ${current_date_us}    Get Current Date           result_format=%m/%d/%Y
    ${plus45_date}        Add Time To Date           ${current_date_us}          45 days            date_format=%m/%d/%Y     result_format=%m/%d/%Y
    Log To Console        ${plus45_date}