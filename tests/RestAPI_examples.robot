*** Settings ***
Resource                      ../resources/common.robot
Resource                      ../resources/api.resource  
Suite Setup                   Run Keywords 
...                           Setup Browser  
...                           Authenticate Salesforce API
Suite Teardown                End suite
Library                       OperatingSystem


*** Test Cases ***
QForce API Examples (Salesforce)
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

# QForce CPQ API Examples 
#     AddCpqProducts
#     SaveCpqQuote
#     CalculateCpqQuote
#     ReadCpqProduct
#     ReadCpqQuote
#     ValidateCpqQuote
    
    

Standard Rest API examples
    [Documentation]    Reference reusable API blocks from api.resource file
    [Tags]             API   
    Create Session  jsonplaceholder  https://jsonplaceholder.typicode.com 
    Quick Get Request Test
    Quick Get Request With Parameters Test
    Quick Get A JSON Body Test
    Get Request Test
    Post Request Test 

Test                                                                                      
    ${data}=    GetFile  ../files/body.json     
    ${resp}=    POST On Session    jsonplaceholder  /posts  json=${data}  expected_status=anything     
                                                                                                       
    Status Should Be                 201  ${resp}
