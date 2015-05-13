#include once "pdflib.bi"

dim as PDF ptr p
dim as integer font, textx, texty, x, y, w, h, fontsize, c, image
dim as string text

p = PDF_new()
'' open new PDF file
if (PDF_open_file(p, "pdflib_test.pdf") = -1) then
	print "Error: could not open PDF file. Check to see if it is open by another application"
	print "Press any key to end..."  '' pause to allow error message to be read
	sleep
	end 1
end if

'' some document information
PDF_set_info(p, "Creator", "pdflib_test.bas")
PDF_set_info(p, "Author", "GOK")
PDF_set_info(p, "Title", "FreeBASIC")

'' start a new page, set font and size
PDF_begin_page(p, a4_width, a4_height)
font = PDF_findfont(p, "Helvetica-Bold", "host", 0)
PDF_setfont(p, font, 12)

'' Insert the logo
dim as string logofilename = exepath() & "/../../fblogo.gif"
image = PDF_open_image_file(p, "gif", logofilename, "", 0)
if image = -1  then
	print "Error: Couldn't read image file """ & logofilename & """"
else
	w = PDF_get_value(p, "imagewidth", image)
	h = PDF_get_value(p, "imageheight", image)
	PDF_place_image(p, image, (a4_width - w)/2, a4_height-h-50, 1)
	'' Note: only close the image when you are finished with it. Keep it in
	'' memory if you plan on reusing it.
	PDF_close_image(p, image)
end if

'' line drawing test
PDF_moveto(p, 25, a4_height-50 - h)
PDF_lineto(p, a4_width-50, a4_height-50 - h)
PDF_stroke(p)

'' some output
texty = a4_height-50 - h -50                              '' Move down from line by 50
PDF_set_text_pos(p, 50, texty)
PDF_show(p, "This is horizontal text in Helvetica-Bold")  '' output text

textx = PDF_get_value(p, "textx", 0)                      '' determine text position
texty = PDF_get_value(p, "texty", 0)                      '' determine text position

'' save state
PDF_save(p)
PDF_translate(p, textx, texty)                            '' move origin to end of text

'' change coordinate system
PDF_rotate(p, -90)                                        '' rotate coordinates
PDF_set_text_pos(p, 30, 100)                              '' provide for distance from horiz. text
PDF_show(p, "vertical text")

'' restore saved state
PDF_restore(p)

PDF_continue_text(p, "horizontal text continues")

'' text in red
PDF_save(p)
PDF_set_text_pos(p, 50, 440)
PDF_setcolor(p, "both", "rgb", 1, 0, 0, 0)
PDF_show(p, "Write some text in a box (Courier 10 - left justified)")
PDF_restore(p)

'' Print in a box
text = "PDF Viewers support a set of 14 core fonts which need not be embedded in any PDF file. They are:" + chr(10) + chr(13) + _
	"Courier, Courier-Bold, Courier-Oblique, Courier-BoldOblique, Helvetica, Helvetica-Bold, Helvetica-Oblique, " + _
	"Helvetica-BoldOblique, Times-Roman, Times-Bold, Times-Italic, Times-BoldItalic, Symbol & ZapfDingbats"

fontsize = 10
font = PDF_findfont(p, "Courier", "host", 0)
PDF_setfont(p, font, fontsize)
x = 50
y = 350
w = 500
h = 7 * fontsize
c = PDF_show_boxed(p, text, x, y, w, h, "left", "")
if (c > 0 ) then
	'' C = number of characters truncated (0 means a fit)
	print "Not all characters could be placed in the box"
end if

'' draw a box around text
PDF_rect(p, x-2, y-2, w+4, h+4)
PDF_stroke(p)

'' tidy up
PDF_end_page(p)                                           '' close page
PDF_close(p)                                              '' close PDF document
PDF_delete(p)                                             '' delete the PDF "object"

print "Press any key to continue..."                      '' pause to allow error message to be read
sleep
