/* LINE statement */

#include "fb_gfx.h"

static int reverse_mask(int mask)
{
	mask = ((mask >> 1) & 0x5555) | ((mask & 0x5555) << 1);
	mask = ((mask >> 2) & 0x3333) | ((mask & 0x3333) << 2);
	mask = ((mask >> 4) & 0x0F0F) | ((mask & 0x0F0F) << 4);
	mask = ((mask >> 8) & 0x00FF) | ((mask & 0x00FF) << 8);
	return mask;
}

/* Assumes coordinates to be physical ones.
 * Also assumes color is already masked. */

/* Caller is expected to hold FB_GRAPHICS_LOCK() */
void fb_GfxDrawLine(FB_GFXCTX *context, int x1, int y1, int x2, int y2, unsigned int color, unsigned int style)
{
	int x, y, d, dx, dy, ax, ay, skip, rot, bit;
	int xmin = context->view_x, xmax = context->view_x + context->view_w - 1;
	int ymin = context->view_y, ymax = context->view_y + context->view_h - 1;

	/* line entirely out of bounds? */
	if ((x1 < xmin) && (x2 < xmin))
		return;
	else if ((x1 > xmax) && (x2 > xmax))
		return;
	else if ((y1 < ymin) && (y2 < ymin))
		return;
	else if ((y1 > ymax) && (y2 > ymax))
		return;

	/* store dy/dx before line is clipped */
	dx = x2 - x1;
	dy = y2 - y1;

	/* clip x2, y2 */
	x2 = MID(xmin, x2, xmax);
	y2 = MID(ymin, y2, ymax);

	rot = 0;

	DRIVER_LOCK();
	/* vertical line */
	if (dx == 0) {
		/* clip y1 */
		if (y1 < ymin) {
			rot += ymin - y1;
			y1 = ymin;
		} else if (y1 > ymax) {
			rot += y1 - ymax;
			y1 = ymax;
		}
		/* go from top down */
		if (y1 > y2) {
			style = reverse_mask(style);
			rot = (~rot) + y2 - y1;
			SWAP(y1, y2);
		}
		bit = 0x8000 >> (rot & 0xF);

		for (y = y1; y <= y2; y++) {
			if (style & bit)
				context->put_pixel(context, x1, y, color);
			RORW1(bit);
		}
	}
	/* horizontal line */
	else if (dy == 0) {
		/* clip x1 */
		if (x1 < xmin) {
			rot += (xmin - x1);
			x1 = xmin;
		} else if (x1 > xmax) {
			rot += (x1 - xmax);
			x1 = xmax;
		}
		/* go from left to right */
		if (x1 > x2) {
			style = reverse_mask(style);
			rot = (~rot) + x2 - x1;
			SWAP(x1, x2);
		}
		bit = 0x8000 >> (rot & 0xF );

		if (style == 0xFFFF)
			context->pixel_set(context->line[y1] + (x1 * context->target_bpp), color, x2 - x1 + 1);
		else {
			for (x = x1; x <= x2; x++) {
				if (style & bit)
					context->put_pixel(context, x, y1, color);
				RORW1(bit);
			}
		}
	/* diagonal line */
	} else {
		ax = ay = 1;
		if (dx < 0) {
			dx = -dx;
			ax = -1;
		}
		if (dy < 0) {
			dy = -dy;
			ay = -1;
		}

		d = (dx >= dy)? dy * 2 - dx : dy - dx * 2;
		dx *= 2;
		dy *= 2;

		/* clip x, y start values */
		x = MID(xmin, x1, xmax);
		d += ax * (x - x1) * dy;

		y = MID(ymin, y1, ymax);
		d -= ay * (y - y1) * dx;

		/* shift style if necessary */
		if (dx >= dy)
			rot += ax * (x - x1);
		else
			rot += ay * (y - y1);

		/* line terminates when x2 or y2 reached */
		x2 = x2 + ax;
		y2 = y2 + ay;

		/* shallow gradient */
		if (dx >= dy) {
			/* put y, x back on the line if clipped*/
			if (d >= dy) {
				skip = (d - dy) / dx + 1;
				y += ay * skip;
				d -= skip * dx;
				if ((y < ymin) || (y > ymax))
					goto done;
			} else if (d < (dy - dx)) {
				skip = ((dy - dx) - d) / dy + 1;
				x += ax * skip;
				d += skip * dy;
				rot += skip;
				if ((x < xmin) || (x > xmax))
					goto done;
			}
			bit = 0x8000 >> (rot & 0xF);
			y1 = y; /* first dirty row */

			while ((x != x2) && (y != y2)) {
				if (style & bit)
					context->put_pixel(context, x, y, color);
				RORW1(bit);
				if (d >= 0) {
					y += ay;
					d -= dx;
				}
				d += dy;
				x += ax;
				/* invariant: (-dx + dy) <= d < dy */
			}
		/* steep gradient */
		} else {
			/* put x, y back on the line if clipped */
			if (d < -dx) {
				skip = (-dx - d) / dy + 1;
				x += ax * skip;
				d += skip * dy;
				if ((x < xmin) || (x > xmax))
					goto done;
			} else if (d > dy - dx) {
				skip = (d - (dy - dx)) / dx + 1;
				y += ay * skip;
				d -= skip * dx;
				rot += skip;
				if ((y < ymin) || (y > ymax))
					goto done;
			}
			bit = 0x8000 >> (rot & 0xF);
			y1 = y; /* first dirty row */

			while ((y != y2) && (x != x2)) {
				if (style & bit)
					context->put_pixel(context, x, y, color);
				RORW1(bit);
				if (d <= 0) {
					x += ax;
					d += dy;
				}
				d -= dx;
				y += ay;
				/* invariant: (-dx) <= d < (-dx + dy) */
			}
		}
		y2 -= ay; /* last dirty row */
	}
	if (y1 > y2)
		SWAP(y1, y2);
	SET_DIRTY(context, y1, y2 - y1 + 1);
	done:
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
