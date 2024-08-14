*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***

TC1 in Suite B 
    Log    1B

TC2 in Suite B 
    Log    2B