<?php
/*************************************************************************************
 * qbasic.php
 * ----------
 * Author: Nigel McNie (oracle.shinoda@gmail.com)
 * Copyright: (c) 2004 Nigel McNie (http://qbnz.com/highlighter/)
 * Release Version: 1.0.3
 * CVS Revision Version: $Revision$
 * Date Started: 2004/06/20
 * Last Modified: $Date$
 *
 * QBasic/QuickBASIC language file for GeSHi.
 *
 * CHANGES
 * -------
 * 2004/11/27 (1.0.3)
 *  -  Added support for multiple object splitters
 * 2004/10/27 (1.0.2)
 *   -  Added support for URLs
 * 2004/08/05 (1.0.1)
 *   -  Added support for symbols
 *   -  Removed unnessecary slashes from some keywords
 * 2004/07/14 (1.0.0)
 *   -  First Release
 *
 * TODO (updated 2004/11/27)
 * -------------------------
 * * Make sure all possible combinations of keywords with
 *   a space in them (EXIT FOR, END SELECT) are added
 *   to the first keyword group
 * * Update colours, especially for the first keyword group
 *
 *************************************************************************************
 *
 *     This file is part of GeSHi.
 *
 *   GeSHi is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   GeSHi is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with GeSHi; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 ************************************************************************************/
$language_data = array (
	'LANG_NAME' => 'QBasic/QuickBASIC',
	'COMMENT_SINGLE' => array(1 => "'", 2 => 'REM'),
	'COMMENT_MULTI' => array("/'" => "'/"),
	'CASE_KEYWORDS' => GESHI_CAPS_CAPITALIZE,
	'QUOTEMARKS' => array('"'),
	'ESCAPE_CHAR' => '',
	'KEYWORDS' => array(
		1 => array(
			'String', 'Zstring', 'Wstring',
			'Unsigned',
			'Byte', 'Ubyte',
			'Short', 'Ushort',
			'Integer', 'Uinteger', 'Long',
			'Longint', 'Ulongint',
			'Single', 'Double',
			'Ptr', 'Pointer'
			),

		2 => array(
			'Do', 'Loop', 'While', 'Wend', 'Then', 'Else', 'Elseif', 'If', 'EndIf',
			'For', 'To', 'Next', 'Step', 'Goto', 'Gosub', 'Return', 'Resume', 'Select',
			'Case', 'Until', 'Exit', 'Continue', 'With', 'Scope', 'End',
			'Namespace', 'Extern',
			'Sub', 'Function', 'Declare', 'Call', 'Case', 'Access',
			'Alias', 'And', 'Any', 'Append', 'As', 'Byval', 'Byref',
			'Dim', 'Common', 'Const', 'Data',
			'Defdbl', 'Defint', 'Deflng', 'Defsng', 'Defstr',
			'Eqv', 'Is', 'Let', 'Local', 'Mod', 'Option', 'Shared',
			'Field', 'Not', 'Or', 'Output', 'Redim', 'Static',
			'Shr', 'Shl', 'Type', 'Union', 'Using', 'Xor',
			'Explicit', 'Base',
			'Include', 'Define', 'Inclib'
			),

		3 => array(
			'Abs', 'Asc', 'Atn', 'Assert',
			'Beep', 'Binary', 'Bload', 'Bsave',
			'Cdbl', 'Cdecl', 'Chain', 'Chdir', 'Chdir', 'Chr', 'Cint',
			'Circle', 'Clear', 'Clng', 'Close', 'Cls', 'Com', 'Command', 'Color',
			'Cos', 'Csng', 'Csrlin', 'Cvd', 'Cvdmbf', 'Cvi', 'Cvl', 'Cvs', 'Cvsmdf',
			'Date', 'Draw',
			'Environ', 'Environ', 'Eof', 'Erase', 'Erl', 'Err',
			'Error', 'Exp',
			'Fileattr', 'Files', 'Fix', 'Fre', 'Freefile',
			'Get',
			'Hex',
			'Inkey', 'Inp', 'Input', 'Input', 'Instr', 'Int', 'Ioctl', 'Ioctl',
			'Key', 'Kill',
			'Lbound', 'Lcase', 'Left', 'Len', 'Line', 'Loc', 'Locate', 'Lock',
			'Lof', 'Log', 'Unlock', 'Lpos', 'Lprint', 'Lset', 'Ltrim',
			'Mid', 'Mkd', 'Mkdir', 'Mkdmbf', 'Mki', 'Mkl', 'Mks', 'Mksmbf',
			'Name', 'Oct',
			'Open', 'Out',
			'Pen', 'Play', 'Paint', 'Palette', 'Pcopy', 'Peek', 'Pmap', 'Point', 'Poke', 'Pos',
			'Preset', 'Print', 'Pset', 'Put',
			'Random', 'Randomize', 'Read', 'Reset', 'Restore', 'Right', 'Rmdir', 'Rnd',
			'Rset', 'Rtrim', 'Run',
			'Screen', 'Seek', 'Setmem', 'Sgn', 'Shell', 'Sin', 'Sleep',
			'Sound', 'Space', 'Spc', 'Sqr', 'Stop', 'Str', 'StrPtr',
			'Swap', 'System', 'Strig',
			'Tab', 'Tan', 'Time', 'Timer',
			'Ubound', 'Ucase', 'Uevent', 'Unlock',
			'Val', 'Varptr', 'View',
			'Wait', 'Width', 'Window', 'Write'
			)
		),
	'SYMBOLS' => array(
		'(', ')', '{', '}', '[', ']', '=', '+', '-', '*', '/', '\\', '^', '!', '%', '#', '&', '$', ':', '@', '>', '<'
		),
	'CASE_SENSITIVE' => array(
		GESHI_COMMENTS => false,
		1 => false,
		2 => false,
		3 => false
		),
	'STYLES' => array(
		'KEYWORDS' => array(
			1 => 'color: #a1a100;',
			3 => 'color: #000066;'
			),
		'COMMENTS' => array(
			1 => 'color: #808080;',
			2 => 'color: #808080;'
			),
		'BRACKETS' => array(
			0 => 'color: #66cc66;'
			),
		'STRINGS' => array(
			0 => 'color: #ff0000;'
			),
		'NUMBERS' => array(
			0 => 'color: #cc66cc;'
			),
		'METHODS' => array(
			),
		'SYMBOLS' => array(
			0 => 'color: #66cc66;'
			),
		'ESCAPE_CHAR' => array(
			0 => 'color: #000099;'
			),
		'SCRIPT' => array(
			),
		'REGEXPS' => array(
			)
		),
	'URLS' => array(
		),
	'OOLANG' => false,
	'OBJECT_SPLITTERS' => array(
		),
	'REGEXPS' => array(
		),
	'STRICT_MODE_APPLIES' => GESHI_NEVER,
	'SCRIPT_DELIMITERS' => array(
		),
	'HIGHLIGHT_STRICT_BLOCK' => array(
		)
);

?>
