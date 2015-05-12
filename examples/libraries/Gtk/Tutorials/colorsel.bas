' Colorsel.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011), check also GtkColorButton
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

' Color changed handler
Sub color_changed_cb Cdecl( Byval widget As GtkColorSelection Ptr, Byval drawingarea As GtkWidget Ptr )

    Dim As GdkColor ncolor

    gtk_color_selection_get_current_color (widget, @ncolor)
    gtk_widget_modify_bg (drawingarea, GTK_STATE_NORMAL, @ncolor)

End Sub


' Drawingarea event handler
Function area_event Cdecl( Byval widget As GtkWidget Ptr, Byval event As GdkEvent  Ptr, Byval colorseldlg As GtkWidget Ptr ) As Integer

    ' Check if we've received a button pressed event
    If event->Type <> GDK_BUTTON_PRESS Then RETURN FALSE

    If GTK_RESPONSE_OK = gtk_dialog_run (GTK_DIALOG (colorseldlg)) Then
        Dim As GdkColor color_
        VAR cosedi = GTK_COLOR_SELECTION_DIALOG(colorseldlg)
        VAR cosewi = gtk_color_selection_dialog_get_color_selection(cosedi)
        VAR colorsel = GTK_COLOR_SELECTION(cosewi)
        gtk_color_selection_get_current_color (colorsel, @color_)
        gtk_color_selection_set_previous_color (colorsel, @color_)
        gtk_widget_modify_bg (widget, GTK_STATE_NORMAL, @color_)
    End If

    gtk_widget_hide (colorseldlg)

    return TRUE

End Function


' ==============================================
' Main
' ==============================================
    Dim As GtkWidget Ptr win

    ' Initialize the toolkit, remove gtk-related commandline stuff
    gtk_init (NULL, NULL)

    ' Create color selection dialog
    VAR colorseldlg = gtk_color_selection_dialog_new ("Select background color")

    ' Get the ColorSelection widget
    VAR colseldia = GTK_COLOR_SELECTION_DIALOG(colorseldlg)
    VAR colselwid = gtk_color_selection_dialog_get_color_selection(colseldia)
    VAR colorsel = GTK_COLOR_SELECTION(colselwid)

    Dim As GdkColor val_color
    val_color.red = 0
    val_color.blue = 65535
    val_color.green = 0
    gtk_color_selection_set_previous_color (colorsel, @val_color)
    gtk_color_selection_set_current_color (colorsel, @val_color)
    gtk_color_selection_set_has_palette (colorsel, TRUE)

    ' Create toplevel window, set title and policies
    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
    gtk_window_set_title (GTK_WINDOW (win), "Color selection test")
    gtk_window_set_resizable (GTK_WINDOW (win), TRUE)

    ' Attach to the "delete" and "destroy" events so we can exit
    g_signal_connect (G_OBJECT (win), "delete_event", _
                      G_CALLBACK (@gtk_main_quit), NULL)

    ' Create drawingarea, set size and catch button events
    VAR drawingarea = gtk_drawing_area_new ()

    gtk_widget_modify_bg (drawingarea, GTK_STATE_NORMAL, @val_color)

    gtk_widget_set_size_request (GTK_WIDGET (drawingarea), 200, 200)

    gtk_widget_set_events (drawingarea, GDK_BUTTON_PRESS_MASK)

    g_signal_connect (G_OBJECT (drawingarea), "event", _
                      G_CALLBACK (@area_event), colorseldlg)

    ''Connect to the "color_changed" signal, set the client-data to the colorsel widget
    'g_signal_connect (G_OBJECT (colorsel), "color_changed", _
                      'G_CALLBACK (@color_changed_cb), drawingarea)

    ' Add drawingarea to window, then show them both
    gtk_container_add (GTK_CONTAINER (win), drawingarea)

    gtk_widget_show (drawingarea)
    gtk_widget_show (win)

    ' Enter the gtk main loop (this never returns)
    gtk_main ()

    End 0
