<?php
/*************************************************************************************
 * freebasic.php
 * -------------
 * Author: Jeff Marshall
 * Copyright: (c) 2006 FreeBASIC Developemnt Team (http://www.freebasic.net/)
 * Release Version: 1.0.7.10 (modified)
 * Date Started: 2006/09/28
 *
 * FreeBasic (http://www.freebasic.net/) language file for GeSHi.
 * Requires patched geshi
 *
 * CHANGES
 * -------
 * 2006/09/28 (1.0.0)
 *  -  first version
 *
 ************************************************************************************/
$this->enable_classes();
$language_data = array (
	'LANG_NAME' => 'QBasic/QuickBASIC',
	'COMMENT_SINGLE' => array(1 => "'", 2 => 'REM' ),
	'COMMENT_MULTI' => array( "/'" => "'/" ),
	'CASE_KEYWORDS' => GESHI_CAPS_REPLACE,
	'QUOTEMARKS' => array('"'),
	'ESCAPE_CHAR' => '',
	'KEYWORDS' => array(
		1 => array(
'__PATH__', '__TIME__', '__LINE__', '__FUNCTION__', '__FILE__', 
'__FB_WIN32__', '__FB_VER_PATCH__', '__FB_VER_MINOR__', 
'__FB_VER_MAJOR__', '__FB_VERSION__', '__FB_SIGNATURE__', 
'__FB_OUT_OBJ__', '__FB_OUT_LIB__', '__FB_OUT_EXE__', '__FB_OUT_DLL__', 
'__FB_OPTION_PRIVATE__', '__FB_OPTION_EXPLICIT__', '__FB_OPTION_ESCAPE__', 
'__FB_OPTION_DYNAMIC__', '__FB_OPTION_BYVAL__', '__FB_MT__', 
'__FB_MIN_VERSION__', '__FB_MAIN__', '__FB_LINUX__', '__FB_LANG__', 
'__FB_ERR__', '__FB_DOS__', '__FB_DEBUG__', '__FB_BIGENDIAN__', 
'__DATE__', 

'ZString', 

'Year', 

'Xor', 

'WString', 'WStr', 'WSpace', 'Write', 'WOct', 'With', 'WInput', 
'WindowTitle', 'Window', 'Width', 'While', 'WHex', 'Wend', 'WeekdayName', 
'Weekday', 'WChr', 'WBin', 'Wait', 

'View Print', 'View', 'VarPtr', 'ValULng', 'ValUInt', 'ValLng', 'ValInt', 
'Val', 'va_next', 'va_first', 'va_arg', 

'Using', 'UShort', 'Until', 'Unsigned', 'Unlock', 'Union', 'ULongInt', 
'UInteger', 'UCase', 'UByte', 'UBound', 

'Type', 'Trim', 'Trans', 'To', 'TimeValue', 'TimeSerial', 'Timer', 'Time', 
'ThreadWait', 'ThreadCreate', 'Then', 'Tan', 'Tab', 

'System', 'Swap', 'Sub', 'StrPtr', 'String', 'Str', 'Stop', 'Step', 
'stdcall', 'Static', 'Sqr', 'Spc', 'Space', 'Sleep', 'SizeOf', 'Single', 
'Sin', 'Shr', 'Short', 'Shl', 'Shell', 'Shared', 'Sgn', 'SetTime', 
'SetMouse', 'SetEnviron', 'SetDate', 'Select Case', 'Select', 'Seek', 
'Second', 'Scrn', 'ScreenUnlock', 'ScreenSync', 'ScreenSet', 'ScreenRes', 
'ScreenPtr', 'ScreenLock', 'ScreenList', 'ScreenInfo', 'ScreenCopy', 
'Screen', 'Scope', 'SAdd', 

'Run', 'RTrim', 'RSet', 'Rnd', 'RmDir', 'Right', 'Return', 'Resume Next', 
'Resume', 'Restore', 'Reset', 'Rem', 'ReDim', 'Reallocate', 'Read', 
'Randomize', 'Random', 'RGBA', 'RGB', 

'Put', 'Public', 'Ptr', 'PSet', 'ProcPtr', 'Private', 'Print Using', 
'Print #', 'Print', 'PReset', 'Preserve', 'Pos', 'PokeS', 'PokeI', 'Poke', 
'Pointer', 'Point', 'PMap', 'Pipe', 'PeekS', 'PeekI', 'Peek', 'PCopy', 
'pascal', 'Palette', 'Paint', 

'Overload', 'Output', 'Out', 'Or', 'Option Static', 'Option Private', 
'Option NoKeyword', 'Option Explicit', 'Option Escape', 'Option Dynamic', 
'Option ByVal', 'Option Base', 'Option', 'Operator', 'Open Scrn', 
'Open Pipe', 'Open Lpt', 'Open Err', 'Open Cons', 'Open Com', 'Open', 
'On Error', 'On', 'OffsetOf', 'Oct', 

'Now', 'Not', 'NoKeyword', 'New', 'Next', 'Namespace', 'Name', 

'MutexUnlock', 'MutexLock', 'MutexDestroy', 'MutexCreate', 'MultiKey', 
'MonthName', 'Month', 'Mod', 'MKShort', 'MKS', 'MKLongInt', 'MKL', 'MKI', 
'MkDir', 'MKD', 'Minute', 'Mid', 

'LTrim', 'LSet', 'Lpt', 'LPrint', 'Loop', 'LongInt', 'Long', 'Log', 'LOF', 
'Lock', 'Locate', 'Local', 'LOC', 'Line Input #', 'Line Input', 'Line', 
'Lib', 'Let', 'Len', 'Left', 'LCase', 'LBound', 'LoWord', 'LoByte', 

'Kill', 

'IsDate', 'Is', 'Integer', 'Int', 'InStr', 'Input()', 'Input #', 'Input', 
'Inp', 'Inkey', 'Import', 'Imp', 'ImageDestroy', 'ImageConvertRow', 
'ImageCreate', 'IIf', 'If', 

'Hour', 'Hex', 'HiWord', 'HiByte', 

'Goto', 'GoSub', 'GetMouse', 'GetKey', 'GetJoystick', 'Get', 

'Function', 'FreeFile', 'Fre', 'Format', 'For', 'Flip', 'Fix', 'FileLen', 
'FileExists', 'FileDateTime', 'FileCopy', 'FileAttr', 'Field', 

'Extern', 'Export', 'Explicit', 'Exp', 'Exit While', 'Exit Sub', 
'Exit Select', 'Exit Operator', 'Exit Function', 'Exit For', 'Exit Do', 
'Exit Destructor', 'Exit Constructor', 'Exit', 'ExePath', 'Exec', 
'Escape', 'Error', 'Err', 'Ermn', 'Erl', 'Erfn', 'Erase', 'Eqv', 'EOF', 
'Environ', 'Enum', 'End With', 'End Sub', 'End Scope', 'End Operator', 
'End Namespace', 'End If', 'End Function', 'End Enum', 'End Destructor', 
'End Constructor', 'End', 'Encoding', 'ElseIf', 'Else', 

'Dynamic', 'DyLibSymbol', 'DyLibLoad', 'DyLibFree', 'Draw String', 'Draw', 
'Double', 'Do', 'Dir', 'Dim', 'Destructor', 'Delete', 'DefUShort', 
'DefULngInt', 'DefUInt', 'DefUByte', 'DefStr', 'DefSng', 'DefShort', 
'DefLngInt', 'DefLng', 'DefInt', 'defined', 'DefDbl', 'DefByte', 
'Declare', 'Deallocate', 'Day', 'DateValue', 'DateSerial', 'DatePart', 
'DateDiff', 'DateAdd', 'Date', 'Data', 

'CVShort', 'CVS', 'CVLongInt', 'CVL', 'CVI', 'CVD', 'Custom', 'CUShort', 
'CurDir', 'CUnsg', 'CULngInt', 'CUInt', 'CUByte', 'CsrLin', 'CSng', 
'CSign', 'CShort', 'CPtr', 'Cos', 'Continue', 'Constructor', 'Const', 
'Cons', 'CondWait', 'CondSignal', 'CondDestroy', 'CondCreate', 
'CondBroadcast', 'Common', 'Command', 'Com', 'Color', 'Cls', 'Close', 
'CLngInt', 'CLng', 'Clear', 'Class', 'Circle', 'CInt', 'Chr', 'ChDir', 
'Chain', 'cdecl', 'CDbl', 'CByte', 'Cast', 'Case Else', 'Case', 'CallS', 
'CAllocate', 'Call', 

'ByVal', 'Byte', 'ByRef', 'BSave', 'BLoad', 'Binary', 'Bin', 'Beep', 
'Base', 'BitSet', 'BitReset', 'Bit', 

'Atn', 'Atan2', 'Asm', 'Asin', 'Asc', 'As', 'Append', 'Any', 'And', 
'Alpha', 'Allocate', 'Alias', 'Acos', 'Access', 'Abs', 'AssertWarn', 
'Assert', 

'$Static', '$Dynamic'			)
		),
	'SYMBOLS' => array(
		'(', ')'
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
			2 => 'color: #808080;',
            3 => 'color: #808080;'
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
		1 => array (
			GESHI_SEARCH => "((\\&amp;)[HhOoBb]?[0-9a-fA-F]+)|([0-9]\.[0-9][eEdD][-+]?[0-9]+)|(\.?[0-9][eEdD][-+]?[0-9]+)",
			GESHI_REPLACE => '\\0',
			GESHI_MODIFIERS => '',
			GESHI_BEFORE => '',
			GESHI_AFTER => ''
			),
		2 => array (
			GESHI_SEARCH => "\#.*",
			GESHI_REPLACE => '\\0',
			GESHI_MODIFIERS => '',
			GESHI_BEFORE => '',
			GESHI_AFTER => ''
			)
		),
	'STRICT_MODE_APPLIES' => GESHI_NEVER,
	'SCRIPT_DELIMITERS' => array(
		),
	'HIGHLIGHT_STRICT_BLOCK' => array(
		)
);

?>