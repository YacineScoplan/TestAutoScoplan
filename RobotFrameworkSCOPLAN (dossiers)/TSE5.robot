*** Settings ***
Library           SeleniumLibrary    timeout=20

*** Variables ***
${mail}           yb@scoplan.com
${password}       bcf92299329
${AjoutTexte}     Le test fonctionne bien
${BROWSER}        chrome
${mail}           yb@scoplan.com
${password}       bcf92299329
${AjoutTexte}     Le test fonctionne bien
${BROWSER}        chrome

*** Test Cases ***
Connexion: L'utilistateur est connecte et arrive sur le fil du projet
    Open Browser    https://www.scoplan.com/fr/login    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    //input[@id="middlewarebundle_login_email"]
    Input Text    //input[@id="middlewarebundle_login_email"]    ${mail}
    Wait Until Page Contains Element    //div[@class="form-container"]
    Click Element    //div[@class="form-container"]
    Wait Until Page Contains Element    //input[@id="middlewarebundle_login_password"]
    Input Text    //input[@id="middlewarebundle_login_password"]    ${password}
    Wait Until Page Contains Element    //button[@class="btn btn-submit"]
    Click Element    //button[@class="btn btn-submit"]

Filtrer par statut SAV et projets archives: Les projet sont tries sur avec le filtre "tous"
    Sleep    10s
    Wait Until Page Contains Element    //select[@id="projectByStatus"]
    Select From List By Value    //select[@id="projectByStatus"]    all

Choisir le compte Uzumaki Boruto
    Sleep    10s
    Wait Until Page Contains Element    xpath=(//a[@href="https://www.scoplan.com/fr/project/detail/24011"])[6]
    Click Link    xpath=(//a[@href="https://www.scoplan.com/fr/project/detail/24011"])[6]

Cliquer sur ajouter un document: Un pop s'affiche
    Sleep    10s
    Wait Until Page Contains Element    //*[@id="icone-action"]/a[4]
    Click Element    //*[@id="icone-action"]/a[4]

Choisir le fichier
    Sleep    10s
    Wait Until Page Contains Element    xpath=(//input[@class="dz-hidden-input"])[5]
    Choose File    xpath=(//input[@class="dz-hidden-input"])[5]    ${CURDIR}${/}data${/}FACTURE 1.pdf
    Sleep    5s
    Choose File    xpath=(//input[@class="dz-hidden-input"])[5]    ${CURDIR}${/}data${/}FACTURE 2.pdf
    Sleep    5s
    Choose File    xpath=(//input[@class="dz-hidden-input"])[5]    ${CURDIR}${/}data${/}FACTURE 3.pdf

Cliquer sur "signature electronique par le client"
    Sleep    10s
    Wait Until Page Contains Element    //*[@id="addDocModalActionWrap"]/div[1]/div[2]/div[1]/div[1]/label/span
    Click Element    //*[@id="addDocModalActionWrap"]/div[1]/div[2]/div[1]/div[1]/label/span

Cliquer sur "Autres documents"
    Sleep    10s
    Wait Until Page Contains Element    //*[@id="ccmiOptionsRow"]/div[3]/div/label/span
    Click Element    //*[@id="ccmiOptionsRow"]/div[3]/div/label/span

Choisir dossier non classé
    Wait Until Page Contains Element    //*[@id="addDocModalActionWrap"]/div[2]/div[1]/label/span
    Click Element    //*[@id="addDocModalActionWrap"]/div[2]/div[1]/label/span

Upload le doc
    Sleep    10s
    Wait Until Page Contains Element    //button[@id="projectStepDocSubmit"]
    Click Element    //button[@id="projectStepDocSubmit"]

Valider et envoyer le doc 1
    Sleep    10s
    Wait Until Page Contains Element    //*[@id="elecSignaturePosition"]/div/div/div[2]/div[3]/button[2]
    Click Element    //*[@id="elecSignaturePosition"]/div/div/div[2]/div[3]/button[2]

Valider et envoyer le doc 2
    Sleep    10s
    Wait Until Page Contains Element    //*[@id="elecSignaturePosition"]/div/div/div[2]/div[3]/button[2]
    Click Element    //*[@id="elecSignaturePosition"]/div/div/div[2]/div[3]/button[2]

Valider et envoyer le doc 3
    Sleep    10s
    Wait Until Page Contains Element    //*[@id="elecSignaturePosition"]/div/div/div[2]/div[3]/button[2]
    Click Element    //*[@id="elecSignaturePosition"]/div/div/div[2]/div[3]/button[2]

Verification de la reception du doc dans le compte CMI (FDP): FDP
    Sleep    10s
    Wait Until Page Contains Element    //*[@id="1 - Bienvenue"]/a/img
    Page Should Contain    FACTURE 1.pdf
    Page Should Contain    FACTURE 2.pdf
    Page Should Contain    FACTURE 3.pdf

Verification de la reception du doc dans le compte CMI (FDP): Partie "Docs"
    Sleep    10s
    Click Element    //*[@id="fdp-filter-menu"]/ul/li[3]/a
    Sleep    10s
    Page Should Contain    FACTURE 1.pdf
    Page Should Contain    FACTURE 2.pdf
    Page Should Contain    FACTURE 3.pdf

Fermer le navigateur du compte Scoplan
    Sleep    10s
    Close Browser

Verification de la reception du doc dans le compte particulier: "Accueil"
    Sleep    10s
    Open Browser    https://www.myprojectcompanion.com/fr/YayaB1749/login    ${BROWSER}
    Maximize Browser Window
    Input Text    //input[@name="middlewarebundle_login[username]"]    borutouzumaki@yopmail.com
    Input Text    //input[@name="middlewarebundle_login[password]"]    azerty
    Click Element    //button[@class="btn btn-submit"]
    Click Element    //div[@class="welcome-item"]
    Click Element    //*[@id="newFdp"]/div[1]/div[2]/ul/li/span[2]/button
    Sleep    10s
    Capture Page Screenshot    ${CURDIR}${/}Capture Yousign${/}CaptureTSE3_Accueil.png
    Close Browser

Verification de la reception du doc dans le compte particulier: Onglet "Docs"
    Sleep    10s
    Open Browser    https://www.myprojectcompanion.com/fr/YayaB1749/login    ${BROWSER}
    Input Text    //input[@name="middlewarebundle_login[username]"]    borutouzumaki@yopmail.com
    Input Text    //input[@name="middlewarebundle_login[password]"]    azerty
    Click Element    //button[@class="btn btn-submit"]
    Click Element    //img[@class="welcome-icon"]
    Click Link    xpath=(//a[@href="/fr/YayaB1749/documents"])[2]
    Click Element    //*[@id="mainSection"]/div/div/div[1]/div[2]/div[2]/div[1]/div[1]/div[2]/div/div/div/div/div/div[1]/div/img
    Sleep    10s
    Capture Page Screenshot    ${CURDIR}${/}Capture Yousign${/}CaptureTSE3_OngletDoc.png
    Sleep    10s
    Close Browser

Verification de la SE dans le mail
    Sleep    10s
    Open Browser    http://www.yopmail.com/    ${BROWSER}
    Input Text    //input[@name="login"]    borutouzumaki
    Wait Until Page Contains Element    //input[@title="Vérifier les mails @yopmail.com"]
    Click Element    //input[@title="Vérifier les mails @yopmail.com"]
    Sleep    3s
    Capture Page Screenshot    ${CURDIR}${/}Capture Yousign${/}CaptureTSE3_MAIL.png

Fin du test: Fermer le navigateur
    Sleep    10s
    Close Browser
