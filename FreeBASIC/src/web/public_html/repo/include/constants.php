<?php
/***************************************************************************
 *                               constants.php
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

// phpATM Version
define('PROGRAM_VERSION', '1.30');

// File Status
define('UNVALIDATED', 0);
define('VALIDATED',   1);

// User status
define('ANONYMOUS', -1);
define('ADMIN',      0);
define('POWER',      1);
define('NORMAL',     2);
define('VIEWER',     3);
define('UPLOADER',   4);

// User grants
define('VIEW',      0);
define('MODOWN',    1);
define('DELOWN',    2);
define('DOWNLOAD',  3);
define('MAIL',      4);
define('UPLOAD',    5);
define('MKDIR',     6);
define('MODALL',    7);
define('DELALL',    8);
define('MAILALL',   9);
define('WEBCOPY',  10);
define('VALIDATE', 11);

// User activation status
define('USER_DISABLED', 0);
define('USER_ACTIVE',   1);

// Order types
define('ORDER_NAME', 0);
define('ORDER_SIZE', 1);
define('ORDER_MOD',  2);
define('ORDER_DL',   3);
define('ORDER_TYPE', 4);

// Action types
define('ACTION_SAVELANGUAGE', 'savelanguage');
define('ACTION_SELECTSKIN',   'selectskin');
define('ACTION_PROFILE',      'profile');
define('ACTION_EDITFILE',     'editfile');
define('ACTION_SAVEFILE',     'savefile');
define('ACTION_CONFIRM',      'confirm');
define('ACTION_REGISTER',     'register');

// Direction types
define('DIRECTION_DOWN', 0);
define('DIRECTION_UP',   1);

?>