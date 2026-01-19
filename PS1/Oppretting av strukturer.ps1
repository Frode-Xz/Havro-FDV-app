
# Koble til SharePoint
Connect-PnPOnline -Url "https://havroas.sharepoint.com/sites/FDVHavroEiendom" -Interactive -ClientId "344780eb-bf05-4325-9f9d-2b30eed09eb2"

##############################################
# 1. Opprett liste for Eiendommer
##############################################
New-PnPList -Title "Eiendommer" -Template GenericList -OnQuickLaunch:$true

# Legg til kolonner i Eiendommer-listen
Add-PnPField -List "Eiendommer" -DisplayName "Adresse" -InternalName "Adresse" -Type Text
Add-PnPField -List "Eiendommer" -DisplayName "Matrikkelnummer" -InternalName "Matrikkelnummer" -Type Text
Add-PnPField -List "Eiendommer" -DisplayName "Antall leiligheter" -InternalName "AntallLeiligheter" -Type Number
Add-PnPField -List "Eiendommer" -DisplayName "Status" -InternalName "Status" -Type Choice -Choices "Aktiv","Solgt"

# Legg inn eiendommer
Add-PnPListItem -List "Eiendommer" -Values @{"Title"="Kranaveien 47-49";"Adresse"="Kranaveien 47-49, 6510 Kristiansund";"Matrikkelnummer"="1505-6/3/0/0";"AntallLeiligheter"="4";"Status"="Aktiv"}
Add-PnPListItem -List "Eiendommer" -Values @{"Title"="Konsul Knudtzons gate 35";"Adresse"="Konsul Knudtzons gate 35, 6508 Kristiansund";"Matrikkelnummer"="3/111";"AntallLeiligheter"="3";"Status"="Aktiv"}
Add-PnPListItem -List "Eiendommer" -Values @{"Title"="Dalegata 32";"Adresse"="Dalegata 32, Kristiansund";"Matrikkelnummer"="";"AntallLeiligheter"="3";"Status"="Aktiv"}

##############################################
# 2. Opprett liste for Prosjekter
##############################################
New-PnPList -Title "Prosjekter" -Template GenericList -OnQuickLaunch:$true

# Legg til kolonner i Prosjekter-listen
Add-PnPField -List "Prosjekter" -DisplayName "Prosjektnavn" -InternalName "Prosjektnavn" -Type Text
Add-PnPField -List "Prosjekter" -DisplayName "Eiendom" -InternalName "Eiendom" -Type Lookup -LookupList "Eiendommer" -LookupField "Title"
Add-PnPField -List "Prosjekter" -DisplayName "Status" -InternalName "Status" -Type Choice -Choices "Planlagt","Pågår","Ferdig"
Add-PnPField -List "Prosjekter" -DisplayName "Startdato" -InternalName "Startdato" -Type DateTime
Add-PnPField -List "Prosjekter" -DisplayName "Sluttdato" -InternalName "Sluttdato" -Type DateTime
Add-PnPField -List "Prosjekter" -DisplayName "Beskrivelse" -InternalName "Beskrivelse" -Type Note

##############################################
# 3. Opprett dokumentbibliotek for FDV-dokumentasjon
##############################################
New-PnPList -Title "FDV-dokumentasjon" -Template DocumentLibrary -OnQuickLaunch:$true

# Legg til metadatafelter
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Eiendom" -InternalName "Eiendom" -Type Lookup -LookupList "Eiendommer" -LookupField "Title"
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Adresse" -InternalName "Adresse" -Type Text
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Matrikkelnummer" -InternalName "Matrikkelnummer" -Type Text
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Bygg" -InternalName "Bygg" -Type Choice -Choices "Bygg A","Bygg B"
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Boenhet" -InternalName "Boenhet" -Type Choice -Choices "H0001","H0101","H0102","H0201","H0202"
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Utstyr/Inventar" -InternalName "UtstyrInventar" -Type Text
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Dokumenttype" -InternalName "Dokumenttype" -Type Choice -Choices "FDV","Tegning","Bilde","Kontrakt","Rapport","Søknad","Prosjekt"
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Prosjekt-ID" -InternalName "ProsjektID" -Type Lookup -LookupList "Prosjekter" -LookupField "ID"
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Status" -InternalName "Status" -Type Choice -Choices "Aktiv","Arkivert"
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Dato" -InternalName "Dato" -Type DateTime
Add-PnPField -List "FDV-dokumentasjon" -DisplayName "Beskrivelse" -InternalName "Beskrivelse" -Type Note
