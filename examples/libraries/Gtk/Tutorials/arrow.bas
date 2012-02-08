' Arrow.bas
' translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

' Create an Arrow widget with the specified parameters
' and pack it into a button
Function create_arrow_button( Byval arrow_type As GtkArrowType, Byval shadow_type As GtkShadowType ) As GtkWidget Ptr

    Dim button As GtkWidget Ptr
    Dim arrow As GtkWidget Ptr

    button = gtk_button_new ()
    arrow = gtk_arrow_new (arrow_type, shadow_type)

    gtk_container_add (GTK_CONTAINER (button), arrow)

    gtk_widget_show (button)
    gtk_widget_show (arrow)

    Return button
End Function

' ==============================================
' Main
' ==============================================

    ' GtkWidget is the storage type for widgets
    Dim As GtkWidget Ptr win
    Dim As GtkWidget Ptr button
    Dim As GtkWidget Ptr box

    ' Initialize the toolkit
    gtk_init (NULL, NULL)

    '* Create a new window
    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)

    gtk_window_set_title (GTK_WINDOW (win), "Arrow Buttons")

    ' It's a good idea to do this for all windows.
    g_signal_connect (G_OBJECT (win), "destroy", _
                      G_CALLBACK (@gtk_main_quit), NULL)

    ' Sets the border width of the window.
    gtk_container_set_border_width (GTK_CONTAINER (win), 10)

    ' Create a box to hold the arrows/buttons
    box = gtk_hbox_new (FALSE, 0)
    gtk_container_set_border_width (GTK_CONTAINER (box), 2)
    gtk_container_add (GTK_CONTAINER (win), box)

    ' Pack and show all our widgets
    gtk_widget_show (box)

    button = create_arrow_button (GTK_ARROW_UP, GTK_SHADOW_IN)
    gtk_box_pack_start (GTK_BOX (box), button, FALSE, FALSE, 3)

    button = create_arrow_button (GTK_ARROW_DOWN, GTK_SHADOW_OUT)
    gtk_box_pack_start (GTK_BOX (box), button, FALSE, FALSE, 3)

    button = create_arrow_button (GTK_ARROW_LEFT, GTK_SHADOW_ETCHED_IN)
    gtk_box_pack_start (GTK_BOX (box), button, FALSE, FALSE, 3)

    button = create_arrow_button (GTK_ARROW_RIGHT, GTK_SHADOW_ETCHED_OUT)
    gtk_box_pack_start (GTK_BOX (box), button, FALSE, FALSE, 3)

    gtk_widget_show (win)

    ' Rest in gtk_main and wait for the fun to begin!
    gtk_main ()
