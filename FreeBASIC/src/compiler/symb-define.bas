''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
	name			as zstring ptr
	value			as zstring ptr
	flags			as integer
	proc			as DEFCALLBACK
end type

declare function	hDefFile_cb			( ) as string
declare function	hDefFunction_cb		( ) as string
declare function	hDefLine_cb			( ) as string
declare function	hDefDate_cb			( ) as string
declare function	hDefTime_cb			( ) as string
declare function    hDefMultithread_cb	( ) as string
declare function    hDefOptByval_cb		( ) as string
declare function    hDefOptDynamic_cb	( ) as string
declare function    hDefOptEscape_cb	( ) as string
declare function    hDefOptExplicit_cb	( ) as string
declare function    hDefOptPrivate_cb	( ) as string
declare function 	hDefOutExe_cb 		( ) as string
declare function 	hDefOutLib_cb 		( ) as string
declare function 	hDefOutDll_cb 		( ) as string
declare function 	hDefOutObj_cb 		( ) as string

'' predefined #defines: name, value, flags, proc (for description flags, see FBS_DEFINE)
const SYMB_MAXDEFINES = 24

	dim shared defTb( 0 to SYMB_MAXDEFINES-1 ) as SYMBDEF => _
	{ _
		(@"__FB_VERSION__",			@FB_VERSION,	   0, NULL				 ), _
		(@"__FB_VER_MAJOR__",		@FB_VER_STR_MAJOR, 1, NULL               ), _
		(@"__FB_VER_MINOR__",		@FB_VER_STR_MINOR, 1, NULL               ), _
		(@"__FB_VER_PATCH__",		@FB_VER_STR_PATCH, 1, NULL               ), _
		(@"__FB_SIGNATURE__",		@FB_SIGN,		   0, NULL               ), _
		(@"__FB_MT__",				NULL,			   1, @hDefMultithread_cb), _
		(@"__FILE__",				NULL,			   0, @hDefFile_cb       ), _
		(@"__FUNCTION__",			NULL,			   0, @hDefFunction_cb   ), _
		(@"__LINE__",				NULL,			   1, @hDefLine_cb       ), _
		(@"__DATE__",				NULL,			   0, @hDefDate_cb       ), _
		(@"__TIME__",				NULL,			   0, @hDefTime_cb       ), _
		(@"__FB_OPTION_BYVAL__",	NULL,		  	   1, @hDefOptByval_cb   ), _
		(@"__FB_OPTION_DYNAMIC__",	NULL,		  	   1, @hDefOptDynamic_cb ), _
		(@"__FB_OPTION_ESCAPE__",	NULL,		  	   1, @hDefOptEscape_cb  ), _
		(@"__FB_OPTION_EXPLICIT__",	NULL,		  	   1, @hDefOptExplicit_cb), _
		(@"__FB_OPTION_PRIVATE__",	NULL,		  	   1, @hDefOptPrivate_cb ), _
		(@"__FB_OUT_EXE__",			NULL,		   	   1, @hDefOutExe_cb 	 ), _
		(@"__FB_OUT_LIB__",			NULL,		   	   1, @hDefOutLib_cb 	 ), _
		(@"__FB_OUT_DLL__",			NULL,		   	   1, @hDefOutDll_cb 	 ), _
		(@"__FB_OUT_OBJ__",			NULL,		   	   1, @hDefOutObj_cb 	 ), _
		(NULL) _
	}

'':::::
private function hDefFile_cb( ) as string static

	function = env.inf.name

end function

'':::::
private function hDefFunction_cb( ) as string static

	function = *symbGetCurrentProcName( )

end function

'':::::
private function hDefLine_cb( ) as string static

	function = str( lexLineNum( ) )

end function

'':::::
private function hDefDate_cb( ) as string static

	function = date

end function

'':::::
private function hDefTime_cb( ) as string static

	function = time

end function

'':::::
private function hDefMultithread_cb( ) as string static

	function = str( env.clopt.multithreaded )

end function

'':::::
private function hDefOptByval_cb ( ) as string

	function = str( env.opt.parammode = FB_PARAMMODE_BYVAL )

end function

'':::::
private function hDefOptDynamic_cb ( ) as string

	function = str( env.opt.dynamic = TRUE )

end function

'':::::
private function hDefOptEscape_cb ( ) as string

	function = str( env.opt.escapestr = TRUE )

end function

'':::::
private function hDefOptExplicit_cb ( ) as string

	function = str( env.opt.explicit = TRUE )

end function

'':::::
private function hDefOptPrivate_cb ( ) as string

	function = str( env.opt.procpublic = FALSE )

end function

'':::::
private function hDefOutExe_cb ( ) as string

	function = str( env.clopt.outtype = FB_OUTTYPE_EXECUTABLE )

end function

'':::::
private function hDefOutLib_cb ( ) as string

	function = str( env.clopt.outtype = FB_OUTTYPE_STATICLIB )

end function

'':::::
private function hDefOutDll_cb ( ) as string

	function = str( env.clopt.outtype = FB_OUTTYPE_DYNAMICLIB )

end function

'':::::
private function hDefOutObj_cb ( ) as string

	function = str( env.clopt.outtype = FB_OUTTYPE_OBJECT )

end function

'':::::
sub symbInitDefines _
	( _
		byval ismain as integer _
	) static

	dim as string value
	dim as zstring ptr def
	dim as integer i

    listNew( @symb.defparamlist, FB_INITDEFARGNODES, len( FB_DEFPARAM ), LIST_FLAGS_NOCLEAR )

    listNew( @symb.deftoklist, FB_INITDEFTOKNODES, len( FB_DEFTOK ), LIST_FLAGS_NOCLEAR )

    for i = 0 to SYMB_MAXDEFINES-1
    	if( defTb(i).name = NULL ) then
    		exit for
    	end if

    	value = *defTb(i).value
    	if( defTb(i).value <> NULL ) then
            if( bit( defTb(i).flags, 0 ) = 0 ) then
    			value = "\"" + value + "\""
            end if
    	end if

    	symbAddDefine( defTb(i).name, value, len( value ), _
    				   FALSE, defTb(i).proc, defTb(i).flags )
    next

	'' target
	select case as const env.clopt.target
	case FB_COMPTARGET_WIN32
		def = @"__FB_WIN32__"
	case FB_COMPTARGET_CYGWIN
		def = @"__FB_CYGWIN__"
	case FB_COMPTARGET_LINUX
		def = @"__FB_LINUX__"
	case FB_COMPTARGET_DOS
		def = @"__FB_DOS__"
	case FB_COMPTARGET_XBOX
		def = @"__FB_XBOX__"
	end select

	symbAddDefine( def, NULL, 0 )

	'' main
	if( ismain ) then
		symbAddDefine( "__FB_MAIN__", NULL, 0 )
	end if

end sub

'':::::
function symbAddDefine _
	( _
		byval symbol as zstring ptr, _
		byval text as zstring ptr, _
		byval lgt as integer, _
		byval isargless as integer = FALSE, _
		byval proc as function( ) as string = NULL, _
        byval flags as integer = 0 _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr sym

    function = NULL

    '' allocate new node (always on global hash, ns' won't work in lexer)
    sym = symbNewSymbol( NULL, _
    					 NULL, @symbGetGlobalHashTb( ), fbIsModLevel( ), _
    					 FB_SYMBCLASS_DEFINE, _
    				   	 TRUE, symbol, NULL, _
    				   	 FB_DATATYPE_CHAR, NULL )
    if( sym = NULL ) then
    	exit function
    end if

	sym->def.text	= ZstrAllocate( lgt )
	*sym->def.text = *text
	sym->lgt = lgt
	sym->def.params	= 0
	sym->def.paramhead = NULL
	sym->def.isargless = isargless
	sym->def.proc = proc
    sym->def.flags = flags

	function = sym

end function

'':::::
function symbAddDefineW _
	( _
		byval symbol as zstring ptr, _
		byval text as wstring ptr, _
		byval lgt as integer, _
		byval isargless as integer = FALSE, _
		byval proc as function( ) as string = NULL, _
        byval flags as integer = 0 _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr sym

    function = NULL

    '' allocate new node (always on global hash, ns' won't work in lexer)
    sym = symbNewSymbol( NULL, _
    					 NULL, @symbGetGlobalHashTb( ), fbIsModLevel( ), _
    					 FB_SYMBCLASS_DEFINE, _
    				   	 TRUE, symbol, NULL, _
    				   	 FB_DATATYPE_WCHAR, NULL )
    if( sym = NULL ) then
    	exit function
    end if

	sym->def.textw = WstrAllocate( lgt )
	*sym->def.textw = *text
	sym->lgt = lgt
	sym->def.params = 0
	sym->def.paramhead = NULL
	sym->def.isargless = isargless
	sym->def.proc = proc
    sym->def.flags = flags

	function = sym

end function

'':::::
function symbAddDefineMacro _
	( _
		byval symbol as zstring ptr, _
		byval tokhead as FB_DEFTOK ptr, _
		byval params as integer, _
		byval paramhead as FB_DEFPARAM ptr _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr sym

    function = NULL

    '' allocate new node (always on global hash, ns' won't work in lexer)
    sym = symbNewSymbol( NULL, _
    					 NULL, @symbGetGlobalHashTb( ), fbIsModLevel( ), _
    					 FB_SYMBCLASS_DEFINE, _
    				   	 TRUE, symbol, NULL )
    if( sym = NULL ) then
    	exit function
    end if

	sym->def.tokhead = tokhead
	sym->def.params = params
	sym->def.paramhead = paramhead
	sym->def.isargless = FALSE
	sym->def.proc = NULL
    sym->def.flags = 0

	function = sym

end function

'':::::
function symbAddDefineParam _
	( _
		byval lastparam as FB_DEFPARAM ptr, _
		byval symbol as zstring ptr _
	) as FB_DEFPARAM ptr static

    dim as FB_DEFPARAM ptr param

    function = NULL

    param = listNewNode( @symb.defparamlist )
    if( param = NULL ) then
    	exit function
    end if

	if( lastparam <> NULL ) then
		lastparam->next = param
	end if

	''
    param->name	= ZstrAllocate( len( *symbol ) )
    hUcase( *symbol, *param->name )
    param->next	= NULL

    function = param

end function

'':::::
function symbAddDefineTok _
	( _
		byval lasttok as FB_DEFTOK ptr, _
		byval dtype as FB_DEFTOK_TYPE _
	) as FB_DEFTOK ptr static

    dim t as FB_DEFTOK ptr

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
	t->type = dtype
	select case dtype
	case FB_DEFTOK_TYPE_TEX
		t->text = NULL
	case FB_DEFTOK_TYPE_TEXW
		t->textw = NULL
	end select

    function = t

end function

'':::::
private sub hDelDefineParams( byval s as FBSYMBOL ptr )
	dim as FB_DEFPARAM ptr param, nxt

    param = s->def.paramhead
    do while( param <> NULL )
    	nxt = param->next
    	ZstrFree( param->name )
    	listDelNode( @symb.defparamlist, param )
    	param = nxt
    loop

end sub

'':::::
private sub hDelDefineTokens( byval s as FBSYMBOL ptr )
	dim as FB_DEFTOK ptr tok, nxt

    tok = s->def.tokhead
    do while( tok <> NULL )
    	nxt = tok->next

    	select case tok->type
    	case FB_DEFTOK_TYPE_TEX
    		ZstrFree( tok->text )
    	case FB_DEFTOK_TYPE_TEXW
    		WstrFree( tok->textw )
    	end select

    	listDelNode( @symb.deftoklist, tok )
    	tok = nxt
    loop

end sub

'':::::
function symbDelDefine _
	( _
		byval s as FBSYMBOL ptr _
	) as integer static

    function = FALSE

    if( s = NULL ) then
    	exit function
    end if

	''
	if( symbGetDefineParams( s ) = 0 ) then
		if( symbGetType( s ) <> FB_DATATYPE_WCHAR ) then
			ZstrFree( s->def.text )
		else
			WstrFree( s->def.textw )
		end if
	else
		hDelDefineTokens( s )
	end if

	''
	hDelDefineParams( s )

    '' del the define node
    symbFreeSymbol( s )

	''
	function = TRUE

end function


