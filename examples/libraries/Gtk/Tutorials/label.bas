' Label.bas
' Translated from C to FB by TinyCla, 2006
'
' Reviewed by TJF (2011)
' Details: http://developer.gnome.org/gtk/

'#DEFINE __USE_GTK3__
#include once "gtk/gtk.bi"

' ==============================================
' Main
' ==============================================

    Dim As GtkWidget Ptr win
    Dim As GtkWidget Ptr hbox
    Dim As GtkWidget Ptr vbox
    Dim As GtkWidget Ptr frame
    Dim As GtkWidget Ptr label
    Dim As Zstring * 1024  buffer

    ' Initialise GTK
    gtk_init (NULL, NULL)

    win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
    g_signal_connect (G_OBJECT (win), "delete-event", _
                      G_CALLBACK (@gtk_main_quit), NULL)

    gtk_window_set_title (GTK_WINDOW (win), "Label")
    vbox = gtk_vbox_new (FALSE, 5)
    hbox = gtk_hbox_new (FALSE, 5)
    gtk_container_add (GTK_CONTAINER (win), hbox)
    gtk_box_pack_start (GTK_BOX (hbox), vbox, FALSE, FALSE, 0)
    gtk_container_set_border_width (GTK_CONTAINER (win), 5)

    frame = gtk_frame_new ("Normal Label")
    label = gtk_label_new ("This is a Normal label")
    gtk_container_add (GTK_CONTAINER (frame), label)
    gtk_box_pack_start (GTK_BOX (vbox), frame, FALSE, FALSE, 0)

    frame = gtk_frame_new ("Multi-line Label")
    label = gtk_label_new (!"This is a Multi-line label.\nSecond line\nThird line")
    gtk_container_add (GTK_CONTAINER (frame), label)
    gtk_box_pack_start (GTK_BOX (vbox), frame, FALSE, FALSE, 0)

    frame = gtk_frame_new ("Left Justified Label")
    label = gtk_label_new (!"This is a Left-Justified\\nMulti-line label.\nThird      line")
    gtk_label_set_justify (GTK_LABEL (label), GTK_JUSTIFY_LEFT)
    gtk_container_add (GTK_CONTAINER (frame), label)
    gtk_box_pack_start (GTK_BOX (vbox), frame, FALSE, FALSE, 0)

    frame = gtk_frame_new ("Right Justified Label")
    label = gtk_label_new (!"This is a Right-Justified\nMulti-line label.\nFourth line, (j/k)")
    gtk_label_set_justify (GTK_LABEL (label), GTK_JUSTIFY_RIGHT)
    gtk_container_add (GTK_CONTAINER (frame), label)
    gtk_box_pack_start (GTK_BOX (vbox), frame, FALSE, FALSE, 0)

    vbox = gtk_vbox_new (FALSE, 5)
    gtk_box_pack_start (GTK_BOX (hbox), vbox, FALSE, FALSE, 0)
    frame = gtk_frame_new ("Line wrapped label")
    buffer = "This is an example of a line-wrapped label.  It should not be taking up the entire             "
    buffer += "width allocated to it, but automatically "
    buffer += "wraps the words to fit.  "
    buffer += "The time has come, for all good men, to come to "
    buffer += "the aid of their party.  "
    buffer += !"The sixth sheik's six sheep's sick.\n"
    buffer += "     It supports multiple paragraphs correctly, "
    buffer += "and  correctly   adds "
    buffer += "many          extra  spaces. "

    label = gtk_label_new (buffer)
    gtk_label_set_line_wrap (GTK_LABEL (label), TRUE)
    gtk_container_add (GTK_CONTAINER (frame), label)
    gtk_box_pack_start (GTK_BOX (vbox), frame, FALSE, FALSE, 0)

    frame = gtk_frame_new ("Filled, wrapped label")
    buffer = "This is an example of a line-wrapped, filled label.  "
    buffer += "It should be taking "
    buffer += "up the entire              width allocated to it.  "
    buffer += "Here is a sentence to prove "
    buffer += "my point.  Here is another sentence. "
    buffer += !"Here comes the sun, do de do de do.\n"
    buffer += !"    This is a new paragraph.\n"
    buffer += "    This is another newer, longer, better "
    buffer += "paragraph.  It is coming to an end, "
    buffer += "unfortunately."
    label = gtk_label_new (buffer)
    gtk_label_set_justify (GTK_LABEL (label), GTK_JUSTIFY_FILL)
    gtk_label_set_line_wrap (GTK_LABEL (label), TRUE)
    gtk_container_add (GTK_CONTAINER (frame), label)
    gtk_box_pack_start (GTK_BOX (vbox), frame, FALSE, FALSE, 0)

    frame = gtk_frame_new ("Underlined label")
    label = gtk_label_new (!"This label is underlined!\nThis one is underlined in quite a funky fashion")
    gtk_label_set_justify (GTK_LABEL (label), GTK_JUSTIFY_LEFT)
    gtk_label_set_pattern (GTK_LABEL (label), "_________________________ _ _________ _ ______     __ _______ ___")
    gtk_container_add (GTK_CONTAINER (frame), label)
    gtk_box_pack_start (GTK_BOX (vbox), frame, FALSE, FALSE, 0)

    gtk_widget_show_all (win)

    gtk_main ()
