*** Settings ***
Resource                  ../resources/common.robot
Suite Setup               Setup Browser
Suite Teardown            End suite


*** Test Cases ***
ServiceCloud Example
    Home
    LaunchApp             Service
    ClickText             Cases                       partial_match=False
    ClickText             New                         partial_match=False
    UseModal              On
    TypeText              Account Name                Robotic Testing
    ClickText             Robotic Testing             anchor=2
    PickList              Status                      New
    PickList              Case Origin                 Email
    PickList              Priority                    Medium
    TypeText              Subject                     Bug Found
    TypeText              Description                 Something broken
    ClickText             Cancel

ExperienceCloud Example
    Home
    LaunchApp             Community
    ClickText             Accounts
    ClickText             New
    UseModal              On
    TypeText              Phone                      4045551234
    TypeText              Account Name               I Love Copado
    PickList              Account Currency           USD - U.S. Dollar
    TypeText              Website                    https://copado.com
    PickList              Type                       Customer - Direct
    PickList              Industry                   Technology
    ClickText             Cancel                     
    UseModal              Off


