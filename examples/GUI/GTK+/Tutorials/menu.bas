' Menu.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __FB_GTK3__
#include once "gtk/gtk.bi"

' ============================================
' Funzioni callback
' ============================================

' Respond to a button-press by posting a menu passed in as widget.
'
' Note that the "widget" argument is the menu being posted, NOT
' the button that was pressed.

Function button_press Cdecl( Byval widget As GtkWidget Ptr, Byval event As GdkEvent Ptr ) as integer
    If event->Type = GDK_BUTTON_PRESS Then
        Dim bevent As GdkEventButton Ptr
        bevent = cast(GdkEventButton Ptr, event)
        gtk_menu_popup (GTK_MENU (widget), NULL, NULL, NULL, NULL, bevent->button, bevent->Time)
        ' Tell calling code that we have handled this event; the buck stops here.
        Return TRUE
    Else
        ' Tell calling code that we have not handled this event; pass it on.
        Return FALSE
    End If
End Function


' Print a string when a menu item is selected

Sub menuitem_response Cdecl( Byval stringa As gchar Ptr )
    g_print (!"%s\n", stringa)
End Sub


' ==============================================
' Main
' ==============================================

    Dim As GtkWidget Ptr win
    Dim As GtkWidget Ptr menu
    Dim As GtkWidget Ptr menu_bar
    Dim As GtkWidget Ptr root_menu
    Dim As GtkWidget Ptr menu_items
    Dim As GtkWidget Ptr vbox
    Dim As GtkWidget Ptr button
    Dim As String buf
    Dim As gint i

    gtk_init (NULL, NULL)

    ' create a new window
    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
    gtk_widget_set_size_request (GTK_WIDGET (win), 200, 100)
    gtk_window_set_title (GTK_WINDOW (win), "GTK Menu Test")
    g_signal_connect (G_OBJECT (win), "delete-event", _
                      G_CALLBACK (@gtk_main_quit), NULL)

    ' Init the menu-widget, and remember -- never
    ' gtk_show_widget() the menu widget!!
    ' This is the menu that holds the menu items, the one that
    ' will pop up when you click on the "Root Menu" in the app
    menu = gtk_menu_new ()

    ' Next we make a little loop that makes three menu-entries for "test-menu".
    ' Notice the call to gtk_menu_shell_append.  Here we are adding a list of
    ' menu items to our menu.  Normally, we'd also catch the "clicked"
    ' signal on each of the menu items and setup a callback for it,
    ' but it's omitted here to save space.

    For i = 0 To 2
        ' Copy the names to the buf.
        buf = "Test-undermenu - " + Str(i)

        ' Create a new menu-item with a name...
        menu_items = gtk_menu_item_new_with_label (Strptr(buf))

        ' ...and add it to the menu.
        gtk_menu_shell_append (GTK_MENU_SHELL (menu), menu_items)

        ' Do something interesting when the menuitem is selected
        g_signal_connect_swapped (G_OBJECT (menu_items), "activate", _
                                  G_CALLBACK (@menuitem_response),  g_strdup (buf))

        ' Show the widget
        gtk_widget_show (menu_items)
    Next

    ' This is the root menu, and will be the label
    ' displayed on the menu bar.  There won't be a signal handler attached,
    ' as it only pops up the rest of the menu when pressed.
    root_menu = gtk_menu_item_new_with_label ("Root Menu")

    gtk_widget_show (root_menu)

    ' Now we specify that we want our newly created "menu" to be the menu
    ' for the "root menu"
    gtk_menu_item_set_submenu (GTK_MENU_ITEM (root_menu), menu)

    ' A vbox to put a menu and a button in:
    vbox = gtk_vbox_new (FALSE, 0)
    gtk_container_add (GTK_CONTAINER (win), vbox)
    gtk_widget_show (vbox)

    ' Create a menu-bar to hold the menus and add it to our main window
    menu_bar = gtk_menu_bar_new ()
    gtk_box_pack_start (GTK_BOX (vbox), menu_bar, FALSE, FALSE, 2)
    gtk_widget_show (menu_bar)

    ' Create a button to which to attach menu as a popup
    button = gtk_button_new_with_label ("press me")
    g_signal_connect_swapped (G_OBJECT (button), "event", _
                              G_CALLBACK (@button_press),  G_OBJECT (menu))
    gtk_box_pack_end (GTK_BOX (vbox), button, TRUE, TRUE, 2)
    gtk_widget_show (button)

    ' And finally we append the menu-item to the menu-bar -- this is the
    ' "root" menu-item I have been raving about =)
    gtk_menu_shell_append (GTK_MENU_SHELL (menu_bar), root_menu)

    ' always display the window as the last step so it all splashes on
    ' the screen at once.
    gtk_widget_show (win)

    gtk_main ()

    End 0
