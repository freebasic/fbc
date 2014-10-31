/* CIRCLE statement */

#include "fb_gfx.h"
#include <math.h>

static void draw_scanline(FB_GFXCTX *ctx, int y, int x1, int x2, unsigned int color, int fill, char *filled)
{
	if ((y >= ctx->view_y) && (y < ctx->view_y + ctx->view_h)) {
		if (fill) {
			if ((x2 < ctx->view_x) || (x1 >= ctx->view_x + ctx->view_w) || (filled[y - ctx->view_y]))
				return;
			filled[y - ctx->view_y] = TRUE;
			x1 = MAX(x1, ctx->view_x);
			x2 = MIN(x2, ctx->view_x + ctx->view_w - 1);
			ctx->pixel_set(ctx->line[y] + (x1 * ctx->target_bpp), color, x2 - x1 + 1);
		}
		else {
			if ((x1 >= ctx->view_x) && (x1 < ctx->view_x + ctx->view_w))
				ctx->put_pixel(ctx, x1, y, color);
			if ((x2 >= ctx->view_x) && (x2 < ctx->view_x + ctx->view_w))
				ctx->put_pixel(ctx, x2, y, color);
		}
	}
}

static void draw_ellipse
	(
		FB_GFXCTX *ctx,
		int x,
		int y,
		float a,
		float b,
		unsigned int color,
		int fill,
		int *top,
		int *bottom
	)
{
	int d, x1, y1, x2, y2;
	long long dx, dy, aq, bq, r, rx, ry;
	char filled[ctx->view_h];

	x1 = x - a;
	x2 = x + a;
	y1 = y2 = y;
	fb_hMemSet(filled, 0, ctx->view_h);

	if (!b) {
		draw_scanline(ctx, y, x1, x2, color, TRUE, filled);
		*top = y;
		*bottom = y;
		return;
	}

	draw_scanline(ctx, y, x1, x2, color, fill, filled);

	aq = a * a;
	bq = b * b;
	dx = aq << 1;
	dy = bq << 1;
	r = a * bq;
	rx = r << 1;
	ry = 0;
	d = a;

	while (d > 0) {
		if (r > 0) {
			y1++;
			y2--;
			ry += dx;
			r -= ry;
		}
		if (r <= 0) {
			d--;
			x1++;
			x2--;
			rx -= dy;
			r += rx;
		}
		draw_scanline(ctx, y1, x1, x2, color, fill, filled);
		draw_scanline(ctx, y2, x1, x2, color, fill, filled);
	}

	/* Tell caller exactly which rows were drawn so the SET_DIRTY() will be
	   correct */
	*top = y2;
	*bottom = y1;
}

static void get_arc_point(float angle, float a, float b, int *x, int *y)
{
	float c, s;

	c = cos(angle) * a;
	s = sin(angle) * b;
	*x = CINT(c);
	*y = CINT(s);
}

FBCALL void fb_GfxEllipse(void *target, float fx, float fy, float radius, unsigned int color, float aspect, float start, float end, int fill, int flags)
{
	FB_GFXCTX *context;
	int x, y, x1, y1, top, bottom;
	unsigned int orig_color;
	float a, b, orig_x, orig_y, increment;

	FB_GRAPHICS_LOCK( );

	if (!__fb_gfx || radius <= 0.0) {
		FB_GRAPHICS_UNLOCK( );
		return;
	}

	context = fb_hGetContext();
	orig_x = fx;
	orig_y = fy;

	fb_hPrepareTarget(context, target);

	orig_color = color;
	if (flags & DEFAULT_COLOR_1)
		color = context->fg_color;
	else
		color = fb_hFixColor(context->target_bpp, color);
	
	fb_hSetPixelTransfer(context, color);

	fb_hFixRelative(context, flags, &fx, &fy, NULL, NULL);

	fb_hTranslateCoord(context, fx, fy, &x, &y);

	if (context->flags & CTX_WINDOW_ACTIVE) {
		/* radius gets multiplied by the VIEW/WINDOW width ratio (aspect is unchanged) */
		radius *= (context->view_w / context->win_w);
	}

	if (aspect == 0.0)
		aspect = __fb_gfx->aspect;

	if (aspect > 1.0) {
		a = (radius / aspect);
		b = radius;
	} else {
		a = radius;
		b = (radius * aspect);
	}

	if ((start != 0.0) || (end != 3.141593f * 2.0)) {
		if (start < 0) {
			start = -start;
			get_arc_point(start, a, b, &x1, &y1);
			x1 = orig_x + x1;
			y1 = orig_y - y1;
			fb_GfxLine(target, orig_x, orig_y, x1, y1, orig_color, LINE_TYPE_LINE, 0xFFFF, COORD_TYPE_AA | (flags & ~COORD_TYPE_MASK));
		}
		if (end < 0) {
			end = -end;
			get_arc_point(end, a, b, &x1, &y1);
			x1 = orig_x + x1;
			y1 = orig_y - y1;
			fb_GfxLine(target, orig_x, orig_y, x1, y1, orig_color, LINE_TYPE_LINE, 0xFFFF, COORD_TYPE_AA | (flags & ~COORD_TYPE_MASK));
		}
		
		while (end < start)
			end += 2 * PI;
		while (end - start > 2 * PI)
			start += 2 * PI;

		increment = 1 / (sqrt(a) * sqrt(b) * 1.5);

		DRIVER_LOCK();

		top = bottom = y;
		for (; start < end + (increment / 2); start += increment) {
			get_arc_point(start, a, b, &x1, &y1);
			x1 = x + x1;
			y1 = y - y1;
			if ((x1 < context->view_x) || (x1 >= context->view_x + context->view_w) ||
			    (y1 < context->view_y) || (y1 >= context->view_y + context->view_h))
				continue;
			context->put_pixel(context, x1, y1, color);
			if (y1 > bottom)
				bottom = y1;
			if (y1 < top)
				top = y1;
		}
	} else {
		DRIVER_LOCK();
		draw_ellipse(context, x, y, a, b, color, fill, &top, &bottom);
	}

	top = MID(context->view_y, top, context->view_y + context->view_h - 1);
	bottom = MID(context->view_y, bottom, context->view_y + context->view_h - 1);
	if( top > bottom )
		SWAP( top, bottom );

	SET_DIRTY(context, top, bottom - top + 1);

	DRIVER_UNLOCK();
	FB_GRAPHICS_UNLOCK( );
}
