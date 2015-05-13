''
'' Threaded consumer/producer example using mutexes
''

declare sub consumer( byval param as any ptr )
declare sub producer( byval param as any ptr )

	dim shared as any ptr produced, consumed 
	dim as any ptr consumer_id, producer_id

	produced = mutexcreate( )
	consumed = mutexcreate( )
	if( (produced = 0) or (consumed = 0) ) then
		print "Error creating mutexes! Exiting..."
		end 1
	end if

	mutexlock produced
	mutexlock consumed
	consumer_id = threadcreate( @consumer )
	producer_id = threadcreate( @producer )
	if( (producer_id = 0) or (consumer_id = 0) ) then
		print "Error creating threads! Exiting..."
		end 1
	end if

	threadwait( consumer_id )
	threadwait( producer_id )

	mutexdestroy( consumed )
	mutexdestroy( produced )

	sleep

sub consumer( byval param as any ptr )
	for i as integer = 0 to 9
		mutexlock produced
		print ", consumer gets: "; i
		mutexunlock consumed
	next
end sub

sub producer( byval param as any ptr )
	for i as integer = 0 to 9
		print "Producer puts: "; i;
		mutexunlock produced
		mutexlock consumed
	next
end sub
