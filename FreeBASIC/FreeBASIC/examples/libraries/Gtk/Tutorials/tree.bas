' Text.bas
' Translated from C to FB by TinyCla, 2006

#include once "gtk/gtk.bi"

#define NULL 0
#define GTK_ENABLE_BROKEN 1

' for all the GtkItem:: and GtkTreeItem:: signals 
Sub cb_itemsignal Cdecl (Byval item As GtkWidget Ptr, Byval signame As Zstring Ptr )

	Dim As Zstring Ptr s_name
	Dim As GtkLabel Ptr label

	' It's a Bin, so it has one child, which we know to be a
	' label, so get that 
	label = GTK_LABEL (GTK_BIN (item)->child)
	' Get the text of the label 
	gtk_label_get (label, @s_name)
	' Get the level of the tree which the item is in 
	g_print (!"%s called for item %s->%p, level %d\n", signame, s_name, item, GTK_TREE (item->parent)->level)
    
End Sub

' Note that this is never called 
Sub cb_unselect_child Cdecl (Byval root_tree As GtkWidget Ptr, Byval child As GtkWidget Ptr, Byval subtree As GtkWidget Ptr)
    
	g_print (!"unselect_child called for root tree %p, subtree %p, child %p\n", root_tree, subtree, child)
    
End Sub

' Note that this is called every time the user clicks on an item,
' whether it is already selected or not. 
Sub cb_select_child Cdecl (Byval  root_tree As GtkWidget Ptr, Byval child As GtkWidget Ptr, Byval subtree As GtkWidget Ptr)
    
	g_print (!"select_child called for root tree %p, subtree %p, child %p\n", root_tree, subtree, child)
    
End Sub

Sub cb_selection_changed Cdecl(Byval tree As GtkTree Ptr)

	Dim As GList Ptr i

	g_print (!"selection_change called for tree %p\n", tree)
	g_print (!"selected objects are:\n")

	'i = GTK_TREE_SELECTION_OLD (cast(GtkTree ptr, tree))
	i = tree->selection
	
	While (i) 
		Dim As Zstring Ptr s_name
		Dim As GtkLabel Ptr label
		Dim As GtkWidget Ptr item

		' Get a GtkWidget pointer from the list node 
		item = GTK_WIDGET (i->Data)
		label = GTK_LABEL (GTK_BIN (item)->child)
		gtk_label_get (label, @s_name)
		g_print (!"\t%s on level %d\n", s_name, GTK_TREE (item->parent)->level)
		i = i->Next
	Wend
End Sub


' ==============================================
' Main
' ==============================================

	Dim As GtkWidget Ptr win
	Dim As GtkWidget Ptr scrolled_win
	Dim As GtkWidget Ptr tree
	
	Dim As Zstring Ptr itemnames(0 To 4) => {@"Foo", @"Bar", @"Baz", @"Quux", @"Maurice"}
	Dim As Integer i
	
	gtk_init (NULL, NULL)
	
	' a generic toplevel window 
	win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
	gtk_window_set_title ( GTK_WINDOW( win ), "Tree" )
	g_signal_connect (G_OBJECT (win), "delete_event", G_CALLBACK (@gtk_main_quit), NULL)
	gtk_container_set_border_width (GTK_CONTAINER (win), 5)
	
	' A generic scrolled window 
	scrolled_win = gtk_scrolled_window_new (NULL, NULL)
	gtk_scrolled_window_set_policy (GTK_SCROLLED_WINDOW (scrolled_win), GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC)
	gtk_widget_set_size_request (scrolled_win, 150, 200)
	gtk_container_add (GTK_CONTAINER (win), scrolled_win)
	gtk_widget_show (scrolled_win)
	
	' Create the root tree 
	tree = gtk_tree_new ()
	g_print (!"root tree is %p\n", tree)
	' connect all GtkTree:: signals 
	g_signal_connect (G_OBJECT (tree), "select_child", G_CALLBACK (@cb_select_child), tree)
	g_signal_connect (G_OBJECT (tree), "unselect_child", G_CALLBACK (@cb_unselect_child), tree)
	g_signal_connect (G_OBJECT(tree), "selection_changed", G_CALLBACK(@cb_selection_changed), tree)
	' Add it to the scrolled window 
	gtk_scrolled_window_add_with_viewport (GTK_SCROLLED_WINDOW (scrolled_win), tree)
	' Set the selection mode 
	gtk_tree_set_selection_mode (GTK_TREE (tree), GTK_SELECTION_MULTIPLE)
	' Show it 
	gtk_widget_show (tree)
	
	For i = 0 To 4
		Dim As GtkWidget Ptr subtree
		Dim As GtkWidget Ptr item
		Dim As gint j
		Dim As Zstring Ptr buffer(4) => { @"select", @"deselect", @"toggle", @"expand", @"collapse" }
	
		' Create a tree item 
		item = gtk_tree_item_new_with_label (cast(gchar Ptr, itemnames(i)))
		' Connect all GtkItem:: and GtkTreeItem:: signals 
		g_signal_connect (G_OBJECT (item), "select", G_CALLBACK (@cb_itemsignal), buffer(0))
		g_signal_connect (G_OBJECT (item), "deselect", G_CALLBACK (@cb_itemsignal), buffer(1))
		g_signal_connect (G_OBJECT (item), "toggle", G_CALLBACK (@cb_itemsignal), buffer(2))
		g_signal_connect (G_OBJECT (item), "expand", G_CALLBACK (@cb_itemsignal), buffer(3))
		g_signal_connect (G_OBJECT (item), "collapse", G_CALLBACK (@cb_itemsignal), buffer(4))
		' Add it to the parent tree 
		gtk_tree_append (GTK_TREE (tree), item)
		' Show it - this can be done at any time 
		gtk_widget_show (item)
		' Create this item's subtree 
		subtree = gtk_tree_new ()
		g_print (!"-> item %s->%p, subtree %p\n", itemnames(i), item, subtree)
	
		' This is still necessary if you want these signals to be called
	       ' for the subtree's children.  Note that selection_change will be 
	       ' signalled for the root tree regardless. 
		g_signal_connect (G_OBJECT (subtree), "select_child", G_CALLBACK (@cb_select_child), subtree)
		g_signal_connect (G_OBJECT (subtree), "unselect_child", G_CALLBACK (@cb_unselect_child), subtree)
		' This has absolutely no effect, because it is completely ignored  in subtrees 
		gtk_tree_set_selection_mode (GTK_TREE (subtree), GTK_SELECTION_SINGLE)
		' Neither does this, but for a rather different reason - the
		' view_mode and view_line values of a tree are propagated to
		' subtrees when they are mapped.  So, setting it later on would
		' actually have a (somewhat unpredictable) effect 
		gtk_tree_set_view_mode (GTK_TREE (subtree), GTK_TREE_VIEW_ITEM)
		' Set this item's subtree - note that you cannot do this until
		' AFTER the item has been added to its parent tree! 
		gtk_tree_item_set_subtree (GTK_TREE_ITEM (item), subtree)
	
		For j = 0 To 4
			Dim As GtkWidget Ptr subitem
	
			' Create a subtree item, in much the same way 
			subitem = gtk_tree_item_new_with_label (itemnames(j))
			' Connect all GtkItem:: and GtkTreeItem:: signals 
			g_signal_connect (G_OBJECT (subitem), "select", G_CALLBACK (@cb_itemsignal), buffer(0))
			g_signal_connect (G_OBJECT (subitem), "deselect", G_CALLBACK (@cb_itemsignal), buffer(1))
			g_signal_connect (G_OBJECT (subitem), "toggle", G_CALLBACK (@cb_itemsignal), buffer(2))
			g_signal_connect (G_OBJECT (subitem), "expand", G_CALLBACK (@cb_itemsignal), buffer(3))
			g_signal_connect (G_OBJECT (subitem), "collapse", G_CALLBACK (@cb_itemsignal), buffer(4))
			g_print (!"-> -> item %s->%p\n", itemnames(j), subitem)
			' Add it to its parent tree 
			gtk_tree_append (GTK_TREE (subtree), subitem)
			' Show it 
			gtk_widget_show (subitem)
		Next
	Next
	
	' Show the window and loop endlessly 
	gtk_widget_show (win)
	
	gtk_main()
	
	End 0
