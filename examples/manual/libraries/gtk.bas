'' examples/manual/libraries/gtk.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'GTK+, The GIMP ToolKit'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibgtk
'' --------

#include Once "gtk/gtk.bi"

Dim Shared As GtkWidget Ptr win

Private Sub on_clicked cdecl(ByVal button As GtkButton Ptr, ByVal userdata As gpointer)
	Static As Integer clickcount = 0
	clickcount += 1
	gtk_window_set_title(GTK_WINDOW(win), "clicked " & clickcount & " times")
End Sub

gtk_init(NULL, NULL)

win = gtk_window_new(GTK_WINDOW_TOPLEVEL)
gtk_window_set_title(GTK_WINDOW(win), "A small GTK+ example")
gtk_window_set_default_size(GTK_WINDOW(win), 300, 200)
gtk_container_set_border_width(GTK_CONTAINER(win), 20)

g_signal_connect(G_OBJECT(win), "destroy", G_CALLBACK(@gtk_main_quit), NULL)

Dim As GtkWidget Ptr button = gtk_button_new_with_label("Click me!")
gtk_container_add(GTK_CONTAINER(win), button)

g_signal_connect(G_OBJECT(button), "clicked", G_CALLBACK(@on_clicked), NULL)

gtk_widget_show_all(win)

gtk_main()
