/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2007 The FreeBASIC development team.
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
 *	file_field - field # functions
 *
 * chng: jan/2007 written [jeffmarshall]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"

FBCALL void fb_FileFieldStrDelete ( FBSTRING *str );

extern FBCALL void (*__FileFieldStrDeleteHook)( FBSTRING *str );

typedef struct ffp_t
{
	int fnum;                       /* file number associated with the desc */
	FBSTRING *desc;                 /* pointer to the var-len descriptor */
	char * org_data;                /* original data location */
	int offset;                     /* offset into the file buffer */
	int size;                       /* size of the field */
	struct ffp_t *next;             /* next field in the list */
} FB_FILEFIELDPARAM_CTX;

typedef struct ffi_t
{
	size_t reclen;					/* size of file buffer */
	char *buffer;                   /* file buffer */
	FB_FILE_HOOKS *prev_hooks;      /* pointer to previous hook data */
	FB_FILE_HOOKS hooks_clone;		/* our own copy of the file hooks */
	FB_FILE *handle;                /* copy of the file handle - how else
	                                      can we get the file num? */
} FB_FILEFIELDINFO_CTX;

/* field information for each file number */
static FB_FILEFIELDINFO_CTX* ffi_ctx[FB_MAX_FILES];

/* all fields in effect are stored in this list */
static FB_FILEFIELDPARAM_CTX* ffp_ctx;

/*:::::*/
static int get_file_num( struct _FB_FILE *handle )
{
	/* is there a better way to do this? */
	int i;
	for( i = 0; i <FB_MAX_FILES; i++ )
		if( ffi_ctx[i] )
			if( ffi_ctx[i]->handle == handle )
				return( i );

	return(-1);
}

/*:::::*/
static int init_FileFieldInfoCtx()
{
	static started = 0;
	if( !started )
	{
		FB_LOCK();

		memset(ffi_ctx, 0, sizeof(FB_FILEFIELDINFO_CTX*) * FB_MAX_FILES);
		
		ffp_ctx = NULL;

		started = 1;

		FB_UNLOCK();
	}
	return( started );
}

/*:::::*/
static FB_FILEFIELDPARAM_CTX *addDesc
	( 
		int fnum,
		FBSTRING *desc, 
		int offset, 
		int size,
		char *buffer
	)
{
	FB_FILEFIELDPARAM_CTX *ffp = ffp_ctx;

	if( desc == NULL || offset < 0 || size <= 0 || buffer == NULL )
		return( NULL );

	/* if the descriptor is already in the list, update it */
	while( ffp && (ffp->desc != desc) )
		ffp = ffp->next;

	/* or create a new one if needed */
	if( !ffp )
	{
		ffp = malloc( sizeof( FB_FILEFIELDPARAM_CTX ));
		if( !ffp )
			return( NULL );

		ffp->next = ffp_ctx;
		ffp_ctx = ffp;
	} 

	ffp->fnum = fnum;
	ffp->desc = desc;
	ffp->offset = offset;
	ffp->size = size;

	if( desc->data && (FB_STRSIZE(desc) != 0) )
		free( desc->data );

	desc->data = buffer + offset;
	desc->len = size;
	desc->size = -1;

	/* Save a copy so we can know later if the data has been realloc'd */
	ffp->org_data = desc->data;

	/* be sure to hook in our dtor handler */
	__FileFieldStrDeleteHook = fb_FileFieldStrDelete;

	return( ffp );

}


/*:::::*/
static void removeDesc
	(
		int fnum,
		FBSTRING *desc
	)
{
	/* 
	   garbage collection:
	   - remove a descriptor matching desc
	   - or any desc assoc. with fnum
	 */

	FB_FILEFIELDPARAM_CTX *ffp = ffp_ctx, *prv = NULL, *nxt;

	while( ffp )
	{
		nxt = ffp->next;

		if( (ffp->fnum == fnum )
		    || ( ffp->desc == desc ) )
		{
			/* 
			   check that the descriptor points to the same place as it did before
			 */

			if( ffp->desc->data == ffp->org_data )
			{
				ffp->desc->data = NULL;
				ffp->desc->len = 0;
				ffp->desc->size = 0;
			}

			if( prv )
				prv->next = ffp->next;
			else
				ffp_ctx = ffp->next;

			free( ffp );
		}
		else
		{
			prv = ffp;
		}

		ffp = nxt;

	}

	/* no descriptors? - then unhook the field dtor handler */
    if( ffp_ctx == NULL )
		__FileFieldStrDeleteHook = NULL;
    	

}

/*:::::*/
static void free_FieldInfo( int fnum, FB_FILE *handle )
{
	FB_FILEFIELDINFO_CTX *ffi = ffi_ctx[fnum];

	removeDesc( fnum, NULL );

	if( ffi == NULL )
		return;

	handle->hooks = ffi->prev_hooks;

	if( ffi->buffer )
		free( ffi->buffer );

	free( ffi );

	ffi_ctx[fnum] = NULL;
}

/*:::::*/
int fb_DevFileFieldClose( struct _FB_FILE *handle )
{
	int fnum = get_file_num(handle);

	if( fnum >= 0 )
	{
		FB_LOCK();
		
		free_FieldInfo( fnum, handle );
		
		FB_UNLOCK();

		return( handle->hooks->pfnClose( handle ) );
	}

	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

/*:::::*/
static FB_FILEFIELDINFO_CTX *alloc_FieldInfo( int fnum, int reclen )
{
	FB_FILEFIELDINFO_CTX *ffi = ffi_ctx[fnum];
	FB_FILE *handle = FB_FILE_TO_HANDLE(fnum);

	/* This only needs to be done once per file */
	if( ffi )
		return( ffi );

	ffi = malloc( sizeof( FB_FILEFIELDINFO_CTX ) );

	if( ffi == NULL )
		return( NULL );

	ffi->reclen = reclen;
	ffi->buffer = malloc( reclen + 1 );

	/* bail if we have no place to load data */
	if( ffi->buffer == NULL )
	{
		free( ffi );
		return( NULL );
	}

	
	/* fill with spaces and put a null-term on the end just in case */
	memset( ffi->buffer, 32, reclen );
	ffi->buffer[reclen] = 0;

	/* 
	   We need to do clean-up when the device is closed, so insert
	   our own close handler here, plus remember the previous hooks
	   so they can be restored later and the real close handler called.
	 */

	ffi->prev_hooks = handle->hooks;
	ffi->hooks_clone = *ffi->prev_hooks;
	ffi->hooks_clone.pfnClose = fb_DevFileFieldClose;

	handle->hooks = &ffi->hooks_clone;

	/* save a copy of the handle so we can know the file number later */
	ffi->handle = handle;

	ffi_ctx[fnum] = ffi;

	return ffi;
}

/*:::::*/
static FB_FILEFIELDINFO_CTX *hCheckFileState( int fnum )
{
	FB_FILE *handle = FB_FILE_TO_HANDLE(fnum);

	init_FileFieldInfoCtx();

	/* 
	   Check for:
	   - file handle in use 
	   - random file mode
	   - fields in effect
	 */

	if( FB_HANDLE_USED(handle) )
		if( handle->mode == FB_FILE_MODE_RANDOM )
			if( ffi_ctx[fnum] != NULL )
				return( ffi_ctx[fnum] );

	return( NULL );

}

/*:::::*/
FBCALL int fb_FileFieldPut( int fnum, long pos )
{
	FB_FILEFIELDINFO_CTX *ffi = hCheckFileState( fnum );
	if( ffi )
		return( fb_FilePutDataEx(FB_FILE_TO_HANDLE(fnum), pos, ffi->buffer, ffi->reclen, TRUE, FALSE, FALSE ) );
	return( fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL ) );
}

/*:::::*/
FBCALL int fb_FileFieldPutLarge( int fnum, long long pos )
{
	FB_FILEFIELDINFO_CTX *ffi = hCheckFileState( fnum );
	if( ffi )
		return( fb_FilePutDataEx(FB_FILE_TO_HANDLE(fnum), pos, ffi->buffer, ffi->reclen, TRUE, FALSE, FALSE ) );
	return( fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL ) );
}

/*:::::*/
FBCALL int fb_FileFieldGet( int fnum, long pos )
{
	FB_FILEFIELDINFO_CTX *ffi = hCheckFileState( fnum );
	if( ffi )
		return( fb_FileGetData((fnum), pos, ffi->buffer, ffi->reclen, TRUE ) );
	return( fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL ) );
}

/*:::::*/
FBCALL int fb_FileFieldGetLarge( int fnum, long long pos )
{
	FB_FILEFIELDINFO_CTX *ffi = hCheckFileState( fnum );
	if( ffi )
		return( fb_FileGetData((fnum), pos, ffi->buffer, ffi->reclen, TRUE ) );
	return( fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL ) );
}

/*:::::*/
int fb_FileField( int fnum, int args, ... )
{
	FBSTRING *fld;
	va_list ap;
	int i, offset, size;
	FB_FILEFIELDINFO_CTX *ffi;
	FB_FILE *handle;
	FB_FILEFIELDPARAM_CTX * ffp;

	init_FileFieldInfoCtx();

	/* don't allow if no args are passed */
	if( args <= 0 )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	handle = FB_FILE_TO_HANDLE(fnum);

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	if( handle->mode != FB_FILE_MODE_RANDOM )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	if( handle->len <= 0 )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	/* first pass - get the total size of the fields */
	va_start( ap, args );
	offset = 0;
	for( i = 0; i < args; i++ )
	{
		size = va_arg( ap, int );
		fld = va_arg( ap, FBSTRING* );
		offset += size;
	}
	va_end( ap );

	/* total field size cannot exceed the file's record length */
	if( size > handle->len )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	/* 
	   initialize the buffer (if it has not been already 
	   will only fail if out of memory
	 */

	FB_LOCK();

	ffi = alloc_FieldInfo( fnum, handle->len );
	if( ffi == NULL )
	{
		FB_UNLOCK();
		return( fb_ErrorSetNum( FB_RTERROR_OUTOFMEM ) );
	}

	/* second pass - add the field parameters */
	va_start( ap, args );
	offset = 0;
	for( i = 0; i < args; i++ )
	{
		size = va_arg( ap, int );
		fld = va_arg( ap, FBSTRING* );
		ffp = addDesc( fnum, fld, offset, size, ffi->buffer );
		if( ffp == NULL )
			break;
		offset += size;
	}
	va_end( ap );

	FB_UNLOCK();

	if( ffp = NULL )
		return( fb_ErrorSetNum( FB_RTERROR_OUTOFMEM ) );

	return( fb_ErrorSetNum( FB_RTERROR_OK ) );
}


/*:::::*/
FBCALL void fb_FileFieldStrDelete ( FBSTRING *str )
{
    if( (str == NULL) || (str->data == NULL) )
    	return;

	FB_LOCK();
	removeDesc( -1, str );
	FB_UNLOCK();
}
