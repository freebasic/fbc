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

/*
 * listdyn.c -- generic internal dynamic lists
 *
 * chng: jul/2005 written [mjs], some lines copied from libfb_list.c
 *
 */

#include <stdlib.h>
#include "fb.h"

/** Initializes a list.
 *
 * This list implementation doesn't care where the data will be stored to.
 * It's up to the caller to do all memory operations.
 *
 * @param list      Pointer to list structure to initialize.
 */
void fb_hListDynInit( FB_LIST *list )
{
    memset(list, 0, sizeof(FB_LIST));
}

/** Adds an element to the list.
 *
 * This function adds a list element to the list. It's up to the
 * caller to allocate the memory required by this element.
 *
 * @param list      Pointer to the list structure.
 * @param elem      Pointer to the element to add to the list.
 */
void fb_hListDynElemAdd( FB_LIST *list, FB_LISTELEM *elem )
{
	if( list->tail != NULL )
		list->tail->next = elem;
	else
		list->head = elem;

	elem->prev = list->tail;
	elem->next = NULL;

	list->tail = elem;

    ++list->cnt;
}

/** Remove an element from the list.
 *
 * This function removes a list element from the list. It's up to the
 * caller to free the memory allocated by this element.
 *
 * @param list      Pointer to the list structure.
 * @param elem      Pointer to the element to remove from the list.
 */
void fb_hListDynElemRemove( FB_LIST *list, FB_LISTELEM *elem )
{
	/* del from used list */
	if( elem->prev != NULL )
		elem->prev->next = elem->next;
	else
		list->head = elem->next;

	if( elem->next != NULL )
		elem->next->prev = elem->prev;
	else
		list->tail = elem->prev;

	/* reset element pointers */
    elem->prev = elem->next = NULL;

    /* don't forget to change the number of elements in the list */
	--list->cnt;
}
