*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***

Data Driven Excel Test
    Home
    LaunchApp    Sales
    ClickText    Accounts
    ClickText    New
    UseModal

    TypeText     Account Name    ${account_name}
    TypeText     Phone           ${phone}
    TypeText     Fax             ${fax}
    TypeText     Website         ${website}
    PickList     Industry        ${industry}
    TypeText     Employees       ${employees}
    TypeText     Annual Revenue  ${annual_revenue}
    ClickText    Cancel  

Verify Picklist Options    
    Home
    LaunchApp             Sales
    ClickText             Leads
    ClickText             New
    UseModal
    ${salutation_options}=            GetPickList           Salutation 
    @{salutation_list}=                Convert to List           ${salutation_options}
    FOR    ${salutation}      IN    @{salutation_list}             
        PickList            Salutation           ${salutation}
        VerifyPickList      Salutation           ${salutation}
        LogScreenshot
    END



