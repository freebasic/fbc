/*
 * con_print_tty.c -- print text data - using TTY (teletype) interpretation
 *
 * chng: sep/2005 written [mjs]
 *
 */

#include <string.h>
#include "fb_con.h"

#define FB_CONPRINTTTY                  fb_ConPrintTTY
#define FB_CONPRINTRAW                  fb_ConPrintRaw
#define FB_TCHAR                        char
#define FB_TCHAR_GET(p)                 (*(p))
#define FB_TCHAR_ADVANCE(i,c)           i += c
#define FB_TCHAR_GET_CHAR_SIZE(p)       1
#define _TC(c)                          c

#include "libfb_con_print_tty_uni.h"
