/* Function to get supported video modes. */

#include "fb_gfx.h"

static int *list = NULL, list_size, current;

static void add_mode(int mode)
{
	int i;

	if (!list) {
		list = malloc(sizeof(int) * 2);
		list[0] = mode;
		list[1] = 0;
		list_size = 1;
	} else {
		for (i = 0; i < list_size; i++) {
			if (list[i] == mode)
				return;
		}
		list = (int *)realloc(list, sizeof(int) * (list_size + 1));
		list[list_size] = mode;
		list_size++;
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
	const GFXDRIVER *driver;
	int i, j, *temp, size, result;

	FB_GRAPHICS_LOCK( );

	if (depth > 0) {
		if (list)
			free(list);
		list = NULL;
		for (i = 0; __fb_gfx_drivers_list[i]; i++) {
			driver = __fb_gfx_drivers_list[i];
			if (driver->fetch_modes) {
				temp = driver->fetch_modes(depth, &size);
				if (temp) {
					for (j = 0; j < size; j++)
						add_mode(temp[j]);
					free(temp);
				}
			}
		}
		if (list)
			qsort(list, list_size, sizeof(int), mode_sorter);
		current = 0;
	}

	current++;
	if ((!list) || (current > list_size)) {
		result = 0;
	} else {
		result = list[current - 1];
	}

	FB_GRAPHICS_UNLOCK( );
	return result;
}
