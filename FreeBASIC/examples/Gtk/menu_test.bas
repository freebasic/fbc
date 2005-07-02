option explicit
#include once "gtk/gtk.bi"

#define NULL 0	

declare function button_press cdecl ( byval widget as GtkWidget ptr, byval event as GdkEvent ptr ) as gint 
declare sub menuitem_response cdecl (byval s as zstring ptr )

 	dim as GtkWidget ptr win
    dim as GtkWidget ptr menu
    dim as GtkWidget ptr menu_bar
    dim as GtkWidget ptr root_menu
    dim as GtkWidget ptr menu_items
    dim as GtkWidget ptr vbox
    dim as GtkWidget ptr button
    dim as zstring * 128 buf 
    dim as integer i

    gtk_init( NULL, NULL )

    '' create a new window
    win = gtk_window_new( GTK_WINDOW_TOPLEVEL)
    gtk_widget_set_usize( win, 200, 100 )
    gtk_window_set_title( win, "GTK Menu Test" )
    gtk_signal_connect( win , "delete_event", @gtk_main_quit, NULL )

    '' Init the menu-widget, and remember -- never
    '' gtk_show_widget() the menu widget!! 
    '' This is the menu that holds the menu items, the one that
    '' will pop up when you click on the "Root Menu" in the app
    menu = gtk_menu_new( )

    '' Next we make a little loop that makes three menu-entries for "test-menu".
    '' Notice the call to gtk_menu_append.  Here we are adding a list of
    '' menu items to our menu.  Normally, we'd also catch the "clicked"
    '' signal on each of the menu items and setup a callback for it,
    '' but it's omitted here to save space.

    for i = 0 to 2
		'' Copy the names to the buf.
        buf = "Test-undermenu - " + str$( i )

        '' Create a new menu-item with a name...
        menu_items = gtk_menu_item_new_with_label(buf)

        '' ...and add it to the menu.
        gtk_menu_append( menu, menu_items )

        '' Do something interesting when the menuitem is selected
        gtk_signal_connect_object( menu_items, "activate", @menuitem_response, g_strdup( buf ) )

        '' Show the widget
        gtk_widget_show( menu_items )
    next

    '' This is the root menu, and will be the label
    '' displayed on the menu bar.  There won't be a signal handler attached,
    '' as it only pops up the rest of the menu when pressed.
    root_menu = gtk_menu_item_new_with_label( "Root Menu" )

    gtk_widget_show( root_menu )

    '' Now we specify that we want our newly created "menu" to be the menu
    '' for the "root menu"
    gtk_menu_item_set_submenu( root_menu, menu )

    '' A vbox to put a menu and a button in:
    vbox = gtk_vbox_new( FALSE, 0 )
    gtk_container_add( win, vbox )
    gtk_widget_show( vbox )

    '' Create a menu-bar to hold the menus and add it to our main win
    menu_bar = gtk_menu_bar_new( )
    gtk_box_pack_start( vbox, menu_bar, FALSE, FALSE, 2 )
    gtk_widget_show( menu_bar )

    '' Create a button to which to attach menu as a popup
    button = gtk_button_new_with_label( "press me" )
    gtk_signal_connect_object( button, "event", @button_press, menu )
    gtk_box_pack_end( vbox, button, TRUE, TRUE, 2 )
    gtk_widget_show( button )

    '' And finally we append the menu-item to the menu-bar -- this is the
    '' "root" menu-item I have been raving about =)
    gtk_menu_bar_append( menu_bar, root_menu )

    '' always display the win as the last step so it all splashes on
    '' the screen at once.
    gtk_widget_show( win )

    gtk_main( )

	end 0

'':::::
'' Respond to a button-press by posting a menu passed in as widget.
''
'' Note that the "widget" argument is the menu being posted, NOT
'' the button that was pressed.
''
function button_press cdecl ( byval widget as GtkWidget ptr, byval event as GdkEvent ptr ) as gint 
    
    if( event->type = GDK_BUTTON_PRESS ) then
        gtk_menu_popup( widget, NULL, NULL, NULL, NULL, _
        				cptr(GdkEventButton ptr, event)->button, cptr(GdkEventButton ptr, event)->time )
        '' Tell calling code that we have handled this event the buck
        '' stops here.
        return TRUE
    end if

    '' Tell calling code that we have not handled this event pass it on.
    return FALSE
end function

'':::::
'' Print a string when a menu item is selected
''
sub menuitem_response cdecl (byval s as zstring ptr )
    print *s
end sub
