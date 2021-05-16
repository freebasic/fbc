' TEST_MODE : COMPILE_ONLY_OK

dim as any ptr img, pixels

imageinfo img
imageinfo img, , , , , pixels

scope
	dim as integer w, h, bypp, pitch, size

#ifndef __FB_64BIT__
	'' w & h optional only valid for INTEGER<32>
	imageinfo img, w
	imageinfo img,  , h
	imageinfo img,  ,  , bypp
	imageinfo img,  ,  ,     , pitch
	imageinfo img,  ,  ,     ,      ,       , size
#endif

	'' specifying w & h is valid for INTEGER<32|64>
	imageinfo img, w, h
	imageinfo img, w, h, bypp
	imageinfo img, w, h,     , pitch
	imageinfo img, w, h,     ,      , pixels
	imageinfo img, w, h,     ,      ,       , size
	imageinfo img, w, h, bypp, pitch, pixels, size


end scope

scope
	dim as longint w, h, bypp, pitch, size

	'' specifying w & h required for LONGINT
	imageinfo img, w, h
	imageinfo img, w, h, bypp
	imageinfo img, w, h,     , pitch
	imageinfo img, w, h,     ,      , pixels
	imageinfo img, w, h,     ,      ,       , size
	imageinfo img, w, h, bypp, pitch, pixels, size

end scope


scope
	dim as long w, h, bypp, pitch, size

	'' any combination possible with LONG
	imageinfo img, w
	imageinfo img,  , h
	imageinfo img,  ,  , bypp
	imageinfo img,  ,  ,     , pitch
	imageinfo img,  ,  ,     ,      , pixels
	imageinfo img,  ,  ,     ,      ,       , size
	imageinfo img, w, h
	imageinfo img, w, h, bypp
	imageinfo img, w, h,     , pitch
	imageinfo img, w, h,     ,      , pixels
	imageinfo img, w, h,     ,      ,       , size
	imageinfo img, w, h, bypp, pitch, pixels, size
end scope
