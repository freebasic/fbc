#pragma once

extern "C"

#define __IUPLUACONTROLS_H

#ifdef LUA_NOOBJECT
	declare function iupcontrolslua_open() as long
#else
	declare function iupcontrolslua_open(byval L as lua_State ptr) as long
	declare function iupcontrolslua_close(byval L as lua_State ptr) as long
#endif

end extern
