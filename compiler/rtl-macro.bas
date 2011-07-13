'' intrinsic macros (RGB, BIT, ASSERT, ...)
''
'' chng: oct/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "rtl.bi"

	dim shared as FB_RTL_MACRODEF macrodata(0 to 15) = _
	{ _
		/' #define RGB(r,g,b) ((cuint(r) shl 16) or (cuint(g) shl 8) or cuint(b) or &hFF000000) '/ _
		( _
			@"RGB", _
	 		FB_RTL_OPT_NOQB, _
	 		3, _
	 		{ _
	 			@"R", @"G", @"B" _
	 		}, _
	 		{ _
	 			( FB_DEFTOK_TYPE_TEX, @"((cuint(" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") shl 16) or (cuint(" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 1 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") shl 8) or cuint(" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 2 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") or &hFF000000)" ), _
	 			( -1 ) _
	 		} _
	 	), _
		/' #define RGBA(r,g,b,a) ((cuint(r) shl 16) or (cuint(g) shl 8) or cuint(b) or (cuint(a) shl 24)) '/ _
		( _
			@"RGBA", _
			FB_RTL_OPT_NOQB, _
	 		4, _
	 		{ _
	 			@"R", @"G", @"B", @"A" _
	 		}, _
	 		{ _
	 			( FB_DEFTOK_TYPE_TEX, @"((cuint(" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") shl 16) or (cuint(" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 1 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") shl 8) or cuint(" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 2 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") or (cuint(" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 3 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") shl 24))" ), _
	 			( -1 ) _
	 		} _
	 	), _
		/' #define va_arg(a,t) peek( t, a ) '/ _
		( _
			@"VA_ARG", _
	 		FB_RTL_OPT_NOQB or FB_RTL_OPT_NOGCC, _
	 		2, _
	 		{ _
	 			@"A", @"T" _
	 		}, _
	 		{ _
	 			( FB_DEFTOK_TYPE_TEX, @"peek(" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 1 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @"," ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @")" ), _
	 			( -1 ) _
	 		} _
	 	), _
		/' #define va_next(a,t) (a + len( t )) '/ _
		( _
			@"VA_NEXT", _
	 		FB_RTL_OPT_NOQB or FB_RTL_OPT_NOGCC, _
	 		2, _
	 		{ _
	 			@"A", @"T" _
	 		}, _
	 		{ _
	 			( FB_DEFTOK_TYPE_TEX, @"(cast(" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 1 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @" ptr," ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") + 1)" ), _
	 			( -1 ) _
	 		} _
	 	), _
		/' #define ASSERT(e) if (e) = FALSE then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e) '/ _
		( _
			@"ASSERT", _
	 		FB_RTL_OPT_DBGONLY or FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			@"E" _
	 		}, _
	 		{ _
	 			( FB_DEFTOK_TYPE_TEX, @"if (" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, " ), _
	 			( FB_DEFTOK_TYPE_PARAMSTR, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") end if" ), _
	 			( -1 ) _
	 		} _
	 	), _
		/' #define ASSERTWARN(e) if (e) = FALSE then fb_AssertWarn(__FILE__, __LINE__, __FUNCTION__, #e) '/ _
		( _
			@"ASSERTWARN", _
	 		FB_RTL_OPT_DBGONLY or FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			@"E" _
	 		}, _
			{ _
	 			( FB_DEFTOK_TYPE_TEX, @"if (" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") = 0 then fb_AssertWarn(__FILE__, __LINE__, __FUNCTION__, " ), _
	 			( FB_DEFTOK_TYPE_PARAMSTR, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") end if" ), _
	 			( -1 ) _
	 		} _
	 	), _
		/' #define OFFSETOF(type_,field_) cint( @cast( type_ ptr, 0 )->field_ ) '/ _
		( _
			@"OFFSETOF", _
	 		FB_RTL_OPT_NOQB, _
	 		2, _
	 		{ _
	 			@"T", @"F" _
	 		}, _
	 		{ _
	 			( FB_DEFTOK_TYPE_TEX, @"cint( @cast( " ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @" ptr, 0 )->" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 1 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @" )" ), _
	 			( -1 ) _
	 		} _
	 	), _
        /' ... '/ _
		( _
			@"__FB_MIN_VERSION__", _
     		FB_RTL_OPT_NOQB, _
     		3, _
     		{ _
     			@"MAJOR", @"MINOR", @"PATCH_LEVEL" _
     		}, _
	 		{ _
	 			( FB_DEFTOK_TYPE_TEX, @"((__FB_VER_MAJOR__ > (" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @")) or ((__FB_VER_MAJOR__ = (" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @")) and ((__FB_VER_MINOR__ > (" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 1 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @")) or (__FB_VER_MINOR__ = (" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 1 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") and __FB_VER_PATCH__ >= (" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 2 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @")))))" ), _
	 			( -1 ) _
	 		} _
	 	), _
		/' #define LOWORD(x) (cuint(x) and &h0000FFFF) '/ _
		( _
			@"LOWORD", _
	 		FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			@"X" _
	 		}, _
	 		{ _
	 			( FB_DEFTOK_TYPE_TEX, @"(cuint(" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") and &h0000FFFF)" ), _
	 			( -1 ) _
	 		} _
	 	), _
		/' #define HIWORD(x) (cyint(x) shr 16) '/ _
		( _
			@"HIWORD", _
	 		FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			@"X" _
	 		}, _
	 		{ _
	 			( FB_DEFTOK_TYPE_TEX, @"(cuint(" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") shr 16)" ), _
	 			( -1 ) _
	 		} _
	 	), _
		/' #define LOBYTE(x) (cuint(x) and &h000000FF) '/ _
		( _
			@"LOBYTE", _
	 		FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			@"X" _
	 		}, _
	 		{ _
	 			( FB_DEFTOK_TYPE_TEX, @"(cuint(" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") and &h000000FF)" ), _
	 			( -1 ) _
	 		} _
	 	), _
		/' #define HIBYTE(x) ((cuint(x) and &h0000FF00) shr 8) '/ _
		( _
			@"HIBYTE", _
	 		FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			@"X" _
	 		}, _
	 		{ _
	 			( FB_DEFTOK_TYPE_TEX, @"((cuint(" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") and &h0000FF00) shr 8)" ), _
	 			( -1 ) _
	 		} _
	 	), _
		/' #define BIT(x,y) (((x) and (cast(typeof(x), 1) shl (y))) <> 0) '/ _
		( _
			@"BIT", _
	 		FB_RTL_OPT_NOQB, _
	 		2, _
	 		{ _
	 			@"X", @"Y" _
	 		}, _
	 		{ _
	 			( FB_DEFTOK_TYPE_TEX, @"(((" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") and (cast(typeof(" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @"), 1) shl (" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 1 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @"))) <> 0)" ), _
	 			( -1 ) _
	 		} _
	 	), _
		/' #define BITSET(x,y) ((x) or (cast(typeof(x), 1) shl (y))) '/ _
		( _
			@"BITSET", _
	 		FB_RTL_OPT_NOQB, _
	 		2, _
	 		{ _
	 			@"X", @"Y" _
	 		}, _
	 		{ _
	 			( FB_DEFTOK_TYPE_TEX, @"((" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") or (cast(typeof(" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @"), 1) shl (" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 1 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @")))" ), _
	 			( -1 ) _
	 		} _
	 	), _
		/' #define BITRESET(x,y) ((x) and not (cast(typeof(x), 1) shl (y))) '/ _
		( _
			@"BITRESET", _
	 		FB_RTL_OPT_NOQB, _
	 		2, _
	 		{ _
	 			@"X", @"Y" _
	 		}, _
	 		{ _
	 			( FB_DEFTOK_TYPE_TEX, @"((" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @") and not (cast(typeof(" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 0 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @"), 1) shl (" ), _
	 			( FB_DEFTOK_TYPE_PARAM, cast( any ptr, 1 ) ), _
	 			( FB_DEFTOK_TYPE_TEX, @")))" ), _
	 			( -1 ) _
	 		} _
	 	), _
		/' EOL '/ _
		( _
			NULL _
		) _
	}

'':::::
sub rtlAddIntrinsicMacros _
	( _
		byval macdef as FB_RTL_MACRODEF ptr _
	)

	dim as FB_DEFPARAM ptr param_head = any, lastparam = any
	dim as FB_DEFTOK ptr tok = any, tok_head = any
	dim as FB_RTL_MACROTOKEN ptr ptk = any

	'' for each macro..
	do
		var flags = FB_DEFINE_FLAGS_NONE
		if( macdef->name = NULL ) then
			exit do
		end if

		param_head = NULL
		lastparam = NULL

		'' for each parameter..
		for i as integer = 0 to macdef->params-1
			lastparam = symbAddDefineParam( lastparam, macdef->paramTb(i) )
			if( param_head = NULL ) then
				param_head = lastparam
			end if
		next

		'' for each token..
		tok_head = NULL

    	dim as integer addbody = TRUE

    	'' only if debugging?
    	if( (macdef->options and FB_RTL_OPT_DBGONLY) <> 0 ) then
    		if( env.clopt.debug = FALSE ) then
    			addbody = FALSE
    		end if
    	end if

    	'' not supported in high-level IR?
    	if( (macdef->options and FB_RTL_OPT_NOGCC) <> 0 ) then
    		if( irGetOption( IR_OPT_HIGHLEVEL ) ) then
    			addbody = FALSE
                flags or= FB_DEFINE_FLAGS_NOGCC
    		end if
    	end if

    	if( addbody ) then
			tok = NULL

    		ptk = @macdef->tokenTb(0)
    		do
    			if( ptk->type = -1 ) then
    				exit do
    			end if

				tok = symbAddDefineTok( tok, ptk->type )
				if( tok_head = NULL ) then
					tok_head = tok
				end if

    			select case ptk->type
    			case FB_DEFTOK_TYPE_PARAM, FB_DEFTOK_TYPE_PARAMSTR
    				symbGetDefTokParamNum( tok ) = cint( ptk->data )

    			case FB_DEFTOK_TYPE_TEX
	    			ZstrAssign( @symbGetDefTokText( tok ), cast( zstring ptr, ptk->data ) )
    			end select

        		'' next
        		ptk += 1
    		loop
    	end if

		'' add the '__' prefix if the macro wasn't present in QB and we are in '-lang qb' mode
		dim as zstring ptr mname = macdef->name
        if( (macdef->options and FB_RTL_OPT_NOQB) <> 0 ) then
    		if( fbLangIsSet( FB_LANG_QB ) ) then
        		static as string tmp
        		tmp = "__" + *mname
        		mname = strptr( tmp )
    		end if
    	end if

       	symbAddDefineMacro( mname, tok_head, macdef->params, param_head, flags )

		'' next
        macdef += 1
	loop

end sub

'':::::
sub rtlMacroModInit( )

	rtlAddIntrinsicMacros( @macrodata(0) )

end sub

'':::::
sub rtlMacroModEnd( )

	'' macros will be deleted when symbEnd is called

end sub

