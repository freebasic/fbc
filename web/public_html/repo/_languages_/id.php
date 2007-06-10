<?php
/***************************************************************************
* id.php
* -------------------
* begin : Sunday', Aug 8', 2004
* copyright : ('C) 2002 Yanmarshus Bachtiar
* email : yan@bogor.net
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
"3" => "Maret",
"4" => "April",
"5" => "Mei",
"6" => "Juni",
"7" => "Juli",
"8" => "Agustus",
"9" => "September",
"10" => "Oktober",
"11" => "November",
"12" => "Desember",
"13" => "Hari ini",
"14" => "Kemarin",
"15" => "Nama File",
"16" => "Aksi",
"17" => "Ukuran",
"18" => "Sudah Dikirim",
"19" => "Pemilik",
"20" => "File Dikirim",
"21" => "File Lokal",
"22" => "Deskripsi File",
"23" => "Download",
"24" => "Pesan",
"25" => "Home",
"26" => "File",
"27" => "Cetak",
"28" => "Tutup",
"29" => "Kembali",
"30" => "File ini sudah dipindahkan",
"31" => "File tidak bisa dibuka",
"32" => "Kembali",
"33" => "Gagal mengirim file !",
"34" => "Anda harus memilih sebuah file",
"35" => "Kembali",
"36" => "File",
"37" => "sukses dikirim",
"38" => "File dengan nama",
"39" => "sudah ada",
"40" => "File berhasil dikirim",
"41" => "Bahasa sudah dipilih",
"42" => "Selamat Datang di PHP Advanced Transfer Manager",
"43" => "Total Disk Terpakai",
"44" => "Tampilkan file untuk semua hari",
"45" => "Arsip ZIP tidak valid!",
"46" => "Isi arsip:",
"47" => "Tanggal/Waktu",
"48" => "Direktori",
"49" => "Tidak diperkenankan mengirim file dengan nama %s!",
"50" => "melebihi ukuran yang diizinkan",
"51" => "Informasi",
"52" => "Pilih Skin",
"53" => "Skin",
"54" => "Selamat Datang",
"55" => "Waktu sekarang",
"56" => "User",
"57" => "Username",
"58" => "Mendaftar",
"59" => "Pendaftaran",
"60" => "Minggu",
"61" => "Senin",
"62" => "Selasa",
"63" => "Rabu",
"64" => "Kamis",
"65" => "Jumat",
"66" => "Sabtu",
"67" => "Kirim",
"68" => "Kirim file dengan email",
"69" => "File sudah dikirim ke alamat %s",
"70" => "File dikirim oleh user: %s",
"71" => "Login",
"72" => "Logout",
"73" => "Masuk",
"74" => "Anonim",
"75" => "Normal User",
"76" => "Power User",
"77" => "Administrator",
"78" => "Daerah privat",
"79" => "Daerah publik",
"80" => "Anda memasukkan user atau password yang tidak valid.",
"81" => "Profil",
"82" => "Lihat/edit profil",
"83" => "Password",
"84" => "Pilih bahasa",
"85" => "Pilih zona waktu",
"86" => "Waktu sekarang",
"88" => "Silahkan masukkan alamat email yang valid.",
"89" => "Pastikan alamat email anda aktif, karena kode aktivasi anda akan dikirim ke alamat email bersangkutan.",
"90" => "File sudah dikirim: ",
"91" => "Silahkan masukkan alamat email yang anda gunakan ketika registrasi.",
"92" => "Ukuran file: ",
"93" => "Silakan tulis nama dan password anda",
"94" => "Diharuskan untuk mendaftar. Silahkan anda mendaftar.",
"95" => "Pendaftaran tidak diperlukan. Anda bisa mendaftar jika menginginkan nama anda ditambahkan pada file yang dikirim. User lain tidak bisa menggunakan nama anda untuk mengirim file mereka.",

"96" => "Skin sudah dipilih.",
"97" => "Refresh",
"98" => "Silahkan masukkan nama login dan password anda",
"99" => "Belum terdaftar? - Mendaftar disini!",
"100" => "Anda lupa password?",
"101" => "Silahkan ke %s kembali %s dan coba lagi.",
"102" => "Anda telah logout.",
"103" => "Username tidak valid. Username tidak boleh lebih dari 12 karakter dan hanya diizinkan menggunakan alfabet dan huruf. Username juga dibolehkan menggunakan '-' dan '_'",
"104" => "Username '%s' sudah digunakan orang lain.",
"105" => "Konfirmasi password",
"106" => "Password tidak cocok.",
"107" => "Format email yang anda masukkan tidak valid.",
"108" => "Terima kasih anda telah mendaftar. Jangan lupa dengan password anda, karena password anda telah dienkripsi, sehingga kami juga tidak bisa mengetahui jika anda melupakannya. Jika anda lupa password, tersedia program yang akan membuat password baru secara acak dan mengirimkan ke email anda.",
"109" => "Anda bisa %s masuk ke Upload Center di sini. %s",
"110" => "Kode aktivasi sudah dikirim ke email anda. Anda harus mengaktifkan account dalam 2 hari, atau account anda akan dihapus secara otomatis.",
"111" => "Anda tidak tidak diizinkan men-download file ini",
"112" => "Aktivasi account",
"113" => "Silahkan aktivkan account anda",
"114" => "Kode aktivasi",
"115" => "Account anda telah aktif.",
"116" => "Silahkan %s masukkan disini %s.",
"117" => "Nama account atau kode aktivasi tidak valid.",
"118" => "Account sudah aktif.",
"119" => "Saya ingin menerima rangkuman file yang dikirim setiap hari melalui email.",
"120" => "Ganti password.",
"121" => "Password yang lama",
"122" => "Nama account yang dimasukkan tidak valid.",
"123" => "Alamat email yang dimasukkan tidak valid.",
"124" => "Password anda yang baru sudah dikirim melalui email.",
"125" => "tidak bisa dieksekusi, objek tidak ditemukan",
"126" => "Pengaturan konfigurasi account",
"127" => "Terapkan",
"128" => "Profil anda telah disimpan.",
"129" => "Password anda sudah diganti",
"130" => "Password anda tidak valid.",
"131" => "Anda harus memasukkan password baru.",
"132" => "Konfigurasi",
"133" => "Kirim",
"134" => "Bahasa & zona waktu",
"135" => "Statistik account",
"136" => "Account anda sudah dibuat:",
"137" => "Manajemen user",
"138" => "Lihat saja",
"139" => "Kirim saja",
"140" => "Account '%s' berhasil diganti",
"141" => "Terbaru",
"142" => "Semua",
"143" => "Alamat email yang baru baru berfungsi setelah konfirmasi. Kode konfirmasi sudah dikirim ke email anda yang baru. Baca instruksi yang ada dalam email tersebut.",
"144" => "",
"145" => "Silahkan konfirmasi alamat email anda yang baru.",
"146" => "Kode konfirmasi",
"147" => "Konfirmasi",
"148" => "Tidak ada yang dikonfirmasi.",
"149" => "Nama account atau kode konfirmasi tidak valid.",
"150" => "Alamat email anda yang baru '%s' sudah dikonfirmasi.",
"151" => "File sudah dikirim",
"152" => "File sudah diambil",
"153" => "File sudah dikirim dengan email",
"154" => "Account sudah dibuat",
"155" => "Waktu akses terakhir",
"156" => "Status",
"157" => "Status aktif",
"158" => "Menerima rangkuman",
"159" => "e-mail",
"160" => "Total:",
"161" => "account",
"162" => "Hapus account",
"163" => "Tampilkan %s account dari %s",
"164" => "Konfigurasi Upload Center",
"165" => "Edit file",
"166" => "Edit file",
"167" => "File %s sudah diganti",
"168" => "Simpan",
"169" => "Hapus",
"170" => "Hapus file",
"171" => "Duplikat",
"172" => "Ya",
"173" => "Tidak",
"174" => "Aktif",
"175" => "Tidak aktif",
"176" => "Tidak berhak",
"177" => "Maaf, server tidak bisa menjalankan email.",
"178" => "Pendaftaran anda gagal. Silahkan coba di lain waktu.",
"179" => "Silahkan coba lagi nanti.",
"180" => "file telah dihapus",
"181" => "anda tidak berhak menghapus file ini",
"182" => "direktori telah dihapus",
"183" => "anda tidak berhak menghapus direktori ini",
"184" => "direktori telah dibuat",
"185" => "anda tidak berhak membuat direktori",
"186" => "Buat direktori baru",
"187" => "Nama direktori",
"188" => "Buat direktori",
"189" => "direktori sudah ada, gunakan nama yang lain",
"190" => "anda harus menulis nama direktori",
"191" => "Modifikasi",
"192" => "Nama file",
"193" => "Modifikasi detil file/direktori",
"194" => "nama objek berhasil diganti.",
"195" => "anda tidak berhak mengganti nama objek ini",
"196" => "Root path tidak benar. Periksa konfigurasi",
"197" => "Urut berdasarkan",
"198" => "gagal mengganti nama, file tersebut sudah ada",
"199" => "Pengiriman terakhir",
"200" => "Download terbanyak",
"201" => "gagal mengganti nama, nama tidak valid",

//
// New strings introduced in version 1.02
//
"202" => "URL yang anda maksud tidak valid",
"203" => "Alamat http file",
"204" => "Kirim file melalui alamat http",

//
// New strings introduced in version 1.10
//
"205" => "Selalu login",
"206" => "Tidak bisa dieksekusi: nama tidak diizinkan",
"207" => "Alamat IP diblokir",
"208" => "Alamat IP anda diblokir oleh Administrator!",
"209" => "Untuk info selanjutnya hubungi Administrator",

//
// New strings introduced in version 1.12
//
"210" => "Kuota perhari telah terlampaui",
"211" => "Kuota perbulan telah terlampaui",
"212" => "Kuota download perhari telah terlampaui",
"213" => "Kuota download perbulan telah terlampaui",
"214" => "Validasi file",
"215" => "File sudah divalidasi",
"216" => "Anda yakin akan menghapus",
"217" => "anda tidak berhak memvalidasi objek tersebut",
"218" => "File ini terdaftar setelah validasi oleh Administrator",
"219" => "Melihat file"

);

//
// Send file e-mail configuration
//
$sendfile_email_subject = 'File yang diminta';
$sendfile_email_body = '
Ini file yang anda minta melalui email

';
$sendfile_email_end = 'Salam,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Rangkuman setiap hari";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'Konfirmasi email baru';
$confirm_email_body = 'Salam %s,

Untuk keamanan, maka email anda yang baru perlu dikonfirmasi.

Kode konfirmasi anda adalah: %s

Aktivasi alamat email dengan langkah berikut:
1. Kunjungi di alamat %s dan kami akan memandu anda.
2. Masukkan nama account anda dan kode konfirmasi.
3. Klik pada tombol \'Konfirmasi\'.

';
$confirm_email_end = 'Salam,';

//
// Send password e-mail configuration
//
$chpass_email_subject = 'Password baru';
$chpass_email_body = 'Salam,

Password anda yang baru: %s

';
$chpass_email_end = 'Salam,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Konfirmasi pendaftaran';
$register_email_body = 'Salam %s,

Terima kasih anda telah mendaftar.

Demi keamanan, maka account anda harus melalui proses aktivasi.

Kode aktivasi anda adalah: %s
(catatan: ini bukan password anda)

Untuk aktivasi account anda dengan langkah:
1. Kunjungi alamat %s dan anda akan dipandu
2. Masukkan nama account dan kode aktivasi anda
3. Klik tombol \'Aktivasi acount\'

';
$register_email_end = 'Salam,';
?>