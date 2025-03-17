''
'' GTK-4 hello world window
''
'' Translated from gtk4/examples/hello/hello-world.c
''   GTK is released under the terms of the LGPL-2.1+
''

#include "glib-object.bi"
#include "gtk/gtk4.bi"

Sub PrintHello (ByVal widget as GtkWidget Ptr, ByVal user_data as gpointer)
  Print "Hello World"
End Sub

Sub OnActivate ( app as GtkApplication Ptr, user_data as gpointer )
  Dim as GtkWidget Ptr win = gtk_application_window_new (app)
  gtk_window_set_title (GTK_WINDOW (win), "Window")
  gtk_window_set_default_size (GTK_WINDOW (win), 200, 200)

  Dim as GtkWidget Ptr button = gtk_button_new_with_label ("Hello World")
  gtk_widget_set_halign (button, GTK_ALIGN_CENTER)
  gtk_widget_set_valign (button, GTK_ALIGN_CENTER)

  '' connect with PrintHello and close the window
  g_signal_connect (button, "clicked", G_CALLBACK(@PrintHello), NULL)
  g_signal_connect_swapped (button, "clicked", G_CALLBACK (@gtk_window_destroy), win)

  gtk_window_set_child (GTK_WINDOW (win), Cast(GtkWidget Ptr, button))
  gtk_window_present (GTK_WINDOW (win))

End Sub


Dim As GtkApplication Ptr app
Dim as Integer status

app = gtk_application_new ("freebasic.gtk4.hello", 0)
g_signal_connect (app, "activate", G_CALLBACK(@OnActivate), NULL)
status = g_application_run (G_APPLICATION (app), __FB_ARGC__, __FB_ARGV__)
g_object_unref (app)

End status
