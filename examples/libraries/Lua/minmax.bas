''
'' Lua (script language) example
''
'' translated from a PB source, originally written by Marco Pontello (marcopon[at]myrealbox.com)
''


#include once "Lua/lua.bi"
#include once "Lua/lauxlib.bi"
#include once "Lua/lualib.bi"


function minmax cdecl (byval L as lua_State ptr) as integer

	dim numpar as long
  	dim i as long
  	dim num as double
  	dim maxnum as double
  	dim minnum as double

  	' get the number of parameters passed on the virtual stack
  	' by the calling lua code

  	numpar = lua_gettop( L )

  	' pop all parameters from the vs and evaluate them
  	for i = 1 to numpar

    	' peek the specified vs element
    	num = lua_tonumber( L, i )

    	if( num > maxnum ) then
    		maxnum = num
    	end if
    	if minnum = 0 then
      		minnum = num
    	else
      		if( num < minnum ) then
      			minnum=  num
      		end if
    	end if
  	next i
  
  	' push the results on the vs
  	lua_pushnumber( L, minnum )
  	lua_pushnumber( L, maxnum )
  
  	' set number of returned parameters
  	minmax = 2

end function

''
'' main                                         
''
  	dim L as lua_State ptr

  	' create a lua state
  	L = lua_open( )

  	' load the base lua library (needed for 'print')
  	luaopen_base( L )

  	' register the function to be called from lua as MinMax
  	lua_register( L, "MinMax", @minmax )

  	' execute the lua script from a file
  	luaL_dofile( L, "minmax.lua" )

  	' release the lua state
  	lua_close( L )

  	print "finished! press any key"
  	sleep
