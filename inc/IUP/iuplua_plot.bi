'' FreeBASIC binding for iup-3.13

#pragma once

#ifdef LUA_TNONE
	extern "C"
#endif

#define __IUPLUA_PLOT_H

#ifdef LUA_TNONE
	declare function iup_plotlua_open(byval L as lua_State ptr) as long

	end extern
#endif
