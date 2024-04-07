#include once "Fl_Pixmap.bi"

extern "c++"
type Fl_XPM_Image extends Fl_Pixmap 
private:
	declare operator let (byref w as const Fl_XPM_Image)
	declare constructor (byref w as const Fl_XPM_Image)
public:
	declare constructor(filename as const zstring ptr)
end type

end extern