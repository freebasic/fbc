<?php
/***************************************************************************
 * eo.php
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

$charsetencoding = "iso-8859-1";
$uploadcentercaption="PHP Advanced Transfer Manager";
$uploadcentermessage = "phpATM";

$mess=array(
"0" => "",
"1" => "Januaro",
"2" => "Februaro",
"3" => "Marto",
"4" => "Aprilo",
"5" => "Majo",
"6" => "Junio",
"7" => "Julio",
"8" => "Augusto",
"9" => "Septembro",
"10" => "Oktobro",
"11" => "Novembro",
"12" => "Decembro",
"13" => "Hodiau",
"14" => "Hierau",
"15" => "Priskribo dosiero",
"16" => "Operacioj",
"17" => "Grandeco",
"18" => "Dato de la elsendo",
"19" => "Proprietulo",
"20" => "Sendu dosieron",
"21" => "Loka dosiero",
"22" => "Priskribo de la dosiero",
"23" => "Elshutu",
"24" => "Supera dosierujo",
"25" => "Hejmo",
"26" => "Dosiero",
"27" => "Presu",
"28" => "Fermu",
"29" => "Malantauen",
"30" => "Chi tiu dosiero estas elvisxita",
"31" => "Estas neeble malfermi la dosieron",
"32" => "Malantauen",
"33" => "Eraro dum alshutado!",
"34" => "vi devas elekti validan dosieron",
"35" => "Malantauen",
"36" => "dosiero",
"37" => "estas sendita sukcese",
"38" => "dosiero",
"39" => " ' jam ekzistas ",
"40" => "la dosiero estas sendita sukcese",
"41" => "la lingvo estas elektita.",
"42" => "bonvenon al PHP Advanced Transfer Manager",
"43" => "Spaco uzita",
"44" => "Montru la tutan arhhivon grupigitan lau la alshut-dato",
"45" => "Zip-dosiero nevalida!",
"36" => "La dosiero enhavas:",
"47" => "Dato/Horo",
"48" => "Dosierujo",
"49" => "ne eblas alshuti dosierojn nomitajn %s",
"50" => "superas la maksimuman grandecon permesatan",
"51" => "Informoj",
"52" => "Elektu Skin",
"53" => "Skin",
"54" => "Bonvenon",
"55" => "Nuna horo",
"56" => "Uzanto",
"57" => "Nomo de la uzanto",
"58" => "Enskribighu",
"59" => "Enskribigho",
"60" => "Dimanicho",
"61" => "Lundo",
"62" => "Mardo",
"63" => "Merkredo",
"64" => "Jhaudo",
"65" => "Vendredo",
"66" => "Sabato",
"67" => "Sendu",
"68" => "Sendu la dosieron retposhte",
"69" => "la dosiero estas sendita al jena retadreso: %s.",
"70" => "dosiero enmetita far de: %s",
"71" => "Eniro",
"72" => "Eliro",
"73" => "Eniru",
"74" => "Anonimulo",
"75" => "Uzulo",
"76" => "Superuzulo",
"77" => "Administranto",
"78" => "Privata spaco",
"79" => "Publica spaco",
"80" => "la enmetita nomo au pasvorto ne validas.",
"81" => "Profilo",
"82" => "Administrado de la profilo",
"83" => "Pasvorto",
"84" => "Elektu lingvon",
"85" => "Elekto de la horzono",
"86" => "Via nuna horo",
"88" => "Retadreso:",
"89" => "certighu, ke la enmetita retadreso funkcias, char tien vi ricevos vian kodon.",
"21" => "Loka dosiero",
"91" => "Retadreso uzata por la enskribigho",
"20" => "Grandeco de la dosiero",
"93" => "Bonvolu noti viajn nomon kaj pasvorton",
"94" => "Estas necese enskribighi.",
"95" => "Ne estas necese enskribighi. Vi povas enskribighi se vi volas aldoni vian nomon al la alshutitaj dosierojn. Neniu alia povos uzi vian nomon por alshuti dosierojn.",
"96" => "Skin elektita.",
"97" => "Gxisdatigu",
"98" => "Enmetu viajn nomon kaj pasvorton",
"99" => "Cxu vi ankorau ne enskribighis? - Enskribighu chi tie!",
"100" => "Chu vi forgesis vian pasvorton?",
"101" => "Bonvole, %s reiru malantauen %s kaj reprovu.",
"102" => "Eliro sukcesa.",
"103" => "La nomo de la uzulo ne validas. Ghi ne povas havi pli ol 12 literoj kaj povas enhavi numerojn, ' - ', ' _ ' kaj spacojn.",
"104" => "La nomo de vi elektita ('%s') ne estas libera.",
"105" => "Reskribu vian pasvorton",
"106" => "La pasrortoj enmetitaj ne coincidas.",
"107" => "La formo de la enmetita retadreso ne validas.",
"108" => "Dankojn por via enskribigho. Bonvolu ne forgesi vian pasvorton. Tamen se tio okazos ni donas al vi kodon kiu kreos novan pasvorton kaj sendas ghin al via retadreso.",
"109" => "Vi povas %s aliri la Centran Alshutejon tra %s",
"110" => "Ni sendis al via retadreso vian kodon. Vi devas funkiigi vian konton en la dauro de du tagoj, post kiuj gxi estos automate forvishita.",
"111" => "Ne eblas elshuti la dosieron, vi ne havas la necesajn permesojn",
"112" => "Aktivigi konton",
"113" => "Aktivigu vian konton",
"114" => "Aktiviga kodo",
"115" => "Ekde nun via konto estas aktiva.",
"116" => "Bonvole, %s eniru tra %s.",
"117" => "La enmetita konta nomo au la aktiviga kodo ne validas.",
"118" => "Konto jam aktiva:",
"119" => "Mi deziras ricevi tagan raporton:",
"120" => "Shanghu vian pasvorton.",
"121" => "Malnova pasvorto",
"122" => "La nomo de la konto ne ekzistas.",
"123" => "La enmetita retadreso ne validas.",
"124" => "Via nova pasvorto estas sendita al via retadreso",
"125" => "plenumo neebla, objekto non trovita",
"126" => "Modifu la agordojn de via konto",
"127" => "Apliku",
"128" => "profilo memorigita.",
"129" => "pasvorto modifita.",
"130" => "la malnova pasvorto ne validas.",
"131" => "Vi devas specifiki la novan pasvorton.",
"132" => "Konfiguro",
"133" => "Alshuto",
"134" => "Lingvo kaj horzono",
"135" => "Statistikoj de la konto",
"136" => "Via konto estas kreita:",
"137" => "Administrado de la uzuloj",
"138" => "Gasto (nur rigardado)",
"139" => "Alshutanto (nur alshutoj)",
"140" => "la konto '%s' estas korekte modifita",
"141" => "Lastaj",
"142" => "Chiuj",
"143" => "La shangho de la retadreso estas farata post konfirmo. Vi povas trovi vian konfirman kodon en via nova poshtkesto. Sekvu la instrukciojn, kiujn vi trovas en la mesagho.",
"144" => "",
"145" => "Bonvolu enmeti la informoj por konfirmi vian novan retadreson:",
"146" => "Konfirma kodo",
"147" => "Konfirmu la novan retadreson",
"148" => "la enmetita uzulo devas konfirmi nenion.",
"149" => "La enmetita konta nomo au la funkciiga kodo ne validas.",
"150" => "Via nova retadreso '%s' estas konfirmita.",
"151" => "Dosieroj senditaj",
"152" => "Dosieroj elshutitaj",
"153" => "Dosieroj retposhte senditaj",
"154" => "Dato de la kreo de la konto",
"155" => "Dato de la lasta eniro:",
"156" => "Rolo",
"157" => "Situacio de la funkciigo",
"158" => "Ricevi raporton",
"159" => "Retadreso",
"160" => "Sumo:",
"161" => "konto",
"162" => "Nuligu konto",
"163" => "Estas montritaj %s kontoj el %s",
"164" => "Konfiguro",
"165" => "Modifu la dosierojn",
"166" => "Modifu la dosieron",
"167" => "La dosiero %s estas sukcese shanghita.",
"168" => "Memorigu",
"169" => "Nuligu",
"170" => "Nuligu la dosierojn",
"171" => "Spegulo",
"172" => "Jes",
"173" => "Ne",
"174" => "Aktiva",
"175" => "Neaktiva",
"176" => "Nerajtigita",
"177" => "Bedaurinde la servilo ne povas uzi la programo por sendi mesaghojn.",
"178" => "Enskribigho nesukcesa. Bonvolu reprovi poste",
"179" => "Bonvolu reprovi poste",
"180" => "dosiero sukcese forvishita",
"181" => "mankas la necesaj permesoj por forvishi la dosieron",
"182" => "dosierujo sukcese forvishita",
"183" => "mankas la necesaj permesoj por forvishi la dosierujon",
"184" => "dosierujo sukcese kreita",
"185" => "mankas la necesaj permesoj por krei la dosierujon",
"186" => "Kreu novan dosierujon",
"187" => "Nomo de la dosierujo",
"188" => "Kreu dosierujon:",
"189" => "neeblas krei la dosierujon, jam ekzistas dosierujo kun la sama nomo",
"190" => "estas necese specifiki la nomon de la kreenda dosierujo",
"191" => "Modifu",
"192" => "Dosiernomo:",
"193" => "Modifu la detalojn de la dosier(uj)o",
"194" => "nomo de la objekto sukcese shanghita.",
"195" => "mankas la necesaj permesoj por shanghi la nomon de la objekto",
"196" => "Agordo de la chefa vojo ne estas korekta. Kontrolu la agordojn!",
"197" => "Ordigu",
"198" => "la dosiero jam ekzistas, ne eblas shanghi la nomon",
"199" => "Laste senditaj dosieroj",
"200" => "La plej elshutitaj dosieroj",
"201" => "ne eblas shanghi la nomon, ghi ne estas permesata",

//
// New strings introduced in version 1.02
//
"202" => "La enmetita TTT adreso ne validas",
"203" => "Adreso de la dosiero",
"204" => "Sendu dosiero per http-adreso",

//
// New strings introduced in version 1.10
//
"205" => "Restu chiam alligita",
"206" => "Ne eblas plenumi: nekorekta au malpermesata nomo",
"207" => "Fermita IP",
"208" => "Via IP estis fermita de la Administraro!",
"209" => "Demandu pliajn informojn al la Administranto",

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
$sendfile_email_subject = 'Petita dosiero';
$sendfile_email_body = '
Jen la dosiero kiun vi petis pere de reta posxto

';
$sendfile_email_end = 'Bonan tagon,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Taga raporto";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'Konfirma retadresa shangho';
$confirm_email_body = 'Estimata %s,

Pro sekurecaj kialoj via konto ankorau ne estas aktiva.

Por aktivigi gxin, jen via aktiviga kodo: %s (atentu: cxi tiu ne estas
via pasvorto!)

Aktivigo de via konto estas simpla:
1. Vizitu la pagxon %s kaj vi ricevos la necesajn informojn.
2. Enmetu vian nomon kaj vian pasvorton.
3. Kliku la butonon \'Apliku\'.

';
$confirm_email_end = 'Bonan tagon,';

//
// Send password e-mail configuration
//
$chpass_email_subject = 'Nova pasvorto';
$chpass_email_body = 'Estimata,

Via nova pasvorto estas %s
Ni konsilas vin sxangxi gxin kiel eble plej baldau.

';
$chpass_email_end = 'Bonan tagon,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Konfirma enskribigxo';
$register_email_body = 'Estimata %s,

Dankojn por via enskribigho.

Pro sekurecaj kialoj via konto ankorau ne estas aktiva.

Por aktivigi gxin, jen via aktiviga kodo: %s (atentu: cxi tiu ne estas
via pasvorto!)

Aktivigo de via konto estas simpla:
1. Vizitu la pagxon %s kaj vi ricevos la necesajn informojn.
2. Enmetu vian nomon kaj vian pasvorton.
3. Kliku la butonon \'Aktivigu konton\'.

';
$register_email_end = 'Bonan tagon,';

?>
