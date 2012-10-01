' Table.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

' Our callback.
' The data passed to this function is printed to stdout
Sub callback Cdecl(Byval widget As GtkWidget Ptr, Byval user_data As gpointer Ptr)

    g_print (!"Hello again - %s was pressed\n", user_data)

End Sub

' ==============================================
' Main
' ==============================================

    Dim As GtkWidget Ptr win
    Dim As GtkWidget Ptr button
    Dim As GtkWidget Ptr table

    gtk_init (NULL, NULL)

    ' Create a new window
    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)

    ' Set the window title
    gtk_window_set_title (GTK_WINDOW (win), "Table")

    ' Set a handler for delete_event that immediately
    ' exits GTK.
    g_signal_connect (G_OBJECT (win), "delete_event", _
                      G_CALLBACK (@gtk_main_quit), NULL)

    ' Sets the border width of the window.
    gtk_container_set_border_width (GTK_CONTAINER (win), 20)

    ' Create a 2x2 table
    table = gtk_table_new (2, 2, TRUE)

    ' Put the table in the main window
    gtk_container_add (GTK_CONTAINER (win), table)

    ' Create first button
    button = gtk_button_new_with_label ("button 1")

    ' When the button is clicked, we call the "callback" function
    ' with a pointer to "button 1" as its argument
    g_signal_connect (G_OBJECT (button), "clicked", _
                      G_CALLBACK (@callback), Strptr("button 1"))

    ' Insert button 1 into the upper left quadrant of the table
    gtk_table_attach_defaults (GTK_TABLE (table), button, 0, 1, 0, 1)

    gtk_widget_show (button)

    ' Create second button
    button = gtk_button_new_with_label ("button 2")

    ' When the button is clicked, we call the "callback" function
    ' with a pointer to "button 2" as its argument
    g_signal_connect (G_OBJECT (button), "clicked", _
                      G_CALLBACK (@callback), Strptr("button 2"))

    ' Insert button 2 into the upper right quadrant of the table
    gtk_table_attach_defaults (GTK_TABLE (table), button, 1, 2, 0, 1)

    gtk_widget_show (button)

    ' Create "Quit" button
    button = gtk_button_new_with_label ("Quit")

    ' When the button is clicked, we call the "delete_event" function
    ' and the program exits
    g_signal_connect (G_OBJECT (button), "clicked", _
                      G_CALLBACK (@gtk_main_quit), NULL)

    ' Insert the quit button into the both
    ' lower quadrants of the table
    gtk_table_attach_defaults (GTK_TABLE (table), button, 0, 2, 1, 2)

    gtk_widget_show (button)
    gtk_widget_show (table)
    gtk_widget_show (win)

    gtk_main ()
