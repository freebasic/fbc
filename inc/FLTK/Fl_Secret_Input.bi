#include once "Fl_Input.bi"

extern "c++"
type Fl_Secret_Input extends Fl_Input
protected:
	declare constructor (byref b as const Fl_Secret_Input)
	declare operator let (byref b as const Fl_Secret_Input)
public:
	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr=0)
	declare function handle(as long) as long
end type
end extern 

