*** Settings ***
Resource                 ../resources/common.robot
Suite Setup              Setup Browser
Suite Teardown           End suite
Library                  pendulum   #https://pendulum.eustace.io/docs/



*** Test Cases ***
Create Lead on Copado Website with Data from Excel
    [Documentation]   Cross-application end-to-end test
    [Tags]            Data Driven
    GoTo              https://www.copado.com
    ClickText         TALK TO SALES       # XPath of button> /html/body/div[2]/div/header/div[1]/div[2]/nav/ul/li[5]
    TypeText          First Name*         ${first_name}
    TypeText          Last Name*          ${last_name}
    TypeText          Business Email*     ${email}
    TypeText          Phone*              ${phone}
    TypeText          Company*            ${company}
    TypeText          Job Title*          ${title}
    DropDown          Country             ${country}

Verify Lead created in SFDC from Copado Website
    Home
    LaunchApp         Sales
    ClickText         Leads
    ClickText         New
    UseModal          On

    Picklist          Salutation          ${salutation}
    TypeText          First Name          ${first_name}
    TypeText          Last Name           ${last_name}
    TypeText          Phone               ${phone}
    TypeText          Company             ${company}
    TypeText          Title               ${title}
    TypeText          Email               ${email}
    TypeText          Website             ${website}
    ClickText         Cancel


Date Time examples
    [Documentation]    'Library  DateTime' must be imported in Settings section to use any DateTime keywords
    #Capture today's date in format of 01/01/2000
    ${date}    Get Current Date           result_format=%m/%d/%Y %HH:%MM
    ${plus1hour}    Add Time To Date      ${date}          1 hour      date_format=%m/%d/%Y %HH:%MM   result_format=%m/%d/%Y %HH:%MM


    #Capture today's date in format of 1/1/2000 by including a minus symbol before "m" and "d" in result_format parameter
    ${date_without_zeros}    Get Current Date           result_format=%-m/%-d/%Y

    #Convert today's date to format of Jan 01,2000 by using %b in result_format parameter
    ${date_month_name}    Convert Date   ${date}  date_format=%m/%d/%Y   result_format=%b %d, %Y

    #Add 45 days to today's date
    ${plus45_date}    Add Time To Date      ${date}          45 days       date_format=%m/%d/%Y     result_format=%m/%d/%Y
    
    #Subtract 45 days from today's date
    ${plus45_date}    Subtract Time From Date      ${date}          45 days       date_format=%m/%d/%Y     result_format=%m/%d/%Y


    Get Date and Change Times                      2 hour

    ${dateUTC}     Get Current Date        UTC   result_format=%m/%d/%Y %HH:%MM


    ${date}    Get Current Date           result_format=%m/%d/%Y %HH:%MM
    ${plus1hour}    Add Time To Date      ${date}          1 hour      date_format=%m/%d/%Y %HH:%MM   result_format=%m/%d/%Y %HH:%MM


    #Examples using pendulum lib
    ${now}           pendulum.now
    ${torontoDate}   Evaluate     $now.in_timezone("America/Toronto")
    ${formatDate}    Evaluate     $now.format('dddd DD MMMM YYYY')
    ${formatDate2}   Evaluate     $now.format('MM/DD/YYYY')
    ${year}          Evaluate     $now.year
    ${month}         Evaluate     $now.month 
    ${day}           Evaluate     $now.day 
    ${hour}          Evaluate     $now.hour 
    ${minute}        Evaluate     $now.minute 
    ${second}        Evaluate     $now.second
    ${convertDate}  Convert Date  ${torontoDate}  date_format=%m/%d/%Y   result_format=%-m/%-d/%Y
    

Loop If Condition Not Met
    GoTo    https://copado.com
    FOR     ${i}    IN RANGE    3
            ${var}=      Run Keyword And Return Status    VerifyNoText        Products   timeout=2
            IF           ${var}                        BREAK
            RefreshPage
    END
    Should Not Be True         ${var}

Loop Testing
    [Documentation]    'Library  Collections' should be imported in Settings section when working with lists and dictionaries of data
    GoTo                        https://qentinelqi.github.io/shop/
    @{animals}                  Create List                 Sacha the Deer              Bumble the Elephant         Gerald the Giraffe
    FOR                         ${item}                     IN                          @{animals}
        ClickText               ${item}
        VerifyText              Slim Fit, 5oz 100% Cotton T-Shirt.
        ClickText               Add to cart
        VerifyText              Shipping and taxes will be calculated at checkout.
        ClickText               Products
        VerifyText              Find your spirit animal
    END


Loop Over a List with Nested If Statement
    [Documentation]    'Library  Collections' should be imported in Settings section when working with lists and dictionaries of data
    @{users}                    Create List                 Guest                       Sales                       Admin
    FOR                         ${user}                     IN                          @{users}
        Log                     This is a success message.
        IF                      '${user}' == 'Admin'
            Log                 The current user is an Admin
        ELSE IF                 '${user}' == 'Guest'
            Log                 The current user is an Guest
        ELSE
            Log                 The current user is someone else
        END
    END


Mathematical Expressions
    [Documentation]    'Library  String' must be imported in Settings section to use FormatString keyword
    ${discount_percentage}=     Set Variable                .2
    ${list_price}=              Set Variable                100000
    ${total_cost}=              Set Variable                5000
    ${currency}=                Set Variable                USD

        #Calculate Net Price at 20% discount of List Price
    ${net_price}=               Evaluate                    int(${list_price}-(${list_price}*${discount_percentage}))
    Should Be Equal As Integers                             ${net_price}                80000

        #Convert 80000 to USD 80,000
    ${net_price_formatted}=     Format String               {:,}                        ${net_price}
    Should Be Equal             ${currency} ${net_price_formatted}                      USD 80,000


Fake Data Generator 
    [Documentation]    'Library  FakerLibrary'  must be imported in Settings section to use any FakerLibrary keywords
    ${address} =       Address
    ${country} =       Country
    ${email} =         Email
    ${first_name} =    First Name
    ${last_name} =     Last Name
    ${phone_number} =  Phone Number
    Log               ${address} ${country} ${email} ${first_name} ${last_name} ${phone_number}   


Table Interaction
    Home 
    ClickText   Leads
    UseTable    Name  
    ${rows}=    GetTableRow    //last
    
    ${names}=      Create List
    ${companies}=  Create List  
    ${phones}=     Create List
    FOR  ${i}  IN RANGE  2  ${rows}+1
        ${name}     GetCellText  r${i}/c?Name    tag=a
        ${company}  GetCellText  r${i}/c?Company   
        ${phone}    GetCellText  r${i}/c?Phone
        Append to List   ${names}       ${name}
        Append To List   ${companies}   ${company}
        Append To List   ${phones}      ${phone}
    END

    Log To Console      ${names}
    Log to console      ${companies}
    Log to console      ${phones}






# Unzip File  #Import OperatingSystem lib
#     ExpectFileDownload
#     ClickText               Download Related Files
#     ${zip_file}             VerifyFileDownload   

#     IF    "${EXECDIR}" == "/home/executor/execution"    # normal test run environment
#         ${downloads_folder}=    Set Variable    /home/executor/Downloads
#     ELSE    # Live Testing environment
#         ${downloads_folder}=    Set Variable    /home/services/Downloads
#     END
 
#     Run    unzip ${zip_file} -d ${downloads_folder}
  
#      #Get file name from download folder
#     @{downloads}=               List Files In Directory    ${downloads_folder}
#     ${unzipped_file}=           Get From List              ${downloads}             0
#     Log                         Unzipped File Name: ${unzipped_file}


# Lightning Web Component Test
#     GoTo          https://slockard-dev-ed.lightning.force.com/lightning/r/copado__ExtensionConfiguration__c/a0f7Q000000gShGQAU/view
#     VerifyText    Extension Configuration Status
#     VerifyText    Active                        anchor=2

# File Interaction
#     Home
#     LaunchApp    Sales
#     ClickText    Opportunities 
#     ClickText    Robotic Testing
#     ScrollTo     Upload Files    visibility=false 
#     UploadFile   Upload Files    ../files/new_accounts.xlsx
#     VerifyText                   1 of 1 file uploaded
#     ClickText    Done
#     ClickText    Notes & Attachments    partial_match=true

#     UseTable     Title
#     ClickCell    r1c5
#     ClickText    Delete
#     ClickText    Delete                 anchor=Cancel



# Table Validations
#     [Documentation]    'Library  QForce' must be imported in Settings section to use LaunchApp keyword
#     Home
#     LaunchApp          Sales
#     ClickText          Accounts

#     UseTable           Account Name
#     VerifyTable        r?Robots, Inc./c?Phone    18001234567
#     ClickCell          r1c6
#     ${account_phone}=  GetCellText              r?Robots, Inc./c?Phone