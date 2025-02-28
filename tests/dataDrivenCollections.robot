*** Settings ***

Documentation           New test suite
Library                 QWeb
Suite Setup             Open Browser    about:blank    chrome
Suite Teardown          Close All Browsers

*** Test Cases ***
Collections Test
    @{first_name}=        Set Variable                Xarl                        Monty                       Magnolia
    @{last_name}=         Set Variable                Chin                        Maguire                     Blossom
    @{gender}=            Set Variable                Female                      Male                        Female
    @{ethnicity}=         Set Variable                American Indian or Alaska Native                        Asian                       American Indian or Alaska Native
    @{role}=              Set Variable                Observer                    Alleged Maltreator          Alleged Victim
    @{dob}=               Set Variable                01/02/1978                  03/05/1981                  10/15/2006



    UseModal
    FOR                   ${x}                     IN RANGE               0   3
        ClickText         here
        ClickText         Select a Role               anchor=*Role
        ClickText         ${role}[${x}]                anchor=Full Name
        ClickCheckbox     Primary Caregiver           on
        TypeText          *First Name                 ${first_name}[${x}]
        TypeText          *Last Name                  ${last_name}[${x}]
        ClickCheckbox     Address Same as Location of Incident                    on

        TypeText          Date of Birth               ${dob}[${x}]
        ClickText         Select Gender               anchor=Gender
        ClickText         ${gender}[${x}]             anchor=Approx. Age
        ScrollTo          ${ethnicity}[${x}]
        ClickCheckbox     ${ethnicity}[${x}]          on
        ClickText         Save
        VerifyText        The Intake Person details are saved. Close this modal to return to the Allegation Report workflow.

        ClickText         Close                       partial_match=false         anchor=The Intake Person details are saved. Close this modal to return to the Allegation Report workflow.

    END


    #create dictornaries and then list 
    &{account_1}=             Create Dictionary    name=Customer A    phone=(12) 345-6789    website=https://www.customera.com    type=Customer - Direct
    &{account_2}=             Create Dictionary    name=Customer B    phone=(98) 765-4321    website=https://www.customerb.com    type=Channel Partner / Reseller
    &{account_3}=             Create Dictionary    name=Customer C    phone=(19) 283-7465    website=https://www.customerc.com    type=Other
    &{account_4}=             Create Dictionary    name=Customer D    phone=(19) 283-7465    website=https://www.customerd.com    type=Other
    @{new_accounts}=          Create List    ${account_1}    ${account_2}    ${account_3}   ${account_4}                         


    # Use a FOR conditon to Create accounts
    FOR    ${item}    IN      @{new_accounts}

        VerifyText            Account Name    delay=2
        ClickUntil            Account Information    New       
        
        UseModal              On
        TypeText              Account Name    ${item["name"]}     anchor=Parent Account
        TypeText              Phone           ${item["phone"]}
        TypeText              Website         ${item["website"]}
        ClickText             Save            partial_match=False
        UseModal              Off

        VerifyText            ${item["name"]}
        ClickText             Accounts        partial_match=False
    END

Test Case - Working with strings and lists 
    # Create a string of words
    ${string}=    Set Variable    lake ocean river mountain sky
    
    # Split string into a list of words; the "@" symbol is used to declare a list
    @{split}=     Split String    ${string}

    # Target the word "mountain" from the list; the index begins at 0, so 0=lake 1=ocean 2=river 3=mountain 4= sky
    ${mountain}=          Get From List             ${split}    3

    # Loop through the entire list using a 
    FOR           ${x}            IN RANGE       0  5
        Log to console       ${split}[${x}]
    END

    # Loop through the list while targeting a specific word beggining with an index of 0
    FOR           ${x}            IN             ${split}
        Log to console       ${x}[0]
        Log to console       ${x}[1]
        Log to console       ${x}[2]
        Log to console       ${x}[3]
        Log to console       ${x}[4]
    END