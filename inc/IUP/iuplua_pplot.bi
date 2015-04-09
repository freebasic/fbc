'' FreeBASIC binding for iup-3.11.2

#pragma once

extern "C"

#define __IUPLUA_PPLOT_H

#ifdef LUA_NOOBJECT
	declare function iup_pplotlua_open() as long
#else
	declare function iup_pplotlua_open(byval L as lua_State ptr) as long
#endif

end extern
