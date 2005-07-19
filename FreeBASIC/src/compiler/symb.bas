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

defint a-z
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
	loctb			as FBSYMBOLTB ptr

	liblist 		as TLIST					'' libraries
	libhash			as THASH

	dimlist			as TLIST					'' array dimensions
	defarglist		as TLIST					'' define arguments
	fwdlist			as TLIST					'' forward typedef refs

	lastlbl			as FBSYMBOL ptr

	fwdrefcnt 		as integer
	defargcnt		as integer
end type

declare sub			symbDelGlobalTb ( )

declare sub 		hFreeSymbol		( byval s as FBSYMBOL ptr, _
									  byval movetoglob as integer = FALSE )

declare function 	hCalcDiff		( byval dimensions as integer, _
									  dTB() as FBARRAYDIM, _
									  byval lgt as integer ) as integer

declare function 	hCalcElements2	( byval dimensions as integer, _
									  dTB() as FBARRAYDIM ) as integer

type DEFCALLBACK as function() as string

declare function	hDefFile_cb		( ) as string
declare function	hDefFunction_cb	( ) as string
declare function	hDefLine_cb		( ) as string
declare function	hDefDate_cb		( ) as string
declare function	hDefTime_cb		( ) as string


''globals
	dim shared ctx as SYMBCTX

'' predefined #defines: name, value, flags, proc
'' for description flags, see FBSDEFINE
definesdata:
data "__FB_VERSION__",			FB_VERSION,		  0, NULL
data "__FB_VER_MAJOR__",		FB_VER_STR_MAJOR, 1, NULL
data "__FB_VER_MINOR__",		FB_VER_STR_MINOR, 1, NULL
data "__FB_VER_PATCH__",		FB_VER_STR_PATCH, 1, NULL
data "__FB_SIGNATURE__",		FB_SIGN,		  0, NULL
data "__FILE__",				"",				  0, @hDefFile_cb
data "__FUNCTION__",			"",				  0, @hDefFunction_cb
data "__LINE__",				"",				  1, @hDefLine_cb
data "__DATE__",				"",				  0, @hDefDate_cb
data "__TIME__",				"",				  0, @hDefTime_cb
data ""


'' keywords: name, id (token), class
keyworddata:
data "AND"		, FB_TK_AND			, FB_TKCLASS_OPERATOR
data "OR"		, FB_TK_OR			, FB_TKCLASS_OPERATOR
data "XOR"		, FB_TK_XOR			, FB_TKCLASS_OPERATOR
data "EQV"		, FB_TK_EQV			, FB_TKCLASS_OPERATOR
data "IMP"		, FB_TK_IMP			, FB_TKCLASS_OPERATOR
data "NOT"		, FB_TK_NOT			, FB_TKCLASS_OPERATOR
data "MOD"		, FB_TK_MOD			, FB_TKCLASS_OPERATOR
data "SHL"		, FB_TK_SHL			, FB_TKCLASS_OPERATOR
data "SHR"		, FB_TK_SHR			, FB_TKCLASS_OPERATOR
data "REM"		, FB_TK_REM			, FB_TKCLASS_KEYWORD
data "DIM"		, FB_TK_DIM			, FB_TKCLASS_KEYWORD
data "STATIC"	, FB_TK_STATIC		, FB_TKCLASS_KEYWORD
data "SHARED"	, FB_TK_SHARED		, FB_TKCLASS_KEYWORD
data "INTEGER"	, FB_TK_INTEGER		, FB_TKCLASS_KEYWORD
data "LONG"		, FB_TK_LONG		, FB_TKCLASS_KEYWORD
data "SINGLE"	, FB_TK_SINGLE		, FB_TKCLASS_KEYWORD
data "DOUBLE"	, FB_TK_DOUBLE		, FB_TKCLASS_KEYWORD
data "STRING"	, FB_TK_STRING		, FB_TKCLASS_KEYWORD
data "CALL"		, FB_TK_CALL		, FB_TKCLASS_KEYWORD
data "BYVAL"	, FB_TK_BYVAL		, FB_TKCLASS_KEYWORD
data "INCLUDE"	, FB_TK_INCLUDE		, FB_TKCLASS_KEYWORD
data "DYNAMIC"	, FB_TK_DYNAMIC		, FB_TKCLASS_KEYWORD
data "AS"		, FB_TK_AS			, FB_TKCLASS_KEYWORD
data "DECLARE"	, FB_TK_DECLARE		, FB_TKCLASS_KEYWORD
data "GOTO"		, FB_TK_GOTO		, FB_TKCLASS_KEYWORD
data "GOSUB"	, FB_TK_GOSUB		, FB_TKCLASS_KEYWORD
data "DEFBYTE"	, FB_TK_DEFBYTE		, FB_TKCLASS_KEYWORD
data "DEFUBYTE"	, FB_TK_DEFUBYTE	, FB_TKCLASS_KEYWORD
data "DEFSHORT"	, FB_TK_DEFSHORT	, FB_TKCLASS_KEYWORD
data "DEFUSHORT", FB_TK_DEFUSHORT	, FB_TKCLASS_KEYWORD
data "DEFINT"	, FB_TK_DEFINT		, FB_TKCLASS_KEYWORD
data "DEFUINT"	, FB_TK_DEFUINT		, FB_TKCLASS_KEYWORD
data "DEFLNG"	, FB_TK_DEFLNG		, FB_TKCLASS_KEYWORD
data "DEFLONGINT", FB_TK_DEFLNGINT	, FB_TKCLASS_KEYWORD
data "DEFULONGINT", FB_TK_DEFULNGINT, FB_TKCLASS_KEYWORD
data "DEFSNG"	, FB_TK_DEFSNG		, FB_TKCLASS_KEYWORD
data "DEFDBL"	, FB_TK_DEFDBL		, FB_TKCLASS_KEYWORD
data "DEFSTR"	, FB_TK_DEFSTR		, FB_TKCLASS_KEYWORD
data "CONST"	, FB_TK_CONST		, FB_TKCLASS_KEYWORD
data "FOR"		, FB_TK_FOR			, FB_TKCLASS_KEYWORD
data "STEP"		, FB_TK_STEP		, FB_TKCLASS_KEYWORD
data "NEXT"		, FB_TK_NEXT		, FB_TKCLASS_KEYWORD
data "TO"		, FB_TK_TO			, FB_TKCLASS_KEYWORD
data "TYPE"		, FB_TK_TYPE		, FB_TKCLASS_KEYWORD
data "END"		, FB_TK_END			, FB_TKCLASS_KEYWORD
data "SUB"		, FB_TK_SUB			, FB_TKCLASS_KEYWORD
data "FUNCTION"	, FB_TK_FUNCTION	, FB_TKCLASS_KEYWORD
data "CDECL"	, FB_TK_CDECL		, FB_TKCLASS_KEYWORD
data "STDCALL"	, FB_TK_STDCALL		, FB_TKCLASS_KEYWORD
data "ALIAS"	, FB_TK_ALIAS		, FB_TKCLASS_KEYWORD
data "LIB"		, FB_TK_LIB			, FB_TKCLASS_KEYWORD
data "LET"		, FB_TK_LET			, FB_TKCLASS_KEYWORD
data "BYTE"		, FB_TK_BYTE		, FB_TKCLASS_KEYWORD
data "UBYTE"	, FB_TK_UBYTE		, FB_TKCLASS_KEYWORD
data "SHORT"	, FB_TK_SHORT		, FB_TKCLASS_KEYWORD
data "USHORT"	, FB_TK_USHORT		, FB_TKCLASS_KEYWORD
data "UINTEGER"	, FB_TK_UINT		, FB_TKCLASS_KEYWORD
data "EXIT"		, FB_TK_EXIT		, FB_TKCLASS_KEYWORD
data "DO"		, FB_TK_DO			, FB_TKCLASS_KEYWORD
data "LOOP"		, FB_TK_LOOP		, FB_TKCLASS_KEYWORD
data "RETURN"	, FB_TK_RETURN		, FB_TKCLASS_KEYWORD
data "ANY"		, FB_TK_ANY			, FB_TKCLASS_KEYWORD
data "PTR"		, FB_TK_PTR			, FB_TKCLASS_KEYWORD
data "POINTER"	, FB_TK_POINTER		, FB_TKCLASS_KEYWORD
data "VARPTR"	, FB_TK_VARPTR		, FB_TKCLASS_KEYWORD
data "WHILE"	, FB_TK_WHILE		, FB_TKCLASS_KEYWORD
data "UNTIL"	, FB_TK_UNTIL		, FB_TKCLASS_KEYWORD
data "WEND"		, FB_TK_WEND		, FB_TKCLASS_KEYWORD
data "CONTINUE"	, FB_TK_CONTINUE	, FB_TKCLASS_KEYWORD
data "CBYTE"	, FB_TK_CBYTE		, FB_TKCLASS_KEYWORD
data "CSHORT"	, FB_TK_CSHORT		, FB_TKCLASS_KEYWORD
data "CINT"		, FB_TK_CINT		, FB_TKCLASS_KEYWORD
data "CLNG"		, FB_TK_CLNG		, FB_TKCLASS_KEYWORD
data "CLNGINT"	, FB_TK_CLNGINT		, FB_TKCLASS_KEYWORD
data "CUBYTE"	, FB_TK_CUBYTE		, FB_TKCLASS_KEYWORD
data "CUSHORT"	, FB_TK_CUSHORT		, FB_TKCLASS_KEYWORD
data "CUINT"	, FB_TK_CUINT		, FB_TKCLASS_KEYWORD
data "CULNGINT"	, FB_TK_CULNGINT	, FB_TKCLASS_KEYWORD
data "CSNG"		, FB_TK_CSNG		, FB_TKCLASS_KEYWORD
data "CDBL"		, FB_TK_CDBL		, FB_TKCLASS_KEYWORD
data "CSIGN"	, FB_TK_CSIGN		, FB_TKCLASS_KEYWORD
data "CUNSG"	, FB_TK_CUNSG		, FB_TKCLASS_KEYWORD
data "CPTR"		, FB_TK_CPTR		, FB_TKCLASS_KEYWORD
data "IF"		, FB_TK_IF			, FB_TKCLASS_KEYWORD
data "THEN"		, FB_TK_THEN		, FB_TKCLASS_KEYWORD
data "ELSE"		, FB_TK_ELSE		, FB_TKCLASS_KEYWORD
data "ELSEIF"	, FB_TK_ELSEIF		, FB_TKCLASS_KEYWORD
data "SELECT"	, FB_TK_SELECT		, FB_TKCLASS_KEYWORD
data "CASE"		, FB_TK_CASE		, FB_TKCLASS_KEYWORD
data "IS"		, FB_TK_IS			, FB_TKCLASS_KEYWORD
data "UNSIGNED"	, FB_TK_UNSIGNED	, FB_TKCLASS_KEYWORD
data "REDIM"	, FB_TK_REDIM		, FB_TKCLASS_KEYWORD
data "ERASE"	, FB_TK_ERASE		, FB_TKCLASS_KEYWORD
data "LBOUND"	, FB_TK_LBOUND		, FB_TKCLASS_KEYWORD
data "UBOUND"	, FB_TK_UBOUND		, FB_TKCLASS_KEYWORD
data "UNION"	, FB_TK_UNION		, FB_TKCLASS_KEYWORD
data "PUBLIC"	, FB_TK_PUBLIC		, FB_TKCLASS_KEYWORD
data "PRIVATE"	, FB_TK_PRIVATE		, FB_TKCLASS_KEYWORD
data "STR"		, FB_TK_STR			, FB_TKCLASS_KEYWORD
data "MID"		, FB_TK_MID			, FB_TKCLASS_KEYWORD
data "BYREF"	, FB_TK_BYREF		, FB_TKCLASS_KEYWORD
data "OPTION"	, FB_TK_OPTION		, FB_TKCLASS_KEYWORD
data "BASE"		, FB_TK_BASE		, FB_TKCLASS_KEYWORD
data "EXPLICIT"	, FB_TK_EXPLICIT	, FB_TKCLASS_KEYWORD
data "PASCAL"	, FB_TK_PASCAL		, FB_TKCLASS_KEYWORD
data "PROCPTR"	, FB_TK_PROCPTR		, FB_TKCLASS_KEYWORD
data "SADD"		, FB_TK_SADD		, FB_TKCLASS_KEYWORD
data "RESTORE"	, FB_TK_RESTORE		, FB_TKCLASS_KEYWORD
data "READ"		, FB_TK_READ		, FB_TKCLASS_KEYWORD
data "DATA"		, FB_TK_DATA		, FB_TKCLASS_KEYWORD
data "ABS"		, FB_TK_ABS			, FB_TKCLASS_KEYWORD
data "SGN"		, FB_TK_SGN			, FB_TKCLASS_KEYWORD
data "FIX"		, FB_TK_FIX			, FB_TKCLASS_KEYWORD
data "PRINT"	, FB_TK_PRINT		, FB_TKCLASS_KEYWORD
data "USING"	, FB_TK_USING		, FB_TKCLASS_KEYWORD
data "LEN"		, FB_TK_LEN			, FB_TKCLASS_KEYWORD
data "PEEK"		, FB_TK_PEEK		, FB_TKCLASS_KEYWORD
data "POKE"		, FB_TK_POKE		, FB_TKCLASS_KEYWORD
data "SWAP"		, FB_TK_SWAP		, FB_TKCLASS_KEYWORD
data "COMMON"	, FB_TK_COMMON		, FB_TKCLASS_KEYWORD
data "OPEN"		, FB_TK_OPEN		, FB_TKCLASS_KEYWORD
data "CLOSE"	, FB_TK_CLOSE		, FB_TKCLASS_KEYWORD
data "SEEK"		, FB_TK_SEEK		, FB_TKCLASS_KEYWORD
data "PUT"		, FB_TK_PUT			, FB_TKCLASS_KEYWORD
data "GET"		, FB_TK_GET			, FB_TKCLASS_KEYWORD
data "ACCESS"	, FB_TK_ACCESS		, FB_TKCLASS_KEYWORD
data "WRITE"	, FB_TK_WRITE		, FB_TKCLASS_KEYWORD
data "LOCK"		, FB_TK_LOCK		, FB_TKCLASS_KEYWORD
data "INPUT"	, FB_TK_INPUT		, FB_TKCLASS_KEYWORD
data "OUTPUT"	, FB_TK_OUTPUT		, FB_TKCLASS_KEYWORD
data "BINARY"	, FB_TK_BINARY		, FB_TKCLASS_KEYWORD
data "RANDOM"	, FB_TK_RANDOM		, FB_TKCLASS_KEYWORD
data "APPEND"	, FB_TK_APPEND		, FB_TKCLASS_KEYWORD
data "NAME"		, FB_TK_NAME		, FB_TKCLASS_KEYWORD
data "PRESERVE"	, FB_TK_PRESERVE	, FB_TKCLASS_KEYWORD
data "ON"		, FB_TK_ON			, FB_TKCLASS_KEYWORD
data "ERROR"	, FB_TK_ERROR		, FB_TKCLASS_KEYWORD
data "ENUM"		, FB_TK_ENUM		, FB_TKCLASS_KEYWORD
data "INCLIB"	, FB_TK_INCLIB		, FB_TKCLASS_KEYWORD
data "ASM"		, FB_TK_ASM			, FB_TKCLASS_KEYWORD
data "SPC"		, FB_TK_SPC			, FB_TKCLASS_KEYWORD
data "TAB"		, FB_TK_TAB			, FB_TKCLASS_KEYWORD
data "LINE"		, FB_TK_LINE		, FB_TKCLASS_KEYWORD
data "VIEW"		, FB_TK_VIEW		, FB_TKCLASS_KEYWORD
data "UNLOCK"	, FB_TK_UNLOCK		, FB_TKCLASS_KEYWORD
data "FIELD"	, FB_TK_FIELD		, FB_TKCLASS_KEYWORD
data "LOCAL"	, FB_TK_LOCAL		, FB_TKCLASS_KEYWORD
data "ERR"		, FB_TK_ERR			, FB_TKCLASS_KEYWORD
data "DEFINE"	, FB_TK_DEFINE		, FB_TKCLASS_KEYWORD
data "UNDEF"	, FB_TK_UNDEF		, FB_TKCLASS_KEYWORD
data "IFDEF"	, FB_TK_IFDEF		, FB_TKCLASS_KEYWORD
data "IFNDEF"	, FB_TK_IFNDEF		, FB_TKCLASS_KEYWORD
data "ENDIF"	, FB_TK_ENDIF		, FB_TKCLASS_KEYWORD
data "DEFINED"	, FB_TK_DEFINED		, FB_TKCLASS_KEYWORD
data "RESUME"	, FB_TK_RESUME		, FB_TKCLASS_KEYWORD
data "PSET"		, FB_TK_PSET		, FB_TKCLASS_KEYWORD
data "PRESET"	, FB_TK_PRESET		, FB_TKCLASS_KEYWORD
data "POINT"	, FB_TK_POINT		, FB_TKCLASS_KEYWORD
data "CIRCLE"	, FB_TK_CIRCLE		, FB_TKCLASS_KEYWORD
data "WINDOW"	, FB_TK_WINDOW		, FB_TKCLASS_KEYWORD
data "PALETTE"	, FB_TK_PALETTE		, FB_TKCLASS_KEYWORD
data "SCREEN"	, FB_TK_SCREEN		, FB_TKCLASS_KEYWORD
data "SCREENRES", FB_TK_SCREENRES	, FB_TKCLASS_KEYWORD
data "PAINT"	, FB_TK_PAINT		, FB_TKCLASS_KEYWORD
data "DRAW"		, FB_TK_DRAW		, FB_TKCLASS_KEYWORD
data "EXTERN"	, FB_TK_EXTERN		, FB_TKCLASS_KEYWORD
data "STRPTR"	, FB_TK_STRPTR		, FB_TKCLASS_KEYWORD
data "WITH"		, FB_TK_WITH		, FB_TKCLASS_KEYWORD
data "EXPORT"	, FB_TK_EXPORT		, FB_TKCLASS_KEYWORD
data "IMPORT"	, FB_TK_IMPORT		, FB_TKCLASS_KEYWORD
data "LIBPATH"	, FB_TK_LIBPATH		, FB_TKCLASS_KEYWORD
data "CHR"		, FB_TK_CHR			, FB_TKCLASS_KEYWORD
data "ASC"		, FB_TK_ASC			, FB_TKCLASS_KEYWORD
data "LSET"		, FB_TK_LSET		, FB_TKCLASS_KEYWORD
data "IIF"		, FB_TK_IIF			, FB_TKCLASS_KEYWORD
data "..."		, FB_TK_VARARG		, FB_TKCLASS_KEYWORD
data "VA_FIRST"	, FB_TK_VA_FIRST	, FB_TKCLASS_KEYWORD
data "LONGINT"	, FB_TK_LONGINT		, FB_TKCLASS_KEYWORD
data "ULONGINT" , FB_TK_ULONGINT	, FB_TKCLASS_KEYWORD
data "ZSTRING"	, FB_TK_ZSTRING		, FB_TKCLASS_KEYWORD
data "SIZEOF"	, FB_TK_SIZEOF		, FB_TKCLASS_KEYWORD
data "SIN"		, FB_TK_SIN			, FB_TKCLASS_KEYWORD
data "ASIN"		, FB_TK_ASIN		, FB_TKCLASS_KEYWORD
data "COS"		, FB_TK_COS			, FB_TKCLASS_KEYWORD
data "ACOS"		, FB_TK_ACOS		, FB_TKCLASS_KEYWORD
data "TAN"		, FB_TK_TAN			, FB_TKCLASS_KEYWORD
data "ATN"		, FB_TK_ATN			, FB_TKCLASS_KEYWORD
data "SQR"		, FB_TK_SQR			, FB_TKCLASS_KEYWORD
data "LOG"		, FB_TK_LOG			, FB_TKCLASS_KEYWORD
data "INT"		, FB_TK_INT			, FB_TKCLASS_KEYWORD
data "ATAN2"	, FB_TK_ATAN2		, FB_TKCLASS_KEYWORD
data "OVERLOAD"	, FB_TK_OVERLOAD	, FB_TKCLASS_KEYWORD
data "CONSTRUCTOR", FB_TK_CONSTRUCTOR, FB_TKCLASS_KEYWORD
data "DESTRUCTOR", FB_TK_DESTRUCTOR	, FB_TKCLASS_KEYWORD
data ""


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
sub symbInitDefines static
	dim as string def, value
    dim as integer flags
	dim as DEFCALLBACK proc

    listNew( @ctx.defarglist, FB_INITDEFARGNODES, len( FBDEFARG ), FALSE )

    ctx.defargcnt = 0

    restore definesdata
    do
    	read def
    	if( len( def ) = 0 ) then
    		exit do
    	end if

    	read value
        read flags
    	read proc

    	if( value <> "" ) then
            if( not bit( flags, 0 ) )then
    			value = "\"" + value + "\""
            end if
    	end if

    	symbAddDefine( def, value, len( value ), 0, NULL, FALSE, proc, flags )
    loop

	''
	select case as const env.clopt.target
	case FB_COMPTARGET_WIN32
		def = "__FB_WIN32__"
	case FB_COMPTARGET_LINUX
		def = "__FB_LINUX__"
	case FB_COMPTARGET_DOS
		def = "__FB_DOS__"
	case FB_COMPTARGET_XBOX
		def = "__FB_XBOX__"
	end select

	symbAddDefine( def, "", 0, 0, NULL, FALSE, NULL, 0 )

end sub

'':::::
sub symbInitKeywords static
	dim as string kname
	dim as integer id, class

	restore keyworddata
	do
    	read kname
    	if( len( kname ) = 0 ) then
    		exit do
    	end if
    	read id, class
    	if( symbAddKeyword( kname, id, class ) = NULL ) then
    		exit sub
    	end if
    loop

end sub

'':::::
sub symbInit

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
	symbInitDefines( )

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

    ''
	hashFree( @ctx.libhash )

    hashFree( @ctx.symhash )

	''
	listFree( @ctx.liblist )

	listFree( @ctx.dimlist )

	listFree( @ctx.fwdlist )

	listFree( @ctx.defarglist )

	listFree( @ctx.symlist )

	''
	ctx.inited = FALSE

end sub

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
		typ 	= FB_SYMBTYPE_UINT
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
function hNewSymbol( byval class as integer, _
					 byval dohash as integer = TRUE, _
					 byval symbol as string, _
					 byval aliasname as string, _
					 byval islocal as integer = FALSE, _
					 byval typ as integer = INVALID, _
					 byval subtype as FBSYMBOL ptr = NULL, _
					 byval ptrcnt as integer = 0, _
					 byval suffix as integer = INVALID, _
					 byval preservecase as integer = FALSE ) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr s, n
    dim as integer slen
    dim as FBSYMBOLTB ptr tb

    function = NULL

    s = listNewNode( @ctx.symlist )
    if( s = NULL ) then
    	exit function
    end if

    ''
    s->class		= class
    s->scope		= iif( islocal, 1, 0 )
    s->typ			= typ
    s->subtype		= subtype
    s->ptrcnt		= ptrcnt

	s->alloctype	= 0
    s->lgt			= 0
    s->ofs			= 0

    if( class = FB_SYMBCLASS_VAR ) then
    	s->var.suffix = suffix
    	s->var.emited = FALSE
    end if

    ''
    ZEROSTRDESC( s->name )
    slen = len( symbol )
    if( slen > 0 ) then
    	if( not preservecase ) then
    		s->name = ucase( symbol )
    	else
    	    s->name = symbol
		end if
    else
    	dohash = FALSE
    end if

    ZEROSTRDESC( s->alias )
    if( len( aliasname ) > 0 ) then
    	s->alias = aliasname
    else
    	if( slen > 0 ) then
    		s->alias = s->name
    	end if
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
				listDelNode( @ctx.symlist, cptr( TLISTNODE ptr, s ) )

				exit function
			end if

			s->hashitem  = n->hashitem
			s->hashindex = n->hashindex

			if( not islocal ) then
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

	'' add to symbol table (local or global)
	if( not islocal ) then
		tb = @ctx.globtb
	else
		tb = ctx.loctb
	end if

	if( tb->tail <> NULL ) then
		tb->tail->next = s
	else
		tb->head = s
	end if

	s->prev = tb->tail
	s->next = NULL
	tb->tail = s

    ''
    function = s

end function

'':::::
function symbAddKeyword( byval symbol as string, _
						 byval id as integer, _
						 byval class as integer ) as FBSYMBOL ptr
    dim k as FBSYMBOL ptr

    k = hNewSymbol( FB_SYMBCLASS_KEYWORD, TRUE, symbol, "" )
    if( k = NULL ) then
    	return NULL
    end if

    ''
    k->key.id		= id
    k->key.class	= class

    function = k

end function

'':::::
function symbAddDefine( byval symbol as string, _
						byval text as string, _
						byval lgt as integer, _
						byval args as integer = 0, _
						byval arghead as FBDEFARG ptr = NULL, _
						byval isargless as integer = FALSE, _
						byval proc as function( ) as string = NULL, _
                        byval flags as integer = 0) as FBSYMBOL ptr static
    dim d as FBSYMBOL ptr

    function = NULL

    '' allocate new node
    d = hNewSymbol( FB_SYMBCLASS_DEFINE, TRUE, symbol, "", env.scope > 0 )
    if( d = NULL ) then
    	exit function
    end if

	''
	ZEROSTRDESC( d->def.text )
	d->def.text 	= text
	d->lgt			= lgt
	d->def.args		= args
	d->def.arghead	= arghead
	d->def.isargless= isargless
	d->def.proc     = proc
    d->def.flags    = flags

	''
	function = d

end function

'':::::
function symbAddDefineArg( byval lastarg as FBDEFARG ptr, _
						   byval symbol as string ) as FBDEFARG ptr static
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
    a->name 	= ucase( symbol )
    a->next		= NULL
    a->id		= ctx.defargcnt
    ctx.defargcnt += 1

    function = a

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
function symbAddTypedef( byval symbol as string, _
						 byval typ as integer, _
						 byval subtype as FBSYMBOL ptr, _
						 byval ptrcnt as integer, _
						 byval lgt as integer ) as FBSYMBOL ptr static
    dim as FBSYMBOL ptr t

    function = NULL

    '' allocate new node
    t = hNewSymbol( FB_SYMBCLASS_TYPEDEF, TRUE, symbol, "", env.scope > 0, typ, subtype, ptrcnt )
    if( t = NULL ) then
    	exit function
    end if

	''
	t->lgt 	= lgt
	t->dbg.typenum = INVALID

	'' check for forward references
	if( ctx.fwdrefcnt > 0 ) then
		hCheckFwdRef( t, FB_SYMBCLASS_TYPEDEF )
	end if

	''
	function = t

end function

'':::::
function symbAddFwdRef( byval symbol as string ) as FBSYMBOL ptr static
    dim f as FBSYMBOL ptr

    function = NULL

    '' allocate new node
    f = hNewSymbol( FB_SYMBCLASS_FWDREF, TRUE, symbol, "", env.scope > 0 )
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

	if( (iscommon) or (ispubext and isdynamic) ) then
		sname = symbGetName( s )
	else
		sname = *hMakeTmpStr( )
	end if

	if( (env.scope = 0) or (isshared) or (isstatic) ) then
		aname = sname
		ofs = 0
	else
		lgt = FB_ARRAYDESCSIZE + dimensions * (FB_INTEGERSIZE+FB_INTEGERSIZE)
		aname = *emitAllocLocal( env.currproc, lgt, ofs )
	end if

	d = hNewSymbol( FB_SYMBCLASS_VAR, FALSE, "", aname, (env.scope > 0) and (not isshared), _
					FB_SYMBTYPE_USERDEF, cptr( FBSYMBOL ptr, FB_DESCTYPE_ARRAY ), 0 )
    if( d = NULL ) then
    	exit function
    end if

	''
	if( isshared ) then
		d->alloctype	= FB_ALLOCTYPE_SHARED
	elseif( isstatic ) then
		d->alloctype	= FB_ALLOCTYPE_STATIC
	else
		d->alloctype	= 0
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
			   		   byval symbol as string, _
			   		   byval aname as string, _
			   		   byval typ as integer, _
			   		   byval subtype as FBSYMBOL ptr, _
			   		   byval lgt as integer, _
			   		   byval ofs as integer, _
			   		   byval dimensions as integer, _
			   		   dTB() as FBARRAYDIM, _
			   		   byval alloctype as integer ) static

	if( typ = INVALID ) then
		typ = hGetDefType( symbol )
	end if

	''
	s->alloctype= alloctype
	s->acccnt 	= 0

	s->lgt		= lgt
	s->ofs		= ofs

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
function symbAddVarEx( byval symbol as string, _
					   byval aliasname as string, _
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

    static as zstring * FB_MAXINTNAMELEN+1 aname
    dim as FBSYMBOL ptr s
    dim as integer elms, suffix, arglen
    dim as integer isshared, isstatic, ispublic, isextern
    dim as integer isarg, islocal, ofs

    function = NULL

    ''
    isshared = (alloctype and FB_ALLOCTYPE_SHARED) > 0
    isstatic = (alloctype and FB_ALLOCTYPE_STATIC) > 0
    ispublic = (alloctype and FB_ALLOCTYPE_PUBLIC) > 0
    isextern = (alloctype and FB_ALLOCTYPE_EXTERN) > 0
    isarg    = (alloctype and (FB_ALLOCTYPE_ARGUMENTBYDESC or _
    						   FB_ALLOCTYPE_ARGUMENTBYVAL or _
    						   FB_ALLOCTYPE_ARGUMENTBYREF)) > 0
	islocal  = FALSE

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
    ofs = 0

	'' create an alias name (the real one that will be emited)
	if( len( aliasname ) > 0 ) then
		aname = aliasname

	else
		if( (not isshared) and (isstatic) ) then
			aname = *hMakeTmpStr( )

		else
			if( (ispublic) or (isextern) ) then
			    aname = *hCreateName( symbol, suffix, preservecase, _
			    					  TRUE, clearname )

			elseif( (isshared) or (env.scope = 0) ) then
				aname = *hCreateName( symbol, suffix, preservecase, _
									  TRUE, clearname )

			else
				if( not isarg ) then
					elms = hCalcElements2( dimensions, dTB() )
					aname = *emitAllocLocal( env.currproc, lgt * elms, ofs )
					islocal = TRUE

				else
        			if( alloctype = FB_ALLOCTYPE_ARGUMENTBYVAL ) then
        				arglen = lgt
        			else
        				arglen = FB_POINTERSIZE
        			end if
					aname = *emitAllocArg( env.currproc, arglen, ofs )
				end if
			end if
		end if
	end if

	''
	s = hNewSymbol( FB_SYMBCLASS_VAR, TRUE, symbol, aname, _
					(env.scope > 0) and (not isshared), _
					typ, subtype, ptrcnt, suffix, preservecase )

	if( s = NULL ) then
		'' remove a local or arg or else emit will reserve unused space for it..
		if( islocal ) then
			emitFreeLocal( env.currproc, lgt * elms )
		elseif( isarg ) then
			emitFreeArg( env.currproc, arglen )
		end if

		exit function
	end if

	''
	hSetupVar( s, symbol, aname, typ, subtype, lgt, _
			   ofs, dimensions, dTB(), alloctype )

	function = s

end function

'':::::
function symbAddVar( byval symbol as string, _
					 byval typ as integer, _
					 byval subtype as FBSYMBOL ptr, _
				     byval ptrcnt as integer, _
				     byval dimensions as integer, _
				     dTB() as FBARRAYDIM, _
				     byval alloctype as integer ) as FBSYMBOL ptr static

    function = symbAddVarEx( symbol, "", typ, subtype, ptrcnt, _
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

	sname = *hMakeTmpStr( )

	alloctype = FB_ALLOCTYPE_TEMP
	if( env.scope > 0 ) then
		if( env.isprocstatic ) then
			alloctype or= FB_ALLOCTYPE_STATIC
		end if
	end if

	function = symbAddVarEx( sname, "", typ, subtype, 0, _
							 0, 0, dTB(), _
							 alloctype, _
							 FALSE, FALSE, FALSE )

end function

'':::::
function hAllocNumericConst( byval sname as string, _
							 byval typ as integer ) as FBSYMBOL ptr static

    static as zstring * FB_MAXINTNAMELEN+1 cname, aname
	dim as FBSYMBOL ptr s
	dim as FBARRAYDIM dTB(0)
    dim as integer p

	function = NULL

	cname = "{fbnc}"
	cname += sname

	s = symbFindByNameAndSuffix( cname, typ, FALSE )
	if( s <> NULL ) then
		return s
	end if

	aname = *hMakeTmpStr( )

	s = symbAddVarEx( cname, aname, typ, NULL, 0, 0, 0, dTB(), _
					  FB_ALLOCTYPE_SHARED, TRUE, FALSE, FALSE )

	''
	s->var.initialized = TRUE

	if( typ = FB_SYMBTYPE_DOUBLE ) then
		p = instr( sname, "D" )
		if( p <> 0 ) then
			sname[p-1] = asc( "E" )
		end if
	end if

	ZEROSTRDESC( s->var.inittext )
	s->var.inittext	= sname

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
		cname = *hMakeTmpStr( )
	end if

	''
	s = symbFindByNameAndClass( cname, FB_SYMBCLASS_VAR, TRUE )
	if( s <> NULL ) then
		return s 's->var.array.desc
	end if

	aname = *hMakeTmpStr( )

	'' plus the null-char as rtlib wrappers will take it into account
	lgt += 1

	s = symbAddVarEx( cname, aname, FB_SYMBTYPE_FIXSTR, NULL, 0, lgt, 0, dTB(), _
					  FB_ALLOCTYPE_SHARED, FALSE, TRUE, FALSE )

	''
	s->var.initialized = TRUE

	ZEROSTRDESC( s->var.inittext )
	s->var.inittext = sname

	'' can't fake a descriptor as the literal string passed to user procs can be modified/reused
	's->var.array.desc = hCreateStringDesc( s )

	function = s 's->var.array.desc

end function

'':::::
function symbAddConst( byval symbol as string, _
					   byval typ as integer, _
					   byval subtype as FBSYMBOL ptr, _
					   byval text as string, _
					   byval lgt as integer ) as FBSYMBOL ptr static
    dim c as FBSYMBOL ptr

    function = NULL

    ''
    c = hNewSymbol( FB_SYMBCLASS_CONST, TRUE, symbol, "", env.scope > 0, typ, subtype )
	if( c = NULL ) then
		exit function
	end if

	c->lgt		= lgt
	ZEROSTRDESC( c->con.text )
	c->con.text	= text

	function = c

end function

'':::::
function symbAddLabel( byval symbol as string, _
					   byval declaring as integer = TRUE, _
					   byval createalias as integer = FALSE ) as FBSYMBOL ptr static

    dim as zstring ptr lname, aname
    dim as FBSYMBOL ptr l

    function = NULL

    if( len( symbol ) > 0 ) then
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
    		aname = strptr( symbol )
		else
			aname = hMakeTmpStr( )
		end if

		lname = strptr( symbol )

	else
		lname = hMakeTmpStr( )
		aname = lname
	end if

    l = hNewSymbol( FB_SYMBCLASS_LABEL, TRUE, lname, aname, env.scope > 0 )
    if( l = NULL ) then
    	exit function
    end if

	l->lbl.declared = declaring

	function = l

end function


'':::::
function symbAddUDT( byval symbol as string, _
					 byval isunion as integer, _
					 byval align as integer ) as FBSYMBOL ptr static
    dim t as FBSYMBOL ptr

    function = NULL

    t = hNewSymbol( FB_SYMBCLASS_UDT, TRUE, symbol, "", env.scope > 0 )
	if( t = NULL ) then
		exit function
	end if

	t->udt.isunion	= isunion
	t->udt.elements	= 0
	t->udt.head 	= NULL
	t->udt.tail 	= NULL
	t->udt.ofs		= 0
	t->udt.align	= align
	t->udt.lfldlen	= 0
	t->udt.innerlgt	= 0
	t->udt.bitpos	= 0

	t->dbg.typenum	= INVALID

	function = t

end function

'':::::
function hCalcALign( byval lgt as integer, _
					 byval ofs as integer, _
					 byval align as integer, _
					 byval typ as integer, _
					 byval subtype as FBSYMBOL ptr ) as integer static
    dim pad as integer
    dim e as FBSYMBOL ptr

	function = 0

	if( align <= 1 ) then
		exit function
	end if

	'' if field is another UDT, loop until a non-UDT header field is found
	if( typ = FB_SYMBTYPE_USERDEF ) then
		do
			e = subtype->udt.head
    		typ = e->typ
    		subtype = e->subtype
		loop while( typ = FB_SYMBTYPE_USERDEF )

		lgt = e->lgt

		'' len = field's len + pad from current field to the next field, if any
		e = e->var.elm.next
		if( e <> NULL ) then
			lgt += (e->var.elm.ofs - lgt)
		end if
	end if

	select case typ
	'' don't align strings
	case FB_SYMBTYPE_CHAR, FB_SYMBTYPE_FIXSTR

	case else
		select case as const lgt
		'' align byte, short, int's, float's and double's to the nearest boundary
		case 1, 2, 4, 8
			pad = lgt - 1

		'' anything else to align given (default: sizeof( int ))
		case else
			pad = align - 1
			lgt = align
		end select

		if( pad > 0 ) then
			function = (lgt - (ofs and pad)) mod lgt
		end if

	end select

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
							byval elmname as string, _
						    byval dimensions as integer, _
						    dTB() as FBARRAYDIM, _
						    byval typ as integer, _
						    byval subtype as FBSYMBOL ptr, _
						    byval ptrcnt as integer, _
						    byval lgt as integer, _
						    byval bits as integer, _
						    byval isinner as integer ) as FBSYMBOL ptr static

    static as zstring * FB_MAXINTNAMELEN+1 ename
    dim as FBSYMBOL ptr e, tail
    dim as integer align, i, updateudt

    function = NULL

    hUcase( elmname, ename )

    '' check if element already exists in the current struct
    e = t->udt.head
    do while( e <> NULL )

    	if( e->alias = ename ) then
    		exit function
    	end if

    	'' next
    	e = e->var.elm.next
    loop

	tail = t->udt.tail

    '' calc length if it wasn't given or if it's a scalar UDT
    '' field (the packed len w/o padding is needed); for array of UDT's
    '' fields, the padded len will be used to be GCC 3.x compatible
	if( (lgt <= 0) or _
		((typ = FB_SYMBTYPE_USERDEF) and (dimensions = 0)) ) then
		lgt	= symbCalcLen( typ, subtype, TRUE )
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
    e = hNewSymbol( FB_SYMBCLASS_UDTELM, FALSE, ename, "", FALSE, typ, subtype, ptrcnt )
    if( e = NULL ) then
    	exit function
    end if

	'' add to parent's linked-list
	e->var.elm.prev 	= tail
	e->var.elm.next		= NULL
    e->var.elm.parent	= t
	t->udt.tail 		= e
	if( tail <> NULL ) then
		tail->var.elm.next = e
	else
		t->udt.head 	= e
	end if

    t->udt.elements	+= 1

	''
	if( updateudt ) then
		align = hCalcALign( lgt, t->udt.ofs, t->udt.align, typ, subtype )
		if( align > 0 ) then
			t->udt.ofs += align
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
		next i
	end if

	e->var.array.elms 	= hCalcElements( e )

	'' update UDT length
	lgt *= e->var.array.elms

	if( updateudt ) then
		if( not t->udt.isunion ) then
			if( not isinner ) then
				t->udt.ofs += lgt
				t->lgt = t->udt.ofs
			else
				if( lgt > t->udt.innerlgt ) then
					t->udt.innerlgt = lgt
				end if
			end if

		else
			if( not isinner ) then
				t->udt.ofs = 0
				if( lgt > t->lgt ) then
					t->lgt = lgt
					t->udt.lfldlen = lgt
				end if
			else
				t->udt.ofs += lgt
				t->udt.innerlgt = t->udt.ofs
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
sub symbRoundUDTSize( byval t as FBSYMBOL ptr ) static
    dim round as integer, align as integer

	align = t->udt.align

	if( align > 1 ) then

		round = (align - (t->lgt and (align-1))) and (align-1)

		if( round > 0 ) then
			t->lgt += round
		end if

	end if

	'' check for forward references
	if( ctx.fwdrefcnt > 0 ) then
		hCheckFwdRef( t, FB_SYMBCLASS_UDT )
	end if

end sub

'':::::
sub symbRecalcUDTSize( byval t as FBSYMBOL ptr ) static
    dim lgt as integer

	lgt = t->udt.innerlgt
	if( lgt > 0 ) then

		if( not t->udt.isunion ) then
			t->udt.ofs += lgt
			t->lgt = t->udt.ofs
		else
			t->udt.ofs = 0
			if( lgt > t->lgt ) then
				t->lgt = lgt
				t->udt.lfldlen = lgt
			end if
		end if

		t->udt.innerlgt = 0
	end if

end sub

'':::::
function symbAddEnum( byval symbol as string ) as FBSYMBOL ptr static
    dim i as integer, e as FBSYMBOL ptr

    function = NULL

    ''
    e = hNewSymbol( FB_SYMBCLASS_ENUM, TRUE, symbol, "", env.scope > 0 )
	if( e = NULL ) then
		exit function
	end if

	e->enum.elements = 0
	e->enum.head 	 = NULL
	e->enum.tail 	 = NULL
	e->dbg.typenum = INVALID

	'' check for forward references
	if( ctx.fwdrefcnt > 0 ) then
		hCheckFwdRef( e, FB_SYMBCLASS_ENUM )
	end if

	function = e

end function

'':::::
function symbAddEnumElement( byval symbol as string, _
					         byval parent as FBSYMBOL ptr, _
					         byval value as integer ) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr elm, tail

	elm = symbAddConst( symbol, FB_SYMBTYPE_ENUM, parent, str( value ), 0 )

	if( elm = NULL ) then
		return NULL
	end if

	parent->enum.elements += 1

	'' add element to parent's linked-list
	tail = parent->enum.tail
	if( tail <> NULL ) then
		tail->con.eelm.nxt = elm
	else
		parent->enum.head = elm
	end if

	parent->enum.tail = elm

	elm->con.eelm.nxt = NULL

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
			lgt	+= ((argtail->lgt + 3) and not 3)			'' x86 assumption!

		case FB_ARGMODE_BYREF, FB_ARGMODE_BYDESC
			lgt	+= FB_POINTERSIZE
		end select

		argtail = argtail->arg.prev
	loop

	function = lgt

end function

'':::::
function symbAddArg( byval symbol as string, _
					 byval tail as FBSYMBOL ptr, _
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

    a = hNewSymbol( FB_SYMBCLASS_PROCARG, FALSE, "", _
    				symbol, FALSE, typ, subtype, ptrcnt, INVALID, TRUE )
    if( a = NULL ) then
    	exit function
    end if

	a->arg.prev = tail
	a->arg.next = NULL
	if( tail <> NULL ) then
		tail->arg.next = a
	end if

	''
	a->lgt			= lgt
	a->arg.mode		= mode
	a->arg.suffix	= suffix
	a->arg.optional	= optional

	if( optional ) then
		select case as const typ
		case IR_DATATYPE_FIXSTR, IR_DATATYPE_STRING, IR_DATATYPE_CHAR
			a->arg.optval.valuestr = optval->valuestr
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			a->arg.optval.value64 = optval->value64
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			a->arg.optval.valuef = optval->valuef
		case else
			a->arg.optval.valuei = optval->valuei
		end select
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
			if( subtype->udt.head->lgt = 2 ) then
				'' and if the struct is not packed
				if( subtype->lgt >= FB_INTEGERSIZE ) then
					return FB_SYMBTYPE_INTEGER
				end if
			end if

		case FB_INTEGERSIZE

			'' return in ST(0) if there's only one element and it's a SINGLE
			if( subtype->udt.elements = 1 ) then
				do
					if( subtype->udt.head->typ = FB_SYMBTYPE_SINGLE ) then
						return FB_SYMBTYPE_SINGLE
					end if

					if( subtype->udt.head->typ <> FB_SYMBTYPE_USERDEF ) then
						exit do
					end if

					subtype = subtype->udt.head->subtype

					if( subtype->udt.elements <> 1 ) then
						exit do
					end if
				loop
			end if

			return FB_SYMBTYPE_INTEGER

		case FB_INTEGERSIZE + 1, FB_INTEGERSIZE + 2, FB_INTEGERSIZE + 3

			'' return as longint only if first is a int
			if( subtype->udt.head->lgt = FB_INTEGERSIZE ) then
				'' and if the struct is not packed
				if( subtype->lgt >= FB_INTEGERSIZE*2 ) then
					return FB_SYMBTYPE_LONGINT
				end if
			end if

		case FB_INTEGERSIZE*2

			'' return in ST(0) if there's only one element and it's a DOUBLE
			if( subtype->udt.elements = 1 ) then
				do
					if( subtype->udt.head->typ = FB_SYMBTYPE_DOUBLE ) then
						return FB_SYMBTYPE_DOUBLE
					end if

					if( subtype->udt.head->typ <> FB_SYMBTYPE_USERDEF ) then
						exit do
					end if

					subtype = subtype->udt.head->subtype

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
private function hAddOvlProc( byval ovlf as FBSYMBOL ptr, _
							  byval symbol as string, _
							  byval aname as string, _
							  byval typ as integer, _
							  byval subtype as FBSYMBOL ptr, _
							  byval ptrcnt as integer, _
				              byval argc as integer, _
				              byval argtail as FBSYMBOL ptr, _
				              byval preservecase as integer ) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr f, farg, parg, fsubtype, psubtype
	dim as integer optcnt

	function = NULL

	'' arg-less?
	if( argc = 0 ) then
		exit function
	end if

	'' can't be vararg..
	if( argtail->arg.mode = FB_ARGMODE_VARARG ) then
		exit function
	end if

	'' all args can't be optional
	optcnt = 0
	parg = argtail
	do while( parg <> NULL )
		if( parg->arg.optional ) then
			optcnt += 1
		end if
		parg = parg->arg.prev
	loop

	if( optcnt = argc ) then
		exit function
	end if

	'' for each overloaded proc..
	f = ovlf
	do while( f <> NULL )

		'' same number of args?
		if( f->proc.args = argc ) then

			'' for each arg..
			parg = argtail
			farg = f->proc.argtail

			do while( parg <> NULL )
				'' not the same type? check next proc..
				if( parg->typ <> farg->typ ) then
					exit do
				end if

				if( parg->subtype <> farg->subtype ) then
					exit do
				end if

				parg = parg->arg.prev
				farg = farg->arg.prev
			loop

			'' all args equal? can't overload..
			if( parg = NULL ) then
				exit function
			end if

		end if

		f = f->proc.ovl.nxt
	loop


    '' add the new proc symbol, w/o adding it to the hash table
	f = hNewSymbol( FB_SYMBCLASS_PROC, FALSE, symbol, aname, FALSE, _
					typ, subtype, ptrcnt, INVALID, preservecase )

	if( f = NULL ) then
		exit function
	end if

	'' add to linked-list or getOrgName will fail
	ovlf->right  = f
	f->left      = ovlf

	f->hashitem  = ovlf->hashitem
	f->hashindex = ovlf->hashindex

    ''
	function = f

end function

'':::::
private function hSetupProc( byval symbol as string, _
							 byval aliasname as string, _
							 byval libname as string, _
				             byval typ as integer, _
				             byval subtype as FBSYMBOL ptr, _
				             byval ptrcnt as integer, _
				             byval alloctype as integer, _
				             byval mode as integer, _
				             byval argc as integer, _
				             byval argtail as FBSYMBOL ptr, _
			                 byval declaring as integer, _
			                 byval preservecase as integer ) as FBSYMBOL ptr static

    static as zstring * FB_MAXINTNAMELEN+1 aname
    dim as integer lgt, i, realtype
    dim as FBSYMBOL ptr f, ovlf

    function = NULL

	''
	if( typ = INVALID ) then
		typ = hGetDefType( symbol )
		subtype = NULL
	end if

    realtype = hGetProcRealType( typ, subtype )

    lgt = hCalcProcArgsLen( argc, argtail )

    '' no alias? make one..
    if( len( aliasname ) = 0 ) then

    	if( len( libname ) = 0 ) then
    		hUcase( symbol, aname )
    	else
    		aname = symbol
    	end if

    	'' overloaded?
		if( (alloctype and FB_ALLOCTYPE_OVERLOADED) > 0 ) then
			aname = *hCreateOvlProcAlias( aname, argc, argtail )
		end if

		aname = *hCreateProcAlias( aname, lgt, mode )

    '' alias given..
    else
	   	aname = *hCreateProcAlias( aliasname, lgt, mode )
    end if

    ''
	f = hNewSymbol( FB_SYMBCLASS_PROC, TRUE, symbol, aname, FALSE, _
					typ, subtype, ptrcnt, INVALID, preservecase )

	'' dup def?
	if( f = NULL ) then
		'' is the dup a proc symbol?
		ovlf = symbFindByNameAndClass( symbol, FB_SYMBCLASS_PROC, preservecase )
		if( ovlf = NULL ) then
			exit function
		end if

		'' proc was defined as overloadable?
		if( not symbIsOverloaded( ovlf ) ) then
			exit function
		end if

    	'' no alias?
    	if( len( aliasname ) = 0 ) then
			if( (alloctype and FB_ALLOCTYPE_OVERLOADED) = 0 ) then
    			if( len( libname ) = 0 ) then
    				hUcase( symbol, aname )
    			else
    				aname = symbol
    			end if

				aname = *hCreateOvlProcAlias( aname, argc, argtail )

				aname = *hCreateProcAlias( aname, lgt, mode )
			end if
		end if

		'' try to overload..
		f = hAddOvlProc( ovlf, symbol, aname, typ, subtype, ptrcnt, _
						 argc, argtail, preservecase )
		if( f = NULL ) then
			exit function
		end if

		alloctype or= FB_ALLOCTYPE_OVERLOADED

	else
		ovlf = NULL
	end if

    ''
	f->alloctype		= alloctype or FB_ALLOCTYPE_SHARED

    '' if proc returns an UDT, add the hidden pointer passed as the 1st arg
    if( typ = FB_SYMBTYPE_USERDEF ) then
    	if( realtype = FB_SYMBTYPE_POINTER + FB_SYMBTYPE_USERDEF ) then
    		lgt += FB_POINTERSIZE
    	end if
    end if

	f->lgt				= lgt

	f->proc.isdeclared 	= declaring
	f->proc.iscalled	= FALSE
	f->proc.isrtl		= FALSE
	f->proc.doerrorcheck= FALSE

	f->proc.mode		= mode
	f->proc.realtype	= realtype

	f->proc.rtlcallback = NULL

	if( len( libname ) > 0 ) then
		f->proc.lib 	= symbAddLib( libname )
	else
		f->proc.lib 	= NULL
	end if

	'' add arguments (w/o declaring them as symbols)
	f->proc.args 		= argc
	f->proc.argtail		= argtail

	if( argtail <> NULL ) then
		do while( argtail->arg.prev <> NULL )
			argtail = argtail->arg.prev
		loop
	end if

	f->proc.arghead		= argtail

	'' if overloading, update the linked-list
	if( (alloctype and FB_ALLOCTYPE_OVERLOADED) > 0 ) then
		if( ovlf <> NULL ) then
			f->proc.ovl.nxt	= ovlf->proc.ovl.nxt
			ovlf->proc.ovl.nxt = f

			if( argc > ovlf->proc.ovl.maxargs ) then
				ovlf->proc.ovl.maxargs = argc
			end if
		else
			f->proc.ovl.nxt	= NULL
			f->proc.ovl.maxargs	= 0
		end if
	end if

	function = f

end function

'':::::
function symbAddPrototype( byval symbol as string, _
						   byval aliasname as string, _
						   byval libname as string, _
						   byval typ as integer, _
						   byval subtype as FBSYMBOL ptr, _
						   byval ptrcnt as integer, _
						   byval alloctype as integer, _
						   byval mode as integer, _
						   byval argc as integer, _
						   byval argtail as FBSYMBOL ptr, _
						   byval isexternal as integer, _
						   byval preservecase as integer = FALSE ) as FBSYMBOL ptr static

    dim f as FBSYMBOL ptr

    function = NULL

	f = hSetupProc( symbol, aliasname, libname, typ, subtype, ptrcnt, _
					alloctype, mode, argc, argtail, isexternal, preservecase )
	if( f = NULL ) then
		exit function
	end if

	function = f

end function

'':::::
function symbAddProc( byval symbol as string, _
					  byval aliasname as string, _
					  byval libname as string, _
					  byval typ as integer, _
					  byval subtype as FBSYMBOL ptr, _
					  byval ptrcnt as integer, _
					  byval alloctype as integer, _
					  byval mode as integer, _
					  byval argc as integer, _
					  byval argtail as FBSYMBOL ptr ) as FBSYMBOL ptr static

    dim f as FBSYMBOL ptr

    function = NULL

	f = hSetupProc( symbol, aliasname, libname, typ, subtype, ptrcnt, _
					alloctype, mode, argc, argtail, TRUE, FALSE )
	if( f = NULL ) then
		exit function
	end if

	function = f

end function

'':::::
function symbAddArgAsVar( byval symbol as string, _
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

    s = symbAddVarEx( symbol, "", typ, arg->subtype, 0, 0, _
    				  0, dTB(), alloctype, arg->arg.suffix <> INVALID, FALSE, TRUE )

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

    s = symbAddVarEx( symbol, "", FB_SYMBTYPE_POINTER+FB_SYMBTYPE_USERDEF, proc->subtype, 0, 0, _
    				  0, dTB(), FB_ALLOCTYPE_ARGUMENTBYVAL, TRUE, TRUE, FALSE )

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

	s = symbAddVarEx( rname, "", proc->typ, proc->subtype, 0, 0, 0, _
					  dTB(), 0, TRUE, TRUE, FALSE )

	function = s

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' lookups
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbLookup( byval symbol as string, _
					 id as integer, _
					 class as integer, _
					 byval preservecase as integer = FALSE ) as FBSYMBOL ptr static

    static as zstring * FB_MAXNAMELEN+1 sname
    dim as FBSYMBOL ptr s

    if( not preservecase ) then
    	hUcase( symbol, sname )
    	s = hashLookup( @ctx.symhash, strptr( sname ) )
    else
    	s = hashLookup( @ctx.symhash, strptr( symbol ) )
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
							  byval fields as string ) as integer

	static as zstring * FB_MAXNAMELEN+1 ename
	dim as FBSYMBOL ptr e
	dim as integer p, ofs, res
	dim as integer flen

    flen = len( fields )

    '' find next dot
    p = instr( 1, fields, "." )
    ename = fields
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
	e = subtype->udt.head
	do while( e <> NULL )

        '' names match?
        if( e->alias = ename ) then

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

    		res = symbGetUDTElmOffset( elm, typ, subtype, byval @ename[p] )	'' mid$( fields, p+1 )
    		if( res < 0 ) then
    			return -1
    		end if

    		return ofs + res

        end if

		'' next
		e = e->var.elm.next
    loop

    function = -1

end function

'':::::
function symbLookupUDTVar( byval symbol as string, _
						   byval dotpos as integer ) as FBSYMBOL ptr static

    static as zstring * FB_MAXNAMELEN+1 sname
	dim as FBSYMBOL ptr s

    function = NULL

    '' symbol contains no dots?
    if( dotpos < 1 ) then
    	exit function
    end if

	'' check if it's an UDT field
    sname = symbol
    sname[dotpos-1] = 0 						'' left$( symbol, dotpos-1 )

    s = symbFindByNameAndClass( sname, FB_SYMBCLASS_VAR )
	if( s = NULL ) then
		exit function
	end if

	if( s->typ <> FB_SYMBTYPE_USERDEF ) then
		exit function
	end if

	function = s

end function

'':::::
function symbLookupUDTElm( byval symbol as string, _
						   byval dotpos as integer, _
						   typ as integer, _
						   ofs as integer, _
					       elm as FBSYMBOL ptr, _
					       subtype as FBSYMBOL ptr ) as FBSYMBOL ptr static

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
	ofs = symbGetUDTElmOffset( elm, typ, subtype, byval @symbol[dotpos] )	'' mid$( symbol, dotpos+1 )
	if( ofs < 0 ) then
		hReportError( FB_ERRMSG_ELEMENTNOTDEFINED )
    	exit function
	end if

	'' update the access counter
	s->acccnt += 1

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

	function = symbFindByNameAndClass( rname, FB_SYMBCLASS_VAR, TRUE )

end function

'':::::
function symbFindByClass( byval s as FBSYMBOL ptr, _
						  byval class as integer ) as FBSYMBOL ptr static

    '' lookup a symbol with the same class
    do while( s <> NULL )
    	if( s->class = class ) then
			exit do
		end if
    	s = s->right
    loop

	'' check if symbol isn't a non-shared module level one
	if( class = FB_SYMBCLASS_VAR ) then
		if( env.scope > 0 ) then
			if( s <> NULL ) then
				if( s->scope = 0 ) then
					if( (s->alloctype and FB_ALLOCTYPE_SHARED) = 0 ) then
						s = NULL
					end if
				end if
			end if
		end if
	end if

	'' update the access counter
	if( s <> NULL ) then
		s->acccnt += 1
	end if

	function = s

end function

'':::::
function symbFindBySuffix( byval s as FBSYMBOL ptr, _
						   byval suffix as integer, _
						   byval deftyp as integer ) as FBSYMBOL ptr static

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

	'' check if symbol isn't a non-shared module level one
	if( env.scope > 0 ) then
		if( s <> NULL ) then
			if( s->scope = 0 ) then
				if( (s->alloctype and FB_ALLOCTYPE_SHARED) = 0 ) then
					s = NULL
				end if
			end if
		end if
	end if

    '' update the access counter
	if( s <> NULL ) then
		s->acccnt += 1
	end if

	function = s

end function

'':::::
function symbFindByNameAndClass( byval symbol as string, _
								 byval class as integer, _
								 byval preservecase as integer = FALSE ) as FBSYMBOL ptr static
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
function symbFindByNameAndSuffix( byval symbol as string, _
								  byval suffix as integer, _
								  byval preservecase as integer = FALSE ) as FBSYMBOL ptr static
	dim s as FBSYMBOL ptr
	dim deftyp as integer
	dim tkid as integer, tkclass as integer

	s = symbLookup( symbol, tkid, tkclass, preservecase )

    '' any found?
    if( s <> NULL ) then
    	'' get default type if no suffix was given
    	if( suffix = INVALID ) then
    		deftyp = hGetDefType( symbol )
    	end if

		'' check if types match
		function = symbFindBySuffix( s, suffix, deftyp )
	else
		function = NULL
	end if

end function

'':::::
function symbFindOverloadProc( byval proc as FBSYMBOL ptr, _
					   	       byval argc as integer, _
					   	       byval argtail as FBSYMBOL ptr ) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr f, farg, parg, fsubtype, psubtype

	'' for each proc..
	f = proc
	do while( f <> NULL )

		if( argc = f->proc.args ) then

			'' for each arg..
			farg = f->proc.argtail
			parg = argtail
			do while( parg <> NULL )

				'' not the same type? check next proc..
				if( parg->typ <> farg->typ ) then
					exit do
				end if

				if( parg->subtype <> farg->subtype ) then
					exit do
				end if

				parg = parg->arg.prev
				farg = farg->arg.prev
			loop

			'' all args equal?
			if( parg = NULL ) then
				return f
			end if

		end if

		f = f->proc.ovl.nxt
	loop

	function = NULL

end function

'':::::
function symbFindClosestOvlProc( byval proc as FBSYMBOL ptr, _
					   		     byval params as integer, _
					   		     exprTB() as ASTNODE ptr, _
					   		     modeTB() as integer ) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr f, farg, marg, match, psubtype, fsubtype
	dim as integer p, pdclass, pdtype, fdclass
	dim as integer fdtype, mdtype, fmatches, mmatches

	match = NULL

	'' for each proc..
	f = proc
	do while( f <> NULL )

		if( params <= f->proc.args ) then

			'' for each arg..
			farg = f->proc.argtail
			for p = params-1 to 0 step -1

				'' optional?
				if( exprTB(p) = NULL ) then
					if( not farg->arg.optional ) then
						exit for
					end if
				else

					''
					pdtype = astGetDataType( exprTB(p) )
					if( pdtype >= IR_DATATYPE_POINTER ) then
						psubtype = NULL
					else
						psubtype = astGetSubtype( exprTB(p) )
					end if

					''
					fdtype = farg->typ
					if( fdtype >= IR_DATATYPE_POINTER ) then
						fsubtype = NULL
					else
						fsubtype = farg->subtype
					end if

					'' same class?
					fdclass = irGetDataClass( fdtype )
					pdclass = irGetDataClass( pdtype )
					if( fdclass <> pdclass ) then
						'' could be a float passed to an int arg or vice-versa
						if( fdclass >= IR_DATACLASS_STRING ) then
							'' zstring?
							if( pdtype <> IR_DATATYPE_CHAR ) then
								exit for
							end if
						else
							if( pdclass >= IR_DATACLASS_STRING ) then
								exit for
							end if
						end if
					end if

					if( fsubtype <> psubtype ) then
						exit for
					end if
				end if

				farg = farg->arg.prev
			next

			'' all params okay?
			if( farg = NULL ) then
				'' no preview matches?
				if( match = NULL ) then
					match = f
				else
					'' proc with less args has more precedence
					if( f->proc.args < match->proc.args ) then
						match = f

					'' same num of args, check the closest..
					else
						farg = f->proc.argtail
						marg = match->proc.argtail
						fmatches = 0
						mmatches = 0

						'' for each param..
						for p = 0 to params-1
							'' not optional?
							if( exprTB(p) <> NULL ) then
								'' different types?
								if( farg->typ <> marg->typ ) then

									pdtype = astGetDataType( exprTB(p) )

									'' get the distance..
									if( abs( farg->typ - pdtype ) < _
										abs( marg->typ - pdtype ) ) then
										fmatches += 1
									else
										mmatches += 1
									end if

								end if
							end if

		                	farg = farg->arg.prev
		                	marg = marg->arg.prev
		                next

		                '' proc has more args close to the final?
		                if( fmatches > mmatches ) then
		                	match = f
		                end if

					end if
				end if
			end if

		end if

		f = f->proc.ovl.nxt
	loop

	if( match <> NULL ) then
		function = match
	else
		function = proc
	end if

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' helpers
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbCalcLen( byval typ as integer, _
					  byval subtype as FBSYMBOL ptr, _
					  byval realsize as integer = FALSE ) as integer static
    dim lgt as integer
    dim e as FBSYMBOL ptr

	lgt = 0

	select case as const typ
	case FB_SYMBTYPE_FWDREF
		lgt = 0

	case FB_SYMBTYPE_BYTE, FB_SYMBTYPE_UBYTE, FB_SYMBTYPE_CHAR
		lgt = 1

	case FB_SYMBTYPE_SHORT, FB_SYMBTYPE_USHORT
		lgt = 2

	case FB_SYMBTYPE_INTEGER, FB_SYMBTYPE_LONG, FB_SYMBTYPE_UINT, FB_SYMBTYPE_ENUM
		lgt = FB_INTEGERSIZE

	case FB_SYMBTYPE_LONGINT, FB_SYMBTYPE_ULONGINT
		lgt = FB_INTEGERSIZE*2

	case FB_SYMBTYPE_SINGLE
		lgt = 4

	case FB_SYMBTYPE_DOUBLE
    	lgt = 8

	case FB_SYMBTYPE_FIXSTR
		lgt = 0									'' 0-len literal-strings

	case FB_SYMBTYPE_STRING
		lgt = FB_STRSTRUCTSIZE

	case FB_SYMBTYPE_USERDEF
		if( not realsize ) then
			lgt = subtype->lgt

		else
			if( not subtype->udt.isunion ) then
				e = subtype->udt.tail
				lgt = e->var.elm.ofs + (e->lgt * e->var.array.elms)

			'' union, use the largest field len
			else
				lgt = subtype->udt.lfldlen
			end if
		end if

	case else
		if( typ >= FB_SYMBTYPE_POINTER ) then
			lgt = FB_POINTERSIZE
		end if
	end select

	function = lgt

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
	next d

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
function symbGetUDTLen( byval udt as FBSYMBOL ptr, _
						byval realsize as integer = TRUE ) as integer static
    dim e as FBSYMBOL ptr

	if( not realsize ) then
		function = udt->lgt

	else
		if( not udt->udt.isunion ) then
			e = udt->udt.tail
			function = e->var.elm.ofs + (e->lgt * e->var.array.elms)

		'' union, use the largest field len
		else
			function = udt->udt.lfldlen
		end if
	end if

end function


'':::::
function symbGetGlobalHead( ) as FBSYMBOL ptr static

	function = ctx.globtb.head

end function

'':::::
function symbGetLocalHead( ) as FBSYMBOL ptr static

	if( ctx.loctb = NULL ) then
		function = NULL
	else
		function = ctx.loctb->head
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
function symbGetProcPrevArg( byval f as FBSYMBOL ptr, _
							 byval a as FBSYMBOL ptr, _
							 byval checkconv as integer = TRUE ) as FBSYMBOL ptr static

	if( a = NULL ) then
		return NULL
	end if

	if( checkconv ) then
		if( f->proc.mode = FB_FUNCMODE_PASCAL ) then
			function = a->arg.prev
		else
			function = a->arg.next
		end if
	else
		function = a->arg.prev
	end if

end function

'':::::
function symbGetProcNextArg( byval f as FBSYMBOL ptr, _
							 byval a as FBSYMBOL ptr, _
							 byval checkconv as integer = TRUE ) as FBSYMBOL ptr static

	if( a = NULL ) then
		return NULL
	end if

	if( checkconv ) then
		if( f->proc.mode = FB_FUNCMODE_PASCAL ) then
			function = a->arg.next
		else
			function = a->arg.prev
		end if
	else
		function = a->arg.next
	end if

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
    if( s->scope = 0 ) then
    	tb = @ctx.globtb
    else
    	tb = ctx.loctb
    end if

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

		s->scope = 0

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
	dim a as FBDEFARG ptr, n as FBDEFARG ptr

    a = s->def.arghead
    do while( a <> NULL )
    	n = a->next
    	a->name = ""
    	listDelNode( @ctx.defarglist, cptr( TLISTNODE ptr, a ) )
    	a = n
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
	s->def.text = ""

	hDelDefineArgs( s )

    ''
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

    ''
    s->con.text = ""

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
    e = s->udt.head
    do while( e <> NULL )
        nxt = e->var.elm.next
    	hFreeSymbol( e )
    	e = nxt
    loop

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
	e = s->enum.head
    do while( e <> NULL )
        nxt = e->con.eelm.nxt
		hFreeSymbol( e )
		e = nxt
	loop

	hFreeSymbol( s )

end sub

'':::::
private sub hDelArgs( byval f as FBSYMBOL ptr )
	dim as FBSYMBOL ptr a, n

    a = f->proc.arghead
    do while( a <> NULL )
    	n = a->arg.next
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
			n = s->proc.ovl.nxt
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
	if( s->scope > 0 ) then
    	'' static? move it to global list
    	if( symbIsStatic( s ) ) then
    		movetoglob = TRUE
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
sub symbDelGlobalTb( ) static
    dim as FBSYMBOL ptr s

    do
    	s = ctx.globtb.head
    	if( s = NULL ) then
    		exit do
    	end if

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

		case else
			hFreeSymbol( s )

    	end select
    loop

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' locals
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbSetLocalTb( byval tb as FBSYMBOLTB ptr )

	ctx.loctb = tb

end sub

'':::::
sub symbDelLocalTb( byval hashonly as integer ) static
    dim as FBSYMBOL ptr s

    '' del from hash tb only?
    if( hashonly ) then

    	s = ctx.loctb->head
    	do while( s <> NULL )

	    	select case as const s->class
    		case FB_SYMBCLASS_VAR, FB_SYMBCLASS_CONST, FB_SYMBCLASS_UDT, _
    			 FB_SYMBCLASS_ENUM, FB_SYMBCLASS_LABEL

    			hDelFromHash( s )

    		end select

    		s = s->next
    	loop

    '' del from hash and symbol tb's
    else

    	do
    	    s = ctx.loctb->head
    		if( s = NULL ) then
    			exit do
    		end if

	    	select case as const s->class
    		case FB_SYMBCLASS_VAR
    			symbDelVar( s, FALSE )

    		case FB_SYMBCLASS_CONST
	    		symbDelConst( s, FALSE )

    		case FB_SYMBCLASS_UDT
    			symbDelUDT( s, FALSE )

    		case FB_SYMBCLASS_ENUM
	    		symbDelEnum( s, FALSE )

    		case FB_SYMBCLASS_LABEL
    			symbDelLabel( s, FALSE )

    		case else
    			hFreeSymbol( s )
    		end select
    	loop

    end if

    ctx.loctb = NULL

end sub

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

	s = ctx.loctb->head
    do while( s <> NULL )

    	if( s->class = FB_SYMBCLASS_VAR ) then
    		if( (s->alloctype and (FB_ALLOCTYPE_SHARED or FB_ALLOCTYPE_STATIC)) = 0 ) then

				'' not an argument?
    			if( (s->alloctype and (FB_ALLOCTYPE_ARGUMENTBYDESC or _
    				  				   FB_ALLOCTYPE_ARGUMENTBYVAL or _
    				  				   FB_ALLOCTYPE_ARGUMENTBYREF or _
    				  				   FB_ALLOCTYPE_TEMP)) = 0 ) then

					if( s->var.array.dims > 0 ) then
						if( symbIsDynamic( s ) ) then
							rtlArrayErase( astNewVAR( s, NULL, 0, s->typ ) )
						elseif( s->typ = FB_SYMBTYPE_STRING ) then
							rtlArrayStrErase( s )
						end if

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
function symbCheckLocalLabels(  ) as integer
    dim as FBSYMBOL ptr s
    dim as integer cnt

    cnt = 0

    s = ctx.loctb->head
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
    	if( sym1->udt.head <> sym2->udt.head ) then
    		exit function
    	end if

    	''
    	if( sym1->udt.tail <> sym2->udt.tail ) then
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
    		argl = argl->arg.next
    		argr = argr->arg.next
    	loop
    end select

	'' and sub type
	if( sym1->subtype <> sym2->subtype ) then
        function = symbIsEqual( sym1->subtype, sym2->subtype )
    else
    	function = TRUE
    end if

end function


