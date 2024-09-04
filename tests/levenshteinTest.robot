*** Settings ***
Resource    ../resources/common.robot
Library           ../resources/levenshtein.py
# Library           ../resources/levenshtein_bridge.py
# Library                     ../libraries/date.py

Suite Setup            OpenBrowser  about:blank  chrome
Suite Teardown         CloseAllBrowsers

*** Test Cases ***
Calculate Levenshtein Distance Between Two Strings
    ${distance}=    Get Levenshtein Distance    Srijan  Vishisth
    
    
    Log             The Levenshtein distance is ${distance}

TC01
    Get Levenshtein Distance                       Example1   Example2
    ${levi_result}=    Get Levenshtein Distance    Srijan  Vishisth
    Log                ${levi_result}


Days of Month Examples
    ${current_date}=          Get Current Date    exclude_millis=true    result_format=%m/%d/%Y
    ${first_day_of_month}=    Nth Day of Month    ${current_date}     nth_day=1    date_format=%m/%d/%Y  result_format=%-m/%-d/%Y 

    ${invoice_start_date}=    Nth Day of Month    ${current_date}     nth_day=1                 date_format=%m/%d/%Y  result_format=%-m/%-d/%Y
    ${start_date}=            Nth Day of Month    ${current_date}     nth_day=1    months=-1    date_format=%m/%d/%Y  result_format=%-m/%-d/%Y
    ${end_date}=              Nth Day of Month    ${current_date}     nth_day=-1   months=23    date_format=%m/%d/%Y  result_format=%-m/%-d/%Y
    ${last_invoice_date}=     Nth Day of Month    ${current_date}     nth_day=-1   months=-1    date_format=%m/%d/%Y  result_format=%-m/%-d/%Y

