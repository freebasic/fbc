<?php
/***************************************************************************
 *                                   dk.php
 *                            -------------------
 *   begin                : Tuesday', Aug 15', 2002
 *   copyright            : ('C) 2002 Bugada Andrea
 *   email                : phpATM@free.fr
 *
 *   $Id$
 *
 *
 ***************************************************************************/

/***************************************************************************
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License', or
 *   ('at your option) any later version.
 *
 ***************************************************************************/

$headerpage="header.htm";    // The optional header file 
$footerpage="footer.htm";    // The optional footer file 
$infopage="info.htm";        // The optional info file 

$charsetencoding="";                 // The encoding for national symbols (i.e. for cyryllic  must be "windows-1251")
$uploadcentercaption="PHP Advanced Transfer Manager";
$uploadcentermessage="phpATM";

$mess=array(
"0" => "",
"1" => "Januar",
"2" => "Februar",
"3" => "Marts",
"4" => "April",
"5" => "Maj",
"6" => "Juni",
"7" => "Juli",
"8" => "August",
"9" => "September",
"10" => "Oktober",
"11" => "November",
"12" => "December",
"13" => "idag",
"14" => "igår",
"15" => "Filnavn",
"16" => "Rating",
"17" => "Størrelse",
"18" => "Uploaded",
"19" => "Ejer",
"20" => "Upload Fil",
"21" => "Lokal Fil",
"22" => "Fil beskrivelse",
"23" => "Download",
"24" => "Rækkefølge",
"25" => "Hjem",
"26" => "Fil",
"27" => "Print",
"28" => "Luk",
"29" => "Gå tilbage",
"30" => "Denne fil er slettet",
"31" => "Det var ikke muligt at slettet filen",
"32" => "Tilbage",
"33" => "Fejl under opload af filen !",
"34" => "Du skal vælge en fil",
"35" => "Tilbage",
"36" => "Filen",
"37" => "er blevet succesfult uploaded til serveren",
"38" => "Filen ved navn",
"39" => "Eksistere allerede",
"40" => "Filen er blevet succesfult uploaded til serveren",
"41" => "Valg af sprog er gennemsført",
"42" => "Velkommen til PHP Advanced Transfer Manager",
"43" => "Totalt pladsforbrug",
"44" => "Vis filer fra alle dage",
"45" => "Ugyldigt ZIP arkiv!",
"46" => "Indholdet af arkivet:",
"47" => "Dato/Tid",
"48" => "Bibliotek",
"49" => "Det er ikke tilladt at uploade filer med navnet %s!",
"50" => "overskrider den maksimalt tilladte størrelse",
"51" => "Information",
"52" => "Vælg udseende",
"53" => "Udseende",
"54" => "Velkommen",
"55" => "Aktuel tid",
"56" => "Bruger",
"57" => "Brugername",
"58" => "Registrer",
"59" => "Registration",
"60" => "Søndag",
"61" => "Mandag",
"62" => "Tirsdag",
"63" => "Onsdag",
"64" => "Torsdag",
"65" => "Fredag",
"66" => "Lørdag",
"67" => "Send",
"68" => "Mail filen",
"69" => "Filen er blevet sendt til %s addresse.",
"70" => "Filen er uploaded af brugeren: %s",
"71" => "Login",
"72" => "Logud",
"73" => "Enter",
"74" => "Anonymous",
"75" => "Normal bruger",
"76" => "Power bruger",
"77" => "Administrator",
"78" => "Privat zone",
"79" => "Offentlig zone",
"80" => "Du har angivet ugyldig brugernavn eller kodeord.",
"81" => "Min profil",
"82" => "Se/rediger min profil",
"83" => "Kodeord",
"84" => "Vælg sprog",
"85" => "Vælg tidszone",
"86" => "Din aktuelle tid",
"88" => "Vær venlig at indtaste en gyldig E-mail.",
"89" => "Din E-mail skal være gyldig og aktiv da din personlige aktiverings kode vil blive sendt til din E-mail.",
"90" => "Fil uploaded: ",
"91" => "Vær venlig at indtaste den E-mail adresse du indtastede under registrationen.",
"92" => "Fil størrelse: ",
"93" => "Husk at skrive dit brugernavn og kodeord ned.",
"94" => "Det er nødvendig at Registrerer dig.",
"95" => "Det er ikke nødvendig at Registrerer dig. Du kan registrere dig hvis du vil og hvorved du kan uploade filer og modtage E-mails om nye filer på siden.",
"96" => "Udseende valgt.",
"97" => "Opdater",
"98" => "Indtast venligst dit brugernavn og kodeord",
"99" => "Endnu ikke registreret? - Registrer her!",
"100" => "Har du glemt dit kodeord?",
"101" => "Vær venlig, at gå %s tilbage %s og prøv igen.",
"102" => "Du er blevet logget ud fra siden.",
"103" => "Dit brugernavn er ugyldigt. Brugernavnet må ikke overskride 12 karakterer og må kun indeholde bogstaver og tal. Derudover må det også indeholde '-', '_', og mellemrum dog ikke som færste eller sidste tegn.",
"104" => "Det valgte brugernavn '%s' du valgte er allerede optaget.",
"105" => "Bekræft kodeord",
"106" => "Du indtastede ikke kodeorderne ens.",
"107" => "Formatet af den indtastede E-mail addresse er ugyldigt.",
"108" => "Tak for din registrering. Husk dit kodeord da det er blevet krypteret og vi kan derfor ikke sende det til dig. Hvis du glemmer dit kodeord tilbyder vi et easy to use script hvorved en ny tilfældig kode kan sendes til dig.",
"109" => "Gå til %s Upload Center her. %s",
"110" => "Din activeringskode er blevet e-mailed til dig. Du skal aktivere din konto inden 2 dage ellers bliver den automatisk slettet.",
"111" => "Du har ikke tilladelse til at hente denne fil",
"112" => "Aktiver konto",
"113" => "Vær venlig at aktivere din konto",
"114" => "aktiveringskode",
"115" => "Din konto er nu aktiv.",
"116" => "Venligst %s gå ind her %s.",
"117" => "Brugernavn eller aktiveringskode er ugyldig.",
"118" => "Kontoen er allerede aktiv.",
"119" => "Jeg ønsker at modtage til min e-mailen daglig opdatering af nye filer på siden.",
"120" => "Ændre dit kodeord.",
"121" => "Dit gamle kodeord",
"122" => "Det indtastede brugernavn eksistere ikke.",
"123" => "Den indtastede e-mail er ikke gyldig.",
"124" => "Dit nye kodeord er sent til din e-mail.",
"125" => "kan ikke eksikvere, objektet blev ikke fundet",
"126" => "Personaliser din konto",
"127" => "Anvend",
"128" => "Din profil er gemt.",
"129" => "Dit kodeord er ændret.",
"130" => "Du indtastede et ugyldigt gammelt kodeord .",
"131" => "Du skal angive et nyt kodeord.",
"132" => "Opsætning",
"133" => "Opload",
"134" => "Sprog & tidszone",
"135" => "Konto statistiks",
"136" => "Din konto er oprettet:",
"137" => "Bruger management",
"138" => "Viewer (view only)",
"139" => "Uploader (upload only)",
"140" => "Din konto '%s' blev ændret",
"141" => "Senest",
"142" => "Alle",
"143" => "Den nye e-mail træder i kraft efter bekræftelse. En bekræftelses kode er sendt til den nye mail adresse. Se instruktionerne i mailen.",
"144" => "",
"145" => "Venligst, bekræt din nye e-mail adresse.",
"146" => "Bekræftelses kode",
"147" => "Bekræft",
"148" => "Intet at bekræfte.",
"149" => "Det indtastede brugernavn eller bekræftelses kode er ugyldig.",
"150" => "Din nye e-mail adresse '%s' er bekræftet.",
"151" => "Oploadede filer",
"152" => "downloadede filer",
"153" => "e-mailede filer",
"154" => "Konto oprettet",
"155" => "Sidste logon tid",
"156" => "Status",
"157" => "Aktiv status",
"158" => "Modtag digest",
"159" => "e-mail",
"160" => "Total:",
"161" => "konto(er)",
"162" => "Slet konto",
"163" => "Vist %s konto(er) of %s",
"164" => "Configurer Opload Center",
"165" => "Rediger filer",
"166" => "Rediger fil",
"167" => "Fil %s er opdateret",
"168" => "Gem",
"169" => "Slet",
"170" => "Slet filer",
"171" => "Mirror",
"172" => "Ja",
"173" => "Nej",
"174" => "Aktiv",
"175" => "Inaktiv",
"176" => "ikke godkendt",
"177" => "Serveren kunne desvære ikke eksekverer mail programmet.",
"178" => "Din registration mislykkedes. Prøv venligst igen senere.",
"179" => "Prøv venligst igen senere.",
"180" => "fil blev slettet",
"181" => "Du har ikke tilladelse til at slette denne fil",
"182" => "bibliotket blev slettet",
"183" => "Du har ikke tilladelse til at slette dette bibliotek",
"184" => "biblioteket blev oprettet",
"185" => "Du har ikke tilladelse til at oprettet et bibliotek",
"186" => "Opret bibliotek",

"187" => "bibliotekets navn",
"188" => "opret bib",
"189" => "biblioteket eksiterer allerede, vælg venligst et andet navn",
"190" => "Du skal angive et biblioteks navn",
"191" => "Ændre",
"192" => "Filnavn",
"193" => "ændre fil / biblioteks detaljer",
"194" => "objektet blev omdøbt.",
"195" => "du har ikke tilladelse til at omdøbe dette objekt",
"196" => "Rod stien er ikke correct. Check opsætningen",
"197" => "sorter efter",
"198" => "omdøbning mislykkedes, der findes allerede en fil med det valgte navn",
"199" => "Seneste oploads",
"200" => "Top downloads",
"201" => "omdøbning mislykkedes, navnet er ikke tilladt",

//
// New strings introduced in version 1.02
//
"202" => "Den url du opgav er ikke gyldig",
"203" => "Filens http addresse",
"204" => "Opload filen fra en http addresse",

//
// New strings introduced in version 1.10
//
"205" => "automatisk login",
"206" => "Kan ikke eksekvere: navnet er ikke tilladt",
"207" => "IP addressen er blokeret",
"208" => "Din IP adresse er spærret af administrationen!",
"209" => "Kontakt administratoren for meget information",

//
// New strings introduced in version 1.12
//
"210" => "Daily allowed Mb exceeded",
"211" => "Monthly allowed Mb exceeded",
"212" => "Daily allowed download Mb exceeded",
"213" => "Monthly allowed download Mb exceeded",
"214" => "Validate File",
"215" => "File Validated",
"216" => "Are you sure to delete",
"217" => "you don't have permission to validate that object",
"218" => "This file will be listed only after administration validation",
"219" => "File viewer"
);

//
// Send file e-mail configuration
//
$sendfile_email_subject = 'Ønsket fil';
$sendfile_email_body = '
Her er den fil du bedte om at få tilsendt på mail

';
$sendfile_email_end = 'Venlig hilsen,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Daglig digest";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'Bekræft ny e-mail';
$confirm_email_body = 'Kære %s,

Da din sikkerhed er vigtig for os, er det nødvendigt at få bekræftet din nye e-mail adresse.

Din personlige bekræftelses kode er: %s

Aktivering af din e-mail adresse er simpel:
1. Besøg os på %s og vi vil guide dig igennem processen.
2. Indtast dit brugernavn og bekræftelses kode.
3. Tryk på \'Confirm\' knappen.

';
$confirm_email_end = 'Venlig hilsen,';

//
// Send kodeord e-mail configuration
//
$chpass_email_subject = 'Nyt kodeord';
$chpass_email_body = 'Kære bruger,

Dit nye kodeord er %s

';
$chpass_email_end = 'Venlig hilsen,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Bekræft registration';
$register_email_body = 'Kære %s,

Tak for din registrering.

Da din sikkerhed er vigtig for os, er det nødvendigt at du aktivere din konto ved modtagelsen af denne mail.

Din personlige aktiverings kode er: %s
(Bemærk venligst: Dette er ikke dit kodeord)

Aktivering af din konto er simpel:
1. Besøg os på %s og vi vil guide dig igennem processen.
2. Indtast dit brugernavn og aktiveringskode.
3. Tryk på \'Activate account\' knappen.

';
$register_email_end = 'Venlig hilsen,';
?>
