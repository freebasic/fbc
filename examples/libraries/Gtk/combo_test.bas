''
'' combo box example, translated from an C example written by Özcan Güngör
''
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/
' Note: spits an error on GTK-2 due to a deprecated signal (but works)

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

'':::::
sub act cdecl (byval widget as GtkWidget ptr, byval _data as gpointer)
   '' Print the selected combo item to console

#IFDEF __USE_GTK3__
   g_print( !"%s\n", gtk_combo_box_text_get_active_text( GTK_COMBO_BOX_TEXT(_data)) )
#ELSE
   g_print( !"%s\n", gtk_entry_get_text( GTK_ENTRY(GTK_COMBO(_data)->entry) ) )
#ENDIF

end sub


   gtk_init( 0, NULL )

   '' Create a new window
   VAR win = gtk_window_new( GTK_WINDOW_TOPLEVEL )
   gtk_window_set_title( GTK_WINDOW(win), "Combo Box" )

   '' Connect destroy event to the window.
   g_signal_connect( G_OBJECT(win), "delete-event", _
                     G_CALLBACK(@gtk_main_quit), NULL )

   '' Create a new horizontal box
   VAR box = gtk_hbox_new( 1, 0 )
   gtk_container_add( GTK_CONTAINER(win), box )

#IFDEF __USE_GTK3__
   '' Creates a combo box with entry
   VAR combo = gtk_combo_box_text_new_with_entry ( )

   gtk_combo_box_text_append_text (GTK_COMBO_BOX_TEXT(combo), "Slackware" )
   gtk_combo_box_text_append_text (GTK_COMBO_BOX_TEXT(combo), "RedHat" )
   gtk_combo_box_text_append_text (GTK_COMBO_BOX_TEXT(combo), "SuSE" )

   gtk_combo_box_set_active (GTK_COMBO_BOX(combo), 0)
#ELSE
   '' Creates a combo box
   dim as GList ptr list = NULL

   list = g_list_append( list, strptr( "Slackware" ) )
   list = g_list_append( list, strptr( "RedHat" ) )
   list = g_list_append( list, strptr( "SuSE" ) )

   '' Creates a combo box
   VAR combo = gtk_combo_new( )

   '' Sets the list
   gtk_combo_set_popdown_strings( GTK_COMBO(combo), list )

   '' Enables up/down keys change the value.
   gtk_combo_set_use_arrows_always( GTK_COMBO(combo), 1 )
#ENDIF

   gtk_box_pack_start( GTK_BOX(box), combo, 1, 1, 1 )

   VAR button = gtk_button_new_with_label("Write it")
   g_signal_connect( G_OBJECT(button), "clicked", _
                     G_CALLBACK(@act), combo )

   gtk_box_pack_start( GTK_BOX(box), button, 1, 1, 1 )

   ''
   gtk_widget_show( box )
   gtk_widget_show( combo )
   gtk_widget_show( button )
   gtk_widget_show( win )

   gtk_main( )

   end 0
