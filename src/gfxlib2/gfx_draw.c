/* DRAW command */

#include "fb_gfx.h"
#include <math.h>
#include <ctype.h>

#define FB_NAN		((intptr_t)0x80000000)
#define SQRT_2		1.4142135623730950488016

static float base_scale = 1.0;
static int base_angle = 0;

/* Returns sine of angle in degrees - quickly return exact values for 0/90/180/270 */
static float dsin(int angle)
{
	switch( angle )
	{
	case 0:  	return 0.0;
	case 90: 	return 1.0;
	case 180:	return 0.0;
	case 270:	return -1.0;
	default: 	return sin((float)angle * PI / 180.0);
	}
}

/* Returns cosine of angle in degrees - quickly return exact values for 0/90/180/270 */
static float dcos(int angle)
{
	switch( angle )
	{
	case 0:  	return 1.0;
	case 90: 	return 0.0;
	case 180:	return -1.0;
	case 270:	return 0.0;
	default: 	return cos((float)angle * PI / 180.0);
	}
}

/* Returns a value wrapped to the range 0..359 - avoids '%' in the range 0..719 for speed */
static int mod360(int angle)
{
	if( angle < 0 )
	{
		return ((angle + 1) % 360) + 359;
	}
	else if( angle >= 360 )
	{
		return (angle < 720)? (angle - 360) : (angle % 360);
	}
	else
	{
		return angle;
	}
}

static intptr_t parse_number(char **str)
{
	char *c = *str;
	intptr_t n = FB_NAN;
	int negative = FALSE;

	while ((*c == ' ') || (*c == '\t') || (*c == '+') || (*c == '-'))
	{
		if (*c == '-')
			negative = !negative;
		c++;
	}
	while ((*c >= '0') && (*c <= '9')) {
		if (n == FB_NAN)
			n = 0;
		n = (n * 10) + (*c - '0');
		c++;
	}
	*str = c;
	if ((negative) && (n != FB_NAN))
		n = -n;

	return n;
}

FBCALL void fb_GfxDraw(void *target, FBSTRING *command)
{
	FB_GFXCTX *context;
	float x, y, dx, dy, ax, ay, x2, y2;
	int angle = 0, diagonal = FALSE;
	char *c;
	intptr_t value1, value2;
	int draw = TRUE, move = TRUE, length = 0, flags, rel;

	FB_GRAPHICS_LOCK( );

	if ((!__fb_gfx) || (!command) || (!command->data)) {
		if (command)
			fb_hStrDelTemp(command);
		FB_GRAPHICS_UNLOCK( );
		return;
	}

	context = fb_hGetContext( );
	fb_hPrepareTarget(context, target);
	fb_hSetPixelTransfer(context, MASK_A_32);

	x = context->last_x;
	y = context->last_y;

	DRIVER_LOCK();

	flags = context->flags;
	context->flags |= CTX_VIEW_SCREEN;

	for (c = command->data; *c;) {
		switch (toupper(*c)) {
			case 'B':
				c++;
				draw = FALSE;
				break;

			case 'N':
				c++;
				move = FALSE;
				break;

			case 'C':
				c++;
				if ((value1 = parse_number(&c)) == FB_NAN)
					goto error;
				context->fg_color = fb_hFixColor(context->target_bpp, value1);
				break;

			case 'S':
				c++;
				if ((value1 = parse_number(&c)) == FB_NAN)
					goto error;
				base_scale = (float)value1 / 4.0;
				break;

			case 'A':
				c++;
				if ((value1 = parse_number(&c)) == FB_NAN)
					goto error;
				base_angle = (value1 & 0x3) * 90;
				break;

			case 'T':
				c++;
				if (toupper(*c) != 'A')
					goto error;
				c++;
				if ((value1 = parse_number(&c)) == FB_NAN)
					goto error;
				base_angle = mod360( value1 );
				break;

			case 'X':
				c++;
				/* Here we could be more severe with checking, but it's unlikely our substring
				 * resides at location FB_NAN (0x80000000) */
				if ((value1 = parse_number(&c)) == FB_NAN)
					goto error;

				/* Store our current x/y for the recursive fb_GfxDraw() call */
				context->last_x = x;
				context->last_y = y;

				DRIVER_UNLOCK();
				fb_GfxDraw(target, (FBSTRING *)value1);
				DRIVER_LOCK();

				/* And update to x/y produced by the recursive fb_GfxDraw() call */
				x = context->last_x;
				y = context->last_y;

				break;

			case 'P':
				c++;
				if ((value1 = parse_number(&c)) == FB_NAN)
					goto error;
				value2 = value1;
				if (*c == ',') {
					c++;
					if ((value2 = parse_number(&c)) == FB_NAN)
						goto error;
				}
				DRIVER_UNLOCK();
				fb_GfxPaint(target, x, y, value1 & __fb_gfx->color_mask, value2 & __fb_gfx->color_mask, NULL, PAINT_TYPE_FILL, COORD_TYPE_A);
				DRIVER_LOCK();
				break;

			case 'M':
				c++;
				while ((*c == ' ') || (*c == '\t'))
					c++;
				rel = ((*c == '+') || (*c == '-'));
				if ((value1 = parse_number(&c)) == FB_NAN)
					goto error;
				if (*c++ != ',')
					goto error;
				if ((value2 = parse_number(&c)) == FB_NAN)
					goto error;
				x2 = (float)value1;
				y2 = (float)value2;
				if (rel) {
					ax = dcos(base_angle);
					ay = -dsin(base_angle);
					dx = x2;
					dy = y2;
					x2 = (((dx * ax) - (dy * ay)) * base_scale) + x;
					y2 = (((dy * ax) + (dx * ay)) * base_scale) + y;
				}
				if (draw) {
					DRIVER_UNLOCK();
					fb_GfxLine(target, (int)x, (int)y, (int)x2, (int)y2, 0, LINE_TYPE_LINE, 0xFFFF, COORD_TYPE_AA | DEFAULT_COLOR_1);
					DRIVER_LOCK();
				}
				if (move) {
					x = x2;
					y = y2;
				}
				move = draw = TRUE;
				break;

			case 'F': case 'D': angle += 90; /* fall through */
			case 'G': case 'L': angle += 90; /* fall through */
			case 'H': case 'U': angle += 90; /* fall through */
			case 'E': case 'R':
				diagonal = ((toupper(*c) >= 'E') && (toupper(*c) <= 'H'));
				c++;
				if ((value1 = parse_number(&c)) != FB_NAN)
					length = value1;
				else
					length = 1;

				angle = mod360( angle + base_angle );
				dx = (float)length * base_scale * dcos( angle );
				dy = (float)length * base_scale * -dsin( angle );

				if (diagonal) {
					x2 = x + (dx + dy);
					y2 = y + (dy - dx);
				}
				else {
					x2 = x + dx;
					y2 = y + dy;
				}
				if (draw) {
					fb_GfxDrawLine( context, CINT(x), CINT(y), CINT(x2), CINT(y2), context->fg_color, 0xffff );
				}
				if (move) {
					x = x2;
					y = y2;
				}

				angle = 0;
				move = draw = TRUE;
				break;

			default:
				c++;
				break;
		}
	}

	context->last_x = x;
	context->last_y = y;

error:
	context->flags = flags;

	DRIVER_UNLOCK();

	/* del if temp */
	fb_hStrDelTemp( command );

	FB_GRAPHICS_UNLOCK( );
}
