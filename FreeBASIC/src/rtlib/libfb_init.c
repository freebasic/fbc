/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
 */

/*
 * init.c -- libfb initialization
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/* globals */
FB_HOOKSTB fb_hooks = { NULL };
FBSTRING fb_strNullDesc = { NULL, 0 };
FB_FILE fb_fileTB[FB_MAX_FILES];

FB_ERRORCTX fb_errctx = { 0 };
FB_INPCTX fb_inpctx = { 0 };
FB_PRINTUSGCTX fb_printusgctx = { 0 };
FB_TLSENTRY fb_dirctx = 0;

/* Dummy function to ensure that FB CTORS/DTORS get really called (on Linux)
 *
 * @lillo: any idea why this is needed?
 */
static void *dummy_ctor __attribute__ ((section (".fb_ctors"))) = NULL;
static void *dummy_dtor __attribute__ ((section (".fb_dtors"))) = NULL;

/* prototypes for the FB constructors and destructors */
typedef void (*FnCTOR)(void);
typedef void (*FnDTOR)(void);

/* variable pointing to the list of FB constructors/destructors */
extern FnCTOR __FB_CTOR_BEGIN__, __FB_CTOR_END__;
extern FnDTOR __FB_DTOR_BEGIN__, __FB_DTOR_END__;

/* execute all constructors */
void fb_CallCTORS(void)
{
    FnCTOR *pCTOR;
    for (pCTOR=&__FB_CTOR_BEGIN__; pCTOR!=&__FB_CTOR_END__; ++pCTOR) {
        if (*pCTOR)
            (*pCTOR)();
    }
}

/* execute all destructors */
void fb_CallDTORS(void)
{
    FnDTOR *pDTOR;
    for (pDTOR=&__FB_DTOR_BEGIN__; pDTOR!=&__FB_DTOR_END__; ++pDTOR) {
        if (*pDTOR)
            (*pDTOR)();
    }
}

/*:::::*/
FBCALL void fb_Init ( int argc, char **argv )
{
	/* initialize files table */
    memset( fb_fileTB, 0, sizeof( fb_fileTB ) );

	/* os-dep initialization */
    fb_hInit( argc, argv );

#if 0
    /* initialize the file handle for direct screen/keyboard access */
    fb_VfsInitScreen();
#endif

    /* call all freebasic constructor functions */
    fb_CallCTORS();

}


