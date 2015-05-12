' This is file g_Arguments.bas, an example for GLib
' translated from C-code by
' (C) 2011 by Thomas[ dot ]Freiherr[ at ]gmx{ dot }net
' License GPLv 3
'
' See for details (Handling commandline arguments with GApplication)
' http://developer.gnome.org/gio/stable/GApplicationCommandLine.html
'
' Start with command line arguments like: [./]g_Arguments 1 hello again 5
' Note: this example doesn't execute under windows XP or below

#INCLUDE ONCE "gio/gio.bi"

FUNCTION command_line CDECL( _
           BYVAL application AS GApplication PTR, _
           BYVAL cmdline AS GApplicationCommandLine PTR) AS INTEGER STATIC
  DIM AS gchar PTR PTR argv
  DIM AS gint argc, i

  argv = g_application_command_line_get_arguments (cmdline, @argc)

  g_application_command_line_print (cmdline, _
                                    !"This text is written back\n" _
                                    !"to stdout of the caller\n")

  FOR i = 0 TO argc - 1
    g_print (!"argument %d: %s\n", i, argv[i])
  NEXT

  g_strfreev (argv)

  RETURN 0
END FUNCTION



VAR app = g_application_new ("org.gtk.TestApplication", _
                         G_APPLICATION_HANDLES_COMMAND_LINE)
g_signal_connect (app, "command-line", G_CALLBACK (@command_line), NULL)
g_application_set_inactivity_timeout (app, 10000)

VAR status = g_application_run (app, __FB_ARGC__, __FB_ARGV__)

g_object_unref (app)

END status
