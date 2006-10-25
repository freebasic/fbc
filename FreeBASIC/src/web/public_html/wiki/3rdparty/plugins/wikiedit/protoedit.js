/* 
////////////////////////////////////////////////////////////////////////
// ProtoEdit                                                          //
// v. 2.01                                                            //
////////////////////////////////////////////////////////////////////////

For license see LICENSE.TXT
*/
var isDOM = document.getElementById //DOM1 browser 
var isO   = isO5 = window.opera && isDOM; //Opera 5+
var isO6  = isO && window.print //Opera 6+
var isO7  = isO && document.readyState //Opera 7+
var isIE  = document.all && document.all.item && !isO //Microsoft Internet Explorer 4+
var isIE5 = isIE && isDOM //MSIE 5+
var isMZ  = isDOM && (navigator.appName=="Netscape")
var ua = navigator.userAgent.toLowerCase();
var isSafari = (ua.indexOf("safari") != -1);

var ProtoEdit = function(){
 this.enabled = true;
 this.MZ=isMZ;
 this.buttons = new Array();
}

ProtoEdit.prototype._init = function(id, rte) {
 this.id = id;                           //id - id of textarea   
 this.area = document.getElementById(id);//area - textarea object
 this.area._owner = this;                //area._owner - this    
                                         //rte - id of rte frame 
 if (rte)
 {
  if(isIE){
    frames[rte].document.onkeydown = function() { document.getElementById(id)._owner.keyDown(frames[rte].event) }
  }else if (this.MZ=isMZ) {
    document.getElementById(rte).contentWindow.document.addEventListener("keypress", function(ev) { document.getElementById(id)._owner.keyDown(ev) }, true);
    document.getElementById(rte).contentWindow.document.addEventListener("keyup",    function(ev) { document.getElementById(id)._owner.keyDown(ev) }, true);
  }
 }
 else
 {
  if(isIE){
   this.area.onkeydown = function() { this._owner.keyDown(event) }
  }else if (this.MZ=isMZ) {
    this.area.addEventListener("keypress", function(ev) { this._owner.keyDown(ev) }, true);
    this.area.addEventListener("keyup",    function(ev) { this._owner.keyDown(ev) }, true);
  }
 }
}

ProtoEdit.prototype.enable = function() {
 this.enabled = true;
}

ProtoEdit.prototype.disable = function() {
 this.enabled = false;
}

ProtoEdit.prototype.KeyDown = function () {

  if (!this.enabled) return;

  return true;
}

ProtoEdit.prototype.insTag = function (Tag,Tag2) {
  if (isMZ)
  {
   var ss = this.area.scrollTop;
   sel1 = this.area.value.substr(0, this.area.selectionStart);
   sel2 = this.area.value.substr(this.area.selectionEnd);

   sel = this.area.value.substr(this.area.selectionStart,
                   this.area.selectionEnd - this.area.selectionStart);

   this.area.value = sel1 + Tag + sel + Tag2 + sel2;

   selPos = Tag.length + sel1.length + sel.length + Tag2.length;
   this.area.setSelectionRange(sel1.length, selPos);
   this.area.scrollTop = ss;
  }
  else
  {
   this.area.focus();
   sel = document.selection.createRange();
   sel.text = Tag+sel.text+Tag2;
   this.area.focus();
  }
  return true;
}

ProtoEdit.prototype.createToolbar = function (id, width, height, readOnly) {
  wh = "";

  html = '<table id="buttons_' + id + '" cellpadding="1" cellspacing="0" class="toolbar">'
          + '  <tr>';
  if (this.editorName) html += '<td class="'+this.editorNameClass+'">'+this.editorName+'</td>';

  for (var i = 0; i<this.buttons.length; i++) 
  {
   var btn = this.buttons[i];
   if (btn.name==" ")
    html += ' <td>&nbsp;</td>\n';
   else if (btn.name=="customhtml")
    html += btn.desc;
   else
    html += ' <td><div id="' + btn.name + '_' + id + '" onmouseover=\'this.className="btn-hover";\' '
          + 'onmouseout=\'this.className="btn-";\' class="btn-" '
          + 'onclick="this.className=\'btn-pressed\';' + btn.actionName + '('//\'' + id + '\', ' 
          + btn.actionParams + ')"><img src="' + this.imagesPath 
          + btn.name + '.gif" ' + wh + ' alt="' + btn.desc + '" title="' + btn.desc 
          + '"></div></td>\n';
  }

  html += '</tr></table>\n';
  return html;
}

ProtoEdit.prototype.addButton = function (name, desc, actionParams, actionName) {
 if (actionName == null) actionName = this.actionName;
 var i = this.buttons.length;
 this.buttons[i] = new Object();
 this.buttons[i].name = name;
 this.buttons[i].desc = desc;
 this.buttons[i].actionName   = actionName;
 this.buttons[i].actionParams = actionParams;
}

ProtoEdit.prototype.checkKey = function (k) 
{
	switch(k)
	{
		case 85+4096:
		case 73+4096:
		case 49+2048: 
		case 50+2048: 
		case 51+2048: 
		case 52+2048:
		case 76+4096: 
		case 76+2048: 
		case 78+2048: 
		case 79+2048: 
		case 66+2048: 
		case 83+2048:
		case 85+2048: 
		case 72+2048: 
		case 73+2048: 
		case 74+2048: 
		case 84+2048: 
		case 2109:
		case 2124+32: 
		case 2126+32: 
		case 2127+32: 
		case 2114+32: 
		case 2131+32:
		case 2133+32: 
		case 2121+32: 
		case 2120+32: 
		case 2122+32:
		case 2161: 
		case 2162: 
		case 2163: 
		case 2164: 
		case 2165: 
		case 2166: 
		case 2167: 
		case 2168: 
		case 2169: 
		case 2170:
			return true;
		default:
			return false;
	}
}

ProtoEdit.prototype.addEvent = function (el, evname, func) {
  if (isIE) 
    el.attachEvent("on" + evname, func);
  else
    el.addEventListener(evname, func, true);
}

ProtoEdit.prototype.trim = function(s2) {
   if (typeof s2 != "string") return s2;
   var s = s2;
   var ch = s.substring(0, 1);
  
   while (ch == " ") { // Check for spaces at the beginning of the string
      s = s.substring(1, s.length);
      ch = s.substring(0, 1);
   }
   ch = s.substring(s.length-1, s.length);
  
   while (ch == " ") { // Check for spaces at the end of the string
      s = s.substring(0, s.length-1);
      ch = s.substring(s.length-1, s.length);
   }
  
  // Note that there are two spaces in the string - look for multiple spaces within the string
   while (s.indexOf("  ") != -1) {
    // Again, there are two spaces in each of the strings
      s = s.substring(0, s.indexOf("  ")) + s.substring(s.indexOf("  ")+1, s.length);
   }
   return s; // Return the trimmed string back to the user
}

