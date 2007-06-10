<?php
/***************************************************************************
* fi.php
* -------------------
* begin : Tuesday', Aug 15', 2002
* copyright : ('C) 2002 Bugada Andrea
* email : phpATM@free.fr
*
* $Id$
*
* Finnish modification by: jiippana at hotmail dot com 06.06.2004
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

$charsetencoding="iso-8859-15"; // The encoding for national symbols (i.e. for cyryllic must be "windows-1251")
$uploadcentercaption="PHP Advanced Transfer Manager";
$uploadcentermessage="phpATM";

$mess=array(
"0" => "",
"1" => "Tammikuu",
"2" => "Helmikuu",
"3" => "Maaliskuu",
"4" => "Huhtikuu",
"5" => "Toukokuu",
"6" => "Kesäkuu",
"7" => "Heinäkuu",
"8" => "Elokuu",
"9" => "Syyskuu",
"10" => "Lokakuu",
"11" => "Marraskuu",
"12" => "Joulukuu",
"13" => "Tänään",
"14" => "Eilen",
"15" => "Tiedostonimi",
"16" => "Toiminnot",
"17" => "Koko",
"18" => "Käyttäjä",
"19" => "Omistaja",
"20" => "Lähetä tiedosto palveluun",
"21" => "Paikallinen tiedosto",
"22" => "Tiedoston kuvaus",
"23" => "Lataa omalle koneelle",
"24" => "Järjestys",
"25" => "Koti",
"26" => "Tiedosto",
"27" => "Tulosta",
"28" => "Sulje",
"29" => "Takaisin",
"30" => "Tämä tiedosto on poistettu",
"31" => "Tiedoston avaaminen ei onnistu",
"32" => "Takaisin",
"33" => "Tiedoston vastaanotto ei onnistu!",
"34" => "Valitse tiedosto",
"35" => "Takaisin",
"36" => "Tiedosto",
"37" => "on vastaanotettu palveluun",
"38" => "Tiedosto",
"39" => "on jo olemassa",
"40" => "Tiedosto on vastaanotettu palveluun",
"41" => "Kieli on vaihdettu onnistuneesti",
"42" => "Tervetuloa PHP Advanced Transfer Manager -palveluun",
"43" => "Tiedostojen koko yhteensä",
"44" => "Näytä kaikkien päivien tiedostot",
"45" => "Epäkelpo ZIP-tiedosto!",
"46" => "Tiedoston sisältö:",
"47" => "PVM/aika",
"48" => "Hakemisto",
"49" => "Tiedoston jonka nimi on \"%s\" lähettäminen palveluun kielletty!",
"50" => "Ylittää määrätyn rajan",
"51" => "Tietoja",
"52" => "Valitse nahka",
"53" => "Nahka",
"54" => "Tervetuloa",
"55" => "Kellonaika",
"56" => "Käyttäjä",
"57" => "Käyttäjätunnus",
"58" => "Rekisteröidy",
"59" => "Rekisteröityminen",
"60" => "Sunnuntai",
"61" => "Maanantai",
"62" => "tiistai",
"63" => "Keskiviikko",
"64" => "Torstai",
"65" => "Perjantai",
"66" => "Lauantai",
"67" => "Lähetä",
"68" => "Lähetä tiedosto sähköpostitse",
"69" => "Tiedosto on lähetetty %s sähköpostiin.",
"70" => "Käyttäjän %s lähettämä tiedosto",
"71" => "Kirjaudu sisään",
"72" => "Kirjaudu ulos",
"73" => "Vahvista",
"74" => "Anonyymi",
"75" => "Normaali",
"76" => "Tehokäyttäjä",
"77" => "Ylläpitäjä",
"78" => "Yksityinen alue",
"79" => "Julkinen alue",
"80" => "Kirjoittamasi käyttäjätunnus tai salasana on epäkelpo",
"81" => "Tietosi",
"82" => "Näytä tai muokkaa tietojasi",
"83" => "Salasana",
"84" => "Valithe kielesi",
"85" => "Valitse aikavyöhyke",
"86" => "Kellonaika",
"88" => "Kirjoita voimassaoleva sähköpostiosoite",
"89" => "Tarkista että kirjoitit sähköpostiosoitteen oikein! Sen tulee olla voimassa, sillä sinne lähetetään salasanasi.",
"90" => "Vastaanotettu tiedosto: ",
"91" => "Kirjoita sama sähköpostiosoite jolla rekisteröidyit.",
"92" => "Tiedoston koko: ",
"93" => "Muista käyttäjätunnuksesi ja salasanasi",
"94" => "Rekisteröinti on pakollista. Ole hyvä ja rekisteröidy.",
"95" => "Rekisteröinti ei ole pakollista. Rekisteröityä jos haluat että lähettämistäsi tiedostoista käy ilmi tietojasi.",

"96" => "Nahka vaihdettu.",
"97" => "Päivitä näyttö",
"98" => "Kirjoita käyttäjätunnuksesi ja salasanasi",
"99" => "Rekisteröidy nyt! Täällä!",
"100" => "Salasana hukassa?",
"101" => "Mene %s takaisin %s ja yritä uudestaan.",
"102" => "Sinut on kirjattu pihalle. ",
"103" => "Epäkelpo käyttäjätunnus! Käyttäjätunnus ei voi olla pidempi kuin 12 merkkiä. Käyttäjätunnus voi sisältää aakkosia, mutta _ei_ ääkkösiä. Sallittuja merkkejä ovat lisäksi '-', '_', ja välilyönti.",
"104" => "'%s' jonka valitsit on jo mennyt.",
"105" => "Salasana uudestaan",
"106" => "Salasanat eivät täsmää.",
"107" => "Sähköpostiosoitteen muoto on epäkelpo.",
"108" => "Kiitos rekisteröitymisestäsi. Jos unohdat salasanasi, palvelu lähettää sähköpostiisi pyynnöstäsi uuden salasanan.",
"109" => "Voit %s nähdäksesi vastaanottokeskuksen. %s",
"110" => "Aktivointitunnus on lähetetty sinulle. Jos et kahden päivän sisällä ole aktivoinut tunnustasi, se poistetaan.",
"111" => "sinulla ei ole valtuuksia ladata tiedostoa itsellesi",
"112" => "Aktivoi käyttäjätunnus",
"113" => "Aktivoi käyttäjätunnuksesi",
"114" => "Aktivointitunnus",
"115" => "Käyttäjätunnuksesi on aktivoitu.",
"116" => "Kirjoita %s tähän %s.",
"117" => "Syöttämäsi käyttäjätunnus tai aktivointitunnus on epäkelpo.",
"118" => "Käyttäjätunnus on jo aktivoitu.",
"119" => "Haluan päivittän sähköpostiini tietoa uusista palveluun lähetetyistä tiedostoista.",
"120" => "Vaihda salasanasi.",
"121" => "Vanha salasanasi",
"122" => "Syöttämääsi käyttäjätunnusta ei löydy.",
"123" => "Syöttämäsi sähköpostiosoite ei ole kelvollinen.",
"124" => "Uusi salasanasi on lähetetty sähöpostiisi.",
"125" => "ei voi suorittaa, objektia ei löydy",
"126" => "Muokkaa asetuksiasi",
"127" => "Ota muutokset käyttöön",
"128" => "Asetuksesti on talletettu.",
"129" => "Salasanasi on vaihdettu.",
"130" => "Vanha salasana on kirjoitettu väärin.",
"131" => "Uusi salasana täytyy olla annettu.",
"132" => "Asetukset",
"133" => "Lähetetty",
"134" => "Kieli ja aikavyöhyke",
"135" => "Käyttätilastot",
"136" => "Käyttäjätunnuksesi on luotu:",
"137" => "Käyttäjän hallinta",
"138" => "Katselija (voi vain katsella)",
"139" => "Lähettäjä (voi vain lähettää tiedostoja palveluun)",
"140" => "Käyttäjätunnus '%s' on muutettu",
"141" => "Viimeisin",
"142" => "Kaikki",
"143" => "Uusi sähköpostiosoite astuu voimaan vahvistuksen jälkeen. Tarkista ohjeet sähköpostistasi.",
"144" => "",
"145" => "Vahvista sähköpostiosoitteesi",
"146" => "Vahvistuskoodi",
"147" => "Vahvista",
"148" => "Eipä ole vahvistettavaa",
"149" => "Syöttämäsi käyttäjätunnus tai aktivointikoodi on epäkelpo.",
"150" => "Uusi sähköpostiosoitteesi '%s' on hyväksytty.",
"151" => "Tiedostoja lähetetty palveluun",
"152" => "Tiedostoja ladattu palvelusta",
"153" => "Tiedostoja lähetty sähköposteihin",
"154" => "Käyttäjätunnus luotu",
"155" => "Viimeksi käytetty",
"156" => "Tila",
"157" => "Aktiivinen tila",
"158" => "Sähköpostita uudet tiedostot",
"159" => "Sähköpostiosoite",
"160" => "Yhteensä:",
"161" => "Käyttäjätunnuksia",
"162" => "Poista käyttäjätunnus",
"163" => "Näytetty %s käyttäjätunnusta %s",
"164" => "Muokkaa vastaanottokeskusta",
"165" => "Muokkaa tiedostoja",
"166" => "Muokkaa tiedostoa",
"167" => "Tiedosto %s on tallennettu",
"168" => "Talleta",
"169" => "Poista",
"170" => "Poista tiedostoja",
"171" => "Peili",
"172" => "Kyllä",
"173" => "Ei",
"174" => "Aktiivinen",
"175" => "Passiivinen",
"176" => "Käyttäjä tunnistamaton",
"177" => "Palvelu ei saanut sähköpostin lähetystä toimimaan. Pahoittelut siitä.",
"178" => "Rekisteröintisi ei nyt onnistu. Ole hyvä, koeta myöhemmin uudestaan.",
"179" => "Ole hyvä, koeta myöhemmin uudestaan.",
"180" => "tiedosto poistettu",
"181" => "sinulla ei ole valtuuksia poistaa tätä tiedostoa",
"182" => "hakemisto poistettu",
"183" => "sinulla ei ole valtuuksia poistaa tätä hakemistoa",
"184" => "hakemisto luotu",
"185" => "sinulla ei ole valtuuksia luoda hakemistoa",
"186" => "Luo uusi hakemisto",
"187" => "Hakemiston nimi",
"188" => "Luo uusi hakemisto",
"189" => "Hakemisto on jo olemassa. Valitse jokin toinen nimi hakemistolle.",
"190" => "Hakekmiston nimi täytyy antaa",
"191" => "Muokkaa",
"192" => "Tiedosto",
"193" => "Muokkaa tiedosto / hakemiston tietoja",
"194" => "objektin nimi vaihdettu.",
"195" => "sinulla ei ole valtuuksia nimetä tuota objektia uudestaan",
"196" => "Juurihakemisto ei ole oikein asetettu! Tarkista asetukset",
"197" => "Järjestä",
"198" => "uudelleen nimeäminen epäonnistui, koska saman niminen tiedosto oli jo olemassa.",
"199" => "Viimeisimmät lähetykset palveluun",
"200" => "Merkittävimmät lataukset palvelusta",
"201" => "uudelleen nimeäminen epäonnistui, tiedoston nimi ei ole sallittu.",

//
// New strings introduced in version 1.02
//
"202" => "url (osoite) on epäkelpo",
"203" => "tiedoston (http) osoite",
"204" => "Lähetä tiedosto http-osoitteella",

//
// New strings introduced in version 1.10
//
"205" => "Pysy aina kirjautuneena",
"206" => "Ei voida suorittaa, nimi ei ole sallittu",
"207" => "IP-osoite evätty",
"208" => "Käyttämästäsi IP-osoitteesta ei ole sallittua ottaa yhteyttä palveluun.",
"209" => "Lisätietoja ylläpitäjältä",

//
// New strings introduced in version 1.12
//
"210" => "Päivittäinen Mb-raja ylitetty",
"211" => "Kuukausittainen Mb-raja ylitetty",
"212" => "Päivittäinen Mb-latausraja palvelusta ylitetty",
"213" => "Kuukausittainen Mb-latausraja palvelusta ylitetty",
"214" => "Vahvista tieodosto",
"215" => "Tiedosto vahvistettu",
"216" => "Oletko varma että haluat poistaa",
"217" => "Sinulla ei ole valtuuksia vahvistaa tuota objektia",
"218" => "Tämä tiedosto tulee näkyviin jahka ylläpito on tarkistanut sen",
"219" => "Tiedostoselain"

);

//
// Send file e-mail configuration
//
$sendfile_email_subject = 'Haluamasi tiedosto';
$sendfile_email_body = '
Tässäpä tiedosto jonka halusit saada sähköpostiisi.

';
$sendfile_email_end = 'Terkuin,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Everyday digest";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'Vahvista sähköpostisoitteesi';
$confirm_email_body = 'Tervehdys %s!

Nyt vaaditaan sinulta hieman toimintaa, eli uusi sähköpostiosoitteesi täytyy vahvistaa palveluun.

Sinun vahvistustunnuksesi on: %s

Tämä on suoraviivainen toiminto:
1. Surffaa osoitteeseen %s.
2. Kirjoita käyttäjätunnuksesi ja vahvistustunnuksesi
3. Paina \'Vahvista\' painiketta.



';
$confirm_email_end = 'Terkuin,';

//
// Send password e-mail configuration
//
$chpass_email_subject = 'Uusi salasanasi';
$chpass_email_body = 'Parahin käyttäjä,

Uusi salasanasi palveluun on %s

';
$chpass_email_end = 'Terkuin,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Vahvista rekisteröitymisesi';
$register_email_body = 'Parahin %s,

Kiitoksia rekisteröitymisestäsi!

Nyt vaaditaan sinulta hieman toimintaa, eli käyttäjätunnuksesi täytyy vahvistaa palveluun.

Sinun vahvistustunnuksesi on: %s
(Huomaa: Tämä _ei_ ole salasanasi)

Tämä on suoraviivainen toiminto:
1. Surffaa osoitteeseen %s.
2. Kirjoita käyttäjätunnuksesi ja vahvistustunnuksesi
3. Paina \'Vahvista\' painiketta.


';
$register_email_end = 'Terkuin,';
?>