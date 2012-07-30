/'** \file
 * \brief Binding of iupwebbrowser to Lua.
 *
 * See Copyright Notice in "iup.h"
 *'/
#ifndef __iupluaweb_bi__
#define __iupluaweb_bi__

extern "C"

#ifdef LUA_NOOBJECT  '/* Lua 3 */
declare function iupweblua_open( ) as integer
#endif

#ifdef LUA_TNONE  '/* Lua 5 */
declare function iupweblua_open( byval L as lua_State ptr ) as integer
#endif

end extern

#endif
