'' symbol table module for keywords
''
'' chng: sep/2004 written [v1ctor]
''       jan/2005 updated to use real linked-lists [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "hash.bi"
#include once "list.bi"

enum KWD_OPTION
	KWD_OPTION_DEFAULT      = &h00000000
	KWD_OPTION_NO_QB        = &h00000001
	KWD_OPTION_STRSUFFIX    = &h00000002
	KWD_OPTION_QB_ONLY      = &h00000004
end enum

type SYMBKWD
	name            as const zstring ptr
	id              as integer
	class           as integer
	opt             as KWD_OPTION
end type

'' keywords: name, id (token), class, option
dim shared kwdTb( 0 to FB_TOKENS-1 ) as SYMBKWD => _
{ _
	( @"AND"        , FB_TK_AND         , FB_TKCLASS_OPERATOR ), _
	( @"OR"         , FB_TK_OR          , FB_TKCLASS_OPERATOR ), _
	( @"ANDALSO"    , FB_TK_ANDALSO     , FB_TKCLASS_OPERATOR ), _
	( @"ORELSE"     , FB_TK_ORELSE      , FB_TKCLASS_OPERATOR ), _
	( @"XOR"        , FB_TK_XOR         , FB_TKCLASS_OPERATOR ), _
	( @"EQV"        , FB_TK_EQV         , FB_TKCLASS_OPERATOR ), _
	( @"IMP"        , FB_TK_IMP         , FB_TKCLASS_OPERATOR ), _
	( @"NOT"        , FB_TK_NOT         , FB_TKCLASS_OPERATOR ), _
	( @"MOD"        , FB_TK_MOD         , FB_TKCLASS_OPERATOR ), _
	( @"SHL"        , FB_TK_SHL         , FB_TKCLASS_OPERATOR , KWD_OPTION_NO_QB ), _
	( @"SHR"        , FB_TK_SHR         , FB_TKCLASS_OPERATOR , KWD_OPTION_NO_QB ), _
	( @"NEW"        , FB_TK_NEW         , FB_TKCLASS_OPERATOR , KWD_OPTION_NO_QB ), _
	( @"DELETE"     , FB_TK_DELETE      , FB_TKCLASS_OPERATOR , KWD_OPTION_NO_QB ), _
	( @"REM"        , FB_TK_REM         , FB_TKCLASS_KEYWORD ), _
	( @"DIM"        , FB_TK_DIM         , FB_TKCLASS_KEYWORD ), _
	( @"ABS"        , FB_TK_ABS         , FB_TKCLASS_KEYWORD ), _
	( @"SGN"        , FB_TK_SGN         , FB_TKCLASS_KEYWORD ), _
	( @"FIX"        , FB_TK_FIX         , FB_TKCLASS_KEYWORD ), _
	( @"FRAC"       , FB_TK_FRAC        , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"INT"        , FB_TK_INT         , FB_TKCLASS_KEYWORD ), _
	( @"STATIC"     , FB_TK_STATIC      , FB_TKCLASS_KEYWORD ), _
	( @"SHARED"     , FB_TK_SHARED      , FB_TKCLASS_KEYWORD ), _
	( @"BOOLEAN"    , FB_TK_BOOLEAN     , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"BYTE"       , FB_TK_BYTE        , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"UBYTE"      , FB_TK_UBYTE       , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"SHORT"      , FB_TK_SHORT       , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"USHORT"     , FB_TK_USHORT      , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"INTEGER"    , FB_TK_INTEGER     , FB_TKCLASS_KEYWORD ), _
	( @"UINTEGER"   , FB_TK_UINT        , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"LONG"       , FB_TK_LONG        , FB_TKCLASS_KEYWORD ), _
	( @"ULONG"      , FB_TK_ULONG       , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"LONGINT"    , FB_TK_LONGINT     , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"ULONGINT"   , FB_TK_ULONGINT    , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"SINGLE"     , FB_TK_SINGLE      , FB_TKCLASS_KEYWORD ), _
	( @"DOUBLE"     , FB_TK_DOUBLE      , FB_TKCLASS_KEYWORD ), _
	( @"STRING"     , FB_TK_STRING      , FB_TKCLASS_KEYWORD , KWD_OPTION_STRSUFFIX ), _
	( @"ZSTRING"    , FB_TK_ZSTRING     , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"WSTRING"    , FB_TK_WSTRING     , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"UNSIGNED"   , FB_TK_UNSIGNED    , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"ANY"        , FB_TK_ANY         , FB_TKCLASS_KEYWORD ), _
	( @"PTR"        , FB_TK_PTR         , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"POINTER"    , FB_TK_POINTER     , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"TYPEOF"     , FB_TK_TYPEOF      , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"WHILE"      , FB_TK_WHILE       , FB_TKCLASS_KEYWORD ), _
	( @"UNTIL"      , FB_TK_UNTIL       , FB_TKCLASS_KEYWORD ), _
	( @"WEND"       , FB_TK_WEND        , FB_TKCLASS_KEYWORD ), _
	( @"CONTINUE"   , FB_TK_CONTINUE    , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CBOOL"      , FB_TK_CBOOL       , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CBYTE"      , FB_TK_CBYTE       , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CSHORT"     , FB_TK_CSHORT      , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CINT"       , FB_TK_CINT        , FB_TKCLASS_KEYWORD ), _
	( @"CLNG"       , FB_TK_CLNG        , FB_TKCLASS_KEYWORD ), _
	( @"CLNGINT"    , FB_TK_CLNGINT     , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CUBYTE"     , FB_TK_CUBYTE      , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CUSHORT"    , FB_TK_CUSHORT     , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CUINT"      , FB_TK_CUINT       , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CULNG"      , FB_TK_CULNG       , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CULNGINT"   , FB_TK_CULNGINT    , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CSNG"       , FB_TK_CSNG        , FB_TKCLASS_KEYWORD ), _
	( @"CDBL"       , FB_TK_CDBL        , FB_TKCLASS_KEYWORD ), _
	( @"CSIGN"      , FB_TK_CSIGN       , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CUNSG"      , FB_TK_CUNSG       , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CPTR"       , FB_TK_CPTR        , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CAST"       , FB_TK_CAST        , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CALL"       , FB_TK_CALL        , FB_TKCLASS_KEYWORD ), _
	( @"BYVAL"      , FB_TK_BYVAL       , FB_TKCLASS_KEYWORD ), _
	( @"BYREF"      , FB_TK_BYREF       , FB_TKCLASS_KEYWORD ), _
	( @"AS"         , FB_TK_AS          , FB_TKCLASS_KEYWORD ), _
	( @"DECLARE"    , FB_TK_DECLARE     , FB_TKCLASS_KEYWORD ), _
	( @"GOTO"       , FB_TK_GOTO        , FB_TKCLASS_KEYWORD ), _
	( @"CONST"      , FB_TK_CONST       , FB_TKCLASS_KEYWORD ), _
	( @"FOR"        , FB_TK_FOR         , FB_TKCLASS_KEYWORD ), _
	( @"STEP"       , FB_TK_STEP        , FB_TKCLASS_KEYWORD ), _
	( @"NEXT"       , FB_TK_NEXT        , FB_TKCLASS_KEYWORD ), _
	( @"TO"         , FB_TK_TO          , FB_TKCLASS_KEYWORD ), _
	( @"TYPE"       , FB_TK_TYPE        , FB_TKCLASS_KEYWORD ), _
	( @"UNION"      , FB_TK_UNION       , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"END"        , FB_TK_END         , FB_TKCLASS_KEYWORD ), _
	( @"SUB"        , FB_TK_SUB         , FB_TKCLASS_KEYWORD ), _
	( @"FUNCTION"   , FB_TK_FUNCTION    , FB_TKCLASS_KEYWORD ), _
	( @"CDECL"      , FB_TK_CDECL       , FB_TKCLASS_KEYWORD ), _
	( @"STDCALL"    , FB_TK_STDCALL     , FB_TKCLASS_KEYWORD ), _
	( @"__THISCALL" , FB_TK_THISCALL    , FB_TKCLASS_KEYWORD ), _
	( @"__FASTCALL" , FB_TK_FASTCALL    , FB_TKCLASS_KEYWORD ), _
	( @"PASCAL"     , FB_TK_PASCAL      , FB_TKCLASS_KEYWORD ), _
	( @"ALIAS"      , FB_TK_ALIAS       , FB_TKCLASS_KEYWORD ), _
	( @"LIB"        , FB_TK_LIB         , FB_TKCLASS_KEYWORD ), _
	( @"LET"        , FB_TK_LET         , FB_TKCLASS_KEYWORD ), _
	( @"EXIT"       , FB_TK_EXIT        , FB_TKCLASS_KEYWORD ), _
	( @"DO"         , FB_TK_DO          , FB_TKCLASS_KEYWORD ), _
	( @"LOOP"       , FB_TK_LOOP        , FB_TKCLASS_KEYWORD ), _
	( @"RETURN"     , FB_TK_RETURN      , FB_TKCLASS_KEYWORD ), _
	( @"IF"         , FB_TK_IF          , FB_TKCLASS_KEYWORD ), _
	( @"THEN"       , FB_TK_THEN        , FB_TKCLASS_KEYWORD ), _
	( @"ELSE"       , FB_TK_ELSE        , FB_TKCLASS_KEYWORD ), _
	( @"ELSEIF"     , FB_TK_ELSEIF      , FB_TKCLASS_KEYWORD ), _
	( @"ENDIF"      , FB_TK_ENDIF       , FB_TKCLASS_KEYWORD ), _
	( @"SELECT"     , FB_TK_SELECT      , FB_TKCLASS_KEYWORD ), _
	( @"CASE"       , FB_TK_CASE        , FB_TKCLASS_KEYWORD ), _
	( @"IS"         , FB_TK_IS          , FB_TKCLASS_KEYWORD ), _
	( @"USING"      , FB_TK_USING       , FB_TKCLASS_KEYWORD ), _
	( @"LEN"        , FB_TK_LEN         , FB_TKCLASS_QUIRKWD ), _
	( @"PEEK"       , FB_TK_PEEK        , FB_TKCLASS_KEYWORD ), _
	( @"POKE"       , FB_TK_POKE        , FB_TKCLASS_KEYWORD ), _
	( @"SWAP"       , FB_TK_SWAP        , FB_TKCLASS_KEYWORD ), _
	( @"COMMON"     , FB_TK_COMMON      , FB_TKCLASS_KEYWORD ), _
	( @"ENUM"       , FB_TK_ENUM        , FB_TKCLASS_KEYWORD ), _
	( @"ASM"        , FB_TK_ASM         , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"EXTERN"     , FB_TK_EXTERN      , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"WITH"       , FB_TK_WITH        , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"SCOPE"      , FB_TK_SCOPE       , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"PUBLIC"     , FB_TK_PUBLIC      , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"PRIVATE"    , FB_TK_PRIVATE     , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"PROTECTED"  , FB_TK_PROTECTED   , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"PROCPTR"    , FB_TK_PROCPTR     , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"NAMESPACE"  , FB_TK_NAMESPACE   , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"EXPORT"     , FB_TK_EXPORT      , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"IMPORT"     , FB_TK_IMPORT      , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"OVERLOAD"   , FB_TK_OVERLOAD    , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CONSTRUCTOR", FB_TK_CONSTRUCTOR , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"DESTRUCTOR" , FB_TK_DESTRUCTOR  , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"OPERATOR"   , FB_TK_OPERATOR    , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"PROPERTY"   , FB_TK_PROPERTY    , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CLASS"      , FB_TK_CLASS       , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"EXTENDS"    , FB_TK_EXTENDS     , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"IMPLEMENTS" , FB_TK_IMPLEMENTS  , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"BASE"       , FB_TK_BASE        , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"VIRTUAL"    , FB_TK_VIRTUAL     , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"ABSTRACT"   , FB_TK_ABSTRACT    , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"VAR"        , FB_TK_VAR         , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"IIF"        , FB_TK_IIF         , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"VA_FIRST"   , FB_TK_VA_FIRST    , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"DATA"       , FB_TK_DATA        , FB_TKCLASS_QUIRKWD ), _
	( @"FIELD"      , FB_TK_FIELD       , FB_TKCLASS_QUIRKWD ), _
	( @"LOCAL"      , FB_TK_LOCAL       , FB_TKCLASS_QUIRKWD ), _
	( @"DEFINED"    , FB_TK_DEFINED     , FB_TKCLASS_QUIRKWD ), _
	( @"SIZEOF"     , FB_TK_SIZEOF      , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"STRPTR"     , FB_TK_STRPTR      , FB_TKCLASS_QUIRKWD ), _
	( @"VARPTR"     , FB_TK_VARPTR      , FB_TKCLASS_QUIRKWD ), _
	( @"DYNAMIC"    , FB_TK_DYNAMIC     , FB_TKCLASS_QUIRKWD ), _
	( @"INCLUDE"    , FB_TK_INCLUDE     , FB_TKCLASS_QUIRKWD ), _
	( @"GOSUB"      , FB_TK_GOSUB       , FB_TKCLASS_QUIRKWD ), _
	( @"DEFBYTE"    , FB_TK_DEFBYTE     , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"DEFUBYTE"   , FB_TK_DEFUBYTE    , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"DEFSHORT"   , FB_TK_DEFSHORT    , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"DEFUSHORT"  , FB_TK_DEFUSHORT   , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"DEFINT"     , FB_TK_DEFINT      , FB_TKCLASS_QUIRKWD ), _
	( @"DEFUINT"    , FB_TK_DEFUINT     , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"DEFLNG"     , FB_TK_DEFLNG      , FB_TKCLASS_QUIRKWD ), _
	( @"DEFULNG"    , FB_TK_DEFULNG     , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"DEFLONGINT" , FB_TK_DEFLNGINT   , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"DEFULONGINT", FB_TK_DEFULNGINT  , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"DEFSNG"     , FB_TK_DEFSNG      , FB_TKCLASS_QUIRKWD ), _
	( @"DEFDBL"     , FB_TK_DEFDBL      , FB_TKCLASS_QUIRKWD ), _
	( @"DEFSTR"     , FB_TK_DEFSTR      , FB_TKCLASS_QUIRKWD ), _
	( @"OPTION"     , FB_TK_OPTION      , FB_TKCLASS_QUIRKWD ), _
	( @"EXPLICIT"   , FB_TK_EXPLICIT    , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"SADD"       , FB_TK_SADD        , FB_TKCLASS_QUIRKWD ), _
	( @"ON"         , FB_TK_ON          , FB_TKCLASS_QUIRKWD ), _
	( @"ERROR"      , FB_TK_ERROR       , FB_TKCLASS_QUIRKWD ), _
	( @"SIN"        , FB_TK_SIN         , FB_TKCLASS_QUIRKWD ), _
	( @"ASIN"       , FB_TK_ASIN        , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"COS"        , FB_TK_COS         , FB_TKCLASS_QUIRKWD ), _
	( @"ACOS"       , FB_TK_ACOS        , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"TAN"        , FB_TK_TAN         , FB_TKCLASS_QUIRKWD ), _
	( @"ATN"        , FB_TK_ATN         , FB_TKCLASS_QUIRKWD ), _
	( @"SQR"        , FB_TK_SQR         , FB_TKCLASS_QUIRKWD ), _
	( @"LOG"        , FB_TK_LOG         , FB_TKCLASS_QUIRKWD ), _
	( @"EXP"        , FB_TK_EXP         , FB_TKCLASS_QUIRKWD ), _
	( @"ATAN2"      , FB_TK_ATAN2       , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"RESUME"     , FB_TK_RESUME      , FB_TKCLASS_QUIRKWD ), _
	( @"ERR"        , FB_TK_ERR         , FB_TKCLASS_QUIRKWD ), _
	( @"REDIM"      , FB_TK_REDIM       , FB_TKCLASS_QUIRKWD ), _
	( @"ERASE"      , FB_TK_ERASE       , FB_TKCLASS_QUIRKWD ), _
	( @"LBOUND"     , FB_TK_LBOUND      , FB_TKCLASS_QUIRKWD ), _
	( @"UBOUND"     , FB_TK_UBOUND      , FB_TKCLASS_QUIRKWD ), _
	( @"STR"        , FB_TK_STR         , FB_TKCLASS_QUIRKWD , KWD_OPTION_STRSUFFIX ), _
	( @"CVD"        , FB_TK_CVD         , FB_TKCLASS_QUIRKWD ), _
	( @"CVS"        , FB_TK_CVS         , FB_TKCLASS_QUIRKWD ), _
	( @"CVI"        , FB_TK_CVI         , FB_TKCLASS_QUIRKWD ), _
	( @"CVL"        , FB_TK_CVL         , FB_TKCLASS_QUIRKWD ), _
	( @"CVSHORT"    , FB_TK_CVSHORT     , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"CVLONGINT"  , FB_TK_CVLONGINT   , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"MKD"        , FB_TK_MKD         , FB_TKCLASS_QUIRKWD , KWD_OPTION_STRSUFFIX ), _
	( @"MKS"        , FB_TK_MKS         , FB_TKCLASS_QUIRKWD , KWD_OPTION_STRSUFFIX ), _
	( @"MKI"        , FB_TK_MKI         , FB_TKCLASS_QUIRKWD , KWD_OPTION_STRSUFFIX ), _
	( @"MKL"        , FB_TK_MKL         , FB_TKCLASS_QUIRKWD , KWD_OPTION_STRSUFFIX ), _
	( @"MKSHORT"    , FB_TK_MKSHORT     , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"MKLONGINT"  , FB_TK_MKLONGINT   , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"WSTR"       , FB_TK_WSTR        , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"MID"        , FB_TK_MID         , FB_TKCLASS_QUIRKWD , KWD_OPTION_STRSUFFIX ), _
	( @"INSTR"      , FB_TK_INSTR       , FB_TKCLASS_QUIRKWD ), _
	( @"INSTRREV"   , FB_TK_INSTRREV    , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"TRIM"       , FB_TK_TRIM        , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"RTRIM"      , FB_TK_RTRIM       , FB_TKCLASS_QUIRKWD , KWD_OPTION_STRSUFFIX ), _
	( @"LTRIM"      , FB_TK_LTRIM       , FB_TKCLASS_QUIRKWD , KWD_OPTION_STRSUFFIX ), _
	( @"LCASE"      , FB_TK_LCASE       , FB_TKCLASS_QUIRKWD , KWD_OPTION_STRSUFFIX ), _
	( @"UCASE"      , FB_TK_UCASE       , FB_TKCLASS_QUIRKWD , KWD_OPTION_STRSUFFIX ), _
	( @"RESTORE"    , FB_TK_RESTORE     , FB_TKCLASS_QUIRKWD ), _
	( @"READ"       , FB_TK_READ        , FB_TKCLASS_QUIRKWD ), _
	( @"PRINT"      , FB_TK_PRINT       , FB_TKCLASS_QUIRKWD ), _
	( @"LPRINT"     , FB_TK_LPRINT      , FB_TKCLASS_QUIRKWD ), _
	( @"OPEN"       , FB_TK_OPEN        , FB_TKCLASS_QUIRKWD ), _
	( @"CLOSE"      , FB_TK_CLOSE       , FB_TKCLASS_QUIRKWD ), _
	( @"SEEK"       , FB_TK_SEEK        , FB_TKCLASS_QUIRKWD ), _
	( @"PUT"        , FB_TK_PUT         , FB_TKCLASS_QUIRKWD ), _
	( @"GET"        , FB_TK_GET         , FB_TKCLASS_QUIRKWD ), _
	( @"ACCESS"     , FB_TK_ACCESS      , FB_TKCLASS_QUIRKWD ), _
	( @"WRITE"      , FB_TK_WRITE       , FB_TKCLASS_QUIRKWD ), _
	( @"LOCK"       , FB_TK_LOCK        , FB_TKCLASS_QUIRKWD ), _
	( @"INPUT"      , FB_TK_INPUT       , FB_TKCLASS_QUIRKWD ), _
	( @"WINPUT"     , FB_TK_WINPUT      , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"OUTPUT"     , FB_TK_OUTPUT      , FB_TKCLASS_QUIRKWD ), _
	( @"BINARY"     , FB_TK_BINARY      , FB_TKCLASS_QUIRKWD ), _
	( @"RANDOM"     , FB_TK_RANDOM      , FB_TKCLASS_QUIRKWD ), _
	( @"APPEND"     , FB_TK_APPEND      , FB_TKCLASS_QUIRKWD ), _
	( @"ENCODING"   , FB_TK_ENCODING    , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"NAME"       , FB_TK_NAME        , FB_TKCLASS_QUIRKWD ), _
	( @"WIDTH"      , FB_TK_WIDTH       , FB_TKCLASS_QUIRKWD ), _
	( @"COLOR"      , FB_TK_COLOR       , FB_TKCLASS_QUIRKWD ), _
	( @"PRESERVE"   , FB_TK_PRESERVE    , FB_TKCLASS_QUIRKWD ), _
	( @"SPC"        , FB_TK_SPC         , FB_TKCLASS_QUIRKWD ), _
	( @"TAB"        , FB_TK_TAB         , FB_TKCLASS_QUIRKWD ), _
	( @"LINE"       , FB_TK_LINE        , FB_TKCLASS_QUIRKWD ), _
	( @"VIEW"       , FB_TK_VIEW        , FB_TKCLASS_QUIRKWD ), _
	( @"UNLOCK"     , FB_TK_UNLOCK      , FB_TKCLASS_QUIRKWD ), _
	( @"CHR"        , FB_TK_CHR         , FB_TKCLASS_QUIRKWD , KWD_OPTION_STRSUFFIX ), _
	( @"WCHR"       , FB_TK_WCHR        , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"ASC"        , FB_TK_ASC         , FB_TKCLASS_QUIRKWD ), _
	( @"LSET"       , FB_TK_LSET        , FB_TKCLASS_QUIRKWD ), _
	( @"RSET"       , FB_TK_RSET        , FB_TKCLASS_QUIRKWD ), _
	( @"PSET"       , FB_TK_PSET        , FB_TKCLASS_QUIRKWD ), _
	( @"PRESET"     , FB_TK_PRESET      , FB_TKCLASS_QUIRKWD ), _
	( @"POINT"      , FB_TK_POINT       , FB_TKCLASS_QUIRKWD ), _
	( @"CIRCLE"     , FB_TK_CIRCLE      , FB_TKCLASS_QUIRKWD ), _
	( @"WINDOW"     , FB_TK_WINDOW      , FB_TKCLASS_QUIRKWD ), _
	( @"PALETTE"    , FB_TK_PALETTE     , FB_TKCLASS_QUIRKWD ), _
	( @"SCREEN"     , FB_TK_SCREEN      , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"SCREEN"     , FB_TK_SCREENQB    , FB_TKCLASS_QUIRKWD , KWD_OPTION_QB_ONLY ), _
	( @"PAINT"      , FB_TK_PAINT       , FB_TKCLASS_QUIRKWD ), _
	( @"DRAW"       , FB_TK_DRAW        , FB_TKCLASS_QUIRKWD ), _
	( @"IMAGECREATE", FB_TK_IMAGECREATE , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"THREADCALL" , FB_TK_THREADCALL  , FB_TKCLASS_QUIRKWD , KWD_OPTION_NO_QB ), _
	( @"CVA_START"  , FB_TK_CVA_START   , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CVA_END"    , FB_TK_CVA_END     , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CVA_ARG"    , FB_TK_CVA_ARG     , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( @"CVA_COPY"   , FB_TK_CVA_COPY    , FB_TKCLASS_KEYWORD , KWD_OPTION_NO_QB ), _
	( NULL ) _
}

'' FALSE/TRUE are names of keyword constants but
'' don't exactly fit in purpose of the KwdTb().
dim shared kwdFALSE as zstring * 6 = "FALSE"
dim shared kwdTRUE as zstring * 5  = "TRUE"

'':::::
sub symbKeywordInit( )

	dim as integer i = 0
	do until( kwdTb(i).name = NULL )

		'' add the '__' prefix if the kwd wasn't present in QB and we are in '-lang qb' mode
		dim as const zstring ptr kname = kwdTb(i).name
		if( (kwdTb(i).opt and KWD_OPTION_NO_QB) <> 0 ) then
			if( fbLangIsSet( FB_LANG_QB ) ) then
				static as string tmp
				tmp = "__" + *kname
				kname = strptr( tmp )
			end if
		end if

		if( (kwdTb(i).opt and KWD_OPTION_QB_ONLY) <> 0 ) then
			if( fbLangIsSet( FB_LANG_QB ) = FALSE ) then
				'' skip QB-only keywords when not in -lang qb
				i += 1
				continue do
			end if
		end if

		'' QB quirks..
		if( (kwdTb(i).opt and KWD_OPTION_STRSUFFIX) <> 0 ) then
			symbAddKeyword( kname, _
							kwdTb(i).id, _
							kwdTb(i).class, _
							NULL, _
							FB_DATATYPE_STRING, _
							FB_SYMBATTRIB_SUFFIXED )
		else
			symbAddKeyword( kname, kwdTb(i).id, kwdTb(i).class )
		end if

		i += 1
	loop

end sub

'':::::
function symbAddKeyword _
	( _
		byval symbol as const zstring ptr, _
		byval id as integer, _
		byval class_ as integer, _
		byval hashtb as FBHASHTB ptr, _
		byval dtype as integer, _
		byval attrib as FB_SYMBATTRIB _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr k = any

	k = symbNewSymbol( FB_SYMBOPT_DOHASH or FB_SYMBOPT_PRESERVECASE, _
	                   NULL, _
	                   @symbGetGlobalTb( ), hashtb, _
	                   FB_SYMBCLASS_KEYWORD, _
	                   symbol, NULL, _
	                   dtype, NULL, _
	                   attrib, FB_PROCATTRIB_NONE )
	if( k = NULL ) then
		return NULL
	end if

	''
	k->key.id = id
	k->key.tkclass = class_

	function = k

end function

function symbKeywordGetText( byval tk as integer ) as const zstring ptr
	'' This is super slow, but as long as it's only used for error
	'' reporting it does not matter.
	'' (TODO: sort the keyword table to match FB_TOKEN enum)
	for i as integer = lbound( kwdTb ) to ubound( kwdTb )
		if( kwdTb(i).id = tk ) then
			return kwdTb(i).name
		end if
	next
	function = @""
end function

'':::::
sub symbKeywordConstsInit( )

	dim as FBVALUE v
	dim id as string * 10

	dim as FB_SYMBATTRIB attrib = any
	dim as FBSYMBOL ptr sym = any

	attrib = FB_SYMBATTRIB_CONST or FB_SYMBATTRIB_LITERAL

	v.i = cint(0)
	if( fbLangIsSet( FB_LANG_QB ) ) then
		id = "__" + kwdFALSE
	else
		id = kwdFALSE
	end if
	sym = symbAddConst( strptr(id), FB_DATATYPE_BOOLEAN, NULL, @v, attrib )
	'' Success? ... symbAddConst() may fail if id was defined on the command line
	if( sym ) then
		symbSetCanRedef( sym )
	end if

	v.i = cint(-1)
	if( fbLangIsSet( FB_LANG_QB ) ) then
		id = "__" + kwdTRUE
	else
		id = kwdTRUE
	end if
	'' Success? ... symbAddConst() may fail if id was defined on the command line
	sym = symbAddConst( strptr(id), FB_DATATYPE_BOOLEAN, NULL, @v, attrib )
	if( sym ) then
		symbSetCanRedef( sym )
	end if

end sub

'':::::
sub symbKeywordTypeInit( )

	dim as FBSYMBOL ptr s = any
	dim pid as zstring ptr = any
	dim dtype as integer = any


	'' add the default cva_list type
	''
	''  #if (__FB_BACKEND__ = "gcc")
	''      #if defined( __FB_64BIT__ )
	''          #if defined( __FB_ARM__ )
	''              type __va_list alias "__va_list"
	''                  as any ptr __stack
	''                  as any ptr __gr_top
	''                  as any ptr __vr_top
	''                  as long __gr_offs
	''                  as long __vr_offs
	''              end type
	''              type cva_list as __va_list alias "__builtin_va_list"
	''          #elseif defined( __FB_WIN32__ )
	''              type cva_list as any alias "__builtin_va_list" ptr
	''          #else
	''              type __va_list_tag alias "__va_list_tag"
	''                  as ulong gp_offset
	''                  as ulong fp_offset
	''                  as any ptr overflow_arg_area
	''                  as any ptr reg_save_area
	''              end type
	''              type cva_list as __va_list_tag alias "__builtin_va_list[]"
	''          #endif
	''      #else
	''          #if defined( __FB_ARM__ )
	''              type __va_list alias "__va_list"
	''                  as any ptr __ap
	''              end type
	''              type cva_list as __va_list alias "__builtin_va_list"
	''          #else
	''              type cva_list as any alias "__builtin_va_list" ptr
	''          #endif
	''      #endif
	''  #else
	''      type cva_list as any alias "char" ptr
	''  #endif

	static as FBARRAYDIM dTB(0)

	if( fbLangIsSet( FB_LANG_QB ) ) then
		pid = @"__cva_list"
	else
		pid = @"cva_list"
	end if

	'' add the default cva_list type based on target options

	select case fbGetBackendValistType()
	case FB_CVA_LIST_BUILTIN_POINTER
		'' cva_list as any alias "__builtin_va_list" ptr (built-in pointer expression)
		dtype = typeSetMangleDt( typeAddrOf( FB_DATATYPE_VOID ), FB_DATATYPE_VA_LIST )
		symbAddTypedef( pid, dtype, NULL, typeGetSize( typeAddrOf( FB_DATATYPE_VOID ) ) )

	case FB_CVA_LIST_BUILTIN_C_STD
		'' cva_list is __builtin_va_list from C definition:
		''  typedef struct __va_list_tag {
		''      unsigned int gp_offset;
		''      unsigned int fp_offset;
		''      void *overflow_arg_area;
		''      void *reg_save_area;
		''  } va_list[1];

		s = symbStructBegin( NULL, NULL, NULL, "__va_list_tag", "__va_list_tag", FALSE, 0, FALSE, 0, 0 )

		'' gp_offset as ulong
		symbAddField( s, "gp_offset", 0, dTB(), FB_DATATYPE_ULONG, NULL, 0, 0, 0 )

		'' fp_offset as ulong
		symbAddField( s, "fp_offset", 0, dTB(), FB_DATATYPE_ULONG, NULL, 0, 0, 0 )

		'' overflow_arg_area as any ptr
		symbAddField( s, "overflow_arg_area", 0, dTB(), typeAddrOf( FB_DATATYPE_VOID ), NULL, 0, 0, 0 )

		'' reg_save_area as any ptr
		symbAddField( s, "reg_save_area", 0, dTB(), typeAddrOf( FB_DATATYPE_VOID ), NULL, 0, 0, 0 )

		'' end type
		symbStructEnd( s )

		'' subtype mangle modifier
		'' don't clone struct, back patch the original only, see note in cMangleModifier()
		'' TODO: s = symbCloneSymbol( s )
		symbSetUdtValistType( s, FB_CVA_LIST_BUILTIN_C_STD )

		'' type cva_list as __va_list_tag alias "__builtin_va_list[]"
		symbAddTypedef( pid, typeSetMangleDt( symbGetType( s ), FB_DATATYPE_VA_LIST ), s, symbGetLen( s ) )

	case FB_CVA_LIST_BUILTIN_AARCH64
		'' cva_list is from ARM64 definition:
		''  typdef struct __va_list {
		''      void *__stack;
		''      void *__gr_top;
		''      void *__vr_top;
		''      int   __gr_offs;
		''      int   __vr_offs;
		''  } va_list;

		s = symbStructBegin( NULL, NULL, NULL, "__va_list", "__va_list", FALSE, 0, FALSE, 0, 0 )

		'' __stack as any ptr
		symbAddField( s, "__stack", 0, dTB(), typeAddrOf( FB_DATATYPE_VOID ), NULL, 0, 0, 0 )

		'' __gr_top as any ptr
		symbAddField( s, "__gr_top", 0, dTB(), typeAddrOf( FB_DATATYPE_VOID ), NULL, 0, 0, 0 )

		'' __vr_top as any ptr
		symbAddField( s, "__vr_top", 0, dTB(), typeAddrOf( FB_DATATYPE_VOID ), NULL, 0, 0, 0 )

		'' __gr_offs as long
		symbAddField( s, "__gr_offs", 0, dTB(), FB_DATATYPE_LONG, NULL, 0, 0, 0 )

		'' __vr_offs as long
		symbAddField( s, "__vr_offs", 0, dTB(), FB_DATATYPE_LONG, NULL, 0, 0, 0 )

		'' end type
		symbStructEnd( s )

		'' subtype mangle modifier
		'' don't clone struct, back patch the original only, see note in cMangleModifier()
		'' TODO: s = symbCloneSymbol( s )
		symbSetUdtValistType( s, FB_CVA_LIST_BUILTIN_AARCH64 )

		'' type cva_list as __va_list alias "__builtin_va_list"
		symbAddTypedef( pid, typeSetMangleDt( symbGetType( s ), FB_DATATYPE_VA_LIST ), s, symbGetLen( s ) )

	case FB_CVA_LIST_BUILTIN_ARM
		'' cva_list is from ARM definition
		''  typdef struct __va_list {
		''      void *__ap;
		''  } va_list;

		s = symbStructBegin( NULL, NULL, NULL, "__va_list", "__va_list", FALSE, 0, FALSE, 0, 0 )

		'' ap as any ptr
		symbAddField( s, "__ap", 0, dTB(), typeAddrOf( FB_DATATYPE_VOID ), NULL, 0, 0, 0 )

		'' end type
		symbStructEnd( s )

		'' subtype mangle modifier
		'' don't clone struct, back patch the original only, see note in cMangleModifier()
		'' TODO: s = symbCloneSymbol( s )
		symbSetUdtValistType( s, FB_CVA_LIST_BUILTIN_ARM )

		'' type cva_list as __va_list alias "__builtin_va_list"
		symbAddTypedef( pid, typeSetMangleDt( symbGetType( s ), FB_DATATYPE_VA_LIST ), s, symbGetLen( s ) )

	case else
		'' FB_CVA_LIST_POINTER
		'' cva_list as any alias "char" ptr (pointer expression)
		dtype = typeSetMangleDt( typeAddrOf( FB_DATATYPE_VOID ), FB_DATATYPE_CHAR )
		symbAddTypedef( pid, dtype, NULL, typeGetSize( typeAddrOf( FB_DATATYPE_VOID ) ) )

	end select

end sub
