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

type FBMAINCTX
	node			as ASTPROCNODE ptr
	proc			as FBSYMBOL ptr
	argc			as FBSYMBOL ptr
	argv			as FBSYMBOL ptr
	initlabel		as FBSYMBOL ptr
	exitlabel		as FBSYMBOL ptr
	initnode		as ASTNODE ptr
end type

'' globals
	dim shared as FBMAINCTX ctx

':::::
private sub hDllMainBegin( )
    dim as FBSYMBOL ptr proc, arg, s, label, exitlabel, initlabel, argreason
   	dim as ASTNODE ptr reason, main
   	dim as ASTPROCNODE ptr procnode
    dim as integer argn

	''
	proc = symbPreAddProc( NULL )

	'' instance
	symbAddArg( proc, "{dllmain_instance}", _
				FB_DATATYPE_POINTER+FB_DATATYPE_VOID, NULL, 1, _
				FB_POINTERSIZE, FB_ARGMODE_BYVAL, INVALID, FALSE, NULL )

	'' reason
	symbAddArg( proc, "{dllmain_reason}", _
				FB_DATATYPE_UINT, NULL, 0, _
				FB_INTEGERSIZE, FB_ARGMODE_BYVAL, INVALID, FALSE, NULL )

	'' reserved
	symbAddArg( proc, "{dllmain_reserved}", _
				FB_DATATYPE_POINTER+FB_DATATYPE_VOID, NULL, 1, _
				FB_POINTERSIZE, FB_ARGMODE_BYVAL, INVALID, FALSE, NULL )

	''
	proc = symbAddProc( proc, NULL, strptr( "DllMain" ), NULL, _
						FB_DATATYPE_INTEGER, NULL, 0, FB_ALLOCTYPE_PUBLIC, _
						FB_FUNCMODE_STDCALL )

    symbSetProcIncFile( proc, INVALID )

    ''
	initlabel = symbAddLabel( NULL )
	exitlabel = symbAddLabel( NULL )

    ''
	procnode = astProcBegin( proc, initlabel, exitlabel, FALSE )

	''
	env.scope = 1
	env.currproc = proc

	arg = symbGetProcHeadArg( proc )
	argn = 1
	do while( arg <> NULL )

		s = symbAddArgAsVar( symbGetName( arg ), arg )
		if( argn = 2 ) then
			argreason = s
		end if

		arg = symbGetArgNext( arg )
		argn += 1
	loop

	symbAddProcResult( proc )

	''
   	astAdd( astNewLABEL( initlabel ) )

   	'' function = TRUE
   	s = symbLookupProcResult( proc )
   	astAdd( astNewASSIGN( astNewVAR( s, 0, symbGetType( proc ) ), _
   						  astNewCONSTi( 1, symbGetType( proc ) ) ) )

	'' if( reason = DLL_PROCESS_ATTACH ) then
	reason = astNewVAR( argreason, 0, symbGetType( argreason ) )
	label = symbAddLabel( NULL )
	astAdd( astNewBOP( IR_OP_NE, reason, astNewCONSTi( 1, FB_DATATYPE_UINT ), label, FALSE ) )

	''	main( 0, NULL )
    main = astNewFUNCT( ctx.proc )
    astNewPARAM( main, astNewCONSTi( 0, FB_DATATYPE_INTEGER ) )
    astNewPARAM( main, astNewCONSTi( NULL, FB_DATATYPE_POINTER+FB_DATATYPE_VOID ) )
    astAdd( main )

	'' end if
    astAdd( astNewLABEL( label ) )

   	''
   	astAdd( astNewLABEL( exitlabel ) )

   	'' load result
   	s = symbLookupProcResult( proc )
   	astAdd( astNewLOAD( astNewVAR( s, 0, symbGetType( proc ) ), _
   						symbGetType( proc ), _
   						TRUE ) )

   	astProcEnd( procnode )

	env.currproc = NULL
	env.scope = 0

end sub

':::::
private sub hMainBegin( byval isdllmain as integer )
    dim as FBSYMBOL ptr proc, arg
    dim as integer alloctype

	''
	proc = symbPreAddProc( NULL )

	'' argc
	symbAddArg( proc, "{argc}", _
				FB_DATATYPE_INTEGER, NULL, 0, _
				FB_INTEGERSIZE, FB_ARGMODE_BYVAL, INVALID, FALSE, NULL )

	'' argv
	symbAddArg( proc, "{argv}", _
				FB_DATATYPE_POINTER+FB_DATATYPE_POINTER+FB_DATATYPE_CHAR, NULL, 2, _
				FB_POINTERSIZE, FB_ARGMODE_BYVAL, INVALID, FALSE, NULL )

	''
	if( isdllmain = FALSE ) then
		alloctype = FB_ALLOCTYPE_PUBLIC
	else
		alloctype = FB_ALLOCTYPE_PRIVATE
	end if

	ctx.proc = symbAddProc( proc, NULL, fbGetEntryPoint( ), NULL, _
								 FB_DATATYPE_VOID, NULL, 0, _
								 alloctype or FB_ALLOCTYPE_MAINPROC, _
								 FB_FUNCMODE_CDECL )

    symbSetProcIncFile( ctx.proc, INVALID )

    ''
	ctx.initlabel = symbAddLabel( NULL )
	ctx.exitlabel = symbAddLabel( NULL )

    ''
	ctx.node = astProcBegin( ctx.proc, _
								  ctx.initlabel, _
								  ctx.exitlabel, _
								  TRUE )

	''
	env.scope = 1
	env.currproc = ctx.proc

	arg = symbGetProcHeadArg( ctx.proc )
	ctx.argc = symbAddArgAsVar( symbGetName( arg ), arg )
	arg = symbGetProcTailArg( ctx.proc )
	ctx.argv = symbAddArgAsVar( symbGetName( arg ), arg )

	'' symbols declared in main() must go to the global tables, as main() has
	'' no beginning or end, all include files are parsed "inside" it, pure hack..
	symbSetSymbolTb( NULL )
	env.currproc = NULL
	env.scope = 0

	''
    dim as ASTNODE ptr argc, argv

	'' call fb_Init
	argc = astNewVAR( ctx.argc, 0, symbGetType( ctx.argc ) )
	argv = astNewVAR( ctx.argv, 0, symbGetType( ctx.argv ) )

    '' init( argc, argv )
    ctx.initnode = rtlInitApp( argc, argv, isdllmain )

   	astAdd( astNewLABEL( ctx.initlabel ) )

end sub

':::::
private sub hModLevelBegin( )
    dim as FBSYMBOL ptr proc

	''
	proc = symbAddProc( symbPreAddProc( NULL ), _
						strptr( "{main}" ), fbGetModuleEntry( ), NULL, _
						FB_DATATYPE_VOID, NULL, 0, _
						FB_ALLOCTYPE_PRIVATE or FB_ALLOCTYPE_CONSTRUCTOR or _
						FB_ALLOCTYPE_MODLEVELPROC, _
						FB_FUNCMODE_CDECL )

    symbSetProcIncFile( proc, INVALID )
    symbSetProcIsCalled( proc, TRUE )

    ''
	ctx.initlabel = symbAddLabel( NULL )
	ctx.exitlabel = symbAddLabel( NULL )

    ''
	ctx.node = astProcBegin( proc, _
								  ctx.initlabel, _
								  ctx.exitlabel, _
								  TRUE )

	'' see hMainBegin..
	symbSetSymbolTb( NULL )
	env.currproc = NULL
	env.scope = 0

   	astAdd( astNewLABEL( ctx.initlabel ) )

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

   	astAdd( astNewLABEL( ctx.exitlabel ) )

    '' end( 0 )
    if( isdllmain = FALSE ) then
    	rtlExitApp( NULL )
    end if

    '' set default data label (def label isn't global as it could clash with other
    '' modules, so DataRestore alone can't figure out where to start)
    if( symbFindByNameAndClass( FB_DATALABELNAME, FB_SYMBCLASS_LABEL ) <> NULL ) then
    	rtlDataRestore( NULL, ctx.initnode, TRUE )
    end if

	''
	astProcEnd( ctx.node )

end sub


'':::::
private sub hModLevelEnd( )

   	astAdd( astNewLABEL( ctx.exitlabel ) )

	''
	astProcEnd( ctx.node )

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
