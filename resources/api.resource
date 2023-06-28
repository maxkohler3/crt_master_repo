*** Settings ***
Library                   String
Library                   RequestsLibrary
Library                   Collections


*** Variables ***    
${api_crt}                https://platform.robotic.copado.com/  
&{ext_api_headers}        Content-Type=application/json    X-AUTHORIZATION=${pat}


*** Keywords ***

Authenticate Salesforce API
    Authenticate    ${client_id}   ${client_secret}   ${username}    ${password}

GetUserData
    [Documentation]       Get user information from CRT API
    ${session}=           Create Session        crt  ${api_crt}     debug=3  verify=true
    ${resp}=              Get On Session
    ...                   crt
    ...                   /users/me
    ...                   headers=&{ext_api_headers}  timeout=10
    Log                   ${resp.status_code}
    Log                   ${resp.json()}
    [Return]              ${resp.json()}


Quick Get Request Test
    ${response}=    GET  https://www.google.com

Quick Get Request With Parameters Test
    ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200

Quick Get A JSON Body Test
    ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
    Should Be Equal As Strings    1  ${response.json()}[id]

Get Request Test                                                                                       
    Create Session    google  http://www.google.com                                                    
                                                                                                       
    ${resp_google}=   GET On Session  google  /  expected_status=200                                   
    ${resp_json}=     GET On Session  jsonplaceholder  /posts/1                                        
                                                                                                       
    Should Be Equal As Strings          ${resp_google.reason}  OK                                      
    Dictionary Should Contain Value     ${resp_json.json()}  sunt aut facere repellat provident occaecati excepturi optio reprehenderit        
                                                                                                       
Post Request Test                                                                                      
    &{data}=    Create dictionary  title=Robotframework requests  body=This is a test!  userId=1       
    ${resp}=    POST On Session    jsonplaceholder  /posts  json=${data}  expected_status=anything     
                                                                                                       
    Status Should Be                 201  ${resp} 