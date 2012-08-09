' This is file g_Filenames.bas, an example for GLib
' translated from C-code by
' (C) 2011 by Thomas[ dot ]Freiherr[ at ]gmx{ dot }net
' License GPLv 3
'
' See for details (Opening files with a GApplication)
' http://developer.gnome.org/gio/stable/GApplication.html
' Note: this example doesn't execute under windows XP or below

#INCLUDE ONCE "gio/gio.bi"

SUB activate CDECL(BYVAL application AS GApplication PTR)
  g_print (!"activated\n")

  '/* Note: when doing a longer-lasting action here that returns
   '* to the mainloop, you should use g_application_hold() and
   '* g_application_release() to keep the application alive until
   '* the action is completed.
   '*/
END SUB

SUB open_ CDECL(BYVAL application AS GApplication PTR, _
                BYVAL files AS GFile PTR PTR, _
                BYVAL n_files AS gint, _
                BYVAL hint AS CONST gchar PTR)

  FOR i AS gint = 0 TO n_files - 1
    VAR uri = g_file_get_uri (files[i])
    g_print (!"open %s\n", uri)
    g_free (uri)
  NEXT

  '/* Note: when doing a longer-lasting action here that returns
   '* to the mainloop, you should use g_application_hold() and
   '* g_application_release() to keep the application alive until
   '* the action is completed.
   '*/
END SUB


VAR app = g_application_new ("org.gtk.TestApplication", _
                             G_APPLICATION_HANDLES_OPEN)
g_signal_connect (app, "activate", G_CALLBACK (@activate), NULL)
g_signal_connect (app, "open", G_CALLBACK (@open_), NULL)
g_application_set_inactivity_timeout (app, 10000)

VAR status = g_application_run (app, __FB_ARGC__, __FB_ARGV__)

g_object_unref (app)

END status
