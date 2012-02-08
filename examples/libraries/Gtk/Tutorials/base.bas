' Base.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

    Dim As GtkWidget Ptr win

    gtk_init (NULL, NULL)

    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
    gtk_window_set_title (GTK_WINDOW (win), "GTK base")

    g_signal_connect (G_OBJECT (win), "delete-event", _
                      G_CALLBACK (@gtk_main_quit), NULL)

    gtk_widget_show  (win)

    gtk_main ()
