*** Settings ***
Library                   String
Library                   RequestsLibrary
Library                   Collections


*** Variables ***    
${api_crt}                https://api.robotic.copado.com/  
&{ext_api_headers}        Content-Type=application/json    X-AUTHORIZATION=${pat}


*** Keywords ***

GetUserData
    [Documentation]       Get user information from CRT API
    ${session}=           Create Session        crt  ${api_crt}     debug=3  verify=true
    ${resp}=              Get On Session
    ...                   crt
    ...                   /new/ui/user/me
    ...                   headers=&{ext_api_headers}  timeout=10
    Log                   ${resp.status_code}
    Log                   ${resp.json()}
    [Return]              ${resp.json()}