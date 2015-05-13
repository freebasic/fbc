' This is file gtk_applicationE110.bas, an example for GTK3
' (C) 2011 by Thomas[ dot ]Freiherr[ at ]gmx{ dot }net
' License GPLv 3
'
' See for details (A simple application)
' http://developer.gnome.org/gtk3/stable/GtkApplication.html
'
' Note: This example doesn't execute on windows XP or below.

#DEFINE __USE_GTK3__
#INCLUDE ONCE "gtk/gtk.bi"

SUB new_window (BYVAL app AS GApplication PTR, _
                BYVAL file AS GFile PTR)
  VAR win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
  gtk_window_set_application (GTK_WINDOW (win), GTK_APPLICATION (app))
  gtk_window_set_title (GTK_WINDOW (win), @"Bloatpad")
  VAR scrolled = gtk_scrolled_window_new (NULL, NULL)
  VAR vie = gtk_text_view_new ()
  gtk_container_add (GTK_CONTAINER (scrolled), vie)
  gtk_container_add (GTK_CONTAINER (win), scrolled)

  IF file THEN
    DIM AS gchar PTR contents
    DIM AS gsize length

    IF g_file_load_contents (file, NULL, @contents, @length, NULL, NULL) THEN
      VAR buffer = gtk_text_view_get_buffer (GTK_TEXT_VIEW (vie))
      gtk_text_buffer_set_text (buffer, contents, length)
      g_free (contents)
    END IF
  END IF

  gtk_widget_show_all (GTK_WIDGET (win))
END SUB

TYPE AS GtkApplication BloatPad
TYPE AS GtkApplicationClass BloatPadClass

G_DEFINE_TYPE (BloatPad, bloat_pad, GTK_TYPE_APPLICATION)

SUB bloat_pad_open CDECL(BYVAL app AS GApplication PTR, _
                         BYVAL files AS GFile PTR PTR, _
                         BYVAL n_files AS gint, _
                         BYVAL hint AS CONST gchar PTR)
  FOR i AS gint = 0 TO n_files - 1
    new_window (app, files[i])
  NEXT
END SUB

SUB bloat_pad_activate CDECL(BYVAL app AS GApplication PTR)
  new_window (app, NULL)
END SUB

SUB bloat_pad_finalize CDECL(BYVAL obj AS GObject PTR)
  G_OBJECT_CLASS (bloat_pad_parent_class)->finalize (obj)
END SUB

SUB bloat_pad_init CDECL(BYVAL app AS BloatPad PTR)
END SUB

SUB bloat_pad_class_init CDECL(BYVAL clas AS BloatPadClass PTR)
  G_OBJECT_CLASS(clas)->finalize = @bloat_pad_finalize

  G_APPLICATION_CLASS(clas)->activate = @bloat_pad_activate
  G_APPLICATION_CLASS(clas)->open = @bloat_pad_open
END SUB

FUNCTION bloat_pad_new () AS BloatPad PTR
  g_type_init ()

  RETURN g_object_new (bloat_pad_get_type (), _
                       @"application-id", @"org.gtk.Test.bloatpad", _
                       "flags", G_APPLICATION_HANDLES_OPEN, _
                       NULL)
END FUNCTION



VAR bloat_pad = bloat_pad_new ()
VAR status = g_application_run (G_APPLICATION (bloat_pad), __FB_ARGC__, __FB_ARGV__)
g_object_unref (bloat_pad)

END status
