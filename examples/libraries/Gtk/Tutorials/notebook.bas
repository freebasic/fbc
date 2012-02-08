' Notebook.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

' This function rotates the position of the tabs
Sub rotate_book Cdecl( Byval button As GtkButton Ptr, Byval notebook As GtkNotebook Ptr )
    VAR tab_pos = gtk_notebook_get_tab_pos(notebook)
    gtk_notebook_set_tab_pos (notebook, (tab_pos + 1) Mod 4)
End Sub

' Add/Remove the page tabs and the borders
Sub tabsborder_book Cdecl( Byval button As GtkButton Ptr, Byval notebook As GtkNotebook Ptr )

    VAR tval = IIF( gtk_notebook_get_show_tabs(notebook), FALSE, TRUE)
    VAR bval = IIF( gtk_notebook_get_show_border(notebook), FALSE, TRUE)

    gtk_notebook_set_show_tabs (notebook, tval)
    gtk_notebook_set_show_border (notebook, bval)
End Sub

' Remove a page from the notebook
Sub remove_book Cdecl( Byval button As GtkButton Ptr, Byval notebook As GtkNotebook Ptr )
    Dim As gint page

    page = gtk_notebook_get_current_page (notebook)
    gtk_notebook_remove_page (notebook, page)
    ' Need to refresh the widget --
    ' This forces the widget to redraw itself.
    gtk_widget_queue_draw (GTK_WIDGET (notebook))
End Sub


' ==============================================
' Main
' ==============================================

    Dim As GtkWidget Ptr win
    Dim As GtkWidget Ptr button
    Dim As GtkWidget Ptr table
    Dim As GtkWidget Ptr notebook
    Dim As GtkWidget Ptr frame
    Dim As GtkWidget Ptr label
    Dim As GtkWidget Ptr checkbutton
    Dim As gint i
    Dim As String bufferf
    Dim As String bufferl

    gtk_init (NULL, NULL)

    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
    gtk_window_set_title (GTK_WINDOW (win), "Notebook")
    g_signal_connect (G_OBJECT (win), "delete-event", _
                      G_CALLBACK (@gtk_main_quit), NULL)

    gtk_container_set_border_width (GTK_CONTAINER (win), 10)

    table = gtk_table_new (3, 6, FALSE)
    gtk_container_add (GTK_CONTAINER (win), table)

    ' Create a new notebook, place the position of the tabs
    notebook = gtk_notebook_new ()
    gtk_notebook_set_tab_pos (GTK_NOTEBOOK (notebook), GTK_POS_TOP)
    gtk_table_attach_defaults (GTK_TABLE (table), notebook, 0, 6, 0, 1)
    gtk_widget_show (notebook)

    ' Let's append a bunch of pages to the notebook
    For  i = 0 To 4
        bufferf =  "Append Frame " + Str(i + 1)
        bufferl =  "Page " + Str(i + 1)

        frame = gtk_frame_new (Strptr(bufferf))
        gtk_container_set_border_width (GTK_CONTAINER (frame), 10)
        gtk_widget_set_size_request (frame, 100, 75)
        gtk_widget_show (frame)

        label = gtk_label_new (Strptr(bufferf))
        gtk_container_add (GTK_CONTAINER (frame), label)
        gtk_widget_show (label)

        label = gtk_label_new (bufferl)
        gtk_notebook_append_page (GTK_NOTEBOOK (notebook), frame, label)
    Next

    ' Now let's add a page to a specific spot
    checkbutton = gtk_check_button_new_with_label ("Check me please!")
    gtk_widget_set_size_request (checkbutton, 100, 75)
    gtk_widget_show (checkbutton)

    label = gtk_label_new ("Add page")
    gtk_notebook_insert_page (GTK_NOTEBOOK (notebook), checkbutton, label, 2)

    ' Now finally let's prepend pages to the notebook
    For i = 0 To 4
        bufferf = "Prepend Frame " + Str( i + 1)
        bufferl = "Page " + Str( i + 1)

        frame = gtk_frame_new (Strptr(bufferf))
        gtk_container_set_border_width (GTK_CONTAINER (frame), 10)
        gtk_widget_set_size_request (frame, 100, 75)
        gtk_widget_show (frame)

        label = gtk_label_new (Strptr(bufferf))
        gtk_container_add (GTK_CONTAINER (frame), label)
        gtk_widget_show (label)

        label = gtk_label_new (bufferl)
        gtk_notebook_prepend_page (GTK_NOTEBOOK (notebook), frame, label)
    Next

    ' Set what page to start at (page 4)
    gtk_notebook_set_current_page (GTK_NOTEBOOK (notebook), 3)

    ' Create a bunch of buttons
    button = gtk_button_new_with_label ("close")
    g_signal_connect_swapped (G_OBJECT (button), "clicked", _
                              G_CALLBACK (@gtk_main_quit), NULL)
    gtk_table_attach_defaults (GTK_TABLE (table), button, 0, 1, 1, 2)
    gtk_widget_show (button)

    button = gtk_button_new_with_label ("next page")
    g_signal_connect_swapped (G_OBJECT (button), "clicked", _
                              G_CALLBACK (@gtk_notebook_next_page), G_OBJECT(notebook))
    gtk_table_attach_defaults (GTK_TABLE (table), button, 1, 2, 1, 2)
    gtk_widget_show (button)

    button = gtk_button_new_with_label ("prev page")
    g_signal_connect_swapped (G_OBJECT (button), "clicked", _
                              G_CALLBACK (@gtk_notebook_prev_page), G_OBJECT(notebook))
    gtk_table_attach_defaults (GTK_TABLE (table), button, 2, 3, 1, 2)
    gtk_widget_show (button)

    button = gtk_button_new_with_label ("tab position")
    g_signal_connect (G_OBJECT (button), "clicked", _
                      G_CALLBACK (@rotate_book),  notebook)
    gtk_table_attach_defaults (GTK_TABLE (table), button, 3, 4, 1, 2)
    gtk_widget_show (button)

    button = gtk_button_new_with_label ("tabs/border on/off")
    g_signal_connect (G_OBJECT (button), "clicked", _
                      G_CALLBACK (@tabsborder_book), notebook)
    gtk_table_attach_defaults (GTK_TABLE (table), button, 4, 5, 1, 2)
    gtk_widget_show (button)

    button = gtk_button_new_with_label ("remove page")
    g_signal_connect (G_OBJECT (button), "clicked", _
                      G_CALLBACK (@remove_book), notebook)
    gtk_table_attach_defaults (GTK_TABLE (table), button, 5, 6, 1, 2)
    gtk_widget_show (button)

    gtk_widget_show (table)
    gtk_widget_show (win)

    gtk_main ()
