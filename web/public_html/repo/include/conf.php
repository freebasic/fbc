<?php
/***************************************************************************
 *                                 conf.php
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

if ( !defined('IN_PHPATM') )
{
	die("Hacking attempt");
}

//
// PHP scripts file extension, change it only if your server requires a
// different name for php scripts. Rememember to rename all .php files
// with the new extension EXCLUDING 'conf.php'
//
$phpExt = 'php';

//
//	Don't touch this include
//
include($include_location.'include/constants.'.$phpExt);

//
// URL link to homepage (the link under "home" icon).
// These value will not influence the script working
//
$homeurl = "http://www.freebasic.net/repo";

//
// The name of administrator (usually your name)
//
$admin_name = 'v1ctor';

//
// Administrator e-mail address
//
$admin_email = 'av1ctor@yahoo.com.br';

//
// If your site has the mail function disabled you can use the SMTP e-mailer.
// Just set $use_smtp to true, fill $smtp_host with your smtp server (something
// like smtp.yourisp.net) and, if required, your username and password.
// Note that if you use 'localhost' as host, password and username normally
// are not required.
//
$use_smtp = false;
$smtp_host ='';
$smtp_username = '';
$smtp_password = '';

//
// $domain_name: the domain of your site without trailing 'http://' (eg. www.mysite.net)
// $script_folder_path: the path where phpATM is located relative to the domain name
//
$domain_name = 'www.frebasic.net';
$script_folder_path = 'repo';
$installurl = 'http://' . $domain_name . '/' . $script_folder_path;

//
// You have to change next settings if you wish use non-default folders
// Highly recommended to change folders name to improve security
//
$users_folder_name = '_users_';
$userstat_folder_name = '_userstat_';
$uploads_folder_name = '_files_';
$languages_folder_name = '_languages_';
$stats_folder_name = '_stats_';
$viewers_folder_name = '_viewers_';
$cfg_folder_name = '_cfg_';

//
// Cookie settings. Normally changing these settings is not required.
// If you want to limit the cookie validity to a particular
// path or domain enter it in $cookiepath and $cookiedomain; set $cookiesecure
// true only if your server is SSL Secure. The default cookie validity is set to 1 year
// (24 * 365 = 8760 hours), you can decrease it if you want
//
$cookiedomain = 'freebasic.net';
$cookiepath = '/repo';
$cookiesecure = false;
$cookievalidity = 8760; //hours

//
// User type grants
// ================
//
// view:     user can view the file list
// modwon:   user can modify name and description of own files only
//		     NOTE: if modall is true, the value of modown will be ignored (assumed true)
// delown:   user can delete own files only
//		     NOTE: if delall is true, the value of delown will be ignored (assumed true)
// download: user can download files
//           NOTE: if view is false then the value of download will be ignored (assumed false)
// mail:	 user can mail files to his own mail address with size limitation (see mailall)
//           NOTE: if view is false then the value of mail will be ignored (assumed false)
// upload:   user can upload files
// mkdir:    user can create directories
// modall:   user can modify name and description of all files and directories
// delall:   user can delete any files or directories
// mailall:  user can send files to his own mail address without size limitation
// webcopy:  user can upload files by http address
// validate: user can validate new uploaded file
//
// Consider following lines as a table and modify true to false and viceversa paying
// attention to not delete commas or parentesis nor other special chars.
// Please don't change uppercase values!!
//
//  STATUS    => array(view,    modown,  delown,  download, mail,    upload,  mkdir,   modall,  delall,  mailall,  webcopy,  validate)
//                       V        V        V        V         V        V        V        V        V        V         V         V
$grants = array(
	ANONYMOUS => array(true,    FALSE,   FALSE,   true,     FALSE,   false,   false,   FALSE,   FALSE,   FALSE,    false,    false),
	UPLOADER  => array(true,    false,   false,   false,    false,   true,    false,   false,   false,   false,    true,     false),
	VIEWER    => array(true,    false,   false,   false,    false,   false,   false,   false,   false,   false,    false,    false),
	NORMAL    => array(true,    true,    true,    true,     false,   true,    false,   false,   false,   false,    false,    false),
	POWER     => array(true,    true,    true,    true,     true,    true,    true,    false,   false,   true,     true,     true ),
	ADMIN     => array(TRUE,    TRUE,    TRUE,    TRUE,     TRUE,    TRUE,    TRUE,    TRUE,    TRUE ,   TRUE,     TRUE,     TRUE )
);

//
// The default status of new registered user
// ADMIN - Administrator, POWER - Power User, NORMAL - Normal User,
// VIEWER - Viewer (view only), UPLOADER - Uploader (upload only)
//
$default_user_status = NORMAL;

//
// The text displayed in the browser titlebar
//
$page_title = 'FreeBASIC File Repository';

//
// The default status of a new uploaded file:
// 0 - new files do not require admin approval to be listed
// 1 - admin approval is required before a new file can be listed
//
$validation_enabled = 1;

//
// You can encrypt files content to increase security and avoid direct linking to files.
// Remember that viewers will be disabled with encryption on. Change this setting only
// if your file directory is empty, because with this setting off, already encrypted files
// will be unreadable and viceversa. Permitted values are 'true' and 'false'. 
// NOTE: if you are planning to enable this setting please first change the encryption key 
// with a password of your choice.
//
$encrypt_filecontent = false;
$encryption_key = 'password';

//
// Server timezone offset, relative to GMT (Greenwich Mean Time), in hours
// Change this setting only if time works incorrect
//
$GMToffset = date('Z')/3600;

//
// The time when script have to do maintenance functions
// (delete unauhtorized users, send digest, etc.). For instance, if you want
// to do maintenance functions after 03:00, set the value to 3.
//
$maintenance_time = 2;

//
// Enable or disable mail functions. If disabled, the digest,
// mail confirmation & file mailing function is off
//
$mail_functions_enabled = false;

//
// The maximum size of file, which normal users can send to their mail (in kilobytes)
// To disable this function (for normal users only), set size below zero
//
$max_filesize_to_mail = 500;

//
// Enable or disable account activation via e-mail.
// These feature helps you check the e-mail address of registered user
//
$require_email_confirmation = false;

//
// Enable or disable language switching ability
// Disable it if you have only one language installed.
//
$allow_choose_language = true;

//
// Max number of files listed in 'last uploads' section
// Don't exceed, since the page load can be very slow
//
$max_last_files = 10;

//
// Max number of files listed in 'top downloads' section
// Don't exceed, since the page load can be very slow
//
$max_topdownloaded_files = 10;

//
// The mail header for digest (html code allowed)
// You can configure it in the 'settings panel' (only administrator)
//
$mailinfopage='mailinfo.htm';

//
// Default language, the language code of one element stored in 'languages' dir
// Anonymous cant't configure this, so will ever use this language
//
$dft_language = 'en';

//
// Maximum allowed filesize to upload (Kilobytes)
// Note: php.ini and server also have an upload size limit
//
$max_allowed_filesize = 128;

//
// Maximum daily allowed Mb upload - set to number of Mb allowed daily.
// Set to -1 if you wish not to have this forced.
//
$max_daily_mb = -1;

//
// Maximum monthly allowed Mb upload - set to number of Mb allowed monthly
// Set to -1 if you wish not to have this forced
//
$max_monthly_mb = -1;

//
// Maximum daily download
// Set to -1 if you wish not to have this enforced.
//
$max_daily_download_mb = -1;

//
// Maximum monthly download
// Set to -1 if you wish not to have this enforced
//
$max_monthly_download_mb = -1;

//
// Format of date & time (in PHP time format, see php.net)
//
$datetimeformat = 'd.m.Y H:i';

//
// Max number chars for file and directory names
//
$file_name_max_caracters = 150;

//
// Max number chars for filename in tables
//
$file_out_max_caracters = 40;

//
// Max number chars for file comment (description)
//
$comment_max_caracters = 300;

//
// Reserved filename
//
$reserved_files = "index\.html|^\.|\.desc$|\.dlcnt$";

//
// Regular expression defines which files can't be uploaded
// If you don't know what are regular expressions, don't touch this.
// NOTE: due to a bug of Apache/PHP, php file with any extra double chars extension
// are executed like normal php file. I.e. test.php.xx is executed as test.php
// This is a big security hole, fixed by the following regular expression
// If you add any extension please consider this bug and add the control to multiextension too
// 
//
$allowedfiles = "/.*?\.zip|.*?\.rar|.*?\.gz|.*?\.bz|.*?\.7z/";

//
// Show hidden files (like .htaccess, etc) and directories (see $hidden_dirs)
//
$showhidden = false;

//
// Hidden directories (regular expression) that won't be shown nor won't be
// analized for digest, last uploads and top donwloads. Note that users can't
// create dirs with an hidden name. Default value hides Fr*ntP*ge directories.
//
$hidden_dirs = "^_vti_";

//
// Header & Background colors of table, Font colors
// Only the first skin in the array currently works!
//
$skins = array(
  array(
    'bordercolor' => '#000000',    // The table border color
    'headercolor' => '#d9d9c9',    // The table header color
    'tablecolor' => '#F5F5F5',     // The table background color
    'lightcolor' => '#FFFFFF',     // Table date field color
    'headerfontcolor' => '#0',
    'normalfontcolor' => '#000000',
    'selectedfontcolor' => '#4682B4',
    'bodytag' => "bgcolor=\"#E5E5E5\" text=\"#000000\" link=\"#000000\" vlink=\"#333333\" alink=\"#000000\""
  )
);

//
// Text font used in every page
//
$font = 'Verdana';

//
// Mimetypes, feel free to change the list but don't remove 'directory' and 'default'.
// Make sure that the specified image exists in 'images' folder and follow
// the existing structure
//
$mimetypes = array (
'.txt'  => array('img' => 'txt.gif',    'mime' => 'text/plain'),
'.html' => array('img' => 'html.gif',   'mime' => 'text/html'),
'.htm'  => array('img' => 'html.gif',   'mime' => 'text/html'),
'.doc'  => array('img' => 'doc.gif',    'mime' => 'application/msword'),
'.pdf'  => array('img' => 'pdf.gif',    'mime' => 'application/pdf'),
'.xls'  => array('img' => 'xls.gif',    'mime' => 'application/msexcel'),
'.gif'  => array('img' => 'gif.gif',    'mime' => 'image/gif'),
'.jpg'  => array('img' => 'jpg.gif',    'mime' => 'image/jpeg'),
'.jpeg' => array('img' => 'jpg.gif',    'mime' => 'image/jpeg'),
'.bmp'  => array('img' => 'bmp.gif',    'mime' => 'image/bmp'),
'.png'  => array('img' => 'gif.gif',    'mime' => 'image/png'),
'.zip'  => array('img' => 'zip.gif',    'mime' => 'application/zip'),
'.rar'  => array('img' => 'rar.gif',    'mime' => 'application/x-rar-compressed'),
'.gz'   => array('img' => 'zip.gif',    'mime' => 'application/x-compressed'),
'.tgz'  => array('img' => 'zip.gif',    'mime' => 'application/x-compressed'),
'.z'    => array('img' => 'zip.gif',    'mime' => 'application/x-compress'),
'.exe'  => array('img' => 'exe.gif',    'mime' => 'application/x-msdownload'),
'.mid'  => array('img' => 'mid.gif',    'mime' => 'audio/mid'),
'.midi' => array('img' => 'mid.gif',    'mime' => 'audio/mid'),
'.wav'  => array('img' => 'wav.gif',    'mime' => 'audio/x-wav'),
'.mp3'  => array('img' => 'mp3.gif',    'mime' => 'audio/x-mpeg'),
'.avi'  => array('img' => 'avi.gif',    'mime' => 'video/x-msvideo'),
'.mpg'  => array('img' => 'mpg.gif',    'mime' => 'video/mpeg'),
'.mpeg' => array('img' => 'mpg.gif',    'mime' => 'video/mpeg'),
'.mov'  => array('img' => 'avi.gif',    'mime' => 'video/quicktime'),
'.swf'  => array('img' => 'flash.gif',  'mime' => 'application/x-shockwave-flash'),
'.gtar' => array('img' => 'rar.gif',    'mime' => 'application/x-gtar'),
'.tar'  => array('img' => 'rar.gif',    'mime' => 'application/x-tar'),
'.tiff' => array('img' => 'defaut.gif', 'mime' => 'image/tiff'),
'.tif'  => array('img' => 'defaut.gif', 'mime' => 'image/tiff'),
'.rtf'  => array('img' => 'doc.gif',    'mime' => 'application/rtf'),
'.eps'  => array('img' => 'defaut.gif', 'mime' => 'application/postscript'),
'.ps'   => array('img' => 'defaut.gif', 'mime' => 'application/postscript'),
'.qt'   => array('img' => 'avi.gif'  ,  'mime' => 'video/quicktime'),
'directory' => array('img' => 'dossier.gif', 'mime' => ''),
'default' =>   array('img' => 'defaut.gif',  'mime' => 'application/octet-stream')
);

//
// Chars removed from filename and directory name for safety purposes
// Avoid to modify it unless you are sure about what are you doing.
//
$invalidchars = array (
"'",
"\"",
"\"",
'&',
',',
';',
'/',
"\\",
'`',
'<',
'>',
':',
'*',
'|',
'?',
'§',
'+',
'^',
'(',
')',
'=',
'$',
'%'
);

//
// Insert here IP addresses that are not allowed to access your site
// Default values should not exist, but are present to show you how
// insert them. If you want you can delete them.
// Warning IP address in this list must be numerical!
//
$ip_black_list = array (
'127.0.0.2',
'127.0.0.3',
);

?>