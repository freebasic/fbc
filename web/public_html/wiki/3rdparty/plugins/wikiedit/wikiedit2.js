/*
////////////////////////////////////////////////////////////////////////
// WikiEdit for Wikka                                                 //
// v. 2.15                                                            //
// supported: MZ1.4+, MSIE5+                                          //
//                                                                    //
// (c) Roman "Kukutz" Ivanov <thingol@mail.ru>, 2003-2004             //
//   based on AutoIndent for textarea                                 //
//   (c) Roman "Kukutz" Ivanov, Evgeny Nedelko, 2003                  //
// Many thanks to Alexander Babaev, Sergey Kruglov and Evgeny Nedelko //
// http://wackowiki.com/WikiEdit                                      //
//                                                                    //
////////////////////////////////////////////////////////////////////////

For license see LICENSE.TXT
*/

var WikiEdit = function(){
 this.mark = "##inspoint##";
 this.begin = "##startpoint##";
 this.rbegin = new RegExp(this.begin);
 this.end = "##endpoint##";
 this.rend = new RegExp(this.end);
 this.rendb = new RegExp("^" + this.end);
 this.enabled = true;
 this.tab = false;
 this.enterpressed = false;
 this.undostack = new Array();
 this.buttons = new Array();
}
var base_url = "";

WikiEdit.prototype = new ProtoEdit();
WikiEdit.prototype.constructor = WikiEdit;

// initialisation
WikiEdit.prototype.init = function(id, name, nameClass, imgPath) {

 if (!(isMZ || isIE)) return;
 this.mzBugFixed=true;
 if (isMZ && navigator.userAgent.substr(navigator.userAgent.indexOf("Gecko/")+6,4)=="2003" ) {
  this.mzBugFixed=(navigator.userAgent.substr(navigator.userAgent.indexOf("Gecko/")+6,8)>20030510);
  mzOld=(navigator.userAgent.substr(navigator.userAgent.indexOf("Gecko/")+6,8)<20030110);
  if (mzOld) this.MZ=false;
  else this.MZ=true;
 }
 if (isMZ && navigator.userAgent.substr(navigator.userAgent.indexOf("Gecko/")+6,4)=="2002" ) this.MZ=false;
 if (!(this.MZ || isIE)) return;

 this._init(id);

// if (!this.area.id) this.area.id = "area_"+String(Math.floor(Math.random()*10000));

 if (isMZ)
 {
 try {
  this.undotext = this.area.value;
  this.undosels = this.area.selectionStart;
  this.undosele = this.area.selectionEnd;
 } catch(e){};
 }
  var mylocation = window.location.href;

  var base_till = mylocation.indexOf("wikka.php");
  if(base_till==-1) {
    var locarray = mylocation.split("/");
    delete locarray[(locarray.length-1)];
    delete locarray[(locarray.length-2)];
    base_url = locarray.join("/");
    base_url = base_url.substr(0, base_url.length-1);
  }
  else {
    base_url = mylocation.substring(0, base_till);
  }
 if (isIE)
 {
  this.area.addBehavior(base_url+"3rdparty/plugins/wikiedit/sel.htc");
 }

 this.imagesPath = (imgPath?imgPath:base_url+"3rdparty/plugins/wikiedit/images/");
 this.editorName = name;
 this.editorNameClass = nameClass;

 this.actionName = "document.getElementById('" + this.id + "')._owner.insTag";

// this.addButton("h1","h1","'==','==',0,1");
 this.addButton("h2","Heading 2","'=====','=====',0,1");
 this.addButton("h3","Heading 3","'====','====',0,1");
 this.addButton(" ");
 this.addButton("bold","Bold","'**','**'");
 this.addButton("italic","Italic","'//','//'");
 this.addButton("underline","Underline","'__','__'");
 this.addButton("strike","Strikethrough","'++','++'");
 this.addButton(" ");
 this.addButton("ul","List","'\\t- ','',0,1,1");
 this.addButton("ol","Numbered list","'\\t1) ','',0,1,1");
 this.addButton(" ");
 this.addButton("indent","Indent","'\\t','',0,1");
 this.addButton("outdent","Outdent","","document.getElementById('" + this.id + "')._owner.unindent");
 this.addButton(" ");
// this.addButton("quote","quote","'\\n<[',']>\\n',2");
 this.addButton("hr","Line","'','\\n----\\n',2");
 this.addButton("textred","Marked text","'\\'\\'','\\'\\'',2");
 this.addButton("createlink","Hyperlink","","document.getElementById('" + this.id + "')._owner.createLink");
// this.addButton("createtable","Insert Table","'','\\n#|\\n|| | ||\\n|| | ||\\n|#\\n',2");
 this.addButton(" ");
 this.addButton("help","Help & About","","document.getElementById('" + this.id + "')._owner.help");
 this.addButton("customhtml",'<td><div style="font:12px Arial;text-decoration:underline; padding:4px;" id="hilfe_' + this.id + '" onmouseover=\'this.className="btn-hover";\' '
            + 'onmouseout=\'this.className="btn-";\' class="btn-" '
            + 'onclick="this.className=\'btn-pressed\';window.open(base_url+\'FormattingRules\');" '
            + ' title="Help on Wikka formatting">Help</a>'
            + '</div></td>');
 

 try {
  var toolbar = document.createElement("div");
  toolbar.id = "tb_"+this.id;
  this.area.parentNode.insertBefore(toolbar, this.area);
  toolbar = document.getElementById("tb_"+this.id);
  toolbar.innerHTML = this.createToolbar(1);
 } catch(e){};
}

// switch TAB key interception on and off
WikiEdit.prototype.switchTab = function() {
 this.tab = !this.tab;
}

// internal functions ----------------------------------------------------
WikiEdit.prototype._LSum = function (Tag, Text, Skip)
{
 if (Skip)
 {
  var bb = new RegExp("^([ ]*)([*][*])(.*)$");
  q = Text.match(bb);
  if (q!=null)
  {
   Text = q[1]+Tag+q[2]+q[3];
   return Text;
  }
  var w = new RegExp("^([ ]*)(([*]|([1-9][0-9]*|[a-zA-Z])([.]|[)]))( |))(.*)$");
  q = Text.match(w);
  if (q!=null)
  {
   Text = q[1]+q[2]+Tag+q[7];
   return Text;
  }
 }
 var w  = new RegExp("^([ ]*)(.*)$");
 q = Text.match(w);
 Text = q[1]+Tag+q[2];
 return Text;
}

WikiEdit.prototype._RSum = function (Text, Tag)
{
 var w  = new RegExp("^(.*)([ ]*)$");
 q = Text.match(w);
 Text = q[1]+Tag+q[2];
 return Text;
}

WikiEdit.prototype._TSum = function (Text, Tag, Tag2, Skip)
{
 var bb = new RegExp("^([ ]*)"+this.begin+"([ ]*)([*][*])(.*)$");
 q = Text.match(bb);
 if (q!=null)
 {
  Text = q[1]+this.begin+q[2]+Tag+q[3]+q[4];
 }
 else
 {
  var w = new RegExp("^([ ]*)"+this.begin+"([ ]*)(([*]|([1-9][0-9]*|[a-zA-Z])([.]|[)]))( |))(.*)$");
  q = Text.match(w);
  if (Skip && q!=null)
  {
   Text = q[1]+this.begin+q[2]+q[3]+Tag+q[8];
  }
  else
  {
   var w = new RegExp("^(.*)"+this.begin+"([ ]*)(.*)$");
   var q = Text.match(w);
   if (q!=null)
   {
    Text = q[1]+this.begin+q[2]+Tag+q[3];
   }
  }
 }
 var w = new RegExp("([ ]*)"+this.end+"(.*)$");
 var q = Text.match(w);
 if (q!=null)
 {
  var w = new RegExp("^(.*)"+this.end);
  var q1 = Text.match(w);
  if (q1!=null)
  {
   var s = q1[1];
   ch = s.substring(s.length-1, s.length);
   while (ch == " ") {
      s = s.substring(0, s.length-1);
      ch = s.substring(s.length-1, s.length);
   }
   Text = s+Tag2+q[1]+this.end+q[2];
  }
 }
 return Text;
}

WikiEdit.prototype.MarkUp = function (Tag, Text, Tag2, onNewLine, expand, strip)
{
 var skip = 0;
 if (expand == 0) skip = 1;
 var r = '';
 var fIn = false;
 var fOut = false;
 var add = 0;
 var f = false;
 var w = new RegExp("(^|\n)( +|\t+)(([-]|([1-9][0-9]*|[a-zA-Z])([.]|[)]))( |))");
 Text = Text.replace(new RegExp("\r", "g"), "");
 var lines = Text.split('\n');
 for(var i = 0; i < lines.length; i++) {
   if (this.rbegin.test(lines[i]))
     fIn = true;
   if (this.rendb.test(lines[i]))
     fIn = false;
   if (this.rend.test(lines[i]))
     fOut = true;
   if (this.rendb.test(lines[i+1])) {
     fOut = true;
     lines[i+1]=lines[i+1].replace(this.rend, "");
     lines[i]=lines[i]+this.end;
   }
   if (r != '')
     r += '\n';

  if (fIn && strip==1) {
    if (this.rbegin.test(lines[i]))
    {
     lines[i] = lines[i].replace(this.rbegin, "");
     f = true;
    } else f=false;
//  alert(lines[i].replace(new RegExp("\n","g"),"|").replace(new RegExp(" ","g"),"_"));
    lines[i] = lines[i].replace(w, "$1");
//  alert(lines[i].replace(new RegExp("\n","g"),"|").replace(new RegExp(" ","g"),"_"));
    if (f) lines[i] = this.begin+lines[i];
  }
  if (fIn && (onNewLine==0 | (onNewLine==1 && add==0) | (onNewLine==2 && (add==0 || fOut)))) {

    if (expand==1) {
      l = lines[i];
      if (add==0) l = this._LSum(Tag, l, skip);
      if (fOut)   l = this._RSum(l, Tag2);
      if (add!=0 && onNewLine!=2) l = this._LSum(Tag, l, skip);
      if (!fOut  && onNewLine!=2) l = this._RSum(l, Tag2);
      r += l;
    } else {
//    alert(lines[i].replace(new RegExp("\n","g"),"|").replace(new RegExp(" ","g"),"_"));
//    alert(lines[i+1].replace(new RegExp("\n","g"),"|").replace(new RegExp(" ","g"),"_"));
      l = this._TSum(lines[i], Tag, Tag2, skip);
      if (add!=0 && onNewLine!=2) l = this._LSum(Tag, l, skip);
      if (!fOut  && onNewLine!=2) l = this._RSum(l, Tag2);
      r += l;
    }
    add++;
  } else {

    r += lines[i];
  }
  if (fOut)
   fIn = false;
 }
 return r;
}

WikiEdit.prototype.keyDown = function (event) {

  if (!this.enabled) return;

  var l, q, l1, re, tr, str, t, tr2, tr1, r1, re, q, e;
  var justenter = false;
  var noscroll = remundo = res = false;

  var t = this.area;

  var Key = event.keyCode;
  if (Key==0) Key = event.charCode;
  if (Key==8 || Key==13 || Key==32 || (Key>45 && Key<91) || (Key>93 && Key<112) || (Key>123 && Key<144)
      || (Key>145 && Key<255)) remundo = Key;
  if (event.altKey && !event.ctrlKey) Key=Key+4096;
  if (event.ctrlKey && !event.altKey) Key=Key+2048;  // Resolves issue DotMG was having.
  // if (event.ctrlKey) Key=Key+2048;  

  if (isMZ && event.type == "keypress" && this.checkKey(Key))
  {
    event.preventDefault();
    event.stopPropagation();
    return false;
  }
  if (isMZ && event.type == "keyup" && (Key==9 || Key==13))
    return false;

  if (isMZ) 
  {
   var scroll = t.scrollTop;
   undotext = t.value;
   undosels = t.selectionStart;
   undosele = t.selectionEnd;
  }

  if (isIE)
  {
    tr  = document.selection.createRange();
    str = tr.text;
  } else {
    str = t.value.substr(t.selectionStart, t.selectionEnd - t.selectionStart);
  }
  sel = (str.length > 0);

  if (isIE && Key==2048+187) Key=2048+61; //
  if (isIE && Key==2048+189 && event.shiftKey) Key=2048+95; //

  switch (Key)
  {
  case 2138: //Z
   if (isMZ && this.undotext) {
    t.value = this.undotext;
    t.setSelectionRange(this.undosels, this.undosele);
    this.undotext = "";
   }
  break;
  case 9:  //Tab
  case 2132: //T
  case 4181: //U
  case 4169: //I
   if (this.tab || Key!=9)
   if (event.shiftKey || Key==4181) {
     res = this.unindent();
   } else {
     res = this.insTag("\t", "", 0, 1);
   }
  break;
  case 2097:   //1
    res = this.insTag("======", "======", 0, 1);
  break;
  case 2098:   //2
    res = this.insTag("=====", "=====", 0, 1);
  break;
  case 2099:   //3
    res = this.insTag("====", "====", 0, 1);
  break;
  case 2100:   //4
    res = this.insTag("===", "===", 0, 1);
  break;
  case 2101:   //5
    res = this.insTag("==", "==", 0, 1);
  break;
  case 2143: //_
//   if (sel) //&& event.shiftKey)
    res = this.insTag("", "\n----\n", 2);
  break;
  case 2114: //B
   if (sel)
    res = this.insTag("**", "**");
  break;
  case 2131:  //S
   if (sel)
    res = this.insTag("++", "++");
  break;
  case 2133: //U
   if (sel)
    res = this.insTag("__", "__");
  break;
  case 2121: //I
   if (sel)
    res = this.insTag("//", "//");
  break;
  case 2122: //J
   if (sel)
    res = this.insTag("''", "''", 2);
  break;
  case 4179: //Alt+S
    try {
      if (weSave!=null) weSave();
    }
    catch(e){};
  break;
  case 2124:   //L
  case 4172:
    if (event.shiftKey && event.ctrlKey) {
      res = this.insTag("\t- ", "", 0, 1, 1);
    } else if (event.altKey || event.ctrlKey) {
      res = this.createLink(event.altKey);
    }
  break;
  case 2127: //O
  case 2126: //N
   if (event.ctrlKey && event.shiftKey)
    res = this.insTag("\t1) ", "", 0, 1, 1);
  break;

  case 2161: //ctrl+f2
    res = this.insTag('{{fbdoc item="category" value="', '"}}', 0, 1);
  	break;
  case 2162: //ctrl+f3
    res = this.insTag('{{fbdoc item="keyword" value="', '"}}', 0, 1);
  	break;
  case 2163: //ctrl+f4
    res = this.insTag('{{fbdoc item="title" value="', '"}}', 0, 1);
  	break;
  case 2164: //ctrl+f5
    res = this.insTag('{{fbdoc item="title" value="', '"}}', 0, 1);
  	break;
  case 2165: //ctrl+f6
    res = this.insTag('{{fbdoc item="syntax"}}', '\n');
  	break;
  case 2166: //ctrl+f7
    res = this.insTag('{{fbdoc item="desc"}}', '\n');
  	break;
  case 2167: //ctrl+f8
    res = this.insTag('{{fbdoc item="ex"}}', '\n');
  	break;
  case 2168: //ctrl+f9
    res = this.insTag('{{fbdoc item="diff"}}', '\n');
	break;
  case 2169: //ctrl+f10
     res = this.insTag('{{fbdoc item="see"}}', '\n');
 	 break;
  case 2170: //ctrl+f11
     res = this.insTag('{{fbdoc item="back" value="', '"}}', 0, 1);
 	 break;

  case 13:
  case 2061:
  case 4109:
   if (event.ctrlKey) {//Ctrl+Enter
    try {
      if (weSave!=null) weSave();
    }
    catch(e){};
   }
   else if (event.shiftKey) { //Shift+Enter
     res = false;
   }
   else
   {
     var text = t.value.replace(/\r/g, "");
     var sel1 = text.substr(0, t.selectionStart);
     var sel2 = text.substr(t.selectionEnd);           
     re = new RegExp("(^|\n)(( +|\t+)(((\-|([1-9][0-9]*|[a-zA-Z])([.]|[)]))( |))|))("+(this.enterpressed?"\s":"[^\n]")+"*)"+(this.mzBugFixed?"":"\n?")+"$");
     q = sel1.match(re);
     if (q!=null) 
     {
      if (this.enterpressed) 
      {
       sel1 = sel1.replace(re, "");
       q[2] = "";
      }
      t.value=sel1+(this.mzBugFixed?"\n":"")+q[2]+sel2;
      sel = q[2].length + sel1.length +(this.mzBugFixed?1:0);
      t.setSelectionRange(sel, sel);

      if (isMZ) {
       if (t.childNodes[0] != null)
       {
        t.childNodes[0].nodeValue=t.value;
        var temp=document.createRange();
        temp.setStart(t.childNodes[0],sel-2);
        temp.setEnd(t.childNodes[0],sel);
       }
       //t.scrollIntoView(true);
       z=t.selectionStart;
       lines=t.value.substr(0,z).split('\n').length-1;
       totalLines=t.value.split('\n').length-1;
       if (scroll + t.offsetHeight + 25 > Math.floor((t.scrollHeight/(totalLines+1))*lines))
       {
        t.scrollTop = Math.floor((t.scrollHeight/(totalLines+1))*lines)  - t.offsetHeight + 20;
        t.focus();
        noscroll = true;
       }
      } else {
       var op = this.area;
       var tp = 0; var lf = 0;
       do {
         tp+=op.offsetTop;
         lf+=op.offsetLeft;
       } while (op=op.offsetParent)
       if (tr.offsetTop >= this.area.clientHeight+tp) tr.scrollIntoView(false);
      }
      res = true;
     }
    var justenter = true;
   }
  break;
  }

  this.enterpressed = justenter;
  if (!res && remundo) {//alert(remundo+"|"+Key+"|"+this.undotext1);
  this.undotext = "";}

  if (res)
  {
    if (isIE) {
     this.area.focus();
     e = window.event;
     e.returnValue = false;
     return false;
    } else {
     this.undotext=undotext;
     this.undosels=undosels;
     this.undosele=undosele;
     event.cancelBubble = true;
     event.preventDefault();
     event.stopPropagation();
     if (!noscroll) t.scrollTop = scroll;
     return false;
    }
  }
}

WikiEdit.prototype.getDefines = function ()
{
  var t = this.area;

  text = t.value.replace(/\r/g, "");
  this.ss = t.selectionStart;
  this.se = t.selectionEnd;

  this.sel1 = text.substr(0, this.ss);
  this.sel2 = text.substr(this.se);
  this.sel = text.substr(this.ss, this.se - this.ss);
  this.str = this.sel1+this.begin+this.sel+this.end+this.sel2;

  if (isMZ) 
  {
   this.scroll = t.scrollTop;
   this.undotext = t.value;
   this.undosels = t.selectionStart;
   this.undosele = t.selectionEnd;
  }

}

WikiEdit.prototype.setAreaContent = function (str)
{
  var t = this.area;
  q = str.match(new RegExp("((.|\n)*)"+this.begin));//?:
  l = q[1].length;
  q = str.match(new RegExp(this.begin+"((.|\n)*)"+this.end));
  l1 = q[1].length;
  str = str.replace(this.rbegin, "");
  str = str.replace(this.rend, "");
  t.value = str;
  t.setSelectionRange(l, l + l1);
  if (isMZ) t.scrollTop = this.scroll;
}

WikiEdit.prototype.insTag = function (Tag, Tag2, onNewLine, expand, strip)
{
/*
onNewLine:
0 - add tags on every line inside selection
1 - add tags only on the first line of selection
2 - add tags before and after selection
//3 - add tags only if there's one line -- not implemented

expand:
0 - add tags on selection
1 - add tags on full line(s)
*/
  if (onNewLine == null) onNewLine = 0;
  if (expand == null) expand = 0;
  if (strip == null) strip = 0;

  var t = this.area;
  t.focus();

  this.getDefines();

  //alert(Tag + " | " + Tag2 + " | " + onNewLine + " | " + expand + " | " + strip);
  str = this.MarkUp(Tag, this.str, Tag2, onNewLine, expand, strip);

  this.setAreaContent(str);

  return true;
}

WikiEdit.prototype.unindent = function ()
{
  var t = this.area;
  t.focus();

  this.getDefines();

  var r = '';
  var fIn = false;
  var lines = this.str.split('\n');
  var rbeginb = new RegExp("^" + this.begin);
  for(var i = 0; i < lines.length; i++)
  {
    var line = lines[i];
    if (this.rbegin.test(line)) {
      fIn = true;
      var rbeginb = new RegExp("^"+this.begin+"([ ]*)");
      line = line.replace(rbeginb, '$1'+this.begin); //catch first line
    }
    if (this.rendb.test(line)) {
      fIn = false;
    }
    if (r != '') {
      r += '\n';
    }
    if (fIn) {
      r += line.replace(/^(    )|\t/, '');
    } else {
      r += line;
    }
    if (this.rend.test(line)) {
      fIn = false;
    }
  }
  this.setAreaContent(r);
  return true;
}

WikiEdit.prototype.createLink = function (isAlt)
{
  var t = this.area;
  t.focus();

  this.getDefines();

  var n = new RegExp("\n");
  if (!n.test(this.sel)) {
    if (!isAlt) {
     lnk = prompt("Link:", this.sel);
     if (lnk==null) lnk = this.sel;
     sl = prompt("Text for linking:", this.sel);
     if (sl==null) sl = "";
     this.sel = lnk+" "+sl;
    };
    str = this.sel1+"[["+this.trim(this.sel)+"]]"+this.sel2;
    t.value = str;
    t.setSelectionRange(this.sel1.length, str.length-this.sel2.length);
    return true;
  }
  return false;
}

WikiEdit.prototype.help = function ()
{
 s =  " WikiEdit 2.15 (Modified for Wikka)\n";
 s += "  (c) Roman Ivanov, 2003-2004   \n";
 s += "  http://wackowiki.com/WikiEdit \n";
 s += "\n";
 s += "         Shortcuts:\n";
 s += " Ctrl+B - Bold\n";
 s += " Ctrl+I - Italic\n";
 s += " Ctrl+U - Underline\n";
 s += " Ctrl+Shift+S - Strikethrough\n";
 s += " Ctrl+Shift+1 - Heading 1\n";
 s += " ...\n";
 s += " Ctrl+Shift+5 - Heading 5\n";
 s += " Alt+I or Ctrl+T - Indent\n";
 s += " Alt+U or Ctrl+Shift+T - Unindent\n";
 s += " Ctrl+J - MarkUp ('')\n";
 s += " Alt+L - Link\n";
 s += " Ctrl+L - Link with description\n";
 s += " Ctrl+Shift+L - Unordered List\n";
 s += " Ctrl+Shift+N - Ordered List\n";
 s += " Ctrl+Shift+O - Ordered List\n";
 s += " Ctrl+Shift+Minus - Horizontal line\n";

 alert(s);
}