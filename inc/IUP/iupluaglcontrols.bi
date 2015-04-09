'' FreeBASIC binding for iup-3.11.2

#pragma once

#ifdef LUA_TNONE
	extern "C"
#endif

#define __IUPLUAGLCONTROLS_H

#ifdef LUA_TNONE
	declare function iupglcontrolslua_open(byval L as lua_State ptr) as long

	end extern
#endif
