' TEST_MODE : COMPILE_ONLY_OK

dim as any ptr img, pixels

imageinfo img
imageinfo img, , , , , pixels

scope
	dim as integer w, h, bypp, pitch, size
	imageinfo img, w, h, bypp, pitch, pixels, size
end scope

scope
	#ifdef __FB_64BIT__
		dim as longint w, h, bypp, pitch, size
		imageinfo img, w, h, bypp, pitch, pixels, size
	#else
		dim as long w, h, bypp, pitch, size
		imageinfo img, w, h, bypp, pitch, pixels, size
	#endif
end scope
