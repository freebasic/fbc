<?php
/***************************************************************************
 *                                   pl.php
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

$charsetencoding="iso-8859-2";
$uploadcentercaption="PHP Advanced Transfer Manager";
$uploadcentermessage="phpATM";

$mess=array(
"0" => "",
"1" => "Styczeñ",
"2" => "Luty",
"3" => "Marzec",
"4" => "Kwiecieñ",
"5" => "Maj",
"6" => "Czerwiec",
"7" => "Lipiec",
"8" => "Sierpieñ",
"9" => "Wrzesieñ",
"10" => "Pa¼dziernik",
"11" => "Listopad",
"12" => "Grudieñ",
"13" => "Dzisiaj",
"14" => "Wczoraj",
"15" => "Opis pliku",
"16" => "Operacje",
"17" => "Wielko¶æ",
"18" => "Data wys³ania",
"19" => "W³a¶ciciel",
"20" => "Wysy³aj",
"21" => "Plik w",
"22" => "Opis pliku",
"23" => "¦ci±gnij",
"24" => "Poprzedni katalog",
"25" => "Home",
"26" => "Plik",
"27" => "Drukuj",
"28" => "Zamknij",
"29" => "Wróæ",
"30" => "Ten plik zosta³ skasowany",
"31" => "Nie mo¿na otworzyæ pliku",
"32" => "Wróæ",
"33" => "B³±d podczas Uploadowania!",
"34" => "musisz wybraæ dobry plik",
"35" => "Wróæ",
"36" => "plik",
"37" => "wys³ano poprawnie",
"38" => "plik '",
"39" => "' ju¿ istnieje",
"40" => "wys³ano poprawnie.",
"41" => "jêzyk zosta³ wybrany.",
"42" => "witamy na PHP Advanced Transfer Manager",
"43" => "Ca³a pamiêæ zajêta",
"44" => "poka¿ ca³± zawarto¶æ archiwum.",
"45" => "Plik Zip b³êdny!",
"46" => "plik zawiera:",
"47" => "Data/Godzina",
"48" => "Katalog",
"49" => "nie mo¿na uploadowaæ pliku o nazwie %s",
"50" => " przekracza maksymaln± d³ugo¶æ.",
"51" => "Infomracje",
"52" => "Wybierz Skin",
"53" => "Skin",
"54" => "Witaj",
"55" => "Jest teraz godzina",
"56" => "U¿ytkownik",
"57" => "U¿ytkownik",
"58" => "Zarejestruj siê",
"59" => "Rejestracja",
"60" => "Niedziela",
"61" => "Poniedzia³ek",
"62" => "Wtorek",
"63" => "¦roda",
"64" => "Czwartek",
"65" => "Piatek",
"66" => "Sobota",
"67" => "Wyslij",
"68" => "Wyslij poprzez e-mail",
"69" => "plik zosta³ wys³any na adres %s.",
"70" => "plik wprowadzony przez u¿ytkownika: %s",
"71" => "Login",
"72" => "Logout",
"73" => "Wejd¼",
"74" => "Anonim",
"75" => "U¿ytkownik",
"76" => "Superuzytkownik",
"77" => "Administrator",
"78" => "Teren przywatny",
"79" => "Teren publiczny",
"80" => "nazwa lub has³o nie jest poprawne.",
"81" => "Profil",
"82" => "Obs³uga profilu",
"83" => "Has³o",
"84" => "Wybierz jêzyk",
"85" => "Strefa czasowa",
"86" => "U¿yj czasu bierz±cego",
"88" => "Adres e-mail:",
"89" => "sprawd¼ czy adres email jest poprawny, zostanie wys³any kod aktywacyjny.",
"90" => "Wstawiono plik: ",
"91" => "Adres email u¿yty do rejestracji",
"92" => "Rozmiar pliku: ",
"93" => "Proszê wprowadziæ nazwe i has³o",
"94" => "nale¿y siê zarejestrowaæ.",
"95" => "Nie trzeba siê rejestrowaæ. Rejestracja pozwoli na dodanie twojej nazwy do wszystkich plików przez ciebie dodanych. ¯aden inny uzytkowanik nie mo¿e wykorzystaæ twojej nazwy do uploadowania pliku.",
"96" => "Skin wybrany.",
"97" => "Od¶wie¿",
"98" => "Wprowad¼ nazwe i has³o dostêpu",
"99" => "Jeszcze siê nie zarejestrowa³e¶? - Rejestracja jest tutaj!",
"100" => "Zapomnia³e¶ has³a?",
"101" => "Proszê %s wróc %s i ponów próbe.",
"102" => "Logout wykonany poprawnie.",
"103" => "Nazwa u¿ytkownika nie jest poprawna. Nie mo¿na u¿ywaæ powy¿ej 12 znaków, oraz znaków typu, '-', '_' i spacji.",
"104" => "Nazwa któr± wybra³e¶ ('%s') nie jest dostepna.",
"105" => "Wpisz ponownie has³o",
"106" => "Wpisane Has³a nie s± jednakowe.",
"107" => "Wpisany format adresu email nie jest poprawny.",
"108" => "Dziêkuje za zarejestrowanie siê. Zapamiêtaj twoj± nazwe i has³o (Login i Password). Je¶li zapomnisz te dane, mozliwe, ¿e ich nie odzyskasz, jednak postaramy sie ci pomóc.",
"109" => "Mo¿esz %s wej¶æ na Upload naciskaj±c tutaj %s",
"110" => "Wys³any zosta³ kod aktywacyjny na twój email. Wygenerowany dostep do konta jest wa¿ny przez 2 dni, jesli nie potwierdzisz rejestracji zostanie ona usuniêta.",
"111" => "Nie mo¿na ¶ci±gn±æ pliku, nie maj± one odpowiednich danych.",
"112" => "Aktywacja rejestracji",
"113" => "Aktywuj swoj± rejestracjê.",
"114" => "Kod aktywacyjny",
"115" => "Od tego momentu aktywowa³eæ swoj± rejestracjê.",
"116" => "Proszê %s aby¶ wszed³ tutaj %s.",
"117" => "Nazwa lub kod aktywacyjny nie s± poprawne.",
"118" => "Ten uzytkownik zosta³ ju¿ aktywowany.",
"119" => "Chcê otrzymywaæ dzienny raport:",
"120" => "Zmieñ Has³o dostêpu.",
"121" => "Stare Has³o",
"122" => "Wprowadzony w¿ytkownik nie jest aktywny.",
"123" => "Wprowadzony email nie jest poprawny.",
"124" => "Nowe has³o zosta³o przes³ane poprzez email",
"125" => "nie mo¿na wykonac operacji, nie znaleziono obiektu",
"126" => "Zmieñ preferencje",
"127" => "Wykonaj",
"128" => "profil zapamietany.",
"129" => "has³o zmienione.",
"130" => "stare has³o nie jest poprawne.",
"131" => "Musisz podaæ nowe has³o.",
"132" => "Konfiguracja",
"133" => "Upload",
"134" => "Jêzyk i strefa czasowa",
"135" => "Statystyka u¿ytkownika",
"136" => "Twój profil zosta³ wygenerowany:",
"137" => "Obs³uga u¿ytkowników",
"138" => "Go¶æ (tylko ogl±danie)",
"139" => "Uploader (tylko upload)",
"140" => "profil '%s' zmodyfikowany poprawnie",
"141" => "Ostatnie",
"142" => "Wszystkie",
"143" => "Zmiana adresu email jest wa¿na po potwierdzeniu. Twój kod aktywacyjny znajdziesz w skrzynce email. Wykonaj czynno¶ci opisane w emailu.",
"144" => "",
"145" => "Proszê wprowadziæ dane i potwierdzic nowy adres email:",
"146" => "Kod aktywacyjny",
"147" => "Potwierd¼ nowy adres email",
"148" => "Wprowadzony u¿ytkownik nie ma nic do potwierdzenia.",
"149" => "Nazwa uzytkownika i kod potwierdzaj±cy nie s± poprawne.",
"150" => "twój nowy adres email '%s' zosta³ potwirdzony.",
"151" => "Pliki wys³ano",
"152" => "¦ci±gniêto pliki",
"153" => "pliki prze emailowane",
"154" => "Data stworzenia profilu",
"155" => "Data ostatniego wej¶cia",
"156" => "Rola",
"157" => "Status aktywacji",
"158" => "Odebrano raport",
"159" => "E-mail",
"160" => "Ca³o¶æ:",
"161" => "profil",
"162" => "Skasuj profil ",
"163" => "Popa¿ %s profil przy wielko¶ci di %s",
"164" => "konfiguracja",
"165" => "Edytuj plik",
"166" => "Edytuj plik",
"167" => "Iplikl %s zosta³ zmodyfikowany poprawnie",
"168" => "Zapisz",
"169" => "Skasuj",
"170" => "Skasuj plik",
"171" => "Mirror",
"172" => "Tak",
"173" => "Nie",
"174" => "Atktywny",
"175" => "Wys³any",
"176" => "Brak autoryzacji",
"177" => "Przykronam serwer nie mo¿e wykonaæ programu pocztowego.",
"178" => "Rejestracja nie powiod³a siê, proszê spóbowac pó¼niej",
"179" => "Proszê spróbowac pó¼niej",
"180" => "fplik zosta³ skasowany",
"181" => "nie posiadasz odpowiednich uprawnieñ do skasowania pliku",
"182" => "katalog zosta³ skasowany",
"183" => "nie posiadasz uprawnieñ do skasowania katalogu",
"184" => "katalog zosta³ stworzony",
"185" => "nie posiadasz uprawnieñ do stworzenia katalogu",
"186" => "Stwórz nowy katalog",
"187" => "Nazwa katalogu",
"188" => "Stwórz katalog",
"189" => "inie mozna stworzyc katalogu, taki juz istnieje",
"190" => "musisz podaæ normaln± nazwê katalogu",
"191" => "Zmieñ",
"192" => "Nazwa pliku",
"193" => "Zmieñ detale katalogu",
"194" => "nazwa obiektu zmieniona poprawnie.",
"195" => "nie posiadasz odpowiednich uprawnieñ do zmiany nazwy obiektu",
"196" => "Wstawiono z³y root path, zmieñ ustawienia w konfiguracji!",
"197" => "Wykoanj",
"198" => "nie mozna zmieniæ nazwy, taki plik istnieje",
"199" => "Pliki ostatnio wgrane",
"200" => "Pliki najczê¶ciej ¶ci±gane",
"201" => "nie mozna zmieniæ, nazwa niedostêpna",

//
// New strings introduced in version 1.02
//
"202" => "Adres web nie jest poprawny",
"203" => "Adres pliku",
"204" => "Wy¶lij plik z adreseum http",

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
$sendfile_email_subject = '¯±dany plik';
$sendfile_email_body = '
Oto plik, który chcia³e¶ dodtaæ poprzez email

';
$sendfile_email_end = 'Mi³ego dnia,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Dzienny raport";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'Potwierd¼ zmianê emaila';
$confirm_email_body = 'Drogi u¿ytkowniku %s,

Poniewa¿ dbamy o bezpieczeñstwo twoich danych, twój profil nie zosta³ jeszcze stworzony.

Aby go uruchomiæ musisz wprowadziæ kod aktywacyjny: %s
(UWAGA to nie jest password - has³o!)

Aktywowaæ rejestracjê-profil jest bardzo ³atwo:
1. Id¼ na stwonê %s itam zostaniesz pokierowany ktok po kroku.
2. Wprowad¼ nazwê u¿ytkownika i email.
3. Wszystko zatwierd¼ .

';
$confirm_email_end = 'Mi³ego dnia,';

//
// Send password e-mail configuration
//
$chpass_email_subject = 'Nowe has³o-password';
$chpass_email_body = 'Nazwa u¿ytkownika,

Nowe has³o è %s
Mo¿esz je zmieniæ kiedy chcesz.

';
$chpass_email_end = 'Mi³ego dnia,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Potwierd¼ rejestracje';
$register_email_body = 'U¿ytkowniku  %s,

Dziêkujemy, ¿e siê zarejestrowa³e¶

poniewa¿ dbamy o bezpieczeñstwo twoich danych profil nie zosta³ jeszcze aktywowany.

Aby go aktywowaæ musisz wpisaæ kod aktywacyjny è: %s
(uwaga! to nie jest has³o-password)

Aktywowaæ rejestracjê-profil jest bardzo ³atwo:
1. Id¼ na stwonê %s itam zostaniesz pokierowany ktok po kroku.
2. Wprowad¼ nazwê u¿ytkownika i email.
3. Wszystko zatwierd¼ .

';
$register_email_end = 'Mi³ego dnia,';

?>
