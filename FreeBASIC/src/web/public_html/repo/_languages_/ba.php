<?php
/***************************************************************************
 *                                   ba.php
 *                            -------------------
 *   begin                : Tuesday', Jul 17', 2004
 *   copyright            : ('C) 2004 bX
 *   email                : buxus_85@hotmail.com
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

$headerpage="include/header.htm";    // The optional header file (can absent)
$footerpage="include/footer.htm";    // The footer file (must present!)
$infopage="include/info.htm";        // The optional info file (can absent)

$charsetencoding="";                 // The encoding for national symbols (i.e. for cyryllic  must be "windows-1251")
$uploadcentercaption="PHP Advanced Transfer Manager";
$uploadcentermessage="phpATM";

$mess=array(
"0" => "",
"1" => "Januar",
"2" => "Februar",
"3" => "Mart",
"4" => "April",
"5" => "Maj",
"6" => "Juni",
"7" => "Juli",
"8" => "August",
"9" => "Septembar",
"10" => "Oktobar",
"11" => "Novembar",
"12" => "Decembar",
"13" => "Danas",
"14" => "Juce",
"15" => "Naziv filea",
"16" => "x Downloadovano",
"17" => "Velicina",
"18" => "Poslato",
"19" => "Vlasnik",
"20" => "Posalji file",
"21" => "Local file",
"22" => "Opis file",
"23" => "Download",
"24" => "Order",
"25" => "Home",
"26" => "File",
"27" => "Print",
"28" => "Zatvori",
"29" => "Nazad",
"30" => "Ovaj file je izbrisan",
"31" => "Nemoguce otvoriti file",
"32" => "Nazad",
"33" => "Greska pri slanju file!",
"34" => "Morate izabrati file",
"35" => "Nazad",
"36" => "File",
"37" => "je supjesno poslan",
"38" => "File sa imenom",
"39" => "vec postoji",
"40" => "File je uspjesno poslan",
"41" => "Uspjesno ste izvrsili poromjenu jezika",
"42" => "bX Maping Community Download Manager",
"43" => "Ukupno iskoristeni prostor",
"44" => "Pokazi sve fajlove",
"45" => "Nevazeci ZIP format!",
"46" => "Sadrzaj formata:",
"47" => "Datum/Vrijeme",
"48" => "Direktorij",
"49" => "It is prohibited to upload file with name %s!",
"50" => "exceeds maximum allowed size",
"51" => "Informacije",
"52" => "Ozaberi Skin",
"53" => "Skin",
"54" => "Dobrodosli",
"55" => "Trenutno vrijeme",
"56" => "Korisnik",
"57" => "Username",
"58" => "Registruj se",
"59" => "Registracija",
"60" => "Nedjelja",
"61" => "Ponedjeljak",
"62" => "Utorak",
"63" => "Srijeda",
"64" => "Cetvrtak",
"65" => "Prtak",
"66" => "Subota",
"67" => "Salji",
"68" => "Posalji file putem maila",
"69" => "File je poslan putem maila na %s adresu.",
"70" => "File poslao: %s",
"71" => "Login",
"72" => "Logout",
"73" => "Enter",
"74" => "Anonymous",
"75" => "Normalni korisnik",
"76" => "Power korisnik",
"77" => "Administrator",
"78" => "Privatna zona",
"79" => "Javna zona",
"80" => "Upisali ste pogresno korisnicko ime ili password.",
"81" => "Moj profil",
"82" => "Pogledaj/uredi moj profil",
"83" => "Password",
"84" => "Izaberi jezik",
"85" => "Izaberi vremensku zonu",
"86" => "Tvoje trenutno vrijeme",
"88" => "Molimo, upisite ispravnu e-mail adresu.",
"89" => "Budite sigurni da je vasa e-mail adresa aktivna, jer ce vas aktivacijski kod biti poslan na vasu e-mail adresu.",
"90" => "Poslan file: ",
"91" => "Molimo, upisite vasu e-mail adresu koju ste upisali tokom vase registracije.",
"92" => "Velicina filea: ",
"93" => "Molimo, upisite vase ime i password",
"94" => "Registracija je neophodna. Molimo, registrujte se.",
"95" => "Registracija nije neophodna. Ako zelite, mozete se registrovati da bi se vase ime pojavilo pored fileova koje ste poslali. Tako niko nece moci koristiti vase ime za slanje vlastitih fileova.",

"96" => "Skin odabran.",
"97" => "Refresh",
"98" => "Molimo, upisite vase podatke: login name i password",
"99" => "Jos niste registrovani? - Registrujte se ovdje!",
"100" => "Zaboravio sam password?",
"101" => "Molimo, idite %s nazad %s i pokusajte ponovo.",
"102" => "Uspjesno ste se izlogali.",
"103" => "Korisnicko ime je nevazece. Ime nesmije biti duze od 12 simbola i jedino moze sadrzati latinske simbole i cifre. Ime takodje moze sadrzati  '-', '_', i razmake (space).",
"104" => "'%s' koje ste trazili je zauzeto.",
"105" => "Potvrdi password",
"106" => "Passwordi se nepodudaraju.",
"107" => "Oblik upisane e-mail adrese je pogresan.",
"108" => "Zahvaljujemo se na registraciji. Molimo, nemojte zaboraviti vas password. Ukoliko zaboravite vas password, omogucavamo vam da koristite skriptu za defaultno generisanje novog passworda koji ce biti poslat na vasu e-mail adresu.",
"109" => "Mozete %s uci u Upload Center ovdje. %s",
"110" => "Vas aktivacijski kod je poslat na vasu e-maile adresu. Morate aktivirati vas racun u toku 2 dana ili ce on u protivnom biti uklonjen.",
"111" => "nemate dozvolu za download ovog filea",
"112" => "Aktiviraj racun",
"113" => "Molimo, aktivirajte vas racun",
"114" => "Kod za aktivaciju",
"115" => "Vas korisnicki racun je aktiviran.",
"116" => "Molimo %s udjite ovdje %s.",
"117" => "Upisano korisnicko ime ili aktivacijski kode je pogresan.",
"118" => "Racun je vec aktiviran.",
"119" => "Zelim da primam svaki dan izvjestaj o uploadovanim fileovima.",
"120" => "Promijenite vas password.",
"121" => "Vas stari password",
"122" => "Upisano korisnicko ime ne postoji.",
"123" => "Upisana e-mail adresa nije vazeca.",
"124" => "Vas nowi pass je poslat na vas e-mail.",
"125" => "nemoze izvrsiti, objekat nije pronadjen",
"126" => "Uredi tvoj korisnicki racun",
"127" => "Prihvati",
"128" => "Vas profil je spasen.",
"129" => "Vas password je zamjenjen.",
"130" => "Upisali ste pogresan stari password.",
"131" => "Morate specifirati vas novi password.",
"132" => "Konfiguracija",
"133" => "Posalji",
"134" => "Jezik i vremenska zona",
"135" => "Statistike racuna",
"136" => "Vas racun je kreiran:",
"137" => "User management",
"138" => "Viewer (samo vidi)",
"139" => "Uploader (samo salji)",
"140" => "Racun '%s' uspjesno izmjenjen",
"141" => "Zadnji",
"142" => "Svi",
"143" => "New e-mail address takes effect after confirmation. Confirmation code has been e-mailed to your new mail address. See instructions inside the letter.",
"144" => "",
"145" => "Please, confirm your new e-mail address.",
"146" => "Potvrda koda",
"147" => "Potvrdi",
"148" => "Nema nista za potvrditi.",
"149" => "Upisano korisnicko ime ili kod za konfirmaciju je pogresan.",
"150" => "Vasa nova e-mail adresa je '%s' potvrdjena.",
"151" => "Uploadovani Fileovi",
"152" => "Downloadovani Fileovi",
"153" => "e-maileovani Fileovi",
"154" => "Racun kreiran",
"155" => "Poslijednji put prijavljen",
"156" => "Status",
"157" => "Active status",
"158" => "Receive digest",
"159" => "e-mail",
"160" => "Ukupno:",
"161" => "Racun(i)",
"162" => "Brisi racun",
"163" => "Prikazani %s racun(i) od %s",
"164" => "Configurisi Upload Centar",
"165" => "Uredi fileove",
"166" => "Uredi file",
"167" => "File %s je uspjesno izmjenjen",
"168" => "Spasi",
"169" => "Brisi",
"170" => "Brisi fileove",
"171" => "Mirror",
"172" => "Da",
"173" => "Ne",
"174" => "Activan",
"175" => "Neaktivan",
"176" => "Neovlasten",
"177" => "Sorry, but server could not execute the mail program.",
"178" => "Your registration failed. Please, try again later.",
"179" => "Molimo, pokusajte opet kasnije.",
"180" => "file uspjesno izbrisan",
"181" => "nemate dozvolu za brisanje ovoga filea",
"182" => "directori uspjesno izbrisan",
"183" => "nemate dozvolu za pristup ovom directoriju",
"184" => "directori uspjesno napravljen",
"185" => "nemate dozvolu za kreiranje novog directorija",
"186" => "Kreiraj novi directori",
"187" => "Ime Directorija",
"188" => "Napravi dir",
"189" => "directori sa tim imenom vec postoji, molimo izaberite drugo ime",
"190" => "you must specify a directory name",
"191" => "Uredi",
"192" => "Ime filea",
"193" => "Uredi file / detalji directorija",
"194" => "objekt uspjesno preimenovan.",
"195" => "nemate dozvolu za promjenu imena tog objekta",
"196" => "Root path je neispravan. Pogledajte u settingsima",
"197" => "Poredaj po",
"198" => "zamjena imena nevazeca, file sa tim imenom vec postoji",
"199" => "Poslijednji uploadi",
"200" => "Top downloadi",
"201" => "rename failed, name not allowed",

//
// New strings introduced in version 1.02
//
"202" => "URL koji ste koristini nije validan",
"203" => "HTTP adresa file",
"204" => "Upload file putem http adrese",

//
// New strings introduced in version 1.10
//
"205" => "Ostani stalno logiran",
"206" => "Can't execute: name not allowed",
"207" => "IP adresa blokirana",
"208" => "Vasa IP adresa je blokirana od strane Administratora!",
"209" => "Za vise informacija kontaktirajte Administratora",

//
// New strings introduced in version 1.12
//
"210" => "Dnevna dozvoljena potrosenja Mb",
"211" => "Mjesecno dozvoljena potrosenja Mb",
"212" => "Dnevna dozvoljena download potrosenja Mb",
"213" => "Mjesecno dozvoljena download potrosenja Mb",
"214" => "Ucini File vazecim",
"215" => "Validacija Filea",
"216" => "Jeste li sigurni da zelite obrisati",
"217" => "nemate dozvolu da ucinite vallidnim taj object",
"218" => "Ovaj file ce biti u listi downloada tek kada ga prihvati administrator",
"219" => "File viewer"

);

//
// Send file e-mail configuration
//
$sendfile_email_subject = 'Requested file';
$sendfile_email_body = '
Here the file you requested by mail

';
$sendfile_email_end = 'Pozdravi,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Svakodnevne posiljke";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'Potvrdi novi e-mail';
$confirm_email_body = 'Postovani %s,

Posto nam je vasa sigurnost na prvom mijestu, vasa nova e-mail adresa treba biti potvrdjenasa vase strane.

Vas vlastiti kod za konfirmaciju je: %s

Aktivacija e-mail adrese je sasvim jednostavna:
1. Posjetite nas na %s i mi cemo vas provesti kroz proces registracije
2. Upisite vase korisnicko ime i kod za konfirmaciju.
3. Kliknite na \'Potvrdi\' link.

';
$confirm_email_end = 'Pozdravi,';

//
// Send password e-mail configuration
//
$chpass_email_subject = 'Novi password';
$chpass_email_body = 'Postovani korisnice,

Tvoj novi password je %s

';
$chpass_email_end = 'Pozdravi,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Potvrdi registraciju';
$register_email_body = 'Postovani %s,

Zahvaljujemo vam na registraciji.

Posto nam je vasa sigurnost na prvom mijestu, vas racun treba biti aktiviran sa vase strane.

Vas vlastiti kod za konfirmaciju je: %s
(zabiljeska: ovo nije vas password - sifra)

Aktivacija vaseg racuna je sasvim jednostavna:
1. Posjetite nas na %s i mi cemo vas provesti kroz proces registracije
2. Upisite vase korisnicko ime i kod za konfirmaciju.
3. Kliknite na \'Potvrdi\' link.


';
$register_email_end = 'Pozdravi,';
?>
