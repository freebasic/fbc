/* dir() */

#include "../fb.h"
#include <dir.h>

#define FB_ATTRIB_MASK ~0xFFFFFF00

typedef struct {
	int in_use;
	int attrib;
	struct ffblk f;
} FB_DIRCTX;

#define fb_DIRCTX_Destructor NULL

static char *find_next ( int *out_attrib )
{
	FB_DIRCTX *ctx = FB_TLSGETCTX( DIR );
	char *name = NULL;

	do {
		if( findnext( &ctx->f ) == 0 ) {
			name = ctx->f.ff_name;
		} else {
			name = NULL;
			break;
		}
	} while( ctx->f.ff_attrib & ~ctx->attrib );

	*out_attrib = ctx->f.ff_attrib & FB_ATTRIB_MASK;
	return name;
}

FBCALL FBSTRING *fb_Dir( FBSTRING *filespec, int attrib, int *out_attrib )
{
	FBSTRING  *res;
	int        out_attrib_fake;
	char      *name = NULL;
	FB_DIRCTX *ctx = FB_TLSGETCTX( DIR );
	ssize_t    len;

	if( !out_attrib )
		out_attrib = &out_attrib_fake;

	len = FB_STRSIZE( filespec );

	if( len > 0 ) {
		/* filespec specified (return first result) */
		ctx->attrib = attrib | 0xFFFFFF00;

		/* archive bit not set? set the dir bit at least.. */
		if( (attrib & 0x10) == 0 )
			ctx->attrib |= 0x20;

		if( findfirst( filespec->data, &ctx->f, ctx->attrib ) == 0 ) {
			if( ctx->f.ff_attrib & ~ctx->attrib ) {
				name = find_next( out_attrib );
			} else {
				*out_attrib = ctx->f.ff_attrib & FB_ATTRIB_MASK;
				name = ctx->f.ff_name;
			}
		}

		if( name ) {
			ctx->in_use = TRUE;
			ctx->attrib = attrib;
		}
	} else {
		/* filespec not specified (return next result) */
		if( ctx->in_use ) {
			name = find_next( out_attrib );
		}
	}

	/* store filename if found */
	if( name ) {
		ctx->in_use = TRUE;
		len = strlen( name );
		res = fb_hStrAllocTemp( NULL, len );
		if( res ) {
			fb_hStrCopy( res->data, name, len );
		} else {
			res = &__fb_ctx.null_desc;
		}
	} else {
		ctx->in_use = FALSE;
		res = &__fb_ctx.null_desc;
		*out_attrib = 0;
	}

	fb_hStrDelTemp( filespec );
	return res;
}
