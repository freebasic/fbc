/* set the with for devices */

#include "fb.h"
#include <ctype.h>

typedef struct _DEV_INFO_WIDTH {
    FB_LISTELEM     elem;
    char           *device;
    int             width;
} DEV_INFO_WIDTH;

/** Initialize the list of device info nodes.
 */
static void            fb_hListDevInit      ( FB_LIST *list )
{
    fb_hListDynInit( list );
}

/** Allocate a new device info node.
 *
 * @return pointer to the new node
 */
static DEV_INFO_WIDTH *fb_hListDevElemAlloc ( FB_LIST *list, const char *device, int width )
{
    DEV_INFO_WIDTH *node = (DEV_INFO_WIDTH*) calloc( 1, sizeof(DEV_INFO_WIDTH) );
    node->device = strdup(device);
    node->width = width;
    fb_hListDynElemAdd( list, &node->elem );
    return node;
}

#if 0
/** Remove the device info node and release its memory.
 */
static void            fb_hListDevElemFree  ( FB_LIST *list, DEV_INFO_WIDTH *node )
{
    fb_hListDynElemRemove( list, &node->elem );
    free(node->device);
    free(node);
}
#endif

/** Pointer to the device info list.
 */
static FB_LIST *dev_info_widths = NULL;

/*:::::*/
FBCALL int fb_WidthDev( FBSTRING *dev, int width )
{
    int cur = width;
    DEV_INFO_WIDTH *node;
    size_t i, size;
    char *device;

    FB_LOCK();

    /* create list of device info nodes (if not created yet) */
    if( dev_info_widths==NULL ) {
        dev_info_widths = malloc( sizeof(FB_LIST) );
        fb_hListDevInit( dev_info_widths );
    }

    FB_UNLOCK();

    /* */
    size = FB_STRSIZE(dev);
    device = alloca(size + 1);
    memcpy( device, dev->data, size );
    device[size] = 0;

    /* make the name uppercase */
    for( i=0; i!=size; ++i ) {
        unsigned ch = (unsigned) device[i];
        if( islower(ch) )
            device[i] = (char) toupper(ch);
    }

    FB_LOCK();

    /* Search list of devices for the requested device name */
    for (node = (DEV_INFO_WIDTH*) dev_info_widths->head;
         node != (DEV_INFO_WIDTH*) NULL;
         node = (DEV_INFO_WIDTH*) node->elem.next)
    {
        if( strcmp( device, node->device ) == 0 ) {
            break;
        }
    }

    if( width != -1 ) {
        if( node == NULL ) {
            /* Allocate a new list node if device name not found */
            node = fb_hListDevElemAlloc ( dev_info_widths, device, width );
        } else {
            /* Set device width */
            node->width = width;
        }
    } else if( node != NULL ) {
        cur = node->width;
    }

    /* search the width for all open (and known) devices */
    if( strcmp( device, "SCRN:" )==0 ) {
        /* SCREEN device */
        if( width!=-1 ) {
            fb_Width( width, -1 );
        }
        cur = FB_HANDLE_SCREEN->width;

    } else if ( fb_DevLptTestProtocol( NULL, device, size ) ) {
        /* PRINTER device */
        cur = fb_DevPrinterSetWidth( device, width, cur );

    } else if ( fb_DevComTestProtocol( NULL, device, size ) ) {
        /* SERIAL device */
        cur = fb_DevSerialSetWidth( device, width, cur );

    } else {
        /* unknown device */
    }

	FB_UNLOCK();

    if( width==-1 ) {
        return cur;
    }

    return fb_ErrorSetNum( FB_RTERROR_OK );
}
