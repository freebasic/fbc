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
 * sys_ports.c -- ports I/O for Win32
 *
 * chng: aug/2005 written [lillo]
 *
 */

#include "fb.h"
#include "fb_win32.h"
#include "portio/fbportio.h"
#include "portio/fbportio_driver.h"
#include <winioctl.h>


static int inited = FALSE;


/*:::::*/
static void remove_driver( void )
{
	SC_HANDLE manager, service;
	SERVICE_STATUS status;

	manager = OpenSCManager( NULL, NULL, GENERIC_ALL );
	if( manager ) {
		service = OpenService( manager, FBPORTIO_NAME, SERVICE_ALL_ACCESS );
		if( service ) {
			ControlService( service, SERVICE_CONTROL_STOP, &status );
			DeleteService( service );
			CloseServiceHandle( service );
		}
		CloseServiceHandle( manager );
	}
}


/*:::::*/
static SC_HANDLE install_driver( SC_HANDLE manager )
{
	SC_HANDLE service = NULL;
	FILE *f;
	char driver_filename[MAX_PATH];
	
	remove_driver( );
	
	if( GetSystemDirectory( driver_filename, MAX_PATH ) ) {
		strncat( driver_filename, "\\Drivers\\" FBPORTIO_NAME ".sys", MAX_PATH-1 );
		f = fopen( driver_filename, "wb" );
		fwrite( fbportio_driver, FBPORTIO_DRIVER_SIZE, 1, f );
		fclose( f );
		
		service = CreateService( manager, FBPORTIO_NAME, FBPORTIO_NAME,
			SERVICE_ALL_ACCESS, SERVICE_KERNEL_DRIVER, SERVICE_DEMAND_START, SERVICE_ERROR_NORMAL,
			"System32\\Drivers\\" FBPORTIO_NAME ".sys", NULL, NULL, NULL, NULL, NULL );
	}
	return service;
}


/*:::::*/
static void start_driver( void )
{
	SC_HANDLE manager, service;

	manager = OpenSCManager( NULL, NULL, GENERIC_ALL );
	if( !manager )
		manager = OpenSCManager( NULL, NULL, GENERIC_READ );
	if( manager ) {
		service = OpenService( manager, FBPORTIO_NAME, SERVICE_ALL_ACCESS );
		if( (!service ) || (!StartService( service, 0, NULL ) ) ) {
			if( service )
				CloseServiceHandle( service );
			service = install_driver( manager );
			StartService( service, 0, NULL );
		}
		CloseServiceHandle( service );
		CloseServiceHandle( manager );
	}
}


/*:::::*/
static int init_ports( void )
{
	OSVERSIONINFO ver_info;
	HANDLE driver;
	DWORD pid, bytes_written;
	WORD driver_version;
	int status, started = FALSE;
	
	
	memset( &ver_info, 0, sizeof(OSVERSIONINFO) );
	ver_info.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
	if ( !GetVersionEx( (OSVERSIONINFO *)&ver_info ) )
		return FALSE;
	switch (ver_info.dwPlatformId) {
		
		case VER_PLATFORM_WIN32_WINDOWS:
			break;
		
		case VER_PLATFORM_WIN32_NT:
			do {
				driver = CreateFile( "\\\\.\\" FBPORTIO_NAME, GENERIC_READ | GENERIC_WRITE, 0, NULL,
					OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL );
				if( driver == INVALID_HANDLE_VALUE ) {
					if( !started ) {
						start_driver( );
						started = TRUE;
					}
					else
						return FALSE;
				}
				else {
					if( !DeviceIoControl( driver, IOCTL_GET_VERSION, NULL, 0, &driver_version, 2, &bytes_written, NULL ) ||
							( driver_version != FBPORTIO_VERSION ) ) {
						/* Not our driver or an old version of it; reinstall */
						CloseHandle( driver );
						remove_driver( );
						start_driver( );
						started = TRUE;
						driver = INVALID_HANDLE_VALUE;
					}
					else
						break;
				}
			} while( driver == INVALID_HANDLE_VALUE );
			
			/* Ok, we got our driver loaded; grant I/O ports access to our own process */
			pid = GetCurrentProcessId( );
			status = DeviceIoControl( driver, IOCTL_GRANT_IOPM, &pid, 4, NULL, 0, &bytes_written, NULL );
			CloseHandle( driver );
			
			/* Give up our timeslice to ensure process kernel state is updated */
			Sleep(1);
			
			if( !status )
				return FALSE;
			break;
	}
	
	return TRUE;
}


/*:::::*/
int fb_hIn( unsigned short port )
{
	unsigned char value;
	
	if( !inited )
		inited = init_ports( );
	if( !inited )
		return -fb_ErrorSetNum( FB_RTERROR_NOPRIVILEDGES );
	
	__asm__ volatile ("inb %1, %0" : "=a" (value) : "d" (port));
	
	return (int)value;
}


/*:::::*/
int fb_hOut( unsigned short port, unsigned char value )
{
	if( !inited )
		inited = init_ports( );
	if( !inited )
		return fb_ErrorSetNum( FB_RTERROR_NOPRIVILEDGES );
	
	__asm__ volatile ("outb %0, %1" : : "a" (value), "d" (port));
	
	return FB_RTERROR_OK;
}

