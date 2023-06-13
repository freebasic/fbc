#include once "Fl_Pixmap.bi"

extern "c++"
type Fl_FormsPixmap extends Fl_Widget
private:
	b as Fl_Pixmap ptr
protected:
	declare sub draw()

	declare constructor (byref b as const Fl_FormsPixmap)
	declare operator let (byref b as const Fl_FormsPixmap)
public:
	declare constructor(t as Fl_Boxtype, X as long, Y as long, W as long, H as long, L as const zstring ptr=0)

	declare sub set(bits as zstring const ptr ptr)
	declare sub Pixmap(B_ as Fl_Pixmap ptr)
	declare const function Pixmap() as Fl_Pixmap ptr
end type
end extern

private sub Fl_FormsPixmap.Pixmap(B_ as Fl_Pixmap ptr)
	b=B_
end sub

private function Fl_FormsPixmap.Pixmap() as Fl_Pixmap ptr
	return b
end function