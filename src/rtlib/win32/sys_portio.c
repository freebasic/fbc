/* ports I/O functions */

#include "../fb.h"
#include "fb_private_console.h"
#include "fbportio.h"
#include <windows.h>
#include <winioctl.h>

#ifdef HOST_X86

#include "fbportio_inline.h"

static int inited = FALSE;

static void remove_driver( void )
{
	SC_HANDLE manager, service;
	SERVICE_STATUS status;

	manager = OpenSCManager( NULL, NULL, GENERIC_ALL );
	if( manager ) {
		service = OpenService( manager, "fbportio", SERVICE_ALL_ACCESS );
		if( service ) {
			ControlService( service, SERVICE_CONTROL_STOP, &status );
			DeleteService( service );
			CloseServiceHandle( service );
		}
		CloseServiceHandle( manager );
	}
}

static SC_HANDLE install_driver( SC_HANDLE manager )
{
	SC_HANDLE service = NULL;
	char driver_filename[MAX_PATH];

	remove_driver( );

	if( GetSystemDirectory( driver_filename, MAX_PATH ) ) {
		strncat( driver_filename, "\\Drivers\\fbportio.sys", MAX_PATH - strlen( driver_filename ) - 1 );
		driver_filename[MAX_PATH-1] = '\0';

		FILE *f = fopen( driver_filename, "wb" );
		fwrite( fbportio_driver, FBPORTIO_DRIVER_SIZE, 1, f );
		fclose( f );

		service = CreateService( manager, "fbportio", "fbportio",
			SERVICE_ALL_ACCESS, SERVICE_KERNEL_DRIVER, SERVICE_DEMAND_START, SERVICE_ERROR_NORMAL,
			"System32\\Drivers\\fbportio.sys", NULL, NULL, NULL, NULL, NULL );
	}
	return service;
}

static void start_driver( void )
{
	SC_HANDLE manager, service;

	manager = OpenSCManager( NULL, NULL, GENERIC_ALL );
	if( !manager )
		manager = OpenSCManager( NULL, NULL, GENERIC_READ );
	if( manager ) {
		service = OpenService( manager, "fbportio", SERVICE_ALL_ACCESS );
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
				driver = CreateFile( "\\\\.\\fbportio", GENERIC_READ | GENERIC_WRITE, 0, NULL,
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

int fb_hIn( unsigned short port )
{
	unsigned char value;

	if( !inited )
		inited = init_ports( );
	if( !inited )
		return -fb_ErrorSetNum( FB_RTERROR_NOPRIVILEGES );

	__asm__ volatile ("inb %1, %0" : "=a" (value) : "d" (port));

	return (int)value;
}

int fb_hOut( unsigned short port, unsigned char value )
{
	if( !inited )
		inited = init_ports( );
	if( !inited )
		return fb_ErrorSetNum( FB_RTERROR_NOPRIVILEGES );

	__asm__ volatile ("outb %0, %1" : : "a" (value), "d" (port));

	return FB_RTERROR_OK;
}

#else

int fb_hIn( unsigned short port )
{
	return -fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

int fb_hOut( unsigned short port, unsigned char value )
{
	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

#endif
