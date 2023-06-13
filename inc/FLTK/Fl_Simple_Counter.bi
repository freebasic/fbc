#include once "Fl_Counter.bi"

extern "c++"

type Fl_Simple_Counter extends Fl_Counter
protected:
	declare constructor (byref b as const Fl_Simple_Counter)
	declare operator let (byref b as const Fl_Simple_Counter)
public:
	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr=0)
end type
end extern
