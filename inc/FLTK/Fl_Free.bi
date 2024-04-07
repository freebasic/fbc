#include once "Fl_Widget.bi"

extern "c++"
type FL_HANDLEPTR as function (as Fl_Widget ptr, as long, as single, as single, as byte alias "char") as long

type Fl_Free extends Fl_Widget
private:
	hfunc as FL_HANDLEPTR
	declare static sub step_ alias "step" (as any ptr)
protected:
	declare constructor (byref b as const Fl_Free)
	declare operator let (byref b as const Fl_Free)
	declare sub draw()
public:
	declare function handle(e as long) as long
	declare constructor(t as ubyte, X as long, Y as long, W as long, H as long, l as const zstring ptr, hdl as FL_HANDLEPTR)
	declare destructor()
end type
end extern

