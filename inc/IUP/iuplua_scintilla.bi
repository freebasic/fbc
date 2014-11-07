#pragma once

extern "C"

#define __IUPLUA_SCINTILLA_H

#ifdef LUA_NOOBJECT
	declare function iup_scintillalua_open() as long
#else
	declare function iup_scintillalua_open(byval L as lua_State ptr) as long
#endif

end extern
