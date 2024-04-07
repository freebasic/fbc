#include once "Fl_Bitmap.bi"

extern "c++"
type Fl_XBM_Image extends Fl_Bitmap 
private:
	declare operator let (byref w as const Fl_XBM_Image)
	declare constructor (byref w as const Fl_XBM_Image)
public:
	declare constructor(filename as const zstring ptr)
end type

end extern