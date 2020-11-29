#pragma once

declare sub ThreadDetach alias "fb_ThreadDetach"( byval thread as any ptr )
declare function ThreadSelf alias "fb_ThreadSelf"( ) as any ptr
