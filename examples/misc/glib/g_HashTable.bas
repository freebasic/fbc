' This is file g_HashTable.bas, an example for GLib Hash tables
' (C) 2011 by Thomas[ dot ]Freiherr[ at ]gmx{ dot }net
' License GPLv 3
'
' See for details
' http://developer.gnome.org/glib/2.28/glib-Hash-Tables.html

#INCLUDE ONCE "glib.bi"

' Define some keys (FB keywords) /  Definiere Keys (hier FB Befehle)
STATIC AS ZSTRING CONST PTR FBKEY(...) = { _
@"ABS",@"ACCESS",@"ACOS",@"ALIAS",@"ALLOCATE",@"ALPHA",@"AND", _
@"ANDALSO",@"ANY",@"APPEND",@"ASSERT",@"ASSERTWARN",@"ASC", _
@"ASIN",@"ASM",@"ATAN2",@"ATN", _
@"BASE",@"BEEP",@"BIN",@"BINARY",@"BIT",@"BITRESET",@"BITSET", _
@"BLOAD",@"BSAVE", _
@"CALL",@"CALLOCATE",@"CASE",@"CAST",@"CBYTE",@"CDBL",@"CDECL", _
@"CHAIN",@"CHDIR",@"CHR",@"CINT",@"CIRCLE",@"CLASS",@"CLEAR", _
@"CLNG",@"CLNGINT",@"CLOSE",@"CLS",@"COLOR",@"COM",@"CONS", _
@"COMMAND",@"COMMON",@"CONDBROADCAST",@"CONDCREATE",@"CONDDESTROY", _
@"CONDSIGNAL",@"CONDWAIT",@"CONST",@"CONSTRUCTOR",@"CONTINUE", _
@"COS",@"CPTR",@"CSHORT",@"CSIGN",@"CSNG",@"CSRLIN",@"CUBYTE", _
@"CUINT",@"CULNG",@"CULNGINT",@"CUNSG",@"CURDIR",@"CUSHORT", _
@"CUSTOM",@"CVD",@"CVI",@"CVL",@"CVLONGINT",@"CVS",@"CVSHORT", _
@"DATA",@"DATE",@"DATEADD",@"DATEDIFF",@"DATEPART",@"DATESERIAL", _
@"DATEVALUE",@"DAY",@"DEALLOCATE",@"DECLARE",@"DEFBYTE",@"DEFDBL", _
@"DEFINT",@"DEFLNG",@"DEFLNGINT",@"DEFSHORT",@"DEFSNG",@"DEFSTR", _
@"DEFUBYTE",@"DEFUINT",@"DEFULNGINT",@"DEFUSHORT",@"DELETE", _
@"DESTRUCTOR",@"DIM",@"DIR",@"DO",@"DRAW",@"DYNAMIC", _
@"DYLIBFREE",@"DYLIBLOAD",@"DYLIBSYMBOL", _
@"ELSE",@"ELSEIF",@"ENCODING",@"END",@"ENUM",@"ENVIRON",@"ESCAPE", _
@"EOF",@"EQV",@"ERASE",@"ERFN",@"ERL",@"ERMN",@"ERR",@"ERROR", _
@"EXEC",@"EXEPATH",@"EXIT",@"EXP",@"EXPLICIT",@"EXPORT",@"EXTERN", _
@"FALSE",@"FBOOLEAN",@"FIELD",@"FILEATTR",@"FILECOPY",@"FILEDATETIME", _
@"FILEEXISTS",@"FILELEN",@"FIX",@"FLIP",@"FOR",@"FORMAT",@"FRAC", _
@"FRE",@"FREEFILE",@"FUNCTION", _
@"GET",@"GETJOYSTICK",@"GETKEY",@"GETMOUSE",@"GOSUB",@"GOTO", _
@"HEX",@"HIBYTE",@"HIWORD",@"HOUR", _
@"IF",@"IIF",@"IMAGECONVERTROW",@"IMAGECREATE",@"IMAGEDESTROY",@"IMP", _
@"IMPORT",@"INKEY",@"INP",@"INPUT",@"INPUT$",@"INSTR",@"INSTRREV", _
@"INT",@"IS",@"ISDATE", _
@"KILL", _
@"LBOUND",@"LCASE",@"LEFT",@"LEN",@"LET",@"LIB",@"LPT",@"LINE", _
@"LOBYTE",@"LOC",@"LOCAL",@"LOCATE",@"LOCK",@"LOF",@"LOG", _
@"LOOP",@"LOWORD",@"LPOS",@"LPRINT",@"LSET",@"LTRIM", _
@"MID",@"MINUTE",@"MKD",@"MKDIR",@"MKI",@"MKL",@"MKLONGINT",@"MKS", _
@"MKSHORT",@"MOD",@"MONTH",@"MONTHNAME",@"MULTIKEY",@"MUTEXCREATE", _
@"MUTEXDESTROY",@"MUTEXLOCK",@"MUTEXUNLOCK", _
@"NAME",@"NAMESPACE",@"NOKEYWORD",@"NEXT",@"NEW",@"NOT",@"NOW", _
@"OCT",@"OFFSETOF",@"ON",@"ONCE",@"OPEN",@"OPTION",@"OPERATOR", _
@"OR",@"ORELSE",@"OUT",@"OUTPUT",@"OVERLOAD", _
@"PAINT",@"PALETTE",@"PASCAL",@"PCOPY",@"PEEK",@"PIPE",@"PMAP", _
@"POINT",@"POINTER",@"POKE",@"POS",@"PRESERVE",@"PRESET",@"PRINT", _
@"PRIVATE",@"PROCPTR",@"PROPERTY",@"PROTECTED",@"PSET",@"PTR", _
@"PUBLIC",@"PUT", _
@"RANDOM",@"RANDOMIZE",@"READ",@"REALLOCATE",@"REDIM",@"REM", _
@"RESET",@"RESTORE",@"RESUME",@"RETURN",@"RGB",@"RGBA",@"RIGHT", _
@"RMDIR",@"RND",@"RSET",@"RTRIM",@"RUN", _
@"SADD",@"SCOPE",@"SCRN",@"SCREEN",@"SCREENCOPY",@"SCREENCONTROL", _
@"SCREENEVENT",@"SCREENINFO",@"SCREENGLPROC",@"SCREENLIST", _
@"SCREENLOCK",@"SCREENPTR",@"SCREENRES",@"SCREENSET",@"SCREENSYNC", _
@"SCREENUNLOCK",@"SECOND",@"SEEK",@"SELECT",@"SETDATE",@"SETENVIRON", _
@"SETMOUSE",@"SETTIME",@"SGN",@"SHARED",@"SHELL",@"SIN", _
@"SIZEOF",@"SLEEP",@"SPACE",@"SPC",@"SQR",@"STATIC", _
@"STDCALL",@"STEP",@"STOP",@"STR",@"STRING",@"STRPTR",@"SUB", _
@"SWAP",@"SYSTEM",@"SHR",@"SHL", _
@"TAB",@"TAN",@"THEN",@"THIS",@"THREADCREATE",@"THREADWAIT", _
@"TIME",@"TIMESERIAL",@"TIMEVALUE",@"TIMER",@"TO",@"TRANS", _
@"TRIM",@"TRUE",@"TYPE", _
@"UBOUND",@"UCASE", _
@"UNION",@"UNLOCK",@"UNSIGNED",@"UNTIL",@"USING", _
@"VA_ARG",@"VA_FIRST",@"VA_NEXT",@"VAL",@"VALLNG",@"VALINT", _
@"VALUINT",@"VALULNG",@"VAR",@"VARPTR",@"VIEW", _
@"WAIT",@"WBIN",@"WCHR",@"WEEKDAY",@"WEEKDAYNAME",@"WEND", _
@"WHILE",@"WHEX",@"WIDTH",@"WINDOW",@"WINDOWTITLE",@"WINPUT", _
@"WITH",@"WOCT",@"WRITE",@"WSPACE",@"WSTR",@"WSTRING", _
@"XOR",@"YEAR", _
@"AS",@"BYREF",@"BYVAL", _
@"BYTE",@"UBYTE",@"SHORT",@"USHORT",@"LONG",@"ULONG", _
@"INTEGER",@"UINTEGER",@"LONGINT",@"ULONGINT", _
@"SINGLE",@"DOUBLE",@"ZSTRING"}


' Search for a key, output error message if not exist (value = 0)
' Sucht Key _K_ und meldet Fehler wenn nicht vorhanden (Value = 0)
#DEFINE check(_T_, _K_) _
  IF g_hash_table_lookup(_T_, _K_) = 0 THEN _
    ? "Error, keyword not found: "; *_K_

' Callback for output: value first, then key
' Callback zur Ausgabe: erst Value, dann Key
SUB HashOut CDECL( _
  BYVAL key AS gpointer, _
  BYVAL value AS gpointer, _
  BYVAL user_data AS gpointer)

  ? GPOINTER_TO_INT(value), *CAST(ZSTRING PTR, key)
END SUB


' ***** main / Hauptprogramm *****

' Create new hash table / Neue HashTable erstellen
VAR table = g_hash_table_new(@g_str_hash, @g_str_equal)

' Insert keys and values / Fuellen mit den Keys und Values
FOR i AS INTEGER = 0 TO UBOUND(FBKEY)
  g_hash_table_insert(table, FBKEY(i), GINT_TO_POINTER(i + 1000))
NEXT i

' Replace an existing key / Ersetzen eines vorhandenen Keys (6 x)
FOR i AS INTEGER = 0 TO 5
  g_hash_table_insert(table, @"UBYTE", GINT_TO_POINTER(i - 999999))
NEXT i

' Check if all keys are available / Pruefen ob alle Keys vorhanden
FOR i AS INTEGER = 0 TO UBOUND(FBKEY)
  check(table, FBKEY(i))
NEXT i

' Print all keys and values / Alle Keys und Values ausgeben
g_hash_table_foreach(table, @HashOut, 0)

' Search for a non existing key / Suche einen nicht vorhandenen Key
check(table, @"FreeBasic-Portal")

' Destroy table, release memory / Tabelle aufloesen, Speicher freigeben
g_hash_table_unref(table)

#IFNDEF __FB_UNIX__
SLEEP
#ENDIF
