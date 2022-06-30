'' TEST_MODE: COMPILE_ONLY_OK
''
'' Include every container header and define every container multiple times
'' to ensure none of it conflicts with each other

#include "../../inc/containers/linkedlist.bi"
#include "../../inc/containers/linkedlist.bi"
#include "../../inc/containers/list.bi"
#include "../../inc/containers/list.bi"
#include "../../inc/containers/queue.bi"
#include "../../inc/containers/queue.bi"
#include "../../inc/containers/stack.bi"
#include "../../inc/containers/stack.bi"
#include "../../inc/containers/listiterator.bi"
#include "../../inc/containers/listiterator.bi"
#include "../../inc/containers/reverselistiterator.bi"
#include "../../inc/containers/reverselistiterator.bi"
#include "../../inc/containers/linkedlistiterator.bi"
#include "../../inc/containers/linkedlistiterator.bi"
#include "../../inc/containers/bitcontainer.bi"
#include "../../inc/containers/bitcontainer.bi"

FBCont_DefineIIteratorOf(Long)
FBCont_DefineIIteratorOf(Long)
FBCont_DefineIIteratorOf(Integer)
FBCont_DefineIIteratorOf(Integer)
FBCont_DefineIContainerOf(Long)
FBCont_DefineIContainerOf(Long)
FBCont_DefineIContainerOf(Integer)
FBCont_DefineIContainerOf(Integer)
FBCont_DefineIListOf(Long)
FBCont_DefineIListOf(Long)
FBCont_DefineIListOf(Integer)
FBCont_DefineIListOf(Integer)
FBCont_DefineLinkedListOf(Long)
FBCont_DefineLinkedListOf(Long)
FBCont_DefineLinkedListOf(Integer)
FBCont_DefineLinkedListOf(Integer)
FBCont_DefineLinkedListNodeOf(Long)
FBCont_DefineLinkedListNodeOf(Long)
FBCont_DefineLinkedListNodeOf(Integer)
FBCont_DefineLinkedListNodeOf(Integer)
FBCont_DefineListOf(Long)
FBCont_DefineListOf(Long)
FBCont_DefineListOf(Integer)
FBCont_DefineListOf(Integer)
FBCont_DefineStackOf(Long)
FBCont_DefineStackOf(Long)
FBCont_DefineStackOf(Integer)
FBCont_DefineStackOf(Integer)
FBCont_DefineQueueOf(Long)
FBCont_DefineQueueOf(Long)
FBCont_DefineQueueOf(Integer)
FBCont_DefineQueueOf(Integer)
FBCont_DefineLinkedListIteratorOf(Long)
FBCont_DefineLinkedListIteratorOf(Long)
FBCont_DefineLinkedListIteratorOf(Integer)
FBCont_DefineLinkedListIteratorOf(Integer)
FBCont_DefineListIteratorOf(Long)
FBCont_DefineListIteratorOf(Long)
FBCont_DefineListIteratorOf(Integer)
FBCont_DefineListIteratorOf(Integer)
FBCont_DefineStackIteratorOf(Long)
FBCont_DefineStackIteratorOf(Long)
FBCont_DefineStackIteratorOf(Integer)
FBCont_DefineStackIteratorOf(Integer)
FBCont_DefineQueueIteratorOf(Long)
FBCont_DefineQueueIteratorOf(Long)
FBCont_DefineQueueIteratorOf(Integer)
FBCont_DefineQueueIteratorOf(Integer)
