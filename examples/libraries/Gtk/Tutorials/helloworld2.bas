' HelloWorld2.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __FB_GTK3__
#include once "gtk/gtk.bi"

' Our new improved callback.  The data passed to this function
' is printed to stdout.
Sub callback Cdecl(Byval widget As GtkWidget Ptr, Byval user_data As gpointer Ptr)

    g_print (!"Hello again - %s was pressed\n", user_data)

End Sub


' ==============================================
' Main
' ==============================================

    ' GtkWidget is the storage type for widgets
    Dim As GtkWidget Ptr win
    Dim As GtkWidget Ptr button
    Dim As GtkWidget Ptr box1

    ' This is called in all GTK applications. Arguments are parsed
    ' from the command line and are returned to the application.
    gtk_init (NULL, NULL)

    ' Create a new window
    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)

    ' This is a new call, which just sets the title of our
    ' new window to "Hello Buttons!"
    gtk_window_set_title (GTK_WINDOW (win), "Hello Buttons!")

    ' Here we just set a handler for delete_event that immediately
    ' exits GTK.
    g_signal_connect (G_OBJECT (win), "delete-event", _
                      G_CALLBACK (@gtk_main_quit), NULL)

    ' Sets the border width of the window.
    gtk_container_set_border_width (GTK_CONTAINER (win), 10)

    ' We create a box to pack widgets into.  This is described in detail
    ' in the "packing" section. The box is not really visible, it
    ' is just used as a tool to arrange widgets.
    box1 = gtk_hbox_new (FALSE, 0)

    ' Put the box into the main window.
    gtk_container_add (GTK_CONTAINER (win), box1)

    ' Creates a new button with the label "Button 1".
    button = gtk_button_new_with_label ("Button 1")

    ' Now when the button is clicked, we call the "callback" function
    ' with a pointer to "button 1" as its argument
    g_signal_connect (G_OBJECT (button), "clicked", _
                      G_CALLBACK (@callback), strptr("button 1"))

    ' Instead of gtk_container_add, we pack this button into the invisible
    ' box, which has been packed into the window.
    gtk_box_pack_start (GTK_BOX(box1), button, TRUE, TRUE, 0)

    ' Always remember this step, this tells GTK that our preparation for
    ' this button is complete, and it can now be displayed.
    gtk_widget_show (button)

    ' Do these same steps again to create a second button
    button = gtk_button_new_with_label ("Button 2")

    ' Call the same callback function with a different argument,
    ' passing a pointer to "button 2" instead.
    g_signal_connect (G_OBJECT (button), "clicked", _
                      G_CALLBACK (@callback), strptr("button 2"))

    gtk_box_pack_start(GTK_BOX (box1), button, TRUE, TRUE, 0)

    ' The order in which we show the buttons is not really important, but I
    ' recommend showing the window last, so it all pops up at once.
    gtk_widget_show (button)

    gtk_widget_show (box1)

    gtk_widget_show (win)

    ' Rest in gtk_main and wait for the fun to begin!
    gtk_main ()
