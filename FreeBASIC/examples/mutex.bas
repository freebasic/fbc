''
'' freeBASIC threaded consumer/producer example using mutexes
''

defint a-z
option explicit

const FALSE = 0
const TRUE = not FALSE

declare sub consumer ( byval param as integer )
declare sub producer ( byval param as integer )

	dim shared produced as integer, consumed as integer
	dim consumer_id as integer, producer_id as integer

	produced = mutexcreate
	consumed = mutexcreate
	
	mutexlock produced
	mutexlock consumed
	consumer_id = threadcreate(@consumer)
	producer_id = threadcreate(@producer)
	
	threadwait consumer_id
	threadwait producer_id
	
	mutexdestroy consumed
	mutexdestroy produced

'':::::
sub consumer ( byval param as integer )
	dim i as integer
	
	for i = 0 to 9
		mutexlock produced
		print ", consumer gets:", i
		mutexunlock consumed
	next i
end sub

'':::::
sub producer ( byval param as integer )
	dim i as integer
	
	for i = 0 to 9
		print "Producer puts:", i;
		mutexunlock produced
		mutexlock consumed
	next i
end sub
