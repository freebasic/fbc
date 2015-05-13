' Fixed.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __FB_GTK3__
#include once "gtk/gtk.bi"

' I'm going to be lazy and use some global variables to
' store the position of the widget within the fixed
' container
Dim Shared As gint x = 50
Dim Shared As gint y = 50

' This callback function moves the button to a new position
' in the Fixed container.
Sub move_button Cdecl( Byval widget As GtkWidget Ptr, Byval fixed As GtkWidget Ptr )
    x = (x + 30) Mod 300
    y = (y + 50) Mod 300
    gtk_fixed_move (GTK_FIXED (fixed), widget, x, y)
End Sub


' ==============================================
' Main
' ==============================================

    ' GtkWidget is the storage type for widgets
    Dim As GtkWidget Ptr win
    Dim As GtkWidget Ptr fixed
    Dim As GtkWidget Ptr button
    Dim As integer i

    ' Initialise GTK
    gtk_init (NULL, NULL )

    ' Create a new window
    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
    gtk_window_set_title (GTK_WINDOW (win), "Fixed Container")

    ' Here we connect the "destroy" event to a signal handler
    g_signal_connect (G_OBJECT (win), "delete-event", _
                      G_CALLBACK (@gtk_main_quit), NULL)

    ' Sets the border width of the window.
    gtk_container_set_border_width (GTK_CONTAINER (win), 10)

    ' Create a Fixed Container
    fixed = gtk_fixed_new ()
    gtk_container_add (GTK_CONTAINER (win), fixed)
    gtk_widget_show (fixed)

    For i = 1 To 3
        ' Creates a new button with the label "Press me"
        button = gtk_button_new_with_label ("Press me")

        ' When the button receives the "clicked" signal, it will call the
        ' function move_button() passing it the Fixed Container as its
        ' argument.
        g_signal_connect (G_OBJECT (button), "clicked", _
                          G_CALLBACK (@move_button), fixed)

        ' This packs the button into the fixed containers window.
        gtk_fixed_put (GTK_FIXED (fixed), button, i * 50, i * 50)

        ' The final step is to display this newly created widget.
        gtk_widget_show (button)
    Next

    ' Display the window
    gtk_widget_show (win)

    ' Enter the event loop
    gtk_main ()
