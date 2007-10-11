''
'' simple timer library using threads
'' (note: to use this library *always* compile the client using the -mt option for threading safety)
''
'' to compile: fbc timer.bas -lib
''



#include once "timer.bi"

'':::::
sub CTimer.threadcb( byval ctx as CTimer ptr )
        
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
constructor CTimer _
	( byval interval as integer, _
	  byval callback as TIMER_CALLBACK, _
	  byval userdata as integer = 0 _
	)
	
	this.state	  = TIMER_STATE_STOPPED
	this.interval = interval
	this.callback = callback
	this.userdata = userdata
	this.cond	  = condcreate( )
	this.thread   = threadcreate( @threadcb, cast( any ptr, @this ) )
	
end constructor

'':::::
sub CTimer.on _
	( _
	)
	
	if( this.state = TIMER_STATE_KILLED ) then
		exit sub
	end if
		
	this.state = TIMER_STATE_RUNNING
	condsignal( this.cond )

end sub

'':::::
sub CTimer.off _
	( _
	)
	
	if( this.state = TIMER_STATE_KILLED ) then
		exit sub
	end if

	this.state = TIMER_STATE_STOPPED

end sub

'':::::
destructor CTimer _
	( _
		_
	)
	
	if( this.state = TIMER_STATE_KILLED ) then
		return
	end if

	this.state = TIMER_STATE_EXITING
	
	condsignal( this.cond )
	threadwait( this.thread )			
	conddestroy( this.cond )
	
	this.state = TIMER_STATE_KILLED
	
end destructor
