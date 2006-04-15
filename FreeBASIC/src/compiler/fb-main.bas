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


'' prolog and epilog for the implicit main() function
''
'' chng: jun/2005 written [v1ctor]
''

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\symb.bi"

':::::
private sub hDllMainBegin( )
    dim as FBSYMBOL ptr proc, label, param
   	dim as ASTNODE ptr reason, main, procnode
    dim as integer argn

const fbdllreason = "__FB_DLLREASON__"

	''
	proc = symbPreAddProc( NULL )

	'' instance
	symbAddProcParam( proc, "__FB_DLLINSTANCE__", _
					  FB_DATATYPE_POINTER+FB_DATATYPE_VOID, NULL, 1, _
					  FB_POINTERSIZE, FB_PARAMMODE_BYVAL, INVALID, FALSE, NULL )

	'' reason
	symbAddProcParam( proc, fbdllreason, _
					  FB_DATATYPE_UINT, NULL, 0, _
					  FB_INTEGERSIZE, FB_PARAMMODE_BYVAL, INVALID, FALSE, NULL )

	'' reserved
	symbAddProcParam( proc, "__FB_DLLRESERVED__", _
					  FB_DATATYPE_POINTER+FB_DATATYPE_VOID, NULL, 1, _
					  FB_POINTERSIZE, FB_PARAMMODE_BYVAL, INVALID, FALSE, NULL )

	'' function DllMain( byval instance as any ptr, byval reason as uinteger, _
	''                   byval reserved as any ptr ) as integer
	proc = symbAddProc( proc, NULL, "DllMain", NULL, _
						FB_DATATYPE_INTEGER, NULL, 0, FB_SYMBATTRIB_PUBLIC, _
						FB_FUNCMODE_STDCALL )

    ''
	procnode = astProcBegin( proc, FALSE )

    symbSetProcIncFile( proc, INVALID )

	''
   	astAdd( astNewLABEL( astGetProcInitlabel( procnode ) ) )

   	'' function = TRUE
   	astAdd( astNewASSIGN( astNewVAR( symbLookupProcResult( proc ), _
   									 0, symbGetType( proc ) ), _
   						  astNewCONSTi( 1, symbGetType( proc ) ) ) )

	'' if( reason = DLL_PROCESS_ATTACH ) then

	param = symbFindByNameAndClass( fbdllreason, FB_SYMBCLASS_VAR )
	reason = astNewVAR( param, 0, symbGetType( param ) )
	label = symbAddLabel( NULL )
	astAdd( astNewBOP( AST_OP_NE, reason, astNewCONSTi( 1, FB_DATATYPE_UINT ), label, FALSE ) )

	''	main( 0, NULL )
    main = astNewCALL( env.main.proc )
    astNewARG( main, astNewCONSTi( 0, FB_DATATYPE_INTEGER ) )
    astNewARG( main, astNewCONSTi( NULL, FB_DATATYPE_POINTER+FB_DATATYPE_VOID ) )
    astAdd( main )

	'' end if
    astAdd( astNewLABEL( label ) )

   	''
   	astProcEnd( procnode, FALSE )

end sub

':::::
private sub hMainBegin( byval isdllmain as integer )
    dim as FBSYMBOL ptr proc
    dim as integer attrib

const fbargc = "__FB_ARGC__"
const fbargv = "__FB_ARGV__"

	''
	proc = symbPreAddProc( NULL )

	'' argc
	symbAddProcParam( proc, fbargc, _
					  FB_DATATYPE_INTEGER, NULL, 0, _
					  FB_INTEGERSIZE, FB_PARAMMODE_BYVAL, INVALID, FALSE, NULL )

	'' argv
	symbAddProcParam( proc, fbargv, _
					  FB_DATATYPE_POINTER+FB_DATATYPE_POINTER+FB_DATATYPE_CHAR, NULL, 2, _
					  FB_POINTERSIZE, FB_PARAMMODE_BYVAL, INVALID, FALSE, NULL )

	''
	if( isdllmain = FALSE ) then
		attrib = FB_SYMBATTRIB_PUBLIC
	else
		attrib = FB_SYMBATTRIB_PRIVATE
	end if

	'' function main cdecl( byval argc as integer, byval argv as zstring ptr ptr) as integer
	env.main.proc = symbAddProc( proc, NULL, fbGetEntryPoint( ), NULL, _
								 FB_DATATYPE_INTEGER, NULL, 0, _
								 attrib or FB_SYMBATTRIB_MAINPROC, _
								 FB_FUNCMODE_CDECL )

    ''
	env.main.node = astProcBegin( env.main.proc, TRUE )

    symbSetProcIncFile( env.main.proc, INVALID )

	env.main.argc = symbFindByNameAndClass( fbargc, FB_SYMBCLASS_VAR )
	env.main.argv = symbFindByNameAndClass( fbargv, FB_SYMBCLASS_VAR )

	''
    dim as ASTNODE ptr argc, argv

	'' call fb_Init
	argc = astNewVAR( env.main.argc, 0, symbGetType( env.main.argc ) )
	argv = astNewVAR( env.main.argv, 0, symbGetType( env.main.argv ) )

    '' init( argc, argv )
    env.main.initnode = rtlInitApp( argc, argv, isdllmain )

   	astAdd( astNewLABEL( astGetProcInitlabel( env.main.node ) ) )

end sub

':::::
private sub hModLevelBegin( )

	'' sub modlevel cdecl( ) constructor
	env.main.proc = symbAddProc( symbPreAddProc( NULL ), _
								 "{modlevel}", fbGetModuleEntry( ), NULL, _
								 FB_DATATYPE_VOID, NULL, 0, _
								 FB_SYMBATTRIB_PRIVATE or FB_SYMBATTRIB_CONSTRUCTOR or _
								 FB_SYMBATTRIB_MODLEVELPROC, _
								 FB_FUNCMODE_CDECL )

    ''
	env.main.node = astProcBegin( env.main.proc, TRUE )

    symbSetProcIncFile( env.main.proc, INVALID )
    symbSetIsCalled( env.main.proc )

   	astAdd( astNewLABEL( astGetProcInitlabel( env.main.node ) ) )

end sub

'':::::
sub fbMainBegin( )
    dim as integer isdllmain

	if( env.outf.ismain ) then
		isdllmain = FALSE
		if( env.clopt.target = FB_COMPTARGET_WIN32 ) then
			if( env.clopt.outtype = FB_OUTTYPE_DYNAMICLIB ) then
				isdllmain = TRUE
			end if
		end if

		hMainBegin( isdllmain )

		if( isdllmain ) then
			hDllMainBegin( )
		end if

	else
		hModLevelBegin( )
	end if

end sub

'':::::
private sub hMainEnd( byval isdllmain as integer )

    '' set default data label (def label isn't global as it could clash with other
    '' modules, so DataRestore alone can't figure out where to start)
    if( symbFindByNameAndClass( FB_DATALABELNAME, FB_SYMBCLASS_LABEL ) <> NULL ) then
    	rtlDataRestore( NULL, env.main.initnode, TRUE )
    end if

	'' if main(), 0 will be returned to crt
	astProcEnd( env.main.node, isdllmain = FALSE )

end sub


'':::::
private sub hModLevelEnd( )

	''
	astProcEnd( env.main.node, FALSE )

end sub

'':::::
sub fbMainEnd( )
	dim as integer isdllmain

    if( env.outf.ismain ) then
		isdllmain = FALSE
		if( env.clopt.target = FB_COMPTARGET_WIN32 ) then
			if( env.clopt.outtype = FB_OUTTYPE_DYNAMICLIB ) then
				isdllmain = TRUE
			end if
		end if

    	hMainEnd( isdllmain )

    else
    	hModLevelEnd( )
    end if

end sub
