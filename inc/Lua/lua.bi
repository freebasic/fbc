''
''
'' lua -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __lua_bi__
#define __lua_bi__

#inclib "lua52"

#define LUA_VERSION_MAJOR "5"
#define LUA_VERSION_MINOR "2"
#define LUA_VERSION_NUM 502
#define LUA_VERSION_RELEASE "1"
#define LUA_VERSION "Lua 5.2"
#define LUA_RELEASE "Lua 5.2.1"
#define LUA_COPYRIGHT "Lua 5.2.1  Copyright (C) 1994-2012 Lua.org, PUC-Rio"
#define LUA_AUTHORS "R. Ierusalimschy, L. H. de Figueiredo, W. Celes"
#define LUA_SIGNATURE "Lua"
#define LUA_MULTRET (-1)
#define LUA_OK 0
#define LUA_YIELD 1
#define LUA_ERRRUN 2
#define LUA_ERRSYNTAX 3
#define LUA_ERRMEM 4
#define LUA_ERRGCMM 5
#define LUA_ERRERR 6

type lua_State as any
type lua_CFunction as function cdecl(byval as lua_State ptr) as integer
type lua_Reader as function cdecl(byval as lua_State ptr, byval as any ptr, byval as size_t ptr) as byte ptr
type lua_Writer as function cdecl(byval as lua_State ptr, byval as any ptr, byval as size_t, byval as any ptr) as integer
type lua_Alloc as sub cdecl(byval as any ptr, byval as any ptr, byval as size_t, byval as size_t)

#define LUA_TNONE (-1)
#define LUA_TNIL 0
#define LUA_TBOOLEAN 1
#define LUA_TLIGHTUSERDATA 2
#define LUA_TNUMBER 3
#define LUA_TSTRING 4
#define LUA_TTABLE 5
#define LUA_TFUNCTION 6
#define LUA_TUSERDATA 7
#define LUA_TTHREAD 8
#define LUA_NUMTAGS 9
#define LUA_MINSTACK 20
#define LUA_RIDX_MAINTHREAD 1
#define LUA_RIDX_GLOBALS 2
#define LUA_RIDX_LAST 2

type lua_Number as LUA_NUMBER
type lua_Integer as LUA_INTEGER
type lua_Unsigned as LUA_UNSIGNED

declare sub lua_close cdecl alias "lua_close" (byval L as lua_State ptr)
declare function lua_CFunction cdecl alias "lua_CFunction" (byval as lua_atpanic) as LUA_API
declare function lua_absindex cdecl alias "lua_absindex" (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_gettop cdecl alias "lua_gettop" (byval L as lua_State ptr) as integer
declare sub lua_settop cdecl alias "lua_settop" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_pushvalue cdecl alias "lua_pushvalue" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_remove cdecl alias "lua_remove" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_insert cdecl alias "lua_insert" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_replace cdecl alias "lua_replace" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_copy cdecl alias "lua_copy" (byval L as lua_State ptr, byval fromidx as integer, byval toidx as integer)
declare function lua_checkstack cdecl alias "lua_checkstack" (byval L as lua_State ptr, byval sz as integer) as integer
declare sub lua_xmove cdecl alias "lua_xmove" (byval from as lua_State ptr, byval to as lua_State ptr, byval n as integer)
declare function lua_isnumber cdecl alias "lua_isnumber" (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_isstring cdecl alias "lua_isstring" (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_iscfunction cdecl alias "lua_iscfunction" (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_isuserdata cdecl alias "lua_isuserdata" (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_type cdecl alias "lua_type" (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_typename cdecl alias "lua_typename" (byval L as lua_State ptr, byval tp as integer) as zstring ptr
declare function lua_Number cdecl alias "lua_Number" (byval as lua_tonumberx) as LUA_API
declare function lua_Integer cdecl alias "lua_Integer" (byval as lua_tointegerx) as LUA_API
declare function lua_Unsigned cdecl alias "lua_Unsigned" (byval as lua_tounsignedx) as LUA_API
declare function lua_toboolean cdecl alias "lua_toboolean" (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_tolstring cdecl alias "lua_tolstring" (byval L as lua_State ptr, byval idx as integer, byval len as size_t ptr) as zstring ptr
declare function size_t cdecl alias "size_t" (byval as lua_rawlen) as LUA_API
declare function lua_CFunction cdecl alias "lua_CFunction" (byval as lua_tocfunction) as LUA_API
declare function lua_touserdata cdecl alias "lua_touserdata" (byval L as lua_State ptr, byval idx as integer) as any ptr
declare function lua_topointer cdecl alias "lua_topointer" (byval L as lua_State ptr, byval idx as integer) as any ptr

#define LUA_OPADD 0
#define LUA_OPSUB 1
#define LUA_OPMUL 2
#define LUA_OPDIV 3
#define LUA_OPMOD 4
#define LUA_OPPOW 5
#define LUA_OPUNM 6

declare sub lua_arith cdecl alias "lua_arith" (byval L as lua_State ptr, byval op as integer)

#define LUA_OPEQ 0
#define LUA_OPLT 1
#define LUA_OPLE 2

declare function lua_rawequal cdecl alias "lua_rawequal" (byval L as lua_State ptr, byval idx1 as integer, byval idx2 as integer) as integer
declare function lua_compare cdecl alias "lua_compare" (byval L as lua_State ptr, byval idx1 as integer, byval idx2 as integer, byval op as integer) as integer
declare sub lua_pushnil cdecl alias "lua_pushnil" (byval L as lua_State ptr)
declare sub lua_pushnumber cdecl alias "lua_pushnumber" (byval L as lua_State ptr, byval n as lua_Number)
declare sub lua_pushinteger cdecl alias "lua_pushinteger" (byval L as lua_State ptr, byval n as lua_Integer)
declare sub lua_pushunsigned cdecl alias "lua_pushunsigned" (byval L as lua_State ptr, byval n as lua_Unsigned)
declare function lua_pushlstring cdecl alias "lua_pushlstring" (byval L as lua_State ptr, byval s as zstring ptr, byval l as size_t) as zstring ptr
declare function lua_pushstring cdecl alias "lua_pushstring" (byval L as lua_State ptr, byval s as zstring ptr) as zstring ptr
declare function lua_pushvfstring cdecl alias "lua_pushvfstring" (byval L as lua_State ptr, byval fmt as zstring ptr, byval argp as va_list) as zstring ptr
declare function lua_pushfstring cdecl alias "lua_pushfstring" (byval L as lua_State ptr, byval fmt as zstring ptr, ...) as zstring ptr
declare sub lua_pushcclosure cdecl alias "lua_pushcclosure" (byval L as lua_State ptr, byval fn as lua_CFunction, byval n as integer)
declare sub lua_pushboolean cdecl alias "lua_pushboolean" (byval L as lua_State ptr, byval b as integer)
declare sub lua_pushlightuserdata cdecl alias "lua_pushlightuserdata" (byval L as lua_State ptr, byval p as any ptr)
declare function lua_pushthread cdecl alias "lua_pushthread" (byval L as lua_State ptr) as integer
declare sub lua_getglobal cdecl alias "lua_getglobal" (byval L as lua_State ptr, byval var as zstring ptr)
declare sub lua_gettable cdecl alias "lua_gettable" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_getfield cdecl alias "lua_getfield" (byval L as lua_State ptr, byval idx as integer, byval k as zstring ptr)
declare sub lua_rawget cdecl alias "lua_rawget" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_rawgeti cdecl alias "lua_rawgeti" (byval L as lua_State ptr, byval idx as integer, byval n as integer)
declare sub lua_rawgetp cdecl alias "lua_rawgetp" (byval L as lua_State ptr, byval idx as integer, byval p as any ptr)
declare sub lua_createtable cdecl alias "lua_createtable" (byval L as lua_State ptr, byval narr as integer, byval nrec as integer)
declare function lua_newuserdata cdecl alias "lua_newuserdata" (byval L as lua_State ptr, byval sz as size_t) as any ptr
declare function lua_getmetatable cdecl alias "lua_getmetatable" (byval L as lua_State ptr, byval objindex as integer) as integer
declare sub lua_getuservalue cdecl alias "lua_getuservalue" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_setglobal cdecl alias "lua_setglobal" (byval L as lua_State ptr, byval var as zstring ptr)
declare sub lua_settable cdecl alias "lua_settable" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_setfield cdecl alias "lua_setfield" (byval L as lua_State ptr, byval idx as integer, byval k as zstring ptr)
declare sub lua_rawset cdecl alias "lua_rawset" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_rawseti cdecl alias "lua_rawseti" (byval L as lua_State ptr, byval idx as integer, byval n as integer)
declare sub lua_rawsetp cdecl alias "lua_rawsetp" (byval L as lua_State ptr, byval idx as integer, byval p as any ptr)
declare function lua_setmetatable cdecl alias "lua_setmetatable" (byval L as lua_State ptr, byval objindex as integer) as integer
declare sub lua_setuservalue cdecl alias "lua_setuservalue" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_callk cdecl alias "lua_callk" (byval L as lua_State ptr, byval nargs as integer, byval nresults as integer, byval ctx as integer, byval k as lua_CFunction)
declare function lua_getctx cdecl alias "lua_getctx" (byval L as lua_State ptr, byval ctx as integer ptr) as integer
declare function lua_pcallk cdecl alias "lua_pcallk" (byval L as lua_State ptr, byval nargs as integer, byval nresults as integer, byval errfunc as integer, byval ctx as integer, byval k as lua_CFunction) as integer
declare function lua_load cdecl alias "lua_load" (byval L as lua_State ptr, byval reader as lua_Reader, byval dt as any ptr, byval chunkname as zstring ptr, byval mode as zstring ptr) as integer
declare function lua_dump cdecl alias "lua_dump" (byval L as lua_State ptr, byval writer as lua_Writer, byval data as any ptr) as integer
declare function lua_yieldk cdecl alias "lua_yieldk" (byval L as lua_State ptr, byval nresults as integer, byval ctx as integer, byval k as lua_CFunction) as integer
declare function lua_resume cdecl alias "lua_resume" (byval L as lua_State ptr, byval from as lua_State ptr, byval narg as integer) as integer
declare function lua_status cdecl alias "lua_status" (byval L as lua_State ptr) as integer

#define LUA_GCSTOP 0
#define LUA_GCRESTART 1
#define LUA_GCCOLLECT 2
#define LUA_GCCOUNT 3
#define LUA_GCCOUNTB 4
#define LUA_GCSTEP 5
#define LUA_GCSETPAUSE 6
#define LUA_GCSETSTEPMUL 7
#define LUA_GCSETMAJORINC 8
#define LUA_GCISRUNNING 9
#define LUA_GCGEN 10
#define LUA_GCINC 11

declare function lua_gc cdecl alias "lua_gc" (byval L as lua_State ptr, byval what as integer, byval data as integer) as integer
declare function lua_error cdecl alias "lua_error" (byval L as lua_State ptr) as integer
declare function lua_next cdecl alias "lua_next" (byval L as lua_State ptr, byval idx as integer) as integer
declare sub lua_concat cdecl alias "lua_concat" (byval L as lua_State ptr, byval n as integer)
declare sub lua_len cdecl alias "lua_len" (byval L as lua_State ptr, byval idx as integer)
declare function lua_Alloc cdecl alias "lua_Alloc" (byval as lua_getallocf) as LUA_API
declare sub lua_setallocf cdecl alias "lua_setallocf" (byval L as lua_State ptr, byval f as lua_Alloc, byval ud as any ptr)

#define LUA_HOOKCALL 0
#define LUA_HOOKRET 1
#define LUA_HOOKLINE 2
#define LUA_HOOKCOUNT 3
#define LUA_HOOKTAILCALL 4
#define LUA_MASKCALL (1 shl 0)
#define LUA_MASKRET (1 shl 1)
#define LUA_MASKLINE (1 shl 2)
#define LUA_MASKCOUNT (1 shl 3)

type lua_Debug as any
type lua_Hook as sub cdecl(byval as lua_State ptr, byval as lua_Debug ptr)

declare function lua_getstack cdecl alias "lua_getstack" (byval L as lua_State ptr, byval level as integer, byval ar as lua_Debug ptr) as integer
declare function lua_getinfo cdecl alias "lua_getinfo" (byval L as lua_State ptr, byval what as zstring ptr, byval ar as lua_Debug ptr) as integer
declare function lua_getlocal cdecl alias "lua_getlocal" (byval L as lua_State ptr, byval ar as lua_Debug ptr, byval n as integer) as zstring ptr
declare function lua_setlocal cdecl alias "lua_setlocal" (byval L as lua_State ptr, byval ar as lua_Debug ptr, byval n as integer) as zstring ptr
declare function lua_getupvalue cdecl alias "lua_getupvalue" (byval L as lua_State ptr, byval funcindex as integer, byval n as integer) as zstring ptr
declare function lua_setupvalue cdecl alias "lua_setupvalue" (byval L as lua_State ptr, byval funcindex as integer, byval n as integer) as zstring ptr
declare function lua_upvalueid cdecl alias "lua_upvalueid" (byval L as lua_State ptr, byval fidx as integer, byval n as integer) as any ptr
declare sub lua_upvaluejoin cdecl alias "lua_upvaluejoin" (byval L as lua_State ptr, byval fidx1 as integer, byval n1 as integer, byval fidx2 as integer, byval n2 as integer)
declare function lua_sethook cdecl alias "lua_sethook" (byval L as lua_State ptr, byval func as lua_Hook, byval mask as integer, byval count as integer) as integer
declare function lua_Hook cdecl alias "lua_Hook" (byval as lua_gethook) as LUA_API
declare function lua_gethookmask cdecl alias "lua_gethookmask" (byval L as lua_State ptr) as integer
declare function lua_gethookcount cdecl alias "lua_gethookcount" (byval L as lua_State ptr) as integer

type lua_Debug
    event as integer
    name as zstring ptr
    namewhat as zstring ptr
    what as zstring ptr
    source as zstring ptr
    currentline as integer
    linedefined as integer
    lastlinedefined as integer
    nups as ubyte
    nparams as ubyte
    isvararg as byte
    istailcall as byte
    short_src as zstring * LUA_IDSIZE
    i_ci as CallInfo ptr
end type

#endif
