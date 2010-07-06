''
'' simple pointer test, using nodes
''

const MAXNODES = 10
const NULL = 0

type TNODE
	id			as short
	prv			as TNODE ptr
	nxt			as TNODE ptr
end type

type TLIST
	head		as TNODE ptr
	tail		as TNODE ptr
end type

	dim list as TLIST
	dim nodeTB(0 to MAXNODES-1) as TNODE
	dim p as TNODE ptr
	
	'' init list
	list.head = @nodeTB(0)
	list.tail = @nodeTB(MAXNODES-1)
	
	p = NULL
	for i as integer = 0 to (MAXNODES-1)-1
		nodeTB(i).id  = i
		nodeTB(i).prv = p
		nodeTB(i).nxt = @nodeTB(i+1)
		p = @nodeTB(i)
	next i
	
	nodeTB(MAXNODES-1).id  = MAXNODES-1
	nodeTB(MAXNODES-1).prv = p
	nodeTB(MAXNODES-1).nxt = NULL
	
	
	'' test it
	dim res as string
	
	p = list.head
	do while( p <> NULL )
		res = res + str( p->id )
		p = p->nxt
	loop
		
	print "Result: "; res
	
	sleep
