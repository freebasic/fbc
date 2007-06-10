<?php
/***************************************************************************
 *                                   de.php
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
"3" => "März",
"4" => "April",
"5" => "May",
"6" => "Juni",
"7" => "July",
"8" => "August",
"9" => "September",
"10" => "Oktober",
"11" => "November",
"12" => "Dezember",
"13" => "Heute",
"14" => "Gestern",
"15" => "Dateiname",
"16" => "Rating",
"17" => "Größe",
"18" => "Uploaded",
"19" => "Besitzer",
"20" => "Upload Datei",
"21" => "Locale Datei",
"22" => "Datei Beschreibung",
"23" => "Download",
"24" => "Verlange",
"25" => "Home",
"26" => "Datei",
"27" => "Drucke",
"28" => "Schließe",
"29" => "Gehe zurück",
"30" => "Diese Datei wurde ersetzt",
"31" => "Kann Datei nicht öffnen",
"32" => "Gehe zurück",
"33" => "Fehler bei Datei Upload!",
"34" => "Sie müssen eine Datei auswählen",
"35" => "Zurück",
"36" => "Die Datei",
"37" => "wurde erfolgreich upgeloaded",
"38" => "Datei mit Namen",
"39" => "besteht bereits",
"40" => "Die Datei wurde erfolgreich upgeloaded",
"41" => "Die Sprache wurde erfolgreich ausgewählt",
"42" => "Wilkommen bei PHP Advanced Transfer Manager",
"43" => "Speicherplatz belegt",
"44" => "Zeige alle Dateien",
"45" => "Defecktes ZIP Archive!",
"46" => "Archive Inhalte:",
"47" => "Datum/Zeit",
"48" => "Ordner",
"49" => "Es ist verboten Dateien mit diesem Namen ( %s ) hochzuladen!",
"50" => "erlaubte Dateigröße überschritten",
"51" => "Information",
"52" => "Wähle Skin",
"53" => "Skin",
"54" => "Wilkommen",
"55" => "Zeit:",
"56" => "Benutzer",
"57" => "Username",
"58" => "Register",
"59" => "Registration",
"60" => "Sonntag",
"61" => "Montag",
"62" => "Dienstag",
"63" => "Mittwoch",
"64" => "Donnerstag",
"65" => "Freitag",
"66" => "Samstag",
"67" => "Sende",
"68" => "Verschicke Datei",
"69" => "Datei wurde an diese Adresse %s versendet. ",
"70" => "Datei wurde von %s hochgeladen",
"71" => "Login",
"72" => "Logout",
"73" => "Enter",
"74" => "Anonymous",
"75" => "Normal User",
"76" => "Power User",
"77" => "Administrator",
"78" => "Private Zone",
"79" => "Öffentliche zone",
"80" => "Sie Haben einen ungültigen Accountnamen oder ein ungültiges Passwort eingegeben.",
"81" => "Mein Profil",
"82" => "Zeige/verändere mein Profil",
"83" => "Passwort",
"84" => "Wähle Sprache",
"85" => "Wähle Zeitzone",
"86" => "Ihre Zeit:",
"88" => "Bitte geben sie eine gültige emailadresse an.",
"89" => "Seien sie sicher das ihre E-mail Adresse gültig ist, ihr Aktivierungscode wurde ihnen zugesannd.",
"90" => "Datei uploaded: ",
"91" => "Geben sie bitte die E-mail Adresse an die sie bei der Registration verwendet haben.",
"92" => "Datei Größe: ",
"93" => "Bitte merken sie sich ihr Passwort und den Benutzernamen",
"94" => "Registration ist nötig! Bitte registrieren.",
"95" => "Registration ist nicht nötig.",

"96" => "Skin ausgewählt.",
"97" => "Aktualisiere",
"98" => "Bitte geben sie ihren Loginnamen und Passwort ein",
"99" => "Immer noch nicht angemeldet? - Hier gehts zur Registration!",
"100" => "Passwort vergessen?",
"101" => "Bitte, gehen sie %s zurück %s und versuchen sie erneut.",
"102" => "Sie wurden erfolgreich ausgelogt.",
"103" => "Der Benutzername ist zu lang, er darf höchsten zwölf Zeichen haben.",
"104" => "Die '%s' die sie ausgesucht haben wurde entfernt.",
"105" => "Bestätige Passwort",
"106" => "Die Passwörter sind nicht identisch.",
"107" => "Das Format der angegeben E-mail Adresse ist falsch.",
"108" => "Vielen Dank für die Registration ihr Aktivierungscode wurde ihnen zugesandt.",
"109" => "Sie können %s den Upload Center hier betreten. %s",
"110" => "Ihr Aktivierungscode wurde ihnen zugesandt.Sie müssen ihren Account innerhalb von 2 Tagen aktivieren sonst wird er automatish gelöscht.",
"111" => "Ihnen fehlen die Rechte um diese Datei runter zu laden",
"112" => "Account aktivieren",
"113" => "Bitte aktivieren sie ihren Account",
"114" => "Aktivierungscode",
"115" => "Ihr Account ist nun freigeschaltet.",
"116" => "Bitte %s treten sie hier %s ein.",
"117" => "Der eingegebene Account oder Aktivierungscode ist fehlerhaft.",
"118" => "Dieser Account ist bereits aktiv.",
"119" => "Ich möchte gerne den Newsletter über die neuen Dateien erhalten.",
"120" => "Ändern sie ihr Passwort.",
"121" => "Ihr altes Passwort",
"122" => "Der eingegebene Account existiert nicht.",
"123" => "Die eingegebene E-mail Adresse ist falsch.",
"124" => "Ihr neues Passwort wurde ihnen per E-mail zu geschickt.",
"125" => "Kann Befehl nicht ausführen, Datei nicht gefunden.",
"126" => "Passen sie ihre Accountdaten an.",
"127" => "Ausführen",
"128" => "Ihr Profil wurde gespeicher.",
"129" => "Ihr Passwort wurde geändert.",
"130" => "Sie haben ein falsches, altes Passwort eingegeben.",
"131" => "Sie müssen ihr neues Passwort spezifizieren.",
"132" => "Configuration",
"133" => "Upload",
"134" => "Sprache & Zeitzone",
"135" => "Account Statistiken",
"136" => "Ihr Account wurde erstellt:",
"137" => "Benutzer Management",
"138" => "Viewer (nur Anzeige)",
"139" => "Uploader (nur upload)",
"140" => "Account '%s' wurde erfolgreich geändert.",
"141" => "Letzten",
"142" => "Alle",
"143" => "Die Neue Email Adresse wird erst nach der Freischaltung aktiv. Freischaltcode wurde ihnen an ihre neue E-mail Adresse zugeschickt.Folgen sie den Anweisungen in der Mail.",
"144" => "",
"145" => "Bitte, bestätigen sie ihre neue E-mail Addresse.",
"146" => "Bestätigungscode",
"147" => "Bestätige",
"148" => "Nichts zu bestätigen.",
"149" => "Der eingegebene Account oder Aktivierungscode ist fehlerhaft.",
"150" => "Ihre neue E-mail Adresse  '%s' wurde bestätigt.",
"151" => "Dateien upgeloaded",
"152" => "Dateien downgeloaded",
"153" => "Dateien gemailed",
"154" => "Account erstellt",
"155" => "Letzer Zugriff",
"156" => "Status",
"157" => "Aktiver status",
"158" => "Erhalte Newsletter",
"159" => "e-mail",
"160" => "Total:",
"161" => "Account(s)",
"162" => "Lösche Account",
"163" => "Zeige %s Account(s) von %s",
"164" => "Stelle den Upload Center ein",
"165" => "Verändere Dateien",
"166" => "Verändere Datei",
"167" => "Die Datei %s wurde erfolgreich verändert",
"168" => "Speichere",
"169" => "Lösche",
"170" => "Lösche Dateien",
"171" => "Mirror",
"172" => "Ja",
"173" => "Nein",
"174" => "Active",
"175" => "Inactive",
"176" => "Unautorisiert",
"177" => "Entschuldigen sie,der Server konnte das E-mail Program nicht ausführen.",
"178" => "Ihre Registration ist Fehlgeschlagen.Bitte versuchen sie es später erneut.",
"179" => "Bitte versuchen sie es später nocj einmal.",
"180" => "Datei erfolgreich gelöscht",
"181" => "Sie haben keine Rechte diese Datei zu löschen",
"182" => "Verzeichniss erfolgreich gelöscht",
"183" => "Sie haben keine Rechte dieses Verzeichnis zu löschen",
"184" => "Das Verzeichnis wurde erfolgreich erstellt",
"185" => "Sie haben keine Rechte ein Verzeichnis zu erstellen",
"186" => "Ein neues Verzeichnis erstellen",
"187" => "Verzeichnis Name",
"188" => "Erstelle Verzeichnis",
"189" => "Das Verzeichnis besteht bereits, bitte wählen sie einen anderen Namen",
"190" => "Sie müssen einen Verzeichnisnamen wählen",
"191" => "Verändere",
"192" => "Dateiname",
"193" => "Verändere Datei / Verzeichnis Details",
"194" => "Objekt wurde erfolgreich umbenannt.",
"195" => "sie haben keine Rechte das Objakt umzubenennen",
"196" => "Das Stammverzeichniss ist nicht korrekt. Checken sie die Einstellungen",
"197" => "Bestellt von",
"198" => "Umbenennen fehlgeschlagen, Datei existiert bereits",
"199" => "Die letzten Uploads",
"200" => "Top Downloads",
"201" => "Umbenennen fehlgeschlagen, der Name ist nicht erlaubt",

//
// New strings introduced in version 1.02
//
"202" => "Die URL die sie angaben ist falsch",
"203" => "Http Adresse der Datei",
"204" => "Uploade eine Datei über eine http Addresse",

//
// New strings introduced in version 1.10
//
"205" => "Always stay logged",
"206" => "Can't execute: name not allowed",
"207" => "ip blocked",
"208" => "Your ip has been blocked by Administration!",
"209" => "To obtain more infos contact the Administrator",

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
$sendfile_email_subject = 'Angeforderte Datei';
$sendfile_email_body = '
Hier ist die Datei die sie via E-mail erhalten wollten

';
$sendfile_email_end = 'Grüße,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Newsletter";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'Bestätige neue E-mail Adresse';
$confirm_email_body = 'Hallo %s,

Aus Sicherheitsgründen müssen sie ihre neue E-mail Adresse bestätigen.Bitte folgen sie den Anweisungen.

Ihr persönlicher Aktivierungscode lautet: %s

Die Aktivierung der neuen E-mail Adresse ist einfach:
1. Besuchen sie uns hier %s und sie werden durch den Prozess geleitet
2. Geben sie ihren Account namen und den Aktivierungscode ein.
3. Klicken sie auf den \'Confirm\' Button.

';
$confirm_email_end = 'Grüße,';

//
// Send password e-mail configuration
//
$chpass_email_subject = 'Neues Passwort';
$chpass_email_body = 'Lieber Benutzer,

Ihr neues Passwort lautet: %s

';
$chpass_email_end = 'Grüße,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Bestätige Registration';
$register_email_body = 'Hallo %s,

Vielen Dank für die Registration.

Ihre Sicherheit ist für uns genauso wichtig wie für Sie, deshalb aktivieren sie ihren Account.

Ihr persönlicher Aktivierungscode lautet: %s
(Bitte Beachten: DIES IST NICHT IHR PASSWORT !!!)

Die Aktivierung des Accounts ist einfach:
1. Besuchen sie uns auf %s und wir werden sie durch den Prozess begleiten.
2. Geben sie ihren Account und den Aktivierungscode ein.
3. Klicken sie auf den \'Account aktivieren\' Button.

';
$register_email_end = 'Grüße,';
?>