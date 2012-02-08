' Aspectframe.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

' ==============================================
' Main
' ==============================================

    Dim As GtkWidget Ptr win
    Dim As GtkWidget Ptr aspect_frame
    Dim As GtkWidget Ptr drawing_area

    gtk_init (NULL, NULL)

    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
    gtk_window_set_title (GTK_WINDOW (win), "Aspect Frame")
    g_signal_connect (G_OBJECT (win), "delete-event", _
                      G_CALLBACK (@gtk_main_quit), NULL)
    gtk_container_set_border_width (GTK_CONTAINER (win), 10)

    ' Create an aspect_frame and add it to our toplevel window
    aspect_frame = gtk_aspect_frame_new ("2x1", _  ' label
                                             0.5, _ ' center x
                                             0.5, _ ' center y
                                             2,  _ ' xsize/ysize = 2
                                             FALSE)   ' ignore child's aspect
    gtk_container_add (GTK_CONTAINER (win), aspect_frame)
    gtk_widget_show (aspect_frame)

    ' Now add a child widget to the aspect frame
    drawing_area = gtk_drawing_area_new ()

    ' Ask for a 200x200 window, but the AspectFrame will give us a 200x100
    ' window since we are forcing a 2x1 aspect ratio
    gtk_widget_set_size_request (drawing_area, 200, 200)
    gtk_container_add (GTK_CONTAINER (aspect_frame), drawing_area)
    gtk_widget_show (drawing_area)

    gtk_widget_show (win)

    gtk_main ()
