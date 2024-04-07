#include once "Fl_Dial.bi"

extern "c++"
type Fl_Fill_Dial extends Fl_Dial
protected:
	declare constructor (byref b as const Fl_Fill_Dial)
	declare operator let (byref b as const Fl_Fill_Dial)
public:
	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr=0)
end type
end extern

