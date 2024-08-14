*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***

TC1 in Suite A 
    Log    1A

TC2 in Suite A 
    Log    2A