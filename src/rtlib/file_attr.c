/* file open mode and attribs */

#include "fb.h"
#ifdef HOST_WIN32
	#include "win32/io_printer_private.h"
#endif
#include "dev_com_private.h"
#include "io_serial_private.h"

static int file_mode_map[] = { FB_FILE_ATTR_MODE_BINARY,   /* FB_FILE_MODE_BINARY = 0 */
	                           FB_FILE_ATTR_MODE_RANDOM,   /* FB_FILE_MODE_RANDOM = 1 */
    	                       FB_FILE_ATTR_MODE_INPUT,    /* FB_FILE_MODE_INPUT  = 2 */
    	                       FB_FILE_ATTR_MODE_OUTPUT,   /* FB_FILE_MODE_OUTPUT = 3 */
    	                       FB_FILE_ATTR_MODE_APPEND }; /* FB_FILE_MODE_APPEND = 4 */

FBCALL ssize_t fb_FileAttr( int handle, int returntype )
{
	ssize_t ret = 0;
	int err = 0;
	FB_FILE *file;

	file = FB_FILE_TO_HANDLE( handle );

	if( !file ) {
		ret = 0;
		err = FB_RTERROR_ILLEGALFUNCTIONCALL;
	} else {
		switch( returntype ) {
		case FB_FILE_ATTR_MODE:
			ret = file_mode_map[file->mode];
			err = FB_RTERROR_OK;
			break;

		case FB_FILE_ATTR_HANDLE:
			switch( file->type ) {
			case FB_FILE_TYPE_PRINTER:
				{
					DEV_LPT_INFO *lptinfo = file->opaque;
					if( lptinfo ) {
						#ifdef HOST_WIN32
							W32_PRINTER_INFO *printerinfo = lptinfo->driver_opaque;
							if( printerinfo ) {
								/* Win32: HANDLE */
								ret = (ssize_t)printerinfo->hPrinter;
								err = FB_RTERROR_OK;
							}
						#else
							/* Unix/DOS: CRT FILE* */
							ret = (ssize_t)lptinfo->driver_opaque;
							err = FB_RTERROR_OK;
						#endif
					}
				}
				break;

			case FB_FILE_TYPE_SERIAL:
				{
					DEV_COM_INFO *cominfo = file->opaque;
					if( cominfo ) {
						#ifdef HOST_WIN32
							W32_SERIAL_INFO *serialinfo = cominfo->hSerial;
							if( serialinfo ) {
								ret = (ssize_t)serialinfo->hDevice;
								err = FB_RTERROR_OK;
							}
						#elif defined HOST_LINUX
							LINUX_SERIAL_INFO *serialinfo = cominfo->hSerial;
							if( serialinfo ) {
								ret = serialinfo->sfd;
								err = FB_RTERROR_OK;
							}
						#elif defined HOST_DOS
							DOS_SERIAL_INFO *serialinfo = cominfo->hSerial;
							if( serialinfo ) {
								ret = serialinfo->com_num;
								err = FB_RTERROR_OK;
							}
						#endif
					}
				}
				break;

			default:
				ret = (ssize_t)file->opaque; /* CRT FILE* */
				err = FB_RTERROR_OK;
				break;
			}
			break;

		case FB_FILE_ATTR_ENCODING:
			ret = file->encod;
			err = FB_RTERROR_OK;
			break;

		default:
			ret = 0;
			err = FB_RTERROR_ILLEGALFUNCTIONCALL; 
			break;
		}
	}

	fb_ErrorSetNum( err );
	return ret;
}
