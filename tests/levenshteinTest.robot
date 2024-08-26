*** Settings ***
Library           ../resources/levenshtein_sample.py
# Library           ../resources/levenshtein_bridge.py

Suite Setup            OpenBrowser  about:blank  chrome
Suite Teardown         CloseAllBrowsers

*** Test Cases ***
Calculate Levenshtein Distance Between Two Strings
    ${distance}=    Get Levenshtein Distance    Srijan  Vishisth
    
    Log             The Levenshtein distance is ${distance}

# TC01
#     Get Levenshtein Distance                       Example1   Example2
#     ${levi_result}=    Get Levenshtein Distance    Srijan  Vishisth
#     Log                ${levi_result}