'' mini.bi (FreeBASIC MINI header) (c) 2005 Daniel Verkamp
'' based on mini.h (c) by Stefan Roettger
'' http://www9.cs.fau.de/~roettger/download

#ifndef MINI_H
#define MINI_H

#inclib "mini-c"
#inclib "mini"

declare sub mini_setminierrorhandler cdecl alias "mini_setminierrorhandler" (byval handler as sub cdecl(byval file as zstring ptr, byval _line as integer, byval fatal as integer = 0))

declare sub mini_setparams cdecl alias "mini_setparams" (byval minr as single = 9.0, byval maxd as single = 100.0, byval ginf as single = 0.25, byval maxc as integer = 8)

declare function mini_initmap cdecl alias "mini_initmap" (byval image as short ptr, byval d2map as any ptr ptr, byval size as integer ptr, byval _dim as single ptr, byval scale as single, byval cellaspect as single=1.0, byval getelevation as function cdecl (byval i as integer, byval j as integer, byval size as integer, byval _data as any ptr) as short = 0, byval objref as any ptr = 0) as any ptr

declare function mini_inittexmap cdecl alias "mini_inittexmap" (byval image as ubyte ptr = 0, byval _width as integer ptr = 0, byval height as integer ptr = 0) as integer

declare function mini_initfogmap cdecl alias "mini_initfogmap" (byval image as ubyte ptr, byval size as integer, byval lambda as single, byval displace as single, byval emission as single, byval fogatt as single = 1.0, byval fogR as single = 1.0, byval fogG as single = 1.0, byval fogB as single = 1.0)

declare sub mini_setmaps cdecl alias "mini_setmaps" (byval map as any ptr, byval d2map as any ptr, byval size as integer, byval dim as single, byval scale as single, byval texid as integer = 0, byval _width as integer = 0, byval height as integer = 0, byval cellaspect as single = 1.0, byval ox as single = 0.0, byval oy as single = 0.0, byval oz as single = 0.0, byval d2map2 as any ptr ptr = 0, byval size2 as integer ptr = 0, byval fogmap as any ptr = 0, byval lambda as single = 0.0, byval displace as single = 0.0, byval emission as single = 0.0, byval fogR as single = 1.0, byval fogG as single = 1.0, byval fogB as single = 1.0)

declare sub mini_drawlandscape cdecl alias "mini_drawlandscape" (byval res as single, byval ex as single, byval ey as single, byval ez as single, byval fx as single, byval fy as single, byval fz as single, byval dx as single, byval dy as single, byval dz as single, byval ux as single, byval uy as single, byval uz as single, byval fovy as single, byval aspect as single, byval nearp as single, byval farp as single, byval beginfan as sub cdecl () = 0, byval fanvertex as sub cdecl (byval i as single, byval y as single, byval j as single) = 0, byval notify as sub cdecl(byval i as integer, byval j as integer, byval s as integer) = 0, byval prismedge as sub cdecl(byval x as single, byval y as single, byval yf as single, byval z as single) = 0, byval state as integer = 0)

declare function mini_checklandscale cdecl alias "mini_checklandscape" (byval ex as single, byval ey as single, byval ez as single, byval dx as single, byval dy as single, byval dz as single, byval ux as single, byval uy as single, byval uz as single, byval fovy as single, byval aspect as single, byval nearp as single, byval farp as single, byval phase as integer = 1)

declare function mini_getheight1 cdecl alias "mini_getheight1" (byval i as integer, byval j as integer) as single

declare sub mini_getheight2 cdecl alias "mini_getheight2" (byval s as single, byval t as single, byval height as single ptr)

declare function mini_getheight3 cdecl alias "mini_getheight3" (byval x as single, byval z as single) as single

private function mini_getheight overload (byval i as integer, byval j as integer) as single
	return mini_getheight1(i, j)
end function

private sub mini_getheight (byval s as single, byval t as single, byval height as single ptr)
	mini_getheight2(s, t, height)
end sub

private function mini_getheight (byval x as single, byval z as single) as single
	return mini_getheight3(x, z)
end function

declare sub mini_getnormal1 cdecl alias "mini_getnormal1" (byval s as single, byval t as single, byval nx as single ptr, byval nz as single ptr)

declare sub mini_getnormal2 cdecl alias "mini_getnormal2" (byval x as single, byval z as single, byval nx as single ptr, byval ny as single ptr, byval nz as single ptr)

private sub mini_getnormal overload (byval s as single, byval t as single, byval nx as single ptr, byval nz as single ptr)
	mini_getnormal1(s, t, nx, nz)
end sub

private sub mini_getnormal (byval x as single, byval z as single, byval nx as single ptr, byval ny as single ptr, byval nz as single ptr)
	mini_getnormal2(x, z, nx, ny, nz)
end sub

declare function mini_getmaxsize cdecl alias "mini_getmaxsize" (byval res as single, byval fx as single, byval fy as single, byval fz as single, byval fovy as single) as integer

declare sub mini_deletemaps cdecl alias "mini_deletemaps" ()

'' helper functions:

declare function mini_getS cdecl alias "mini_getS" () as integer
declare sub mini_setS cdecl alias "mini_setS(byval newval as integer)

declare function mini_getDx cdecl alias "mini_getDx" () as single
declare sub mini_setDx cdecl alias "mini_setDx" (byval newval as single)

declare function mini_getSCALE cdecl alias "mini_getSCALE" () as single
declare sub mini_setSCALE cdecl alias "mini_setSCALE" (byval newval as single)

declare function mini_getDz cdecl alias "mini_getDz" () as single
declare sub mini_setDz cdecl alias "mini_setDz" (byval newval as single)

declare function mini_getOX cdecl alias "mini_getOX" () as single
declare sub mini_setOX cdecl alias "mini_setOX" (byval newval as single)

declare function mini_getOY cdecl alias "mini_getOY" () as single
declare sub mini_setOY cdecl alias "mini_setOY" (byval newval as single)

declare function mini_getOZ cdecl alias "mini_getOZ" () as single
declare sub mini_setOZ cdecl alias "mini_setOZ" (byval newval as single)

declare function mini_getX cdecl alias "mini_getX" (byval i as single) as single
declare function mini_getY cdecl alias "mini_getY" (byval y as single) as single
declare function mini_getZ cdecl alias "mini_getZ" (byval j as single) as single

#endif
