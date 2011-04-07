#include <windows.h>
#include <winioctl.h>

#include <stddef.h>
#include <stdio.h>

#include "fbportio.h"

static unsigned char *fbportio_driver = NULL;
static size_t FBPORTIO_DRIVER_SIZE = 0;
static DWORD dwLastError = ERROR_SUCCESS;

#define SERVICE_SUCCESS       0
#define SERVICE_OPEN_FAILED   1
#define SERVICE_DELETE_FAILED 2
#define SERVICE_STOP_FAILED   3
#define DRIVER_WRITE_FAILED   4
#define SERVICE_CREATE_FAILED 5
#define SERVICE_START_FAILED  6
#define INIT_FAILED           7
#define DRIVER_READ_FAILED    8
#define DRIVER_CALL_FAILED    9
#define DRIVER_VERSION_MISMATCH 10
#define DRIVER_NO_PRIVILEGE   11

/*:::::*/
static int remove_driver( SC_HANDLE manager )
{
    int ret_code = SERVICE_SUCCESS;
	SC_HANDLE service;

    service = OpenService( manager, FBPORTIO_NAME, SERVICE_ALL_ACCESS );
    if( service ) {
        if( !DeleteService( service ) ) {
            ret_code = SERVICE_DELETE_FAILED;
            dwLastError = GetLastError();
        }
        CloseServiceHandle( service );
    } else {
        ret_code = SERVICE_OPEN_FAILED;
        dwLastError = GetLastError();
    }

    return ret_code;
}

/*:::::*/
static int stop_driver( SC_HANDLE manager )
{
    int ret_code = SERVICE_SUCCESS;
	SC_HANDLE service;

    service = OpenService( manager, FBPORTIO_NAME, SERVICE_ALL_ACCESS );
    if( service ) {
        SERVICE_STATUS status;
        if( !ControlService( service, SERVICE_CONTROL_STOP, &status ) ) {
            ret_code = SERVICE_STOP_FAILED;
            dwLastError = GetLastError();
        }
        CloseServiceHandle( service );
    } else {
        ret_code = SERVICE_OPEN_FAILED;
        dwLastError = GetLastError();
    }

    return ret_code;
}


/*:::::*/
static int install_driver( SC_HANDLE manager, SC_HANDLE *pService )
{
    int ret_code = SERVICE_SUCCESS;
	SC_HANDLE service = NULL;
	char driver_filename[MAX_PATH];

	if( GetSystemDirectory( driver_filename, MAX_PATH ) ) {
        FILE *fpDriver;
		strncat( driver_filename, "\\Drivers\\" FBPORTIO_NAME ".sys", MAX_PATH-1 );
        fpDriver = fopen( driver_filename, "wb" );
        if( fpDriver==NULL ) {
            ret_code = DRIVER_WRITE_FAILED;
            dwLastError = ERROR_SUCCESS;
        } else {
            if( fwrite( fbportio_driver, FBPORTIO_DRIVER_SIZE, 1, fpDriver )!=1 ) {
                ret_code = DRIVER_WRITE_FAILED;
                dwLastError = ERROR_SUCCESS;
            } else {
                service = CreateService( manager, FBPORTIO_NAME, FBPORTIO_NAME,
                                         SERVICE_ALL_ACCESS, SERVICE_KERNEL_DRIVER, SERVICE_DEMAND_START, SERVICE_ERROR_NORMAL,
                                         "System32\\Drivers\\" FBPORTIO_NAME ".sys", NULL, NULL, NULL, NULL, NULL );
                if( service==NULL ) {
                    ret_code = SERVICE_CREATE_FAILED;
                    dwLastError = GetLastError();
                }
            }
            fclose( fpDriver );
        }
    } else {
        ret_code = DRIVER_WRITE_FAILED;
        dwLastError = GetLastError();
    }

    if( ret_code==SERVICE_SUCCESS ) {
        if( pService!=NULL ) {
            *pService = service;
        } else {
            CloseServiceHandle( service );
        }
    }

    return ret_code;
}

/*:::::*/
static int start_driver( SC_HANDLE manager )
{
    int ret_code = SERVICE_SUCCESS;
	SC_HANDLE service;

    service = OpenService( manager, FBPORTIO_NAME, SERVICE_ALL_ACCESS );
    if( service ) {
        if( !StartService( service, 0, NULL ) ) {
            ret_code = SERVICE_START_FAILED;
            dwLastError = GetLastError();
        }
    } else {
        ret_code = SERVICE_OPEN_FAILED;
        dwLastError = GetLastError();
    }
    CloseServiceHandle( service );

    return ret_code;
}

static int access_driver( HANDLE hnd,
                          DWORD dwControlCode,
                          void *lpInBuffer, size_t nInBufferSize,
                          void *lpOutBuffer, size_t nOutBufferSize,
                          size_t *pBytesReturned )
{
    int ret_code = SERVICE_SUCCESS;
    DWORD dwBytesReturned = 0;
    if( !DeviceIoControl( hnd,
                          dwControlCode,
                          lpInBuffer, nInBufferSize,
                          lpOutBuffer, nOutBufferSize,
                          &dwBytesReturned,
                          NULL ) )
    {
        ret_code = DRIVER_CALL_FAILED;
        dwLastError = GetLastError();
    } else if( pBytesReturned!=NULL ) {
        *pBytesReturned = dwBytesReturned;
    }
    return ret_code;
}

/*:::::*/
static int init_driver( void )
{
    static int initialized = FALSE;
    int ret_code = SERVICE_SUCCESS;
    HANDLE driver;

    if( initialized )
        return ret_code;

    driver =
        CreateFile( "\\\\.\\" FBPORTIO_NAME,
                    GENERIC_READ | GENERIC_WRITE,
                    0,
                    NULL,
                    OPEN_EXISTING,
                    FILE_ATTRIBUTE_NORMAL,
                    NULL );

    if( driver == INVALID_HANDLE_VALUE ) {
        ret_code = SERVICE_OPEN_FAILED;
        dwLastError = GetLastError();
    } else {
        WORD DriverVersion = 0;
        ret_code = access_driver( driver,
                                  IOCTL_GET_VERSION,
                                  NULL, 0,
                                  &DriverVersion, 2,
                                  NULL );
        if( ret_code==SERVICE_SUCCESS ) {
            if( DriverVersion!=FBPORTIO_VERSION ) {
                ret_code = DRIVER_VERSION_MISMATCH;
            } else {
                /* Ok, we got our driver loaded; grant I/O ports access to our own process */
                DWORD pid = GetCurrentProcessId( );
                ret_code = access_driver( driver,
                                          IOCTL_GRANT_IOPM,
                                          &pid, 4,
                                          NULL, 0,
                                          NULL );
                if( ret_code!=SERVICE_SUCCESS )
                    ret_code = DRIVER_NO_PRIVILEGE;
            }
        }

        CloseHandle( driver );

        if( ret_code==SERVICE_SUCCESS ) {
            /* Give up our timeslice to ensure process kernel state is updated */
            Sleep(1);
            initialized = TRUE;
        }
    }

    return ret_code;
}

/*:::::*/
static int write_driver( WORD port, BYTE value )
{
    int ret_code = init_driver();
    if( ret_code==SERVICE_SUCCESS ) {
        __asm__ volatile ("outb %0, %1" : : "a" (value), "d" (port));
    }
    return ret_code;
}

/*:::::*/
static int read_driver( WORD port, BYTE *pValue )
{
    int ret_code = init_driver();
    if( ret_code==SERVICE_SUCCESS ) {
        BYTE value = 0;
        __asm__ volatile ("inb %1, %0" : "=a" (value) : "d" (port));
        if( pValue )
            *pValue = value;
    }
    return ret_code;
}

int load_driver( const char *pszAppFileName, const char *pszDriverName )
{
    const char *pszLastBS = strrchr( pszAppFileName, '\\' );
    const char *pszLastS = strrchr( pszAppFileName, '/' );

    int ret_code = SERVICE_SUCCESS;

    char *pszDriverFileName;
    size_t cchDriverPathSize;

    FILE *fpDriver;

    if( pszLastBS < pszLastS ) {
        pszLastBS = pszLastS;
    }
    if( pszLastBS==NULL ) {
        pszLastBS = pszAppFileName;
    } else {
        ++pszLastBS;
    }

    cchDriverPathSize = pszLastBS - pszAppFileName;
    pszDriverFileName = malloc( cchDriverPathSize + strlen(pszDriverName) + 1 );
    if( cchDriverPathSize!=0 )
        memcpy( pszDriverFileName, pszAppFileName, cchDriverPathSize );
    strcpy( pszDriverFileName + cchDriverPathSize,
            pszDriverName );

    fpDriver = fopen( pszDriverFileName, "rb" );
    if( fpDriver==NULL ) {
        ret_code = DRIVER_READ_FAILED;
        dwLastError = ERROR_SUCCESS;
    } else {
        fseek( fpDriver, 0, SEEK_END );
        FBPORTIO_DRIVER_SIZE = ftell( fpDriver );
        fseek( fpDriver, 0, SEEK_SET );

        fbportio_driver = malloc( FBPORTIO_DRIVER_SIZE );
        if( fread( fbportio_driver, FBPORTIO_DRIVER_SIZE, 1, fpDriver )!=1 ) {
            ret_code = DRIVER_READ_FAILED;
            dwLastError = ERROR_SUCCESS;

            free( fbportio_driver );
            fbportio_driver = NULL;
            FBPORTIO_DRIVER_SIZE = 0;
        }
        fclose( fpDriver );
    }

    free( pszDriverFileName );

    return ret_code;
}

int main(int argc, char **argv)
{
    const char *pszAppFileName = argv[0];

    int show_help = 0;
    int ret_code = SERVICE_SUCCESS;

    SC_HANDLE manager;

	manager = OpenSCManager( NULL, NULL, GENERIC_ALL );
    if( !manager ) {
        manager = OpenSCManager( NULL, NULL, GENERIC_READ );
        if( !manager ) {
            fprintf( stderr, "Failed to open service control manager\n" );
            return INIT_FAILED;
        } else {
            printf( "Warning: Service control manager opened in READ ONLY mode\n" );
        }
    }

    if( load_driver( pszAppFileName, FBPORTIO_NAME ".sys" )!=SERVICE_SUCCESS ) {
        if( load_driver( pszAppFileName, "i386\\" FBPORTIO_NAME ".sys" )!=SERVICE_SUCCESS ) {
            fprintf( stderr, "Driver %s not found\n",
                     FBPORTIO_NAME ".sys" );
            ret_code = DRIVER_READ_FAILED;
        }
    }

    show_help = argc==1;
    if( !show_help && ret_code==SERVICE_SUCCESS ) {
        int i;
        for( i=1; i!=argc; ++i ) {
            const char *arg = argv[i];
            if( strcmp( arg, "--help" )==0 || strcmp( arg, "-h" )==0 || strcmp( arg, "/?" )==0 ) {
                show_help = 1;
                break;
            } else if( strcmp( arg, "--install" )==0 || strcmp( arg, "-i" )==0 ) {
                ret_code = install_driver( manager, NULL );
            } else if( strcmp( arg, "--uninstall" )==0 || strcmp( arg, "-u" )==0 ) {
                ret_code = remove_driver( manager );
            } else if( strcmp( arg, "--start" )==0 || strcmp( arg, "-s" )==0 ) {
                ret_code = start_driver( manager );
            } else if( strcmp( arg, "--stop" )==0 || strcmp( arg, "-e" )==0 ) {
                ret_code = stop_driver( manager );
            } else if( strcmp( arg, "--write" )==0 || strcmp( arg, "-w" )==0 ) {
                const char *port, *value;
                char *endptr;
                if( ++i==argc )
                    break;
                port = argv[i];
                if( ++i==argc )
                    break;
                value = argv[i];
                ret_code = write_driver( (WORD) strtoul( port, &endptr, 0 ),
                                         (BYTE) strtoul( value, &endptr, 0 ) );
            } else if( strcmp( arg, "--read" )==0 || strcmp( arg, "-r" )==0 ) {
                const char *port;
                char *endptr;
                BYTE value = 0;
                if( ++i==argc )
                    break;
                port = argv[i];
                ret_code = read_driver( (WORD) strtoul( port, &endptr, 0 ),
                                        &value );
                if( ret_code==SERVICE_SUCCESS )
                    printf( "Value = %u\n", (unsigned) value );
            }
            if( ret_code!=SERVICE_SUCCESS )
                break;
        }
    }

    if( show_help ) {
        printf( "fbportio_install {--install|--uninstall|--start|--stop}\n" );
        ret_code = 1;
    } else if( ret_code!=0 ) {
        if( dwLastError!=ERROR_SUCCESS ) {
            fprintf( stderr, "Operation failed: %d (0x%08lx / %ld)\n", ret_code, dwLastError, dwLastError );
        } else {
            fprintf( stderr, "Operation failed: %d\n", ret_code );
        }
    }

    if( manager!=NULL )
        CloseServiceHandle( manager );
    if( fbportio_driver!=NULL )
        free( fbportio_driver );
    FBPORTIO_DRIVER_SIZE = 0;

    return ret_code;
}
