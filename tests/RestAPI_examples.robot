*** Settings ***
Resource                      ../resources/common.robot
Resource                      ../resources/api.resource  
Suite Setup                   Setup Browser  
Suite Teardown                End suite
Library                       OperatingSystem


*** Test Cases ***
QForce API Examples (Salesforce)
    Authenticate    ${client_id}   ${client_secret}   ${username}    ${password}
    ${contact}=      Create Record  Contact       FirstName=Jane   LastName=Doe
    ${account}=      Create Record  Account       Name=KindCorp    Type=Prospect    Industry=Consulting
    
    ${account1}=     Get Record     Account       ${account}

    Update Record    Contact        ${contact}    FirstName=Jamie   Email=jamie.doe@fake.com
    Verify Record    Contact        ${contact}    FirstName=Jamie   LastName=Doe   Email=jamie.doe@fake.com
    
    ${results}=      QueryRecords   SELECT id,name from Contact WHERE name LIKE 'Jane%'

    Delete Record    Contact        ${contact}
    Delete Record    Account        ${account}

    # ${json}=      Import Records   Account    ../files/account.json
    # Home
    # ClickText     Accounts

    ListObjects
    Revoke

Create 3 records with random data via API
    FOR     ${I}    IN RANGE                 3
        ${LastName}       Last Name
        ${Phone}          Phone Number
        ${Company}        Company
        ${FirstName}      First Name
        ${compTrunc}      Remove String      ${Company}   ${SPACE}  ,  -  .
        ${Email}          Set Variable       ${FirstName}.${LastName}@${compTrunc}.com
        ${Salutation}     Set Variable       Mr.
        ${Title}          Set Variable        Engineer
        ${oid}=            Create Record    Lead    LastName=${LastName}    Phone=${Phone}    Company=${Company}
        ...                FirstName=${FirstName}    Email=${Email}    Salutation=${Salutation}    Title=${Title}
        Log                Lead record created with ID: ${oid}
        DeleteRecord       Lead                      ${oid}
    END


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

# Test                                            
#     Create Session  jsonplaceholder  https://jsonplaceholder.typicode.com 
                                        
#     ${json}=    GetFile  ../files/body.json   
#     ${json_dict}=    Evaluate      json.loads('''${json}''')         json

#     ${resp}=    POST On Session    jsonplaceholder  /posts  json=${json_dict}  expected_status=anything     
#     Log To Console                 ${resp.text}                                                                                                   
#     Status Should Be                 201  ${resp}

#     # ${CreateSession}=           Create Session              CRT                         https://api.eu-robotic.copado.com/pace
#     # ${headers}=                 Create Dictionary           X-AUTHORIZATION=${x-key}    Content-Type=application/json
#     # ${json}=                    Get File                    ${CURDIR}/../resources/test.json
#     # ${json_dict}=               Evaluate                    json.loads('''${json}''')                               json
#     ${resp}=                    Post On Session             CRT                         /v4/projects/34282/jobs/41932/builds              headers=${headers}    json=${json_dict}
#     Should Be Equal As Strings                              ${resp.status_code}         201
#     Log                         ${resp.text}
#     ${run_info}=                Get Field Value From Json                               ${resp.text}                data
#     Log                         ${run_info}
#     ${runid}=                   Get From Dictionary         ${run_info}                 id
#     ${run_status}=              Get From Dictionary         ${run_info}                 status