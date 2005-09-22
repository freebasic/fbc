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
    typedef void (*fb_fnHookConLocate)( struct _fb_ConHooks *handle );
    typedef int  (*fb_fnHookConWrite )( struct _fb_ConHooks *handle, const void *buffer, size_t length, size_t *written );

    typedef struct _fb_ConHooks {
        void                     *Opaque;

        fb_fnHookConScroll        Scroll;
        fb_fnHookConLocate        Locate;
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
                pCoord->Y = pBorder->Bottom;
                return TRUE;
            }
        }
        return FALSE;
    }

    void fb_ConPrintRaw( fb_ConHooks *handle,
                         const char *pachText,
                         size_t TextLength );

    void fb_ConPrintTTY( fb_ConHooks *handle,
                         const char *pachText,
                         size_t TextLength,
                         int is_text_mode );

#ifdef __cplusplus
}
#endif

#endif
