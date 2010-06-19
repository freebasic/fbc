/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * signal.c -- signal handlers
 *
 * chng: jul/2005 written [v1ctor]
 *
 */

#include <signal.h>
#include "fb.h"

typedef struct _FB_SIGHANDLER {
	int		errnum;
	void 	(*oldhnd)(int);
} FB_SIGHANDLER;

static FB_SIGHANDLER sigTb[NSIG];

/*:::::*/
#define FB_SETUPSIGNAL(n,h) 				\
    sigTb[n].oldhnd = signal( n, h ); 		\
    sigTb[n].errnum = FB_RTERROR_##n;

/*:::::*/
static void gen_handler( int sig )
{
	FB_ERRHANDLER handler;

	/* don't cause another exception */
	if( (sig < 0) || (sig >= NSIG) || (sigTb[sig].errnum == FB_RTERROR_OK) )
	{
		raise( sig );
		return;
	}

	/* call user handler if any defined */
	handler = fb_ErrorThrowEx( sigTb[sig].errnum, -1, NULL, NULL, NULL );
	if( handler != NULL )
		handler( );

	/* if the user handler returned, exit */
	fb_End( sigTb[sig].errnum );
}

/*:::::*/
FBCALL void fb_InitSignals( void )
{
	memset( sigTb, 0, sizeof(sigTb) );

	FB_SETUPSIGNAL(SIGABRT, gen_handler)
	FB_SETUPSIGNAL(SIGFPE, gen_handler)
	FB_SETUPSIGNAL(SIGILL, gen_handler)
	FB_SETUPSIGNAL(SIGSEGV, gen_handler)
	FB_SETUPSIGNAL(SIGTERM, gen_handler)
	FB_SETUPSIGNAL(SIGINT, gen_handler)
#ifdef SIGQUIT
	FB_SETUPSIGNAL(SIGQUIT, gen_handler)
#endif

	/* os-dep */
	fb_hInitSignals( );
}
