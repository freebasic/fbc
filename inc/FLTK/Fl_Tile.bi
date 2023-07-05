#include once "Fl_Input.bi"

extern "c++"
type Fl_Tile extends Fl_Group
protected:
	declare constructor (byref b as const Fl_Tile)
	declare operator let (byref b as const Fl_Tile)
public:
	declare function handle(event as long) as long
	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr=0)
	declare sub resize(X as long, Y as long, W as long, H as long)
	declare sub position(oldx as long, oldy as long, newx as long, newy as long)
end type
end extern 

