''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' symbol table module for keywords
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"

enum KWD_OPTION
    
    KWD_OPTION_DEFAULT
	KWD_OPTION_NO_QB

end enum

type SYMBKWD
	name			as zstring ptr
	id				as integer
    class			as integer
    opt             as KWD_OPTION
end type

	'' keywords: name, id (token), class
	dim shared kwdTb( 0 to FB_TOKENS-1 ) as SYMBKWD => _
	{ _
        (    @"AND"             , FB_TK_AND             , FB_TKCLASS_OPERATOR, KWD_OPTION_DEFAULT   ), _
        (    @"OR"              , FB_TK_OR              , FB_TKCLASS_OPERATOR, KWD_OPTION_DEFAULT   ), _
        (    @"XOR"             , FB_TK_XOR             , FB_TKCLASS_OPERATOR, KWD_OPTION_DEFAULT   ), _
        (    @"EQV"             , FB_TK_EQV             , FB_TKCLASS_OPERATOR, KWD_OPTION_DEFAULT   ), _
        (    @"IMP"             , FB_TK_IMP             , FB_TKCLASS_OPERATOR, KWD_OPTION_DEFAULT   ), _
        (    @"NOT"             , FB_TK_NOT             , FB_TKCLASS_OPERATOR, KWD_OPTION_DEFAULT   ), _
        (    @"MOD"             , FB_TK_MOD             , FB_TKCLASS_OPERATOR, KWD_OPTION_DEFAULT   ), _
        (    @"SHL"             , FB_TK_SHL             , FB_TKCLASS_OPERATOR, KWD_OPTION_DEFAULT   ), _
        (    @"SHR"             , FB_TK_SHR             , FB_TKCLASS_OPERATOR, KWD_OPTION_DEFAULT   ), _
        (    @"NEW"             , FB_TK_NEW             , FB_TKCLASS_OPERATOR, KWD_OPTION_NO_QB     ), _
        (    @"DELETE"          , FB_TK_DELETE          , FB_TKCLASS_OPERATOR, KWD_OPTION_NO_QB     ), _
        (    @"REM"             , FB_TK_REM             , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"VAR"             , FB_TK_VAR             , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB     ), _
        (    @"DIM"             , FB_TK_DIM             , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"ABS"             , FB_TK_ABS             , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"SGN"             , FB_TK_SGN             , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"FIX"             , FB_TK_FIX             , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"FRAC"            , FB_TK_FRAC            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"INT"             , FB_TK_INT             , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"STATIC"          , FB_TK_STATIC          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"SHARED"          , FB_TK_SHARED          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"BYTE"            , FB_TK_BYTE            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"UBYTE"           , FB_TK_UBYTE           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"SHORT"           , FB_TK_SHORT           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"USHORT"          , FB_TK_USHORT          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"INTEGER"         , FB_TK_INTEGER         , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"UINTEGER"        , FB_TK_UINT            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"LONG"            , FB_TK_LONG            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"ULONG"           , FB_TK_ULONG           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"LONGINT"         , FB_TK_LONGINT         , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"ULONGINT"        , FB_TK_ULONGINT        , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"SINGLE"          , FB_TK_SINGLE          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"DOUBLE"          , FB_TK_DOUBLE          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"STRING"          , FB_TK_STRING          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"ZSTRING"         , FB_TK_ZSTRING         , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"WSTRING"         , FB_TK_WSTRING         , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"UNSIGNED"        , FB_TK_UNSIGNED        , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"ANY"             , FB_TK_ANY             , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"PTR"             , FB_TK_PTR             , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"POINTER"         , FB_TK_POINTER         , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"VARPTR"          , FB_TK_VARPTR          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"WHILE"           , FB_TK_WHILE           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"UNTIL"           , FB_TK_UNTIL           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"WEND"            , FB_TK_WEND            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CONTINUE"        , FB_TK_CONTINUE        , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CBYTE"           , FB_TK_CBYTE           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CSHORT"          , FB_TK_CSHORT          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CINT"            , FB_TK_CINT            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CLNG"            , FB_TK_CLNG            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CLNGINT"         , FB_TK_CLNGINT         , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CUBYTE"          , FB_TK_CUBYTE          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CUSHORT"         , FB_TK_CUSHORT         , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CUINT"           , FB_TK_CUINT           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CULNG"           , FB_TK_CULNG           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CULNGINT"        , FB_TK_CULNGINT        , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CSNG"            , FB_TK_CSNG            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CDBL"            , FB_TK_CDBL            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CSIGN"           , FB_TK_CSIGN           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CUNSG"           , FB_TK_CUNSG           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CPTR"            , FB_TK_CPTR            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CAST"            , FB_TK_CAST            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CALL"            , FB_TK_CALL            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"BYVAL"           , FB_TK_BYVAL           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"BYREF"           , FB_TK_BYREF           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"AS"              , FB_TK_AS              , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"DECLARE"         , FB_TK_DECLARE         , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"GOTO"            , FB_TK_GOTO            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CONST"           , FB_TK_CONST           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"FOR"             , FB_TK_FOR             , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"STEP"            , FB_TK_STEP            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"NEXT"            , FB_TK_NEXT            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"TO"              , FB_TK_TO              , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"TYPE"            , FB_TK_TYPE            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"UNION"           , FB_TK_UNION           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"END"             , FB_TK_END             , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"SUB"             , FB_TK_SUB             , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"FUNCTION"        , FB_TK_FUNCTION        , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CDECL"           , FB_TK_CDECL           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"STDCALL"         , FB_TK_STDCALL         , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"PASCAL"          , FB_TK_PASCAL          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"ALIAS"           , FB_TK_ALIAS           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"LIB"             , FB_TK_LIB             , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB     ), _
        (    @"LET"             , FB_TK_LET             , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"EXIT"            , FB_TK_EXIT            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"DO"              , FB_TK_DO              , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"LOOP"            , FB_TK_LOOP            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"RETURN"          , FB_TK_RETURN          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"IF"              , FB_TK_IF              , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"THEN"            , FB_TK_THEN            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"ELSE"            , FB_TK_ELSE            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"ELSEIF"          , FB_TK_ELSEIF          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"ENDIF"           , FB_TK_ENDIF           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"SELECT"          , FB_TK_SELECT          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"CASE"            , FB_TK_CASE            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"IS"              , FB_TK_IS              , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"PUBLIC"          , FB_TK_PUBLIC          , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB     ), _
        (    @"PRIVATE"         , FB_TK_PRIVATE         , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB     ), _
        (    @"PROTECTED"       , FB_TK_PROTECTED       , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB     ), _
        (    @"PROCPTR"         , FB_TK_PROCPTR         , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB     ), _
        (    @"DATA"            , FB_TK_DATA            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"USING"           , FB_TK_USING           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"LEN"             , FB_TK_LEN             , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"PEEK"            , FB_TK_PEEK            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"POKE"            , FB_TK_POKE            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"SWAP"            , FB_TK_SWAP            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"COMMON"          , FB_TK_COMMON          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"ENUM"            , FB_TK_ENUM            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"ASM"             , FB_TK_ASM             , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"FIELD"           , FB_TK_FIELD           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"LOCAL"           , FB_TK_LOCAL           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"DEFINED"         , FB_TK_DEFINED         , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"EXTERN"          , FB_TK_EXTERN          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"STRPTR"          , FB_TK_STRPTR          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"WITH"            , FB_TK_WITH            , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"SCOPE"           , FB_TK_SCOPE           , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"NAMESPACE"       , FB_TK_NAMESPACE       , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB     ), _
        (    @"EXPORT"          , FB_TK_EXPORT          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"IMPORT"          , FB_TK_IMPORT          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"IIF"             , FB_TK_IIF             , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"VA_FIRST"        , FB_TK_VA_FIRST        , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"SIZEOF"          , FB_TK_SIZEOF          , FB_TKCLASS_KEYWORD , KWD_OPTION_DEFAULT   ), _
        (    @"OVERLOAD"        , FB_TK_OVERLOAD        , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB     ), _
        (    @"CONSTRUCTOR"     , FB_TK_CONSTRUCTOR     , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB     ), _
        (    @"DESTRUCTOR"      , FB_TK_DESTRUCTOR      , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB     ), _
        (    @"OPERATOR"        , FB_TK_OPERATOR        , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB     ), _
        (    @"PROPERTY"        , FB_TK_PROPERTY        , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB     ), _
        (    @"CLASS"           , FB_TK_CLASS           , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB     ), _
        (    @"DYNAMIC"         , FB_TK_DYNAMIC         , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"INCLUDE"         , FB_TK_INCLUDE         , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"GOSUB"           , FB_TK_GOSUB           , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"DEFBYTE"         , FB_TK_DEFBYTE         , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"DEFUBYTE"        , FB_TK_DEFUBYTE        , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"DEFSHORT"        , FB_TK_DEFSHORT        , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"DEFUSHORT"       , FB_TK_DEFUSHORT       , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"DEFINT"          , FB_TK_DEFINT          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"DEFUINT"         , FB_TK_DEFUINT         , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"DEFLNG"          , FB_TK_DEFLNG          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"DEFULNG"         , FB_TK_DEFULNG         , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"DEFLONGINT"      , FB_TK_DEFLNGINT       , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"DEFULONGINT"     , FB_TK_DEFULNGINT      , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"DEFSNG"          , FB_TK_DEFSNG          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"DEFDBL"          , FB_TK_DEFDBL          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"DEFSTR"          , FB_TK_DEFSTR          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"OPTION"          , FB_TK_OPTION          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"BASE"            , FB_TK_BASE            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"EXPLICIT"        , FB_TK_EXPLICIT        , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"SADD"            , FB_TK_SADD            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"ON"              , FB_TK_ON              , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"ERROR"           , FB_TK_ERROR           , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"SIN"             , FB_TK_SIN             , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"ASIN"            , FB_TK_ASIN            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"COS"             , FB_TK_COS             , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"ACOS"            , FB_TK_ACOS            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"TAN"             , FB_TK_TAN             , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"ATN"             , FB_TK_ATN             , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"SQR"             , FB_TK_SQR             , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"LOG"             , FB_TK_LOG             , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"EXP"             , FB_TK_EXP             , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"ATAN2"           , FB_TK_ATAN2           , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"RESUME"          , FB_TK_RESUME          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"ERR"             , FB_TK_ERR             , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"REDIM"           , FB_TK_REDIM           , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"ERASE"           , FB_TK_ERASE           , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"LBOUND"          , FB_TK_LBOUND          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"UBOUND"          , FB_TK_UBOUND          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"STR"             , FB_TK_STR             , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"WSTR"            , FB_TK_WSTR            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"MID"             , FB_TK_MID             , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"INSTR"           , FB_TK_INSTR           , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"TRIM"            , FB_TK_TRIM            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"RTRIM"           , FB_TK_RTRIM           , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"LTRIM"           , FB_TK_LTRIM           , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"RESTORE"         , FB_TK_RESTORE         , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"READ"            , FB_TK_READ            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"PRINT"           , FB_TK_PRINT           , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"LPRINT"          , FB_TK_LPRINT          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"OPEN"            , FB_TK_OPEN            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"CLOSE"           , FB_TK_CLOSE           , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"SEEK"            , FB_TK_SEEK            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"PUT"             , FB_TK_PUT             , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"GET"             , FB_TK_GET             , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"ACCESS"          , FB_TK_ACCESS          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"WRITE"           , FB_TK_WRITE           , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"LOCK"            , FB_TK_LOCK            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"INPUT"           , FB_TK_INPUT           , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"OUTPUT"          , FB_TK_OUTPUT          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"BINARY"          , FB_TK_BINARY          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"RANDOM"          , FB_TK_RANDOM          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"APPEND"          , FB_TK_APPEND          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"ENCODING"        , FB_TK_ENCODING        , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"NAME"            , FB_TK_NAME            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"WIDTH"           , FB_TK_WIDTH           , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"COLOR"           , FB_TK_COLOR           , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"PRESERVE"        , FB_TK_PRESERVE        , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"SPC"             , FB_TK_SPC             , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"TAB"             , FB_TK_TAB             , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"LINE"            , FB_TK_LINE            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"VIEW"            , FB_TK_VIEW            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"UNLOCK"          , FB_TK_UNLOCK          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"CHR"             , FB_TK_CHR             , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"WCHR"            , FB_TK_WCHR            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"ASC"             , FB_TK_ASC             , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"LSET"            , FB_TK_LSET            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"PSET"            , FB_TK_PSET            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"PRESET"          , FB_TK_PRESET          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"POINT"           , FB_TK_POINT           , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"CIRCLE"          , FB_TK_CIRCLE          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"WINDOW"          , FB_TK_WINDOW          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"PALETTE"         , FB_TK_PALETTE         , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"SCREEN"          , FB_TK_SCREEN          , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"SCREENRES"       , FB_TK_SCREENRES       , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"PAINT"           , FB_TK_PAINT           , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"DRAW"            , FB_TK_DRAW            , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (    @"IMAGECREATE"     , FB_TK_IMAGECREATE     , FB_TKCLASS_QUIRKWD , KWD_OPTION_DEFAULT   ), _
        (NULL) _
	}


'':::::
sub symbKeywordInit( ) static
    dim as integer i, do_add

	i = 0
	do until( kwdTb(i).name = NULL )
        
        do_add = TRUE

        select case as const kwdTb(i).opt
        	'' don't add if '-lang qb' is set.
        	case KWD_OPTION_NO_QB
        		do_add = (fbLangIsSet( FB_LANG_QB ) = FALSE)
        	''
        	case else
        	
        end select
        
        if( do_add ) then
        
	    	if( symbAddKeyword( kwdTb(i).name, _
	    						kwdTb(i).id, _
	    						kwdTb(i).class ) = NULL ) then
	    		exit sub
	    	end if

		end if

    	i += 1
    loop

end sub

'':::::
function symbAddKeyword _
	( _
		byval symbol as zstring ptr, _
		byval id as integer, _
		byval class_ as integer, _
		byval hashtb as FBHASHTB ptr _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr k

    k = symbNewSymbol( FB_SYMBOPT_DOHASH or FB_SYMBOPT_PRESERVECASE, _
    				   NULL, _
    				   @symbGetGlobalTb( ), hashtb, _
    				   FB_SYMBCLASS_KEYWORD, _
    				   symbol, NULL, _
    				   INVALID, NULL, 0 )
    if( k = NULL ) then
    	return NULL
    end if

    ''
    k->key.id = id
    k->key.tkclass = class_

    function = k

end function

'':::::
function symbDelKeyword _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

    function = FALSE

	if( s = NULL ) then
		exit function
	end if

	symbFreeSymbol( s )

	function = TRUE

end function


