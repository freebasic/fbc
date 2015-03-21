#pragma once

extern "C"

#define __IUPLUA_H

#ifdef LUA_NOOBJECT
	declare function iuplua_open() as long
	declare function iupkey_open() as long
	declare function iuplua_checkihandle(byval pos as long) as Ihandle ptr
	declare sub iuplua_pushihandle(byval n as Ihandle ptr)
	declare function iuplua_dofile(byval filename as zstring ptr) as long
#else
	declare function iuplua_open(byval L as lua_State ptr) as long
	declare function iupkey_open(byval L as lua_State ptr) as long
	declare function iuplua_close(byval L as lua_State ptr) as long
	declare function iuplua_checkihandle(byval L as lua_State ptr, byval pos as long) as Ihandle ptr
	declare sub iuplua_pushihandle(byval L as lua_State ptr, byval n as Ihandle ptr)
	declare function iuplua_dofile(byval L as lua_State ptr, byval filename as const zstring ptr) as long
	declare function iuplua_dostring(byval L as lua_State ptr, byval string as const zstring ptr, byval chunk_name as const zstring ptr) as long
#endif

end extern
