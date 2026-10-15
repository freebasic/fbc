/* Function to get supported video modes. */

#include "fb_gfx.h"

/* Enumeration state is kept per thread (like Dir()), so that one thread
   walking the list with ScreenList() isn't disturbed by another thread
   starting a new enumeration with ScreenList(depth). */
typedef struct _FB_GFXSCREENLISTCTX {
	int *list;
	int list_size;
	int current;
} FB_GFXSCREENLISTCTX;

static void fb_GFXSCREENLISTCTX_Destructor(void *data)
{
	FB_GFXSCREENLISTCTX *ctx = (FB_GFXSCREENLISTCTX *)data;
	free(ctx->list);
}

static void add_mode(FB_GFXSCREENLISTCTX *ctx, int mode)
{
	int i;

	if (!ctx->list) {
		ctx->list = malloc(sizeof(int) * 2);
		ctx->list[0] = mode;
		ctx->list[1] = 0;
		ctx->list_size = 1;
	} else {
		for (i = 0; i < ctx->list_size; i++) {
			if (ctx->list[i] == mode)
				return;
		}
		ctx->list = (int *)realloc(ctx->list, sizeof(int) * (ctx->list_size + 1));
		ctx->list[ctx->list_size] = mode;
		ctx->list_size++;
	}
}

static int mode_sorter(const void *e1, const void *e2)
{
	int m1 = *(int *)e1;
	int m2 = *(int *)e2;

	if ((m1 >> 16) > (m2 >> 16))
		return 1;
	else if (((m1 >> 16) == (m2 >> 16)) && ((m1 & 0xFFFF) > (m2 & 0xFFFF)))
		return 1;
	else if (m1 == m2)
		return 0;
	else
		return -1;
}

FBCALL int fb_GfxScreenList(int depth)
{
	FB_GFXSCREENLISTCTX *ctx;
	const GFXDRIVER *driver;
	int i, j, *temp, size, result;

	FB_GRAPHICS_LOCK( );

	ctx = FB_TLSGETCTX(GFXSCREENLIST);

	if (depth > 0) {
		if (ctx->list)
			free(ctx->list);
		ctx->list = NULL;
		ctx->list_size = 0;
		for (i = 0; __fb_gfx_drivers_list[i]; i++) {
			driver = __fb_gfx_drivers_list[i];
			if (driver->fetch_modes) {
				temp = driver->fetch_modes(depth, &size);
				if (temp) {
					for (j = 0; j < size; j++)
						add_mode(ctx, temp[j]);
					free(temp);
				}
			}
		}
		if (ctx->list)
			qsort(ctx->list, ctx->list_size, sizeof(int), mode_sorter);
		ctx->current = 0;
	}

	ctx->current++;
	if ((!ctx->list) || (ctx->current > ctx->list_size)) {
		result = 0;
	} else {
		result = ctx->list[ctx->current - 1];
	}

	FB_GRAPHICS_UNLOCK( );
	return result;
}
