#include "dos/dpmi.bi"

type FnIntHandler as function cdecl( byval as uinteger) as integer

declare function fb_isr_set cdecl alias "fb_isr_set"( _
	byval irq_number as uinteger, _
    byval pfnIntHandler as FnIntHandler ptr, _
    byval size as uinteger ) as integer

declare function fb_isr_reset cdecl alias "fb_isr_reset"( _
	byval irq_number as uinteger ) as integer

declare function fb_dos_lock_mem cdecl alias "fb_dos_lock_mem"( _
	byval as any ptr, byval as uinteger ) as integer
declare function fb_dos_unlock_mem cdecl alias "fb_dos_unlock_mem"( _
	byval as any ptr, byval as uinteger ) as integer


dim shared timer_ticks as integer

private function isr_timer cdecl( byval irq_number as uinteger) as integer
    timer_ticks += 1
    return 0   ' FALSE = we don't want to abort ISR handling
               '         IOW: call the old ISR handler
end function
private sub isr_timer_end cdecl()
end sub

if fb_dos_lock_mem( @timer_ticks, len(timer_ticks) )<>0 then
    print "Failed to lock data"
    end 1
end if

dim as byte ptr ptr_end = cptr( byte ptr, @isr_timer_end )
dim as byte ptr ptr_start = cptr( byte ptr, @isr_timer )
if not fb_isr_set( 0, @isr_timer, ptr_end - ptr_start ) then
    print "Failed to lock ISR"
    end 1
end if

print "Press ENTER to stop counting timer ticks"

while len(inkey$)=0: sleep 100: wend

fb_isr_reset( 0 )

print timer_ticks
end
