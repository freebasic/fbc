#include "fb_gfx.h"

// Pull in the auto-generated data...
#include "gfxdata_inline.h"

/* Data will be uncompressed into this buffer at runtime */
static unsigned char internal_data[DATA_SIZE];

/* must match the FB_FONT_* enum */
const FONT __fb_font[FB_FONT_COUNT] =
{
	{ 8,  8, &internal_data[DATA_FONT_8 ] },
	{ 8, 14, &internal_data[DATA_FONT_14] },
	{ 8, 16, &internal_data[DATA_FONT_16] }
};

/* must match the FB_PALETTE_* enum */
const PALETTE __fb_palette[FB_PALETTE_COUNT] =
{
	{   2, &internal_data[DATA_PAL_2  ] },
	{  16, &internal_data[DATA_PAL_16 ] },
	{  64, &internal_data[DATA_PAL_64 ] },
	{ 256, &internal_data[DATA_PAL_256] }
};

/* Caller is expected to hold FB_GRAPHICS_LOCK() */
void fb_hSetupData()
{
	static int inited = FALSE;

	if (inited)
		return;

	ssize_t size = DATA_SIZE;
	fb_hDecode(compressed_data, sizeof(compressed_data), internal_data, &size);

	inited = TRUE;
}
