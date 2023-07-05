#include once "Fl_Input.bi"

extern "c++"
type Fl_Int_Input extends Fl_Input
protected:
	declare constructor (byref b as const Fl_Int_Input)
	declare operator let (byref b as const Fl_Int_Input)
public:
	declare constructor(X as long, Y as long, W as long, H as long, l as const zstring ptr=0)
end type
end extern

