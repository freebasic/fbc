/* dir() */

#include "../fb.h"
#ifndef HOST_CYGWIN
	#include <direct.h>
#endif
#include <windows.h>

typedef struct {
	int in_use;
	int attrib;
#ifdef HOST_CYGWIN
	WIN32_FIND_DATA data;
	HANDLE handle;
#else
	struct _finddata_t data;
	intptr_t handle;
#endif
} FB_DIRCTX;

static void close_dir_internal ( FB_DIRCTX *ctx )
{
#ifdef HOST_MINGW
	_findclose( ctx->handle );
#else
	FindClose( ctx->handle );
#endif
	ctx->in_use = FALSE;
}

void fb_DIRCTX_Destructor ( void* data )
{
	FB_DIRCTX *ctx = ( FB_DIRCTX *)data;
	if( ctx->in_use )
		close_dir_internal( ctx );
}

static void close_dir ( void )
{
	FB_DIRCTX *ctx = FB_TLSGETCTX( DIR );
	close_dir_internal( ctx );
}

static char *find_next ( int *attrib )
{
	char *name = NULL;
	FB_DIRCTX *ctx = FB_TLSGETCTX( DIR );

#ifdef HOST_MINGW
	do
	{
		if( _findnext( ctx->handle, &ctx->data ) )
		{
			close_dir( );
			name = NULL;
			break;
		}
        name = ctx->data.name;
	}
	while( ctx->data.attrib & ~ctx->attrib );

	*attrib = ctx->data.attrib & ~0xFFFFFF00;

#else
    do {
        if( !FindNextFile( ctx->handle, &ctx->data ) ) {
            close_dir();
            name = NULL;
            break;
        }
        name = ctx->data.cFileName;
    } while( ctx->data.dwFileAttributes & ~ctx->attrib );

    *attrib = ctx->data.dwFileAttributes & ~0xFFFFFF00;
#endif

	return name;
}

FBCALL FBSTRING *fb_Dir( FBSTRING *filespec, int attrib, int *out_attrib )
{
	FB_DIRCTX *ctx;
	FBSTRING *res;
	ssize_t len;
	int tmp_attrib;
    char *name;
    int handle_ok;

	if( out_attrib == NULL )
		out_attrib = &tmp_attrib;

	len = FB_STRSIZE( filespec );
	name = NULL;

	ctx = FB_TLSGETCTX( DIR );

	if( len > 0 )
	{
		/* findfirst */
		if( ctx->in_use )
			close_dir( );

#ifdef HOST_MINGW
        ctx->handle = _findfirst( filespec->data, &ctx->data );
        handle_ok = ctx->handle != -1;
#else
        ctx->handle = FindFirstFile( filespec->data, &ctx->data );
        handle_ok = ctx->handle != INVALID_HANDLE_VALUE;
#endif
		if( handle_ok )
		{
			/* Handle any other possible bits different Windows versions could return */
			ctx->attrib = attrib | 0xFFFFFF00;

			/* archive bit not set? set the dir bit at least.. */
			if( (attrib & 0x10) == 0 )
				ctx->attrib |= 0x20;

#ifdef HOST_MINGW
			if( ctx->data.attrib & ~ctx->attrib )
				name = find_next( out_attrib );
			else
			{
                name = ctx->data.name;
				*out_attrib = ctx->data.attrib & ~0xFFFFFF00;
            }
#else
			if( ctx->data.dwFileAttributes & ~ctx->attrib )
				name = find_next( out_attrib );
			else
			{
                name = ctx->data.cFileName;
                *out_attrib = ctx->data.dwFileAttributes & ~0xFFFFFF00;
            }
#endif
			if( name )
				ctx->in_use = TRUE;
		}
	} else {
		/* findnext */
		if( ctx->in_use )
			name = find_next( out_attrib );
	}

	FB_STRLOCK();

	/* store filename if found */
	if( name ) {
		len = strlen( name );
		res = fb_hStrAllocTemp_NoLock( NULL, len );
		if( res )
			fb_hStrCopy( res->data, name, len );
		else
			res = &__fb_ctx.null_desc;
	} else {
		res = &__fb_ctx.null_desc;
		*out_attrib = 0;
	}

	fb_hStrDelTemp_NoLock( filespec );

	FB_STRUNLOCK();

	return res;
}
