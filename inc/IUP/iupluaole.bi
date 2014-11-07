#pragma once

extern "C"

#define __IUPLUAOLE_H

#ifdef LUA_NOOBJECT
	declare function iupolelua_open() as long
#else
	declare function iupolelua_open(byval L as lua_State ptr) as long
#endif

end extern
