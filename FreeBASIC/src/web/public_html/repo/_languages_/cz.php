<?php
/***************************************************************************
 *                                   en.php
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

$charsetencoding="windows-1250";                 // The encoding for national symbols (i.e. for cyryllic  must be "windows-1251")
$uploadcentercaption="PHP Advanced Transfer Manager";
$uploadcentermessage="phpATM";

$mess=array(
"0" => "",
"1" => "Leden",
"2" => "Únor",
"3" => "Bøezen",
"4" => "Duben",
"5" => "Kvìten",
"6" => "Èerven",
"7" => "Èervenec",
"8" => "Srpen",
"9" => "Záøí",
"10" => "Øíjen",
"11" => "Listopad",
"12" => "Prosinec",
"13" => "Dnes",
"14" => "Vèera",
"15" => "Soubor",
"16" => "Funkce",
"17" => "Velikost",
"18" => "Nahráno",
"19" => "Majitel",
"20" => "Nahrání souboru",
"21" => "Lokální soubor",
"22" => "Popis",
"23" => "Stažení",
"24" => "Øazení",
"25" => "Titulní strana",
"26" => "Soubor",
"27" => "Tisknout",
"28" => "Uzavøít",
"29" => "Zpìt",
"30" => "Soubor byl odstranìn",
"31" => "Soubor nelze otevøít",
"32" => "Zpìt",
"33" => "ERROR - chyba pøi nahrávání souboru!!!",
"34" => "Musíte vybrat soubor",
"35" => "Zpìt",
"36" => "Soubor",
"37" => "Vpoøádku nahrán",
"38" => "Soubor se jménem",
"39" => "Již existuje",
"40" => "OK - soubor byl nahrán",
"41" => "OK - jazyk byl vybrán",
"42" => "Vítejte v MCUatm",
"43" => "Obsazený prostor",
"44" => "Zobrazit soubory každý den",
"45" => "ERROR - chybný ZIP archiv!",
"46" => "Archiv obsahuje:",
"47" => "Datum/Èas",
"48" => "Adresáø",
"49" => "Není možné nahrát soubor se jménem: %s!",
"50" => "pøekroèena maximální velikost",
"51" => "Informace",
"52" => "Vyberte vzhled",
"53" => "Vzhled",
"54" => "Vítejte",
"55" => "Souèasný èas",
"56" => "Uživatel",
"57" => "Uživatelské jméno",
"58" => "Register",
"59" => "Registrace",
"60" => "Nedìle",
"61" => "Pondìlí",
"62" => "Úterý",
"63" => "Støeda",
"64" => "Ètvrtek",
"65" => "Pátek",
"66" => "Sobota",
"67" => "Poslat",
"68" => "Poslat e-mailem",
"69" => "Soubor byl odeslán na adresu: %s",
"70" => "Soubor nahrál uživatel: %s",
"71" => "Pøihlášení",
"72" => "Odhlášení",
"73" => "Vstupte",
"74" => "Anonym",
"75" => "Bìžný uživatel",
"76" => "Privilegovaný uživatel",
"77" => "Administrátor",
"78" => "Soukromá zóna",
"79" => "Veøejná zóna",
"80" => "ERROR - chybné uživatelské jméno nebo heslo.",
"81" => "Váš profil",
"82" => "Váš profil",
"83" => "Heslo",
"84" => "Volba jazyka",
"85" => "Volba èasového pásma",
"86" => "Váš souèasný èas",
"88" => "E-mail adresa",
"89" => "Vaše e-mail adresa musí být aktivní, nebo aktivaèní kod Vám bude zaslán e-mailem.",
"90" => "Soubor nahrán: ",
"91" => "Vložte Vaši e-mail adresu, kterou jste zadal pøi registraci.",
"92" => "Velikost souboru: ",
"93" => "Vložte Vaše uživatelské jméno a heslo",
"94" => "Je nutná registrace. Registrujte se, prosím.",
"95" => "Registrace není nutná. Mùžete se zaregistrovat pokud chcete zobrazovat Vaše jméno u souborù, které jste nahrál. Nikdo jiný pod Vašim jménem nemùže vystupovat.",

"96" => "Vzhled byl vybrán.",
"97" => "Obnovit",
"98" => "Vložte prosím své uživatelské jméno a heslo",
"99" => "Nejste registrovaný uživatel? - Zaregistrujte se!",
"100" => "Zapomnìl jste heslo?",
"101" => "Prosím, %s vrate se %s a zkuste to znovu.",
"102" => "Odhlásil jste se.",
"103" => "Uživatelské jméno je neplatné. Jméno musí být kratší než 13 znakù a mùže obsahovat písmena, èíslice, '-', '_' a mezery.",
"104" => "The '%s' you picked has been taken.",
"105" => "Potvrïte heslo",
"106" => "Heslo nesouhlasí.",
"107" => "E-mail adresa je neplatná.",
"108" => "Dìkujeme za registraci. Nezapomeòte své heslo. V pøípadì že ho zapomenete, bude Vám zasláno nové, náhodnì vygenerované.",
"109" => "Mùžete %s soubory mùžete vkládat zde. %s",
"110" => "Aktivaèní kod bude odeslán na Vašie-mail adresu. Musíte aktivovat svùj úèet do dvou dnù, jinak bude automaticky zrušen.",
"111" => "nemáte práva pr vložení tohoto souboru",
"112" => "Akivace uživatelského úètu",
"113" => "Prosím, aktivujte si Váš uživatelský úèet",
"114" => "Aktivaèní kod",
"115" => "Váš uživatelský úèet byl aktivován.",
"116" => "Prosím %s vstupte %s.",
"117" => "Uživatelské jméne, nebo aktivaèní kod je neplatné.",
"118" => "Uživatelský úèet je již aktivní.",
"119" => "Zasílat denní pøehled vložených souborù e-mailem.",
"120" => "Nové heslo",
"121" => "Staré heslo",
"122" => "Uživatelské jméno neexistuje.",
"123" => "E-mail adresa je neplatná.",
"124" => "Vaše nové heslo bylo odesláno.",
"125" => "Není možné vykonat, objekt nenalezen",
"126" => "Úprava uživatelského profilu",
"127" => "Proveï",
"128" => "Váš profil byl uložen.",
"129" => "Vaše heslo bylo zmìnìno.",
"130" => "Chybné pùvodní heslo.",
"131" => "Musíte vložit nové heslo.",
"132" => "Konfigurace",
"133" => "Nahrávání",
"134" => "Jazyk a èasové pásmo",
"135" => "Uživatelská statistika",
"136" => "Úèet založen:",
"137" => "Konfigurace uživatelù",
"138" => "Pouze prohlížení",
"139" => "Pouze nahrávání",
"140" => "Úèet '%s' korektnì upraven",
"141" => "Poslední",
"142" => "Všechno",
"143" => "Nová e-mail adresa bude aktivní až po Vašem potvrzení. Potvrzovací kod byl odeslán na Vaší novou e-mail adresu. Postupujte podle instrukcí v e-mailu.",
"144" => "",
"145" => "Prosím, potvrïte Vaší novou e-mail adresu.",
"146" => "Potvrzovací kod",
"147" => "Potvrzení",
"148" => "Není co potvrdit.",
"149" => "Uživatelské jméne, nebo potvrzovací kod je neplatné.",
"150" => "Vaše nová e-mail adresa '%s' je uložena.",
"151" => "Poèet nahraných souborù",
"152" => "Poèet stažených souborù",
"153" => "Soubor byl odeslán e-mailem",
"154" => "Úèet byl vytvoøen",
"155" => "Poslední pøístup",
"156" => "Práva",
"157" => "Status",
"158" => "Notifikace pøírustkù e-mailem",
"159" => "e-mail",
"160" => "Celkem úètù:",
"161" => "",
"162" => "Zrušit úèet",
"163" => "Zobrazit %s úètù %s",
"164" => "Konfigurace nahrávacího centra",
"165" => "Editace souborù",
"166" => "Editace souboru",
"167" => "Soubor %s byl upraven",
"168" => "Uložit",
"169" => "Zrušit",
"170" => "Odstranit soubory",
"171" => "Mirror",
"172" => "Ano",
"173" => "Ne",
"174" => "Aktivní",
"175" => "Neaktivní",
"176" => "Neschváleno",
"177" => "Lituji, ale server nemùže spustit poštovní program.",
"178" => "Chybná registrace. Prosím opakujte pozdìji.",
"179" => "Prosím, opakujte pozdìji.",
"180" => "soubor odstranìn",
"181" => "nemáte oprávnìní odstranit tento soubor",
"182" => "adresáø odstranìn",
"183" => "nemáte oprávnìní odstranit tento adresáø",
"184" => "adresáø byl vytvoøen",
"185" => "nemáte oprávnìní vytváøet nový adresáø",
"186" => "Vytvoøit nový adresáø",
"187" => "Název adresáøe",
"188" => "Vytvoøit adresáø",
"189" => "adresáø již existuje, zvolte jiný název",
"190" => "musíte zadat název adresáøe",
"191" => "Upravit",
"192" => "Název souboru",
"193" => "Upravit soubor/adresáø",
"194" => "objekt byl pøejmenován.",
"195" => "Nemáte oprávnìní k pøejmenování objektu",
"196" => "Bázový adresáø je nekorektní, zkontrolujte nastavení",
"197" => "Seøadit podle",
"198" => "rename failed, file already exists",
"199" => "Poslední pøíspìvky",
"200" => "Nejèastìji stahované",
"201" => "Nelze pøejmenovat, nekorektní název",

//
// New strings introduced in version 1.02
//
"202" => "Zadaná adresa je neplatná",
"203" => "HTTP adresa souboru",
"204" => "Nahrání souboru z HTTP adresy",

//
// New strings introduced in version 1.10
//
"205" => "Zùstat trvale pøihlášen",
"206" => "Není možné vykonat",
"207" => "IP adresa je blokována",
"208" => "Vaše IP adresa byla blokována Administrátorem!",
"209" => "Pro více informací kontaktujte Administrátora",

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
$sendfile_email_subject = 'Požadovaný soubor';
$sendfile_email_body = '
Tento soubor jste si nechal zaslat e-mailem

';
$sendfile_email_end = 'S pozdravem,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Denní pøírùstky";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'Potvrzení nové e-mail adresy';
$confirm_email_body = 'Vážený %s,

Protože se snažíme o maximální bezpeènost našich uživatelù, bude Váše e-mailová adresa zmìnìna až po zadání aktivaèního kodu.

Váš osobní aktivaèní kod je: %s

Aktivace Vaší nové e-mailové adresy je snadná:
1. Navštivte nás na adrese %s and a budete proveden celým procesem
2. Zadejte Váše uživatelské jméno a aktivaèní kod
3. Kliknìte na tlaèítko

';
$confirm_email_end = 'S pozdravem,';

//
// Send password e-mail configuration
//
$chpass_email_subject = 'Nové heslo';
$chpass_email_body = 'Vážený uživateli,

Váše mové heslo je: %s

';
$chpass_email_end = 'S pozdravem,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Potvrzení registrace';
$register_email_body = 'Vážený %s,

Dìkujeme za registraci.

Protože se snažíme o maximální bezpeènost našich uživatelù, bude Váš uživatelský úèet aktivován až po zadání aktivaèního kodu.

Váš osobní aktivaèní kod je: %s
(Pozor: nejedná se o Vaše heslo)

Aktivace Vašeho úètu je snadná:
1. Navštivte nás na adrese %s and a budete proveden celým procesem
2. Zadejte Váše uživatelské jméno a aktivaèní kod
3. Kliknìte na tlaèítko

';
$register_email_end = 'S pozdravem,';
?>
