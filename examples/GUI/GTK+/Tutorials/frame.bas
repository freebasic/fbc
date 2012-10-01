' Frame.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

' ==============================================
' Main
' ==============================================

    ' GtkWidget is the storage type for widgets
    Dim As GtkWidget Ptr win
    Dim As GtkWidget Ptr frame

    ' Initialise GTK
    gtk_init (NULL, NULL)

    ' Create a new window
    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
    gtk_window_set_title (GTK_WINDOW (win), "Frame Example")

    ' Here we connect the "destroy" event to a signal handler
    g_signal_connect (G_OBJECT (win), "delete-event", _
                      G_CALLBACK (@gtk_main_quit), NULL)
    gtk_widget_set_size_request (win, 300, 300)

    ' Sets the border width of the window.
    gtk_container_set_border_width (GTK_CONTAINER (win), 10)

    ' Create a Frame
    frame = gtk_frame_new (NULL)
    gtk_container_add (GTK_CONTAINER (win), frame)

    ' Set the frame's label
    gtk_frame_set_label (GTK_FRAME (frame), "GTK Frame Widget")

    ' Align the label at the right of the frame
    gtk_frame_set_label_align (GTK_FRAME (frame), 1.0, 0.0)

    ' Set the style of the frame
    gtk_frame_set_shadow_type (GTK_FRAME (frame), GTK_SHADOW_ETCHED_OUT)

    gtk_widget_show (frame)

    ' Display the window
    gtk_widget_show (win)

    ' Enter the event loop
    gtk_main ()
