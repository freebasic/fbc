#include once "Fl_Browser.bi"

extern "c++"
type Fl_Select_Browser extends Fl_Browser
protected:
	declare constructor (byref b as const Fl_Select_Browser)
	declare operator let (byref b as const Fl_Select_Browser)
public:
	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr=0)
end type
end extern

