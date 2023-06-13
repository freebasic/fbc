#include once "Fl_Bitmap.bi"

extern "c++"
type Fl_FormsBitmap extends Fl_Widget 
private:
	b as Fl_Bitmap ptr
protected:
	declare constructor (byref b as const Fl_FormsBitmap)
	declare operator let (byref b as const Fl_FormsBitmap)
	declare sub draw()
public:
	declare constructor(as Fl_Boxtype, as long, as long, as long, as long, as const zstring ptr = 0)
	declare sub set(W as long, H as long, bits as const ubyte ptr)
	declare sub bitmap(B_ as Fl_Bitmap ptr)
	declare const function bitmap() as Fl_Bitmap ptr
end type
end extern

private sub Fl_FormsBitmap.bitmap(B_ as Fl_Bitmap ptr)
	b = B_
end sub

private function Fl_FormsBitmap.bitmap() as Fl_Bitmap ptr
	return b
end function