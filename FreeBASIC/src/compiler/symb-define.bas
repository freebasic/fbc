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


'' symbol table module for defines and macros
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\lex.bi"

type DEFCALLBACK as function() as string

type SYMBDEF
	name			as zstring * 16+1
	value			as zstring * 16+1
	flags			as integer
	proc			as DEFCALLBACK
end type

declare function	hDefFile_cb			( ) as string
declare function	hDefFunction_cb		( ) as string
declare function	hDefLine_cb			( ) as string
declare function	hDefDate_cb			( ) as string
declare function	hDefTime_cb			( ) as string
declare function    hDefMultithread_cb	( ) as string

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

	function = str( lexLineNum( ) )

end function

'':::::
function hDefDate_cb( ) as string static

	function = date

end function

'':::::
function hDefTime_cb( ) as string static

	function = time

end function

'':::::
function hDefMultithread_cb( ) as string static

	function = str( env.clopt.multithreaded )

end function

'':::::
sub symbInitDefines( byval ismain as integer ) static
	dim as string def, value
	dim as integer i

    listNew( @symb.defarglist, FB_INITDEFARGNODES, len( FBDEFARG ), FALSE )

    listNew( @symb.deftoklist, FB_INITDEFTOKNODES, len( FBDEFTOK ), FALSE )

    symb.defargcnt = 0

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
    d = symbNewSymbol( NULL, symb.symtb, FB_SYMBCLASS_DEFINE, TRUE, _
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
    d = symbNewSymbol( NULL, symb.symtb, FB_SYMBCLASS_DEFINE, TRUE, _
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

    a = listNewNode( @symb.defarglist )
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
    a->id		= symb.defargcnt
    symb.defargcnt += 1

    function = a

end function

'':::::
function symbAddDefineTok( byval lasttok as FBDEFTOK ptr, _
						   byval typ as FB_DEFTOK_TYPE _
						 ) as FBDEFTOK ptr static

    dim t as FBDEFTOK ptr

    function = NULL

    t = listNewNode( @symb.deftoklist )
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
private sub hDelDefineArgs( byval s as FBSYMBOL ptr )
	dim as FBDEFARG ptr arg, nxt

    arg = s->def.arghead
    do while( arg <> NULL )
    	nxt = arg->next
    	arg->name = ""
    	listDelNode( @symb.defarglist, cptr( TLISTNODE ptr, arg ) )
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

    	listDelNode( @symb.deftoklist, cptr( TLISTNODE ptr, tok ) )
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
    symbFreeSymbol( s )

	''
	function = TRUE

end function


