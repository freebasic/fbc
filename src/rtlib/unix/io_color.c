/* console COLOR statement */

#include "../fb.h"
#include "fb_private_console.h"

unsigned int fb_ConsoleColor( unsigned int fc, unsigned int bc, int flags )
{
	const char map[8] = { 0, 4, 2, 6, 1, 5, 3, 7 };
	unsigned int old_fg = __fb_con.fg_color;
	unsigned int old_bg = __fb_con.bg_color;
	int force = FALSE;

	if (!__fb_con.inited)
		return old_fg | (old_bg << 16);

	if (!(flags & FB_COLOR_FG_DEFAULT))
		__fb_con.fg_color = (fc & 0xF);
	if (!(flags & FB_COLOR_BG_DEFAULT))
		__fb_con.bg_color = (bc & 0xF);

	if ((__fb_con.inited == INIT_CONSOLE) || (__fb_con.term_type != TERM_XTERM)) {
		/* console and any terminal but xterm do not support extended color attributes and only allow 16+8 colors */
		if (__fb_con.fg_color != old_fg) {
			if ((__fb_con.fg_color ^ old_fg) & 0x8) {
				/* bright mode changed: reset attributes and force setting both back and fore colors */
				fb_hTermOut(SEQ_RESET_COLOR, 0, 0);
				if (__fb_con.fg_color & 0x8)
					fb_hTermOut(SEQ_BRIGHT_COLOR, 0, 0);
				force = TRUE;
			}
			fb_hTermOut(SEQ_FG_COLOR, 0, map[__fb_con.fg_color & 0x7]);
		}
		if ((__fb_con.bg_color != old_bg) || (force))
			fb_hTermOut(SEQ_BG_COLOR, 0, map[__fb_con.bg_color & 0x7]);
	} else {
		/* generic xterm supports 16+16 colors */
		if (__fb_con.fg_color != old_fg)
			fb_hTermOut(SEQ_SET_COLOR_EX, map[__fb_con.fg_color & 0x7] + (__fb_con.fg_color & 0x8 ? 90 : 30), 0);
		if (__fb_con.bg_color != old_bg)
			fb_hTermOut(SEQ_SET_COLOR_EX, map[__fb_con.bg_color & 0x7] + (__fb_con.bg_color & 0x8 ? 100 : 40), 0);
	}

	return old_fg | (old_bg << 16);
}

unsigned int fb_ConsoleGetColorAtt( void )
{
	return __fb_con.inited ? (__fb_con.fg_color | (__fb_con.bg_color << 4)) : 0x7;
}
