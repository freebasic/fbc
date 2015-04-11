'' FreeBASIC binding for iup-3.13

#pragma once

extern "C"

#define __IUPLUA_MGLPLOT_H

#ifdef LUA_NOOBJECT
	declare function iup_mglplotlua_open() as long
#else
	declare function iup_mglplotlua_open(byval L as lua_State ptr) as long
#endif

end extern
