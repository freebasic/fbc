' Paned.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

' Create the list of "messages"
Function create_list Cdecl( ) As GtkWidget Ptr

    Dim As GtkWidget Ptr scrolled_window
    Dim As GtkWidget Ptr tree_view
    Dim As GtkWidget Ptr model
    Dim As GtkTreeIter iter
    Dim As GtkCellRenderer Ptr cell
    Dim As GtkTreeViewColumn Ptr column
    Dim As integer i

    ' Create a new scrolled window, with scrollbars only if needed
    scrolled_window = gtk_scrolled_window_new (NULL, NULL)
    gtk_scrolled_window_set_policy (GTK_SCROLLED_WINDOW (scrolled_window), GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC)

    model = cast(GtkWidget Ptr, gtk_list_store_new (1, G_TYPE_STRING))
    tree_view = gtk_tree_view_new ()
    gtk_scrolled_window_add_with_viewport (GTK_SCROLLED_WINDOW (scrolled_window),  tree_view)
    gtk_tree_view_set_model (GTK_TREE_VIEW (tree_view), GTK_TREE_MODEL (model))
    gtk_widget_show (tree_view)

    ' Add some messages to the window
    For i = 0 To 9
        Dim As String msg
        msg = "Message #" + Str(i + 1)
        gtk_list_store_append (GTK_LIST_STORE (model), @iter)
        gtk_list_store_set (GTK_LIST_STORE (model),  @iter, 0, Strptr(msg), -1)
    Next i

    cell = gtk_cell_renderer_text_new ()

    column = gtk_tree_view_column_new_with_attributes ("Messages", cell, "text", 0, NULL)

    gtk_tree_view_append_column (GTK_TREE_VIEW (tree_view), GTK_TREE_VIEW_COLUMN (column))

    Return scrolled_window

End Function

' Add some text to our text widget - this is a callback that is invoked
' when our window is realized. We could also force our window to be
' realized with gtk_widget_realize, but it would have to be part of
' a hierarchy first

Sub insert_text Cdecl(Byval buffer As GtkTextBuffer Ptr)

    Dim As GtkTextIter iter
    Dim As Zstring * 1024 buf_text

    buf_text = !"From: pathfinder@nasa.gov\n"
    buf_text += !"To: mom@nasa.gov\n"
    buf_text += !"Subject: Made it!\n"
    buf_text += !"\n"
    buf_text += !"We just got in this morning. The weather has been\n"
    buf_text += !"great - clear but cold, and there are lots of fun sights.\n"
    buf_text += !"Sojourner says hi. See you soon.\n"
    buf_text += !" -Path\n"

    gtk_text_buffer_get_iter_at_offset (buffer, @iter, 0)
    gtk_text_buffer_insert (buffer, @iter,  buf_text, -1)
End Sub

' Create a scrolled text area that displays a "message"
Function create_text Cdecl( ) As GtkWidget Ptr

    Dim As GtkWidget Ptr scrolled_window
    Dim As GtkWidget Ptr  view_text
    Dim As GtkTextBuffer Ptr buffer

    view_text = gtk_text_view_new ()
    buffer = gtk_text_view_get_buffer (GTK_TEXT_VIEW (view_text))

    scrolled_window = gtk_scrolled_window_new (NULL, NULL)
    gtk_scrolled_window_set_policy (GTK_SCROLLED_WINDOW (scrolled_window), GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC)

    gtk_container_add (GTK_CONTAINER (scrolled_window), view_text)
    insert_text (buffer)

    gtk_widget_show_all (scrolled_window)

    Return scrolled_window

End Function


' ==============================================
' Main
' ==============================================

    Dim As GtkWidget Ptr win
    Dim As GtkWidget Ptr vpaned
    Dim As GtkWidget Ptr list
    Dim As GtkWidget Ptr text

    gtk_init (NULL, NULL)

    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
    gtk_window_set_title (GTK_WINDOW (win), "Paned Windows")
    g_signal_connect (G_OBJECT (win), "delete-event", _
                      G_CALLBACK (@gtk_main_quit), NULL)
    gtk_container_set_border_width (GTK_CONTAINER (win), 10)
    gtk_widget_set_size_request (GTK_WIDGET (win), 450, 400)

    ' create a vpaned widget and add it to our toplevel window
    vpaned = gtk_vpaned_new ()
    gtk_container_add (GTK_CONTAINER (win), vpaned)
    gtk_widget_show (vpaned)

    ' Now create the contents of the two halves of the window
    list = create_list ()
    gtk_paned_add1 (GTK_PANED (vpaned), list)
    gtk_widget_show (list)

    text = create_text ()
    gtk_paned_add2 (GTK_PANED (vpaned), text)
    gtk_widget_show (text)
    gtk_widget_show (win)

    gtk_main ()
