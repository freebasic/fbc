' HelloWorld.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

' This is a callback function. The data arguments are ignored
' in this example. More on callbacks below.
Sub hello Cdecl(Byval widget As GtkWidget Ptr, Byval user_data As gpointer Ptr)

    g_print (!"Hello World\n")

End Sub

Function delete_event Cdecl(Byval widget As GtkWidget Ptr, Byval event As GdkEvent Ptr, Byval user_data As gpointer Ptr) as integer
    ' If you return FALSE in the "delete_event" signal handler,
    ' GTK will emit the "destroy" signal. Returning TRUE means
    ' you don't want the window to be destroyed.
    ' This is useful for popping up 'are you sure you want to quit?'
    ' type dialogs. */

    g_print (!"delete event occurred\n")

    ' Change TRUE to FALSE and the main window will be destroyed with
    ' a "delete_event".
    return FALSE

End Function


' ==============================================
' Main
' ==============================================

    ' GtkWidget is the storage type for widgets
    Dim As GtkWidget Ptr win
    Dim As GtkWidget Ptr button

    ' This is called in all GTK applications. Arguments are parsed
    ' from the command line and are returned to the application.
    gtk_init (NULL, NULL)

    ' create a new window
    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
    gtk_window_set_title (GTK_WINDOW (win), "Hello, world!")

    ' When the window is given the "delete_event" signal (this is given
    ' by the window manager, usually by the "close" option, or on the
    ' titlebar), we ask it to call the delete_event () function
    ' as defined above. The data passed to the callback
    ' function is NULL and is ignored in the callback function.
    g_signal_connect (G_OBJECT (win), "delete-event", _
                      G_CALLBACK(@delete_event), NULL)

    ' Here we connect the "destroy" event to a signal handler.
    ' This event occurs when we call gtk_widget_destroy() on the window,
    ' or if we return FALSE in the "delete_event" callback.
    g_signal_connect (G_OBJECT (win), "destroy", _
                      G_CALLBACK (@gtk_main_quit), NULL)

    ' Sets the border width of the window.
    gtk_container_set_border_width (GTK_CONTAINER (win), 10)

    ' Creates a new button with the label "Hello World".
    button = gtk_button_new_with_label ("Hello World")

    ' When the button receives the "clicked" signal, it will call the
    ' function hello() passing it NULL as its argument.  The hello()
    ' function is defined above.
    g_signal_connect_swapped (G_OBJECT (button), "clicked", _
                              G_CALLBACK (@hello), NULL)

    ' This will cause the window to be destroyed by calling
    ' gtk_widget_destroy(window) when "clicked".  Again, the destroy
    ' signal could come from here, or the window manager.
    g_signal_connect_swapped (G_OBJECT (button), "clicked", _
                              G_CALLBACK (@gtk_widget_destroy), G_OBJECT( win))

    ' This packs the button into the window (a gtk container).
    gtk_container_add (GTK_CONTAINER (win), button)

    ' The final step is to display this newly created widget.
    gtk_widget_show (button)

    ' and the window
    gtk_widget_show (win)

    ' All GTK applications must have a gtk_main(). Control ends here
    ' and waits for an event to occur (like a key press or
    ' mouse event).
    gtk_main ()
