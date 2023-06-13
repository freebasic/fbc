#ifdef FLTK_HAVE_CAIRO
#include once "Fl_Double_Window.bi"

extern "c++"

type Fl_Cairo_Window_ as Fl_Cairo_Window
type cairo_draw_cb as sub (self as Fl_Cairo_Window_ ptr, def as cairo_t ptr)

type Fl_Cairo_Window extends Fl_Double_Window
protected:
	declare constructor (byref b as const Fl_Cairo_Window)
	declare operator let (byref b as const Fl_Cairo_Window)

	declare sub draw()
public:
	declare constructor(w as long, h as long)

	declare sub set_draw_cb(cb as cairo_draw_cb)
private:
	draw_cb_ as cairo_draw_cb 
end type

end extern

private sub Fl_Cairo_Window.draw()
	base.draw()
	if Fl.cairo_autolink_context()=0 then Fl.cairo_make_current(@this)
	if (draw_cb_) then draw_cb_(@this, Fl.cairo_cc())
end sub

private constructor Fl_Cairo_Window(w as long, h as long)
	base(w,h)
end constructor

private sub Fl_Cairo_Window.set_draw_cb(cb as cairo_draw_cb)
	draw_cb_=cb
end sub
#endif
