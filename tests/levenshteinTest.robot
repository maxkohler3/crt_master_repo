*** Settings ***
Library           ../resources/levenshtein_sample.py

*** Test Cases ***
Calculate Levenshtein Distance Between Two Strings
    ${distance}=    Calculate Levenshtein Distance    Hello    Hallo
    Log             The Levenshtein distance is ${distance}