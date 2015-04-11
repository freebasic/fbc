'' FreeBASIC binding for iup-3.13

#pragma once

extern "C"

#define __IUPLUAIM_H

#ifdef LUA_NOOBJECT
	declare sub iupimlua_open()
#else
	declare function iupimlua_open(byval L as lua_State ptr) as long
#endif

end extern
