' Spinbutton.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"
#include once "vbcompat.bi"

Dim Shared As GtkWidget Ptr spinner1

Sub toggle_snap Cdecl(Byval widget As GtkWidget Ptr, Byval spin As GtkSpinButton Ptr)

    VAR active = gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON (widget))
    gtk_spin_button_set_snap_to_ticks (spin, active)

End Sub

Sub toggle_numeric Cdecl(Byval widget As GtkWidget Ptr, Byval spin As GtkSpinButton Ptr)

    VAR active = gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON (widget))
    gtk_spin_button_set_numeric (spin, active)

End Sub

Sub change_digits Cdecl(Byval widget As GtkWidget Ptr, Byval spin As GtkSpinButton Ptr)

    Dim As GtkSpinButton Ptr spin1
    Dim as UInteger n_digits = gtk_spin_button_get_value_as_int (spin)

    gtk_spin_button_set_digits (GTK_SPIN_BUTTON (spinner1), n_digits)

End Sub

Sub get_value Cdecl(Byval widget As GtkWidget Ptr, Byval user_data As gpointer)

    Dim As String buf
    Dim As GtkLabel Ptr label
    Dim As GtkSpinButton Ptr spin
    Dim As String str_format
    Dim As Zstring Ptr param

    param = user_data

    str_format = "###,###,##0"
    spin = GTK_SPIN_BUTTON (spinner1)
    label = GTK_LABEL (g_object_get_data (G_OBJECT (widget), "user_data"))

    If *param = "1" Then
        Dim As Integer val_spin
        val_spin = gtk_spin_button_get_value_as_int (spin)
        buf = format(val_spin, str_format)
    Else
        Dim As Double val_spin_dbl
        Dim As Integer num_digit
        val_spin_dbl = gtk_spin_button_get_value (spin)
        num_digit = gtk_spin_button_get_digits (spin)
        If num_digit > 0 Then
            str_format += "."
            Dim As Integer j
            For j = 1 To num_digit
                str_format += "0"
            Next
        End If
        buf = format(val_spin_dbl, str_format)
    End If
    gtk_label_set_text (label, Strptr(buf))

End Sub


' ==============================================
' Main
' ==============================================

    Dim As GtkWidget Ptr win
    Dim As GtkWidget Ptr frame
    Dim As GtkWidget Ptr hbox
    Dim As GtkWidget Ptr main_vbox
    Dim As GtkWidget Ptr vbox
    Dim As GtkWidget Ptr vbox2
    Dim As GtkWidget Ptr spinner2
    Dim As GtkWidget Ptr spinner
    Dim As GtkWidget Ptr button
    Dim As GtkWidget Ptr label
    Dim As GtkWidget Ptr val_label
    Dim As GtkAdjustment Ptr adj
    Dim As Integer n1

    ' Initialise GTK
    gtk_init (NULL, NULL)

    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)

    g_signal_connect (G_OBJECT (win), "destroy", _
                      G_CALLBACK (@gtk_main_quit), NULL)

    gtk_window_set_title (GTK_WINDOW (win), "Spin Button")

    main_vbox = gtk_vbox_new (FALSE, 5)
    gtk_container_set_border_width (GTK_CONTAINER (main_vbox), 10)
    gtk_container_add (GTK_CONTAINER (win), main_vbox)

    frame = gtk_frame_new ("Not accelerated")
    gtk_box_pack_start (GTK_BOX (main_vbox), frame, TRUE, TRUE, 0)

    vbox = gtk_vbox_new (FALSE, 0)
    gtk_container_set_border_width (GTK_CONTAINER (vbox), 5)
    gtk_container_add (GTK_CONTAINER (frame), vbox)

    ' Day, month, year spinners
    hbox = gtk_hbox_new (FALSE, 0)
    gtk_box_pack_start (GTK_BOX (vbox), hbox, TRUE, TRUE, 5)

    vbox2 = gtk_vbox_new (FALSE, 0)
    gtk_box_pack_start (GTK_BOX (hbox), vbox2, TRUE, TRUE, 5)

    label = gtk_label_new ("Day :")
    gtk_misc_set_alignment (GTK_MISC (label), 0, 0.5)
    gtk_box_pack_start (GTK_BOX (vbox2), label, FALSE, TRUE, 0)

    adj = cast(GtkAdjustment Ptr, _
               gtk_adjustment_new (1.0, 1.0, 31.0, 1.0, 5.0, 0.0))
    spinner = gtk_spin_button_new (adj, 0, 0)
    gtk_spin_button_set_wrap (GTK_SPIN_BUTTON (spinner), TRUE)
    gtk_box_pack_start (GTK_BOX (vbox2), spinner, FALSE, TRUE, 0)

    vbox2 = gtk_vbox_new (FALSE, 0)
    gtk_box_pack_start (GTK_BOX (hbox), vbox2, TRUE, TRUE, 5)

    label = gtk_label_new ("Month :")
    gtk_misc_set_alignment (GTK_MISC (label), 0, 0.5)
    gtk_box_pack_start (GTK_BOX (vbox2), label, FALSE, TRUE, 0)

    adj = cast(GtkAdjustment Ptr, _
               gtk_adjustment_new (1.0, 1.0, 12.0, 1.0, 5.0, 0.0))
    spinner = gtk_spin_button_new (adj, 0, 0)
    gtk_spin_button_set_wrap (GTK_SPIN_BUTTON (spinner), TRUE)
    gtk_box_pack_start (GTK_BOX (vbox2), spinner, FALSE, TRUE, 0)

    vbox2 = gtk_vbox_new (FALSE, 0)
    gtk_box_pack_start (GTK_BOX (hbox), vbox2, TRUE, TRUE, 5)

    label = gtk_label_new ("Year :")
    gtk_misc_set_alignment (GTK_MISC (label), 0, 0.5)
    gtk_box_pack_start (GTK_BOX (vbox2), label, FALSE, TRUE, 0)

    adj = cast(GtkAdjustment Ptr, _
               gtk_adjustment_new (1998.0, 0.0, 2100.0, 1.0, 100.0, 0.0))
    spinner = gtk_spin_button_new (adj, 0, 0)
    gtk_spin_button_set_wrap (GTK_SPIN_BUTTON (spinner), FALSE)
    gtk_widget_set_size_request (spinner, 55, -1)
    gtk_box_pack_start (GTK_BOX (vbox2), spinner, FALSE, TRUE, 0)

    frame = gtk_frame_new ("Accelerated")
    gtk_box_pack_start (GTK_BOX (main_vbox), frame, TRUE, TRUE, 0)

    vbox = gtk_vbox_new (FALSE, 0)
    gtk_container_set_border_width (GTK_CONTAINER (vbox), 5)
    gtk_container_add (GTK_CONTAINER (frame), vbox)

    hbox = gtk_hbox_new (FALSE, 0)
    gtk_box_pack_start (GTK_BOX (vbox), hbox, FALSE, TRUE, 5)

    vbox2 = gtk_vbox_new (FALSE, 0)
    gtk_box_pack_start (GTK_BOX (hbox), vbox2, TRUE, TRUE, 5)

    label = gtk_label_new ("Value :")
    gtk_misc_set_alignment (GTK_MISC (label), 0, 0.5)
    gtk_box_pack_start (GTK_BOX (vbox2), label, FALSE, TRUE, 0)

    adj = cast(GtkAdjustment Ptr, _
               gtk_adjustment_new (0.0, -10000.0, 10000.0, 0.5, 100.0, 0.0))
    spinner1 = gtk_spin_button_new (adj, 1.0, 2)
    gtk_spin_button_set_wrap (GTK_SPIN_BUTTON (spinner1), TRUE)
    gtk_widget_set_size_request (spinner1, 100, -1)
    gtk_box_pack_start (GTK_BOX (vbox2), spinner1, FALSE, TRUE, 0)

    vbox2 = gtk_vbox_new (FALSE, 0)
    gtk_box_pack_start (GTK_BOX (hbox), vbox2, TRUE, TRUE, 5)

    label = gtk_label_new ("Digits :")
    gtk_misc_set_alignment (GTK_MISC (label), 0, 0.5)
    gtk_box_pack_start (GTK_BOX (vbox2), label, FALSE, TRUE, 0)

    adj = cast(GtkAdjustment Ptr, gtk_adjustment_new (2, 1, 5, 1, 1, 0))
    spinner2 = gtk_spin_button_new (adj, 0.0, 0)
    gtk_spin_button_set_wrap (GTK_SPIN_BUTTON (spinner2), TRUE)
    g_signal_connect (G_OBJECT (adj), "value_changed", _
                      G_CALLBACK (@change_digits), cast(gpointer, spinner2))
    gtk_box_pack_start (GTK_BOX (vbox2), spinner2, FALSE, TRUE, 0)

    hbox = gtk_hbox_new (FALSE, 0)
    gtk_box_pack_start (GTK_BOX (vbox), hbox, FALSE, TRUE, 5)

    button = gtk_check_button_new_with_label ("Snap to 0.5-ticks")
    g_signal_connect (G_OBJECT (button), "clicked", _
                      G_CALLBACK (@toggle_snap), spinner1)
    gtk_box_pack_start (GTK_BOX (vbox), button, TRUE, TRUE, 0)
    gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (button), TRUE)

    button = gtk_check_button_new_with_label ("Numeric only input mode")
    g_signal_connect (G_OBJECT (button), "clicked", _
                      G_CALLBACK (@toggle_numeric), spinner1)
    gtk_box_pack_start (GTK_BOX (vbox), button, TRUE, TRUE, 0)
    gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (button), TRUE)

    val_label = gtk_label_new ("")

    hbox = gtk_hbox_new (FALSE, 0)
    gtk_box_pack_start (GTK_BOX (vbox), hbox, FALSE, TRUE, 5)
    button = gtk_button_new_with_label ("Value as Int")
    g_object_set_data (G_OBJECT (button), "user_data", val_label)
    g_signal_connect (G_OBJECT (button), "clicked", _
                      G_CALLBACK (@get_value), Strptr("1"))
    gtk_box_pack_start (GTK_BOX (hbox), button, TRUE, TRUE, 5)

    button = gtk_button_new_with_label ("Value as Float")
    g_object_set_data (G_OBJECT (button), "user_data", val_label)
    g_signal_connect (G_OBJECT (button), "clicked", _
                      G_CALLBACK (@get_value), Strptr("2"))
    gtk_box_pack_start (GTK_BOX (hbox), button, TRUE, TRUE, 5)

    gtk_box_pack_start (GTK_BOX (vbox), val_label, TRUE, TRUE, 0)
    gtk_label_set_text (GTK_LABEL (val_label), "0")

    hbox = gtk_hbox_new (FALSE, 0)
    gtk_box_pack_start (GTK_BOX (main_vbox), hbox, FALSE, TRUE, 0)

    button = gtk_button_new_with_label ("Close")
    g_signal_connect (G_OBJECT (button), "clicked", _
                      G_CALLBACK (@gtk_main_quit), NULL)
    gtk_box_pack_start (GTK_BOX (hbox), button, TRUE, TRUE, 5)

    gtk_widget_show_all (win)

    ' Enter the event loop
    gtk_main ()

    End 0

