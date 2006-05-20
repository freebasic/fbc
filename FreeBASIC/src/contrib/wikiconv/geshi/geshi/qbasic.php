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
	'COMMENT_MULTI' => array(),
	'CASE_KEYWORDS' => GESHI_CAPS_CAPITALIZE,
	'QUOTEMARKS' => array('"'),
	'ESCAPE_CHAR' => '',
	'KEYWORDS' => array(
		1 => array(
			'Do', 'Loop', 'While', 'Wend', 'Then', 'Else', 'Elseif', 'If',
			'For', 'To', 'Next', 'Step', 'Goto', 'Gosub', 'Return', 'Resume', 'Select',
			'Case', 'Until', 'Exit', 'Continue', 'With', 'Scope',
			
			'String', 'Zstring', 'Wstring',
			'Unsigned',
			'Byte', 'Ubyte', 
			'Short', 'Ushort', 
			'Integer', 'Uinteger', 'Long',
			'Longint', 'Ulongint', 
			'Single', 'Double',
			'Ptr', 'Pointer'
			),
		3 => array(
			'Abs', 'Absolute', 'Access', 'Alias', 'And', 'Any', 'Append', 'As', 'Asc', 'Atn',
			
			'Base', 'Beep', 'Binary', 'Bload', 'Bsave', 'Byval', 'Byref',
			
			'Call', 'Calls', 'Case', 'Cdbl', 'Cdecl', 'Chain', 'Chdir', 'Chdir', 'Chr', 'Cint', 
			'Circle', 'Clear', 'Clng', 'Close', 'Cls', 'Com', 'Command', 'Common', 'Const', 'Color', 
			'Cos', 'Csng', 'Csrlin', 'Cvd', 'Cvdmbf', 'Cvi', 'Cvl', 'Cvs', 'Cvsmdf', 
			
			'Data', 'Date', 'Declare', 'Def', 'Fn', 'Seg', 'Defdbl', 'Defint', 'Deflng', 'Defsng', 
			'Defstr', 'Dim', 'Draw', 
			
			'End', 'Environ', 'Environ', 'Eof', 'Eqv', 'Erase', 'Erdev', 'Erdev', 'Erl', 'Err', 
			'Error', 'Exp', 
			
			'Field', 'Fileattr', 'Files', 'Fix', 'Fre', 'Freefile', 'Function', 
			
			'Get', 
			
			'Hex', 
			
			'Inkey', 'Inp', 'Input', 'Input', 'Instr', 'Int', 'Ioctl', 'Ioctl', 'Is',
			
			'Key', 'Kill', 
			
			'Lbound', 'Lcase', 'Left', 'Len', 'Let', 'Line', 'List', 'Loc', 'Local', 'Locate', 'Lock', 
			'Lof', 'Log', 'Unlock', 'Lpos', 'Lprint', 'Lset', 'Ltrim', 
			
			'Mid', 'Mkd', 'Mkdir', 'Mkdmbf', 'Mki', 'Mkl', 'Mks', 'Mksmbf', 'Mod', 
			
			'Name', 'Not', 'Oct', 'Off', 'On', 
			
			'Open', 'Option', 'Or', 'Out', 'Output',
			
			'Pen', 'Play', 'Paint', 'Palette', 'Pcopy', 'Peek', 'Pmap', 'Point', 'Poke', 'Pos', 
			'Preset', 'Print', 'Ptr', 'Pset', 'Put', 
			
			'Random', 'Randomize', 'Read', 'Redim', 'Reset', 'Restore', 'Right', 'Rmdir', 'Rnd', 
			'Rset', 'Rtrim', 'Run', 
			
			'Sadd', 'Screen', 'Seek', 'Setmem', 'Sgn', 'Shared', 'Shell', 'Signal', 'Sin', 'Sleep', 
			'Sound', 'Space', 'Spc', 'Sqr', 'Static', 'Stick', 'Stop', 'Str', 'Strig', 'Sub', 
			'Swap', 'System', 'Strig', 'Shr', 'Shl',
			
			'Tab', 'Tan', 'Time', 'Timer', 'Troff', 'Tron', 'Type', 
			
			'Ubound', 'Ucase', 'Uevent', 'Unlock', 'Using', 
			
			'Val', 'Varptr', 'Varptr', 'Varseg', 'View', 
			
			'Wait', 'Width', 'Window', 'Write', 
			
			'Xor'
			)
		),
	'SYMBOLS' => array(
		'(', ')', '{', '}', '[', ']', '=', '+', '-', '*', '/', '\\', '^', '!', '%', '#', '&', '$', ':', '@', '>', '<'
		),
	'CASE_SENSITIVE' => array(
		GESHI_COMMENTS => false,
		1 => false,
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