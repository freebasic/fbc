''
'' combo box example, translated from an C example written by Özcan Güngör
''


#include once "gtk/gtk.bi"

#define NULL 0

'':::::
sub act cdecl (byval widget as GtkWidget ptr, byval _data as gpointer ptr)
   '' Print the selected combo item to console
   g_print( _data )
end sub

   dim as GtkWidget ptr win
   dim as GtkWidget ptr combo
   dim as GtkWidget ptr button
   dim as GtkWidget ptr box
   dim as GList ptr list = NULL

   list = g_list_append( list, strptr( "Slackware" ) )
   list = g_list_append( list, strptr( "RedHat" ) )
   list = g_list_append( list, strptr( "SuSE" ) )

   gtk_init( 0, NULL )

   '' Create a new window
   win = gtk_window_new( GTK_WINDOW_TOPLEVEL )
   gtk_window_set_title( GTK_WINDOW(win), "Combo Box" )

   '' Connect destroy event to the window.
   gtk_signal_connect( GTK_OBJECT(win), "destroy", GTK_SIGNAL_FUNC(@gtk_main_quit), NULL )

   '' Create a new horizontal box
   box = gtk_hbox_new( 1, 0 )
   gtk_container_add( GTK_CONTAINER(win), box )

   '' Creates a combo box
   combo = gtk_combo_new( )

   '' Sets the list
   gtk_combo_set_popdown_strings( GTK_COMBO(combo), list )

   '' Enables up/down keys change the value.
   gtk_combo_set_use_arrows_always( GTK_COMBO(combo), 1 )

   gtk_box_pack_start( GTK_BOX(box), combo, 1, 1, 1 )

   button = gtk_button_new_with_label("Write it")
   
   gtk_signal_connect( GTK_OBJECT(button), "clicked", GTK_SIGNAL_FUNC(@act), _
   					   gtk_entry_get_text( GTK_ENTRY(GTK_COMBO(combo)->entry) ) )
   
   gtk_box_pack_start( GTK_BOX(box), button, 1, 1, 1 )

   '' 
   gtk_widget_show( box )
   gtk_widget_show( combo )
   gtk_widget_show( button )
   gtk_widget_show( win )

   gtk_main( )
   
   end 0
