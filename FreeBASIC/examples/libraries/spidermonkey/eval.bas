''
'' to compile: fbc eval.bas common.bas
''



#include once "common.bi"

const DEFAULT_SCRIPT = "factorial.js"

    
'' main
    dim as string filename = trim( command( 1 ) )
    
    if( len( filename ) = 0 ) then
    	filename = DEFAULT_SCRIPT
    end if
    
    dim as string script = sm_load( filename )
    
    if( len( script ) = 0 ) then
    	end 1
    end if
    
    dim as sm ptr sm = sm_create( )
    
    if( sm = 0 ) then
    	end 1
    end if
    
    print "result: "; *sm_eval( sm, script )
    
    sm_destroy( sm )

