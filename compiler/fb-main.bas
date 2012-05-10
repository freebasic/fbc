'' prolog and epilog for the implicit main() function
''
'' chng: jun/2005 written [v1ctor]
''


#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "symb.bi"

':::::
private sub hDllMainBegin_Win32 ( )

    dim as FBSYMBOL ptr proc, label, param
	dim as ASTNODE ptr reason, main
    dim as integer argn

const fbdllreason = "__FB_DLLREASON__"

	''
	proc = symbPreAddProc( NULL )

	'' instance
	symbAddProcParam( proc, "__FB_DLLINSTANCE__", typeAddrOf( FB_DATATYPE_VOID ), NULL, _
	                  FB_POINTERSIZE, FB_PARAMMODE_BYVAL, 0, NULL )

	'' reason
	param = symbAddProcParam( proc, fbdllreason, FB_DATATYPE_UINT, NULL, _
	                          FB_INTEGERSIZE, FB_PARAMMODE_BYVAL, 0, NULL )

	'' reserved
	symbAddProcParam( proc, "__FB_DLLRESERVED__", typeAddrOf( FB_DATATYPE_VOID ), NULL, _
	                  FB_POINTERSIZE, FB_PARAMMODE_BYVAL, 0, NULL )

	'' function DllMain stdcall( byval instance as any ptr, byval reason as uinteger, _
	''                           byval reserved as any ptr ) as integer
	proc = symbAddProc( proc, NULL, "DllMain", _
						FB_DATATYPE_INTEGER, NULL, _
						FB_SYMBATTRIB_PUBLIC, _
						env.target.stdcall )

	astProcBegin( proc, FALSE )
	astAdd( astNewLABEL( astGetProcInitlabel( ast.proc.curr ) ) )

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

	astProcEnd( FALSE )

end sub

':::::
private sub hDllMainBegin_GlobCtor ( )
    dim as FBSYMBOL ptr proc, label
   	dim as ASTNODE ptr main

	'' sub ctor cdecl( )
	proc = symbAddProc( symbPreAddProc( NULL ), NULL, "__fb_DllMain_ctor", _
						FB_DATATYPE_VOID, NULL, _
						FB_SYMBATTRIB_PRIVATE, _
						FB_FUNCMODE_CDECL )

	astProcBegin( proc, FALSE )
	symbAddGlobalCtor( proc )

   	astAdd( astNewLABEL( astGetProcInitlabel( ast.proc.curr ) ) )

	'' main( 0, NULL )
    main = astNewCALL( env.main.proc )
    astNewARG( main, astNewCONSTi( 0, FB_DATATYPE_INTEGER ) )
    astNewARG( main, astNewCONSTi( NULL, typeAddrOf( FB_DATATYPE_VOID ) ) )

	'' tell the emitter to not allocate a result
	astSetType( main, FB_DATATYPE_VOID, NULL )

    astAdd( main )

	astProcEnd( FALSE )

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
	env.main.argc = symbAddProcParam( proc, fbargc, FB_DATATYPE_INTEGER, NULL, _
	                                  FB_INTEGERSIZE, FB_PARAMMODE_BYVAL, 0, NULL )

	'' argv
	env.main.argv = symbAddProcParam( proc, fbargv, typeMultAddrOf( FB_DATATYPE_CHAR, 2 ), NULL, _
	                                  FB_POINTERSIZE, FB_PARAMMODE_BYVAL, 0, NULL )

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
	env.main.proc = symbAddProc( proc, NULL, id, _
								 FB_DATATYPE_INTEGER, NULL, _
								 attrib, _
								 FB_FUNCMODE_CDECL )

    symbSetIsMainProc( env.main.proc )

	astProcBegin( env.main.proc, TRUE )

	env.main.argc = symbGetParamVar( env.main.argc )
	env.main.argv = symbGetParamVar( env.main.argv )

	''
    dim as ASTNODE ptr argc, argv

	'' call fb_Init
	argc = astNewVAR( env.main.argc, 0, symbGetFullType( env.main.argc ) )
	argv = astNewVAR( env.main.argv, 0, symbGetFullType( env.main.argv ) )

    '' init( argc, argv )
    env.main.initnode = rtlInitApp( argc, argv, isdllmain )

   	astAdd( astNewLABEL( astGetProcInitlabel( ast.proc.curr ) ) )

end sub

':::::
private sub hModLevelBegin( )

	'' sub modlevel cdecl( ) constructor
	env.main.proc = symbAddProc( symbPreAddProc( NULL ), _
								 "{modlevel}", fbGetModuleEntry( ), _
								 FB_DATATYPE_VOID, NULL, _
								 FB_SYMBATTRIB_PRIVATE, _
								 FB_FUNCMODE_CDECL )

    symbSetIsModLevelProc( env.main.proc )

    symbAddGlobalCtor( env.main.proc )

	astProcBegin( env.main.proc, TRUE )
    symbSetIsCalled( env.main.proc )
	astAdd( astNewLABEL( astGetProcInitlabel( ast.proc.curr ) ) )

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
	astProcEnd( isdllmain = FALSE )

end sub


'':::::
private sub hModLevelEnd( )
	astProcEnd( FALSE )
end sub

'':::::
sub fbMainEnd( )

    if( env.outf.ismain ) then
    	hMainEnd( env.clopt.outtype = FB_OUTTYPE_DYNAMICLIB )

    else
    	hModLevelEnd( )
    end if

end sub
