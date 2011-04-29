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

#ifndef __FB_INTERN_H__
#define __FB_INTERN_H__

/**************************************************************************************************
 * helpers
 **************************************************************************************************/

#define fb_hSign( x ) \
    ( ( (x) < 0 ) ? -1 : 1 )

/**************************************************************************************************
 * internal lists
 **************************************************************************************************/

    /** List element members.
     *
     * When you use this list implementation, you have to add a member of
     * this type to your list elements. This member must be the first(!)
     * member in your list element structure.
     */
typedef struct _FB_LISTELEM {
    struct _FB_LISTELEM    *prev;/**< Pointer to the previous member in this list */
    struct _FB_LISTELEM    *next;/**< Pointer to the next member in this list */
} FB_LISTELEM;

typedef struct _FB_LIST {
    int                cnt;      /**< Number of used elements. */
    FB_LISTELEM        *head;    /**< Pointer to the first used element. */
    FB_LISTELEM        *tail;    /**< Pointer to the last used element. */
    FB_LISTELEM        *fhead;   /**< Pointer to the first free element. */
} FB_LIST;

void                fb_hListInit            ( FB_LIST *list, void *table, int elem_size,
											  int size );
FB_LISTELEM        *fb_hListAllocElem       ( FB_LIST *list );
void                fb_hListFreeElem        ( FB_LIST *list, FB_LISTELEM *elem );

void                fb_hListDynInit         ( FB_LIST *list );
void                fb_hListDynElemAdd      ( FB_LIST *list, FB_LISTELEM *elem );
void                fb_hListDynElemRemove   ( FB_LIST *list, FB_LISTELEM *elem );

#endif /* __FB_INTERN_H__ */
