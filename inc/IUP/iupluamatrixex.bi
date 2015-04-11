'' FreeBASIC binding for iup-3.13

#pragma once

#ifdef LUA_TNONE
	extern "C"
#endif

#define __IUPLUAMATRIXEX_H

#ifdef LUA_TNONE
	declare function iupmatrixexlua_open(byval L as lua_State ptr) as long

	end extern
#endif
