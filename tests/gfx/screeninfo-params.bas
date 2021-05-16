' TEST_MODE : COMPILE_ONLY_OK

dim driver as string

screeninfo , , , , , , driver

scope
	dim as integer w, h, bpp, bypp, pitch, refresh_rate

#ifndef __FB_64BIT__
	'' w & h optional only valid for INTEGER<32>
	screeninfo w
	screeninfo  , h
	screeninfo  ,  , bpp
	screeninfo  ,  ,    , bypp
	screeninfo  ,  ,    ,     , pitch
	screeninfo  ,  ,    ,     ,      , refresh_rate
	screeninfo  ,  ,    ,     ,      ,             , driver

#endif
	'' if at least w & h specified, other combninations valid for INTEGER<32|64>

	screeninfo w, h
	screeninfo w, h, bpp
	screeninfo w, h,    , bypp
	screeninfo w, h,    ,     , pitch
	screeninfo w, h,    ,     ,      , refresh_rate
	screeninfo w, h,    ,     ,      ,             , driver
	screeninfo w, h, bpp, bypp, pitch
	screeninfo w, h, bpp, bypp, pitch, refresh_rate
	screeninfo w, h, bpp, bypp, pitch, refresh_rate, driver
end scope

scope
	dim as longint w, h, bpp, bypp, pitch, size, refresh_rate

	'' specifying w & h required for LONGINT
	screeninfo w, h
	screeninfo w, h, bpp
	screeninfo w, h,    , bypp
	screeninfo w, h,    ,     , pitch
	screeninfo w, h,    ,     ,      , refresh_rate
	screeninfo w, h,    ,     ,      ,             , driver
	screeninfo w, h, bpp, bypp, pitch
	screeninfo w, h, bpp, bypp, pitch, refresh_rate
	screeninfo w, h, bpp, bypp, pitch, refresh_rate, driver

end scope


scope
	dim as long w, h, bpp, bypp, pitch, size, refresh_rate

	'' any combination possible with LONG
	screeninfo w
	screeninfo  , h
	screeninfo  ,  , bpp
	screeninfo  ,  ,    , bypp
	screeninfo  ,  ,    ,     , pitch
	screeninfo  ,  ,    ,     ,      , refresh_rate
	screeninfo  ,  ,    ,     ,      ,             , driver
	screeninfo w, h
	screeninfo w, h, bpp
	screeninfo w, h,    , bypp
	screeninfo w, h,    ,     , pitch
	screeninfo w, h,    ,     ,      , refresh_rate
	screeninfo w, h,    ,     ,      ,             , driver
	screeninfo w, h, bpp, bypp, pitch
	screeninfo w, h, bpp, bypp, pitch, refresh_rate
	screeninfo w, h, bpp, bypp, pitch, refresh_rate, driver
end scope
