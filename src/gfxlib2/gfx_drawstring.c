/* advanced graphical string drawing routine */

#include "fb_gfx.h"

/*
 *	User font format:
 *
 *	Basically a GET/PUT buffer, where the first pixels data line holds the
 *	font header:
 *
 *	offset	|	description
 *	--------+--------------------------------------------------------------
 *	0		|	Font header version (currently must be 0)
 *	1		|	First ascii character supported
 *	2		|	Last ascii character supported
 *	3-(3+n)	|	n-th supported character width
 *
 *	The font height is computed as the height of the buffer minus 1, and the
 *	actual glyph shapes start on the second buffer line, one after another in
 *	the same row, starting with first supported ascii character up to the
 *	last one.
 *
 */

typedef struct FBGFX_CHAR
{
	unsigned int width;
	unsigned char *data;
} FBGFX_CHAR;

FBCALL int fb_GfxDrawString
	(
		void *target,
		float fx,
		float fy,
		int flags,
		FBSTRING *string,
		unsigned int color,
		void *font,
		int mode,
		PUTTER *putter,
		BLENDER *blender,
		void *param
	)
{
	FB_GFXCTX *context;
	FBGFX_CHAR char_data[256], *ch;
	PUT_HEADER *header;
	int font_height, x, y, px, py, i, w, h, pitch, bpp, first, last;
	int offset, bytes_count, res = fb_ErrorSetNum( FB_RTERROR_OK );
	unsigned char *data, *width;

	FB_GRAPHICS_LOCK( );

	context = fb_hGetContext();

	if ((!__fb_gfx) || (!string) || (!string->data)) {
		if (!string)
			res = FB_RTERROR_ILLEGALFUNCTIONCALL;
		goto exit_error_unlocked;
	}

	fb_hPrepareTarget(context, target);

	if (mode != PUT_MODE_ALPHA) {
		if (flags & DEFAULT_COLOR_1)
			color = context->fg_color;
		else
			color = fb_hFixColor(context->target_bpp, color);
	}

	fb_hSetPixelTransfer(context, color);

	fb_hFixRelative(context, flags, &fx, &fy, NULL, NULL);

	fb_hTranslateCoord(context, fx, fy, &x, &y);

	DRIVER_LOCK();

	if (font) {
		/* user passed a custom font */

		header = (PUT_HEADER *)font;
		if (header->type == PUT_HEADER_NEW) {
			bpp = header->bpp;
			font_height = header->height - 1;
			pitch = header->pitch;
			data = (unsigned char *)font + sizeof(PUT_HEADER);
		}
		else {
			bpp = header->old.bpp;
			if (!bpp)
				bpp = context->target_bpp;
			font_height = header->old.height - 1;
			pitch = header->old.width * bpp;
			data = (unsigned char *)font + 4;
		}

		if ((y + font_height <= context->view_y) || (y >= context->view_y + context->view_h))
			goto exit_error;

		if ((bpp != context->target_bpp) || (pitch < 4) || (font_height <= 0) || (data[0] != 0)) {
			res = FB_RTERROR_ILLEGALFUNCTIONCALL;
			goto exit_error;
		}

		first = (int)data[1];
		last = (int)data[2];
		width = &data[3];
		if (first > last)
			SWAP(first, last);
		fb_hMemSet(char_data, 0, sizeof(FBGFX_CHAR) * 256);
		data += pitch;
		if (y < context->view_y) {
			data += (pitch * (context->view_y - y));
			font_height -= (context->view_y - y);
			y = context->view_y;
		}
		if (y + font_height > context->view_y + context->view_h)
			font_height -= ((y + font_height) - (context->view_y + context->view_h));

		for (w = 0, i = first; i <= last; i++) {
			char_data[i].width = (unsigned int)width[i - first];
			char_data[i].data = data;
			data += (char_data[i].width * bpp);
			w += char_data[i].width;
		}
		if (w > (pitch / __fb_gfx->bpp)) {
			res = FB_RTERROR_ILLEGALFUNCTIONCALL;
			goto exit_error;
		}

		for (i = 0; i < (int)FB_STRSIZE(string); i++) {

			if (x >= context->view_x + context->view_w)
				break;

			ch = &char_data[(unsigned char)string->data[i]];
			data = ch->data;
			if (!data) {
				/* character not found */
				x += font_height;
				continue;
			}
			w = ch->width;
			h = font_height;
			px = x;

			if (x + w >= context->view_x) {

				if (x < context->view_x) {
					data += ((context->view_x - x) * bpp);
					w -= (context->view_x - x);
					px = context->view_x;
				}
				if (x + w > context->view_x + context->view_w)
					w -= ((x + w) - (context->view_x + context->view_w));
				putter(data, context->line[y] + (px * bpp), w, h, pitch, context->target_pitch, color, blender, param);

			}
			x += ch->width;
		}
	} else {
		/* use default font */

		font_height = __fb_gfx->font->h;
		w = __fb_gfx->font->w;
		bytes_count = BYTES_PER_PIXEL(w);
		offset = 0;

		if ((x + (w * (int)FB_STRSIZE(string)) <= context->view_x) || (x >= context->view_x + context->view_w) ||
		    (y + font_height <= context->view_y) || (y >= context->view_y + context->view_h)) {
			goto exit_error;
		}

		if (y < context->view_y) {
			offset = (bytes_count * (context->view_y - y));
			font_height -= (context->view_y - y);
			y = context->view_y;
		}
		if (y + font_height > context->view_y + context->view_h)
			font_height -= ((y + font_height) - (context->view_y + context->view_h));

		first = 0;
		if (x < context->view_x) {
			first = (context->view_x - x) / w;
			x += (first * w);
		}
		last = FB_STRSIZE(string);
		if (x + ((last - first) * w) > context->view_x + context->view_w)
			last -= ((x + ((last - first) * w) - (context->view_x + context->view_w)) / w);

		for (i = first; i < last; i++, x += w) {

			if (x + w <= context->view_x)
				continue;

			if (x >= context->view_x + context->view_w)
				break;

			data = (unsigned char *)__fb_gfx->font->data + ((unsigned char)string->data[i] * bytes_count * __fb_gfx->font->h) + offset;
			for (py = 0; py < font_height; py++) {
				for (px = 0; px < w; px++) {
					if ((*data & (1 << (px & 0x7))) && (x + px >= context->view_x) && (x + px < context->view_x + context->view_w))
						context->put_pixel(context, x + px, y + py, color);
					if ((px & 0x7) == 0x7)
						data++;
				}
			}
		}
	}

	SET_DIRTY(context, y, font_height);

exit_error:
	DRIVER_UNLOCK();

exit_error_unlocked:
	fb_hStrDelTemp(string);

	FB_GRAPHICS_UNLOCK( );

	if (res != FB_RTERROR_OK)
		return fb_ErrorSetNum(res);
	else
		return res;
}
