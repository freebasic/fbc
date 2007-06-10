<?php
/***************************************************************************
 *                                   fa.php
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

$charsetencoding="windows-1256";                 // The encoding for national symbols (i.e. for cyryllic  must be "windows-1251")
$uploadcentercaption="PHP Advanced Transfer Manager";
$uploadcentermessage="phpATM";

$mess=array(
"0" => "",
"1" => "January",
"2" => "February",
"3" => "March",
"4" => "April",
"5" => "May",
"6" => "June",
"7" => "July",
"8" => "August",
"9" => "September",
"10" => "October",
"11" => "November",
"12" => "December",
"13" => "«„—Ê“",
"14" => "œÌ—Ê“",
"15" => "‰«„ ›«Ì·",
"16" => "⁄„·Ì« ",
"17" => "ÕÃ„ ›«Ì·",
"18" => " «—ÌŒ «—”«· ›«Ì·",
"19" => "›—” ‰œÂ",
"20" => "›—” «œ‰ ›«Ì·",
"21" => "„”Ì— ›«Ì·",
"22" => " Ê÷ÌÕ« Ì œ— „Ê—œ ›«Ì·",
"23" => "œ«‰·Êœ",
"24" => "”›«—‘",
"25" => "’›ÕÂ «’·Ì",
"26" => "›«Ì·",
"27" => "ç«Å ò—œ‰",
"28" => "»” ‰",
"29" => "»—ê‘  »Â ⁄ﬁ»",
"30" => "«Ì‰ ›«Ì· Å«ò ‘œ.",
"31" => "⁄«Ã“ «“ »«“ ò—œ‰ ›«Ì·",
"32" => "»—ê‘  »Â ⁄ﬁ»",
"33" => "«‘ »«Â œ— ›—” «œ‰ ›«Ì· !",
"34" => "‘„« »«Ìœ Ìò ›«Ì· —« «‰ Œ«» ò‰Ìœ",
"35" => "»—ê‘ ",
"36" => "The file",
"37" => "«Ì‰ ›«Ì· »« „Ê›ﬁÌ  ›—” «œÂ  ‘œ",
"38" => "›«Ì· »« «”„",
"39" => "ﬁ»·« ÀÌ  ‘œÂ",
"40" => "«Ì‰ ›«Ì· »« „Ê›ﬁÌ  ›—” «œÂ  ‘œ",
"41" => "“»«‰ Ê—œ ‰Ÿ— ‘„« »« „Ê›ﬁÌ   €ÌÌ— œ«œÂ ‘œ",
"42" => "„—ò“ «—”«· ›«Ì·",
"43" => "ÕÃ„ ›«Ì·Â«Ì ›—” «œÂ ‘œÂ",
"44" => "œÌœ‰ ›«Ì·Â« »— «”«”  „«„ —Ê“Â«",
"45" => "›«Ì· “ÌÅ ‘„« »Ì «⁄ »«— «” ",
"46" => "„Õ Ê«Ì ¬—‘ÌÊ :",
"47" => " «—ÌŒ/“„«‰",
"48" => "œ«Ì—ò Ê—Ì",
"49" => "It is prohibited to upload file with name %s!",
"50" => "»Ì‘ —Ì‰ «‰œ«“Â „Ã«“ »—«Ì ¬Å·Êœ",
"51" => "—«Â‰„«",
"52" => "«‰ Œ«» ÅÊ” Â",
"53" => "ÅÊ” Â",
"54" => "ŒÊ‘ ¬„œÌœ",
"55" => "“„«‰ Ã«—Ì",
"56" => "ò«—»—",
"57" => "‰«„ ò«—»—Ì",
"58" => "À»  ‰«„",
"59" => "‰«„ ‰ÊÌ”Ì ò—œ‰",
"60" => "Ìò‘‰»Â",
"61" => "œÊ‘‰»Â",
"62" => "”Â ‘‰»Â",
"63" => "çÂ«—‘‰»Â",
"64" => "Å‰Ã ‘‰»Â",
"65" => "Ã„⁄Â",
"66" => "‘‰»Â",
"67" => "›—” «œ‰",
"68" => "«—”«· ›«Ì·",
"69" => "File has been mailed to %s address.",
"70" => "›«Ì· ›—” «œÂ ‘œÂ »« ‰«„ ò«—»—Ì: %s",
"71" => ">>> ›—” «œ‰ ›«Ì· <<<",
"72" => "Logout",
"73" => "Ê«—œ ò—œ‰",
"74" => "»Ì ‰«„",
"75" => "?ò«—»— „⁄„Ê·Ì",
"76" => "ò«—»— ÅÌ‘—› Â",
"77" => "„œÌ— ”«Ì ",
"78" => "»Œ‘ „Õ—„«‰Â",
"79" => "»Œ‘ ⁄„Ê„Ì",
"80" => "‰«„ ò«—»—Ì Ì« ò·„Â —„“ ‘„« «‘ »«Â „Ì »«‘œ.",
"81" => "Å—Ê›«Ì· „‰",
"82" => "œÌœ‰/ €ÌÌ— œ«œ‰ Å—Ê›«Ì·",
"83" => "?ò·„Â —„“",
"84" => "«‰ Œ«» “»«‰",
"85" => "«‰ Œ«» ”«⁄  „‰ÿﬁÂ",
"86" => "“„«‰ Ã«—Ì ‘„«",
"88" => "·ÿ›« ¬œ—” «Ì„Ì· ’ÕÌÕ —« Ê«—œ ò‰Ìœ",
"89" => "¬Ì« ‘„« „ÿ„∆‰ Â” Ìœ òÂ ¬œ—” «Ì„Ì· «‰ „ÊÃÊœ „Ì »«‘œ “Ì—« òœ ›⁄«· ò—œ‰ Õ”«Ì ‘„« »« ¬œ—” «Ì„Ì· «‰ «—”«· „Ì ‘Êœ.",
"90" => "›—” «œ‰ ›«Ì·: ",
"91" => "·ÿ›« œ— “„«‰ À»  ‰«„ ¬œ—” «Ì„Ì· ’ÕÌÕ —« Ê«—œ ò‰Ìœ.",
"92" => "ÕÃ„ ›«Ì·: ",
"93" => "·ÿ›« ‰«„ ò«—»—Ì Ê ò·„Â —„“ ŒÊœ —« »‰ÊÌ”Ìœ.",
"94" => "·ÿ›« À»  ‰«„ ò‰Ìœ.",
"95" => "Registration is not necessary. You can register if you wish add your name to all your uploaded files. Nobody other can use your name to upload their files.",

"96" => "ÅÊ” Â «‰ Œ«» ‘œÂ.",
"97" => " ò—«— ’›ŒÂ",
"98" => "·ÿ›« ‰«„ ò«—»—Ì Ê ò·„Â —„“ ŒÊœ —« Ê«—œ ò‰Ìœ",
"99" => "‘„« À»  ‰«„ ‰ò—œÂ «Ìœø «Ì‰Ã« ò·Ìò ò‰Ìœ »—«Ì À»  ‰«„ !",
"100" => "ò·„Â —„“ ŒÊœ —« ›—«„Ê‘ ò—œÂ «Ìœø",
"101" => "Please, go %s back %s and try again.",
"102" => "‘„« »« „Ê›ﬁÌ  «“ ”«Ì  Œ«—Ã ‘œÂ «Ìœ.",
"103" => "User name is invalid. The name must be not longer than 12 symbols and can consists of latin symbols and digits only. Name can also contain '-', '_', and space symbols inside.",
"104" => "The '%s' you picked has been taken.",
"105" => " ò—«— ò·„Â —„“",
"106" => "ò·„Â —„“ ‘„« „ÿ«»ﬁ  ‰œ«—œ.",
"107" => "¬œ—” «Ì„Ì· ‘„« «‘ »«Â «” .",
"108" => "ŒÊ«Â‘‰ ò·„Â —„“ ŒÊœ —« ›—«„Ê‘ ‰ò‰Ìœ œ— €Ì— «Ì‰ ’Ê—  ò·„Â —„“ ÃœÌœÌ »—«Ì ‘„« «—”«· „Ì ‘Êœ",
"109" => "You can %s enter to Upload Center here. %s",
"110" => "·ÿ›« «Ì„Ì· ŒÊœ —« çò ò‰Ìœ Ê —ÊÌ ·Ì‰òÌ òÂ »—«Ì ‘„« ›—” «œÂ ‘œÂ ò·Ìò ò‰Ìœ  « Õ”«» ‘„« ›⁄«· ‘Êœ.",
"111" => "‘„« «Ã«“Â ‰œ«—Ìœ ÂÌç ›«Ì·Ì —« œ«‰·Êœ ò‰Ìœ.",
"112" => "›⁄«· ò—œ‰ Õ”«»",
"113" => "·ÿ›« Õ”«» ò«—»—Ì ŒÊœ —« ›⁄«· ò‰Ìœ",
"114" => "òœ »Â ò«— «‰œ«Œ ‰ Õ”«» ò«—»—Ì ‘„«",
"115" => "Õ”«» ò«—»—Ì ‘„« «·«‰ ›⁄«· ‘œ.",
"116" => "Please %s enter here %s.",
"117" => "‰«„ ò«—»—Ì Ì« òœ »Â ò«— «‰œ«Œ ‰ Õ”«» ‘„« «‘ »«Â „Ì »«‘œ.",
"118" => "Õ”«» ò«—»—Ì ‘„« ﬁ»·« ›⁄«· ‘œÂ.",
"119" => "„‰ „Ì ŒÊ«Â„ Â— —Ê“ ê“«—‘Ì «“ ›«Ì·Â«Ì «—”«·Ì —« »êÌ—„.",
"120" => " €ÌÌ— œ«œ‰ ò·„Â —„“",
"121" => "ò·„Â —„“ ﬁ»·Ì",
"122" => "The entered account name does not exists.",
"123" => "«Ì‰ ¬œ—” «Ì„Ì· ‘„« »Ì «⁄ »·— «” .",
"124" => "ò·„Â —„“ ÃœÌœ ‘„« »Â ¬œ—” «Ì„Ì· «‰ ›—” «œÂ ‘œ.",
"125" => "‰„Ì  Ê«‰ ò«—Ì «‰Ã«„ »œÂ„ “Ì—« ›«Ì·Ì „ÊÃÊœ ‰„Ì »«‘œ",
"126" => " €ÌÌ— œ«œ‰ Õ”«» ò«—»—Ì «‰",
"127" => "À»  «ÿ·«⁄« ",
"128" => "Å—Ê›«Ì· ‘„«  €ÌÌ— œ«œÂ ‘œ.",
"129" => "ò·„Â —„“ ‘„«  €ÌÌ— œ«œÂ ‘œ.",
"130" => "ò·„Â —„“ ﬁ»·Ì ŒÊœ —« Ê«—œ ò‰Ìœ",
"131" => "‘„« »«Ìœ ò·„Â —„“ ÃœÌœ ŒÊœ —« „‘Œ’ ò‰Ìœ",
"132" => "ÅÌò— »‰œÌ",
"133" => "›—” «œ‰ ›«Ì·",
"134" => "“»«‰  & ”«⁄  „‰ÿﬁÂ",
"135" => "¬„«— Õ”«»Â«Ì ò«—»—Ì",
"136" => "Õ”«» ò«—»—Ì ‘„« «ÌÃ«œ ê—œÌœ:",
"137" => "‰«„ ò«—»—Ì „œÌ—Ì ",
"138" => "»Ì‰‰œÂ(›ﬁÿ  „«‘«çÌ)",
"139" => "«—”«· ò‰‰œÂ ›«Ì·(›ﬁÿ «—”«· ",
"140" => "Õ”«» ò«—»—Ì '%s' »« „Ê›ﬁÌ   €ÌÌ— œ«œÂ ‘œ",
"141" => "Latest",
"142" => "Â„Â",
"143" => "New e-mail address takes effect after confirmation. Confirmation code has been e-mailed to your new mail address. See instructions inside the letter.",
"144" => "",
"145" => "·ÿ›« ¬œ—” «Ì„Ì· «‰ —«  «ÌÌœ ò‰Ìœ.",
"146" => " «ÌÌœ òœ",
"147" => " «ÌÌœ ò‰Ìœ",
"148" => "ÂÌç çÌ“Ì  «ÌÌœ ‰‘œÂ.",
"149" => "·ÿ›« òœ Õ”«» ò«—»—Ì Ê òœ ò«—»—Ì ’ÕÌÕ —« Ê«—œ ò‰Ìœ",
"150" => "«Ì‰ ¬œ—” «Ì„Ì· ÃœÌœ ‘„« '%s'  «ÌÌœ ‘œ.",
"151" => "›—” «œ‰ ›«Ì·",
"152" => "œ«‰·Êœ ò—œ‰ ›«Ì·",
"153" => "Files e-mailed",
"154" => "«ÌÃ«œ Õ”«» ò«—»—Ì",
"155" => "¬Œ—Ì‰ “„«‰ œ” Ì·»Ì",
"156" => "Ê÷Ì⁄ ",
"157" => "Ê÷Ì⁄  ›⁄«·",
"158" => "œ—Ì«›  Œ·«’Â",
"159" => "¬œ—” «Ì„Ì·",
"160" => "?ò·«:",
"161" => "Õ”«» ò«—»—Ì",
"162" => "Å«ò ò—œ‰ Õ”«» ò«—»—Ì",
"163" => "Shown %s account(s) of %s",
"164" => "‘ò· œ«œ‰ »Â „—ò“ ›—” «œ‰ ›«Ì·",
"165" => " €ÌÌ— œ«œ‰ ›«Ì·Â«",
"166" => " €ÌÌ— ›«Ì·",
"167" => "File %s has been changed succesfully",
"168" => "–ŒÌ—Â ò—œ‰",
"169" => "Å«ò ò—œ‰",
"170" => "Å«ò ò—œ‰ ›«Ì·Â«",
"171" => "„‰⁄ò” ò—œ‰",
"172" => "»·Â",
"173" => "‰Â",
"174" => "›⁄«·",
"175" => "€Ì— ›⁄«·",
"176" => "€Ì— „Ã«“",
"177" => "Sorry, but server could not execute the mail program.",
"178" => "‘„« »—«Ì À»  ‰«„ »« „‘ò· „Ê«ÃÂ ‘œÌœ »—ê—œÌœ Ê  ’ÌÕ ò‰Ìœ.",
"179" => "·ÿ›« »—ê—œÌœ Ê ”⁄Ì ò‰Ìœ.",
"180" => "›«Ì· ‘„« »« „Ê›ﬁÌ  Å«ò ‘œ.",
"181" => "‘„« «Ã«“Â ‰œ«—Ìœ «Ì‰ ›«Ì· —« Å«ò ò‰Ìœ.",
"182" => "œ«Ì—ò Ê—Ì »« „Ê›ﬁÌ  Å«ò ‘œ",
"183" => "‘„« «Ã«“Â ‰œ«—Ìœ «Ì‰ œ«Ì—ò Ê—Ì —« Å«ò ò‰Ìœ",
"184" => "œ«Ì—ò Ê—Ì »« „Ê›ﬁÌ  «ÌÃ«œ ‘œ.",
"185" => "‘„« «Ã«“Â «ÌÃ«œ ò—œ‰ œ«Ì—ò Ê—Ì —« ‰œ«—Ìœ.",
"186" => "«ÌÃ«œ ò—œ‰ œ«Ì—ò Ê—Ì ÃœÌœ",
"187" => "‰«„ œ«Ì—ò Ê—Ì",
"188" => "À»  «ÿ·«⁄« ",
"189" => "«Ì‰ œ«Ì—ò Ê—Ì ﬁ»·« «ÌÃ«œ ‘œÂ ·ÿ›« ‰«„ œÌê—Ì —« «‰ Œ«» ò‰Ìœ.",
"190" => "‘„« »«Ìœ ‰«„ œ«Ì—ò Ê—Ì —« „‘Œ’ ò‰Ìœ",
"191" => " €ÌÌ— œ«œ‰",
"192" => "‰«„ ›«Ì·",
"193" => " €ÌÌ— œ«œ‰ ›«Ì·/Ã“ÌÌ«  œ«Ì—ò Ê—Ì",
"194" => "»« „Ê›ﬁÌ  «Ì‰ ‰«„  €ÌÌ— ò—œ.",
"195" => "‘„« «Ã«“Â ‰œ«—Ìœ «Ì‰ ›«Ì· —«  €ÌÌ— »œÂÌœ.",
"196" => "„”Ì— œ«œÂ ‘œÂ «‘ »«Â „Ì »«‘œ. ‰ŸÌ„«  «‰ —« çò ò‰Ìœ.",
"197" => "»Â ”›«—‘",
"198" => " €ÌÌ— ‰«„ «‰Ã«„ ‰‘œ “Ì—« «Ì‰‰«„ „ÊÃÊœ „Ì »«‘œ",
"199" => "¬Œ—Ì‰ ›«Ì· «—”«· ‘œÂ",
"200" => "¬Œ—Ì‰ ›«Ì· œ«‰·Êœ ‘œÂ",
"201" => " €ÌÌ— ‰«„ «‰Ã«„ ‰‘œ “Ì« «Ì‰ ‰«„ €Ì— „Ã«“ „Ì »«‘œ",
"999" => "›—” «œ‰ ›«Ì·",
//
// New strings introduced in version 1.02
//
"202" => "The url you provided is not valid",
"203" => "¬œ—” ”«Ì  ›«Ì·",
"204" => "«—”«· ›«Ì· »— «”«” ¬œ—” ”«Ì ",

//
// New strings introduced in version 1.10
//
"205" => " Ìò «Ì‰ —« Â„Ì‘Â »ê–«—Ìœ",
"206" => "‰„Ì  Ê«‰„ «‰Ã«„ »œ„: “Ì—« «Ì‰ ‰«„ €Ì— „Ã«“ „Ì »«‘œ.",
"207" => "¬œ—” ¬Ì ÅÌ ‘„« »” Â ‘œÂ Ì⁄‰Ì œÌê— «Ã«“Â Ê—Êœ ‰œ«—Ìœ.",
"208" => "¬œ—” ¬Ì ÅÌ ‘„«  Ê”ÿ „œÌ“Ì  ”«Ì  »” Â ‘œÂ «” .",
"209" => "»—«Ì «ÿ·«⁄«  »Ì‘ — »« „œÌ— ”«Ì   „«” »êÌ—Ìœ.",

//
// New strings introduced in version 1.12
//
"210" => "Daily allowed Mb exceeded",
"211" => "Monthly allowed Mb exceeded",
"212" => "Daily allowed download Mb exceeded",
"213" => "Monthly allowed download Mb exceeded",
"214" => "„⁄ »— ò—œ‰ ›«Ì·",
"215" => " «ÌÌœ ›«Ì·",
"216" => "¬Ì« ‘„« „ÿ„∆‰ Â” Ìœ òÂ „Ì ŒÊ«ÂÌœ Å«ò ò‰Ìœ.",
"217" => "‘„« «Ã«“Â  «ÌÌœ «Ì‰ ›«Ì· —« ‰œ«—Ìœ.",
"218" => "«Ì‰ ›«Ì· —« „Êﬁ⁄Â «Ì œ— ·Ì”  ﬁ—«— „Ì œÂÌ„ òÂ  Ê”ÿ „œÌ—Ì   «ÌÌœ ‘Êœ.",
"219" => "»ÌÌ‰œÂ ›«Ì·"

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