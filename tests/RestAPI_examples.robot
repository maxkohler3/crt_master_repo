*** Settings ***
Resource                      ../resources/common.robot
Resource                      ../resources/api.resource  
Suite Setup                   Run Keywords 
...                           Setup Browser  
...                           Authenticate Salesforce API
Suite Teardown                End suite


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

# General RestAPI examples below...

Get Request on Google
    ${response}=    GET  https://www.google.com

Get Request with Parameters
    ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200

Get REquest with Response Verification
    ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
    Should Be Equal As Strings    1  ${response.json()}[id]

Get Request with JSON Body                                                                                       
    Create Session    google  http://www.google.com                                                    
                                                                                                       
    ${resp_google}=   GET On Session  google  /  expected_status=200                                   
    ${resp_json}=     GET On Session  jsonplaceholder  /posts/1                                        
                                                                                                       
    Should Be Equal As Strings          ${resp_google.reason}  OK                                      
    Dictionary Should Contain Value     ${resp_json.json()}  sunt aut facere repellat provident occaecati excepturi optio reprehenderit        
                                                                                                       
Post Request with JSON Body                                                                                      
    &{data}=    Create dictionary  title=Robotframework requests  body=This is a test!  userId=1       
    ${resp}=    POST On Session    jsonplaceholder  /posts  json=${data}  expected_status=anything     
                                                                                                       
    Status Should Be                 201  ${resp}    
