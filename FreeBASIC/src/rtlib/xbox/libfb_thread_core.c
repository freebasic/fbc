/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 * thread_core.c -- xbox thread creation and destruction
 *
 * chng: apr/2007 written [DrV]
 *
 */

#include "fb.h"

#include <xboxkrnl/xboxkrnl.h>

/*:::::*/
static void NTAPI threadproc(void *param1, void *param2)
{

#if 0
	FBTHREAD *thread = param1;
	
	/* call the user thread procedure */
	thread->proc( thread->param );
	
	/* free mem */
	fb_TlsFreeCtxTb( );
#endif

}


/*:::::*/
FBCALL FBTHREAD *fb_ThreadCreate( FB_THREADPROC proc, void *param, int stack_size )
{
	NTSTATUS status;
	FBTHREAD *thread;
	
	thread = malloc( sizeof( FBTHREAD ) );
	
	if ( !thread )
		return NULL;
	
	thread->proc = proc;
	thread->param = param;
	
	status = PsCreateSystemThreadEx( &thread->id, /* ThreadHandle */
	                                 0,           /* ThreadExtraSize */
	                                 /* stack_size??? */ 65536,       /* KernelStackSize */
	                                 0,           /* TlsDataSize */
	                                 NULL,        /* ThreadId */
	                                 &thread,     /* StartContext1 */
	                                 NULL,        /* StartContext2 */
	                                 FALSE,       /* CreateSuspended */
	                                 FALSE,       /* DebugStack */
	                                 threadproc); /* StartRoutine */
	
	if ( status != STATUS_SUCCESS )
	{
		free( thread );
		return NULL;
	}
	
	return NULL;
}

/*:::::*/
FBCALL void fb_ThreadWait( FBTHREAD *thread )
{
	if( !thread )
		return;
	
	NTWaitForSingleObject( thread->id, FALSE, NULL );
	NtClose( thread->id );
	free( thread );
}
