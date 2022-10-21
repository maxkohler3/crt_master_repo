*** Settings ***
Resource                      ../resources/common.robot
Resource                      ../resources/api.resource  
Suite Setup                   Run Keywords 
...                           Setup Browser  
# ...                           Authenticate   
Suite Teardown                End suite


*** Test Cases ***
    
QForce API Examples
    Authenticate
    CreateRecord
