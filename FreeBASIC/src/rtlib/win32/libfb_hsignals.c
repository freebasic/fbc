/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
 */

/*
 * signal.c -- low-level signal handlers for Windows
 *
 * chng: jul/2005 written [v1ctor]
 *
 */

#include <signal.h>
#include "fb.h"

static LPTOP_LEVEL_EXCEPTION_FILTER old_excpfilter;

/*:::::*/
static __stdcall LONG exception_filter( LPEXCEPTION_POINTERS info )
{

	switch( info->ExceptionRecord->ExceptionCode )
	{
	case EXCEPTION_ACCESS_VIOLATION:
		raise( SIGSEGV );
	    break;

	case EXCEPTION_FLT_DIVIDE_BY_ZERO:
		raise( SIGFPE );
		break;

	case EXCEPTION_INT_DIVIDE_BY_ZERO:
		raise( SIGFPE );
		break;
	}

	return old_excpfilter( info );
}

/*:::::*/
void fb_hInitSignals( void )
{
	old_excpfilter = SetUnhandledExceptionFilter( exception_filter );
}
