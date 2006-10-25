<?php
/***************************************************************************
 *                                   si.php
 *                            -------------------
 *   begin                : Wednesday', Sept 26', 2002
 *   copyright            : ('C) 2002 Stane Accetto
 *   email                : stane.accetto@siol.net
 *	 URL                  : http://stane.saax.com

 *   $Id$
 *
 *	 Nota! Skripta pripada: Bugada Andrea, moj je samo prevod.
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

$charsetencoding="windows-1250";                 // The encoding for national symbols (i.e. for cyryllic  must be "windows-1251")
$uploadcentercaption="PHP Advanced Transfer Manager";
$uploadcentermessage="phpATM";

$mess=array(
"0" => "",
"1" => "Januar",
"2" => "Februar",
"3" => "Marc",
"4" => "April",
"5" => "Maj",
"6" => "Junij",
"7" => "Julij",
"8" => "Avgust",
"9" => "September",
"10" => "Oktober",
"11" => "November",
"12" => "December",
"13" => "Danes",
"14" => "Vèeraj",
"15" => "Datoteka",
"16" => "Uvrstitev",
"17" => "Velikost",
"18" => "Naloženo",
"19" => "Lastnik",
"20" => "Naloži datoteko",
"21" => "Lokalna datoteka",
"22" => "Opis datoteke",
"23" => "Download",
"24" => "Order",
"25" => "Domov",
"26" => "Datoteka",
"27" => "Natisni",
"28" => "Zapri",
"29" => "Pojdi nazaj",
"30" => "Ta datoteka je bila odstranjena",
"31" => "Ne morem odpreti datoteke",
"32" => "Pojdi nazaj",
"33" => "Napaka pri nalaganju!",
"34" => "Morate izbrati datoteko",
"35" => "Nazaj",
"36" => "Datoteka",
"37" => "je bila uspešno naložena",
"38" => "Datoteka z imenom",
"39" => "že obstoja",
"40" => "Datoteka je bila uspešno naložena",
"41" => "Izbira jezika je bila uspešna",
"42" => "Dobrodošli v  PHP Advanced Transfer Manager",
"43" => "Skupno uporabljen prostor",
"44" => "Prikaži vse datoteke po datumu",
"45" => "Neveljavna ZIP datoteka!",
"46" => "Vsebina datoteke:",
"47" => "Datum/Èas",
"48" => "Mapa",
"49" => "Prepovedano je naložiti datoteko z imenom %s!",
"50" => "dovoljena velikost je presežena",
"51" => "Informacija",
"52" => "Izberi Skin",
"53" => "Skin",
"54" => "Dobrodošel",
"55" => "Trenutni èas",
"56" => "Uporabnik",
"57" => "Uporabniško ime",
"58" => "Registriraj se",
"59" => "Registracija",
"60" => "Nedelja",
"61" => "Ponedeljek",
"62" => "Torek",
"63" => "Sreda",
"64" => "Èetrtek",
"65" => "Petek",
"66" => "Sobota",
"67" => "Pošlji",
"68" => "Pošlji datoteko",
"69" => "Datoteka je bila poslana na naslov %s .",
"70" => "Datoteko je naložil uporabnik: %s",
"71" => "Login",
"72" => "Zakljuèi",
"73" => "Vstopi",
"74" => "Anonimni uporabniks",
"75" => "Normalni uporabnik",
"76" => "Napredni uporabnik",
"77" => "Administrator",
"78" => "Osebno podroèje",
"79" => "Javno podroèje",
"80" => "Vpisali ste neveljavno ime raèuna ali geslo.",
"81" => "Moj profil",
"82" => "Vpogled/spreminjanje profila",
"83" => "Geslo",
"84" => "Izberi jezik",
"85" => "Izberi èasovno cono",
"86" => "Vaš tekoèi èas",
"88" => "Prosim, vnesi veljavni E-Mail naslov.",
"89" => "Vaš E-Mail naslov mora biti veljaven, ker vam bo na ta naslov poslana osebna aktivacijska koda",
"90" => "Datoteka je bila naložena: ",
"91" => "Prosim, vnesite vaš E-Mail naslov, katerega ste vpisali ob registraciji.",
"92" => "Velikost datoteke: ",
"93" => "Prosim, zapišite si vaše ime in geslo",
"94" => "Registracija je obvezna. Prosim, da se registrirate.",
"95" => "Registracija ni potrebna. Èe želite, da se vaše ime pojavi poleg naložene datoteke, potem se registrirajte. Nihèe drug ne bo mogel uporabljati vašega imena.",

"96" => "Skin je bil izbran.",
"97" => "Osveži",
"98" => "Prosim, vpišite svoje ime in geslo",
"99" => "Še vedno niste registrirani? - Registrirajte se tu!",
"100" => "Ste pozabili vaše geslo?",
"101" => "Prosim, pojdite %s nazaj %s in znova poskusite.",
"102" => "Uspešno ste se izkljuèili.",
"103" => "Ime uporabnika je neveljavno. Ime ne sme biti daljše od 12 èrk, lahko vsebuje latinske simbole / brez šumnikov/ in številke. Ime lahko vsebuje tudi '-', '_', in space simbol.",
"104" => "Ime '%s' je že zasedeno.",
"105" => "Potrdi geslo",
"106" => "Gesli se ne ujemata.",
"107" => "Vnešena oblika E-Mail naslova je neveljavna.",
"108" => "Hvala, da ste se registrirali. Prosim, ne pozabite svojega gesla, ker je to šifrirano in vam ga ne moremo posredovati. V primeru, da ste ga pozabili, lahko uporabite program, kateri vam bo nakljuèno doloèil novo geslo in ga boste prejeli po E-Mailu.",
"109" => "Tukaj %s lahko vstopite v Upload Center. %s",
"110" => "Vaša aktivacijska koda vam je bila poslana po E-Mailu. Vaš raèun morate aktivirati v roku 2 dni, ker bo v nasprotnem primeru avtomatièno odstranjen.",
"111" => "nimate pravice za download te datoteke",
"112" => "Aktiviranje raèuna",
"113" => "Prosim, aktivirajte vaš raèun",
"114" => "Aktivacijska koda",
"115" => "Vaš raèun je sedaj aktiven.",
"116" => "Prosim %s tu vstopite %s.",
"117" => "Vnešeno ime raèuna ali aktivacijska koda je neveljavno.",
"118" => "Raèun je že aktiven.",
"119" => "Dnevno želim prejemati pregled naloženih datotek po E-Mailu.",
"120" => "Spreminjanje gesla.",
"121" => "Staro geslo",
"122" => "Vnešeno ime raèuna ne obstoja.",
"123" => "Vnešeni e-mail naslov je neveljaven.",
"124" => "Novo geslo vam je bilo poslano po E-Mailu.",
"125" => "ne morem izvršiti, predmet ni najden",
"126" => "Spreminjanje nastavitev vašega raèuna",
"127" => "Uporabi",
"128" => "Vaš profil je bil shranjen.",
"129" => "Vaše geslo je bilo spremenjeno.",
"130" => "Vpisali ste neveljavno staro geslo.",
"131" => "Vpisati morate vaše novo geslo.",
"132" => "Nastavitve",
"133" => "Naloži",
"134" => "Jezik & èasovni pas",
"135" => "Statistika raèuna",
"136" => "Vaš raèun je bil ustvarjen:",
"137" => "Upravljanje uporabnikov",
"138" => "Obiskovalec (samo vpogled)",
"139" => "Naložitelj (samo nalaganje)",
"140" => "Raèun '%s' je bil uspešno spremenjen",
"141" => "Zadnji",
"142" => "Vsi",
"143" => "Novi E-Mail naslov bo veljaven šele s potrditvijo. Potrditvena koda vam je bila poslana na vaš novi E-mail naslov. Poglejte navodila v sporoèilu.",
"144" => "",
"145" => "Prosim, potrdite vaš novi E-Mail naslov.",
"146" => "Potrditvena koda",
"147" => "Potrdi",
"148" => "Niè ni potrjeno.",
"149" => "Vnešeno ime raèuna ali potrditvena koda je neveljavno.",
"150" => "Vaš novi E-Mail naslov '%s' je potrjen.",
"151" => "Naložene datoteke",
"152" => "Files (datoteke) downloaded",
"153" => "Datoteke poslane po E-Mailu",
"154" => "Raèun je bil ustvarjen",
"155" => "Zadnji obisk",
"156" => "Status",
"157" => "Aktivni status",
"158" => "Prejem pregleda",
"159" => "E-mail",
"160" => "Skupno:",
"161" => "raèun(i)",
"162" => "Briši raèun",
"163" => "Pokaži %s raèun(e) od %s",
"164" => "Konfiguracija",
"165" => "Editiraj datoteke",
"166" => "Editiraj datoteko",
"167" => "Datoteka %s je bila uspešno spremenjena",
"168" => "Shrani",
"169" => "Briši",
"170" => "Briši datoteke",
"171" => "Mirror",
"172" => "Da",
"173" => "Ne",
"174" => "Aktiven",
"175" => "Neaktiven",
"176" => "Neautoriziran",
"177" => "Obžalujem, strežnik ne more izvršiti mail programa.",
"178" => "Vaša registracija ni uspela. Prosim, poskusite pozneje.",
"179" => "Prosim, poskusite pozneje.",
"180" => "datoteka je bila uspešno brisana",
"181" => "nimate pravice brisati te datoteke",
"182" => "mapa je bila uspešno brisana",
"183" => "nimate pravice brisati te mape",
"184" => "mapa je bila uspešno ustvarjena",
"185" => "nimate pravice ustvariti nove mape",
"186" => "Ustvari novo mapo",
"187" => "Ime mape",
"188" => "Make dir",
"189" => "mapa že obstoja, prosim, izberite drugo ime",
"190" => "ime mape je obvezno",
"191" => "Spremeni",
"192" => "Datoteka",
"193" => "Spremeni datoteko / podrobnosti mape",
"194" => "predmet je bil uspešno preimenovan.",
"195" => "nimate pravice preimenovati ta predmet",
"196" => "Root path ni pravilen. Preglejte nastavitve",
"197" => "Vrstni red po",
"198" => "preimenovanje ni bilo uspešno, datoteka že obstoja",
"199" => "Zadnje naložene datoteke",
"200" => "Najbolj pogosti download",
"201" => "preimenovanje ni bilo uspešno, ime ni dovoljeno",
"202" => "Web naslov ni veljavem",
"203" => "http naslov datoteke",
"204" => "Naloži datoteko s http naslovom",

//
// New strings introduced in version 1.10
//
"205" => "Always stay logged",
"206" => "Can't execute: name not allowed",
"207" => "IP address blocked",
"208" => "Your IP address has been blocked by Administration!",
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
$sendfile_email_subject = 'Zahtevana datoteka';
$sendfile_email_body = '
Tukaj je zahtevana datoteka po E-Mailu

';
$sendfile_email_end = 'Lep pozdrav,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Dnevni pregled";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'Potrditev e-maila';
$confirm_email_body = 'Spoštovani uporabnik %s,

Ker nam je vaša varnost pomembna, je nujno, da potrdite vaš novi e-mail naslov.

Vaša osebna potrditvena koda je: %s

Aktiviranje e-mail naslova je preprosto:
1. Obišèite nas  %s in mi vas bomo vodili
2. Vnesite ime vašega raèuna in potrditveno kodo.
3. Kliknite na \'Potrdi\' gumb.

';
$confirm_email_end = 'Lep pozdrav,';

//
// Send password e-mail configuration
//
$chpass_email_subject = 'Novo geslo';
$chpass_email_body = 'Spoštovani uporabnik,

Vaše new geslo je %s

';
$chpass_email_end = 'Lep pozdrav,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Potrditev registracije';
$register_email_body = 'Spoštovani uporabnik %s,

Hvala lepa za registracijo.

Ker nam je vaša varnost pomembna, je nujno, da potrdite vaš raèun.

Vaša osebna aktivacijska koda je: %s
(pozor: to ni vaše geslo)

Aktiviranje Vašega raèuna je preprosto:
1. Obišèite nas  %s in mi vas bomo vodili
2. Vnesite ime vašega raèuna in aktivacijsko kodo.
3. Kliknite na \'Aktiviraj raèun\' gumb.

';
$register_email_end = 'Lep pozdrav,';
?>
