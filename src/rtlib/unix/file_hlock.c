/* low-level lock and unlock functions */

#include "../fb.h"
#include <fcntl.h>

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

int fb_hFileLock( FILE *f, fb_off_t inipos, fb_off_t size )
{
	return do_lock(f, TRUE, inipos, size);
}

int fb_hFileUnlock( FILE *f, fb_off_t inipos, fb_off_t size )
{
	return do_lock(f, FALSE, inipos, size);
}
