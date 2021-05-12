*** Settings ***
Library           SeleniumLibrary    timeout=20
Library           SeleniumLibrary    timeout=20

*** Variables ***
${mail}           yb@scoplan.com
${password}       bcf92299329
${AjoutTexte}     Le test fonctionne bien
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
    Open Browser    https://preprod.scoplan.com/fr/login    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    //input[@id="middlewarebundle_login_email"]
    Input Text    //input[@id="middlewarebundle_login_email"]    ${mail}
    Wait Until Page Contains Element    //div[@class="form-container"]
    Click Element    //div[@class="form-container"]
    Wait Until Page Contains Element    //input[@id="middlewarebundle_login_password"]
    Input Text    //input[@id="middlewarebundle_login_password"]    ${password}
    Wait Until Page Contains Element    //button[@class="btn btn-submit"]
    Click Element    //button[@class="btn btn-submit"]

Choisir le compte Uzumaki Boruto
    Sleep    10s
    Wait Until Page Contains Element    xpath=(//a[@href="https://preprod.scoplan.com/fr/project/detail/1790"])[6]
    Click Link    xpath=(//a[@href="https://preprod.scoplan.com/fr/project/detail/1790"])[6]

Cliquer sur ajouter un document: Un pop s'affiche
    Sleep    10s
    Wait Until Page Contains Element    //*[@id="icone-action"]/a[4]
    Click Element    //*[@id="icone-action"]/a[4]

Choisir le fichier
    Sleep    10s
    Wait Until Page Contains Element    xpath=(//input[@class="dz-hidden-input"])[5]
    Choose File    xpath=(//input[@class="dz-hidden-input"])[5]    ${CURDIR}${/}data${/}FACTURE 1.pdf

Cliquer sur "signature electronique par le client"
    Sleep    10s
    Wait Until Page Contains Element    //*[@id="addDocModalActionWrap"]/div[1]/div[2]/div[1]/div[1]/label/span
    Click Element    //*[@id="addDocModalActionWrap"]/div[1]/div[2]/div[1]/div[1]/label/span

Cliquer sur "Est-ce la notice du contrat ou la notice descriptive"
    Sleep    10s
    Wait Until Page Contains Element    //*[@id="ccmiOptionsRow"]/div[2]/div[1]/label/span
    Click Element    //*[@id="ccmiOptionsRow"]/div[2]/div[1]/label/span
    Wait Until Page Contains Element    //input[@name="amountNotice"]
    Input Text    //input[@name="amountNotice"]    1098765

Choisir dossier "Contrat & avenants": Un menu avec la possibilite d'ecrire un message apparait
    Sleep    10s
    Wait Until Page Contains Element    //i[@class="icon-more-less fa fa-angle-down"]
    Click Element    //i[@class="icon-more-less fa fa-angle-down"]
    Sleep    2s
    Wait Until Page Contains Element    //input[@id="project_file_folder_511"]
    Click Element    //input[@id="project_file_folder_511"]

Upload le doc
    Sleep    10s
    Wait Until Page Contains Element    //button[@id="projectStepDocSubmit"]
    Click Element    //button[@id="projectStepDocSubmit"]

Valider et envoyer le doc
    Sleep    10s
    Wait Until Page Contains Element    //*[@id="elecSignaturePosition"]/div/div/div[2]/div[3]/button[2]
    Click Element    //*[@id="elecSignaturePosition"]/div/div/div[2]/div[3]/button[2]

Verification de la reception du doc dans le compte CMI (FDP): FDP
    Sleep    10s
    Wait Until Page Contains Element    //*[@id="1 - Bienvenue"]/a/img
    Page Should Contain    FACTURE 1.pdf

Verification de la reception du doc dans le compte CMI (FDP): Partie "Docs"
    Sleep    10s
    Click Element    //*[@id="fdp-filter-menu"]/ul/li[3]/a
    Sleep    10s
    Page Should Contain    FACTURE 1.pdf

Fermer le navigateur du compte Scoplan
    Sleep    10s
    Close Browser

Verification de la reception du doc dans le compte particulier: "Accueil"
    Sleep    10s
    Open Browser    https://preprod.myprojectcompanion.com/fr/YayaB581/login    ${BROWSER}
    Maximize Browser Window
    Input Text    //input[@name="middlewarebundle_login[username]"]    borutouzumaki@yopmail.com
    Input Text    //input[@name="middlewarebundle_login[password]"]    azerty
    Click Element    //button[@class="btn btn-submit"]
    Wait Until Page Contains Element    //img[@class="welcome-icon"]
    Click Element    //img[@class="welcome-icon"]
    Wait Until Page Contains Element    //*[@id="newFdp"]/div[1]/div[2]/ul/li/span[2]/button
    Click Element    //*[@id="newFdp"]/div[1]/div[2]/ul/li/span[2]/button
    Sleep    10s
    Capture Page Screenshot    ${CURDIR}${/}Capture Yousign${/}CaptureTSE3_Accueil.png
    Close Browser

Verification de la reception du doc dans le compte particulier: Onglet "Docs"
    Sleep    10s
    Open Browser    https://preprod.myprojectcompanion.com/fr/YayaB581/login    ${BROWSER}
    Input Text    //input[@name="middlewarebundle_login[username]"]    borutouzumaki@yopmail.com
    Input Text    //input[@name="middlewarebundle_login[password]"]    azerty
    Click Element    //button[@class="btn btn-submit"]
    Click Element    //img[@class="welcome-icon"]
    Click Link    xpath=(//a[@href="/fr/YayaB581/documents"])[2]
    Click Element    //*[@id="mainSection"]/div/div/div[1]/div[2]/div[2]/div[1]/div[1]/div[2]/div/div/div/div/div/div[1]/div/img
    Sleep    10s
    Capture Page Screenshot    ${CURDIR}${/}Capture Yousign${/}CaptureTSE5_OngletDoc.png
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
