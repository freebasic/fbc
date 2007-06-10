<?php
/***************************************************************************
 *                                   tr.php
 *                            -------------------
 *   begin                : Tuesday', Mar 26', 2004
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

$headerpage="include/header.htm";    // The optional header file (can absent)
$footerpage="include/footer.htm";    // The footer file (must present!)
$infopage="include/info.htm";        // The optional info file (can absent)

$charsetencoding="windows-1254";                 // The encoding for national symbols (i.e. for cyryllic  must be "windows-1251")
$uploadcentercaption="PHP Advanced Transfer Manager";
$uploadcentermessage="phpATM";

$mess=array(
"0" => "",
"1" => "Ocak",
"2" => "Þubat",
"3" => "Mart",
"4" => "Nisan",
"5" => "Mayýs",
"6" => "Haziran",
"7" => "Temmuz",
"8" => "Aðustos",
"9" => "Eylül",
"10" => "Ekim",
"11" => "Kasým",
"12" => "Aralýk",
"13" => "Bugün",
"14" => "Dün",
"15" => "Dosya Adý",
"16" => "Popülarite",
"17" => "Boyutu",
"18" => "Yüklenen",
"19" => "Sahibi",
"20" => "Dosya Yükle",
"21" => "Yerel Dosya",
"22" => "Dosya Tanýmý",
"23" => "Yükle",
"24" => "Sýrala",
"25" => "Anasayfa",
"26" => "Dosya",
"27" => "Yazdýr",
"28" => "Kapat",
"29" => "Geri Git",
"30" => "Bu dosya kaldýrýlmýþtýr",
"31" => "Dosyayý açamýyorum",
"32" => "Geri Git",
"33" => "Dosyayý yüklerken hata oluþtu !",
"34" => "Bir dosya seçmelisiniz",
"35" => "Geri",
"36" => "Dosya",
"37" => "baþarýlý bir þekilde yüklendi",
"38" => "Dosya adý",
"39" => "zaten var",
"40" => "Dosya baþarýlý bir þekilde yüklendi",
"41" => "Dil baþarýlý bir þekilde seçildi",
"42" => "Php Geliþmiþ Transfer Yöneticisine hoþ geldiniz",
"43" => "Toplam kullanýlan alan",
"44" => "Tüm günler içindeki dosyalarý göster",
"45" => "Yanlýþ/Hasarlý ZIP dosyasý!",
"46" => "Arþiv içerikleri:",
"47" => "Gün/Zaman",
"48" => "Dizin",
"49" => "%s isminde bir dosya yüklemeniz yasaktýr!",
"50" => "izin verilen dosya boyutunu aþýyor",
"51" => "Bilgi",
"52" => "Görünüm seçin",
"53" => "Görünüm",
"54" => "Hoþgeldiniz",
"55" => "Þu anki zaman",
"56" => "Kullanýcý",
"57" => "Kullanýcý Adý",
"58" => "Kayýt Ol",
"59" => "Kaydolma",
"60" => "Pazar",
"61" => "Pazartesi",
"62" => "Salý",
"63" => "Çarþamba",
"64" => "Perþembe",
"65" => "Cuma",
"66" => "Cumartesi",
"67" => "Gönder",
"68" => "Dosyayý maille gönder",
"69" => "Dosya baþarýyla %s addresine gönderilmiþtir.",
"70" => "Kullanýcý tarafýndan yüklenen dosya: %s",
"71" => "Sisteme Giriþ",
"72" => "Sistemden Çýkýþ",
"73" => "Gir",
"74" => "Anonymous",
"75" => "Normal User",
"76" => "Power User",
"77" => "Administrator",
"78" => "Private zone",
"79" => "Public zone",
"80" => "Yanlýþ bir kullanýcý adý veya þifre girdiniz.",
"81" => "Profilim",
"82" => "Profilimi görüntüle/deðiþtir",
"83" => "Þifre",
"84" => "Dil seçiniz",
"85" => "Zaman dilimi seçiniz",
"86" => "Þu anki zaman",
"88" => "Lütfen geçerli bir e-mail adresi giriniz.",
"89" => "E-mail hesabýnýzýn aktif olduðuna emin olun, çünkü size özel aktivasyon kodunuz bu e-mail adresine gönderilecektir.",
"90" => "Dosya yüklendi: ",
"91" => "Lütfen kayýt sýrasýnda yazdýðýnýz e-mail hesabýnýzý giriniz.",
"92" => "Dosya boyutu: ",
"93" => "Lütfen isminizi ve þifrenizi yazýnýz",
"94" => "Kayýt olmak gereklidir. Lütfen kayýt olunuz.",
"95" => "Kayýt olmanýz gerekmemektedir. Eðer tüm yüklediðiniz dosyalara isminizi eklemek isterseniz kayýt olabilirsiniz. Baþka hiçkimse kendi dosylarýný yüklemek için sizin adýnýzý kullanamaz.",
"96" => "Görünüm seçildi.",
"97" => "Yenile",
"98" => "Lütfen kayýt isminizi ve þifrenizi giriniz",
"99" => "Hala kayýt olmadýnýzmý? - Buradan kayýt olun!",
"100" => "Þifrenizimi unuttunuz?",
"101" => "Lütfen, geri %s gidin %s ve tekrar deneyin.",
"102" => "Baþarýlý olarak sistemden çýktýnýz.",
"103" => "Kullanýcý adý geçersiz. Kullanýcý adý 12 sembolden uzun olmamalý ve latin harfleri ve numaralardan oluþmalýdýr. Kullanýcý adý ayný zamanda '-', '_', ve boþluk sembollerini içinde barýndýrmamalýdýr.",
"104" => "Seçmiþ olduðunuz '%s' baþkasý tarafýndan alýnmýþtýr.",
"105" => "Þifreyi doðrula",
"106" => "Þifreler birbirleriyle uymuyor.",
"107" => "Girilen e-mail formatý geçersizdir.",
"108" => "Kayýt olduðunuz için teþekkürler. Þifreniz veritabanýmýzda kripte edildiði için þifrenizi size geri bildiremiyoruz, bu sebeple lütfen þifrenizi unutmayýnýz. Ne var ki þifrenizi unutmanýz durumunda emailinize yeni ve rasgele bir þifre yaratýlýp gönderilecektir.",
"109" => "Buradan %s Yükleme alanýna giriþ yapabilirsiniz. %s",
"110" => "Aktivasyon kodunuz emailinize gönderilmiþtir. 2 gün içinde hesabýnýzý aktive etmezseniz hesabýnýz otomatik olarak silinecektir.",
"111" => "Bu dosyayý yüklemek için gerekli izne sahip deðilsiniz",
"112" => "Hesabý aktive et",
"113" => "Lütfen hesabýnýzý aktive ediniz",
"114" => "Aktivasyon kodu",
"115" => "Hesabýnýz þu anda aktiftir.",
"116" => "Lütfen %s buradan giriþ yapýnýz %s.",
"117" => "Girmiþ olduðunuz hesap adý veya aktivasyon kodu geçersizdir.",
"118" => "Hesap zaten aktif durumda.",
"119" => "Emailime günlük olarak yüklenen dosyalarýn listesini gönderilmesini istiyorum.",
"120" => "Þifrenizi deðiþtirin.",
"121" => "Eski þifreniz",
"122" => "Girilen hesap adý geçersizdir.",
"123" => "Girilen e-mail adresi geçersizdir.",
"124" => "Yeni þifreniz e-mailinize gönderilmiþtir.",
"125" => "iþlemi gerçekleþtiremiyorum, obje bulunamadý",
"126" => "Hesabýnýzdaki ayarlarý özelleþtirin",
"127" => "Uygula",
"128" => "Profiliniz kaydedilmiþtir.",
"129" => "Þifreniz deðiþtirilmiþtir.",
"130" => "Önceki þifrenizi yanlýþ girdiniz.",
"131" => "Yeni þifrenizi belrlemeniz gerekmektedir.",
"132" => "Ayarlar",
"133" => "Yükle",
"134" => "Dil & zaman dilimi",
"135" => "Hesap istatistikleri",
"136" => "Hesabýnýz yaratýlmýþtýr:",
"137" => "Kullanýcý yönetimi",
"138" => "Gözleyici (sadece izleyebilir)",
"139" => "Yükleyici (sadece yükleme yapabilir)",
"140" => "Hesap '%s' baþarýyla deðiþtirilmiþtir",
"141" => "Son",
"142" => "Hepsi",
"143" => "Yeni e-mail adresi onaylandýktan sonra aktif olur. Onay kodu e-maili adresinize gönderilmiþtir. E-mailin içindeki açýklamalara bakýnýz.",
"144" => "",
"145" => "Lütfen yeni e-mail adresinizi onaylayýn.",
"146" => "Onay kodu",
"147" => "Onayla",
"148" => "Onaylanacak birþey bulunamadý.",
"149" => "Girilen hesap adý veya onay kodu geçersizdir.",
"150" => "Yeni e-mail adresiniz '%s' onaylanmýþtýr.",
"151" => "Dosyalar yüklendi",
"152" => "Dosyalar indirildi",
"153" => "Dosyalar e-mail ile gönderildi",
"154" => "Hesap yaratýldý",
"155" => "Son eriþim zamaný",
"156" => "Durum",
"157" => "Aktif durum",
"158" => "Haberleri al",
"159" => "e-mail",
"160" => "Toplam:",
"161" => "hesap(s)",
"162" => "Hesabý sil",
"163" => "Gösterilen %s hesaplarýn(s) %s",
"164" => "Yükleme alanýný ayarla",
"165" => "Dosyalarý düzenle",
"166" => "Dosyayý düzenle",
"167" => "Dosya %s baþarýyla deðiþtirilmiþtir",
"168" => "Kaydet",
"169" => "Sil",
"170" => "Dosyalarý sil",
"171" => "alternatif",
"172" => "Evet",
"173" => "Hayýr",
"174" => "Aktif",
"175" => "Deaktif",
"176" => "Ýzinsiz",
"177" => "Üzgünüm ama sunucu posta programýný çalýþtýramadý.",
"178" => "Kayýdýnýz baþarýsýz oldu. Lütfen daha sonra tekrar deneyin.",
"179" => "Lütfen daha sonra tekrar deneyin.",
"180" => "Dosya baþarýyla silindi",
"181" => "Bu dosyayý silmek için yetkiniz bulunmamaktadýr",
"182" => "Dizin baþarýyla silinmiþtir",
"183" => "Bu dizini silmek için yetkiniz bulunmamaktadýr",
"184" => "dizin baþarýyla yaratýlmýþtýr",
"185" => "Dizin yaratmak için yetkiniz bulunmamaktadýr",
"186" => "Yeni dizin yarat",
"187" => "Dizin adý",
"188" => "Dizin yarat",
"189" => "dizin zaten mevcut, lütfen farklý bir ad seçiniz",
"190" => "bir dizin ismi belirlemek zorundasýnýz",
"191" => "Deðiþtir",
"192" => "Dosya Adý",
"193" => "Dosyayý deðiþtir / dizin detaylarý",
"194" => "objenin ismi baþarýyla deðiþtirildi.",
"195" => "bu dosyanýn ismini deðiþtirmek için yetkiniz yok",
"196" => "Kök dizini doðru deðil. Ayarlarý kontrol ediniz",
"197" => "Buna göre sýrala",
"198" => "isim deðiþtirilme baþarýsýz oldu, dosya zaten mevcut",
"199" => "Son yüklenenler",
"200" => "En çok yüklenenler",
"201" => "isim deðiþtirilme baþarýsýz oldu, bu isme izin verilmemektedir",

//
// New strings introduced in version 1.02
//
"202" => "Girdiðiniz url adresi geçersizdir",
"203" => "Dosya http adresi",
"204" => "Dosyayý http adresinden yükle",

//
// New strings introduced in version 1.10
//
"205" => "Her zaman kayýtlý kal",
"206" => "Ýþlem yapýlamýyor: bu isime izin verilmiyor",
"207" => "IP adresi bloke olmuþtur",
"208" => "Ip adresiniz yönetici tarafýndan bloke edilmiþtir!",
"209" => "Daha detaylý bilgi için yöneticiye baþvurunuz",


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
$sendfile_email_subject = 'Ýstenen dosya';
$sendfile_email_body = '
E-mail ile gönderilmesini istediðiniz dosya

';
$sendfile_email_end = 'Saygýlar,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Günlük liste";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'Yeni e-mailinizi onaylayýn';
$confirm_email_body = 'Sayýn %s,

Güvenliðiniz bizim için önemli olduðundan yeni e-mail adresinizin bu alýndýdan sonra onaylanmasý gerekmektedir.
Kiþisel onay kodunuz: %s

E-mail adresinizi aktive etmek çok basittir:
1. Sitemizi bu adresten %s ziyaret edin ve biz size bu iþlemler sýrasýnda yol gösterelim
2. Hesabýnýzýn adýný ve onay kodunu girin.
3. Onayla \'Confirm\' düðmesine týklayýn.

';
$confirm_email_end = 'Saygýlar,';

//
// Send password e-mail configuration
//
$chpass_email_subject = 'Yeni þifre';
$chpass_email_body = 'Sayýn kullanýcý,

Yeni þifreniz %s olarak atanmýþtýr

';
$chpass_email_end = 'Saygýlar,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Kaydý Onayla';
$register_email_body = 'Sayýn %s,

Kayýt olduðunuz için teþekkür ederiz.

Güvenliðiniz bizim için önemli olduðundan yeni e-mail adresinizin bu alýndýdan sonra onaylanmasý gerekmektedir.

Kiþisel onay kodunuz: %s
(not: bu sizin þifreniz deðildir)

E-mail adresinizi aktive etmek çok basittir:
1. Sitemizi bu adresten %s ziyaret edin ve biz size bu iþlemler sýrasýnda yol gösterelim
2. Hesabýnýzýn adýný ve onay kodunu girin.
3. Hesabý aktive et \'Activate account\' düðmesine týklayýn.


';
$register_email_end = 'Saygýlar,';
?>
