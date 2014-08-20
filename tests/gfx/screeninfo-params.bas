' TEST_MODE : COMPILE_ONLY_OK

dim driver as string

screeninfo , , , , , , driver

scope
	dim as integer w, h, bpp, bypp, pitch, refresh_rate
	screeninfo w, h, bpp, bypp, pitch
	screeninfo w, h, bpp, bypp, pitch, refresh_rate
	screeninfo w, h, bpp, bypp, pitch, refresh_rate, driver
end scope

scope
	#ifdef __FB_64BIT__
		dim as longint w, h, bpp, bypp, pitch, refresh_rate
	#else
		dim as long w, h, bpp, bypp, pitch, refresh_rate
	#endif
	screeninfo w, h, bpp, bypp, pitch
	screeninfo w, h, bpp, bypp, pitch, refresh_rate
	screeninfo w, h, bpp, bypp, pitch, refresh_rate, driver
end scope
