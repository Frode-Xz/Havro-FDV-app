
# Koble til SharePoint
Connect-PnPOnline -Url "https://havroas.sharepoint.com/sites/FDVHavroEiendom" -Interactive -ClientId "344780eb-bf05-4325-9f9d-2b30eed09eb2"

##############################################
# 1. Opprett Eiendommer-listen
##############################################
New-PnPList -Title "Eiendommer" -Template GenericList -OnQuickLaunch:$true

# Legg til kolonner
Add-PnPField -List "Eiendommer" -DisplayName "Adresse" -InternalName "Adresse" -Type Text
Add-PnPField -List "Eiendommer" -DisplayName "Matrikkelnummer" -InternalName "Matrikkelnummer" -Type Text
Add-PnPField -List "Eiendommer" -DisplayName "Antall leiligheter" -InternalName "AntallLeiligheter" -Type Number
Add-PnPField -List "Eiendommer" -DisplayName "Status" -InternalName "Status" -Type Choice -Choices "Aktiv","Solgt"

# Legg inn eiendommer
Add-PnPListItem -List "Eiendommer" -Values @{"Title"="Kranaveien 47-49";"Adresse"="Kranaveien 47-49, 6510 Kristiansund";"Matrikkelnummer"="1505-6/3/0/0";"AntallLeiligheter"="4";"Status"="Aktiv"}
Add-PnPListItem -List "Eiendommer" -Values @{"Title"="Konsul Knudtzons gate 35";"Adresse"="Konsul Knudtzons gate 35, 6508 Kristiansund";"Matrikkelnummer"="3/111";"AntallLeiligheter"="3";"Status"="Aktiv"}
Add-PnPListItem -List "Eiendommer" -Values @{"Title"="Dalegata 32";"Adresse"="Dalegata 32, Kristiansund";"Matrikkelnummer"="";"AntallLeiligheter"="3";"Status"="Aktiv"}

##############################################
# 2. Opprett Prosjekter-listen
##############################################
New-PnPList -Title "Prosjekter" -Template GenericList -OnQuickLaunch:$true

# Legg til kolonner
Add-PnPField -List "Prosjekter" -DisplayName "Prosjektnavn" -InternalName "Prosjektnavn" -Type Text
Add-PnPField -List "Prosjekter" -DisplayName "Status" -InternalName "Status" -Type Choice -Choices "Planlagt","Pågår","Ferdig"
Add-PnPField -List "Prosjekter" -DisplayName "Startdato" -InternalName "Startdato" -Type DateTime
Add-PnPField -List "Prosjekter" -DisplayName "Sluttdato" -InternalName "Sluttdato" -Type DateTime
Add-PnPField -List "Prosjekter" -DisplayName "Beskrivelse" -InternalName "Beskrivelse" -Type Note

##############################################
# 3. Opprett FDV-dokumentasjon (dokumentbibliotek)
##############################################
New-PnPList -Title "FDV-dokumentasjon" -Template DocumentLibrary -OnQuickLaunch:$true

# Legg til vanlige felter
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Adresse" -InternalName "Adresse" -Type Text
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Matrikkelnummer" -InternalName "Matrikkelnummer" -Type Text
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Bygg" -InternalName "Bygg" -Type Choice -Choices "Bygg A","Bygg B"
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Boenhet" -InternalName "Boenhet" -Type Choice -Choices "H0001","H0101","H0102","H0201","H0202"
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Utstyr/Inventar" -InternalName "UtstyrInventar" -Type Text
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Dokumenttype" -InternalName "Dokumenttype" -Type Choice -Choices "FDV","Tegning","Bilde","Kontrakt","Rapport","Søknad","Prosjekt"
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Status" -InternalName "Status" -Type Choice -Choices "Aktiv","Arkivert"
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Dato" -InternalName "Dato" -Type DateTime
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Beskrivelse" -InternalName "Beskrivelse" -Type Note

##############################################
# 4. Hent GUID for listene
##############################################
$eiendomListId = (Get-PnPList -Identity "Eiendommer").Id
$prosjektListId = (Get-PnPList -Identity "Prosjekter").Id

##############################################
# 5. Opprett oppslagsfeltene med XML
##############################################
$fieldXmlEiendomProsjekt = @"
<Field Type='Lookup' DisplayName='Eiendom' Name='Eiendom' List='$eiendomListId' ShowField='Title' />
"@
Add-PnPFieldFromXml -List "Prosjekter" -FieldXml $fieldXmlEiendomProsjekt

$fieldXmlEiendomFDV = @"
<Field Type='Lookup' DisplayName='Eiendom' Name='Eiendom' List='$eiendomListId' ShowField='Title' />
"@
Add-PnPFieldFromXml -List "FDV-dokumentasjon" -FieldXml $fieldXmlEiendomFDV

$fieldXmlProsjektFDV = @"
<Field Type='Lookup' DisplayName='Prosjekt-ID' Name='ProsjektID' List='$prosjektListId' ShowField='ID' />
"@
Add-PnPFieldFromXml -List "FDV-dokumentasjon" -FieldXml $fieldXmlProsjektFDV


# Koble til SharePoint
Connect-PnPOnline -Url "https://havroas.sharepoint.com/sites/FDVHavroEiendom" -Interactive

##############################################
# 1. Opprett Eiendommer-listen
##############################################
New-PnPList -Title "Eiendommer" -Template GenericList -OnQuickLaunch:$true

# Legg til kolonner
Add-PnPField -List "Eiendommer" -DisplayName "Adresse" -InternalName "Adresse" -Type Text
Add-PnPField -List "Eiendommer" -DisplayName "Matrikkelnummer" -InternalName "Matrikkelnummer" -Type Text
Add-PnPField -List "Eiendommer" -DisplayName "Antall leiligheter" -InternalName "AntallLeiligheter" -Type Number
Add-PnPField -List "Eiendommer" -DisplayName "Status" -InternalName "Status" -Type Choice -Choices "Aktiv","Solgt"

# Legg inn eiendommer
Add-PnPListItem -List "Eiendommer" -Values @{"Title"="Kranaveien 47-49";"Adresse"="Kranaveien 47-49, 6510 Kristiansund";"Matrikkelnummer"="1505-6/3/0/0";"AntallLeiligheter"="4";"Status"="Aktiv"}
Add-PnPListItem -List "Eiendommer" -Values @{"Title"="Konsul Knudtzons gate 35";"Adresse"="Konsul Knudtzons gate 35, 6508 Kristiansund";"Matrikkelnummer"="3/111";"AntallLeiligheter"="3";"Status"="Aktiv"}
Add-PnPListItem -List "Eiendommer" -Values @{"Title"="Dalegata 32";"Adresse"="Dalegata 32, Kristiansund";"Matrikkelnummer"="";"AntallLeiligheter"="3";"Status"="Aktiv"}

##############################################
# 2. Opprett Prosjekter-listen
##############################################
New-PnPList -Title "Prosjekter" -Template GenericList -OnQuickLaunch:$true

# Legg til kolonner
Add-PnPField -List "Prosjekter" -DisplayName "Prosjektnavn" -InternalName "Prosjektnavn" -Type Text
Add-PnPField -List "Prosjekter" -DisplayName "Status" -InternalName "Status" -Type Choice -Choices "Planlagt","Pågår","Ferdig"
Add-PnPField -List "Prosjekter" -DisplayName "Startdato" -InternalName "Startdato" -Type DateTime
Add-PnPField -List "Prosjekter" -DisplayName "Sluttdato" -InternalName "Sluttdato" -Type DateTime
Add-PnPField -List "Prosjekter" -DisplayName "Beskrivelse" -InternalName "Beskrivelse" -Type Note

##############################################
# 3. Opprett FDV-dokumentasjon (dokumentbibliotek)
##############################################
New-PnPList -Title "FDV-dokumentasjon" -Template DocumentLibrary -OnQuickLaunch:$true

# Legg til vanlige felter
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Adresse" -InternalName "Adresse" -Type Text
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Matrikkelnummer" -InternalName "Matrikkelnummer" -Type Text
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Bygg" -InternalName "Bygg" -Type Choice -Choices "Bygg A","Bygg B"
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Boenhet" -InternalName "Boenhet" -Type Choice -Choices "H0001","H0101","H0102","H0201","H0202"
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Utstyr/Inventar" -InternalName "UtstyrInventar" -Type Text
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Dokumenttype" -InternalName "Dokumenttype" -Type Choice -Choices "FDV","Tegning","Bilde","Kontrakt","Rapport","Søknad","Prosjekt"
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Status" -InternalName "Status" -Type Choice -Choices "Aktiv","Arkivert"
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Dato" -InternalName "Dato" -Type DateTime
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Beskrivelse" -InternalName "Beskrivelse" -Type Note

##############################################
# 4. Opprett Oppgavelisten
##############################################
New-PnPList -Title "FDV-Oppgaver" -Template GenericList -OnQuickLaunch:$true

# Legg til kolonner
Add-PnPField -List "FDV-Oppgaver" -DisplayName "Boenhet" -InternalName "Boenhet" -Type Choice -Choices "H0001","H0101","H0102","H0201","H0202"
Add-PnPField -List "FDV-Oppgaver" -DisplayName "Oppgavetype" -InternalName "Oppgavetype" -Type Choice -Choices "Kontroll","Vedlikehold","Rydding","Leverandøroppfølging"
Add-PnPField -List "FDV-Oppgaver" -DisplayName "Beskrivelse" -InternalName "Beskrivelse" -Type Note
Add-PnPField -List "FDV-Oppgaver" -DisplayName "Frist" -InternalName "Frist" -Type DateTime
Add-PnPField -List "FDV-Oppgaver" -DisplayName "Status" -InternalName "Status" -Type Choice -Choices "Ny","Pågår","Fullført"
Add-PnPField -List "FDV-Oppgaver" -DisplayName "Ansvarlig" -InternalName "Ansvarlig" -Type User
Add-PnPField -List "FDV-Oppgaver" -DisplayName "Bilder" -InternalName "Bilder" -Type Note

##############################################
# 5. Hent GUID for listene
##############################################
$eiendomListId = (Get-PnPList -Identity "Eiendommer").Id
$prosjektListId = (Get-PnPList -Identity "Prosjekter").Id

##############################################
# 6. Opprett oppslagsfeltene med XML
##############################################
# Oppslag i Prosjekter (Eiendom)
$fieldXmlEiendomProsjekt = @"
<Field Type='Lookup' DisplayName='Eiendom' Name='Eiendom' List='$eiendomListId' ShowField='Title' />
"@
Add-PnPFieldFromXml -List "Prosjekter" -FieldXml $fieldXmlEiendomProsjekt

# Oppslag i FDV-dokumentasjon (Eiendom og Prosjekt-ID)
$fieldXmlEiendomFDV = @"
<Field Type='Lookup' DisplayName='Eiendom' Name='Eiendom' List='$eiendomListId' ShowField='Title' />
"@
Add-PnPFieldFromXml -List "FDV-dokumentasjon" -FieldXml $fieldXmlEiendomFDV

$fieldXmlProsjektFDV = @"
<Field Type='Lookup' DisplayName='Prosjekt-ID' Name='ProsjektID' List='$prosjektListId' ShowField='ID' />
"@
Add-PnPFieldFromXml -List "FDV-dokumentasjon" -FieldXml $fieldXmlProsjektFDV

# Oppslag i FDV-Oppgaver (Eiendom)
$fieldXmlEiendomOppgaver = @"
<Field Type='Lookup' DisplayName='Eiendom' Name='Eiendom' List='$eiendomListId' ShowField='Title' />
"@
Add-PnPFieldFromXml -List "FDV-Oppgaver" -FieldXml $fieldXmlEiendomOppgaver
