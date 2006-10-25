SafeHTML
--------
Version 1.2.0.
http://pixel-apes.com/safehtml
--------

This parser strips down all potentially dangerous content within HTML:
  * opening tag without its closing tag
  * closing tag without its opening tag
  * any of these tags: "base", "basefont", "head", "html", "body", "applet", "object", 
    "iframe", "frame", "frameset", "script", "layer", "ilayer", "embed", "bgsound", 
    "link", "meta", "style", "title", "blink", "xml" etc.
  * any of these attributes: on*, data*, dynsrc
  * javascript:/vbscript:/about: etc. protocols
  * expression/behavior etc. in styles
  * any other active content
It also tries to convert code to XHTML valid, but htmltidy is far better solution for this task.

If you found any bugs in this parser, please inform me -- ICQ:551593 or mailto:thingol@mail.ru

Please, subscribe to http://pixel-apes.com/safehtml/feed/rss feed in order to receive notices 
when SAFEHTML will be updated.

-- Roman Ivanov.
-- Pixel-Apes ( http://pixel-apes.com ).
-- JetStyle ( http://jetstyle.ru/ ).



--------
Version history:
--------
1.2.0.
 * "id" and "name" attributes added to dangerous attributes list, because malefactor can broke legal javascript by spoofing ID or NAME of some element.
 * New method parse() allows to do all parsing process in two lines of code. Examples also updated.
 * New array, closeParagraph, contains list of block-level elements. When we open such elemet, we should close paragraph before. . It allows SafeHTML to produce more XHTML compliant code.
 * Added "webcal" to white list of protocols for those who uses calendar programs (Mozilla/iCal/etc).
 * Now SafeHTML strips down table elements when we are not inside table.
 * Now SafeHTML correctly closes unclosed "li" tags: before opening "li" of the same nesting level.
1.1.0.
 * New "dangerous" protocols: hcp, ms-help, help, disk, vnd.ms.radio, opera, res, resource, chrome, mocha, livescript.
 * <XML> tag was moved from "tags for deletion" to "tags for deletion with content".
 * New "dangerous" CSS instruction "include-source" (NN4 specific).
 * New array, Attributes, contains list of attributes for removal. If you need to remove "id" or "name" attribute, 
 just add it to this array.
 * Now it is possible to choose between white-list and black-list filtering of protocols. Defaults are "white-list".
 This list is: "http", "https", "ftp", "telnet", "news", "nntp", "gopher", "mailto", "file".
 * For speed purposes, we now filter protocols only from these attributes: src, href, action, lowsrc, dynsrc, 
 background, codebase.
 * Opera6 XSS bug ([\xC0][\xBC]script>alert(1)[\xC0][\xBC]/script> [UTF-8] workarounded.
1.0.4.
 New "dangerous" tag: plaintext.
1.0.3.
 Added array of elements that can have no closing tag.
1.0.2.
 Bug fix: <img src="&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;alert(1);"> attack.
 Thanks to shmel.
1.0.1.
 Bug fix: safehtml hangs on <style></style></style> code.
 Thanks to lj user=electrocat.
1.0.0.
 First public release
