<?php
/***************************************************************************
* en.php
* -------------------
* begin : Tuesday', Aug 15', 2002
* copyright : ('C) 2002 Bugada Andrea
* email : phpATM@free.fr
* Translated by : awho/2005.2.15
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

$headerpage="include/header.htm"; // The optional header file (can absent)
$footerpage="include/footer.htm"; // The footer file (must present!)
$infopage="include/info.htm"; // The optional info file (can absent)

$charsetencoding=""; // The encoding for national symbols (i.e. for cyryllic must be "windows-1251")
$uploadcentercaption="PHP Advanced Transfer Manager";
$uploadcentermessage="phpATM";

$mess=array(
"0" => "",
"1" => "一月",
"2" => "二月",
"3" => "三月",
"4" => "四月",
"5" => "五月",
"6" => "六月",
"7" => "七月",
"8" => "八月",
"9" => "九月",
"10" => "十月",
"11" => "十一月",
"12" => "十二月",
"13" => "今日",
"14" => "昨日",
"15" => "檔案名稱",
"16" => "Actions",
"17" => "檔案大小",
"18" => "上傳時間",
"19" => "擁有者",
"20" => "上傳檔案",
"21" => "本地檔案",
"22" => "檔案說明",
"23" => "下載",
"24" => "Order",
"25" => "根目錄",
"26" => "檔案",
"27" => "列印",
"28" => "關閉",
"29" => "返回",
"30" => "此檔案已被移除",
"31" => "無法開啟檔案",
"32" => "返回",
"33" => "上傳檔案時發生錯誤 ! 檔案名稱 ",
"34" => "請指定一個檔案",
"35" => "返回",
"36" => "檔案",
"37" => " 上傳成功 ",
"38" => "檔案名稱為",
"39" => "已存在",
"40" => "檔案上傳成功 ",
"41" => "Language has succesfully choosen",
"42" => "歡迎使用 PHP Advanced Transfer Manager",
"43" => "已使用空間",
"44" => "Show files for all days",
"45" => "Invalid ZIP archive!",
"46" => "Archive contents:",
"47" => "Date/Time",
"48" => "檔案所在資料夾",
"49" => "It is prohibited to upload file with name %s!",
"50" => "超過允許的檔案大小",
"51" => "Information",
"52" => "Select Skin",
"53" => "Skin",
"54" => "Welcome",
"55" => "Current time",
"56" => "User",
"57" => "使用者名稱",
"58" => "註冊",
"59" => "註冊",
"60" => "星期日",
"61" => "星期一",
"62" => "星期二",
"63" => "星期三",
"64" => "星期四",
"65" => "星期五",
"66" => "星期六",
"67" => "傳送",
"68" => "郵寄檔案",
"69" => "檔案已郵寄到 %s .",
"70" => "File uploaded by user: %s",
"71" => "登入",
"72" => "登出",
"73" => "登入",
"74" => "匿名",
"75" => "一般用戶",
"76" => "Power 用戶",
"77" => "管理者",
"78" => "Private zone",
"79" => "Public zone",
"80" => "您輸入的帳號或密碼不正確.",
"81" => "個人資料",
"82" => "檢視/編輯 我的個人資料",
"83" => "密碼",
"84" => "選擇語系",
"85" => "選擇時區",
"86" => "Your current time",
"88" => "請輸入正確的郵件地址.",
"89" => "請確您的e-mail位址是有效的, 因為我們會將您帳號的啟動碼寄送到您的e-mail信箱.",
"90" => "File uploaded: ",
"91" => "請輸入您註冊時的郵件地址. ",
"92" => "File size: ",
"93" => "請將您的名稱和密碼抄寫下來",
"94" => "Registration is necessary. Please, register.",
"95" => "Registration is not necessary. You can register if you wish add your name to all your uploaded files. Nobody other can use your name to upload their files.",

"96" => "Skin selected.",
"97" => "更新",
"98" => "請輸入您的帳號和密碼",
"99" => "還沒註冊嗎? - 註冊!",
"100" => "忘記密碼?",
"101" => "請回 %s 上一頁 %s 檢查後再試一次.",
"102" => "您已成功登出.",
"103" => "使用者名稱不正確. The name must be not longer than 12 symbols and can consists of latin symbols and digits only. Name can also contain '-', '_', and space symbols inside.",
"104" => "帳號名稱 '%s' 已有人使用. ",
"105" => "密碼確認",
"106" => "密碼不正確.",
"107" => "您所輸入的郵件地址格式不正確.",
"108" => "感謝您的註冊. 請記住您的密碼，因密碼已加密，所以我們無法替您找回您的原始密碼. 如果您忘記密碼，我們也提供一個簡單的程式來寄送一個新的密碼到您的郵件信箱.",
"109" => "您已可 %s 進入檔案上傳中心 %s",
"110" => "系統已將啟動碼寄送給您了. 您須要在兩天內啟動您的帳號，否則系統會自動刪除您的帳號. ",
"111" => "您無權限下載此檔案",
"112" => "啟動帳號",
"113" => "請啟動您的帳號",
"114" => "啟動碼",
"115" => "您的帳號已啟動.",
"116" => "Please %s enter here %s.",
"117" => "您輸入的帳號或啟動碼不正確.",
"118" => "此帳號已被啟動.",
"119" => "I wish to receive to my e-mail everyday digest of uploaded files.",
"120" => "變更密碼.",
"121" => "原始密碼",
"122" => "無此帳號.",
"123" => "此郵件地址不正確.",
"124" => "已將您的新密碼寄到您的郵件地址.",
"125" => "can not execute, object not found",
"126" => "個人化設定",
"127" => "確認",
"128" => "個人設定已變更.",
"129" => "密碼已變更.",
"130" => "原始密碼不正確.",
"131" => "請輸入新的密碼.",
"132" => "Configuration",
"133" => "Upload",
"134" => "語系 & 時區",
"135" => "帳號統計資料",
"136" => "您的帳號建立於：",
"137" => "帳號管理",
"138" => "Viewer (僅檢視功能)",
"139" => "Uploader (僅上傳功能)",
"140" => "使用者帳號 '%s' 已變更",
"141" => "Latest",
"142" => "All",
"143" => "新的郵件地址會在您確認後生效. 確認碼已寄送到您的郵件信箱. 請參閱確認信中的說明.",
"144" => "",
"145" => "請確認您新的郵件地址.",
"146" => "確認碼",
"147" => "確認",
"148" => "Nothing to confirm.",
"149" => "您所輸入的郵件地址或確認碼不正確.",
"150" => "您的郵件地址 '%s' 已確認.",
"151" => "上傳檔案數量",
"152" => "下載檔案數量",
"153" => "已郵寄的檔案",
"154" => "帳號建立時間",
"155" => "最近一次登入時間",
"156" => "狀態",
"157" => "狀況設定",
"158" => "Receive digest",
"159" => "郵件地址",
"160" => "帳號總數:",
"161" => "使用者",
"162" => "刪除帳號",
"163" => "Shown %s account(s) of %s",
"164" => "Configure Upload Center",
"165" => "Edit files",
"166" => "編輯檔案",
"167" => "File %s has been changed succesfully",
"168" => "Save",
"169" => "刪除",
"170" => "Delete files",
"171" => "Mirror",
"172" => "Yes",
"173" => "No",
"174" => "啟動",
"175" => "未啟動",
"176" => "未認證",
"177" => "抱歉，伺服器無法使用郵寄功能.",
"178" => "註冊失敗. 請稍後再試.",
"179" => "請稍後再試.",
"180" => "檔案已被刪除",
"181" => "您無刪除此檔案之權限",
"182" => " 資料夾已刪除成功 ",
"183" => "你無刪除此資料夾之權限",
"184" => "資料夾已建立",
"185" => "您無建立資料夾之權限",
"186" => "建立新資料夾",
"187" => "資料夾名稱",
"188" => "建立",
"189" => "資料夾名稱相同，請變更資料夾名稱",
"190" => "您必須輸入資料夾名稱",
"191" => "變更",
"192" => "檔案名稱",
"193" => "變更檔案 / 資料夾 資訊",
"194" => "變更完成.",
"195" => "you don't have permission to rename that object",
"196" => "The root path is not correct. Check the settings",
"197" => "排序方式",
"198" => "更改檔名失敗，檔案已存在",
"199" => "最新上傳檔案",
"200" => "熱門下載檔案",
"201" => " 更改檔名失敗，此名稱不被允許 ",

//
// New strings introduced in version 1.02
//
"202" => " 您所輸入的檔案網址不正確 ",
"203" => "檔案網址",
"204" => "上傳網路檔案",

//
// New strings introduced in version 1.10
//
"205" => "自動登入",
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
"214" => "檔案確認",
"215" => "檔案已確認",
"216" => "Are you sure to delete",
"217" => "you don't have permission to validate that object",
"218" => "此檔案將會在管理員確認後列出",
"219" => "File viewer"

);

//
// Send file e-mail configuration
//
$sendfile_email_subject = 'Requested file';
$sendfile_email_body = '
Here the file you requested by mail

';
$sendfile_email_end = 'Regards,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Everyday digest";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'Confirm new e-mail';
$confirm_email_body = 'Dear %s,

Because your security is importance to us, your new e-mail address will need to be confirmed upon receipt.

Your personal confirmation code is: %s

Activating e-mail address is simple:
1. Visit us at %s and we will guide you through the process
2. Enter your account name and confirmation code.
3. Click on the \'Confirm\' button.

';
$confirm_email_end = 'Regards,';

//
// Send password e-mail configuration
//
$chpass_email_subject = 'New password';
$chpass_email_body = 'Dear user,

Your new password is %s

';
$chpass_email_end = 'Regards,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Confirm registration';
$register_email_body = 'Dear %s,

Thank You for registration.

Because your security is importance to us, your account will need to be activated upon receipt.

Your personal activation code is: %s
(please note: this is not your password)

Activating Your account is simple:
1. Visit us at %s and we will guide you through the process
2. Enter your account name and activation code.
3. Click on the \'Activate account\' button.

';
$register_email_end = 'Regards,';
?> 