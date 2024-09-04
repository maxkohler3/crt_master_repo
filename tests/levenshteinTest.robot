*** Settings ***
#Resource               ../resources/common.robot
#Resource               ../resources/locator.robot
Library                ../resources/levenshtein_bridge.py
Library                ../libraries/date.py
Library                QForce
Suite Setup            OpenBrowser  about:blank  chrome
Library                String
Library                DateTime
Suite Teardown         CloseAllBrowsers

 
*** Test Cases ***

TC02  
    [Tags]             TC02                        BEAU_Order_POC
    [Documentation]    BEAU Testing POC

    #logging in to System Admin
    ${levi_result}=    Get Levenshtein Distance    Srijan  Vishisth
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

