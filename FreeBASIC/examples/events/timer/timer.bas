''
'' simple timer library using threads
'' (note: to use this library *always* compile the client using the -mt option for threading safety)
''
'' to compile: fbc timer.bas -lib
''



#include once "timer.bi"

enum TIMER_STATES
	TIMER_STATE_KILLED
	TIMER_STATE_RUNNING
	TIMER_STATE_STOPPED
	TIMER_STATE_EXITING
end enum

type TIMER_CTX
	state		as TIMER_STATES
	interval	as integer
	callback	as TIMER_CALLBACK
	userdata	as integer
	cond		as any ptr
	thread		as any ptr
end type

'':::::
private sub timer_thread( byval ctx as TIMER_CTX ptr )
        
	do
		select case ctx->state
		case TIMER_STATE_EXITING
			exit do
		
		case TIMER_STATE_STOPPED
			condwait( ctx->cond )
		
		case TIMER_STATE_RUNNING
			dim interval as integer
			
			interval = ctx->interval
			do 
				sleep iif( interval <= 100, interval, 100 ), 1
				
				if( ctx->state <> TIMER_STATE_RUNNING ) then
					exit do
				end if
				
				interval -= 100
			loop while( interval > 0 )
			
			if( interval <= 0 ) then
				ctx->callback( ctx->userdata )
			end if
		end select
	loop
        
end sub

'':::::
function timercreate( _
				      byval interval as integer, _
					  byval callback as TIMER_CALLBACK, _
					  byval userdata as integer = 0 _
					) as integer
	
	dim as TIMER_CTX ptr ctx
	
	ctx = allocate( len( TIMER_CTX ) )
	
	ctx->state	  = TIMER_STATE_STOPPED
	ctx->interval = interval
	ctx->callback = callback
	ctx->userdata = userdata
	ctx->cond	  = condcreate( )
	ctx->thread   = threadcreate( @timer_thread, cint( ctx ) )
	
	function = cint( ctx )

end function

'':::::
sub timeron( _
		     byval id as integer _
		   )
	
	dim ctx as TIMER_CTX ptr = cast( TIMER_CTX ptr, id )
	
	if( ctx = 0 ) then
		exit sub
	end if
	
	if( ctx->state = TIMER_STATE_KILLED ) then
		exit sub
	end if
		
	ctx->state = TIMER_STATE_RUNNING
	condsignal( ctx->cond )

end sub

'':::::
sub timeroff( _
			  byval id as integer _
			)
	
	dim ctx as TIMER_CTX ptr = cast( TIMER_CTX ptr, id )
	
	if( ctx = 0 ) then
		exit sub
	end if

	if( ctx->state = TIMER_STATE_KILLED ) then
		exit sub
	end if

	ctx->state = TIMER_STATE_STOPPED

end sub

'':::::
sub timerdestroy( _
			      byval id as integer _
			    )
	
	dim ctx as TIMER_CTX ptr = cast( TIMER_CTX ptr, id )
	
	if( ctx = 0 ) then
		exit sub
	end if

	if( ctx->state = TIMER_STATE_KILLED ) then
		exit sub
	end if

	ctx->state = TIMER_STATE_EXITING
	
	condsignal( ctx->cond )
	threadwait( ctx->thread )			
	conddestroy( ctx->cond )
	
	ctx->state = TIMER_STATE_KILLED
	
	deallocate( ctx )
	
end sub
	
