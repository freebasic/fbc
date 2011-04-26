/*
 * file_copy.c -- file copy
 *
 * chng: dec/2005 written [DrV]
 *
 */

#include "fb.h"

FBCALL int fb_FileCopy 
	( 
		const char *source, 
		const char *destination 
	)
{
	return fb_DrvFileCopy( source, destination );
}
