<?php
/***************************************************************************
* nl.php
* -------------------
* begin : Tuesday', Aug 15', 2002
* copyright : ('C) 2002 Bugada Andrea
* email : phpATM@free.fr
*
* $Id$
*
*
***************************************************************************/

/***************************************************************************
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License', or
* ('at your option) any later version.
*
***************************************************************************/

$headerpage="header.htm";    // The optional header file 
$footerpage="footer.htm";    // The optional footer file 
$infopage="info.htm";        // The optional info file 

$charsetencoding=""; // The encoding for national symbols (i.e. for cyryllic must be "windows-1251")
$uploadcentercaption="PHP Advanced Transfer Manager";
$uploadcentermessage="phpATM";

$mess=array(
"0" => "",
"1" => "Januari",
"2" => "Februari",
"3" => "Maart",
"4" => "April",
"5" => "Mei",
"6" => "Juni",
"7" => "Juli",
"8" => "Augustus",
"9" => "September",
"10" => "Oktober",
"11" => "November",
"12" => "December",
"13" => "Vandaag",
"14" => "Gisteren",
"15" => "Bestandsnaam",
"16" => "Waardering",
"17" => "Grootte",
"18" => "Geupload",
"19" => "Eigenaar",
"20" => "Upload Bestand",
"21" => "Lokaal Bestand",
"22" => "Bestandsbeschrijving",
"23" => "Download",
"24" => "Volgorde",
"25" => "Home",
"26" => "Bestand",
"27" => "Print",
"28" => "Sluiten",
"29" => "Ga terug",
"30" => "Dit bestand is verwijderd",
"31" => "Kan bestand niet openen",
"32" => "Ga terug",
"33" => "Fout bij uploaden bestand!",
"34" => "Je moet een bestand selecteren",
"35" => "Terug",
"36" => "Het bestand",
"37" => "werd succesvol geupload",
"38" => "Bestand met naam",
"39" => "bestaat reeds",
"40" => "Het bestand is succesvol geupload",
"41" => "Taal is succesvol gekozen",
"42" => "Welkom bij PHP A.T.-Manager",
"43" => "Totale Ruimte Opgebruikt",
"44" => "Toon bestanden van alle dagen",
"45" => "Ongeldig ZIP archief!",
"46" => "Archiefinhoud:",
"47" => "Datum/Tijd",
"48" => "Directory",
"49" => "Het is niet toegestaan om het bestand te uploaden met naam %s!",
"50" => "overschrijding maximum toegestane grootte",
"51" => "Informatie",
"52" => "Selecteer Skin",
"53" => "Skin",
"54" => "Welkom",
"55" => "Huidige tijd",
"56" => "Gebruiker",
"57" => "Gebruikersnaam",
"58" => "Registreren",
"59" => "Registratie",
"60" => "Zondag",
"61" => "Maandag",
"62" => "Dinsdag",
"63" => "Woensdag",
"64" => "Donderdag",
"65" => "Vrijdag",
"66" => "Zaterdag",
"67" => "Zend",
"68" => "Mailbestand",
"69" => "Bestand is gemailed naar %s adres.",
"70" => "Bestand geupload door gebruiker: %s",
"71" => "Login",
"72" => "Logout",
"73" => "Enter",
"74" => "Anoniem",
"75" => "Normale Gebruiker",
"76" => "Power Gebruiker",
"77" => "Administrator",
"78" => "Private zone",
"79" => "Publieke zone",
"80" => "Je hebt een onjuiste accountnaam of paswoord ingegeven.",
"81" => "Mijn profiel",
"82" => "Toon/edit mijn profiel",
"83" => "Paswoord",
"84" => "Selecteer taal",
"85" => "Selecteer tijdzone",
"86" => "Uw huidige tijd",
"88" => "Geef een juist emailadres op.",
"89" => "Vergewis jezelf ervan dat je emailadres actief is, want je persoonlijke activatiecode wordt naar je emailadres gezonden.",
"90" => "Bestand geupload: ",
"91" => "Geef het emailadres, dat je hebt opgegeven bij je registratie.",
"92" => "Bestandsgrootte: ",
"93" => "Schrijf je naam en paswoord ergens op",
"94" => "Registratie is verplicht. Registreer!",
"95" => "Registratie is niet nodig. Je kan registreren als je je naam bij je geuploade bestanden wil zien. Niemand anders kan je naam gebruiken om bestanden te uploaden.",

"96" => "Skin geselecteerd.",
"97" => "Vernieuwen",
"98" => "Geef je loginnaam en paswoord",
"99" => "Nog steeds niet geregistreerd? - Registreer hier!",
"100" => "Je paswoord vergeten?",
"101" => "Ga %s terug %s en probeer opnieuw.",
"102" => "Je bent succesvol uitgelogd.",
"103" => "Gebruikersnaam is ongeldig. De naam mag niet langer dan 12 symbolen zijn en mag bestaan uit letters en cijfers. Naam kan ook '-', '_', en spaties bevatten.",
"104" => "De '%s' die je hebt gekozen is al in gebruik.",
"105" => "Bevestig paswoord",
"106" => "Paswoorden zijn niet gelijk.",
"107" => "Het formaat van het ingegeven emailadres is onjuist.",
"108" => "Dank je voor het registreren. Vergeet je paswoord niet daar het gecodeerd in de database wordt weggeschreven en ook wij het niet kunnen achterhalen.",
"109" => "Je kan %s enter het Upload Center hier. %s",
"110" => "Je activatiecode is per email naar je verzonden. Je moet je account binnen 2 dagen activeren of het account wordt automatisch opgeheven.",
"111" => "Je hebt geen rechten om dit bestand te downloaden",
"112" => "Activeer account",
"113" => "Activeer nu je account",
"114" => "Activatiecode",
"115" => "Je account is nu actief.",
"116" => "%s enter hier %s.",
"117" => "De ingegeven accountnaam of activatiecode is onjuist.",
"118" => "Account reeds actief.",
"119" => "Ik wil elke dag gemaild worden over de geuploade bestanden.",
"120" => "Wijzig je paswoord.",
"121" => "Je oude paswoord",
"122" => "De ingegeven accountnaam bestaat niet.",
"123" => "Het ingegeven emailadres is onjuist.",
"124" => "Je nieuwe paswoord is verzonden naar je emailadres.",
"125" => "Kan dit niet uitvoeren! Object niet gevonden",
"126" => "Pas je accountinstellingen aan",
"127" => "Toepassen",
"128" => "Je profiel is opgeslagen.",
"129" => "Je paswoord is gewijzigd.",
"130" => "Je hebt een onjuist oud paswoord ingegeven.",
"131" => "Je moet je nieuwe paswoord opgeven.",
"132" => "Configuratie",
"133" => "Upload",
"134" => "Taal & tijdzone",
"135" => "Accountstatistieken",
"136" => "Je account is aangemaakt:",
"137" => "Gebruikersbeheer",
"138" => "Viewer (alleen lezen)",
"139" => "Uploader (alleen uploaden)",
"140" => "Account '%s' successvol gewijzigd",
"141" => "Laatste",
"142" => "Alle",
"143" => "Nieuw emailadres wordt geldig na bevestiging. Bevestigingscode is gemailed naar je nieuwe emailadres. Zie de instructies in de email.",
"144" => "",
"145" => "Bevestig je nieuw emailadres.",
"146" => "Bevestigingscode",
"147" => "Bevestig",
"148" => "Niets te bevestigen.",
"149" => "De ingegeven accountnaam of bevestigingscode is onjuist.",
"150" => "Je nieuwe emailadres '%s' is bevestigd.",
"151" => "Bestanden geupload",
"152" => "Bestanden gedownload",
"153" => "Bestanden gemailed",
"154" => "Account aangemaakt",
"155" => "Laatste inlogtijd",
"156" => "Status",
"157" => "Actieve status",
"158" => "Onvangst nieuwsbrief",
"159" => "email",
"160" => "Totaal:",
"161" => "Account(s)",
"162" => "Verwijder account",
"163" => "Toon %s account(s) van %s",
"164" => "Configureer Upload Center",
"165" => "Edit bestanden",
"166" => "Edit bestand",
"167" => "Bestand %s is succesvol gewijzigd",
"168" => "Opslaan",
"169" => "Verwijder",
"170" => "Verwijder bestanden",
"171" => "Spiegel",
"172" => "Ja",
"173" => "Nee",
"174" => "Actief",
"175" => "Inactief",
"176" => "Ongerechtigd",
"177" => "Sorry, de server kon het mailprogramma niet uitvoeren.",
"178" => "Je registratie is mislukt. Probeer het later nog eens.",
"179" => "Probeer het later nog eens.",
"180" => "Bestand succesvol verwijderd",
"181" => "Je hebt geen rechten om dit bestand te verwijderen",
"182" => "Directory succesvol verwijderd",
"183" => "Je hebt geen rechten om deze directory te verwijderen",
"184" => "Directory succesvol aangemaakt",
"185" => "Je hebt geen rechten om een directory aan te maken",
"186" => "Maak een nieuwe directory",
"187" => "Directorynaam",
"188" => "Maak directory",
"189" => "Directory bestaat reeds! Geef een andere naam",
"190" => "Je moet een directorynaam opgeven",
"191" => "Verander",
"192" => "Bestandsnaam",
"193" => "Verander bestand / directorydetails",
"194" => "Object succesvol hernoemd.",
"195" => "Je hebt geen rechten om dit object te hernoemen",
"196" => "Het root path is niet correct. Controleer de instellingen",
"197" => "Sorteer volgens",
"198" => "Hernoemen mislukt, bestand bestaat reeds",
"199" => "Laatste uploads",
"200" => "Top downloads",
"201" => "Hernoemen mislukt, naam niet toegestaan",

//
// New strings introduced in version 1.02
//
"202" => "The url die je opgaf is ongeldig",
"203" => "Bestand http adres",
"204" => "Upload bestand via http adres",

//
// New strings introduced in version 1.10
//
"205" => "Blijf altijd aangemeld",
"206" => "Kan dit niet uitvoeren: naam niet toegestaan",
"207" => "ip-adres geblokkeerd",
"208" => "Uw ip-adres werd geblokkeerd door de Administratie!",
"209" => "Voor meer info contacteer de Administratie",

//
// New strings introduced in version 1.12
//
"210" => "Dagelijks toegestane Mb overschreden",
"211" => "Maandelijks toegestane Mb overschreden",
"212" => "Dagelijks toegestane download Mb overschreden",
"213" => "Maandelijks toegestane download Mb overschreden",
"214" => "Valideer bestand",
"215" => "Bestand gevalideerd",
"216" => "Ben u zeker dit te wissen?",
"217" => "U hebt geen toelating om dit object te valideren",
"218" => "Dit bestand zal enkel getoond worden in de lijst na validering van de administratie",
"219" => "Bestandviewer"

);

//
// Send file e-mail configuration
//
$sendfile_email_subject = 'Aangevraagd bestand';
$sendfile_email_body = '
Hier is het door jou aangevraagd bestand per mail

';
$sendfile_email_end = 'Groeten,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Dagelijkse nieuwsbrief";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'Bevestig nieuw emailadres';
$confirm_email_body = 'Beste %s,

Omdat jouw veiligheid belangrijk voor ons is, zal je nieuwe emailadres bevestigd moeten worden na ontvangst.

Je persoonlijke bevestigingscode is: %s

Activering van je emailadres is eenvoudig:
1. Bezoek ons op %s en we zullen je door de procedure loodsen.
2. Geef je accountnaam en bevestigingscode.
3. Klik op de \'Bevestig\' knop.

';
$confirm_email_end = 'Groeten,';

//
// Send password e-mail configuration
//
$chpass_email_subject = 'Nieuw paswoord';
$chpass_email_body = 'Beste gebruiker,

Je nieuwe paswoord is %s

';
$chpass_email_end = 'Groeten,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Bevestig registratie';
$register_email_body = 'Beste %s,

Dank voor je registratie.

Omdat jouw veiligheid belangrijk voor ons is, Zal je account geactiveerd moeten worden na ontvangst.

Je persoonlijke activeringscode is: %s
(let op: dit is niet je paswoord)

Activering van je account is eenvoudig:
1. Bezoek ons op %s en we zullen je door de procedure loodsen.
2. Geef je account naam en activerings code.
3. Klik op de \'Activeer account\' knop.

';
$register_email_end = 'Groeten,';
?>