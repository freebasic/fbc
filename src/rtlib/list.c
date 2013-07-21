/* generic internal lists based on static arrays */

#include "fb.h"

/** Initializes a list.
 *
 * This list implementation is based on a static array.
 *
 * @param list      Pointer to list structure to initialize.
 * @param table     Pointer to the pool of available list elements.
 * @param elem_size Size of elements in the array.
 * @param size      Number of elements in the array.
 */
void fb_hListInit( FB_LIST *list, void *table, size_t elem_size, size_t size )
{
	size_t i;
	FB_LISTELEM *next;
    unsigned char *elem = (unsigned char *)table;

    fb_hListDynInit( list );
	
	list->fhead = (FB_LISTELEM *)elem;
	
	for( i = 0; i < size; i++ )
	{
		if( i < size-1 )
			next = (FB_LISTELEM *)(elem + elem_size);
		else
			next = NULL;
		((FB_LISTELEM *)elem)->prev = NULL;
		((FB_LISTELEM *)elem)->next = next;
		
		elem += elem_size;
	}
}

/** Allocate a new list element.
 *
 * This function gets an element from the list of free elements
 * ( struct _FB_LIST::fhead ) and adds to the tail. It also increases the
 * number of used elements ( struct _FB_LIST::cnt ).
 *
 * @param list      Pointer to the list structure.
 *
 * @return A new element.
 */
FB_LISTELEM *fb_hListAllocElem( FB_LIST *list )
{
	FB_LISTELEM *elem;

	/* take from free list */
	elem = list->fhead;
	if( elem == NULL )
		return NULL;

	list->fhead = elem->next;

    /* add to entry used list */
    fb_hListDynElemAdd( list, elem );

	return elem;
}

/** Free a list element.
 *
 * This function frees a list element by removing it from the list of
 * used elements and adding it to the list of free elements
 * ( struct _FB_LIST::fhead ). It also decreses the number of used
 * elements ( struct _FB_LIST::cnt ).
 *
 * @param list      Pointer to the list structure.
 * @param elem      List element to add to the list of free elements.
 */
void fb_hListFreeElem( FB_LIST *list, FB_LISTELEM *elem )
{
    /* remove entry from the list of used elements */
    fb_hListDynElemRemove( list, elem );

	/* add to free list */
	elem->next = list->fhead;
	list->fhead = elem;
}
