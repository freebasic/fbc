''
'' $Id$
'' Auxiliary functions for building Lua libraries
'' See Copyright Notice in lua.h
''


#ifndef lauxlib_h_
#define lauxlib_h_

#include once "Lua/lua.bi"

#ifndef LUALIB_API
#define LUALIB_API	LUA_API
#endif


type luaL_reg
  name	as byte ptr
  func	as lua_CFunction
end type


declare sub luaL_openlib LUALIB_API alias "luaL_openlib"  (byval L as lua_State ptr, byval libname as zstring ptr, byval l as luaL_reg ptr, byval nup as integer)
declare function luaL_getmetafield LUALIB_API alias "luaL_getmetafield"  (byval L as lua_State ptr, byval obj as integer, byval e as zstring ptr) as integer
declare function luaL_callmeta LUALIB_API alias "luaL_callmeta"  (byval L as lua_State ptr, byval obj as integer, byval e as zstring ptr) as integer
declare function luaL_typerror LUALIB_API alias "luaL_typerror"  (byval L as lua_State ptr, byval narg as integer, byval tname as zstring ptr) as integer
declare function luaL_argerror LUALIB_API alias "luaL_argerror"  (byval L as lua_State ptr, byval numarg as integer, byval extramsg as zstring ptr) as integer
declare function luaL_checklstring LUALIB_API alias "luaL_checklstring" (byval L as lua_State ptr, byval numArg as integer, byval l as integer ptr) as zstring ptr
declare function luaL_optlstring LUALIB_API alias "luaL_optlstring" (byval L as lua_State ptr, byval numArg as integer, byval def as zstring ptr, byval l as integer ptr) as zstring ptr
declare function luaL_checknumber LUALIB_API alias "luaL_checknumber" (byval L as lua_State ptr, byval numArg as integer) as lua_Number
declare function luaL_optnumber LUALIB_API alias "luaL_optnumber" (byval L as lua_State ptr, byval nArg as integer, byval def as lua_Number) as lua_Number

declare sub luaL_checkstack LUALIB_API alias "luaL_checkstack"  (byval L as lua_State ptr, byval sz as integer, byval msg as zstring ptr)
declare sub luaL_checktype LUALIB_API alias "luaL_checktype"  (byval L as lua_State ptr, byval narg as integer, byval t as integer)
declare sub luaL_checkany LUALIB_API alias "luaL_checkany"  (byval L as lua_State ptr, byval narg as integer)

declare function luaL_newmetatable LUALIB_API alias "luaL_newmetatable"  (byval L as lua_State ptr, byval tname as zstring ptr) as integer
declare sub luaL_getmetatable LUALIB_API alias "luaL_getmetatable"  (byval L as lua_State ptr, byval tname as zstring ptr)
declare function luaL_checkudata LUALIB_API alias "luaL_checkudata" (byval L as lua_State ptr, byval ud as integer, byval tname as zstring ptr) as any ptr

declare sub luaL_where LUALIB_API alias "luaL_where"  (byval L as lua_State ptr, byval lvl as integer)
declare function luaL_error LUALIB_API alias "luaL_error"  (byval L as lua_State ptr, byval fmt as zstring ptr, ...) as integer

declare function luaL_findstring LUALIB_API alias "luaL_findstring"  (byval st as zstring ptr, byval lst as byte ptr) as integer

declare function luaL_ref LUALIB_API alias "luaL_ref"  (byval L as lua_State ptr, byval t as integer) as integer
declare sub luaL_unref LUALIB_API alias "luaL_unref"  (byval L as lua_State ptr, byval t as integer, byval ref as integer)

declare function luaL_getn LUALIB_API alias "luaL_getn"  (byval L as lua_State ptr, byval t as integer) as integer
declare sub luaL_setn LUALIB_API alias "luaL_setn"  (byval L as lua_State ptr, byval t as integer, byval n as integer)

declare function luaL_loadfile LUALIB_API alias "luaL_loadfile"  (byval L as lua_State ptr, byval filename as zstring ptr) as integer
declare function luaL_loadbuffer LUALIB_API alias "luaL_loadbuffer"  (byval L as lua_State ptr, byval buff as zstring ptr, byval sz as integer, byval name as zstring ptr) as integer



''
'' ===============================================================
'' some useful macros
'' ===============================================================
''

'''''#define luaL_argcheck(L, cond,numarg,extramsg) if (!(cond)) luaL_argerror(L, numarg,extramsg)
'''''#define luaL_checkstring(L,n)	(luaL_checklstring(L, (n), NULL))
'''''#define luaL_optstring(L,n,d)	(luaL_optlstring(L, (n), (d), NULL))
'''''#define luaL_checkint(L,n)	((int)luaL_checknumber(L, n))
'''''#define luaL_checklong(L,n)	((long)luaL_checknumber(L, n))
'''''#define luaL_optint(L,n,d)	((int)luaL_optnumber(L, n,(lua_Number)(d)))
'''''#define luaL_optlong(L,n,d)	((long)luaL_optnumber(L, n,(lua_Number)(d)))


''
'' =======================================================
'' Generic Buffer manipulation
'' =======================================================
''


#ifndef LUAL_BUFFERSIZE
#define LUAL_BUFFERSIZE	  8192
#endif


type luaL_Buffer
  p		as byte ptr
  lvl	as integer
  L 	as lua_State ptr
  buffer(0 to LUAL_BUFFERSIZE) as byte
end type

declare sub luaL_buffinit LUALIB_API alias "luaL_buffinit"  (byval L as lua_State ptr, byval B as luaL_Buffer ptr)
declare function luaL_prepbuffer LUALIB_API alias "luaL_prepbuffer" (byval B as luaL_Buffer ptr) as byte ptr
declare sub luaL_addlstring LUALIB_API alias "luaL_addlstring"  (byval B as luaL_Buffer ptr, byval s as zstring ptr, byval l as integer)
declare sub luaL_addstring LUALIB_API alias "luaL_addstring"  (byval B as luaL_Buffer ptr, byval s as zstring ptr)
declare sub luaL_addvalue LUALIB_API alias "luaL_addvalue"  (byval B as luaL_Buffer ptr)
declare sub luaL_pushresult LUALIB_API alias "luaL_pushresult"  (byval B as luaL_Buffer ptr)


#define luaL_putchar(B,c) if( B->p >= @B->buffer(LUAL_BUFFERSIZE) ) then luaL_prepbuffer( B ) end if : B->p = c : B->p += 1

#define luaL_addsize(B,n) B->p += (n)


'' }====================================================== ''



''
'' Compatibility macros and functions
''

declare function lua_dofile LUALIB_API alias "lua_dofile"  (byval L as lua_State ptr, byval filename as zstring ptr) as integer
declare function lua_dostring LUALIB_API alias "lua_dostring"  (byval L as lua_State ptr, byval str as zstring ptr) as integer
declare function lua_dobuffer LUALIB_API alias "lua_dobuffer"  (byval L as lua_State ptr, byval buff as zstring ptr, byval sz as integer, byval n as zstring ptr) as integer


#define luaL_check_lstr 	luaL_checklstring
#define luaL_opt_lstr 	luaL_optlstring 
#define luaL_check_number 	luaL_checknumber 
#define luaL_opt_number	luaL_optnumber
#define luaL_arg_check	luaL_argcheck
#define luaL_check_string	luaL_checkstring
#define luaL_opt_string	luaL_optstring
#define luaL_check_int	luaL_checkint
#define luaL_check_long	luaL_checklong
#define luaL_opt_int	luaL_optint
#define luaL_opt_long	luaL_optlong


#endif


