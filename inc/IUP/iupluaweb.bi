'' FreeBASIC binding for iup-3.11.2

#pragma once

extern "C"

#define __IUPLUAWEB_H

#ifdef LUA_NOOBJECT
	declare function iupweblua_open() as long
#else
	declare function iupweblua_open(byval L as lua_State ptr) as long
#endif

end extern
