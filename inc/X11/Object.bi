'' FreeBASIC binding for libXt-1.1.4

#pragma once

'' The following symbols have been renamed:
''     typedef Object => Object_

extern "C"

#define _XtObject_h
type Object_ as _ObjectRec ptr
type ObjectClass as _ObjectClassRec ptr
extern objectClass as WidgetClass

end extern
