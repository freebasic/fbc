<?php
/***************************************************************************
 *                                   sh.php
 *                            -------------------
 *   begin                : Tuesday', Aug 15', 2002
 *   copyright            : ('C) 2002 Bugada Andrea
 *   email                : phpATM@free.fr
 *
 *   $Id$
 *
 *   Preveo Batalo Zarko www.technomarket@gmx.at
 *               www.technomarket@gmx
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
"15" => "Sadrzaj",
"16" => "Menadzer",
"17" => "Velicina",
"18" => "Dodato",
"19" => "Info",
"20" => "Upload Fajl",
"21" => "Lokalni Fajl",
"22" => "Opis Fajla",
"23" => "Download",
"24" => "Sortiraj",
"25" => "Pocetak",
"26" => "Fajl",
"27" => "Stampaj",
"28" => "Zatvori",
"29" => "Nazad",
"30" => "Fajl je Dodat/Obrisan",
"31" => "Greska !!! Nemoze da otvori fajl",
"32" => "Nazad",
"33" => "Greska pri uploadu!",
"34" => "Morate da izaberete jedan fajl",
"35" => "Nazad",
"36" => "Fajl",
"37" => "je uspesno uploadovan",
"38" => "Fajl sa imenom",
"39" => "vec postoji",
"40" => "Fajl je uspesno uploadovan",
"41" => "Jezik je uspesno izabran",
"42" => "Dobrodosli na .::WWW.VASAHOMEPAGE.COM::.",
"43" => "Ukupno iskoristen web prostor",
"44" => "Prikazi sve fajlove",
"45" => "Defektna ZIP Arhiva!",
"46" => "Sadrzaj arhive:",
"47" => "Datum/Vreme",
"48" => "Folder",
"49" => "Uploadovanje fajlova sa ovim imenom ( %s ) je zabranjeno!",
"50" => "Dozvoljena velicina fajla je prekoracena",
"51" => "Informacija",
"52" => "Izaberi Skin",
"53" => "Skin",
"54" => "Dobrodosli",
"55" => "Vreme:",
"56" => "Korisnik",
"57" => "Korisnicko Ime",
"58" => "Registruj Me",
"59" => "Registracija",
"60" => "Nedelja",
"61" => "Ponedeljak",
"62" => "Utorak",
"63" => "Sreda",
"64" => "Cetvrtak",
"65" => "Petak",
"66" => "Subota",
"67" => "Posalji",
"68" => "Posalji Fajl na e-Mail",
"69" => "Fajl je poslat na sledecu e-Mail adresu %s ",
"70" => "Fajl uploadovao korisnik: %s ",
"71" => "PRIJAVA",
"72" => "ODJAVA",
"73" => "ULAZ",
"74" => "Anonymous",
"75" => "Stadardni Korisnik",
"76" => "Power Korisnik",
"77" => "Administrator",
"78" => "Privatna Zona",
"79" => "Javna Zona",
"80" => "Upisali ste nevazece Korisnicko Ime ili Liozinku.",
"81" => "Moj Profil",
"82" => "Pogledaj/Prepravi moje profile",
"83" => "Lozinka",
"84" => "Odaberi Jezik",
"85" => "Odaberi Vremensku Zonu",
"86" => "Vase Vreme:",
"88" => "Molimo vas, upisite vazecu E-Mail adresu.",
"89" => "Jer ce vam Aktivacioni Kod pomocu kog ce te aktivirati vas Acount biti poslat na e-mail.",
"90" => "Fajl uploadovan: ",
"91" => "Upisite vasu E-Mail adresu, koju ste upisali prilikom registracije.",
"92" => "Velicina Fajla: ",
"93" => "Molimo vas zapisite negde vase Korisnicko Ime i Lozinku",
"94" => "Potrebna je Registracija! Molimo vas registrujte se.",
"95" => "Registracija nije potrebna.",

"96" => "Skin je odabran.",
"97" => "Refresh",
"98" => "Molimo vas upisite vase Korisnicko Ime i Lozinku",
"99" => "Jos niste registrovani? - Registruj se ovde!",
"100" => "Zaboravili ste lozinku?",
"101" => "Molimo vas, idite %s NAZAD %s i pokusajte ponovo.",
"102" => "Uspesno ste se odjavili.",
"103" => "Korisnicko Ime je suvise dugacko !!! Korisnicko Ime Sme da se sastoji od maksimalno 12 znakova (Slova I Brojeva)",
"104" => "Ime '%s' koje ste zahtevali je nazalost vec uzeto.",
"105" => "Potvrdi Lozinku",
"106" => "Lozinke koje ste upisali nisu identicne (Ne podudaraju se).",
"107" => "E-Mail adresa koju ste upisali je pogresna.",
"108" => "Hvala na registraciji,vas aktivacioni kod vam je poslat na E-Mail adresu.",
"109" => "Ovde mozete da udjete na  %s DOWNLOAD. %s",
"110" => "Morate da aktivirate vas Acount u roku od dva dana inace ce biti automatski obrisan.VAZNO !!! Morate dobro da zapamtite vasu lozinku i podatke jer svi ovi podaci si kriptuju tako da vam mi ne mozemo pomoci ako ih zaboravite jer ih mi sami takodje ne znamo,cim se prvi put ulogujete na stranicu te podatke mozete da promenite npr:lozinku,e-mail adresu itd",
"111" => "Vi nemate ovlascenja da downloadujete ovaj fajl",
"112" => "Aktiviraj Acount",
"113" => "Molimo vas,Aktivirajte vas Acount",
"114" => "Aktivacioni Kod",
"115" => "Vas Acount je aktiviran.",
"116" => "Ovde mozete da udjete na %s DOWNLOAD %s ",
"117" => "Upisano Aktivaciono Ime ili Kod su pogresni.",
"118" => "Ovaj Acount je vec aktiviran.",
"119" => "Newsletter",
"120" => "Promeni Lozinku.",
"121" => "Vasa Trenutna Lozinka",
"122" => "Upisani Acount ne postoji.",
"123" => "Upisana E-Mail adresa je pogresna.",
"124" => "Vasa nova Lozinka vam je poslata na E-Mail.",
"125" => "Ne moze da izvrsi naredbu, podatak nije nadjen.",
"126" => "Prepravite vasa licna stelovanja (Profile).",
"127" => "Promeni",
"128" => "Vasi profili su memorisani.",
"129" => "Vasa lozinka je promenjena.",
"130" => "Greska !!! Upisali ste pogresnu staru Lozinku.",
"131" => "Greska !!! Morate da odredite vasu novu Lozinku.",
"132" => "Konfiguracija",
"133" => "Upload",
"134" => "Jezik & Vremenska Zona",
"135" => "Acount Statistike",
"136" => "Vas Acount je napravljen:",
"137" => "Statistike/Stelovanja",
"138" => "Posmatrac (samo pregled)",
"139" => "Uploader (samo upload)",
"140" => "Acount '%s' je uspesno promenjen/prepravljen.",
"141" => "Zadnji",
"142" => "Svi",
"143" => "Nova E-Mail adresa ce tek posle aktiviranja biti aktivna. Aktivacioni Kod vam je poslat na novu E-Mail adresu.Pratite dalje upustva koja ste dobili na E-Mail.",
"144" => "",
"145" => "Molimo vas,potvrdite vasu novu E-Mail adresu.",
"146" => "Potvrdni Kod",
"147" => "Potvrdjujem",
"148" => "Odustajem.",
"149" => "Greska !!! Upisani Acount ili aktivacioni Kod su pogresni.",
"150" => "Vasa nova E-Mail adresa je  '%s' potvrdjena.",
"151" => "Vas ukupan broj uploada koji ste imali",
"152" => "Vas ukupan broj downloada koji ste imali",
"153" => "Fajlovi poslati na E-Mail",
"154" => "Acount Kreiran",
"155" => "Zadnji Pristup",
"156" => "Status",
"157" => "Aktiv status",
"158" => "Poslatih E-Mail_a",
"159" => "E-Mail",
"160" => "Ukupno:",
"161" => "Clana/Clanova",
"162" => "Obrisi Acount",
"163" => "Prikazi %s Clanove od %s",
"164" => "Konfiguriraj Opcije",
"165" => "Prepravi Fajlove",
"166" => "Prepravi Fajl",
"167" => "Fajl %s je uspesno promenjen/prepravljen",
"168" => "Memorisi",
"169" => "Obrisi",
"170" => "Obrisi Fajlove",
"171" => "Mirror",
"172" => "Da",
"173" => "Ne",
"174" => "Activan",
"175" => "Neaktivan",
"176" => "Neovlascen",
"177" => "Izvinjavamo se,Nas Server nije mogao da izvrsi zahtevani E-Mail program.",
"178" => "Vasa Registracija je neuspesna.Molimo vas probajte malo kasnije.",
"179" => "Molimo vas pokusajte malo kasnije jos jednom.",
"180" => "Fajl je uspesno obrisan",
"181" => "Vi nemate ovlascenja da obrisete ovaj fajl",
"182" => "Folder uspesno obrisan",
"183" => "Vi nemate ovlascenja da obrisete ovaj folder",
"184" => "Folder je uspesno kreiran",
"185" => "Vi nemate ovlascenja da kreirate jedan folder",
"186" => "Kreiraj Folder",
"187" => "Ime Foldera",
"188" => "Napravi Folder",
"189" => "Folder sa tim imenom vec postoji, Molimo vas dajte mu neko drugo ime",
"190" => "Morate da izaberete jedan folder",
"191" => "Prepravi/Promeni",
"192" => "Fajl",
"193" => "Prepravi/Promeni Fajl / Folder detalji",
"194" => "Objekt je uspesno preimenovan.",
"195" => "Vi ne posedujte ovlascenja za promenu imena",
"196" => "Glavni folder je pogresan. Proverite stelovanja",
"197" => "Sortiraj",
"198" => "Preimenovanje neuspesno, fajl vec postoji pod tim imenom",
"199" => "ZADNJI UPLOADI",
"200" => "TOP DOWNLOADS",
"201" => "Preimenovanje neuspesno, Ime nije dozvoljeno",

//
// New strings introduced in version 1.02
//
"202" => "URL adresa koju ste upisali je pogresna",
"203" => "Http Adresa fajla",
"204" => "Upload fajla preko jedne http adrese",

//
// New strings introduced in version 1.10
//
"205" => "Zapamti Me",
"206" => "Greska: Nedozvoljeno Ime",
"207" => "IP Adresa Blokirana",
"208" => "Administrator je blokirao vasu IP Adresu!",
"209" => "Za dodatne informacije se obratite administratoru",

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
$sendfile_email_subject = 'Zahtevani Fajl';
$sendfile_email_body = '
Ovde je fajl koji ste hteli da dobijete na E-Mail

';
$sendfile_email_end = 'Pozdrav,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Mailing Lista";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'Potvrdjujem novu E-Mail adresu';
$confirm_email_body = 'Zdravo %s,

Iz sigurnosnih razloga morate da potvrdite vasu E-Mail adresu.Molimo vas pratite upustva.

Vas Licni Aktivacioni Kod je: %s

Aktiviranje nove E-Mail adrese je jednostavno:
1. Posetite nas Ovde %s i bicete dalje vodjeni jednostavnim citanjem upustva.
2. Upisite vase Korisnicko Ime i Aktivacioni Kod.
3. Kliknite na Dugme. \'Confirm\'

';
$confirm_email_end = 'Pozdrav,';

//
// Send password e-mail configuration
//
$chpass_email_subject = 'Nova Lozinka';
$chpass_email_body = 'Postovani Korisnice,

Vasa nova Lozinka glasi: %s

';
$chpass_email_end = 'Pozdrav,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Potvrdjujem Registraciju';
$register_email_body = 'Zdravo %s,

Hvala na Registraciji.

Vasa sigurnost je za nas isto toliko vazna kao i za vas same, zbog toga aktivirajte vas Acount.

Vas licni Aktivacioni Kod glasi: %s
(OBRATITE PAZNJU: OVO NIJE VASA LOZINKA !!!)

Aktiviranje vaseg Acounta je jednostavno:
1. Posetite nas ovde %s i bicete dalje vodjeni jednostavnim citanjem upustva.
2. Upisite vase Korisnicko Ime i Aktivacioni Kod.
3. Kliknite na Dugme. \'Account aktivieren\'

';
$register_email_end = 'Pozdrav,';
?>
