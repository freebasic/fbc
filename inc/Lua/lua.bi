#pragma once
#inclib "lua"

#include once "crt/stdarg.bi"
#include once "crt/stddef.bi"
#include once "crt/limits.bi"

'' The following symbols have been renamed:
''     #define LUA_NUMBER => LUA_NUMBER_
''     #define LUA_INTEGER => LUA_INTEGER_
''     #define LUA_UNSIGNED => LUA_UNSIGNED_
''     #define LUA_VERSION => LUA_VERSION_
''     #define LUA_YIELD => LUA_YIELD_

extern "C"

#define lua_h
#define lconfig_h

#ifdef __FB_WIN32__
	#define LUA_WIN
	#define LUA_DL_DLL
	#define LUA_USE_AFORMAT
	#define LUA_LDIR !"!\\lua\\"
	#define LUA_CDIR !"!\\"
	#define LUA_PATH_DEFAULT LUA_LDIR "?.lua;" LUA_LDIR !"?\\init.lua;" LUA_CDIR "?.lua;" LUA_CDIR !"?\\init.lua;" !".\\?.lua"
	#define LUA_CPATH_DEFAULT LUA_CDIR "?.dll;" LUA_CDIR "loadall.dll;" !".\\?.dll"
	#define LUA_DIRSEP !"\\"
#else
	#define LUA_VDIR LUA_VERSION_MAJOR "." LUA_VERSION_MINOR "/"
	#define LUA_ROOT "/usr/local/"
	#define LUA_LDIR LUA_ROOT "share/lua/" LUA_VDIR
	#define LUA_CDIR LUA_ROOT "lib/lua/" LUA_VDIR
	#define LUA_PATH_DEFAULT LUA_LDIR "?.lua;" LUA_LDIR "?/init.lua;" LUA_CDIR "?.lua;" LUA_CDIR "?/init.lua;" "./?.lua"
	#define LUA_CPATH_DEFAULT LUA_CDIR "?.so;" LUA_CDIR "loadall.so;" "./?.so"
	#define LUA_DIRSEP "/"
#endif

#define LUA_ENV "_ENV"
#define LUA_QL(x) "'" x "'"
#define LUA_QS LUA_QL("%s")
#define LUA_IDSIZE 60

#macro luai_writestringerror(s, p)
	scope
		fprintf(stderr, (s), (p))
		fflush(stderr)
	end scope
#endmacro

#define LUAI_MAXSHORTLEN 40
#define LUAI_BITSINT 32
#define LUA_INT32 long
#define LUAI_UMEM uinteger
#define LUAI_MEM integer
#define LUAI_MAXSTACK 1000000
#define LUAI_FIRSTPSEUDOIDX ((-LUAI_MAXSTACK) - 1000)
#define LUAL_BUFFERSIZE BUFSIZ
#define LUA_NUMBER_DOUBLE
#define LUA_NUMBER_ double
#define LUAI_UACNUMBER double
#define LUA_NUMBER_SCAN "%lf"
#define LUA_NUMBER_FMT "%.14g"
#define lua_number2str(s, n) sprintf((s), LUA_NUMBER_FMT, (n))
#define LUAI_MAXNUMBER2STR 32
#define l_mathop(x) (x)
#define lua_str2number(s, p) strtod((s), (p))
#define LUA_INTEGER_ integer
#define LUA_UNSIGNED_ ulong
#define LUA_IEEE754TRICK

#if defined(__FB_DOS__) or ((not defined(__FB_64BIT__)) and (defined(__FB_WIN32__) or defined(__FB_LINUX__)))
	#define LUA_IEEELL
#endif

#define LUA_IEEEENDIAN 0

#if defined(__FB_DOS__) or ((not defined(__FB_64BIT__)) and (defined(__FB_WIN32__) or defined(__FB_LINUX__)))
	#define LUA_NANTRICK
#endif

#define LUA_VERSION_MAJOR "5"
#define LUA_VERSION_MINOR "2"
#define LUA_VERSION_NUM 502
#define LUA_VERSION_RELEASE "3"
#define LUA_VERSION_ "Lua " LUA_VERSION_MAJOR "." LUA_VERSION_MINOR
#define LUA_RELEASE LUA_VERSION_ "." LUA_VERSION_RELEASE
#define LUA_COPYRIGHT LUA_RELEASE "  Copyright (C) 1994-2013 Lua.org, PUC-Rio"
#define LUA_AUTHORS "R. Ierusalimschy, L. H. de Figueiredo, W. Celes"
#define LUA_SIGNATURE !"\27Lua"
#define LUA_MULTRET (-1)
#define LUA_REGISTRYINDEX LUAI_FIRSTPSEUDOIDX
#define lua_upvalueindex(i) (LUA_REGISTRYINDEX - (i))
#define LUA_OK 0
#define LUA_YIELD_ 1
#define LUA_ERRRUN 2
#define LUA_ERRSYNTAX 3
#define LUA_ERRMEM 4
#define LUA_ERRGCMM 5
#define LUA_ERRERR 6

type lua_State as lua_State_
type lua_CFunction as function(byval L as lua_State ptr) as long
type lua_Reader as function(byval L as lua_State ptr, byval ud as any ptr, byval sz as uinteger ptr) as const zstring ptr
type lua_Writer as function(byval L as lua_State ptr, byval p as const any ptr, byval sz as uinteger, byval ud as any ptr) as long
type lua_Alloc as function(byval ud as any ptr, byval ptr as any ptr, byval osize as uinteger, byval nsize as uinteger) as any ptr

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
#define LUA_RIDX_LAST LUA_RIDX_GLOBALS

type lua_Number as double
type lua_Integer as integer
type lua_Unsigned as ulong
extern lua_ident as const zstring * len("$LuaVersion: " LUA_COPYRIGHT " $" "$LuaAuthors: " LUA_AUTHORS " $")

declare function lua_newstate(byval f as lua_Alloc, byval ud as any ptr) as lua_State ptr
declare sub lua_close(byval L as lua_State ptr)
declare function lua_newthread(byval L as lua_State ptr) as lua_State ptr
declare function lua_atpanic(byval L as lua_State ptr, byval panicf as lua_CFunction) as lua_CFunction
declare function lua_version(byval L as lua_State ptr) as const lua_Number ptr
declare function lua_absindex(byval L as lua_State ptr, byval idx as long) as long
declare function lua_gettop(byval L as lua_State ptr) as long
declare sub lua_settop(byval L as lua_State ptr, byval idx as long)
declare sub lua_pushvalue(byval L as lua_State ptr, byval idx as long)
declare sub lua_remove(byval L as lua_State ptr, byval idx as long)
declare sub lua_insert(byval L as lua_State ptr, byval idx as long)
declare sub lua_replace(byval L as lua_State ptr, byval idx as long)
declare sub lua_copy(byval L as lua_State ptr, byval fromidx as long, byval toidx as long)
declare function lua_checkstack(byval L as lua_State ptr, byval sz as long) as long
declare sub lua_xmove(byval from as lua_State ptr, byval to as lua_State ptr, byval n as long)
declare function lua_isnumber(byval L as lua_State ptr, byval idx as long) as long
declare function lua_isstring(byval L as lua_State ptr, byval idx as long) as long
declare function lua_iscfunction(byval L as lua_State ptr, byval idx as long) as long
declare function lua_isuserdata(byval L as lua_State ptr, byval idx as long) as long
declare function lua_type(byval L as lua_State ptr, byval idx as long) as long
declare function lua_typename(byval L as lua_State ptr, byval tp as long) as const zstring ptr
declare function lua_tonumberx(byval L as lua_State ptr, byval idx as long, byval isnum as long ptr) as lua_Number
declare function lua_tointegerx(byval L as lua_State ptr, byval idx as long, byval isnum as long ptr) as lua_Integer
declare function lua_tounsignedx(byval L as lua_State ptr, byval idx as long, byval isnum as long ptr) as lua_Unsigned
declare function lua_toboolean(byval L as lua_State ptr, byval idx as long) as long
declare function lua_tolstring(byval L as lua_State ptr, byval idx as long, byval len as uinteger ptr) as const zstring ptr
declare function lua_rawlen(byval L as lua_State ptr, byval idx as long) as uinteger
declare function lua_tocfunction(byval L as lua_State ptr, byval idx as long) as lua_CFunction
declare function lua_touserdata(byval L as lua_State ptr, byval idx as long) as any ptr
declare function lua_tothread(byval L as lua_State ptr, byval idx as long) as lua_State ptr
declare function lua_topointer(byval L as lua_State ptr, byval idx as long) as const any ptr

#define LUA_OPADD 0
#define LUA_OPSUB 1
#define LUA_OPMUL 2
#define LUA_OPDIV 3
#define LUA_OPMOD 4
#define LUA_OPPOW 5
#define LUA_OPUNM 6
declare sub lua_arith(byval L as lua_State ptr, byval op as long)
#define LUA_OPEQ 0
#define LUA_OPLT 1
#define LUA_OPLE 2

declare function lua_rawequal(byval L as lua_State ptr, byval idx1 as long, byval idx2 as long) as long
declare function lua_compare(byval L as lua_State ptr, byval idx1 as long, byval idx2 as long, byval op as long) as long
declare sub lua_pushnil(byval L as lua_State ptr)
declare sub lua_pushnumber(byval L as lua_State ptr, byval n as lua_Number)
declare sub lua_pushinteger(byval L as lua_State ptr, byval n as lua_Integer)
declare sub lua_pushunsigned(byval L as lua_State ptr, byval n as lua_Unsigned)
declare function lua_pushlstring(byval L as lua_State ptr, byval s as const zstring ptr, byval l as uinteger) as const zstring ptr
declare function lua_pushstring(byval L as lua_State ptr, byval s as const zstring ptr) as const zstring ptr
declare function lua_pushvfstring(byval L as lua_State ptr, byval fmt as const zstring ptr, byval argp as va_list) as const zstring ptr
declare function lua_pushfstring(byval L as lua_State ptr, byval fmt as const zstring ptr, ...) as const zstring ptr
declare sub lua_pushcclosure(byval L as lua_State ptr, byval fn as lua_CFunction, byval n as long)
declare sub lua_pushboolean(byval L as lua_State ptr, byval b as long)
declare sub lua_pushlightuserdata(byval L as lua_State ptr, byval p as any ptr)
declare function lua_pushthread(byval L as lua_State ptr) as long
declare sub lua_getglobal(byval L as lua_State ptr, byval var as const zstring ptr)
declare sub lua_gettable(byval L as lua_State ptr, byval idx as long)
declare sub lua_getfield(byval L as lua_State ptr, byval idx as long, byval k as const zstring ptr)
declare sub lua_rawget(byval L as lua_State ptr, byval idx as long)
declare sub lua_rawgeti(byval L as lua_State ptr, byval idx as long, byval n as long)
declare sub lua_rawgetp(byval L as lua_State ptr, byval idx as long, byval p as const any ptr)
declare sub lua_createtable(byval L as lua_State ptr, byval narr as long, byval nrec as long)
declare function lua_newuserdata(byval L as lua_State ptr, byval sz as uinteger) as any ptr
declare function lua_getmetatable(byval L as lua_State ptr, byval objindex as long) as long
declare sub lua_getuservalue(byval L as lua_State ptr, byval idx as long)
declare sub lua_setglobal(byval L as lua_State ptr, byval var as const zstring ptr)
declare sub lua_settable(byval L as lua_State ptr, byval idx as long)
declare sub lua_setfield(byval L as lua_State ptr, byval idx as long, byval k as const zstring ptr)
declare sub lua_rawset(byval L as lua_State ptr, byval idx as long)
declare sub lua_rawseti(byval L as lua_State ptr, byval idx as long, byval n as long)
declare sub lua_rawsetp(byval L as lua_State ptr, byval idx as long, byval p as const any ptr)
declare function lua_setmetatable(byval L as lua_State ptr, byval objindex as long) as long
declare sub lua_setuservalue(byval L as lua_State ptr, byval idx as long)
declare sub lua_callk(byval L as lua_State ptr, byval nargs as long, byval nresults as long, byval ctx as long, byval k as lua_CFunction)
#define lua_call(L, n, r) lua_callk(L, (n), (r), 0, NULL)
declare function lua_getctx(byval L as lua_State ptr, byval ctx as long ptr) as long
declare function lua_pcallk(byval L as lua_State ptr, byval nargs as long, byval nresults as long, byval errfunc as long, byval ctx as long, byval k as lua_CFunction) as long
#define lua_pcall(L, n, r, f) lua_pcallk(L, (n), (r), (f), 0, NULL)
declare function lua_load(byval L as lua_State ptr, byval reader as lua_Reader, byval dt as any ptr, byval chunkname as const zstring ptr, byval mode as const zstring ptr) as long
declare function lua_dump(byval L as lua_State ptr, byval writer as lua_Writer, byval data as any ptr) as long
declare function lua_yieldk(byval L as lua_State ptr, byval nresults as long, byval ctx as long, byval k as lua_CFunction) as long
#define lua_yield(L, n) lua_yieldk(L, (n), 0, NULL)
declare function lua_resume(byval L as lua_State ptr, byval from as lua_State ptr, byval narg as long) as long
declare function lua_status(byval L as lua_State ptr) as long

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

declare function lua_gc(byval L as lua_State ptr, byval what as long, byval data as long) as long
declare function lua_error(byval L as lua_State ptr) as long
declare function lua_next(byval L as lua_State ptr, byval idx as long) as long
declare sub lua_concat(byval L as lua_State ptr, byval n as long)
declare sub lua_len(byval L as lua_State ptr, byval idx as long)
declare function lua_getallocf(byval L as lua_State ptr, byval ud as any ptr ptr) as lua_Alloc
declare sub lua_setallocf(byval L as lua_State ptr, byval f as lua_Alloc, byval ud as any ptr)

#define lua_tonumber(L, i) lua_tonumberx(L, i, NULL)
#define lua_tointeger(L, i) lua_tointegerx(L, i, NULL)
#define lua_tounsigned(L, i) lua_tounsignedx(L, i, NULL)
#define lua_pop(L, n) lua_settop(L, (-(n)) - 1)
#define lua_newtable(L) lua_createtable(L, 0, 0)
#macro lua_register(L, n, f)
	scope
		lua_pushcfunction(L, (f))
		lua_setglobal(L, (n))
	end scope
#endmacro
#define lua_pushcfunction(L, f) lua_pushcclosure(L, (f), 0)
#define lua_isfunction(L, n) (lua_type(L, (n)) = LUA_TFUNCTION)
#define lua_istable(L, n) (lua_type(L, (n)) = LUA_TTABLE)
#define lua_islightuserdata(L, n) (lua_type(L, (n)) = LUA_TLIGHTUSERDATA)
#define lua_isnil(L, n) (lua_type(L, (n)) = LUA_TNIL)
#define lua_isboolean(L, n) (lua_type(L, (n)) = LUA_TBOOLEAN)
#define lua_isthread(L, n) (lua_type(L, (n)) = LUA_TTHREAD)
#define lua_isnone(L, n) (lua_type(L, (n)) = LUA_TNONE)
#define lua_isnoneornil(L, n) (lua_type(L, (n)) <= 0)
#define lua_pushliteral(L, s) lua_pushlstring(L, "" s, len(s)-1)
#define lua_pushglobaltable(L) lua_rawgeti(L, LUA_REGISTRYINDEX, LUA_RIDX_GLOBALS)
#define lua_tostring(L, i) lua_tolstring(L, (i), NULL)
#define LUA_HOOKCALL 0
#define LUA_HOOKRET 1
#define LUA_HOOKLINE 2
#define LUA_HOOKCOUNT 3
#define LUA_HOOKTAILCALL 4
#define LUA_MASKCALL (1 shl LUA_HOOKCALL)
#define LUA_MASKRET (1 shl LUA_HOOKRET)
#define LUA_MASKLINE (1 shl LUA_HOOKLINE)
#define LUA_MASKCOUNT (1 shl LUA_HOOKCOUNT)
type lua_Debug as lua_Debug_
type lua_Hook as sub(byval L as lua_State ptr, byval ar as lua_Debug ptr)

declare function lua_getstack(byval L as lua_State ptr, byval level as long, byval ar as lua_Debug ptr) as long
declare function lua_getinfo(byval L as lua_State ptr, byval what as const zstring ptr, byval ar as lua_Debug ptr) as long
declare function lua_getlocal(byval L as lua_State ptr, byval ar as const lua_Debug ptr, byval n as long) as const zstring ptr
declare function lua_setlocal(byval L as lua_State ptr, byval ar as const lua_Debug ptr, byval n as long) as const zstring ptr
declare function lua_getupvalue(byval L as lua_State ptr, byval funcindex as long, byval n as long) as const zstring ptr
declare function lua_setupvalue(byval L as lua_State ptr, byval funcindex as long, byval n as long) as const zstring ptr
declare function lua_upvalueid(byval L as lua_State ptr, byval fidx as long, byval n as long) as any ptr
declare sub lua_upvaluejoin(byval L as lua_State ptr, byval fidx1 as long, byval n1 as long, byval fidx2 as long, byval n2 as long)
declare function lua_sethook(byval L as lua_State ptr, byval func as lua_Hook, byval mask as long, byval count as long) as long
declare function lua_gethook(byval L as lua_State ptr) as lua_Hook
declare function lua_gethookmask(byval L as lua_State ptr) as long
declare function lua_gethookcount(byval L as lua_State ptr) as long

type CallInfo as CallInfo_

type lua_Debug_
	event as long
	name as const zstring ptr
	namewhat as const zstring ptr
	what as const zstring ptr
	source as const zstring ptr
	currentline as long
	linedefined as long
	lastlinedefined as long
	nups as ubyte
	nparams as ubyte
	isvararg as byte
	istailcall as byte
	short_src as zstring * LUA_IDSIZE
	i_ci as CallInfo ptr
end type

end extern
