''
'' Lua (script language) example
''
'' translated from a PB source, originally written by Marco Pontello (marcopon[at]myrealbox.com)
''

#include once "Lua/lua.bi"
#include once "Lua/lauxlib.bi"
#include once "Lua/lualib.bi"

function minmax cdecl(byval L as lua_State ptr) as long
	dim as integer argcount
	dim as double num, maxnum, minnum

	'' Get the number of arguments passed on the virtual stack
	'' by the calling lua code
	argcount = lua_gettop( L )

	'' Pop all parameters from the virtual stack and evaluate them
	for i as integer = 1 to argcount
		'' Peek the specified virtual stack element
		num = lua_tonumber( L, i )

		if( num > maxnum ) then
			maxnum = num
		end if
		if minnum = 0 then
			minnum = num
		else
			if( num < minnum ) then
				minnum = num
			end if
		end if
	next
  
	'' Push the results on the virtual stack
	lua_pushnumber( L, minnum )
	lua_pushnumber( L, maxnum )
  
	'' Return number of returned parameters
	function = 2
end function

private function my_lua_Alloc cdecl _
	( _
		byval ud as any ptr, _
		byval p as any ptr, _
		byval osize as uinteger, _
		byval nsize as uinteger _
	) as any ptr

	if( nsize = 0 ) then
		deallocate( p )
		function = NULL
	else
		function = reallocate( p, nsize )
	end if

end function

''
'' main
''
	dim L as lua_State ptr

	'' Create a lua state
	L = lua_newstate( @my_lua_Alloc, NULL )

#if 0
	'' Load only the base lua library (needed for 'print')
	lua_pushcfunction( L, @luaopen_base )
	lua_pushstring( L, "" )
	lua_call( L, 1, 0 )
#else
	'' Load all Lua libraries
	'' (including the base one, which is needed for 'print')
	luaL_openlibs( L )
#endif

	'' Register the function to be called from lua as MinMax
	lua_register( L, "MinMax", @minmax )

	'' Execute the lua script from a file
	luaL_dofile( L, exepath() + "/minmax.lua" )

	'' Release the lua state
	lua_close( L )

	print "Finished! Waiting for keypress to exit..."
	sleep
