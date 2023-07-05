#include once "Fl_Output.bi"

extern "c++"
type Fl_Multiline_Output extends Fl_Output
protected:
	declare constructor (byref b as const Fl_Multiline_Output)
	declare operator let (byref b as const Fl_Multiline_Output)
public:
	declare constructor(X as long, Y as long, W as long, H as long, l as const zstring ptr=0)
end type
end extern

