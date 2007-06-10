<?php
/***************************************************************************
 *                                   vi.php
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

$headerpage="include/header.htm"; // The optional header file (can absent)
$footerpage="include/footer.htm"; // The footer file (must present!)
$infopage="include/info.htm"; // The optional info file (can absent)

$charsetencoding=""; // The encoding for national symbols (i.e. for cyryllic must be "windows-1251")
$uploadcentercaption="PHP Advanced Transfer Manager";
$uploadcentermessage="phpATM";

$mess=array(
"0" => "",
"1" => "Thang Gieng",
"2" => "Thang Hai",
"3" => "Thang Ba",
"4" => "Thang Tu",
"5" => "Thang Nam",
"6" => "Thang Sau",
"7" => "Thang Bay",
"8" => "Thang Tam",
"9" => "Thang Chin",
"10" => "Thang Muoi",
"11" => "Thang Muoi Mot",
"12" => "Thang Muoi Hai",
"13" => "Hom nay",
"14" => "Hom qua",
"15" => "Ten",
"16" => "Danh Gia",
"17" => "Size",
"18" => "Post len ngay",
"19" => "Tac gia",
"20" => "Post file",
"21" => "File tren may",
"22" => "Mieu ta",
"23" => "Tai ve",
"24" => "Thu tu",
"25" => "Trang dau",
"26" => "File",
"27" => "In ra",
"28" => "Dong lai",
"29" => "Quay ve",
"30" => "File nay da duoc xoa",
"31" => "Khong the mo file nay",
"32" => "Quay ve",
"33" => "Co van de trong viec post file nay !",
"34" => "Ban phai chon file",
"35" => "Quay ve",
"36" => "File",
"37" => "File nay da duoc goi len",
"38" => "Co mot file voi ten",
"39" => "da ton tai",
"40" => "File da duoc goi len thang cong",
"41" => "Ngon ngu da duoc chon",
"42" => "Chuc mung cac ban da den voi phan mem quan ly trao doi file va thu muc",
"43" => "Tong cong bo nho da duoc su dung",
"44" => "Tat ca cac file",
"45" => "Luu tru ZIP khong co gia tri!",
"46" => "Noi dung luc tru :",
"47" => "Ngay/Gio",
"48" => "Thu muc",
"49" => "Khong the goi file ten %s!",
"50" => "Da qua tai khoi luong cho phep",
"51" => "Thong tin",
"52" => "hay chon mot Skin",
"53" => "Skin",
"54" => "Chuc mung ban ",
"55" => "Gio dia phuong",
"56" => "Nguoi dung",
"57" => "Ten nguoi dung",
"58" => "Dang ky",
"59" => "Dang ky",
"60" => "Chu nhat",
"61" => "Thu Hai",
"62" => "Thu Ba",
"63" => "Thu Tu",
"64" => "Thu Nam",
"65" => "Thu Sau",
"66" => "Thu Bay",
"67" => "Goi di",
"68" => "Goi file",
"69" => "File nay da duoc goi den dia chi : %s .",
"70" => "Fi duoc goi boi : %s",
"71" => "Connex",
"72" => "Déconnex",
"73" => "Vao",
"74" => "Nac danh",
"75" => "Nguoi dung thuong",
"76" => "Nguoi dung cao cap",
"77" => "Quan tri",
"78" => "Vung cam",
"79" => "Noi danh cho tat ca moi nguoi",
"80" => "Ten nguoi dung hoac co mat ma khong dung.",
"81" => "Tai khoan cua tui",
"82" => "Xem tai khoan cua tui",
"83" => "Mat ma",
"84" => "Ngon ngu",
"85" => "Mui gio",
"86" => "Mui gio cua ban",
"88" => "Xin dzui long go dia chi email dung.",
"89" => "Hay xem lai dia chi mail cua ban da kich hoat chua ? Mat ma se duoc goi den dia chi nay.",
"90" => "File nay da duoc goi di : ",
"91" => "Hay go vao dia chi ma ban da go lan dau tien.",
"92" => "Kich co cua File : ",
"93" => "Xin dzui long giu ky ten nguoi dung va mat ma ",
"94" => "Can phai dang ky. Chan cho gi nua ?",
"95" => "Co the dang ky hay khong nhung de goi File va ghi ten ban duoc kem theo file, khong ai khac co the dung ten cua ban de goi file len.",

"96" => "Skin duoc chon.",
"97" => "Tai ve lan nua ",
"98" => "Hay go va ten nguoi dung va mat ma",
"99" => "Chua dang ky ? Nhan vao day !",
"100" => "Hu hu tui quen mat ma roi ?",
"101" => "Quay ve %s trang %s va thu lai deee! .",
"102" => "Ban da deconnexion.",
"103" => "Ten nguoi dung khong duoc qua 12 ky tu va chi duoc dung ky tu latin.",
"104" => "Ten '%s' nay da duong dung .",
"105" => "Go lai mat ma ",
"106" => "Hi hi mat ma khong dung roi.",
"107" => "Dai chi khogn dung roi.",
"108" => "Cam on ban da dang ky.Xin dung quen mat ma.Chung tui da ma hoa no va chiu khong lay ra duoc.Nhung
ban co the dung chuc nang tu dong de goi mat ma ve dia chi email cua ban.",
"109" => "Vao trung tam qua ly bay gio deee ! . %s",
"110" => "Mat ma da duoc goi ve dia chi cua ban. Can phai kich hoat no trong vong 24 gio.
Neu khong no se tu dong xoa do !",
"111" => "Hi hi da xin phep dau chu ?",
"112" => "Kich hoat tai khoan",
"113" => "Xin vui long kich hoat",
"114" => "mat ma kich hoat",
"115" => "tai khoan cua ban dang hoat dong day !.",
"116" => "Xin dzui long %s vao day %s.",
"117" => "Ten va mat ma khong dung.",
"118" => "Tai khoan nay dang hoat dong ban ui !.",
"119" => "Tui muon duoc thong bao cai file goi len bang thu.",
"120" => "Thay doi mat ma.",
"121" => "Mat ma cu",
"122" => "Choi ah, ten nay chu co ai dung het tron !.",
"123" => "Dia chi khong dung.",
"124" => "Mat ma moi da duoc goi den cho ban.",
"125" => "Khong thuc hien duoc ",
"126" => "Thich tai khoan cua ban nhu the nao ?",
"127" => "Ap dung",
"128" => "Tai khoan da duoc ghi nho.",
"129" => "Mat ma thay doi roi day .",
"130" => "Ui chà ! Mat ma cu sai roi ban oi ! .",
"131" => "Phai go mat ma moi chu .",
"132" => "Tham so",
"133" => "Goi len",
"134" => "Ngon ngu va mui gio",
"135" => "So lieu",
"136" => "Tai khoan cua ban da duoc tao:",
"137" => "Quan ly nguoi dung",
"138" => "Chi duoc nhin thoi ",
"139" => "Chi duoc goi len",
"140" => "tai khoan '%s' da duoc thay doi",
"141" => "Gan day nhat",
"142" => "Tat ca",
"143" => "Dia chi moi se co hieu luc sau khi duoc chap nhan.
mat ma se duoc goi den dia chi cua ban.
Hay xem chi dan trong thu.",
"144" => "",
"145" => "Xac nhan lai dia chi moi.",
"146" => "Mat ma",
"147" => "Xac nhan",
"148" => "Co gi ma xac nhan ? .",
"149" => "Ten va tai khoan sai roi.",
"150" => "Dia chi moi '%s' duoc xac nhan.",
"151" => "File duoc goi len",
"152" => "File tai ve",
"153" => "File goi deeeeeeeeee",
"154" => "Tao tai khoan",
"155" => "Lan ghe lai gan day",
"156" => "Trang thai",
"157" => "Trang thai hoat dong",
"158" => "Nhan thong bao",
"159" => "Email",
"160" => "Tong cong:",
"161" => "Tai khoan(s)",
"162" => "Xoa tai khoan",
"163" => "Xem %s tai khoan (s) tren %s",
"164" => "Thong so ",
"165" => "Xem file",
"166" => "Xem file",
"167" => "File %s da duoc thay doi",
"168" => "Ghi",
"169" => "Xoa",
"170" => "Xoa file",
"171" => "Guong",
"172" => "Co",
"173" => "Khong",
"174" => "Hoat dong",
"175" => "Khong hoat dong",
"176" => "Khong duoc phep",
"177" => "Xin loi cai phai server mail chua hoat dong.",
"178" => "Ghi ten bay gio khong duoc roi. Thu lai sau nhe ?.",
"179" => "Xin vui long thu lai.",
"180" => "Xoa duoc cai file nay roi",
"181" => "Ne sao ma xoa file cua nguoi ta ?",
"182" => "Thu muc da duyoc xoa",
"183" => "Ne sao ma xoa thu mua cua nguoi ta",
"184" => "Thu muc tao xong roi ",
"185" => "Ne ban lam chi co quyen tao thu muc ?",
"186" => "Tao thu muc moi",
"187" => "Ten thu muc",
"188" => "Tao",
"189" => "ten thu muc nay da duoc tao roi, tim ten khac di !",
"190" => "Eh ban cung co ten ma ! sao ko dat ten cho thu muc ? ",
"191" => "thay doi",
"192" => "Thu File",
"193" => "Thay doi fiel / Chi tiet thu muc",
"194" => "Doi tuong da duoc doi ten.",
"195" => "Ban khong co quyen dau ",
"196" => "Duong dan khong dung !",
"197" => "Sap xep lai",
"198" => "Khong the doi ten duoc, da co ten nhu vay roi ! ",
"199" => "Moi",
"200" => "Top tai ve",
"201" => "Ten nay khong duoc phep ",

//
// New strings introduced in version 1.02
//
"202" => "Dia chi trang web sai rui !",
"203" => "File bang dia chi http ",
"204" => "Dua file len boi http",

//
// New strings introduced in version 1.10
//
"205" => "Connect lien tuc ",
"206" => "Ten nay khong the duoc roi",
"207" => "Dia chi Ip bi cam roi !",
"208" => "Dia chi Ip cua ban da bi nha quan tri cam roi !",
"209" => "Hay lien he voi nguoi qua tri di ! Se co huong giai quyet thoi ",

//
// New strings introduced in version 1.12
//
"210" => "Ngay hom nay dung nhieu qua roi !",
"211" => "Thang nay tieu du qua roi ",
"212" => "Ngay hom nay dung nhieu qua roi",
"213" => "Thang nay dung nhieu qua roi",
"214" => "Nhan vao",
"215" => "File da duoc chap nhan",
"216" => "Co thuc su muon xoa di khong ? ",
"217" => "Khong co quyen dau",
"218" => "Phai cho nguoi qua tri coi lai da !",
"219" => "Xem File"
);

//
// Send file e-mail configuration
//
$sendfile_email_subject = 'Fichier demandé';
$sendfile_email_body = '
Voici le fichier que vous avez demandé par Email

';
$sendfile_email_end = 'Vôtre,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Notification quotidienne";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'confirmation de nouvelle adresse';
$confirm_email_body = 'Cher %s,

Parce que votre sécurité est importante pour nous, votre nouvel email doit être confirmé sur réception de celui-ci.

Votre code de confirmation personnel est: %s

L\'activation de l\'email est simple:
1. Visitez-nous à %s et vous serez guidé pas à pas
2. Entrez votre nom d\'utilisateur et code de confirmation.
3. Cliquez sur le bouton \'Confirmation\'.

';
$confirm_email_end = 'Vôtre,';

//
// Send password e-mail configuration
//
$chpass_email_subject = 'Nouveau mot de passe';
$chpass_email_body = 'Cher utilisateur,

Votre nouveau mot de passe est %s

';
$chpass_email_end = 'Vôtre,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Confirmation d\'inscription';
$register_email_body = 'Cher %s,

Merci de vous être inscris.

Parce que votre sécurité est importante pour nous, votre compte doit être confirmé sur réception de celui-ci.

Votre code d\'activation personnel est: %s
(veuillez noter que ce code n\'est pas votre mot de passe)

L\'activation de votre compte est simple:
1. Visitez-nous à %s et vous serez guidé pas à pas
2. Entrez votre nom d\'utilisateur et code d\'activation.
3. Cliquez sur le bouton \'Activer compte\'.

';
$register_email_end = 'Vôtre,'
?>