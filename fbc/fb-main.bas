''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\symb.bi"

':::::
private sub hDllMainBegin_Win32 ( )

    dim as FBSYMBOL ptr proc, label, param
   	dim as ASTNODE ptr reason, main, procnode
    dim as integer argn

const fbdllreason = "__FB_DLLREASON__"

	''
	proc = symbPreAddProc( NULL )

	'' instance
	symbAddProcParam( proc, "__FB_DLLINSTANCE__", NULL, _
					  typeAddrOf( FB_DATATYPE_VOID ), NULL, _
					  FB_POINTERSIZE, FB_PARAMMODE_BYVAL, _
					  0, NULL )

	'' reason
	param = symbAddProcParam( proc, fbdllreason, NULL, _
					  		  FB_DATATYPE_UINT, NULL, _
					  		  FB_INTEGERSIZE, FB_PARAMMODE_BYVAL, _
					  		  0, NULL )

	'' reserved
	symbAddProcParam( proc, "__FB_DLLRESERVED__", NULL, _
					  typeAddrOf( FB_DATATYPE_VOID ), NULL, _
					  FB_POINTERSIZE, FB_PARAMMODE_BYVAL, 0, NULL )

	'' function DllMain( byval instance as any ptr, byval reason as uinteger, _
	''                   byval reserved as any ptr ) as integer
	proc = symbAddProc( proc, NULL, "DllMain", NULL, _
						FB_DATATYPE_INTEGER, NULL, _
						FB_SYMBATTRIB_PUBLIC, _
						FB_FUNCMODE_STDCALL )

    ''
	procnode = astProcBegin( proc, FALSE )

    symbSetProcIncFile( proc, NULL )

	''
   	astAdd( astNewLABEL( astGetProcInitlabel( procnode ) ) )

   	'' function = TRUE
   	astAdd( astNewASSIGN( astNewVAR( symbGetProcResult( proc ), _
   									 0, symbGetFullType( proc ) ), _
   						  astNewCONSTi( 1, symbGetType( proc ) ) ) )

	'' if( reason = DLL_PROCESS_ATTACH ) then

	param = symbGetParamVar( param )
	reason = astNewVAR( param, 0, symbGetFullType( param ) )
	label = symbAddLabel( NULL )
	astAdd( astNewBOP( AST_OP_NE, _
					   reason, _
					   astNewCONSTi( 1, FB_DATATYPE_UINT ), _
					   label, _
					   AST_OPOPT_NONE ) )

	''	main( 0, NULL )
    main = astNewCALL( env.main.proc )
    astNewARG( main, astNewCONSTi( 0, FB_DATATYPE_INTEGER ) )
    astNewARG( main, astNewCONSTi( NULL, typeAddrOf( FB_DATATYPE_VOID ) ) )

	'' tell the emitter to not allocate a result
	astSetType( main, FB_DATATYPE_VOID, NULL )

    astAdd( main )

	'' end if
    astAdd( astNewLABEL( label ) )

   	''
   	astProcEnd( procnode, FALSE )

end sub

':::::
private sub hDllMainBegin_GlobCtor ( )
    dim as FBSYMBOL ptr proc, label
   	dim as ASTNODE ptr main, procnode

	'' sub ctor cdecl( )
	proc = symbAddProc( symbPreAddProc( NULL ), NULL, "__fb_DllMain_ctor", NULL, _
						FB_DATATYPE_VOID, NULL, _
						FB_SYMBATTRIB_PRIVATE, _
						FB_FUNCMODE_CDECL )

	procnode = astProcBegin( proc, FALSE )

    symbSetProcIncFile( proc, NULL )
	symbAddGlobalCtor( proc )

   	astAdd( astNewLABEL( astGetProcInitlabel( procnode ) ) )

	'' main( 0, NULL )
    main = astNewCALL( env.main.proc )
    astNewARG( main, astNewCONSTi( 0, FB_DATATYPE_INTEGER ) )
    astNewARG( main, astNewCONSTi( NULL, typeAddrOf( FB_DATATYPE_VOID ) ) )

	'' tell the emitter to not allocate a result
	astSetType( main, FB_DATATYPE_VOID, NULL )

    astAdd( main )

   	astProcEnd( procnode, FALSE )

end sub

':::::
private sub hDllMainBegin ( )

	'' handle systems where main() or dllmain() won't be called automatically
	select case env.clopt.target
	case FB_COMPTARGET_WIN32
		hDllMainBegin_Win32( )
	case else
		hDllMainBegin_GlobCtor( )
	end select

end sub

':::::
private sub hMainBegin _
	( _
		byval isdllmain as integer _
	)

    dim as FBSYMBOL ptr proc

const fbargc = "__FB_ARGC__"
const fbargv = "__FB_ARGV__"

	''
	proc = symbPreAddProc( NULL )

	'' argc
	env.main.argc = symbAddProcParam( proc, fbargc, NULL, _
					  			   	  FB_DATATYPE_INTEGER, NULL, _
					  				  FB_INTEGERSIZE, FB_PARAMMODE_BYVAL, _
					  				  0, NULL )

	'' argv
	env.main.argv = symbAddProcParam( proc, fbargv, NULL, _
					  				  typeMultAddrOf( FB_DATATYPE_CHAR, 2 ), NULL, _
					  				  FB_POINTERSIZE, FB_PARAMMODE_BYVAL, _
					  				  0, NULL )

	'' if it's a dll, the main() function should be private
	var attrib = FB_SYMBATTRIB_PUBLIC
	var id = fbGetEntryPoint( )
	if( isdllmain ) then
		attrib = FB_SYMBATTRIB_PRIVATE
		'' if it's high level, give it a random name
		if( irGetOption( IR_OPT_HIGHLEVEL ) ) then
			id = *hMakeTmpStrNL()
		end if
	end if

	'' function main cdecl( byval argc as integer, byval argv as zstring ptr ptr) as integer
	env.main.proc = symbAddProc( proc, NULL, id, NULL, _
								 FB_DATATYPE_INTEGER, NULL, _
								 attrib, _
								 FB_FUNCMODE_CDECL )

    symbSetIsMainProc( env.main.proc )

    ''
	env.main.node = astProcBegin( env.main.proc, TRUE )

    symbSetProcIncFile( env.main.proc, NULL )

	env.main.argc = symbGetParamVar( env.main.argc )
	env.main.argv = symbGetParamVar( env.main.argv )

	''
    dim as ASTNODE ptr argc, argv

	'' call fb_Init
	argc = astNewVAR( env.main.argc, 0, symbGetFullType( env.main.argc ) )
	argv = astNewVAR( env.main.argv, 0, symbGetFullType( env.main.argv ) )

    '' init( argc, argv )
    env.main.initnode = rtlInitApp( argc, argv, isdllmain )

   	astAdd( astNewLABEL( astGetProcInitlabel( env.main.node ) ) )

end sub

':::::
private sub hModLevelBegin( )

	'' sub modlevel cdecl( ) constructor
	env.main.proc = symbAddProc( symbPreAddProc( NULL ), _
								 "{modlevel}", fbGetModuleEntry( ), NULL, _
								 FB_DATATYPE_VOID, NULL, _
								 FB_SYMBATTRIB_PRIVATE, _
								 FB_FUNCMODE_CDECL )

    symbSetIsModLevelProc( env.main.proc )

    symbAddGlobalCtor( env.main.proc )

    ''
	env.main.node = astProcBegin( env.main.proc, TRUE )

    symbSetProcIncFile( env.main.proc, NULL )
    symbSetIsCalled( env.main.proc )

   	astAdd( astNewLABEL( astGetProcInitlabel( env.main.node ) ) )

end sub

'':::::
sub fbMainBegin( )
	if( env.outf.ismain ) then
		hMainBegin( env.clopt.outtype = FB_OUTTYPE_DYNAMICLIB )

		if( env.clopt.outtype = FB_OUTTYPE_DYNAMICLIB ) then
			hDllMainBegin( )
		end if

	else
		hModLevelBegin( )
	end if

end sub

'':::::
private sub hMainEnd _
	( _
		byval isdllmain as integer _
	)

    '' set default data label (def label isn't global as it could clash with other
    '' modules, so DataRestore alone can't figure out where to start)
    if( astGetFirstDataStmtSymbol( ) <> NULL ) then
    	rtlDataRestore( NULL, env.main.initnode )
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

    if( env.outf.ismain ) then
    	hMainEnd( env.clopt.outtype = FB_OUTTYPE_DYNAMICLIB )

    else
    	hModLevelEnd( )
    end if

end sub
