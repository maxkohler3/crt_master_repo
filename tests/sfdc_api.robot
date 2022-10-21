*** Settings ***
Resource                      ../resources/common.robot
Resource                      ../resources/api.resource  
Suite Setup                   Run Keywords 
...                           Setup Browser  
...                           Authenticate Authenticate Salesforce API
Suite Teardown                End suite


*** Test Cases ***
    
QForce API Examples
    ${contact}=      Create Record  Contact            FirstName=Jane         LastName=Doe
    ${account}=      Create Record  Account            Name=KindCorp
    Delete Record    Contact        ${contact}
    Delete Record    Account        ${account}