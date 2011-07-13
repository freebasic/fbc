/*
 * init.c -- libfb initialization for NetBSD
 *
 * chng: sep/2007 written [DrV]
 *
 */

#include "fb.h"

/*:::::*/
void fb_hInit ( void )
{
	fb_unix_hInit( );
}
