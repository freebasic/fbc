' This is file g_SplitArguments.bas, an example for GLib
' translated from C-code by
' (C) 2011 by Thomas[ dot ]Freiherr[ at ]gmx{ dot }net
' License GPLv 3
'
' See for details (Split commandline handling)
' http://developer.gnome.org/gio/stable/GApplicationCommandLine.html
'
' Start with command line arguments like: g_SplitArguments 1 hello --local-again 5
' Note: this example doesn't execute under windows XP or below

#INCLUDE ONCE "gio/gio.bi"

FUNCTION command_line CDECL( _
           BYVAL application AS GApplication PTR, _
           BYVAL cmdline AS GApplicationCommandLine PTR _
           ) AS INTEGER STATIC
  DIM AS gint argc
  DIM AS gchar PTR PTR argv
  argv = g_application_command_line_get_arguments (cmdline, @argc)

  FOR i AS gint = 0 TO argc - 1
    g_print (!"handling argument %s remotely\n", argv[i])
  NEXT

  g_strfreev (argv)
  RETURN 0
END FUNCTION

FUNCTION test_local_cmdline CDECL( _
           BYVAL application AS GApplication PTR, _
           BYVAL arguments AS gchar PTR PTR PTR, _
           BYVAL exit_status AS gint PTR) AS gboolean STATIC
  DIM AS gchar PTR PTR argv
  DIM AS gint i, j
  argv = *arguments
  i = 1
  WHILE argv[i]
    IF g_str_has_prefix (argv[i], "--local-") THEN
      g_print (!"handling argument %s locally\n", argv[i])
      g_free (argv[i])
      j = i
      WHILE argv[j]
        argv[j] = argv[j + 1]
        j += 1
      WEND
    ELSE
      g_print (!"not handling argument %s locally\n", argv[i])
      i += 1
    END IF
  WEND
  *exit_status = 0
  RETURN FALSE
END FUNCTION

TYPE AS GApplication TestApplication
TYPE AS GApplicationClass TestApplicationClass

G_DEFINE_TYPE(TestApplication, test_application, G_TYPE_APPLICATION)

SUB test_application_finalize CDECL(BYVAL object AS GObject PTR)
  G_OBJECT_CLASS (test_application_parent_class)->finalize(object)
END SUB

SUB test_application_init CDECL(BYVAL app AS TestApplication PTR)
END SUB

SUB test_application_class_init CDECL(BYVAL clas AS TestApplicationClass PTR)
  G_OBJECT_CLASS(clas)->finalize = @test_application_finalize
  G_APPLICATION_CLASS(clas)->local_command_line = @test_local_cmdline
END SUB

FUNCTION test_application_new (BYVAL application_id AS CONST gchar PTR, _
                               BYVAL flags AS GApplicationFlags) AS GApplication PTR
  g_return_val_if_fail(g_application_id_is_valid (application_id), NULL)

  g_type_init()

  RETURN g_object_new(test_application_get_type (), _
                      "application-id", application_id, _
                      "flags", flags, _
                      NULL)
END FUNCTION


VAR status = -1
VAR app = test_application_new ("org.gtk.TestApplication", 0)
IF app THEN
  g_application_set_inactivity_timeout (app, 10000)
  g_signal_connect(app, "command-line", G_CALLBACK (@command_line), NULL)

  status = g_application_run (app, __FB_ARGC__, __FB_ARGV__)

  g_object_unref (app)
END IF

END status
