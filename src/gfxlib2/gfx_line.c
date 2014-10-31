/* LINE statement */

#include "fb_gfx.h"

#define CLIP_LEFT_EDGE		0x1
#define CLIP_RIGHT_EDGE		0x2
#define CLIP_BOTTOM_EDGE	0x4
#define CLIP_TOP_EDGE		0x8
#define CLIP_INSIDE(a)		(!a)
#define CLIP_REJECT(a,b)	((a) & (b))
#define CLIP_ACCEPT(a,b)	(!((a) | (b)))

static int encode(FB_GFXCTX *context, int x, int y)
{
	int code = 0;

	if (x < context->view_x)
		code |= CLIP_LEFT_EDGE;
	else if (x >= context->view_x + context->view_w)
		code |= CLIP_RIGHT_EDGE;
	if (y < context->view_y)
		code |= CLIP_TOP_EDGE;
	else if (y >= context->view_y + context->view_h)
		code |= CLIP_BOTTOM_EDGE;

	return code;
}

static int reverse_mask(int mask)
{
	mask = ((mask >> 1) & 0x5555) | ((mask & 0x5555) << 1);
	mask = ((mask >> 2) & 0x3333) | ((mask & 0x3333) << 2);
	mask = ((mask >> 4) & 0x0F0F) | ((mask & 0x0F0F) << 4);
	mask = ((mask >> 8) & 0x00FF) | ((mask & 0x00FF) << 8);
	return mask;
}

static int clip_line(FB_GFXCTX *context, int *x1, int *y1, int *x2, int *y2)
{
	int code1, code2;
	float m;

	while (1) {
		code1 = encode(context, *x1, *y1);
		code2 = encode(context, *x2, *y2);

		if (CLIP_ACCEPT(code1, code2))
			break;
		if (CLIP_REJECT(code1, code2))
			return -1;
		if (CLIP_INSIDE(code1)) {
			SWAP(*x1, *x2);
			SWAP(*y1, *y2);
			SWAP(code1, code2);
		}
		if (*x1 != *x2)
			m = (*y2 - *y1) / (float)(*x2 - *x1);
		else
			m = 1.0;
		if (code1 & CLIP_LEFT_EDGE) {
			*y1 += (context->view_x - *x1) * m;
			*x1 = context->view_x;
		}
		else if (code1 & CLIP_RIGHT_EDGE) {
			*y1 += (context->view_x + context->view_w - 1 - *x1) * m;
			*x1 = context->view_x + context->view_w - 1;
		}
		else if (code1 & CLIP_TOP_EDGE) {
			if (*x1 != *x2)
				*x1 += (context->view_y - *y1) / m;
			*y1 = context->view_y;
		}
		else if (code1 & CLIP_BOTTOM_EDGE) {
			if (*x1 != *x2)
				*x1 += (context->view_y + context->view_h - 1 - *y1) / m;
			*y1 = context->view_y + context->view_h - 1;
		}
	}

	return 0;
}

/* Assumes coordinates to be physical ones.
 * Also assumes color is already masked. */

/* Caller is expected to hold FB_GRAPHICSLOCK() */
void fb_GfxDrawLine(FB_GFXCTX *context, int x1, int y1, int x2, int y2, unsigned int color, unsigned int style)
{
	int x, y, len, d, dx, dy, ax, ay, bit = 0x8000;

	if (clip_line(context, &x1, &y1, &x2, &y2)) {
		return;
	}

	DRIVER_LOCK();
	if (x1 == x2) {
		if (y1 > y2) {
			SWAP(y1, y2);
			style = reverse_mask(style);
			bit = 1 << ((y2 - y1) & 0xF);
		}
		for (y = y1; y <= y2; y++) {
			if (style & bit)
				context->put_pixel(context, x1, y, color);
			RORW1(bit);
		}
	}
	else if (y1 == y2) {
		if (x1 > x2) {
			SWAP(x1, x2);
			style = reverse_mask(style);
			bit = 1 << ((x2 - x1) & 0xF);
		}
		if (style == 0xFFFF)
			context->pixel_set(context->line[y1] + (x1 * __fb_gfx->bpp), color, x2 - x1 + 1);
		else {
			for (x = x1; x <= x2; x++) {
				if (style & bit)
					context->put_pixel(context, x, y1, color);
				RORW1(bit);
			}
		}
	} else {
		dx = x2 - x1;
		dy = y2 - y1;
		ax = ay = 1;
		if (dx < 0) {
			dx = -dx;
			ax = -1;
		}
		if (dy < 0) {
			dy = -dy;
			ay = -1;
		}
		x = x1;
		y = y1;
		if (dx >= dy) {
			len = dx + 1;
			dy <<= 1;
			d = dy - dx;
			dx <<= 1;
			for (; len; len--) {
				if (style & bit)
					context->put_pixel(context, x, y, color);
				RORW1(bit);
				if (d >= 0) {
					y += ay;
					d -= dx;
				}
				d += dy;
				x += ax;
			}
		} else {
			len = dy + 1;
			dx <<= 1;
			d = dx - dy;
			dy <<= 1;
			for (; len; len--) {
				if (style & bit)
					context->put_pixel(context, x, y, color);
				RORW1(bit);
				if (d >= 0) {
					x += ax;
					d -= dy;
				}
				d += dx;
				y += ay;
			}
		}
	}
	if (y1 > y2)
		SWAP(y1, y2);
	SET_DIRTY(context, y1, y2 - y1 + 1);
	DRIVER_UNLOCK();
}

FBCALL void fb_GfxLine(void *target, float fx1, float fy1, float fx2, float fy2, unsigned int color, int type, unsigned int style, int flags)
{
	FB_GFXCTX *context;
	int x1, y1, x2, y2;

	FB_GRAPHICS_LOCK( );

	if (!__fb_gfx) {
		FB_GRAPHICS_UNLOCK( );
		return;
	}

	context = fb_hGetContext( );
	fb_hPrepareTarget(context, target);

	if (flags & DEFAULT_COLOR_1)
		color = context->fg_color;
	else
		color = fb_hFixColor(context->target_bpp, color);

	fb_hSetPixelTransfer(context,color);

	style &= 0xFFFF;
	
	fb_hFixRelative(context, flags, &fx1, &fy1, &fx2, &fy2);

	fb_hTranslateCoord(context, fx1, fy1, &x1, &y1);
	fb_hTranslateCoord(context, fx2, fy2, &x2, &y2);

	if (type == LINE_TYPE_LINE) {
		fb_GfxDrawLine( context, x1, y1, x2, y2, color, style );
	} else {
		fb_hFixCoordsOrder(&x1, &y1, &x2, &y2);
		fb_hGfxBox(x1, y1, x2, y2, color, (type == LINE_TYPE_BF), style);
	}

	FB_GRAPHICS_UNLOCK( );
}
