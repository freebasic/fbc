' Created by vladimir777, 2011
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

sub undo_redo cdecl(byval widget as GtkWidget ptr, byval item as gpointer)

  static count as integer = 0
  VAR name1 = *gtk_widget_get_name(widget)

  print name1

  gtk_widget_set_sensitive(item, TRUE)
  if (name1 = "undo1") Then
    count += 1
    IF count < 2 THEN EXIT SUB
  else
    count -= 1
    IF count > -2 THEN EXIT SUB
  end if
  gtk_widget_set_sensitive(widget, FALSE)

end sub


dim as GtkWidget ptr win
dim as GtkWidget ptr vbox
dim as GtkWidget ptr toolbar
dim as GtkToolItem  ptr undo1
dim as GtkToolItem  ptr redo1
dim as GtkToolItem  ptr sep
dim as GtkToolItem  ptr exit1

gtk_init(@__FB_ARGC__, @__FB_ARGV__)

  win = gtk_window_new(GTK_WINDOW_TOPLEVEL)
  gtk_window_set_position(GTK_WINDOW(win), GTK_WIN_POS_CENTER)
  gtk_window_set_default_size(GTK_WINDOW(win), 250, 200)
  gtk_window_set_title(GTK_WINDOW(win), "undoredo")

  vbox = gtk_vbox_new(FALSE, 0)
  gtk_container_add(GTK_CONTAINER(win), vbox)

  toolbar = gtk_toolbar_new()
  gtk_toolbar_set_style(GTK_TOOLBAR(toolbar), GTK_TOOLBAR_ICONS)

  gtk_container_set_border_width(GTK_CONTAINER(toolbar), 2)

  undo1 = gtk_tool_button_new_from_stock(GTK_STOCK_UNDO)
  gtk_widget_set_name(GTK_WIDGET(undo1), "undo1")
  gtk_toolbar_insert(GTK_TOOLBAR(toolbar), undo1, -1)

  redo1 = gtk_tool_button_new_from_stock(GTK_STOCK_REDO)
  gtk_widget_set_name(GTK_WIDGET(redo1), "redo1")
  gtk_toolbar_insert(GTK_TOOLBAR(toolbar), redo1, -1)

  sep = gtk_separator_tool_item_new()
  gtk_toolbar_insert(GTK_TOOLBAR(toolbar), sep, -1)

  exit1 = gtk_tool_button_new_from_stock(GTK_STOCK_QUIT)
  gtk_toolbar_insert(GTK_TOOLBAR(toolbar), exit1, -1)

  gtk_box_pack_start(GTK_BOX(vbox), toolbar, FALSE, FALSE, 5)
  g_signal_connect (G_OBJECT(undo1), "clicked", _
                    G_CALLBACK(@undo_redo), redo1)
  g_signal_connect (G_OBJECT(redo1), "clicked", _
                    G_CALLBACK(@undo_redo), undo1)
  g_signal_connect (G_OBJECT(exit1), "clicked", _
                    G_CALLBACK(@gtk_main_quit), NULL)
  g_signal_connect (G_OBJECT(win), "delete-event", _
                    G_CALLBACK(@gtk_main_quit), NULL)
  gtk_widget_show_all(win)

  gtk_main()
end 0
