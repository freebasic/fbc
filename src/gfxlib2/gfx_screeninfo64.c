#include "fb_gfx.h"

FBCALL void fb_GfxScreenInfo64
	(
		long long *width,
		long long *height,
		long long *depth,
		long long *bpp,
		long long *pitch,
		long long *refresh,
		FBSTRING *driver
	)
{
	int iwidth, iheight, idepth, ibpp, ipitch, irefresh;

	fb_GfxScreenInfo( &iwidth, &iheight, &idepth, &ibpp, &ipitch, &irefresh, driver );

	*width = iwidth;
	*height = iheight;
	*depth = idepth;
	*bpp = ibpp;
	*pitch = ipitch;
	*refresh = irefresh;
}
