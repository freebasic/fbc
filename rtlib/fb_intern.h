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
