#include once "Fl_Window.bi"

extern "c++"
type Fl_Single_Window extends Fl_Window
protected:
	declare constructor (byref b as const Fl_Single_Window)
	declare operator let (byref b as const Fl_Single_Window)
public:
	declare sub show()
	declare sub show(a as long, b as zstring ptr ptr)
	declare sub flush()
  

	declare constructor(W as long, H as long, l as const zstring ptr=0)

	declare constructor(X as long, Y as long, W as long, H as long, l as const zstring ptr=0)

	declare function make_current() as long

end type

end extern

private sub Fl_Single_Window.show(a as long, b as zstring ptr ptr)
	base.show(a,b)
end sub
