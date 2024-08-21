*** Settings ***
Library           ../resources/levenshtein_sample.py

*** Test Cases ***
Calculate Levenshtein Distance Between Two Strings
    ${distance}=    Get Levenshtein Distance    Srijan  Vishisth
    
    Log             The Levenshtein distance is ${distance}