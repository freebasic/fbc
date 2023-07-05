#include once "Fl_Menu_.bi"

extern "c++"
type Fl_Choice extends Fl_Menu_
protected:
	declare constructor (byref b as const Fl_Choice)
	declare operator let (byref b as const Fl_Choice)

	declare sub draw()

public:
	declare function handle(as long) as long
	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr=0)

	declare const function value() as long 

	declare function value(v as long) as long 

	declare function value(v as const Fl_Menu_Item ptr) as long 
end type
end extern 

private function Fl_Choice.value() as long 
	return base.value()
end function

