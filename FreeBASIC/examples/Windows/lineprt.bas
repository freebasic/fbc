''
'' lineprt -- shows how to use GDI printers from FB using BASIC-only commands
''


dim as string printer_name, doc_title

line input "What's the printer name"; printer_name
if len(printer_name)=0 then end 1

line input "What's the documents title"; doc_title
if len(doc_title)>0 then
    if instr(doc_title,",")>0 then
        print "The document title must not contain a comma"
        end 1
    end if
    doc_title = ",TITLE=" + doc_title
end if

open lpt "LPT:" + printer_name + ",EMU=TTY" + doc_title as 1
print #1, "Hello World !"
print #1, chr(12); ' start a new page
print #1, "I say ""Hello World !"" on page 2"
close 1
