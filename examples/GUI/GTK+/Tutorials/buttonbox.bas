' Buttonbox.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

' Create a Button Box with the specified parameters
Function create_bbox( Byval horizontal As gint, Byval title As Zstring Ptr, Byval spacing As gint, _
        Byval child_w As gint, Byval child_h As gint, Byval layout As gint) As GtkWidget Ptr

    Dim As GtkWidget Ptr frame
    Dim As GtkWidget Ptr bbox
    Dim As GtkWidget Ptr button

    frame = gtk_frame_new (title)

    If horizontal Then
        bbox = gtk_hbutton_box_new ()
    Else
        bbox = gtk_vbutton_box_new ()
    End If

    gtk_container_set_border_width (GTK_CONTAINER (bbox), 5)
    gtk_container_add (GTK_CONTAINER (frame), bbox)

    ' Set the appearance of the Button Box
    gtk_button_box_set_layout (GTK_BUTTON_BOX (bbox), layout)
    gtk_box_set_spacing (GTK_BOX (bbox), spacing)

    g_object_set_data(G_Object (bbox), "child-min-width", @child_w)
    g_object_set_data(G_Object (bbox), "child-min-height", @child_h)

    button = gtk_button_new_from_stock (GTK_STOCK_OK)
    gtk_container_add (GTK_CONTAINER (bbox), button)

    button = gtk_button_new_from_stock (GTK_STOCK_CANCEL)
    gtk_container_add (GTK_CONTAINER (bbox), button)

    button = gtk_button_new_from_stock (GTK_STOCK_HELP)
    gtk_container_add (GTK_CONTAINER (bbox), button)

    Return frame
End Function

' ==============================================
' Main
' ==============================================

    Dim As GtkWidget Ptr win
    Dim As GtkWidget Ptr main_vbox
    Dim As GtkWidget Ptr vbox
    Dim As GtkWidget Ptr hbox
    Dim As GtkWidget Ptr frame_horz
    Dim As GtkWidget Ptr frame_vert

    ' Initialize GTK
    gtk_init (NULL, NULL)

    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
    gtk_window_set_title (GTK_WINDOW (win), "Button Boxes")

    g_signal_connect (G_OBJECT (win), "destroy", _
                      G_CALLBACK (@gtk_main_quit), NULL)

    gtk_container_set_border_width (GTK_CONTAINER (win), 10)

    main_vbox = gtk_vbox_new (FALSE, 0)
    gtk_container_add (GTK_CONTAINER (win), main_vbox)

    frame_horz = gtk_frame_new ("Horizontal Button Boxes")
    gtk_box_pack_start (GTK_BOX (main_vbox), frame_horz, TRUE, TRUE, 10)

    vbox = gtk_vbox_new (FALSE, 0)
    gtk_container_set_border_width (GTK_CONTAINER (vbox), 10)
    gtk_container_add (GTK_CONTAINER (frame_horz), vbox)

    gtk_box_pack_start (GTK_BOX (vbox), create_bbox (TRUE, "Spread (spacing 40)", 40, 85, 20, GTK_BUTTONBOX_SPREAD), TRUE, TRUE, 0)

    gtk_box_pack_start (GTK_BOX (vbox), create_bbox (TRUE, "Edge (spacing 30)", 30, 85, 20, GTK_BUTTONBOX_EDGE), TRUE, TRUE, 5)

    gtk_box_pack_start (GTK_BOX (vbox), create_bbox (TRUE, "Start (spacing 20)", 20, 85, 20, GTK_BUTTONBOX_START), TRUE, TRUE, 5)

    gtk_box_pack_start (GTK_BOX (vbox), create_bbox (TRUE, "End (spacing 10)", 10, 85, 20, GTK_BUTTONBOX_END), TRUE, TRUE, 5)

    frame_vert = gtk_frame_new ("Vertical Button Boxes")
    gtk_box_pack_start (GTK_BOX (main_vbox), frame_vert, TRUE, TRUE, 10)

    hbox = gtk_hbox_new (FALSE, 0)
    gtk_container_set_border_width (GTK_CONTAINER (hbox), 10)
    gtk_container_add (GTK_CONTAINER (frame_vert), hbox)

    gtk_box_pack_start (GTK_BOX (hbox), create_bbox (FALSE, "Spread (spacing 5)", 5, 85, 20, GTK_BUTTONBOX_SPREAD), TRUE, TRUE, 0)

    gtk_box_pack_start (GTK_BOX (hbox), create_bbox (FALSE, "Edge (spacing 30)", 30, 85, 20, GTK_BUTTONBOX_EDGE), TRUE, TRUE, 5)

    gtk_box_pack_start (GTK_BOX (hbox), create_bbox (FALSE, "Start (spacing 20)", 20, 85, 20, GTK_BUTTONBOX_START), TRUE, TRUE, 5)

    gtk_box_pack_start (GTK_BOX (hbox), create_bbox (FALSE, "End (spacing 20)", 20, 85, 20, GTK_BUTTONBOX_END), TRUE, TRUE, 5)

    gtk_widget_show_all (win)

    ' Enter the event loop *
    gtk_main ()
