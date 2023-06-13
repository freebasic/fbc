#include once "Fl_Double_Window.bi"

extern "c++"
type Fl_Overlay_Window extends Fl_Double_Window
protected:
	declare abstract sub draw_overlay()

	declare constructor (byref b as const Fl_Overlay_Window)
	declare operator let (byref b as const Fl_Overlay_Window)
private:
	overlay_ as Fl_Window ptr

public:
	declare sub show()
	declare sub flush()
	declare sub hide()
	declare sub resize(as long, as long, as long, as long)
	declare destructor

	declare function can_do_overlay() as long
	declare sub redraw_overlay()
private:
	declare constructor(W as long, H as long, l as const zstring ptr=0)
	declare constructor(X as long, Y as long, W as long, H as long, l as const zstring ptr=0)
public:
	declare sub show(a as long, b as zstring ptr ptr)


end type

end extern

private sub Fl_Overlay_Window.show(a as long, b as zstring ptr ptr)
	base.show(a,b)
end sub
