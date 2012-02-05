' This is file g_VarArgMacros.bas, an macro example
' (C) 2011 by Thomas[ dot ]Freiherr[ at ]gmx{ dot }net
' License GPLv 3
'
' Details: http://developer.gnome.org/glib/2.30/glib-Message-Logging.html
' Test if your fbc version supports var arg macros (>= 0.21.1)

#INCLUDE "glib.bi"

' send an information, continue
g_message(!"from GLib, just %i more %s!\n", 2, "times")

' send a warning, continue
g_warning(!"just %i more %s!\n", 1, "time")

' report an error and stop
g_error(!"That's it! %i %i %i %s\n", 1, 2, 3, " over!")

? "This statement will not be executed!"
