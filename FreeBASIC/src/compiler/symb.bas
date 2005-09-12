''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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


'' symbol table module
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"
#include once "inc\ir.bi"
#include once "inc\emit.bi"
#include once "inc\emitdbg.bi"
#include once "inc\lex.bi"

const FBPREFIX_PROCRES = "{fbpr}"


type SYMBCTX
	inited			as integer

	symlist			as TLIST					'' symbols (VAR, CONST, FUNCTION, UDT, ENUM, LABEL, etc)
	symhash			as THASH

	globtb			as FBSYMBOLTB
	symtb			as FBSYMBOLTB ptr			'' current table

	liblist 		as TLIST					'' libraries
	libhash			as THASH

	dimlist			as TLIST					'' array dimensions
	defarglist		as TLIST					'' define arguments
	deftoklist		as TLIST					'' define tokens
	fwdlist			as TLIST					'' forward typedef refs

	lastlbl			as FBSYMBOL ptr

	fwdrefcnt 		as integer
	defargcnt		as integer
end type

type SYMBKWD
	name			as zstring * 16
	id				as integer
    class			as integer
end type

type DEFCALLBACK as function() as string

type SYMBDEF
	name			as zstring * 20
	value			as zstring * 12
	flags			as integer
	proc			as DEFCALLBACK
end type

declare sub			symbDelGlobalTb ( )

declare sub 		hFreeSymbol		( byval s as FBSYMBOL ptr, _
									  byval movetoglob as integer = FALSE )

declare function 	hCalcDiff		( byval dimensions as integer, _
									  dTB() as FBARRAYDIM, _
									  byval lgt as integer ) as integer

declare function 	hCalcElements2	( byval dimensions as integer, _
									  dTB() as FBARRAYDIM ) as integer

declare function	hDefFile_cb		( ) as string
declare function	hDefFunction_cb	( ) as string
declare function	hDefLine_cb		( ) as string
declare function	hDefDate_cb		( ) as string
declare function	hDefTime_cb		( ) as string
declare function    hDefMultithread_cb( ) as string


''globals
	dim shared ctx as SYMBCTX

'' predefined #defines: name, value, flags, proc (for description flags, see FBS_DEFINE)
const SYMB_MAXDEFINES = 16

	dim shared defTb( 0 to SYMB_MAXDEFINES-1 ) as SYMBDEF => _
	{ _
		("__FB_VERSION__",			FB_VERSION,		  0, NULL				), _
		("__FB_VER_MAJOR__",		FB_VER_STR_MAJOR, 1, NULL               ), _
		("__FB_VER_MINOR__",		FB_VER_STR_MINOR, 1, NULL               ), _
		("__FB_VER_PATCH__",		FB_VER_STR_PATCH, 1, NULL               ), _
		("__FB_SIGNATURE__",		FB_SIGN,		  0, NULL               ), _
		("__FB_MT__",				"",				  1, @hDefMultithread_cb), _
		("__FILE__",				"",				  0, @hDefFile_cb       ), _
		("__FUNCTION__",			"",				  0, @hDefFunction_cb   ), _
		("__LINE__",				"",				  1, @hDefLine_cb       ), _
		("__DATE__",				"",				  0, @hDefDate_cb       ), _
		("__TIME__",				"",				  0, @hDefTime_cb       ), _
		("") _
	}

	'' keywords: name, id (token), class
const SYMB_MAXKEYWORDS = 210

	dim shared kwdTb( 0 to SYMB_MAXKEYWORDS-1 ) as SYMBKWD => _
	{ _
		("AND"		, FB_TK_AND			, FB_TKCLASS_OPERATOR), _
        ("OR"		, FB_TK_OR			, FB_TKCLASS_OPERATOR), _
        ("XOR"		, FB_TK_XOR			, FB_TKCLASS_OPERATOR), _
        ("EQV"		, FB_TK_EQV			, FB_TKCLASS_OPERATOR), _
        ("IMP"		, FB_TK_IMP			, FB_TKCLASS_OPERATOR), _
        ("NOT"		, FB_TK_NOT			, FB_TKCLASS_OPERATOR), _
        ("MOD"		, FB_TK_MOD			, FB_TKCLASS_OPERATOR), _
        ("SHL"		, FB_TK_SHL			, FB_TKCLASS_OPERATOR), _
        ("SHR"		, FB_TK_SHR			, FB_TKCLASS_OPERATOR), _
        ("REM"		, FB_TK_REM			, FB_TKCLASS_KEYWORD), _
        ("DIM"		, FB_TK_DIM			, FB_TKCLASS_KEYWORD), _
        ("STATIC"	, FB_TK_STATIC		, FB_TKCLASS_KEYWORD), _
        ("SHARED"	, FB_TK_SHARED		, FB_TKCLASS_KEYWORD), _
        ("INTEGER"	, FB_TK_INTEGER		, FB_TKCLASS_KEYWORD), _
        ("LONG"		, FB_TK_LONG		, FB_TKCLASS_KEYWORD), _
        ("SINGLE"	, FB_TK_SINGLE		, FB_TKCLASS_KEYWORD), _
        ("DOUBLE"	, FB_TK_DOUBLE		, FB_TKCLASS_KEYWORD), _
        ("STRING"	, FB_TK_STRING		, FB_TKCLASS_KEYWORD), _
        ("CALL"		, FB_TK_CALL		, FB_TKCLASS_KEYWORD), _
        ("BYVAL"	, FB_TK_BYVAL		, FB_TKCLASS_KEYWORD), _
        ("INCLUDE"	, FB_TK_INCLUDE		, FB_TKCLASS_KEYWORD), _
        ("DYNAMIC"	, FB_TK_DYNAMIC		, FB_TKCLASS_KEYWORD), _
        ("AS"		, FB_TK_AS			, FB_TKCLASS_KEYWORD), _
        ("DECLARE"	, FB_TK_DECLARE		, FB_TKCLASS_KEYWORD), _
        ("GOTO"		, FB_TK_GOTO		, FB_TKCLASS_KEYWORD), _
        ("GOSUB"	, FB_TK_GOSUB		, FB_TKCLASS_KEYWORD), _
        ("DEFBYTE"	, FB_TK_DEFBYTE		, FB_TKCLASS_KEYWORD), _
        ("DEFUBYTE"	, FB_TK_DEFUBYTE	, FB_TKCLASS_KEYWORD), _
        ("DEFSHORT"	, FB_TK_DEFSHORT	, FB_TKCLASS_KEYWORD), _
        ("DEFUSHORT", FB_TK_DEFUSHORT	, FB_TKCLASS_KEYWORD), _
        ("DEFINT"	, FB_TK_DEFINT		, FB_TKCLASS_KEYWORD), _
        ("DEFUINT"	, FB_TK_DEFUINT		, FB_TKCLASS_KEYWORD), _
        ("DEFLNG"	, FB_TK_DEFLNG		, FB_TKCLASS_KEYWORD), _
        ("DEFLONGINT", FB_TK_DEFLNGINT	, FB_TKCLASS_KEYWORD), _
        ("DEFULONGINT", FB_TK_DEFULNGINT, FB_TKCLASS_KEYWORD), _
        ("DEFSNG"	, FB_TK_DEFSNG		, FB_TKCLASS_KEYWORD), _
        ("DEFDBL"	, FB_TK_DEFDBL		, FB_TKCLASS_KEYWORD), _
        ("DEFSTR"	, FB_TK_DEFSTR		, FB_TKCLASS_KEYWORD), _
        ("CONST"	, FB_TK_CONST		, FB_TKCLASS_KEYWORD), _
        ("FOR"		, FB_TK_FOR			, FB_TKCLASS_KEYWORD), _
        ("STEP"		, FB_TK_STEP		, FB_TKCLASS_KEYWORD), _
        ("NEXT"		, FB_TK_NEXT		, FB_TKCLASS_KEYWORD), _
        ("TO"		, FB_TK_TO			, FB_TKCLASS_KEYWORD), _
        ("TYPE"		, FB_TK_TYPE		, FB_TKCLASS_KEYWORD), _
        ("END"		, FB_TK_END			, FB_TKCLASS_KEYWORD), _
        ("SUB"		, FB_TK_SUB			, FB_TKCLASS_KEYWORD), _
        ("FUNCTION"	, FB_TK_FUNCTION	, FB_TKCLASS_KEYWORD), _
        ("CDECL"	, FB_TK_CDECL		, FB_TKCLASS_KEYWORD), _
        ("STDCALL"	, FB_TK_STDCALL		, FB_TKCLASS_KEYWORD), _
        ("ALIAS"	, FB_TK_ALIAS		, FB_TKCLASS_KEYWORD), _
        ("LIB"		, FB_TK_LIB			, FB_TKCLASS_KEYWORD), _
        ("LET"		, FB_TK_LET			, FB_TKCLASS_KEYWORD), _
        ("BYTE"		, FB_TK_BYTE		, FB_TKCLASS_KEYWORD), _
        ("UBYTE"	, FB_TK_UBYTE		, FB_TKCLASS_KEYWORD), _
        ("SHORT"	, FB_TK_SHORT		, FB_TKCLASS_KEYWORD), _
        ("USHORT"	, FB_TK_USHORT		, FB_TKCLASS_KEYWORD), _
        ("UINTEGER"	, FB_TK_UINT		, FB_TKCLASS_KEYWORD), _
        ("EXIT"		, FB_TK_EXIT		, FB_TKCLASS_KEYWORD), _
        ("DO"		, FB_TK_DO			, FB_TKCLASS_KEYWORD), _
        ("LOOP"		, FB_TK_LOOP		, FB_TKCLASS_KEYWORD), _
        ("RETURN"	, FB_TK_RETURN		, FB_TKCLASS_KEYWORD), _
        ("ANY"		, FB_TK_ANY			, FB_TKCLASS_KEYWORD), _
        ("PTR"		, FB_TK_PTR			, FB_TKCLASS_KEYWORD), _
        ("POINTER"	, FB_TK_POINTER		, FB_TKCLASS_KEYWORD), _
        ("VARPTR"	, FB_TK_VARPTR		, FB_TKCLASS_KEYWORD), _
        ("WHILE"	, FB_TK_WHILE		, FB_TKCLASS_KEYWORD), _
        ("UNTIL"	, FB_TK_UNTIL		, FB_TKCLASS_KEYWORD), _
        ("WEND"		, FB_TK_WEND		, FB_TKCLASS_KEYWORD), _
        ("CONTINUE"	, FB_TK_CONTINUE	, FB_TKCLASS_KEYWORD), _
        ("CBYTE"	, FB_TK_CBYTE		, FB_TKCLASS_KEYWORD), _
        ("CSHORT"	, FB_TK_CSHORT		, FB_TKCLASS_KEYWORD), _
        ("CINT"		, FB_TK_CINT		, FB_TKCLASS_KEYWORD), _
        ("CLNG"		, FB_TK_CLNG		, FB_TKCLASS_KEYWORD), _
        ("CLNGINT"	, FB_TK_CLNGINT		, FB_TKCLASS_KEYWORD), _
        ("CUBYTE"	, FB_TK_CUBYTE		, FB_TKCLASS_KEYWORD), _
        ("CUSHORT"	, FB_TK_CUSHORT		, FB_TKCLASS_KEYWORD), _
        ("CUINT"	, FB_TK_CUINT		, FB_TKCLASS_KEYWORD), _
        ("CULNGINT"	, FB_TK_CULNGINT	, FB_TKCLASS_KEYWORD), _
        ("CSNG"		, FB_TK_CSNG		, FB_TKCLASS_KEYWORD), _
        ("CDBL"		, FB_TK_CDBL		, FB_TKCLASS_KEYWORD), _
        ("CSIGN"	, FB_TK_CSIGN		, FB_TKCLASS_KEYWORD), _
        ("CUNSG"	, FB_TK_CUNSG		, FB_TKCLASS_KEYWORD), _
        ("CPTR"		, FB_TK_CPTR		, FB_TKCLASS_KEYWORD), _
        ("IF"		, FB_TK_IF			, FB_TKCLASS_KEYWORD), _
        ("THEN"		, FB_TK_THEN		, FB_TKCLASS_KEYWORD), _
        ("ELSE"		, FB_TK_ELSE		, FB_TKCLASS_KEYWORD), _
        ("ELSEIF"	, FB_TK_ELSEIF		, FB_TKCLASS_KEYWORD), _
        ("SELECT"	, FB_TK_SELECT		, FB_TKCLASS_KEYWORD), _
        ("CASE"		, FB_TK_CASE		, FB_TKCLASS_KEYWORD), _
        ("IS"		, FB_TK_IS			, FB_TKCLASS_KEYWORD), _
        ("UNSIGNED"	, FB_TK_UNSIGNED	, FB_TKCLASS_KEYWORD), _
        ("REDIM"	, FB_TK_REDIM		, FB_TKCLASS_KEYWORD), _
        ("ERASE"	, FB_TK_ERASE		, FB_TKCLASS_KEYWORD), _
        ("LBOUND"	, FB_TK_LBOUND		, FB_TKCLASS_KEYWORD), _
        ("UBOUND"	, FB_TK_UBOUND		, FB_TKCLASS_KEYWORD), _
        ("UNION"	, FB_TK_UNION		, FB_TKCLASS_KEYWORD), _
        ("PUBLIC"	, FB_TK_PUBLIC		, FB_TKCLASS_KEYWORD), _
        ("PRIVATE"	, FB_TK_PRIVATE		, FB_TKCLASS_KEYWORD), _
        ("STR"		, FB_TK_STR			, FB_TKCLASS_KEYWORD), _
        ("MID"		, FB_TK_MID			, FB_TKCLASS_KEYWORD), _
 		("INSTR"	, FB_TK_INSTR		, FB_TKCLASS_KEYWORD), _
		("TRIM"		, FB_TK_TRIM		, FB_TKCLASS_KEYWORD), _
        ("RTRIM"	, FB_TK_RTRIM		, FB_TKCLASS_KEYWORD), _
        ("LTRIM"	, FB_TK_LTRIM		, FB_TKCLASS_KEYWORD), _
        ("BYREF"	, FB_TK_BYREF		, FB_TKCLASS_KEYWORD), _
        ("OPTION"	, FB_TK_OPTION		, FB_TKCLASS_KEYWORD), _
        ("BASE"		, FB_TK_BASE		, FB_TKCLASS_KEYWORD), _
        ("EXPLICIT"	, FB_TK_EXPLICIT	, FB_TKCLASS_KEYWORD), _
        ("PASCAL"	, FB_TK_PASCAL		, FB_TKCLASS_KEYWORD), _
        ("PROCPTR"	, FB_TK_PROCPTR		, FB_TKCLASS_KEYWORD), _
        ("SADD"		, FB_TK_SADD		, FB_TKCLASS_KEYWORD), _
        ("RESTORE"	, FB_TK_RESTORE		, FB_TKCLASS_KEYWORD), _
        ("READ"		, FB_TK_READ		, FB_TKCLASS_KEYWORD), _
        ("DATA"		, FB_TK_DATA		, FB_TKCLASS_KEYWORD), _
        ("ABS"		, FB_TK_ABS			, FB_TKCLASS_KEYWORD), _
        ("SGN"		, FB_TK_SGN			, FB_TKCLASS_KEYWORD), _
        ("FIX"		, FB_TK_FIX			, FB_TKCLASS_KEYWORD), _
        ("PRINT"	, FB_TK_PRINT		, FB_TKCLASS_KEYWORD), _
        ("LPRINT"	, FB_TK_LPRINT		, FB_TKCLASS_KEYWORD), _
        ("USING"	, FB_TK_USING		, FB_TKCLASS_KEYWORD), _
        ("LEN"		, FB_TK_LEN			, FB_TKCLASS_KEYWORD), _
        ("PEEK"		, FB_TK_PEEK		, FB_TKCLASS_KEYWORD), _
        ("POKE"		, FB_TK_POKE		, FB_TKCLASS_KEYWORD), _
        ("SWAP"		, FB_TK_SWAP		, FB_TKCLASS_KEYWORD), _
        ("COMMON"	, FB_TK_COMMON		, FB_TKCLASS_KEYWORD), _
        ("OPEN"		, FB_TK_OPEN		, FB_TKCLASS_KEYWORD), _
        ("CLOSE"	, FB_TK_CLOSE		, FB_TKCLASS_KEYWORD), _
        ("SEEK"		, FB_TK_SEEK		, FB_TKCLASS_KEYWORD), _
        ("PUT"		, FB_TK_PUT			, FB_TKCLASS_KEYWORD), _
        ("GET"		, FB_TK_GET			, FB_TKCLASS_KEYWORD), _
        ("ACCESS"	, FB_TK_ACCESS		, FB_TKCLASS_KEYWORD), _
        ("WRITE"	, FB_TK_WRITE		, FB_TKCLASS_KEYWORD), _
        ("LOCK"		, FB_TK_LOCK		, FB_TKCLASS_KEYWORD), _
        ("INPUT"	, FB_TK_INPUT		, FB_TKCLASS_KEYWORD), _
        ("OUTPUT"	, FB_TK_OUTPUT		, FB_TKCLASS_KEYWORD), _
        ("BINARY"	, FB_TK_BINARY		, FB_TKCLASS_KEYWORD), _
        ("RANDOM"	, FB_TK_RANDOM		, FB_TKCLASS_KEYWORD), _
        ("APPEND"	, FB_TK_APPEND		, FB_TKCLASS_KEYWORD), _
        ("NAME"		, FB_TK_NAME		, FB_TKCLASS_KEYWORD), _
        ("WIDTH"	, FB_TK_WIDTH		, FB_TKCLASS_KEYWORD), _
        ("PRESERVE"	, FB_TK_PRESERVE	, FB_TKCLASS_KEYWORD), _
        ("ON"		, FB_TK_ON			, FB_TKCLASS_KEYWORD), _
        ("ERROR"	, FB_TK_ERROR		, FB_TKCLASS_KEYWORD), _
        ("ENUM"		, FB_TK_ENUM		, FB_TKCLASS_KEYWORD), _
        ("INCLIB"	, FB_TK_INCLIB		, FB_TKCLASS_KEYWORD), _
        ("ASM"		, FB_TK_ASM			, FB_TKCLASS_KEYWORD), _
        ("SPC"		, FB_TK_SPC			, FB_TKCLASS_KEYWORD), _
        ("TAB"		, FB_TK_TAB			, FB_TKCLASS_KEYWORD), _
        ("LINE"		, FB_TK_LINE		, FB_TKCLASS_KEYWORD), _
        ("VIEW"		, FB_TK_VIEW		, FB_TKCLASS_KEYWORD), _
        ("UNLOCK"	, FB_TK_UNLOCK		, FB_TKCLASS_KEYWORD), _
        ("FIELD"	, FB_TK_FIELD		, FB_TKCLASS_KEYWORD), _
        ("LOCAL"	, FB_TK_LOCAL		, FB_TKCLASS_KEYWORD), _
        ("ERR"		, FB_TK_ERR			, FB_TKCLASS_KEYWORD), _
        ("DEFINE"	, FB_TK_DEFINE		, FB_TKCLASS_KEYWORD), _
        ("UNDEF"	, FB_TK_UNDEF		, FB_TKCLASS_KEYWORD), _
        ("IFDEF"	, FB_TK_IFDEF		, FB_TKCLASS_KEYWORD), _
        ("IFNDEF"	, FB_TK_IFNDEF		, FB_TKCLASS_KEYWORD), _
        ("ENDIF"	, FB_TK_ENDIF		, FB_TKCLASS_KEYWORD), _
        ("DEFINED"	, FB_TK_DEFINED		, FB_TKCLASS_KEYWORD), _
        ("RESUME"	, FB_TK_RESUME		, FB_TKCLASS_KEYWORD), _
        ("PSET"		, FB_TK_PSET		, FB_TKCLASS_KEYWORD), _
        ("PRESET"	, FB_TK_PRESET		, FB_TKCLASS_KEYWORD), _
        ("POINT"	, FB_TK_POINT		, FB_TKCLASS_KEYWORD), _
        ("CIRCLE"	, FB_TK_CIRCLE		, FB_TKCLASS_KEYWORD), _
        ("WINDOW"	, FB_TK_WINDOW		, FB_TKCLASS_KEYWORD), _
        ("PALETTE"	, FB_TK_PALETTE		, FB_TKCLASS_KEYWORD), _
        ("SCREEN"	, FB_TK_SCREEN		, FB_TKCLASS_KEYWORD), _
        ("SCREENRES", FB_TK_SCREENRES	, FB_TKCLASS_KEYWORD), _
        ("PAINT"	, FB_TK_PAINT		, FB_TKCLASS_KEYWORD), _
        ("DRAW"		, FB_TK_DRAW		, FB_TKCLASS_KEYWORD), _
        ("EXTERN"	, FB_TK_EXTERN		, FB_TKCLASS_KEYWORD), _
        ("STRPTR"	, FB_TK_STRPTR		, FB_TKCLASS_KEYWORD), _
        ("WITH"		, FB_TK_WITH		, FB_TKCLASS_KEYWORD), _
        ("SCOPE"	, FB_TK_SCOPE		, FB_TKCLASS_KEYWORD), _
        ("EXPORT"	, FB_TK_EXPORT		, FB_TKCLASS_KEYWORD), _
        ("IMPORT"	, FB_TK_IMPORT		, FB_TKCLASS_KEYWORD), _
        ("LIBPATH"	, FB_TK_LIBPATH		, FB_TKCLASS_KEYWORD), _
        ("CHR"		, FB_TK_CHR			, FB_TKCLASS_KEYWORD), _
        ("ASC"		, FB_TK_ASC			, FB_TKCLASS_KEYWORD), _
        ("LSET"		, FB_TK_LSET		, FB_TKCLASS_KEYWORD), _
        ("IIF"		, FB_TK_IIF			, FB_TKCLASS_KEYWORD), _
        ("..."		, FB_TK_VARARG		, FB_TKCLASS_KEYWORD), _
        ("VA_FIRST"	, FB_TK_VA_FIRST	, FB_TKCLASS_KEYWORD), _
        ("LONGINT"	, FB_TK_LONGINT		, FB_TKCLASS_KEYWORD), _
        ("ULONGINT" , FB_TK_ULONGINT	, FB_TKCLASS_KEYWORD), _
        ("ZSTRING"	, FB_TK_ZSTRING		, FB_TKCLASS_KEYWORD), _
        ("SIZEOF"	, FB_TK_SIZEOF		, FB_TKCLASS_KEYWORD), _
        ("SIN"		, FB_TK_SIN			, FB_TKCLASS_KEYWORD), _
        ("ASIN"		, FB_TK_ASIN		, FB_TKCLASS_KEYWORD), _
        ("COS"		, FB_TK_COS			, FB_TKCLASS_KEYWORD), _
        ("ACOS"		, FB_TK_ACOS		, FB_TKCLASS_KEYWORD), _
        ("TAN"		, FB_TK_TAN			, FB_TKCLASS_KEYWORD), _
        ("ATN"		, FB_TK_ATN			, FB_TKCLASS_KEYWORD), _
        ("SQR"		, FB_TK_SQR			, FB_TKCLASS_KEYWORD), _
        ("LOG"		, FB_TK_LOG			, FB_TKCLASS_KEYWORD), _
        ("INT"		, FB_TK_INT			, FB_TKCLASS_KEYWORD), _
        ("ATAN2"	, FB_TK_ATAN2		, FB_TKCLASS_KEYWORD), _
        ("OVERLOAD"	, FB_TK_OVERLOAD	, FB_TKCLASS_KEYWORD), _
        ("CONSTRUCTOR", FB_TK_CONSTRUCTOR, FB_TKCLASS_KEYWORD), _
        ("DESTRUCTOR", FB_TK_DESTRUCTOR	, FB_TKCLASS_KEYWORD), _
        ("") _
	}

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' init/end
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbInitSymbols static

	'' globals/module-level
	listNew( @ctx.symlist, FB_INITSYMBOLNODES, len( FBSYMBOL ), FALSE )

	hashNew( @ctx.symhash, FB_INITSYMBOLNODES )

	ctx.globtb.head = NULL
	ctx.globtb.tail = NULL

	ctx.symtb = @ctx.globtb

	ctx.lastlbl = NULL

end sub

'':::::
sub symbInitFwdRef static

	listNew( @ctx.fwdlist, FB_INITFWDREFNODES, len( FBFWDREF ), FALSE )

	ctx.fwdrefcnt = 0

end sub

'':::::
sub symbInitDims static

	listNew( @ctx.dimlist, FB_INITDIMNODES, len( FBVARDIM ), FALSE )

end sub

'':::::
sub symbInitLibs static

	listNew( @ctx.liblist, FB_INITLIBNODES, len( FBLIBRARY ), FALSE )

    hashNew( @ctx.libhash, FB_INITLIBNODES )

end sub

'':::::
sub symbInitDefines( byval ismain as integer ) static
	dim as string def, value
	dim as integer i

    listNew( @ctx.defarglist, FB_INITDEFARGNODES, len( FBDEFARG ), FALSE )

    listNew( @ctx.deftoklist, FB_INITDEFTOKNODES, len( FBDEFTOK ), FALSE )

    ctx.defargcnt = 0

    for i = 0 to SYMB_MAXDEFINES-1
    	if( len( defTb(i).name ) = 0 ) then
    		exit for
    	end if

    	value = defTb(i).value
    	if( value <> "" ) then
            if( not bit( defTb(i).flags, 0 ) )then
    			value = "\"" + value + "\""
            end if
    	end if

    	symbAddDefine( @defTb(i).name, strptr( value ), len( value ), _
    				   FALSE, defTb(i).proc, defTb(i).flags )
    next

	'' target
	select case as const env.clopt.target
	case FB_COMPTARGET_WIN32
		def = "__FB_WIN32__"
	case FB_COMPTARGET_CYGWIN
		def = "__FB_CYGWIN__"
	case FB_COMPTARGET_LINUX
		def = "__FB_LINUX__"
	case FB_COMPTARGET_DOS
		def = "__FB_DOS__"
	case FB_COMPTARGET_XBOX
		def = "__FB_XBOX__"
	end select

	symbAddDefine( strptr( def ), NULL, 0 )

	'' main
	if( ismain ) then
		symbAddDefine( strptr( "__FB_MAIN__" ), NULL, 0 )
	end if

end sub

'':::::
sub symbInitKeywords static
    dim as integer i

	for i = 0 to SYMB_MAXKEYWORDS-1
    	if( len( kwdTb(i).name ) = 0 ) then
    		exit for
    	end if
    	if( symbAddKeyword( @kwdTb(i).name, kwdTb(i).id, kwdTb(i).class ) = NULL ) then
    		exit sub
    	end if
    next

end sub

'':::::
sub symbInit( byval ismain as integer )

	''
	if( ctx.inited ) then
		exit sub
	end if


	''
	hashInit( )

	''
	'' vars, arrays, procs & consts
	''
	symbInitSymbols( )

	''
	'' keywords
	symbInitKeywords( )

	''
	'' defines
	''
	symbInitDefines( ismain )

	''
	'' forward refs
	''
	symbInitFwdRef( )

	''
	'' arrays dim tb
	''
	symbInitDims( )

	''
	'' libraries
	''
	symbInitLibs( )

    ''
    ctx.inited 	= TRUE

end sub

'':::::
sub symbEnd

    if( not ctx.inited ) then
    	exit sub
    end if

	''
	symbDelGlobalTb( )

	ctx.globtb.head = NULL
	ctx.globtb.tail = NULL
	ctx.symtb = NULL

    ''
	hashFree( @ctx.libhash )

    hashFree( @ctx.symhash )

	''
	listFree( @ctx.liblist )

	listFree( @ctx.dimlist )

	listFree( @ctx.fwdlist )

	listFree( @ctx.deftoklist )

	listFree( @ctx.defarglist )

	listFree( @ctx.symlist )

	''
	ctx.inited = FALSE

end sub

'':::::
function symbSetSymbolTb( byval tb as FBSYMBOLTB ptr ) as FBSYMBOLTB ptr

	function = ctx.symtb

	if( tb = NULL ) then
		ctx.symtb = @ctx.globtb
	else
		ctx.symtb = tb
	end if

end function

'':::::
function symbGetSymbolTbHead( ) as FBSYMBOL ptr static

	function = ctx.symtb->head

end function

'':::::
function symbGetGlobalTbHead( ) as FBSYMBOL ptr static

	function = ctx.globtb.head

end function


'':::::
function hDefFile_cb( ) as string static

	function = env.inf.name

end function

'':::::
function hDefFunction_cb( ) as string static

	if( env.currproc = NULL ) then
		function = "(main)"
	else
		function = symbGetOrgName( env.currproc )
	end if

end function

'':::::
function hDefLine_cb( ) as string static

	function = str$( lexLineNum( ) )

end function

'':::::
function hDefDate_cb( ) as string static

	function = date$

end function

'':::::
function hDefTime_cb( ) as string static

	function = time$

end function

'':::::
function hDefMultithread_cb( ) as string static

	function = str$( env.clopt.multithreaded )

end function


''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hCanDuplicate( byval n as FBSYMBOL ptr, _
								byval s as FBSYMBOL ptr ) as integer

	select case as const s->class
	'' adding a define or keyword? no dups can exist
	case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_KEYWORD
		return FALSE

	'' adding a type field? anything is allowed (udt elms are not added to a hash tb)
	case FB_SYMBCLASS_UDTELM, FB_SYMBCLASS_PROCARG

	'' adding a label or forward ref? anything but a define and keyword is allowed,
	'' if the same class doesn't exist yet
	case FB_SYMBCLASS_LABEL, FB_SYMBCLASS_FWDREF

		function = FALSE

		do
			select case as const n->class
			case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_KEYWORD
				exit function

			case else
				if( n->class = s->class ) then
					exit function
				end if
			end select

			n = n->right
		loop while( n <> NULL )

	'' adding an udt, enum or typedef? anything but a define, keyword or
	'' themselves is allowed
	case FB_SYMBCLASS_UDT, FB_SYMBCLASS_ENUM, FB_SYMBCLASS_TYPEDEF

		function = FALSE

		do
			select case as const n->class
			case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_KEYWORD, _
				 FB_SYMBCLASS_UDT, FB_SYMBCLASS_ENUM, FB_SYMBCLASS_TYPEDEF
				exit function
			end select

			n = n->right
		loop while( n <> NULL )

	'' adding a constant or proc? only dup allowed are labels, udts or enums
	case FB_SYMBCLASS_CONST, FB_SYMBCLASS_PROC

		function = FALSE

		do
			select case as const n->class
			case FB_SYMBCLASS_LABEL, FB_SYMBCLASS_UDT, FB_SYMBCLASS_ENUM, _
				 FB_SYMBCLASS_TYPEDEF, FB_SYMBCLASS_FWDREF

			case else
				exit function
			end select

			n = n->right
		loop while( n <> NULL )

	'' adding a variable? labels, udts or enums are allowed as dups AND
	'' other vars if they have different suffixes -- if any with suffix
	'' exists, a suffix-less will not be accepted (and vice-versa)
	case FB_SYMBCLASS_VAR

		function = FALSE

		do
			select case as const n->class
			case FB_SYMBCLASS_LABEL, FB_SYMBCLASS_UDT, FB_SYMBCLASS_ENUM, _
				 FB_SYMBCLASS_TYPEDEF, FB_SYMBCLASS_FWDREF

			case FB_SYMBCLASS_VAR
				if( s->scope = n->scope ) then
					if( (s->var.suffix = INVALID) or (n->var.suffix = INVALID) ) then
	    				exit function
					end if

    				'' same suffix?
    				if( n->var.suffix = s->var.suffix ) then
    					exit function
    				end if
    			end if

			case else
				exit function
			end select

			n = n->right
		loop while( n <> NULL )

	end select

	''
	function = TRUE

end function

'':::::
private sub hFixForwardRef( byval f as FBSYMBOL ptr, _
							byval sym as FBSYMBOL ptr, _
							byval class as integer )
    dim as FBFWDREF ptr n, p
    dim as FBSYMBOL ptr ref
    dim as integer typ, ptrcnt

	select case as const class
	case FB_SYMBCLASS_UDT
		typ 	= FB_SYMBTYPE_USERDEF
		ptrcnt 	= 0
	case FB_SYMBCLASS_ENUM
		typ 	= FB_SYMBTYPE_ENUM
		ptrcnt 	= 0
	case FB_SYMBCLASS_TYPEDEF
		typ 	= sym->typ
		ptrcnt 	= sym->ptrcnt
		sym 	= sym->subtype
	end select

	n = f->fwd.reftail
	do while( n <> NULL )
		p = n->prev

		ref = n->ref

		ref->typ     = typ + (ref->ptrcnt * FB_SYMBTYPE_POINTER)
		ref->subtype = sym
		ref->ptrcnt  = ptrcnt
		ref->lgt	 = symbCalcLen( ref->typ, sym )

		listDelNode( @ctx.fwdlist, cptr( TLISTNODE ptr, n ) )

		n = p
	loop

	hFreeSymbol( f )

	ctx.fwdrefcnt -= 1

end sub

'':::::
private sub hAddToFwdRef( byval f as FBSYMBOL ptr, _
						  byval ref as FBSYMBOL ptr ) static
	dim n as FBFWDREF ptr

	n = listNewNode( @ctx.fwdlist )

	n->ref 	= ref
	n->prev	= f->fwd.reftail
	f->fwd.reftail = n

	f->fwd.refs += 1

end sub

'':::::
function hNewSymbol( byval s as FBSYMBOL ptr, _
					 byval symtb as FBSYMBOLTB ptr, _
					 byval class as SYMBCLASS_ENUM, _
					 byval dohash as integer = TRUE, _
					 byval symbol as zstring ptr, _
					 byval aliasname as zstring ptr, _
					 byval islocal as integer = FALSE, _
					 byval typ as integer = INVALID, _
					 byval subtype as FBSYMBOL ptr = NULL, _
					 byval ptrcnt as integer = 0, _
					 byval suffix as integer = INVALID, _
					 byval preservecase as integer = FALSE ) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr n
    dim as integer slen, delok

    function = NULL

    delok = FALSE
    if( s = NULL ) then
    	delok = TRUE
    	s = listNewNode( @ctx.symlist )
    	if( s = NULL ) then
    		exit function
    	end if
    end if

    ''
    s->class		= class
    s->scope		= env.scope
    s->typ			= typ
    s->subtype		= subtype
    s->ptrcnt		= ptrcnt

	s->alloctype	= iif( islocal, FB_ALLOCTYPE_LOCAL, 0 )
    s->lgt			= 0
    s->ofs			= 0

    if( class = FB_SYMBCLASS_VAR ) then
    	s->var.suffix = suffix
    	s->var.emited = FALSE
    end if

    ''
    ZEROSTRDESC( s->name )
    slen = len( *symbol )
    if( slen > 0 ) then
    	if( not preservecase ) then
    		s->name = ucase( *symbol )
    	else
    	    s->name = *symbol
		end if
    else
    	dohash = FALSE
    end if

    ZEROSTRDESC( s->alias )
    if( aliasname <> NULL ) then
    	s->alias = *aliasname
    else
		select case class
		case FB_SYMBCLASS_VAR, FB_SYMBCLASS_PROC
			s->alias = s->name
		end select
    end if

	s->left  = NULL
	s->right = NULL

	''
	if( dohash ) then

		'' doesn't exist yet?
		n = hashLookup( @ctx.symhash, strptr( s->name ) )
		if( n = NULL ) then
			'' add to hash table
			s->hashitem = hashAdd( @ctx.symhash, strptr( s->name ), s, s->hashindex )

		else
			'' can be duplicated?
			if( not hCanDuplicate( n, s ) ) then
				s->name = ""
				s->alias = ""
				if( delok ) then
					listDelNode( @ctx.symlist, cptr( TLISTNODE ptr, s ) )
				end if
				exit function
			end if

			s->hashitem  = n->hashitem
			s->hashindex = n->hashindex

			'' module-level scope?
			if( s->scope = 0 ) then
				'' add to tail
				do while( n->right <> NULL )
					n = n->right
				loop

				n->right = s
				s->left  = n

			else
				'' add to head
				n->hashitem->idx  = s
				n->hashitem->name = strptr( s->name )
			    n->left	 = s
			    s->right = n

			end if
		end if

	else
		s->hashitem  = NULL
		s->hashindex = 0
	end if

	''
	typ -= ptrcnt * FB_SYMBTYPE_POINTER
	if( typ = FB_SYMBTYPE_FWDREF ) then
		hAddToFwdRef( subtype, s )
	end if

	'' add to symbol table
	if( symtb->tail <> NULL ) then
		symtb->tail->next = s
	else
		symtb->head = s
	end if

	s->prev  = symtb->tail
	s->next  = NULL

	symtb->tail = s

	s->symtb = symtb

    ''
    function = s

end function

'':::::
function symbAddKeyword( byval symbol as zstring ptr, _
						 byval id as integer, _
						 byval class as integer ) as FBSYMBOL ptr
    dim k as FBSYMBOL ptr

    k = hNewSymbol( NULL, @ctx.globtb, FB_SYMBCLASS_KEYWORD, TRUE, _
    				symbol, NULL )
    if( k = NULL ) then
    	return NULL
    end if

    ''
    k->key.id		= id
    k->key.class	= class

    function = k

end function

'':::::
function symbAddDefine( byval symbol as zstring ptr, _
						byval text as zstring ptr, _
						byval lgt as integer, _
						byval isargless as integer = FALSE, _
						byval proc as function( ) as string = NULL, _
                        byval flags as integer = 0 _
                      ) as FBSYMBOL ptr static

    dim d as FBSYMBOL ptr

    function = NULL

    '' allocate new node
    d = hNewSymbol( NULL, ctx.symtb, FB_SYMBCLASS_DEFINE, TRUE, _
    				symbol, NULL, fbIsLocal( ) )
    if( d = NULL ) then
    	exit function
    end if

	''
	ZEROSTRDESC( d->def.text )
	d->def.text 	= *text
	d->lgt			= lgt
	d->def.args		= 0
	d->def.arghead	= NULL
	d->def.isargless= isargless
	d->def.proc     = proc
    d->def.flags    = flags

	''
	function = d

end function

'':::::
function symbAddDefineMacro( byval symbol as zstring ptr, _
							 byval tokhead as FBDEFTOK ptr, _
							 byval args as integer, _
						 	 byval arghead as FBDEFARG ptr _
						   ) as FBSYMBOL ptr static

    dim d as FBSYMBOL ptr

    function = NULL

    '' allocate new node
    d = hNewSymbol( NULL, ctx.symtb, FB_SYMBCLASS_DEFINE, TRUE, _
    				symbol, NULL, fbIsLocal( ) )
    if( d = NULL ) then
    	exit function
    end if

	''
	d->def.tokhead  = tokhead
	d->def.args		= args
	d->def.arghead	= arghead
	d->def.isargless= FALSE
	d->def.proc     = NULL
    d->def.flags    = 0

	''
	function = d

end function

'':::::
function symbAddDefineArg( byval lastarg as FBDEFARG ptr, _
						   byval symbol as zstring ptr _
						 ) as FBDEFARG ptr static
    dim a as FBDEFARG ptr

    function = NULL

    a = listNewNode( @ctx.defarglist )
    if( a = NULL ) then
    	exit function
    end if

	if( lastarg <> NULL ) then
		lastarg->next = a
	end if

	''
    ZEROSTRDESC( a->name )
    a->name 	= ucase( *symbol )
    a->next		= NULL
    a->id		= ctx.defargcnt
    ctx.defargcnt += 1

    function = a

end function

'':::::
function symbAddDefineTok( byval lasttok as FBDEFTOK ptr, _
						   byval typ as FB_DEFTOK_TYPE _
						 ) as FBDEFTOK ptr static

    dim t as FBDEFTOK ptr

    function = NULL

    t = listNewNode( @ctx.deftoklist )
    if( t = NULL ) then
    	exit function
    end if

	if( lasttok <> NULL ) then
		lasttok->next = t
	end if
	t->next	= NULL

	''
	t->type = typ
	ZEROSTRDESC( t->text )

    function = t

end function

'':::::
private sub hCheckFwdRef( byval s as FBSYMBOL ptr, _
						  byval class as integer ) static
	dim as FBSYMBOL ptr f, n

	'' go to head
	n = s
	do while( n->left <> NULL )
		n = n->left
	loop

	f = symbFindByClass( n, FB_SYMBCLASS_FWDREF )
	if( f <> NULL ) then
		hFixForwardRef( f, s, class )
	end if

end sub

'':::::
function symbAddTypedef( byval symbol as zstring ptr, _
						 byval typ as integer, _
						 byval subtype as FBSYMBOL ptr, _
						 byval ptrcnt as integer, _
						 byval lgt as integer ) as FBSYMBOL ptr static
    dim as FBSYMBOL ptr t

    function = NULL

    '' allocate new node
    t = hNewSymbol( NULL, ctx.symtb, FB_SYMBCLASS_TYPEDEF, TRUE, _
    				symbol, NULL, _
    				fbIsLocal( ), typ, subtype, ptrcnt )
    if( t = NULL ) then
    	exit function
    end if

	''
	t->lgt 	= lgt

	'' check for forward references
	if( ctx.fwdrefcnt > 0 ) then
		hCheckFwdRef( t, FB_SYMBCLASS_TYPEDEF )
	end if

	''
	function = t

end function

'':::::
function symbAddFwdRef( byval symbol as zstring ptr ) as FBSYMBOL ptr static
    dim f as FBSYMBOL ptr

    function = NULL

    '' allocate new node
    f = hNewSymbol( NULL, ctx.symtb, FB_SYMBCLASS_FWDREF, TRUE, _
    				symbol, NULL, fbIsLocal( ) )
    if( f = NULL ) then
    	exit function
    end if

   	f->fwd.refs = 0
   	f->fwd.reftail = NULL

   	''
   	ctx.fwdrefcnt += 1

    function = f

end function

'':::::
function hCreateArrayDesc( byval s as FBSYMBOL ptr, _
						   byval dimensions as integer ) as FBSYMBOL ptr static

    static as zstring * FB_MAXINTNAMELEN+1 sname, aname
    dim as FBSYMBOL ptr d
    dim as integer lgt, ofs
    dim as integer isshared, isstatic, isdynamic, iscommon, ispubext

	function = NULL

    '' don't add if it's a jump table
    if( symbIsJumpTb( s ) ) then
    	exit function
    end if

	isshared 	= symbIsShared( s )
	isstatic 	= symbIsStatic( s )
	isdynamic	= symbIsDynamic( s )
	iscommon 	= symbIsCommon( s )
	ispubext 	= (s->alloctype and (FB_ALLOCTYPE_PUBLIC or FB_ALLOCTYPE_EXTERN)) > 0

	'' COMMON, public or dynamic? use the array name for the descriptor,
	'' as only it will be allocated or seen by other modules
	if( (iscommon) or (ispubext and isdynamic) ) then
		sname = symbGetName( s )

	'' otherwise, create a temporary name..
	else
		sname = *hMakeTmpStr( FALSE )
	end if

	'' module-level or static? no alias
	if( not fbIsLocal( ) or (isshared) or (isstatic) ) then
		aname = sname
		ofs = 0

	'' local.. let emit do it
	else
		lgt = FB_ARRAYDESCLEN + dimensions * FB_ARRAYDESC_DIMLEN
		aname = *emitAllocLocal( env.currproc, lgt, ofs )
	end if

	d = hNewSymbol( NULL, ctx.symtb, FB_SYMBCLASS_VAR, FALSE, _
					NULL, aname, _
					fbIsLocal( ) and (not isshared), _
					FB_SYMBTYPE_USERDEF, cptr( FBSYMBOL ptr, FB_DESCTYPE_ARRAY ), 0 )
    if( d = NULL ) then
    	exit function
    end if

	''
	if( isshared ) then
		d->alloctype  or= FB_ALLOCTYPE_SHARED
	elseif( isstatic ) then
		d->alloctype  or= FB_ALLOCTYPE_STATIC
	end if

	d->ofs				= ofs
	d->var.array.desc 	= NULL
	d->var.array.dif  	= 0
	d->var.array.dims 	= 0

    d->var.suffix 		= INVALID
    d->var.initialized 	= FALSE

	''
	function = d

end function

'':::::
function hNewDim( head as FBVARDIM ptr, _
				  tail as FBVARDIM ptr, _
				  byval lower as integer, _
				  byval upper as integer ) as FBVARDIM ptr static
    dim as FBVARDIM ptr d, n

    function = NULL

    d = listNewNode( @ctx.dimlist )
    if( d = NULL ) then
    	exit function
    end if

    d->lower = lower
    d->upper = upper

	n = tail
	d->next = NULL
	tail = d
	if( n <> NULL ) then
		n->next = d
	else
		head = d
	end if

    function = d

end function

'':::::
sub symbSetArrayDims( byval s as FBSYMBOL ptr, _
					  byval dimensions as integer, _
					  dTB() as FBARRAYDIM )

    dim as integer i
    dim as FBVARDIM ptr d

	s->var.array.dims = dimensions

	if( dimensions > 0 ) then
		s->var.array.dif = hCalcDiff( dimensions, dTB(), s->lgt )

		if( s->var.array.dimhead = NULL ) then
			for i = 0 to dimensions-1
				if( hNewDim( s->var.array.dimhead, s->var.array.dimtail, _
							 dTB(i).lower, dTB(i).upper ) = NULL ) then
				end if
			next i
		else
			d = s->var.array.dimhead
			for i = 0 to dimensions-1
				d->lower = dTB(i).lower
				d->upper = dTB(i).upper
				d = d->next
			next i
		end if

	else
		s->var.array.dif = 0
	end if

	'' dims can be -1 with COMMON arrays..
	if( dimensions <> 0 ) then
		if( s->var.array.desc = NULL ) then
			s->var.array.desc = hCreateArrayDesc( s, dimensions )
		end if
	else
		s->var.array.desc = NULL
	end if

end sub

'':::::
private sub hSetupVar( byval s as FBSYMBOL ptr, _
			   		   byval symbol as zstring ptr, _
			   		   byval typ as integer, _
			   		   byval subtype as FBSYMBOL ptr, _
			   		   byval lgt as integer, _
			   		   byval ofs as integer, _
			   		   byval dimensions as integer, _
			   		   dTB() as FBARRAYDIM, _
			   		   byval alloctype as integer ) static

	if( typ = INVALID ) then
		typ = hGetDefType( *symbol )
	end if

	''
	s->alloctype  or= alloctype
	s->acccnt		= 0

	s->lgt			= lgt
	s->ofs			= ofs

	'' array fields
	s->var.array.dimhead = NULL
	s->var.array.dimtail = NULL

	s->var.array.elms = 0						'' real value doesn't matter
	s->var.array.desc = NULL
	if( dimensions <> 0 ) then
		symbSetArrayDims( s, dimensions, dTB() )
	else
		s->var.array.dims = 0
		s->var.array.dif  = 0
	end if

	''
    s->var.initialized 	= FALSE

end sub

'':::::
function symbAddVarEx( byval symbol as zstring ptr, _
					   byval aliasname as zstring ptr, _
					   byval typ as integer, _
					   byval subtype as FBSYMBOL ptr, _
					   byval ptrcnt as integer, _
					   byval lgt as integer, _
					   byval dimensions as integer, _
					   dTB() as FBARRAYDIM, _
				       byval alloctype as integer, _
				       byval addsuffix as integer, _
				       byval preservecase as integer, _
				       byval clearname as integer ) as FBSYMBOL ptr static

    dim as zstring ptr aname
    dim as FBSYMBOL ptr s
    dim as integer isshared, isstatic, ispublic, isextern, isarg, islocal
    dim as integer suffix, locofs, loclen

    function = NULL

    ''
    isshared = (alloctype and FB_ALLOCTYPE_SHARED) > 0
    isstatic = (alloctype and FB_ALLOCTYPE_STATIC) > 0
    ispublic = (alloctype and FB_ALLOCTYPE_PUBLIC) > 0
    isextern = (alloctype and FB_ALLOCTYPE_EXTERN) > 0
    isarg    = (alloctype and (FB_ALLOCTYPE_ARGUMENTBYDESC or _
    						   FB_ALLOCTYPE_ARGUMENTBYVAL or _
    						   FB_ALLOCTYPE_ARGUMENTBYREF)) > 0
    ''
    if( lgt <= 0 ) then
		if( typ = INVALID ) then
			suffix = hGetDefType( symbol )
		else
			suffix = typ
 		end if
    	lgt	= symbCalcLen( suffix, subtype )
    end if

    ''
    if( addsuffix ) then
    	suffix = typ
    else
    	suffix = INVALID
    end if

    ''
    locofs = 0

	'' create an alias name (the real one that will be emited)
	islocal  = FALSE
	if( aliasname <> NULL ) then
		'' if alias was given, it can't be a local var
		aname = aliasname

	else
		'' static?
		if( (not isshared) and (isstatic) ) then
			aname = hMakeTmpStr( FALSE )

		else
			'' global/shared or module-level?
			if( (ispublic) or _
				(isextern) or _
				(isshared) or _
				not fbIsLocal( ) ) then

			    '' not inside a SCOPE block?
			    if( env.scope = 0 ) then
			    	aname = hCreateName( *symbol, suffix, preservecase, _
			    					  	 TRUE, clearname )

				'' inside a SCOPE..
				else
					aname = hMakeTmpStr( FALSE )
				end if

			'' local..
			else
				islocal = TRUE
				'' an argument?
				if( isarg ) then
					loclen = iif( alloctype = FB_ALLOCTYPE_ARGUMENTBYVAL, lgt, FB_POINTERSIZE )
					aname = emitAllocArg( env.currproc, loclen, locofs )

				'' local..
				else
					loclen = lgt * hCalcElements2( dimensions, dTB() )
					aname = emitAllocLocal( env.currproc, loclen, locofs )
				end if
			end if
		end if
	end if

	'' if SHARED, use the global symbol tb, even if inside a proc
	s = hNewSymbol( NULL, iif( isshared, @ctx.globtb, ctx.symtb ), _
					FB_SYMBCLASS_VAR, TRUE, _
					symbol, aname, _
					fbIsLocal( ) and (not isshared), _
					typ, subtype, ptrcnt, suffix, preservecase )

	if( s = NULL ) then
		'' remove a local or arg or else emit will reserve unused space for it..
		if( islocal ) then
			if( isarg ) then
				emitFreeArg( env.currproc, loclen )
			else
				emitFreeLocal( env.currproc, loclen )
			end if
		end if

		exit function
	end if

	''
	hSetupVar( s, symbol, typ, subtype, lgt, _
			   locofs, dimensions, dTB(), alloctype )

	function = s

end function

'':::::
function symbAddVar( byval symbol as zstring ptr, _
					 byval typ as integer, _
					 byval subtype as FBSYMBOL ptr, _
				     byval ptrcnt as integer, _
				     byval dimensions as integer, _
				     dTB() as FBARRAYDIM, _
				     byval alloctype as integer ) as FBSYMBOL ptr static

    function = symbAddVarEx( symbol, NULL, typ, subtype, ptrcnt, _
    		  			     0, dimensions, dTB(), _
    						 alloctype, _
    						 TRUE, FALSE, TRUE )
end function

'':::::
function symbAddTempVar( byval typ as integer, _
						 byval subtype as FBSYMBOL ptr = NULL ) as FBSYMBOL ptr static

	static as zstring * FB_MAXINTNAMELEN+1 sname
	dim as integer alloctype
    dim as FBARRAYDIM dTB(0)

	sname = *hMakeTmpStr( FALSE )

	alloctype = FB_ALLOCTYPE_TEMP
	if( fbIsLocal( ) ) then
		if( env.isprocstatic ) then
			alloctype or= FB_ALLOCTYPE_STATIC
		end if
	end if

	function = symbAddVarEx( sname, NULL, typ, subtype, 0, _
							 0, 0, dTB(), _
							 alloctype, _
							 FALSE, FALSE, FALSE )

end function

'':::::
function hAllocFloatConst( byval value as double, _
						   byval typ as integer _
						 ) as FBSYMBOL ptr static

    static as zstring * FB_MAXINTNAMELEN+1 cname, aname
	dim as FBSYMBOL ptr s
	dim as FBARRAYDIM dTB(0)
	dim as string svalue

	function = NULL

	'' can't use STR() because GAS doesn't support the 1.#INF notation
	svalue = hFloatToStr( value, typ )

	cname = "{fbnc}"
	cname += svalue

	s = symbFindByNameAndSuffix( @cname, typ, FALSE )
	if( s <> NULL ) then
		return s
	end if

	aname = *hMakeTmpStr( FALSE )

	'' it must be declare as SHARED, because even if currently inside an
	'' proc, the global symbol tb should be used, so just one constant
	'' will be ever allocated over the module
	s = symbAddVarEx( @cname, @aname, typ, NULL, 0, 0, 0, dTB(), _
					  FB_ALLOCTYPE_SHARED, TRUE, FALSE, FALSE )

	''
	s->var.initialized = TRUE

	ZEROSTRDESC( s->var.inittext )
	s->var.inittext	= svalue

	function = s

end function

'':::::
function hAllocStringConst( byval sname as string, _
							byval lgt as integer ) as FBSYMBOL ptr static

    static as zstring * FB_MAXINTNAMELEN+1 cname, aname
	dim as FBSYMBOL ptr s
	dim as FBARRAYDIM dTB(0)

	function = NULL

	''
	if( lgt < 0 ) then
		lgt = len( sname )
	end if

	if( lgt <= FB_MAXNAMELEN-6 ) then
		cname = "{fbsc}"
		cname += sname
	else
		cname = *hMakeTmpStr( FALSE )
	end if

	''
	s = symbFindByNameAndClass( @cname, FB_SYMBCLASS_VAR, TRUE )
	if( s <> NULL ) then
		return s '''''s->var.array.desc
	end if

	aname = *hMakeTmpStr( FALSE )

	'' plus the null-char as rtlib wrappers will take it into account
	lgt += 1

	'' it must be declare as SHARED, see hAllocFloatConst()
	s = symbAddVarEx( @cname, @aname, FB_SYMBTYPE_FIXSTR, NULL, _
					  0, lgt, 0, dTB(), _
					  FB_ALLOCTYPE_SHARED, FALSE, TRUE, FALSE )

	''
	s->var.initialized = TRUE

	ZEROSTRDESC( s->var.inittext )
	s->var.inittext = sname

	'' can't fake a descriptor as the literal string passed to
	'' user procs can be modified/reused
	'''''s->var.array.desc = hCreateStringDesc( s )

	function = s '''''s->var.array.desc

end function

'':::::
function symbAddConst( byval symbol as zstring ptr, _
					   byval typ as integer, _
					   byval subtype as FBSYMBOL ptr, _
					   byval value as FBVALUE ptr _
					 ) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr c

    function = NULL

    c = hNewSymbol( NULL, iif( typ = FB_SYMBTYPE_ENUM, @subtype->enum.elmtb, ctx.symtb ), _
    				FB_SYMBCLASS_CONST, TRUE, _
    				symbol, NULL, _
    				fbIsLocal( ), typ, subtype )
	if( c = NULL ) then
		exit function
	end if

	c->con.val = *value

	function = c

end function

'':::::
function symbAddLabel( byval symbol as zstring ptr, _
					   byval declaring as integer = TRUE, _
					   byval createalias as integer = FALSE ) as FBSYMBOL ptr static

    dim as zstring ptr lname, aname
    dim as FBSYMBOL ptr l

    function = NULL

    if( symbol <> NULL ) then
    	'' check if label already exists
    	l = symbFindByNameAndClass( symbol, FB_SYMBCLASS_LABEL )
    	if( l <> NULL ) then
    		if( declaring ) then
    			if( l->lbl.declared ) then
	    			exit function
    			else
    				l->lbl.declared = TRUE
    				return l
    			end if
    		else
    			return l
    		end if
    	end if

		'' add the new label
		if( not createalias ) then
    		aname = symbol
		else
			aname = hMakeTmpStr( TRUE )
		end if

		lname = symbol

	else
		lname = hMakeTmpStr( TRUE )
		aname = lname
	end if

    l = hNewSymbol( NULL, ctx.symtb, FB_SYMBCLASS_LABEL, TRUE, _
    				lname, aname, fbIsLocal( ) )
    if( l = NULL ) then
    	exit function
    end if

	l->lbl.declared = declaring

	function = l

end function


'':::::
function symbAddUDT( byval parent as FBSYMBOL ptr, _
					 byval symbol as zstring ptr, _
					 byval isunion as integer, _
					 byval align as integer ) as FBSYMBOL ptr static
    dim t as FBSYMBOL ptr

    function = NULL

    t = hNewSymbol( NULL, ctx.symtb, FB_SYMBCLASS_UDT, TRUE, _
    				symbol, NULL, fbIsLocal( ) )
	if( t = NULL ) then
		exit function
	end if

	t->udt.parent		= parent
	t->udt.isunion		= isunion
	t->udt.elements		= 0
	t->udt.fldtb.head	= NULL
	t->udt.fldtb.tail	= NULL
	t->udt.ofs			= 0
	t->udt.align		= align
	t->udt.lfldlen		= 0
	t->udt.bitpos		= 0
	t->udt.unpadlgt 	= 0

	t->udt.dbg.typenum	= INVALID

	function = t

end function

'':::::
private function hCalcALign( byval lgt as integer, _
					 		 byval ofs as integer, _
					 		 byval align as integer, _
					 		 byval dtype as integer, _
					 		 byval subtype as FBSYMBOL ptr ) as integer static

	function = 0

	'' do align?
	if( align = 1 ) then
		exit function
	end if

	'' handle special types
	select case dtype
	'' another UDT? use its largest field len
	case FB_SYMBTYPE_USERDEF
		lgt = subtype->udt.lfldlen

	'' zstring or fixed-len? size is actually sizeof(byte)
	case FB_SYMBTYPE_CHAR, FB_SYMBTYPE_FIXSTR
		lgt = 1

	'' var-len string: first field is a pointer
	case FB_SYMBTYPE_STRING
		lgt = FB_POINTERSIZE
	end select

	'' default?
	if( align = 0 ) then
		select case as const lgt
		'' align byte, short, int, float, double and long long to the natural boundary
		case 1
			exit function
		case 2
			function = (2 - (ofs and (2-1))) and (2-1)
		case 4
			function = (4 - (ofs and (4-1))) and (4-1)
		case 8
			function = (8 - (ofs and (8-1))) and (8-1)

		'' anything else (shouldn't happen), align to sizeof(int)
		case else
			function = (FB_INTEGERSIZE - (ofs and (FB_INTEGERSIZE-1))) and (FB_INTEGERSIZE-1)
		end select

	'' packed..
	else
		if( lgt < align ) then
			align = lgt
		end if

		function = (align - (ofs and (align - 1))) and (align-1)
	end if

end function

'':::::
function symbCheckBitField( byval udt as FBSYMBOL ptr, _
							byval typ as integer, _
							byval lgt as integer, _
							byval bits as integer ) as integer

	if( (bits <= 0) or _
		(bits > lgt*8) or _
		(typ >= FB_SYMBTYPE_ENUM) ) then
		return FALSE
	end if

    return TRUE

end function

'':::::
function symbAddUDTElement( byval t as FBSYMBOL ptr, _
							byval elmname as zstring ptr, _
						    byval dimensions as integer, _
						    dTB() as FBARRAYDIM, _
						    byval typ as integer, _
						    byval subtype as FBSYMBOL ptr, _
						    byval ptrcnt as integer, _
						    byval lgt as integer, _
						    byval bits as integer ) as FBSYMBOL ptr static

    static as zstring * FB_MAXINTNAMELEN+1 ename
    dim as FBSYMBOL ptr p, e, tail
    dim as integer pad, i, updateudt, elen

    function = NULL

    hUcase( *elmname, ename )

    '' check if element already exists in the current struct and parents
    p = t
    do
    	e = p->udt.fldtb.head
    	do while( e <> NULL )
    		if( e->name = ename ) then
    			exit function
    		end if

    		'' next
    		e = e->next
    	loop

    	p = p->udt.parent
    loop while( p <> NULL )

	tail = t->udt.fldtb.tail

    '' calc length if it wasn't given
	if( lgt <= 0 ) then
		lgt	= symbCalcLen( typ, subtype, TRUE )

	'' or if it's a non-array UDT field (the len w/o padding) -- for array
	'' of UDT's fields, the padded len will be used, to be GCC 3.x compatible
	elseif( typ = FB_SYMBTYPE_USERDEF ) then
		if( dimensions = 0 ) then
			lgt = subtype->udt.unpadlgt
		end if
	end if

    '' check if the parent ofs must be updated
    updateudt = TRUE
    if( bits > 0 ) then
    	if( t->udt.bitpos > 0 ) then
    		'' does it fit? if not, start at a new pos..
    		if( t->udt.bitpos + bits > tail->lgt*8 ) then
    			t->udt.bitpos = 0
    		else
    			'' if it fits but len is different, make it the same
    			if( lgt <> tail->lgt ) then
    				typ = tail->typ
    				lgt = tail->lgt
    			end if
    		end if
    	end if

		'' don't update if there are enough bits left
		if( t->udt.bitpos <> 0 ) then
			updateudt = FALSE
		end if

    else
    	t->udt.bitpos = 0
    end if

	''
    e = hNewSymbol( NULL, @t->udt.fldtb, FB_SYMBCLASS_UDTELM, FALSE, _
    				@ename, NULL, _
    				FALSE, typ, subtype, ptrcnt )
    if( e = NULL ) then
    	exit function
    end if

	'' add to parent's linked-list
    e->var.elm.parent = t
    t->udt.elements	+= 1

	''
	if( updateudt ) then
		pad = hCalcALign( lgt, t->udt.ofs, t->udt.align, typ, subtype )
		if( pad > 0 ) then
			t->udt.ofs += pad
		end if

		'' update largest field len
		select case as const typ
		'' another UDT? use its largest field len
		case FB_SYMBTYPE_USERDEF
			elen = subtype->udt.lfldlen
		'' zstring or fixed-len? size is actually sizeof(byte)
		case FB_SYMBTYPE_CHAR, FB_SYMBTYPE_FIXSTR
			elen = 1
		'' var-len string? first field is a pointer
		case FB_SYMBTYPE_STRING
			elen = FB_POINTERSIZE
		'' anything else..
		case else
			elen = lgt
		end select

		'' larger?
		if( elen > t->udt.lfldlen ) then
			t->udt.lfldlen = elen
		end if
	end if

	e->lgt 				= lgt
	if( updateudt ) then
		e->var.elm.ofs	= t->udt.ofs
	else
		e->var.elm.ofs	= t->udt.ofs - lgt
	end if
	e->var.elm.bitpos	= t->udt.bitpos
	e->var.elm.bits		= bits

	'' array fields
	e->var.array.dif	= hCalcDiff( dimensions, dTB(), lgt )
	e->var.array.dimhead= NULL
	e->var.array.dimtail= NULL

	e->var.array.dims	= dimensions
	if( dimensions > 0 ) then
		for i = 0 to dimensions-1
			if( hNewDim( e->var.array.dimhead, e->var.array.dimtail, _
						 dTB(i).lower, dTB(i).upper ) = NULL ) then
			end if
		next
	end if

	e->var.array.elms 	= hCalcElements( e )

	'' multiple len by all array elements (if any)
	lgt *= e->var.array.elms

	if( updateudt ) then
		'' struct?
		if( not t->udt.isunion ) then
			t->udt.ofs += lgt
			t->lgt = t->udt.ofs

		'' union..
		else
			t->udt.ofs = 0
			if( lgt > t->lgt ) then
				t->lgt = lgt
			end if
		end if
	end if

	'' update the bit position, wrapping around
	if( bits > 0 ) then
		t->udt.bitpos += bits
		t->udt.bitpos and= (irGetDataBits( typ ) - 1)
	end if

	''
    e->var.initialized 	= FALSE

    function = e

end function

'':::::
sub symbInsertInnerUDT( byval t as FBSYMBOL ptr, _
						byval inner as FBSYMBOL ptr ) static

    dim as FBSYMBOL ptr e
    dim as FBSYMBOLTB ptr symtb
    dim as integer pad

	if( not t->udt.isunion ) then
		'' calc padding (should be aligned like if an UDT field were been added)
		pad = hCalcALign( inner->udt.lfldlen, t->udt.ofs, t->udt.align, _
						  FB_SYMBTYPE_VOID, NULL )
		if( pad > 0 ) then
			t->udt.ofs += pad
		end if
	end if

    '' move the nodes from inner to parent
    e = inner->udt.fldtb.head

    e->prev = t->udt.fldtb.tail
    if( t->udt.fldtb.tail = NULL ) then
    	t->udt.fldtb.head = e
    else
    	t->udt.fldtb.tail->next = e
    end if

    symtb = @t->udt.fldtb

    if( t->udt.isunion ) then
    	'' link to parent
    	do while( e <> NULL )
    		e->var.elm.parent = t
    		e->symtb = symtb

    		'' next
    		e = e->next
    	loop

    else
    	'' link to parent
    	do while( e <> NULL )
    		e->var.elm.parent = t
    		e->symtb = symtb

			'' update the offsets
			t->udt.ofs += e->var.elm.ofs
			e->var.elm.ofs = t->udt.ofs

    		'' next
    		e = e->next
    	loop
    end if

    t->udt.fldtb.tail = inner->udt.fldtb.tail

    '' update elements
    t->udt.elements	+= inner->udt.elements

	'' struct? update ofs + len
	if( not t->udt.isunion ) then
		t->udt.ofs += inner->udt.unpadlgt
		t->lgt = t->udt.ofs

	'' union.. update len, if bigger
	else
		t->udt.ofs = 0
		if( inner->udt.unpadlgt > t->lgt ) then
			t->lgt = inner->udt.unpadlgt
		end if
	end if

	'' update the largest field len
	if( inner->udt.lfldlen > t->udt.lfldlen ) then
		t->udt.lfldlen = inner->udt.lfldlen
	end if

    '' reset bitfield
    t->udt.bitpos = 0

    '' remove from inner udt list
    inner->udt.fldtb.head = NULL
    inner->udt.fldtb.tail = NULL

end sub

'':::::
sub symbRoundUDTSize( byval t as FBSYMBOL ptr ) static
    dim as integer align, pad

	align = t->udt.align

	'' default?
	if( align = 0 ) then
		align = FB_INTEGERSIZE
	end if

	'' save length w/o padding
	t->udt.unpadlgt = t->lgt

	'' do round?
	if( align > 1 ) then
		'' first pad with the alignament given
		pad = (align - (t->lgt and (align-1))) and (align-1)
		if( pad > 0 ) then
			t->lgt += pad
		end if

		'' plus the largest scalar field size (GCC 3.x ABI)
		pad = hCalcALign( t->udt.lfldlen, t->lgt, t->udt.align, FB_SYMBTYPE_VOID, NULL )
		if( pad > 0 ) then
			t->lgt += pad
		end if
	end if

	'' check for forward references
	if( ctx.fwdrefcnt > 0 ) then
		hCheckFwdRef( t, FB_SYMBCLASS_UDT )
	end if

end sub

'':::::
function symbAddEnum( byval symbol as zstring ptr ) as FBSYMBOL ptr static
    dim as integer i
    dim as FBSYMBOL ptr e

    function = NULL

    ''
    e = hNewSymbol( NULL, ctx.symtb, FB_SYMBCLASS_ENUM, TRUE, _
    				symbol, NULL, fbIsLocal( ) )
	if( e = NULL ) then
		exit function
	end if

	e->enum.elements	= 0
	e->enum.elmtb.head 	= NULL
	e->enum.elmtb.tail	= NULL
	e->enum.dbg.typenum = INVALID

	'' check for forward references
	if( ctx.fwdrefcnt > 0 ) then
		hCheckFwdRef( e, FB_SYMBCLASS_ENUM )
	end if

	function = e

end function

'':::::
function symbAddEnumElement( byval parent as FBSYMBOL ptr, _
							 byval symbol as zstring ptr, _
					         byval intval as integer ) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr elm, tail
	dim as FBVALUE value

	value.int = intval
	elm = symbAddConst( symbol, FB_SYMBTYPE_ENUM, parent, @value )

	if( elm = NULL ) then
		return NULL
	end if

	parent->enum.elements += 1

	''
	function = elm

end function


'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' procs
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbAddLib( byval libname as string ) as FBLIBRARY ptr static
    dim l as FBLIBRARY ptr

    function = NULL

    '' check if not already declared
    l = hashLookup( @ctx.libhash, strptr( libname ) )
    if( l <> NULL ) then
    	return l
    end if

    l = listNewNode( @ctx.liblist )
	if( l = NULL ) then
		exit function
	end if

	''
	l->name		= libname

	l->hashitem = hashAdd( @ctx.libhash, strptr( l->name ), l, l->hashindex )

	function = l

end function

'':::::
private function hCalcProcArgsLen( byval args as integer, _
						   		   byval argtail as FBSYMBOL ptr ) as integer
	dim i as integer, lgt as integer

	lgt	= 0
	do while( argtail <> NULL )
		select case argtail->arg.mode
		case FB_ARGMODE_BYVAL
			lgt	+= ((argtail->lgt + (FB_INTEGERSIZE-1)) and _
				   not (FB_INTEGERSIZE-1))						'' x86 assumption!

		case FB_ARGMODE_BYREF, FB_ARGMODE_BYDESC
			lgt	+= FB_POINTERSIZE
		end select

		argtail = argtail->prev
	loop

	function = lgt

end function

'':::::
function symbAddArg( byval proc as FBSYMBOL ptr, _
					 byval symbol as zstring ptr, _
					 byval typ as integer, _
					 byval subtype as FBSYMBOL ptr, _
					 byval ptrcnt as integer, _
					 byval lgt as integer, _
					 byval mode as integer, _
					 byval suffix as integer, _
					 byval optional as integer, _
					 byval optval as FBVALUE ptr ) as FBSYMBOL ptr static

    dim a as FBSYMBOL ptr

    function = NULL

    a = hNewSymbol( NULL, @proc->proc.argtb, FB_SYMBCLASS_PROCARG, FALSE, _
    				NULL, symbol, _
    				FALSE, typ, subtype, ptrcnt, INVALID, TRUE )
    if( a = NULL ) then
    	exit function
    end if

	proc->proc.args += 1

	''
	a->lgt			= lgt
	a->arg.mode		= mode
	a->arg.suffix	= suffix
	a->arg.optional	= optional

	if( optional ) then
		a->arg.optval = *optval
	end if

    function = a

end function

'':::::
private function hGetProcRealType( byval typ as integer, _
								   byval subtype as FBSYMBOL ptr ) as integer static

    select case typ
    '' string? it's actually a pointer to a string descriptor
    case FB_SYMBTYPE_STRING
    	 return FB_SYMBTYPE_POINTER + FB_SYMBTYPE_STRING

    '' UDT? follow GCC 3.x's ABI
    case FB_SYMBTYPE_USERDEF

		'' use the un-padded UDT len
		select case as const symbGetUDTLen( subtype )
		case 1
			return FB_SYMBTYPE_BYTE

		case 2
			return FB_SYMBTYPE_SHORT

		case 3
			'' return as int only if first is a short
			if( subtype->udt.fldtb.head->lgt = 2 ) then
				'' and if the struct is not packed
				if( subtype->lgt >= FB_INTEGERSIZE ) then
					return FB_SYMBTYPE_INTEGER
				end if
			end if

		case FB_INTEGERSIZE

			'' return in ST(0) if there's only one element and it's a SINGLE
			if( subtype->udt.elements = 1 ) then
				do
					if( subtype->udt.fldtb.head->typ = FB_SYMBTYPE_SINGLE ) then
						return FB_SYMBTYPE_SINGLE
					end if

					if( subtype->udt.fldtb.head->typ <> FB_SYMBTYPE_USERDEF ) then
						exit do
					end if

					subtype = subtype->udt.fldtb.head->subtype

					if( subtype->udt.elements <> 1 ) then
						exit do
					end if
				loop
			end if

			return FB_SYMBTYPE_INTEGER

		case FB_INTEGERSIZE + 1, FB_INTEGERSIZE + 2, FB_INTEGERSIZE + 3

			'' return as longint only if first is a int
			if( subtype->udt.fldtb.head->lgt = FB_INTEGERSIZE ) then
				'' and if the struct is not packed
				if( subtype->lgt >= FB_INTEGERSIZE*2 ) then
					return FB_SYMBTYPE_LONGINT
				end if
			end if

		case FB_INTEGERSIZE*2

			'' return in ST(0) if there's only one element and it's a DOUBLE
			if( subtype->udt.elements = 1 ) then
				do
					if( subtype->udt.fldtb.head->typ = FB_SYMBTYPE_DOUBLE ) then
						return FB_SYMBTYPE_DOUBLE
					end if

					if( subtype->udt.fldtb.head->typ <> FB_SYMBTYPE_USERDEF ) then
						exit do
					end if

					subtype = subtype->udt.fldtb.head->subtype

					if( subtype->udt.elements <> 1 ) then
						exit do
					end if
				loop
			end if

			return FB_SYMBTYPE_LONGINT

		end select

		'' if nothing matched, it's the pointer that was passed as the 1st arg
		return FB_SYMBTYPE_POINTER + FB_SYMBTYPE_USERDEF

	'' type is the same
	case else
    	return typ

	end select

end function

'':::::
private function hAddOvlProc( byval proc as FBSYMBOL ptr, _
							  byval parent as FBSYMBOL ptr, _
							  byval symbol as zstring ptr, _
							  byval aname as zstring ptr, _
							  byval typ as integer, _
							  byval subtype as FBSYMBOL ptr, _
							  byval ptrcnt as integer, _
				              byval preservecase as integer ) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr f, farg, parg
	dim as integer optcnt, argc

	function = NULL

	'' not arg-less?
	argc = symbGetProcArgs( proc )
	if( argc > 0 ) then

		'' can't be vararg..
		parg = symbGetProcTailArg( proc )
		if( parg->arg.mode = FB_ARGMODE_VARARG ) then
			exit function
		end if

		'' all args can't be optional
		optcnt = 0
		do while( parg <> NULL )
			if( parg->arg.optional ) then
				optcnt += 1
			end if
			parg = parg->prev
		loop

		if( optcnt = argc ) then
			exit function
		end if
	end if

	'' for each overloaded proc..
	f = parent
	do while( f <> NULL )

		'' same number of args?
		if( f->proc.args = argc ) then

			'' both arg-less?
			if( argc = 0 ) then
				exit function
			end if

			'' for each arg..
			parg = symbGetProcTailArg( proc )
			farg = symbGetProcTailArg( f )

			do while( parg <> NULL )
				'' not the same type? check next proc..
				if( parg->typ <> farg->typ ) then
					exit do
				end if

				if( parg->subtype <> farg->subtype ) then
					exit do
				end if

				parg = parg->prev
				farg = farg->prev
			loop

			'' all args equal? can't overload..
			if( parg = NULL ) then
				exit function
			end if

		end if

		f = f->proc.ovl.next
	loop


    '' add the new proc symbol, w/o adding it to the hash table
	proc = hNewSymbol( proc, @ctx.globtb, FB_SYMBCLASS_PROC, FALSE, _
					   symbol, aname, _
					   FALSE, typ, subtype, ptrcnt, INVALID, preservecase )

	if( proc = NULL ) then
		exit function
	end if

	'' add to linked-list or getOrgName will fail
	parent->right	= proc
	proc->left      = parent

	proc->hashitem  = parent->hashitem
	proc->hashindex	= parent->hashindex

    ''
	function = proc

end function

'':::::
function symbIsProcOverloadOf( byval proc as FBSYMBOL ptr, _
							   byval parent as FBSYMBOL ptr ) as integer static

	dim as FBSYMBOL ptr f

	'' no parent?
	if( parent = NULL ) then
		return FALSE
	end if

	'' same?
	if( proc = parent ) then
		return TRUE
	end if

	'' not overloaded?
	if( not symbIsOverloaded( parent ) ) then
		return FALSE
	end if

	'' for each overloaded proc..
	f = parent->proc.ovl.next
	do while( f <> NULL )

		'' same?
		if( proc = f ) then
			return TRUE
		end if

		f = f->proc.ovl.next
	loop

	'' none found..
	return FALSE

end function

'':::::
private function hSetupProc( byval sym as FBSYMBOL ptr, _
							 byval id as zstring ptr, _
							 byval aliasname as zstring ptr, _
							 byval libname as zstring ptr, _
				             byval typ as integer, _
				             byval subtype as FBSYMBOL ptr, _
				             byval ptrcnt as integer, _
				             byval alloctype as integer, _
				             byval mode as integer, _
			                 byval declaring as integer, _
			                 byval preservecase as integer ) as FBSYMBOL ptr static

    static as zstring * FB_MAXINTNAMELEN+1 aname
    dim as integer lgt, realtype
    dim as FBSYMBOL ptr proc, parent

    function = NULL

	''
	if( typ = INVALID ) then
		typ = hGetDefType( *id )
		subtype = NULL
	end if

    realtype = hGetProcRealType( typ, subtype )

    lgt = hCalcProcArgsLen( symbGetProcArgs( sym ), symbGetProcTailArg( sym ) )

    '' no alias? make one..
    if( aliasname = NULL ) then

    	hUcase( *id, aname )

    	'' overloaded?
		if( (alloctype and FB_ALLOCTYPE_OVERLOADED) > 0 ) then
			aname = *hCreateOvlProcAlias( aname, _
										  symbGetProcArgs( sym ), _
										  symbGetProcHeadArg( sym ) )
		end if

		aname = *hCreateProcAlias( aname, lgt, mode )

    '' alias given..
    else
	   	aname = *hCreateProcAlias( *aliasname, lgt, mode )
    end if

    ''
	proc = hNewSymbol( sym, @ctx.globtb, FB_SYMBCLASS_PROC, TRUE, _
					   id, @aname, _
					   FALSE, typ, subtype, ptrcnt, INVALID, preservecase )

	'' dup def?
	if( proc = NULL ) then
		'' is the dup a proc symbol?
		parent = symbFindByNameAndClass( id, FB_SYMBCLASS_PROC, preservecase )
		if( parent = NULL ) then
			exit function
		end if

		'' proc was defined as overloadable?
		if( not symbIsOverloaded( parent ) ) then
			exit function
		end if

    	'' no alias?
    	if( aliasname = NULL ) then
			'' not declared explicitly as overloaded?
			if( (alloctype and FB_ALLOCTYPE_OVERLOADED) = 0 ) then
    			hUcase( *id, aname )

				aname = *hCreateOvlProcAlias( aname, _
											  symbGetProcArgs( sym ), _
											  symbGetProcHeadArg( sym ) )

				aname = *hCreateProcAlias( aname, lgt, mode )
			end if
		end if

		'' try to overload..
		proc = hAddOvlProc( sym, parent, id, aname, typ, subtype, ptrcnt, preservecase )
		if( proc = NULL ) then
			exit function
		end if

		alloctype or= FB_ALLOCTYPE_OVERLOADED

	else
		parent = NULL
	end if

    ''
	proc->alloctype			= alloctype or FB_ALLOCTYPE_SHARED

    '' if proc returns an UDT, add the hidden pointer passed as the 1st arg
    if( typ = FB_SYMBTYPE_USERDEF ) then
    	if( realtype = FB_SYMBTYPE_POINTER + FB_SYMBTYPE_USERDEF ) then
    		lgt += FB_POINTERSIZE
    	end if
    end if

	proc->lgt				= lgt

	proc->proc.isdeclared 	= declaring
	proc->proc.iscalled		= FALSE
	proc->proc.isrtl		= FALSE
	proc->proc.doerrorcheck	= FALSE

	proc->proc.mode			= mode
	proc->proc.realtype		= realtype

	proc->proc.rtlcallback 	= NULL

	if( libname <> NULL ) then
		if( len( libname ) > 0 ) then
			proc->proc.lib 	= symbAddLib( *libname )
		else
			proc->proc.lib 	= NULL
		end if
	else
		proc->proc.lib 		= NULL
	end if

	'' if overloading, update the linked-list
	if( (alloctype and FB_ALLOCTYPE_OVERLOADED) > 0 ) then
		if( parent <> NULL ) then
			proc->proc.ovl.next = parent->proc.ovl.next
			parent->proc.ovl.next = proc

			if( symbGetProcArgs( proc ) > parent->proc.ovl.maxargs ) then
				parent->proc.ovl.maxargs = symbGetProcArgs( proc )
			end if
		else
			proc->proc.ovl.next		= NULL
			proc->proc.ovl.maxargs	= symbGetProcArgs( proc )
		end if
	end if

	function = proc

end function

'':::::
function symbAddPrototype( byval proc as FBSYMBOL ptr, _
						   byval symbol as zstring ptr, _
						   byval aliasname as zstring ptr, _
						   byval libname as zstring ptr, _
						   byval typ as integer, _
						   byval subtype as FBSYMBOL ptr, _
						   byval ptrcnt as integer, _
						   byval alloctype as integer, _
						   byval mode as integer, _
						   byval isexternal as integer, _
						   byval preservecase as integer = FALSE ) as FBSYMBOL ptr static

    function = NULL

	proc = hSetupProc( proc, symbol, aliasname, libname, _
					   typ, subtype, ptrcnt, _
					   alloctype, mode, isexternal, preservecase )
	if( proc = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function symbAddProc( byval proc as FBSYMBOL ptr, _
					  byval symbol as zstring ptr, _
					  byval aliasname as zstring ptr, _
					  byval libname as zstring ptr, _
					  byval typ as integer, _
					  byval subtype as FBSYMBOL ptr, _
					  byval ptrcnt as integer, _
					  byval alloctype as integer, _
					  byval mode as integer ) as FBSYMBOL ptr static

    function = NULL

	proc = hSetupProc( proc, symbol, aliasname, libname, _
					   typ, subtype, ptrcnt, _
					   alloctype, mode, TRUE, FALSE )
	if( proc = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function symbPreAddProc( ) as FBSYMBOL ptr static
    dim as FBSYMBOL ptr proc

	proc = listNewNode( @ctx.symlist )
	if( proc = NULL ) then
		exit function
	end if

	proc->class				= FB_SYMBCLASS_PROC
	proc->proc.args 		= 0
	proc->proc.argtb.head	= NULL
	proc->proc.argtb.tail	= NULL

	function = proc

end function

'':::::
function symbAddArgAsVar( byval symbol as zstring ptr, _
						  byval arg as FBSYMBOL ptr ) as FBSYMBOL ptr static

    dim as FBARRAYDIM dTB(0)
    dim as FBSYMBOL ptr s
    dim as integer alloctype, typ

	function = NULL

	typ = arg->typ

	select case as const arg->arg.mode
    case FB_ARGMODE_BYVAL
    	'' byval string? it's actually an pointer to a zstring
    	if( typ = FB_SYMBTYPE_STRING ) then
    		alloctype = FB_ALLOCTYPE_ARGUMENTBYREF
    		typ = FB_SYMBTYPE_CHAR
    	else
    		alloctype = FB_ALLOCTYPE_ARGUMENTBYVAL
    	end if

	case FB_ARGMODE_BYREF
	    alloctype = FB_ALLOCTYPE_ARGUMENTBYREF

	case FB_ARGMODE_BYDESC
    	alloctype = FB_ALLOCTYPE_ARGUMENTBYDESC

	case else
    	exit function
	end select

    s = symbAddVarEx( symbol, NULL, typ, arg->subtype, 0, 0, _
    				  0, dTB(), alloctype, _
    				  arg->arg.suffix <> INVALID, FALSE, TRUE )

    if( s = NULL ) then
    	exit function
    end if

	function = s

end function

'':::::
function symbAddProcResArg( byval proc as FBSYMBOL ptr ) as FBSYMBOL ptr static
    static as zstring * FB_MAXINTNAMELEN+1 symbol
    dim as FBARRAYDIM dTB(0)
    dim as FBSYMBOL ptr s

	'' UDT?
	if( proc->typ <> FB_SYMBTYPE_USERDEF ) then
		return NULL
	end if

	'' returning a ptr?
	if( proc->proc.realtype <> FB_SYMBTYPE_POINTER+FB_SYMBTYPE_USERDEF ) then
		return NULL
	end if

	symbol = FBPREFIX_PROCRES
	symbol += symbGetOrgName( proc )

    s = symbAddVarEx( @symbol, NULL, _
    				  FB_SYMBTYPE_POINTER+FB_SYMBTYPE_USERDEF, proc->subtype, 0, 0, _
    				  0, dTB(), FB_ALLOCTYPE_ARGUMENTBYVAL, _
    				  TRUE, TRUE, FALSE )

	function = s

end function

'':::::
function symbAddProcResult( byval proc as FBSYMBOL ptr ) as FBSYMBOL ptr static
	static as zstring * FB_MAXINTNAMELEN+1 rname
	dim as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr s, subtype
	dim as integer dtype

	'' UDT?
	if( proc->typ = FB_SYMBTYPE_USERDEF ) then
		'' returning a ptr? result is at the hidden arg
		if( proc->proc.realtype = FB_SYMBTYPE_POINTER+FB_SYMBTYPE_USERDEF ) then
			return symbLookupProcResult( proc )
		end if
	end if

	rname = FBPREFIX_PROCRES
	rname += symbGetOrgName( proc )

	s = symbAddVarEx( @rname, NULL, proc->typ, proc->subtype, 0, 0, 0, _
					  dTB(), 0, TRUE, TRUE, FALSE )

	function = s

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' scopes
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbAddScope( ) as FBSYMBOL ptr
    dim as FBSYMBOL ptr s

    s = hNewSymbol( NULL, ctx.symtb, FB_SYMBCLASS_SCOPE, FALSE, NULL, NULL )

    s->scp.loctb.head = NULL
    s->scp.loctb.tail = NULL

	function = s

end function


''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' lookups
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbLookup( byval symbol as zstring ptr, _
					 id as integer, _
					 class as integer, _
					 byval preservecase as integer = FALSE _
				   ) as FBSYMBOL ptr static

    static as zstring * FB_MAXNAMELEN+1 sname
    dim as FBSYMBOL ptr s

    if( not preservecase ) then
    	hUcase( *symbol, sname )
    	s = hashLookup( @ctx.symhash, @sname )
    else
    	s = hashLookup( @ctx.symhash, symbol )
    end if

	'' assume it's an unknown identifier
	id 	  = FB_TK_ID
	class = FB_TKCLASS_IDENTIFIER

	if( s <> NULL ) then
		'' if it's a keyword, return id and class
		if( s->class = FB_SYMBCLASS_KEYWORD ) then
			id 	  = s->key.id
			class = s->key.class
		end if
	end if

	function = s

end function

'':::::
function symbGetUDTElmOffset( elm as FBSYMBOL ptr, _
							  typ as integer, _
							  subtype as FBSYMBOL ptr, _
							  byval fields as zstring ptr _
							) as integer

	static as zstring * FB_MAXNAMELEN+1 ename
	dim as FBSYMBOL ptr e
	dim as integer p, ofs, res
	dim as integer flen

    flen = len( *fields )

    '' find next dot
    p = instr( 1, *fields, "." )
    ename = *fields
    if( p > 0 ) then
    	ename[p-1] = 0							'' ename = left$( fields, p-1 )
    else
    	p = flen
    end if

    '' to upper
    hUcase( ename, ename )

	''
	elm = NULL

    '' no subtupe? can't be an UDT
    if( subtype = NULL ) then
    	return -1
    end if

	'' for each field
	e = subtype->udt.fldtb.head
	do while( e <> NULL )

        '' names match?
        if( e->name = ename ) then

        	elm 		= e
        	ofs 		= e->var.elm.ofs
        	typ 		= e->typ
        	subtype 	= e->subtype

        	if( typ <> FB_SYMBTYPE_USERDEF ) then
				if( p < flen ) then
        			return -1
        		else
        			return ofs
        		end if
        	end if

    		'' another UDT..
    		if( p = flen ) then
    			return ofs
    		end if

    		res = symbGetUDTElmOffset( elm, _
    								   typ, subtype, _
    								   @ename[p] )		'' mid$( fields, p+1 )
    		if( res < 0 ) then
    			return -1
    		end if

    		return ofs + res

        end if

		'' next
		e = e->next
    loop

    function = -1

end function

'':::::
function symbLookupUDTVar( byval symbol as zstring ptr, _
						   byval dotpos as integer _
						 ) as FBSYMBOL ptr static

    static as zstring * FB_MAXNAMELEN+1 sname
	dim as FBSYMBOL ptr s

    function = NULL

    '' symbol contains no dots?
    if( dotpos < 1 ) then
    	exit function
    end if

	'' check if it's an UDT field
    sname = *symbol
    sname[dotpos-1] = 0 						'' left$( symbol, dotpos-1 )

    s = symbFindByNameAndClass( @sname, FB_SYMBCLASS_VAR )
	if( s = NULL ) then
		exit function
	end if

	if( s->typ <> FB_SYMBTYPE_USERDEF ) then
		exit function
	end if

	function = s

end function

'':::::
function symbLookupUDTElm( byval symbol as zstring ptr, _
						   byval dotpos as integer, _
						   typ as integer, _
						   ofs as integer, _
					       elm as FBSYMBOL ptr, _
					       subtype as FBSYMBOL ptr _
					     ) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr s

    function = NULL

    s = symbLookupUDTVar( symbol, dotpos )
    if( s = NULL ) then
    	exit function
    end if

    ''
    elm	    = NULL
    subtype	= s->subtype
    typ 	= s->typ

	'' find the offset
	ofs = symbGetUDTElmOffset( elm, _
							   typ, subtype, _
							   @symbol[dotpos] )		'' mid$( symbol, dotpos+1 )
	if( ofs < 0 ) then
		hReportError( FB_ERRMSG_ELEMENTNOTDEFINED )
    	exit function
	end if

	function = s

end function

'':::::
function symbLookupProcResult( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr static
	static as zstring * FB_MAXINTNAMELEN+1 rname

	if( f = NULL ) then
		return NULL
	end if

	rname = FBPREFIX_PROCRES
	rname += symbGetOrgName( f )

	function = symbFindByNameAndClass( @rname, FB_SYMBCLASS_VAR, TRUE )

end function

'':::::
function symbFindByClass( byval s as FBSYMBOL ptr, _
						  byval class as integer _
						) as FBSYMBOL ptr static

    '' lookup a symbol with the same class
    do while( s <> NULL )
    	if( s->class = class ) then
			exit do
		end if
    	s = s->right
    loop

	if( s = NULL ) then
		return NULL
	end if

	'' check if symbol isn't a non-shared module level one

	if( class = FB_SYMBCLASS_VAR ) then
		if( fbIsLocal( ) ) then
			if( (s->alloctype and (FB_ALLOCTYPE_LOCAL or FB_ALLOCTYPE_SHARED)) = 0 ) then
				return NULL
			end if
		end if
	end if

	function = s

end function

'':::::
function symbFindBySuffix( byval s as FBSYMBOL ptr, _
						   byval suffix as integer, _
						   byval deftyp as integer _
						 ) as FBSYMBOL ptr static

    '' symbol has a suffix? lookup a symbol with the same type, suffixed or not
    if( suffix <> INVALID ) then
    	do while( s <> NULL )
    		if( s->class = FB_SYMBCLASS_VAR ) then
     			if( s->typ = suffix ) then
     				exit do
     			end if
     		end if
    		s = s->right
    	loop

    '' symbol has no suffix, lookup a symbol w/o suffix or with the same type as deftyp
    else
    	do while( s <> NULL )
    		if( s->class = FB_SYMBCLASS_VAR ) then
     			if( s->var.suffix = INVALID ) then
     				exit do
     			elseif( s->typ = deftyp ) then
     				exit do
     			end if
     		end if
    		s = s->right
    	loop
    end if

	if( s = NULL ) then
		return NULL
	end if

	'' check if symbol isn't a non-shared module level one
	if( fbIsLocal( ) ) then
		if( (s->alloctype and (FB_ALLOCTYPE_LOCAL or FB_ALLOCTYPE_SHARED)) = 0 ) then
			return NULL
		end if
	end if

	function = s

end function

'':::::
function symbFindByNameAndClass ( byval symbol as zstring ptr, _
	  							  byval class as integer, _
	  							  byval preservecase as integer = FALSE _
								) as FBSYMBOL ptr static

	dim s as FBSYMBOL ptr
	dim tkid as integer, tkclass as integer

    s = symbLookup( symbol, tkid, tkclass, preservecase )

    '' any found?
    if( s <> NULL ) then
    	'' check if classes match
    	function = symbFindByClass( s, class )
    else
    	function = NULL
    end if

end function

'':::::
function symbFindByNameAndSuffix( byval symbol as zstring ptr, _
								  byval suffix as integer, _
								  byval preservecase as integer = FALSE _
								) as FBSYMBOL ptr static
	dim s as FBSYMBOL ptr
	dim deftyp as integer
	dim tkid as integer, tkclass as integer

	s = symbLookup( symbol, tkid, tkclass, preservecase )

    '' any found?
    if( s <> NULL ) then
    	'' get default type if no suffix was given
    	if( suffix = INVALID ) then
    		deftyp = hGetDefType( *symbol )
    	end if

		'' check if types match
		function = symbFindBySuffix( s, suffix, deftyp )
	else
		function = NULL
	end if

end function

'':::::
function symbFindOverloadProc( byval parent as FBSYMBOL ptr, _
							   byval proc as FBSYMBOL ptr ) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr f, farg, parg, fsubtype, psubtype
	dim as integer argc

	''
	if( (parent = NULL) or (proc = NULL) ) then
		return NULL
	end if

	'' procs?
	if( (symbGetClass( parent ) <> FB_SYMBCLASS_PROC) or _
		(symbGetClass( proc ) <> FB_SYMBCLASS_PROC) ) then
		return NULL
	end if

	argc = symbGetProcArgs( proc )

	'' for each proc starting from parent..
	f = parent
	do while( f <> NULL )

		if( argc = f->proc.args ) then

			'' arg-less?
			if( argc = 0 ) then
				return f
			end if

			'' for each arg..
			farg = symbGetProcTailArg( f )
			parg = symbGetProcTailArg( proc )
			do while( parg <> NULL )

				'' not the same type? check next proc..
				if( parg->typ <> farg->typ ) then
					exit do
				end if

				if( parg->subtype <> farg->subtype ) then
					exit do
				end if

				parg = parg->prev
				farg = farg->prev
			loop

			'' all args equal?
			if( parg = NULL ) then
				return f
			end if

		end if

		f = f->proc.ovl.next
	loop

	function = NULL

end function

'':::::
function symbFindClosestOvlProc( byval proc as FBSYMBOL ptr, _
					   		     byval params as integer, _
					   		     exprTB() as ASTNODE ptr, _
					   		     modeTB() as integer _
					   		   ) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr f, arg, s
	dim as integer p, pdtype, pdclass
	dim as integer fmatches, matches

	'' enough to an impossible-to-reach level of indirection
	const FB_OVLPROC_FULLMATCH = 1073741824 \ FB_MAXPROCARGS
	const FB_OVLPROC_HALFMATCH = FB_OVLPROC_FULLMATCH \ 2

	matches = 0

	'' for each proc..
	f = proc
	do while( f <> NULL )

		if( params <= symbGetProcArgs( f ) ) then

			'' arg-less? exit..
			if( symbGetProcArgs( f ) = 0 ) then
				return f
			end if

			arg = symbGetProcLastArg( f )
			fmatches = 0

			'' for each arg..
			for p = 0 to params-1

				'' not optional?
				if( exprTB(p) <> NULL ) then

					'' different types?
					pdtype = astGetDataType( exprTB(p) )
					if( arg->typ <> pdtype ) then

						pdclass = irGetDataClass( pdtype )

						'' check classes
						select case as const irGetDataClass( arg->typ )
						'' integer?
						case IR_DATACLASS_INTEGER
							select case as const pdclass
							'' another integer or float is ok (due the auto-coercion)
							case IR_DATACLASS_INTEGER, IR_DATACLASS_FPOINT
								fmatches += (FB_OVLPROC_HALFMATCH - abs( arg->typ - pdtype ))

							'' string? only if it's a zstring ptr arg
							case IR_DATACLASS_STRING
								if( arg->typ <> IR_DATATYPE_POINTER+IR_DATATYPE_CHAR ) then
									fmatches = 0
									exit for
								end if

								fmatches += FB_OVLPROC_FULLMATCH

							'' refuse anything else
							case else
								fmatches = 0
								exit for
							end select

						'' floating-point?
						case IR_DATACLASS_FPOINT
							'' only accept another float or integer
							select case as const pdclass
							case IR_DATACLASS_INTEGER, IR_DATACLASS_FPOINT
								fmatches += (FB_OVLPROC_HALFMATCH - abs( arg->typ - pdtype ))

							'' refuse anything else
							case else
								fmatches = 0
								exit for
							end select

						'' string?
						case IR_DATACLASS_STRING

							select case pdclass
							'' okay if it's another var- or fixed-len string
							case IR_DATACLASS_STRING
								fmatches += (FB_OVLPROC_HALFMATCH - abs( arg->typ - pdtype ))

							'' integer only if it's a zstring
							case IR_DATACLASS_INTEGER
								if( pdtype <> IR_DATATYPE_CHAR ) then
									fmatches = 0
									exit for
								end if

								fmatches += FB_OVLPROC_FULLMATCH

							'' refuse anything else
							case else
								fmatches = 0
								exit for
							end select

						'' user-defined..
						case IR_DATACLASS_UDT

							'' not another udt?
							if( pdclass <> IR_DATACLASS_UDT ) then
								'' not a proc? (can be an UDT been returned in registers)
								if( astGetClass( exprTB(p) ) <> AST_NODECLASS_FUNCT ) then
									fmatches = 0
									exit for
								end if

								'' it's a proc, but was it originally returning an UDT?
								s = astGetSymbol( exprTB(p) )
								if( s->typ <> FB_SYMBTYPE_USERDEF ) then
									fmatches = 0
									exit for
								end if

								'' get the original subtype
								s = s->subtype

                            '' udt..
                            else
                            	s = astGetSubType( exprTB(p) )
                            end if

                			'' can't be different
							if( arg->subtype <> s ) then
								fmatches = 0
								exit for
							end if

							fmatches += FB_OVLPROC_FULLMATCH

						end select

                    '' same types..
					else
						fmatches += FB_OVLPROC_HALFMATCH

						'' check the subtype
						if( arg->subtype <> astGetSubType( exprTB(p) ) ) then

							'' check classes
							select case irGetDataClass( arg->typ )

							'' UDT? can't be different..
							case IR_DATACLASS_UDT
								fmatches = 0
								exit for

							end select

						'' same subtype too..
						else
							fmatches += FB_OVLPROC_HALFMATCH
						end if
					end if

				'' optional..
				else
					'' but arg isn't?
					if( not symbGetArgOptional( f, arg ) ) then
						fmatches = 0
						exit for
					end if

					fmatches += FB_OVLPROC_FULLMATCH

				end if

               	'' next arg
				arg = symbGetProcPrevArg( f, arg )
			next

			if( fmatches > 0 ) then
				'' fewer params? check if the ones missing are optional
				if( params < symbGetProcArgs( f ) ) then
					do while( arg <> NULL )
				    	'' not optional? exit
				    	if( not symbGetArgOptional( f, arg ) ) then
				    		fmatches = 0
				    		exit do
				    	end if

						'' next arg
						arg = symbGetProcPrevArg( f, arg )
					loop
				end if
			end if

		    '' closer?
		    if( fmatches > matches ) then
			   	proc = f
			   	matches = fmatches
			end if

		end if

		'' next overloaded proc
		f = f->proc.ovl.next
	loop

	''
	function = proc

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' helpers
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbCalcLen( byval typ as integer, _
					  byval subtype as FBSYMBOL ptr, _
					  byval realsize as integer = FALSE ) as integer static

    dim e as FBSYMBOL ptr

	function = 0

	select case as const typ
	case FB_SYMBTYPE_FWDREF
		function = 0

	case FB_SYMBTYPE_BYTE, FB_SYMBTYPE_UBYTE, FB_SYMBTYPE_CHAR
		function = 1

	case FB_SYMBTYPE_SHORT, FB_SYMBTYPE_USHORT
		function = 2

	case FB_SYMBTYPE_INTEGER, FB_SYMBTYPE_LONG, FB_SYMBTYPE_UINT, FB_SYMBTYPE_ENUM
		function = FB_INTEGERSIZE

	case FB_SYMBTYPE_LONGINT, FB_SYMBTYPE_ULONGINT
		function = FB_INTEGERSIZE*2

	case FB_SYMBTYPE_SINGLE
		function = 4

	case FB_SYMBTYPE_DOUBLE
    	function = 8

	case FB_SYMBTYPE_FIXSTR
		function = 0									'' 0-len literal-strings

	case FB_SYMBTYPE_STRING
		function = FB_STRDESCLEN

	case FB_SYMBTYPE_USERDEF
		if( not realsize ) then
			function = subtype->lgt
		else
			function = subtype->udt.unpadlgt
		end if

	case else
		if( typ >= FB_SYMBTYPE_POINTER ) then
			function = FB_POINTERSIZE
		end if
	end select

end function

'':::::
function symbCalcArgLen( byval typ as integer, _
						 byval subtype as FBSYMBOL ptr, _
						 byval mode as integer ) as integer static
    dim lgt as integer

	select case mode
	case FB_ARGMODE_BYREF, FB_ARGMODE_BYDESC
		lgt = FB_POINTERSIZE
	case else
		if( typ = FB_SYMBTYPE_STRING ) then
			lgt = FB_POINTERSIZE
		else
			lgt = symbCalcLen( typ, subtype )
		end if
	end select

	function = lgt

end function

'':::::
function hCalcDiff( byval dimensions as integer, _
					dTB() as FBARRAYDIM, _
					byval lgt as integer ) as integer

    dim d as integer, diff as integer, elms as integer, mult as integer

	if( dimensions <= 0 ) then
		return 0
	end if

	diff = 0
	for d = 0 to (dimensions-1)-1
		elms = (dTB(d+1).upper - dTB(d+1).lower) + 1
		diff = (diff+dTB(d).lower) * elms
	next

	diff += dTB(dimensions-1).lower

	diff *= lgt

	function = -diff

end function

'':::::
function hCalcElements( byval s as FBSYMBOL ptr, _
						byval n as FBVARDIM ptr = NULL ) as integer static
    dim e as integer, d as integer

	if( n = NULL ) then
		n = s->var.array.dimhead
	end if

	e = 1
	do while( n <> NULL )
		d = (n->upper - n->lower) + 1
		e = e * d
		n = n->next
	loop

	function = e

end function

'':::::
function hCalcElements2( byval dimensions as integer, _
						 dTB() as FBARRAYDIM ) as integer static
    dim e as integer, i as integer, d as integer

	e = 1
	for i = 0 to dimensions-1
		d = (dTB(i).upper - dTB(i).lower) + 1
		e = e * d
	next i

	function = e

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' getters and setters
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbGetUDTLen( byval s as FBSYMBOL ptr, _
						byval realsize as integer = TRUE ) as integer static

	if( not realsize ) then
		function = s->lgt
	else
		function = s->udt.unpadlgt
	end if

end function

'':::::
function symbGetProcLib( byval p as FBSYMBOL ptr ) as string static
    dim l as FBLIBRARY ptr

	l = p->proc.lib
	if( l <> NULL ) then
		function = l->name
	else
	    function = ""
	end if

end function

'':::::
function symbGetVarDescName( byval s as FBSYMBOL ptr ) as string static
	dim d as FBSYMBOL ptr

	d = s->var.array.desc
	if( d <> NULL ) then
		function = d->alias
	else
		function = ""
	end if

end function

'':::::
function symbGetVarText( byval s as FBSYMBOL ptr ) as string static

	if( s->var.initialized ) then
		function = s->var.inittext
	else
		function = ""
	end if

end function

'':::::
function symbGetConstValueAsStr( byval s as FBSYMBOL ptr ) as string

  	select case as const symbGetType( s )
  	case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR, IR_DATATYPE_CHAR
  		function = symbGetConstValStr( s )->var.inittext

  	case IR_DATATYPE_LONGINT
  		function = str( symbGetConstValLong( s ) )

  	case IR_DATATYPE_ULONGINT
  	    function = str( cunsg( symbGetConstValLong( s ) ) )

  	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  		function = str( symbGetConstValFloat( s ) )

  	case IR_DATATYPE_UBYTE, IR_DATATYPE_USHORT, IR_DATATYPE_UINT
  		function = str( cunsg( symbGetConstValInt( s ) ) )

  	case else
  		function = str( symbGetConstValInt( s ) )
  	end select

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' del
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hDelFromHash( byval s as FBSYMBOL ptr ) static
    dim as FBSYMBOL ptr prv, nxt

	if( s->hashitem = NULL ) then
		exit sub
	end if

    '' relink
    prv = s->left
    nxt = s->right
    if( prv <> NULL ) then
    	prv->right = nxt
    end if
    if( nxt <> NULL ) then
    	nxt->left = prv
    end if

    '' symbol was the head node?
    if( prv = NULL ) then
    	'' nothing left? remove from hash table
    	if( nxt = NULL ) then
    		hashDel( @ctx.symhash, s->hashitem, s->hashindex )

    	'' update list head
    	else
       		s->hashitem->idx  = nxt
       		s->hashitem->name = strptr( nxt->name )
    	end if
    end if

    s->hashitem  = NULL
    s->hashindex = 0
    s->left 	 = NULL
    s->right 	 = NULL

end sub

'':::::
private sub hFreeSymbol( byval s as FBSYMBOL ptr, _
				 		 byval movetoglob as integer ) static

    dim as FBSYMBOLTB ptr tb
    dim as FBSYMBOL ptr prv, nxt

	hDelFromHash( s )

    '' del from table
    tb = s->symtb

    prv = s->prev
    nxt = s->next
    if( prv <> NULL ) then
    	prv->next = nxt
    else
    	tb->head = nxt
    end if

    if( nxt <> NULL ) then
    	nxt->prev = prv
    else
    	tb->tail = prv
    end if

    '' remove from symbol list
    if( not movetoglob ) then
    	s->prev  = NULL
    	s->next  = NULL
    	s->name  = ""
    	s->alias = ""

    	listDelNode( @ctx.symlist, cptr( TLISTNODE ptr, s ) )

    '' move from local to global table
    else
		if( ctx.globtb.tail <> NULL ) then
			ctx.globtb.tail->next = s
		else
			ctx.globtb.head = s
		end if

		s->prev = ctx.globtb.tail
		s->next = NULL
		ctx.globtb.tail = s
		s->symtb = @ctx.globtb
    end if

end sub

'':::::
function symbDelKeyword( byval s as FBSYMBOL ptr, _
				         byval dolookup as integer ) as integer

    function = FALSE

	if( dolookup ) then
		s = symbFindByClass( s, FB_SYMBCLASS_KEYWORD )
	end if

	if( s = NULL ) then
		exit function
	end if

	hFreeSymbol( s )

	function = TRUE

end function

'':::::
private sub hDelDefineArgs( byval s as FBSYMBOL ptr )
	dim as FBDEFARG ptr arg, nxt

    arg = s->def.arghead
    do while( arg <> NULL )
    	nxt = arg->next
    	arg->name = ""
    	listDelNode( @ctx.defarglist, cptr( TLISTNODE ptr, arg ) )
    	arg = nxt
    loop

end sub

'':::::
private sub hDelDefineTokens( byval s as FBSYMBOL ptr )
	dim as FBDEFTOK ptr tok, nxt

    tok = s->def.tokhead
    do while( tok <> NULL )
    	nxt = tok->next

    	if( tok->type = FB_DEFTOK_TYPE_TEX ) then
    		tok->text = ""
    	end if

    	listDelNode( @ctx.deftoklist, cptr( TLISTNODE ptr, tok ) )
    	tok = nxt
    loop

end sub

'':::::
function symbDelDefine( byval s as FBSYMBOL ptr, _
				        byval dolookup as integer ) as integer static
    dim arg as FBDEFARG ptr, narg as FBDEFARG ptr

    function = FALSE

	if( dolookup ) then
		s = symbFindByClass( s, FB_SYMBCLASS_DEFINE )
	end if

    if( s = NULL ) then
    	exit function
    end if

	''
	if( symbGetDefineArgs( s ) = 0 ) then
		s->def.text = ""
	else
		hDelDefineTokens( s )
	end if

	hDelDefineArgs( s )

    '' del the define node
    hFreeSymbol( s )

	''
	function = TRUE

end function

'':::::
sub symbDelLabel( byval s as FBSYMBOL ptr, _
				  byval dolookup as integer ) static

    if( dolookup ) then
    	s = symbFindByClass( s, FB_SYMBCLASS_LABEL )
    end if

    if( s = NULL ) then
    	exit sub
    end if

    hFreeSymbol( s )

end sub

'':::::
sub symbDelConst( byval s as FBSYMBOL ptr, _
				  byval dolookup as integer )

    if( dolookup ) then
    	s = symbFindByClass( s, FB_SYMBCLASS_CONST )
    end if

    if( s = NULL ) then
    	exit sub
    end if

    '' if it's a string, the symbol attached will be deleted be delVar()

	hFreeSymbol( s )

end sub

'':::::
sub symbDelUDT( byval s as FBSYMBOL ptr, _
				byval dolookup as integer )

    dim as FBSYMBOL ptr e, nxt

    if( dolookup ) then
    	s = symbFindByClass( s, FB_SYMBCLASS_UDT )
    end if

    if( s = NULL ) then
    	exit sub
    end if

    '' del all udt elements
    e = s->udt.fldtb.head
    do while( e <> NULL )
        nxt = e->next
    	hFreeSymbol( e )
    	e = nxt
    loop

	'' del the udt node
	hFreeSymbol( s )

end sub

'':::::
sub symbDelEnum( byval s as FBSYMBOL ptr, _
				 byval dolookup as integer )

	dim as FBSYMBOL ptr e, nxt

    if( dolookup ) then
    	s = symbFindByClass( s, FB_SYMBCLASS_ENUM )
    end if

    if( s = NULL ) then
    	exit sub
    end if

    '' del all enum constants
	e = s->enum.elmtb.head
    do while( e <> NULL )
        nxt = e->next
		hFreeSymbol( e )
		e = nxt
	loop

	'' del the enum node
	hFreeSymbol( s )

end sub

'':::::
sub symbDelScope( byval scp as FBSYMBOL ptr )
	dim as FBSYMBOL ptr s, nxt

    if( scp = NULL ) then
    	exit sub
    end if

    '' del all enum constants
	s = scp->scp.loctb.head
    do while( s <> NULL )
        nxt = s->next
		symbDelSymbol( s )
		s = nxt
	loop

	'' del the scope node
	hFreeSymbol( scp )

end sub

'':::::
private sub hDelArgs( byval f as FBSYMBOL ptr )
	dim as FBSYMBOL ptr a, n

    a = f->proc.argtb.head
    do while( a <> NULL )
    	n = a->next
    	hFreeSymbol( a )
    	a = n
    loop

end sub

'':::::
sub symbDelPrototype( byval s as FBSYMBOL ptr, _
				      byval dolookup as integer )
	dim as FBSYMBOL ptr n

    if( dolookup ) then
    	s = symbFindByClass( s, FB_SYMBCLASS_PROC )
    end if

    if( s = NULL ) then
    	exit sub
    end if

	do
		'' overloaded?
		if( symbIsOverloaded( s ) ) then
			n = s->proc.ovl.next
		else
			n = NULL
		end if

		'' del args..
		if( s->proc.args > 0 ) then
			hDelArgs( s )
		end if

    	hFreeSymbol( s )

    	'' next overload
    	s = n
    loop while( s <> NULL )

end sub

'':::::
sub hDelVarDims( byval s as FBSYMBOL ptr ) static
    dim as FBVARDIM ptr n, nxt

    n = s->var.array.dimhead
    do while( n <> NULL )
    	nxt = n->next

    	listDelNode( @ctx.dimlist, cptr( TLISTNODE ptr, n ) )

    	n = nxt
    loop

    s->var.array.dimhead = NULL
    s->var.array.dimtail = NULL
    s->var.array.dims	  = 0

end sub

'':::::
sub symbDelVar( byval s as FBSYMBOL ptr, _
				byval dolookup as integer )

    dim movetoglob as integer

    if( s = NULL ) then
    	exit sub
    end if

	movetoglob = FALSE

	'' local?
	if( (s->alloctype and FB_ALLOCTYPE_LOCAL ) > 0 ) then
    	'' static?
    	if( symbIsStatic( s ) ) then
    		'' move it to global list if not already
    		if( s->symtb <> @ctx.globtb ) then
    			movetoglob = TRUE
    		end if
    	end if
	end if

	if( not movetoglob ) then
    	if( s->var.array.dims > 0 ) then
    		hDelVarDims( s )
    		'' del the array descriptor, recursively
    		symbDelVar( s->var.array.desc )
    	end if
    end if

    if( s->var.initialized ) then
    	s->var.initialized = FALSE
    	s->var.inittext = ""
    end if

    hFreeSymbol( s, movetoglob )

end sub

'':::::
sub symbDelLib( byval l as FBLIBRARY ptr ) static

	if( l = NULL ) then
		exit sub
	end if

	hashDel( @ctx.libhash, l->hashitem, l->hashindex )

	l->name = ""

    listDelNode( @ctx.liblist, cptr( TLISTNODE ptr, l ) )

end sub

'':::::
sub symbDelSymbol( byval s as FBSYMBOL ptr )

	select case as const s->class
    case FB_SYMBCLASS_VAR
    	symbDelVar( s, FALSE )

    case FB_SYMBCLASS_CONST
		symbDelConst( s, FALSE )

    case FB_SYMBCLASS_PROC
    	symbDelPrototype( s, FALSE )

	case FB_SYMBCLASS_DEFINE
		symbDelDefine( s, FALSE )

	case FB_SYMBCLASS_KEYWORD
		symbDelKeyword( s, FALSE )

    case FB_SYMBCLASS_LABEL
    	symbDelLabel( s, FALSE )

    case FB_SYMBCLASS_ENUM
		symbDelEnum( s, FALSE )

    case FB_SYMBCLASS_UDT
    	symbDelUDT( s, FALSE )

    case FB_SYMBCLASS_SCOPE
    	symbDelScope( s )

	case else
		hFreeSymbol( s )

    end select

end sub

'':::::
sub symbDelGlobalTb( ) static
    dim as FBSYMBOL ptr s

    do
    	s = ctx.globtb.head
    	if( s = NULL ) then
    		exit do
    	end if

    	symbDelSymbol( s )
    loop

end sub

'':::::
sub symbDelSymbolTb( byval tb as FBSYMBOLTB ptr, _
					 byval hashonly as integer ) static

    dim as FBSYMBOL ptr s

    '' del from hash tb only?
    if( hashonly ) then

    	s = tb->head
    	do while( s <> NULL )

	    	select case as const s->class
    		case FB_SYMBCLASS_VAR, FB_SYMBCLASS_CONST, FB_SYMBCLASS_UDT, _
    			 FB_SYMBCLASS_ENUM, FB_SYMBCLASS_LABEL

    			hDelFromHash( s )

    		case FB_SYMBCLASS_SCOPE
    			'' already removed..
    			''''' symbDelScopeTb( s )
    		end select

    		s = s->next
    	loop

    '' del from hash and symbol tb's
    else

    	do
    	    s = tb->head
    		if( s = NULL ) then
    			exit do
    		end if

	    	symbDelSymbol( s )
    	loop

    end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' locals
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbFreeLocalDynVars( byval proc as FBSYMBOL ptr, _
						  byval issub as integer ) static

    dim as FBSYMBOL ptr s, fres
    dim as ASTNODE ptr strg

    '' can't free function's result, that's will be done by the rtlib
    if( issub ) then
    	fres = NULL
    else
    	fres = symbLookupProcResult( proc )
	end if

	s = ctx.symtb->head
    do while( s <> NULL )
    	'' variable?
    	if( s->class = FB_SYMBCLASS_VAR ) then
    		'' not shared or static?
    		if( (s->alloctype and (FB_ALLOCTYPE_SHARED or FB_ALLOCTYPE_STATIC)) = 0 ) then

				'' not an argument?
    			if( (s->alloctype and (FB_ALLOCTYPE_ARGUMENTBYDESC or _
    				  				   FB_ALLOCTYPE_ARGUMENTBYVAL or _
    				  				   FB_ALLOCTYPE_ARGUMENTBYREF or _
    				  				   FB_ALLOCTYPE_TEMP)) = 0 ) then

					'' array?
					if( s->var.array.dims > 0 ) then
						'' dynamic?
						if( symbIsDynamic( s ) ) then
							rtlArrayErase( astNewVAR( s, NULL, 0, s->typ ) )
						'' array of dyn strings?
						elseif( s->typ = FB_SYMBTYPE_STRING ) then
							rtlArrayStrErase( s )
						end if

					'' dyn string?
					elseif( s->typ = FB_SYMBTYPE_STRING ) then
						'' not funct's result?
						if( s <> fres ) then
							strg = astNewVAR( s, NULL, 0, IR_DATATYPE_STRING )
							astAdd( rtlStrDelete( strg ) )
						end if
					end if

				end if

    		end if
    	end if

    	s = s->next
    loop

end sub

'':::::
sub symbFreeScopeDynVars( byval scp as FBSYMBOL ptr ) static

    dim as FBSYMBOL ptr s
    dim as ASTNODE ptr strg

	'' for each symbol declared inside the SCOPE block..
	s = scp->scp.loctb.head
    do while( s <> NULL )
    	'' variable?
    	if( s->class = FB_SYMBCLASS_VAR ) then
    		'' not shared or static (for locals)
    		if( (s->alloctype and (FB_ALLOCTYPE_SHARED or FB_ALLOCTYPE_STATIC)) = 0 ) then
                '' array?
				if( s->var.array.dims > 0 ) then
					'' dynamic?
					if( symbIsDynamic( s ) ) then
						rtlArrayErase( astNewVAR( s, NULL, 0, s->typ ) )
					'' array of dyn strings?
					elseif( s->typ = FB_SYMBTYPE_STRING ) then
						rtlArrayStrErase( s )
					end if

				'' dyn string?
				elseif( s->typ = FB_SYMBTYPE_STRING ) then
					strg = astNewVAR( s, NULL, 0, IR_DATATYPE_STRING )
					astAdd( rtlStrDelete( strg ) )
				end if
    		end if
    	end if

    	s = s->next
    loop

end sub

'':::::
sub symbDelScopeTb( byval scp as FBSYMBOL ptr ) static

    dim as FBSYMBOL ptr s

	'' for each symbol declared inside the SCOPE block..
	s = scp->scp.loctb.head
    do while( s <> NULL )
    	'' remove from hash only
    	hDelFromHash( s )

    	s = s->next
    loop

end sub

'':::::
function symbCheckLocalLabels(  ) as integer
    dim as FBSYMBOL ptr s
    dim as integer cnt

    cnt = 0

    s = ctx.symtb->head
    do while( s <> NULL )

    	if( s->class = FB_SYMBCLASS_LABEL ) then
    		if( not s->lbl.declared ) then
    			hReportErrorEx( FB_ERRMSG_UNDEFINEDLABEL, symbGetOrgName( s ), -1 )
    			cnt += 1
    		end if
    	end if

    	s = s->next
    loop

	function = cnt

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbGetLastLabel as FBSYMBOL ptr static

	function = ctx.lastlbl

end function

'':::::
sub symbSetLastLabel( byval l as FBSYMBOL ptr ) static

	ctx.lastlbl = l

end sub

'':::::
function symbCheckLabels( ) as integer
    dim as FBSYMBOL ptr s
    dim as integer cnt

	cnt = 0

    s = ctx.globtb.head
    do while( s <> NULL )
    	if( s->class = FB_SYMBCLASS_LABEL ) then
    		if( not s->lbl.declared ) then
    			hReportErrorEx( FB_ERRMSG_UNDEFINEDLABEL, symbGetOrgName( s ), -1 )
    			cnt += 1
    		end if
    	end if

    	s = s->next
    loop

	function = cnt

end function

'':::::
function hFindLib( byval libname as string, _
				   namelist() as string ) as integer
    dim i as integer

	function = INVALID

	for i = 0 to ubound( namelist ) - 1

		if( len( namelist(i) ) = 0 ) then
			exit function
		end if

		if( namelist(i) = libname ) then
			return i
		end if
	next i

end function

'':::::
function symbListLibs( namelist() as string, _
					   byval index as integer ) as integer static
    dim cnt as integer
    dim node as FBLIBRARY ptr

	cnt  = index

	node = ctx.liblist.head
	do while( node <> NULL )

		if( hFindLib( node->name, namelist() ) = INVALID ) then
			namelist(cnt) = node->name
			cnt += 1
		end if

		node = node->ll_nxt
	loop

	function = cnt - index

end function

'':::::
function symbIsEqual( byval sym1 as FBSYMBOL ptr, _
					  byval sym2 as FBSYMBOL ptr ) as integer

	dim as FBSYMBOL ptr argl, argr

	function = FALSE

	'' same?
	if( sym1 = sym2 ) then
		return TRUE
	end if

	'' NULL?
	if( (sym1 = NULL) or (sym2 = NULL) ) then
		exit function
	end if

	'' different classes?
    if( sym1->class <> sym2->class ) then
    	exit function
    end if

	'' different types?
    if( sym1->typ <> sym2->typ ) then
    	exit function
    end if

    select case sym1->class
    case FB_SYMBCLASS_UDT
    	''
    	if( sym1->udt.isunion <> sym2->udt.isunion ) then
    		exit function
    	end if

    	''
    	if( sym1->udt.elements <> sym2->udt.elements ) then
    		exit function
    	end if

    	''
    	if( sym1->udt.fldtb.head <> sym2->udt.fldtb.head ) then
    		exit function
    	end if

    	''
    	if( sym1->udt.fldtb.tail <> sym2->udt.fldtb.tail ) then
    		exit function
    	end if

    case FB_SYMBCLASS_PROC
    	'' check calling convention
    	if( symbGetFuncMode( sym1 ) <> symbGetFuncMode( sym2 ) ) then
    		exit function
    	end if

    	'' not the same number of args?
    	if( symbGetProcArgs( sym1 ) <> symbGetProcArgs( sym2 ) ) then

    		'' no args?
    		if( symbGetProcArgs( sym1 ) = 0 ) then
    			exit function
    		end if

    		'' not vararg?
    		if( symbGetProcTailArg( sym1 )->arg.mode <> FB_ARGMODE_VARARG ) then
    			exit function
    		end if

    		'' not enough args?
    		if( (symbGetProcArgs( sym2 ) - symbGetProcArgs( sym1 )) < -1 ) then
    			exit function
    		end if
    	end if

    	'' check each arg
    	argl = symbGetProcHeadArg( sym1 )
    	argr = symbGetProcHeadArg( sym2 )

    	do while( argl <> NULL )
            '' vararg?
            if( argl->arg.mode = FB_ARGMODE_VARARG ) then
            	exit do
            end if

    		'' mode?
    		if( argl->arg.mode <> argr->arg.mode ) then
            	exit function
    		end if

    		'' different types?
    		if( argl->typ <> argr->typ ) then
         		exit function
        	end if

        	'' sub-types?
        	if( argl->subtype <> argr->subtype ) then
            	exit function
			end if

    		'' next arg..
    		argl = argl->next
    		argr = argr->next
    	loop
    end select

	'' and sub type
	if( sym1->subtype <> sym2->subtype ) then
        function = symbIsEqual( sym1->subtype, sym2->subtype )
    else
    	function = TRUE
    end if

end function


