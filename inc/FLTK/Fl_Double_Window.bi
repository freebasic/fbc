#include once "Fl_Window.bi"

extern "c++"
type Fl_Double_Window extends Fl_Window
protected:
	declare sub flush(eraseoverlay as long)
	force_doublebuffering_ as ubyte

	declare constructor (byref b as const Fl_Double_Window)
	declare operator let (byref b as const Fl_Double_Window)
public:
	declare virtual sub show()
	declare sub show(a as long, b as zstring ptr ptr)
	declare virtual sub flush()
	declare virtual sub resize(as long, as long, as long, as long)
	declare virtual sub hide()
	declare virtual destructor
  

	declare constructor(W as long, H as long, l as const zstring ptr=0)

	declare constructor(X as long, Y as long, W as long, H as long, l as const zstring ptr=0)


end type

end extern

private sub Fl_Double_Window.show(a as long, b as zstring ptr ptr)
	base.show(a,b)
end sub
