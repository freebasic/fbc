/* low-level lock and unlock functions */

#include "fb.h"

#if defined( HOST_UNIX )
static int do_lock(FILE *f, int lock, fb_off_t inipos, fb_off_t size)
{
	struct flock lck;
	int fd;

	fd = fileno( f );

	if( lock ) {
		if( fcntl( fd, F_GETFL ) & O_RDONLY )
			lck.l_type = F_RDLCK;
		else
			lck.l_type = F_WRLCK;
	} else {
		lck.l_type = F_UNLCK;
	}

	lck.l_whence = SEEK_SET;
	lck.l_start = inipos;
	lck.l_len = size;

	return fb_ErrorSetNum( fcntl( fd, F_SETLKW, &lck ) ? FB_RTERROR_FILEIO : FB_RTERROR_OK );
}
#endif

int fb_hFileLock( FILE *f, fb_off_t inipos, fb_off_t size )
{
#if defined( HOST_DOS )
	return fb_ErrorSetNum( _dos_lock( fileno(f), inipos, size ) == 0 ?
	                       FB_RTERROR_OK : FB_RTERROR_FILEIO );
#elif defined( HOST_UNIX )
	return do_lock(f, TRUE, inipos, size);
#elif defined( HOST_WIN32 )
	return fb_ErrorSetNum( LockFile( (HANDLE)get_osfhandle( fileno( f ) ), inipos, 0, size, 0 ) == TRUE ?
	                       FB_RTERROR_OK : FB_RTERROR_FILEIO );
#else
	return fb_ErrorSetNum( FB_RTERROR_FILEIO );
#endif
}

int fb_hFileUnlock( FILE *f, fb_off_t inipos, fb_off_t size )
{
#if defined( HOST_DOS )
	return fb_ErrorSetNum( _dos_unlock( fileno(f), inipos, size) == 0 ?
	                       FB_RTERROR_OK : FB_RTERROR_FILEIO );
#elif defined( HOST_UNIX )
	return do_lock(f, FALSE, inipos, size);
#elif defined( HOST_WIN32 )
	return fb_ErrorSetNum( UnlockFile( (HANDLE)get_osfhandle( fileno( f ) ), inipos, 0, size, 0 ) == TRUE ?
	                       FB_RTERROR_OK : FB_RTERROR_FILEIO );
#else
	return fb_ErrorSetNum( FB_RTERROR_FILEIO );
#endif
}
