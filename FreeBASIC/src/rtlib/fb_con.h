/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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

#ifndef __FB_CON_H__
#define __FB_CON_H__

#include "fb.h"

#ifdef __cplusplus
extern "C" {
#endif

    typedef struct _fb_Rect {
        int Left, Top, Right, Bottom;
    } fb_Rect;

    typedef struct _fb_Coord {
        int X, Y;
    } fb_Coord;

    struct _fb_ConHooks;

    typedef void (*fb_fnHookConScroll)( struct _fb_ConHooks *handle, int x1, int y1, int x2, int y2, int rows );
    typedef int  (*fb_fnHookConWrite )( struct _fb_ConHooks *handle, const void *buffer, size_t length );

    typedef struct _fb_ConHooks {
        void                     *Opaque;

        fb_fnHookConScroll        Scroll;
        fb_fnHookConWrite         Write;

        fb_Rect                   Border;
        fb_Coord                  Coord;
    } fb_ConHooks;

    static __inline__
        int fb_hConCheckScroll( fb_ConHooks *handle )
    {
        fb_Rect *pBorder = &handle->Border;
        fb_Coord *pCoord = &handle->Coord;
        if( pBorder->Bottom!=-1 ) {
            if( pCoord->Y > pBorder->Bottom ) {
                int nRows = pCoord->Y - pBorder->Bottom;
                handle->Scroll( handle,
                                pBorder->Left,
                                pBorder->Top,
                                pBorder->Right,
                                pBorder->Bottom,
                                nRows );
                return TRUE;
            }
        }
        return FALSE;
    }

    void fb_ConPrintRaw				( fb_ConHooks *handle, const char *pachText,
                         			  size_t TextLength );
    void fb_ConPrintRawWstr			( fb_ConHooks *handle, const FB_WCHAR *pachText,
                         			  size_t TextLength );

    void fb_ConPrintTTY				( fb_ConHooks *handle, const char *pachText,
                         			  size_t TextLength, int is_text_mode );
    void fb_ConPrintTTYWstr			( fb_ConHooks *handle, const FB_WCHAR *pachText,
                         			  size_t TextLength, int is_text_mode );

#ifdef __cplusplus
}
#endif

#endif
