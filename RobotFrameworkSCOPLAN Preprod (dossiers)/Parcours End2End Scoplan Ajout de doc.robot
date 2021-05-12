*** Settings ***
Library           SeleniumLibrary    timeout=20

*** Variables ***
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
    Wait Until Page Contains Element    //select[@id="projectByStatus"]
    Select From List By Value    //select[@id="projectByStatus"]    all

Choisir le compte Uzumaki Boruto
    Sleep    6s
    Wait Until Page Contains Element    xpath=(//a[@href="https://www.scoplan.com/fr/project/detail/24011"])[4]
    Click Link    xpath=(//a[@href="https://www.scoplan.com/fr/project/detail/24011"])[4]

Cliquer sur ajouter un document: Un pop s'affiche
    sleep    5s
    Wait Until Page Contains Element    //*[@id="icone-action"]/a[4]
    Click Element    //*[@id="icone-action"]/a[4]

Envoi du fichier
    Wait Until Page Contains Element    id=addDocDropzone
	Choose File    xpath=(//input[@class="dz-hidden-input"])[5]    ${CURDIR}${/}data${/}planning (6).pdf
    Sleep    3s

Cliquer sur "Dossier Permis de construire": Un menu avec la possibilité d'écrire un message apparaît
    Wait Until Page Contains Element    //i[@class="icon-more-less fa fa-angle-down"]
    Click Element    //i[@class="icon-more-less fa fa-angle-down"]
    Sleep    2s
    Wait Until Page Contains Element    //*[@id="project_file_folder_404"]
    Click Element    //*[@id="project_file_folder_404"]
    

Ajout de texte:
    Sleep    2s
    Wait Until Page Contains Element    //*[@id="showDocMailEdit"]/div/textarea
    Input Text    //*[@id="showDocMailEdit"]/div/textarea    ${AjoutTexte}
    Sleep    2s

Envoyer le doc: Un popin s'affiche
    Wait Until Page Contains Element    //button[@id="projectStepDocSubmit"]
    Click Element    //button[@id="projectStepDocSubmit"]
    

Verification de la reception du doc dans le compte CMI (FDP): FDP
    Sleep    10s
    Page Should Contain    ${AjoutTexte}
    



Verification de la reception du doc dans le compte CMI (FDP): Partie "Docs"
    Wait Until Page Contains Element    //*[@id="fdp-filter-menu"]/ul/li[3]/a
    Click Link    //*[@id="fdp-filter-menu"]/ul/li[3]/a
    Sleep    5s
    Page Should Contain    ${AjoutTexte}



Fermer le navigateur
    Sleep    10s
    Close Browser

Verification de la reception du doc dans le compte particulier: "Accueil"
    Open Browser    https://www.myprojectcompanion.com/fr/YayaB1749/login    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    //input[@id="middlewarebundle_login_username"]
    Input Text    //input[@id="middlewarebundle_login_username"]    yacine.bedhouche@protonmail.com
    Wait Until Page Contains Element    //input[@id="middlewarebundle_login_password"]
    Input Text    //input[@id="middlewarebundle_login_password"]    bcf92299329
    Wait Until Page Contains Element    //button[@class="btn btn-submit"]
    Click Element    //button[@class="btn btn-submit"]
    Wait Until Page Contains Element    //img[@class="welcome-icon"]
    Click Element    //img[@class="welcome-icon"]
    Sleep    7s
    Page Should Contain    ${AjoutTexte}
    

Verification de la reception du doc dans le compte particulier: Onglet "Docs"
    Click Element    //*[@id="fdp-filter-menu"]/ul/li[3]/a
    Sleep    7s
    Page Should Contain    ${AjoutTexte}



Fermer le navigateur: Fin du test   
    Sleep    10s
    Close Browser
    


