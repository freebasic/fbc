#include once "IUP/iup.bi"
const NULL = 0
const NEWLINE = !"\n"

function on_click_ok cdecl(byval handler as Ihandle ptr) as long
	var dialog = IupGetHandle("dialog")
	var textbox = IupGetHandle("textbox")
	var label = IupGetHandle("label")

	var text = *IupGetAttribute(textbox, IUP_VALUE)

	print "OK clicked! content of textbox: <" + text + ">"

	IupSetStrAttribute(label, IUP_TITLE, _
		"Thanks. You entered <" + text + ">." + NEWLINE + _
		"val() result: " & val(text) & ". " + NEWLINE + _
		"IupGetInt() result: " & IupGetInt(textbox, IUP_VALUE) & "." + NEWLINE + _
		"IupGetFloat() result: " & IupGetFloat(textbox, IUP_VALUE) & "." _
	)

	'' Recalculate the window layout. Since we changed the label text, it
	'' may require more space. This may require us to even increase the
	'' entire dialog's size to make room for the bigger label. According to
	'' IUP documentation doing this requires setting the SIZE attribute of
	'' the dialog, then call IupRefresh() on it. I'm not 100% sure whether
	'' this is the right/best way to do it.
	IupSetAttribute(dialog, IUP_SIZE, NULL)
	IupRefresh(dialog)

	function = IUP_DEFAULT
end function

IupOpen(NULL, NULL)

'' Create a window with a text box, ok button, and a label
var textbox = IupText(NULL)
var okbutton = IupButton("OK", "on_click_ok")
var label = IupLabel("Hello! Enter some text and click OK.")
var vbox = IupVbox(textbox, okbutton, label, NULL)
var dialog = IupDialog(vbox)

'' Window title
IupSetAttribute(dialog, IUP_TITLE, "Text box example")

'' Make text box accept numbers only (instead of arbitrary text)
'' According to the IUP documentation, the IupText() control accepts a FILTER
'' attribute on Windows, which can have the values LOWERCASE, UPPERCASE or NUMBER.
'' Thus FLOAT does not seem to be valid!?
'IupSetAttribute(textbox, IUP_FILTER, "FLOAT")
'' However, NUMBER does not disallow letters to be entered on Windows XP either...
'IupSetAttribute(textbox, IUP_FILTER, "NUMBER")

'' Adjust layout a little bit
IupSetAttribute(textbox, IUP_EXPAND, "YES")
IupSetAttribute(okbutton, IUP_EXPAND, "YES")
IupSetAttribute(label, IUP_EXPAND, "YES")
IupSetAttribute(vbox, IUP_GAP, "4")
IupSetAttribute(vbox, IUP_ALIGNMENT, "ACENTER")
IupSetAttribute(vbox, IUP_MARGIN, "4x4")

'' Set callbacks and handles
IupSetFunction("on_click_ok", @on_click_ok)
IupSetHandle("dialog", dialog)
IupSetHandle("textbox", textbox)
IupSetHandle("label", label)

'' Show window and run main loop
IupShow(dialog)
IupMainLoop()
IupClose()
