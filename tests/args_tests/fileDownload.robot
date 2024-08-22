*** Settings ***
Library    OperatingSystem
Library    Collections
Library    RequestsLibrary
Library    GitLibrary

*** Variables ***
${REPO_PATH}      /path/to/your/repo
${GIT_URL}        https://your-git-repo-url.git
${FILE_URL}       https://example.com/file-to-download.txt
${FILE_NAME}      file-to-download.txt
${COMMIT_MESSAGE} Added file during runtime

*** Test Cases ***
Download File And Commit To Git
    [Setup]    Clone Repository
    Download File
    Add File To Repository
    Commit Changes
    Push Changes
    [Teardown]    Cleanup Repository

*** Keywords ***
Clone Repository
    Run Process    git    clone    ${GIT_URL}    ${REPO_PATH}    shell=True
    Directory Should Exist    ${REPO_PATH}

Download File
    Create Directory    ${REPO_PATH}/downloads
    ${response}=    Get Request    ${FILE_URL}
    ${status_code}=    Get From Dictionary    ${response}    status_code
    Should Be Equal As Numbers    ${status_code}    200
    ${file_content}=    Get From Dictionary    ${response}    content
    Create File    ${REPO_PATH}/downloads/${FILE_NAME}    ${file_content}

Add File To Repository
    Run Process    git    add    ${REPO_PATH}/downloads/${FILE_NAME}    cwd=${REPO_PATH}    shell=True

Commit Changes
    Run Process    git    commit    -m "${COMMIT_MESSAGE}"    cwd=${REPO_PATH}    shell=True

Push Changes
    Run Process    git    push    origin    main    cwd=${REPO_PATH}    shell=True

Cleanup Repository
    Remove Directory    ${REPO_PATH}    recursive=True
