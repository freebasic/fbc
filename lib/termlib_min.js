/*
  termlib.js - JS-WebTerminal Object v1.66

  (c) Norbert Landsteiner 2003-2015
  mass:werk - media environments
  <http://www.masswerk.at/termlib/>

  Creates [multiple] Terminal instances.

  License:
  This JavaScript-library is free.
  Include a visible backlink to <http://www.masswerk.at/termlib/> in the
  embedding web page or application.
  The library should always be accompanied by the 'readme.txt' and the
  sample HTML-documents.
  
  Any changes should be commented and must be reflected in `Terminal.version'
  in the format: "Version.Subversion (compatibility)".
  
  Donations:
  Donations are welcome: You may support and/or honor the development of
  "termlib.js" via PayPal at: <http://www.masswerk.at/termlib/donate/>

  Disclaimer:
  This software is distributed AS IS and in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. The entire risk as to
  the quality and performance of the product is borne by the user. No use of
  the product is authorized hereunder except under this disclaimer.
*/

var Terminal = function(conf) {
	if (typeof conf != 'object') conf=new Object();
	for (var i in this.Defaults) {
		if (typeof conf[i] == 'undefined') conf[i]=this.Defaults[i];
	}
	if (typeof conf.handler != 'function') conf.handler=Terminal.prototype.defaultHandler;
	this.conf=conf;
	this.setInitValues();
}


Terminal.prototype = {
// prototype definitions (save some 2k on indentation)

version: '1.66 (fb)',

Defaults: {
	// dimensions
	cols:80,
	rows:24,
	// appearance
	x:100,
	y:100,
	termDiv:'termDiv',
	bgColor:'#181818',
	frameColor:'#555555',
	frameWidth:1,
	rowHeight:15,
	blinkDelay:500,
	// css class
	fontClass:'term',
	// initial cursor mode
	crsrBlinkMode:false,
	crsrBlockMode:true,
	// key mapping
	DELisBS:false,
	printTab:true,
	printEuro:true,
	catchCtrlH:true,
	closeOnESC:true,
	// prevent consecutive history doublets
	historyUnique:false,
	// optional id
	id:0,
	// strings
	ps:'>',
	greeting:'%+r Terminal ready. %-r',
	// handlers
	handler:null,
	ctrlHandler:null,
	initHandler:null,
	exitHandler:null,
	wrapping:false,
	mapANSI:false,
	ANSItrueBlack:false,
	textBlur: 0,
	textColor: ''
},

setInitValues: function() {
	this.isSafari= (navigator.userAgent.indexOf('Safari')>=0 || navigator.userAgent.indexOf('WebKit')>=0)? true:false;
	this.isOpera= (window.opera && navigator.userAgent.indexOf('Opera')>=0)? true:false;
	this.isChrome= (navigator.userAgent.indexOf('Chrome/')>=0 && navigator.userAgent.indexOf('WebKit')>=0)? true:false;
	this.domAPI= (document && document.createElement)? true:false;
	this.isMac= (navigator.userAgent.indexOf('Mac')>=0)? true:false;
	this.id=this.conf.id;
	this.maxLines=this.conf.rows;
	this.maxCols=this.conf.cols;
	this.termDiv=this.conf.termDiv;
	this.crsrBlinkMode=this.conf.crsrBlinkMode;
	this.crsrBlockMode=this.conf.crsrBlockMode;
	this.blinkDelay=this.conf.blinkDelay;
	this.DELisBS=this.conf.DELisBS;
	this.printTab=this.conf.printTab;
	this.printEuro=this.conf.printEuro;
	this.catchCtrlH=this.conf.catchCtrlH;
	this.closeOnESC=this.conf.closeOnESC;
	this.historyUnique=this.conf.historyUnique;
	this.ps=this.conf.ps;
	this.closed=false;
	this.r;
	this.c;
	this.charBuf=new Array();
	this.styleBuf=new Array();
	this.scrollBuf=null;
	this.blinkBuffer=0;
	this.blinkTimer;
	this.cursoractive=false;
	this.lock=true;
	this.insert=false;
	this.charMode=false;
	this.rawMode=false;
	this.lineBuffer='';
	this.inputChar=0;
	this.lastLine='';
	this.guiCounter=0;
	this.history=new Array();
	this.histPtr=0;
	this.env=new Object();
	this.buckupBuffer=null;
	this.handler=this.conf.handler;
	this.wrapping=this.conf.wrapping;
	this.mapANSI=this.conf.mapANSI;
	this.ANSItrueBlack=this.conf.ANSItrueBlack;
	this.ctrlHandler=this.conf.ctrlHandler;
	this.initHandler=this.conf.initHandler;
	this.exitHandler=this.conf.exitHandler;
	this.fieldMode=false;
	this.fieldStart=this.fieldEnd=this.fieldC=0;
	if (typeof this.conf.textBlur === 'object' && this.conf.textBlur.length) {
		var a=[];
		for (var i=0; i<this.conf.textBlur.length; i++) {
			var b=Number(this.conf.textBlur[i]);
			if (!isNaN(b) && b>0) a.push(b);
		}
		this.textBlur=(a.length)? a:0;
	}
	else {
		this.textBlur=Number(this.conf.textBlur);
		if (isNaN(this.textBlur) || this.textBlur<0 || this.textBlur>40) this.textBlur=0;
	}
	this.textColor=this.conf.textColor || '';
},

defaultHandler: function() {
	this.newLine();
	if (this.lineBuffer != '') {
		this.type('You typed: '+this.lineBuffer);
		this.newLine();
	}
	this.prompt();
},

open: function() {
	if (this.termDivReady()) {
		if (!this.closed) this._makeTerm();
		this.init();
		return true;
	}
	else {
		return false;
	}
},

close: function() {
	this.lock=true;
	this.cursorOff();
	if (this.exitHandler) this.exitHandler();
	this.globals.setVisible(this.termDiv,0);
	this.closed=true;
},

init: function() {
	// wait for gui
	if (this.guiReady()) {
		this.guiCounter=0;
		// clean up at re-entry
		if (this.closed) {
			this.setInitValues();
		}
		this.clear();
		this.globals.setVisible(this.termDiv,1);
		this.globals.enableKeyboard(this);
		if (this.initHandler) {
			this.initHandler();
		}
		else {
			this.write(this.conf.greeting);
			this.newLine();
			this.prompt();
		}
	}
	else {
		this.guiCounter++;
		if (this.guiCounter>18000) {
			if (confirm('Terminal:\nYour browser hasn\'t responded for more than 2 minutes.\nRetry?')) {
				this.guiCounter=0;
			}
			else {
				return;
			}
		};
		this.globals.termToInitialze=this;
		window.setTimeout('Terminal.prototype.globals.termToInitialze.init()',200);
	}
},

getRowArray: function(l,v) {
	// returns a fresh array of l length initialized with value v
	var a=new Array();
	for (var i=0; i<l; i++) a[i]=v;
	return a;
},

wrapOn: function() {
	// activate word wrap, wrapping workes with write() only!
	this.wrapping=true;
},

wrapOff: function() {
	this.wrapping=false;
},

setTextBlur: function(v) {
	var rerender=false;
	if (typeof v === 'object' && v.length) {
		var a=[];
		for (var i=0; i<v.length; i++) {
			var b=Number(v[i]);
			if (!isNaN(b) && b>0) a.push(b);
		}
		this.textBlur=(a.length)? a:0;
		rerender=true;
	}
	else {
		v=Number(v);
		if (isNaN(v) || v<0 || v>40) v=0;
		if (v!=this.textBlur) {
			this.textBlur=v;
			rerender=true;
		}
	}
	if (rerender) {
		for (var r=0, l=this.conf.rows; r<l; r++) this.redraw(r);
	}
},

setTextColor: function(v) {
	if (!v) v='';
	if (v!=this.textColor) {
		this.textColor=v;
		for (var r=0, l=this.conf.rows; r<l; r++) {
			this.redraw(r);
		}
	}
},

// main output methods

type: function(text,style) {
	for (var i=0; i<text.length; i++) {
		var ch=text.charCodeAt(i);
		if (!this.isPrintable(ch)) ch=94;
		this.charBuf[this.r][this.c]=ch;
		this.styleBuf[this.r][this.c]=(style)? style:0;
		var last_r=this.r;
		this._incCol();
		if (this.r!=last_r) this.redraw(last_r);
	}
	this.redraw(this.r)
},

write: function(text,usemore) {
	// write to scroll buffer with markup
	// new line = '%n' prepare any strings or arrys first
	if (typeof text != 'object') {
		if (typeof text!='string') text=''+text;
		if (text.indexOf('\n')>=0) {
			var ta=text.split('\n');
			text=ta.join('%n');
		}
	}
	else {
		if (text.join) {
			text=text.join('%n');
		}
		else {
			text=''+text;
		}
		if (text.indexOf('\n')>=0) {
			var ta=text.split('\n');
			text=ta.join('%n');
		}
	}
	if (this.mapANSI) text=this.globals.ANSI_map(text, this.ANSItrueBlack);
	this._sbInit(usemore);
	var chunks=text.split('%');
	var esc=(text.charAt(0)!='%');
	var style=0;
	var styleMarkUp=this.globals.termStyleMarkup;
	for (var i=0; i<chunks.length; i++) {
		if (esc) {
			if (chunks[i].length>0) {
				this._sbType(chunks[i],style);
			}
			else if (i>0) {
				this._sbType('%', style);
			}
			esc=false;
		}
		else {
			var func=chunks[i].charAt(0);
			if (chunks[i].length==0 && i>0) {
				this._sbType("%",style);
				esc=true;
			}
			else if (func=='n') {
				this._sbNewLine(true);
				if (chunks[i].length>1) this._sbType(chunks[i].substring(1),style);
			}
			else if (func=='+') {
				var opt=chunks[i].charAt(1);
				opt=opt.toLowerCase();
				if (opt=='p') {
					style=0;
				}
				else if (styleMarkUp[opt]) {
					style|=styleMarkUp[opt];
				}
				if (chunks[i].length>2) this._sbType(chunks[i].substring(2),style);
			}
			else if (func=='-') {
				var opt=chunks[i].charAt(1);
				opt=opt.toLowerCase();
				if (opt=='p') {
					style=0;
				}
				else if (styleMarkUp[opt]) {
					style&=~styleMarkUp[opt];
				}
				if (chunks[i].length>2) this._sbType(chunks[i].substring(2),style);
			}
			else if (chunks[i].length>1 && func=='c') {
				var cinfo=this._parseColor(chunks[i].substring(1));
				style=(style&(~0xfffff0))|cinfo.style;
				if (cinfo.rest) this._sbType(cinfo.rest,style);
			}
			else if (chunks[i].length>1 && chunks[i].charAt(0)=='C' && chunks[i].charAt(1)=='S') {
				this.clear();
				this._sbInit();
				if (chunks[i].length>2) this._sbType(chunks[i].substring(2),style);
			}
			else {
				if (chunks[i].length>0) this._sbType(chunks[i],style);
			}
		}
	}
	this._sbOut();
},

_lookupColor: function(clabel)
{
	if (clabel.length && clabel.length<=2) {
		var isHex=false;
		for (var i=0; i<clabel.length; i++) {
			if (this.globals.isHexOnlyChar(clabel.charAt(i))) {
				isHex=true;
				break;
			}
		}
		var cl=(isHex)? parseInt(clabel, 16):parseInt(clabel,10);
		if (!isNaN(cl) || cl<=15) {
			style=cl;
		}
	}
	else {
		style=this.globals.getColorCode(clabel);
	}
	
	return style;
},

// parse a color markup
_parseColor: function(chunk) {
	var rest='';
	var style=0;
	if (chunk.length) {
		if (chunk.charAt(0)=='(') {
			var clabel='';
			var bclabel = '';
			var isforeground = true;
			for (var i=1; i<chunk.length; i++) {
				var c = chunk.charAt(i);
				if (c==')') {
					if (chunk.length>i) rest=chunk.substring(i+1);
					break;
				} 
				else if (c==',') {
					isforeground = false;
					continue;
				}
				if( isforeground )
					clabel+=c;
				else
					bclabel+=c;
			}
			if (clabel) {
				style = this._lookupColor(clabel, false) << 8;
			}
			
			if (bclabel) {
				style = (style & 0xff00) | (this._lookupColor(bclabel, true) << 16);
			}
			
		}
		else {
			var c=chunk.charAt(0);
			if (this.globals.isHexChar(c)) {
				style=this.globals.hexToNum[c] << 8;
				rest=chunk.substring(1);
			}
			else {
				rest=chunk;
			}
		}
	}
	return { rest: rest, style: style };
},

// internal scroll buffer output methods

_sbInit: function(usemore) {
	var sb=this.scrollBuf=new Object();
	var sbl=sb.lines=new Array();
	var sbs=sb.styles=new Array();
	sb.more=usemore;
	sb.line=0;
	sb.status=0;
	sb.r=0;
	sb.c=this.c;
	sbl[0]=this.getRowArray(this.conf.cols,0);
	sbs[0]=this.getRowArray(this.conf.cols,0);
	for (var i=0; i<this.c; i++) {
		sbl[0][i]=this.charBuf[this.r][i];
		sbs[0][i]=this.styleBuf[this.r][i];
	}
},

_sbType: function(text,style) {
	// type to scroll buffer
	var sb=this.scrollBuf;
	for (var i=0; i<text.length; i++) {
		var ch=text.charCodeAt(i);
		if (!this.isPrintable(ch)) ch=94;
		sb.lines[sb.r][sb.c]=ch;
		sb.styles[sb.r][sb.c++]=(style)? style:0;
		if (sb.c>=this.maxCols) this._sbNewLine();
	}
},

_sbNewLine: function(forced) {
	var sb=this.scrollBuf;
	if (this.wrapping && forced) {
		sb.lines[sb.r][sb.c]=10;
		sb.lines[sb.r].length=sb.c+1;
	}
	sb.r++;
	sb.c=0;
	sb.lines[sb.r]=this.getRowArray(this.conf.cols,0);
	sb.styles[sb.r]=this.getRowArray(this.conf.cols,0);
},

_sbWrap: function() {
	// create a temp wrap buffer wb and scan for words/wrap-chars
	// then re-asign lines & styles to scrollBuf
	var wb=new Object();
	wb.lines=new Array();
	wb.styles=new Array();
	wb.lines[0]=this.getRowArray(this.conf.cols,0);
	wb.styles[0]=this.getRowArray(this.conf.cols,0);
	wb.r=0;
	wb.c=0;
	var sb=this.scrollBuf;
	var sbl=sb.lines;
	var sbs=sb.styles;
	var ch, st, wrap, lc, ls;
	var l=this.c;
	var lastR=0;
	var lastC=0;
	wb.cBreak=false;
	for (var r=0; r<sbl.length; r++) {
		lc=sbl[r];
		ls=sbs[r];
		for (var c=0; c<lc.length; c++) {
			ch=lc[c];
			st=ls[c];
			if (ch) {
				var wrap=this.globals.wrapChars[ch];
				if (ch==10) wrap=1;
				if (wrap) {
					if (wrap==2) {
						l++;
					}
					else if (wrap==4) {
						l++;
						lc[c]=45;
					}
					this._wbOut(wb, lastR, lastC, l);		
					if (ch==10) {
						this._wbIncLine(wb);
					}
					else if (wrap==1 && wb.c<this.maxCols) {
						wb.lines[wb.r][wb.c]=ch;
						wb.styles[wb.r][wb.c++]=st;
						if (wb.c>=this.maxCols) this._wbIncLine(wb);
					}
					if (wrap==3) {
						lastR=r;
						lastC=c;
						l=1;
					}
					else {
						l=0;
						lastR=r;
						lastC=c+1;
						if (lastC==lc.length) {
							lastR++;
							lastC=0;
						}
						if (wrap==4) wb.cBreak=true;
					}
				}
				else {
					l++;
				}
			}
			else {
				continue;
			}
		}
	}
	if (l) {
		if (wb.cBreak && wb.c!=0) wb.c--;
		this._wbOut(wb, lastR, lastC, l);
	}
	sb.lines=wb.lines;
	sb.styles=wb.styles;
	sb.r=wb.r;
	sb.c=wb.c;
},

_wbOut: function(wb, br, bc, l) {
	// copy a word (of l length from br/bc) to wrap buffer wb
	var sb=this.scrollBuf;
	var sbl=sb.lines;
	var sbs=sb.styles;
	var ofs=0;
	var lc, ls;
	if (l+wb.c>this.maxCols) {
		if (l<this.maxCols) {
			this._wbIncLine(wb);
		}
		else {
			var i0=0;
			ofs=this.maxCols-wb.c;
			lc=sbl[br];
			ls=sbs[br];
			while (true) {
				for (var i=i0; i<ofs; i++) {
					wb.lines[wb.r][wb.c]=lc[bc];
					wb.styles[wb.r][wb.c++]=ls[bc++];
					if (bc==sbl[br].length) {
						bc=0;
						br++;
						lc=sbl[br];
						ls=sbs[br];
					}
				}
				this._wbIncLine(wb);
				if (l-ofs<this.maxCols) break;
				i0=ofs;
				ofs+=this.maxCols;
			}
		}
	}
	else if (wb.cBreak) {
		wb.c--;
	}
	lc=sbl[br];
	ls=sbs[br];
	for (var i=ofs; i<l; i++) {
		wb.lines[wb.r][wb.c]=lc[bc];
		wb.styles[wb.r][wb.c++]=ls[bc++];
		if (bc==sbl[br].length) {
			bc=0;
			br++;
			lc=sbl[br];
			ls=sbs[br];
		}
	}
	wb.cBreak=false;
},

_wbIncLine: function(wb) {
	// create a new line in temp buffer
	wb.r++;
	wb.c=0;
	wb.lines[wb.r]=this.getRowArray(this.conf.cols,0);
	wb.styles[wb.r]=this.getRowArray(this.conf.cols,0);
},

_sbOut: function() {
	var sb=this.scrollBuf;
	if (this.wrapping && !sb.status) this._sbWrap();
	var sbl=sb.lines;
	var sbs=sb.styles;
	var tcb=this.charBuf;
	var tsb=this.styleBuf;
	var ml=this.maxLines;
	var buflen=sbl.length;
	if (sb.more) {
		if (sb.status) {
			if (this.inputChar==this.globals.lcMoreKeyAbort) {
				this.r=ml-1;
				this.c=0;
				tcb[this.r]=this.getRowArray(this.conf.cols,0);
				tsb[this.r]=this.getRowArray(this.conf.cols,0);
				this.redraw(this.r);
				this.handler=sb.handler;
				this.charMode=false;
				this.inputChar=0;
				this.scrollBuf=null;
				this.prompt();
				return;
			}
			else if (this.inputChar==this.globals.lcMoreKeyContinue) {
				this.clear();
			}
			else {
				return;
			}
		}
		else {
			if (this.r>=ml-1) this.clear();
		}
	}
	if (this.r+buflen-sb.line<=ml) {
		for (var i=sb.line; i<buflen; i++) {
			var r=this.r+i-sb.line;
			tcb[r]=sbl[i];
			tsb[r]=sbs[i];
			this.redraw(r);
		}
		this.r+=sb.r-sb.line;
		this.c=sb.c;
		if (sb.more) {
			if (sb.status) this.handler=sb.handler;
			this.charMode=false;
			this.inputChar=0;
			this.scrollBuf=null;
			this.prompt();
			return;
		}
	}
	else if (sb.more) {
		ml--;
		if (sb.status==0) {
			sb.handler=this.handler;
			this.handler=this._sbOut;
			this.charMode=true;
			sb.status=1;
		}
		if (this.r) {
			var ofs=ml-this.r;
			for (var i=sb.line; i<ofs; i++) {
				var r=this.r+i-sb.line;
				tcb[r]=sbl[i];
				tsb[r]=sbs[i];
				this.redraw(r);
			}
		}
		else {
			var ofs=sb.line+ml;
			for (var i=sb.line; i<ofs; i++) {
				var r=this.r+i-sb.line;
				tcb[r]=sbl[i];
				tsb[r]=sbs[i];
				this.redraw(r);
			}
		}
		sb.line=ofs;
		this.r=ml;
		this.c=0;
		this.type(this.globals.lcMorePrompt1, this.globals.lcMorePromtp1Style);
		this.type(this.globals.lcMorePrompt2, this.globals.lcMorePrompt2Style);
		this.lock=false;
		return;
	}
	else if (buflen>=ml) {
		var ofs=buflen-ml;
		for (var i=0; i<ml; i++) {
			var r=ofs+i;
			tcb[i]=sbl[r];
			tsb[i]=sbs[r];
			this.redraw(i);
		}
		this.r=ml-1;
		this.c=sb.c;
	}
	else {
		var dr=ml-buflen;
		var ofs=this.r-dr;
		for (var i=0; i<dr; i++) {
			var r=ofs+i;
			for (var c=0; c<this.maxCols; c++) {
				tcb[i][c]=tcb[r][c];
				tsb[i][c]=tsb[r][c];
			}
			this.redraw(i);
		}
		for (var i=0; i<buflen; i++) {
			var r=dr+i;
			tcb[r]=sbl[i];
			tsb[r]=sbs[i];
			this.redraw(r);
		}
		this.r=ml-1;
		this.c=sb.c;
	}
	this.scrollBuf=null;
},

// basic console output

typeAt: function(r,c,text,style) {
	var tr1=this.r;
	var tc1=this.c;
	this.cursorSet(r,c);
	for (var i=0; i<text.length; i++) {
		var ch=text.charCodeAt(i);
		if (!this.isPrintable(ch)) ch=94;
		this.charBuf[this.r][this.c]=ch;
		this.styleBuf[this.r][this.c]=(style)? style:0;
		var last_r=this.r;
		this._incCol();
		if (this.r!=last_r) this.redraw(last_r);
	}
	this.redraw(this.r);
	this.r=tr1;
	this.c=tc1;
},

statusLine: function(text,style,offset) {
	var ch,r;
	style=(style && !isNaN(style))? parseInt(style)&15:0;
	if (offset && offset>0) {
		r=this.conf.rows-offset;
	}
	else {
		r=this.conf.rows-1;
	}
	for (var i=0; i<this.conf.cols; i++) {
		if (i<text.length) {
			ch=text.charCodeAt(i);
			if (!this.isPrintable(ch)) ch = 94;
		}
		else {
			ch=0;
		}
		this.charBuf[r][i]=ch;
		this.styleBuf[r][i]=style;
	}
	this.redraw(r);
},

printRowFromString: function(r,text,style) {
	var ch;
	style=(style && !isNaN(style))? parseInt(style)&15:0;
	if (r>=0 && r<this.maxLines) {
		if (typeof text != 'string') text=''+text;
		for (var i=0; i<this.conf.cols; i++) {
			if (i<text.length) {
				ch=text.charCodeAt(i);
				if (!this.isPrintable(ch)) ch = 94;
			}
			else {
				ch=0;
			}
			this.charBuf[r][i]=ch;
			this.styleBuf[r][i]=style;
		}
		this.redraw(r);
	}
},

setChar: function(ch,r,c,style) {
	this.charBuf[r][c]=ch;
	this.styleBuf[r][c]=(style)? style:0;
	this.redraw(r);
},

newLine: function() {
	this.c=0;
	this._incRow();
},

// internal methods for output

_charOut: function(ch, style) {
	this.charBuf[this.r][this.c]=ch;
	this.styleBuf[this.r][this.c]=(style)? style:0;
	this.redraw(this.r);
	this._incCol();
},

_incCol: function() {
	this.c++;
	if (this.c>=this.maxCols) {
		this.c=0;
		this._incRow();
	}
},

_incRow: function() {
	this.r++;
	if (this.r>=this.maxLines) {
		this._scrollLines(0,this.maxLines);
		this.r=this.maxLines-1;
	}
},

_scrollLines: function(start, end) {
	window.status='Scrolling lines ...';
	start++;
	for (var ri=start; ri<end; ri++) {
		var rt=ri-1;
		this.charBuf[rt]=this.charBuf[ri];
		this.styleBuf[rt]=this.styleBuf[ri];
	}
	// clear last line
	var rt=end-1;
	this.charBuf[rt]=this.getRowArray(this.conf.cols,0);
	this.styleBuf[rt]=this.getRowArray(this.conf.cols,0);
	this.redraw(rt);
	for (var r=end-1; r>=start; r--) this.redraw(r-1);
	window.status='';
},

// control methods

clear: function() {
	window.status='Clearing display ...';
	this.cursorOff();
	this.insert=false;
	for (var ri=0; ri<this.maxLines; ri++) {
		this.charBuf[ri]=this.getRowArray(this.conf.cols,0);
		this.styleBuf[ri]=this.getRowArray(this.conf.cols,0);
		this.redraw(ri);
	}
	this.r=0;
	this.c=0;
	window.status='';
},

reset: function() {
	if (this.lock) return;
	this.lock=true;
	this.rawMode=false;
	this.charMode=false;
	this.maxLines=this.conf.rows;
	this.maxCols=this.conf.cols;
	this.lastLine='';
	this.lineBuffer='';
	this.inputChar=0;
	this.clear();
},

prompt: function() {
	this.lock=true;
	if (this.c>0) this.newLine();
	this.type(this.ps);
	this._charOut(1);
	this.lock=false;
	this.cursorOn();
},

isPrintable: function(ch, unicodePage1only) {
	if (this.wrapping && this.globals.wrapChars[ch]==4) return true;
	if (unicodePage1only && ch>255) {
		return (ch==this.termKey.EURO && this.printEuro)? true:false;
	}
	return (
		(ch>=32 && ch!=this.termKey.DEL) ||
		(this.printTab && ch==this.termKey.TAB)
	);
},

// cursor methods

cursorSet: function(r,c) {
	var crsron=this.cursoractive;
	if (crsron) this.cursorOff();
	this.r=r%this.maxLines;
	this.c=c%this.maxCols;
	this._cursorReset(crsron);
},

cursorOn: function() {
	if (this.blinkTimer) clearTimeout(this.blinkTimer);
	this.blinkBuffer=this.styleBuf[this.r][this.c];
	this._cursorBlink();
	this.cursoractive=true;
},

cursorOff: function() {
	if (this.blinkTimer) clearTimeout(this.blinkTimer);
	if (this.cursoractive) {
		this.styleBuf[this.r][this.c]=this.blinkBuffer;
		this.redraw(this.r);
		this.cursoractive=false;
	}
},

cursorLeft: function() {
	var crsron=this.cursoractive;
	if (crsron) this.cursorOff();
	var r=this.r;
	var c=this.c;
	if (c>0) {
		c--;
	}
	else if (r>0) {
		c=this.maxCols-1;
		r--;
	}
	if (this.isPrintable(this.charBuf[r][c])) {
		this.r=r;
		this.c=c;
	}
	this.insert=true;
	this._cursorReset(crsron);
},

cursorRight: function() {
	var crsron=this.cursoractive;
	if (crsron) this.cursorOff();
	var r=this.r;
	var c=this.c;
	if (c<this.maxCols-1) {
		c++;
	}
	else if (r<this.maxLines-1) {
		c=0;
		r++;
	}
	if (!this.isPrintable(this.charBuf[r][c])) {
		this.insert=false;
	}
	if (this.isPrintable(this.charBuf[this.r][this.c])) {
		this.r=r;
		this.c=c;
	}
	this._cursorReset(crsron);
},

backspace: function() {
	var crsron=this.cursoractive;
	if (crsron) this.cursorOff();
	var r=this.r;
	var c=this.c;
	if (c>0) c--
	else if (r>0) {
		c=this.maxCols-1;
		r--;
	};
	if (this.isPrintable(this.charBuf[r][c])) {
		this._scrollLeft(r, c);
		this.r=r;
		this.c=c;
	};	
	this._cursorReset(crsron);
},

fwdDelete: function() {
	var crsron=this.cursoractive;
	if (crsron) this.cursorOff();
	if (this.isPrintable(this.charBuf[this.r][this.c])) {
		this._scrollLeft(this.r,this.c);
		if (!this.isPrintable(this.charBuf[this.r][this.c])) this.insert=false;
	}
	this._cursorReset(crsron);
},

_cursorReset: function(crsron) {
	if (crsron) {
		this.cursorOn();
	}
	else {
		this.blinkBuffer=this.styleBuf[this.r][this.c];
	}
},

_cursorBlink: function() {
	if (this.blinkTimer) clearTimeout(this.blinkTimer);
	if (this == this.globals.activeTerm) {
		if (this.crsrBlockMode) {
			this.styleBuf[this.r][this.c]=(this.styleBuf[this.r][this.c]&1)?
				this.styleBuf[this.r][this.c]&0xfffffe:this.styleBuf[this.r][this.c]|1;
		}
		else {
			this.styleBuf[this.r][this.c]=(this.styleBuf[this.r][this.c]&2)?
				this.styleBuf[this.r][this.c]&0xffffd:this.styleBuf[this.r][this.c]|2;
		}
		this.redraw(this.r);
	}
	if (this.crsrBlinkMode) this.blinkTimer=setTimeout('Terminal.prototype.globals.activeTerm._cursorBlink()', this.blinkDelay);
},

_scrollLeft: function(r,c) {
	var rows=new Array();
	rows[0]=r;
	while (this.isPrintable(this.charBuf[r][c])) {
		var ri=r;
		var ci=c+1;
		if (ci==this.maxCols) {
			if (ri<this.maxLines-1) {
				ci=0;
				ri++;
				rows[rows.length]=ri;
			}
			else {
				break;
			}
		}
		this.charBuf[r][c]=this.charBuf[ri][ci];
		this.styleBuf[r][c]=this.styleBuf[ri][ci];
		c=ci;
		r=ri;
	}
	if (this.charBuf[r][c]!=0) this.charBuf[r][c]=0;
	for (var i=0; i<rows.length; i++) this.redraw(rows[i]);
},

_scrollRight: function(r,c) {
	var rows=new Array();
	var end=this._getLineEnd(r,c);
	var ri=end[0];
	var ci=end[1];
	if (ci==this.maxCols-1 && ri==this.maxLines-1) {
		if (r==0) return;
		this._scrollLines(0,this.maxLines);
		this.r--;
		r--;
		ri--;
	}
	rows[r]=1;
	while (this.isPrintable(this.charBuf[ri][ci])) {
		var rt=ri;
		var ct=ci+1;
		if (ct==this.maxCols) {
			ct=0;
			rt++;
			rows[rt]=1;
		}
		this.charBuf[rt][ct]=this.charBuf[ri][ci];
		this.styleBuf[rt][ct]=this.styleBuf[ri][ci];
		if (ri==r && ci==c) break;
		ci--;
		if (ci<0) {
			ci=this.maxCols-1;
			ri--;
			rows[ri]=1;
		}
	}
	for (var i=r; i<this.maxLines; i++) {
		if (rows[i]) this.redraw(i);
	}
},

_getLineEnd: function(r,c) {
	if (!this.isPrintable(this.charBuf[r][c])) {
		c--;
		if (c<0) {
			if (r>0) {
				r--;
				c=this.maxCols-1;
			}
			else {
				c=0;
			}
		}
	}
	if (this.isPrintable(this.charBuf[r][c])) {
		while (true) {
			var ri=r;
			var ci=c+1;
			if (ci==this.maxCols) {
				if (ri<this.maxLines-1) {
					ri++;
					ci=0;
				}
				else {
					break;
				}
			}
			if (!this.isPrintable(this.charBuf[ri][ci])) break;
			c=ci;
			r=ri;
		}
	}
	return [r,c];
},

_getLineStart: function(r,c) {
	// not used by now, just in case anyone needs this ...
	var ci, ri;
	if (!this.isPrintable(this.charBuf[r][c])) {
		ci=c-1;
		ri=r;
		if (ci<0) {
			if (ri==0) return [0,0];
			ci=this.maxCols-1;
			ri--;
		}
		if (!this.isPrintable(this.charBuf[ri][ci])) {
			return [r,c];
		}
		else {
			r=ri;
			c=ci;
		}
	}
	while (true) {
		var ri=r;
		var ci=c-1;
		if (ci<0) {
			if (ri==0) break;
			ci=this.maxCols-1;
			ri--;
		}
		if (!this.isPrintable(this.charBuf[ri][ci])) break;;
		r=ri;
		c=ci;
	}
	return [r,c];
},

_getLine: function(adjustCrsrPos) {
	var end=this._getLineEnd(this.r,this.c);
	var r=end[0];
	var c=end[1];
	if (adjustCrsrPos && (this.r!=r || this.c!=c+1)) {
		this.r=r;
		this.c=c+1;
		if (this.c>=this.maxCols) this.c=this.maxCols-1;
	}
	var line=new Array();
	while (this.isPrintable(this.charBuf[r][c])) {
		line[line.length]=String.fromCharCode(this.charBuf[r][c]);
		if (c>0) {
			c--;
		}
		else if (r>0) {
			c=this.maxCols-1;
			r--;
		}
		else {
			break;
		}
	}
	line.reverse();
	return line.join('');
},

_clearLine: function() {
	var end=this._getLineEnd(this.r,this.c);
	var r=end[0];
	var c=end[1];
	var line='';
	while (this.isPrintable(this.charBuf[r][c])) {
		this.charBuf[r][c]=0;
		if (c>0) {
			c--;
		}
		else if (r>0) {
			this.redraw(r);
			c=this.maxCols-1;
			r--;
		}
		else {
			break;
		}
	}
	if (r!=end[0]) this.redraw(r);
	c++;
	this.cursorSet(r,c);
	this.insert=false;
},

// backup/restore screen & state

backupScreen: function() {
	var backup=this.backupBuffer=new Object();
	var rl=this.conf.rows;
	var cl=this.conf.cols;
	backup.cbuf=new Array(rl);
	backup.sbuf=new Array(rl);
	backup.maxCols=this.maxCols;
	backup.maxLines=this.maxLines;
	backup.r=this.r;
	backup.c=this.c;
	backup.charMode=this.charMode;
	backup.rawMode=this.rawMode;
	backup.handler=this.handler;
	backup.ctrlHandler=this.ctrlHandler;
	backup.cursoractive=this.cursoractive;
	
	backup.crsrBlinkMode=this.crsrBlinkMode;
	backup.crsrBlockMode=this.crsrBlockMode;
	backup.blinkDelay=this.blinkDelay;
	backup.DELisBS=this.DELisBS;
	backup.printTab=this.printTab;
	backup.printEuro=this.printEuro;
	backup.catchCtrlH=this.catchCtrlH;
	backup.closeOnESC=this.closeOnESC;
	backup.historyUnique=this.historyUnique;
	backup.ps=this.ps;
	backup.lineBuffer=this.lineBuffer;
	backup.inputChar=this.inputChar;
	backup.lastLine=this.lastLine;
	backup.historyLength=this.history.length;
	backup.histPtr=this.histPtr;
	backup.wrapping=this.wrapping;
	backup.mapANSI=this.mapANSI;
	backup.ANSItrueBlack=this.ANSItrueBlack;
	if (this.cursoractive) this.cursorOff();
	for (var r=0; r<rl; r++) {
		var cbr=this.charBuf[r];
		var sbr=this.styleBuf[r];
		var tcbr=backup.cbuf[r]=new Array(cl);
		var tsbr=backup.sbuf[r]=new Array(cl);
		for (var c=0; c<cl; c++) {
			tcbr[c]=cbr[c];
			tsbr[c]=sbr[c];
		}
	}
},

restoreScreen: function() {
	var backup=this.backupBuffer;
	if (!backup) return;
	var rl=this.conf.rows;
	for (var r=0; r<rl; r++) {
		this.charBuf[r]=backup.cbuf[r];
		this.styleBuf[r]=backup.sbuf[r];
		this.redraw(r);
	}
	this.maxCols=backup.maxCols;
	this.maxLines=backup.maxLines;
	this.r=backup.r;
	this.c=backup.c;
	this.charMode=backup.charMode;
	this.rawMode=backup.rawMode;
	this.handler=backup.handler;
	this.ctrlHandler=backup.ctrlHandler;
	this.cursoractive=backup.cursoractive;
	this.crsrBlinkMode=backup.crsrBlinkMode;
	this.crsrBlockMode=backup.crsrBlockMode;
	this.blinkDelay=backup.blinkDelay;
	this.DELisBS=backup.DELisBS;
	this.printTab=backup.printTab;
	this.printEuro=backup.printEuro;
	this.catchCtrlH=backup.catchCtrlH;
	this.closeOnESC=backup.closeOnESC;
	this.historyUnique=backup.historyUnique;
	this.ps=backup.ps;
	this.lineBuffer=backup.lineBuffer;
	this.inputChar=backup.inputChar;
	this.lastLine=backup.lastLine;
	if (this.history.length>backup.historyLength) {
		this.history.length=backup.historyLength;
		this.histPtr=backup.histPtr;
	}
	this.wrapping=backup.wrapping;
	this.mapANSI=backup.mapANSI;
	this.ANSItrueBlack=backup.ANSItrueBlack;
	if (this.cursoractive) this.cursorOn();
	this.backupBuffer=null;
},

swapBackup: function() {
	// swap current state and backup buffer (e.g.: toggle do/undo)
	var backup=this.backupBuffer;
	this.backupScreen;
	if (backup) {
		var backup2=this.backupBuffer;
		this.backupBuffer=backup;
		this.restoreScreen();
		this.backupBuffer=backup2;
	}
},

// simple markup escaping

escapeMarkup: function(t) {
	return t.replace(/%/g, '%%');
},

// field mode

enterFieldMode: function(start, end, style) {
	this.cursorOff();
	if (start===undefined || start<0) start=this.c;
	if (end=== undefined || end<start || end>this.maxCols) end=this.maxCols;
	if (!style) style=0;
	this.fieldStart=start;
	this.fieldEnd=end;
	this.fieldStyle=style;
	this.fieldC=0;
	this.lastLine='';
	this.fieldMode=true;
	this.rawMode=this.charMode=false;
	if (style&1) {
		this._crsrWasBlockMode=this.crsrBlockMode;
		this._crsrWasBlinkMode=this.crsrBlinkMode;
		this.crsrBlockMode=false;
		this.crsrBlinkMode=true;
	}
	this.drawField();
	this.lock=false;
},

exitFieldMode: function() {
	this.drawField(true);
	this.fieldMode=false;
	this.c=this.fieldEnd;
	if (this.c==this.maxLine) this.newLine();
	this.lock=true;
},

drawField: function(isfinal) {
	this.cursorOff();
	if (isfinal) this.fieldC=0;
	var fl=this.fieldEnd-this.fieldStart;
	if (this.fieldC==this.lastLine.length) fl--;
	var ofs=this.fieldC-fl;
	if (ofs<0) ofs=0;
	var line = (ofs)?  this.lastLine.substring(ofs):this.lastLine;
	var sb=this.styleBuf[this.r];
	var cb=this.charBuf[this.r];
	var max=line.length;
	for (var i=this.fieldStart, k=0; i<this.fieldEnd; i++, k++) {
		sb[i]=this.fieldStyle;
		cb[i]=(k<max)? line.charCodeAt(k):0;
	}
	this.redraw(this.r);
	if (isfinal) {
		if (this.fieldStyle&1) {
			this.crsrBlockMode=this._crsrWasBlockMode;
			this.crsrBlinkMode=this._crsrWasBlinkMode;
			delete this._crsrWasBlockMode;
			delete this._crsrWasBlinkMode;
		}
	}
	else {
		this.c=this.fieldStart+this.fieldC-ofs;
		this.cursorOn();
	}
},

// keyboard focus

focus: function() {
	this.globals.setFocus(this);
},

// a inner reference (just for comfort) to be mapped to Terminal.prototype.globals.termKey
termKey: null,


// GUI related methods

_makeTerm: function(rebuild) {
	window.status='Building terminal ...';
	var divPrefix=this.termDiv+'_r';
	if (this.domAPI) {
		// if applicable we're using createElement
		this.globals.hasSubDivs=false;
		var td, row, table, tbody, table2, tbody2, tr, td, node;
		table=document.createElement('table');
		table.setAttribute('border', 0);
		table.setAttribute('cellSpacing', 0);
		table.setAttribute('cellPadding', this.conf.frameWidth);
		tbody=document.createElement('tbody');
		table.appendChild(tbody);
		row=document.createElement('tr');
		tbody.appendChild(row);
		ptd=document.createElement('td');
		ptd.style.backgroundColor=this.conf.frameColor;
		row.appendChild(ptd);
		table2=document.createElement('table');
		table2.setAttribute('border', 0);
		table2.setAttribute('cellSpacing', 0);
		table2.setAttribute('cellPadding', 2);
		tbody2=document.createElement('tbody');
		table2.appendChild(tbody2);
		tr=document.createElement('tr');
		tbody2.appendChild(tr);
		td=document.createElement('td');
		td.style.backgroundColor=this.conf.bgColor;
		tr.appendChild(td);
		ptd.appendChild(table2);
		ptd=td;
		table2=document.createElement('table');
		table2.setAttribute('border', 0);
		table2.setAttribute('cellSpacing', 0);
		table2.setAttribute('cellPadding', 0);
		tbody2=document.createElement('tbody');
		table2.appendChild(tbody2);
		var rstr='';
		for (var c=0; c<this.conf.cols; c++) rstr+='&nbsp;';
		for (var r=0; r<this.conf.rows; r++) {
			tr=document.createElement('tr');
			td=document.createElement('td');
			td.id=divPrefix+r;
			td.style.height=td.style.minHeight=td.style.maxHeight=this.conf.rowHeight+'px';
			td.style.whiteSpace='nowrap';
			td.className=this.conf.fontClass;
			td.innerHTML=rstr;
			tr.appendChild(td);
			tbody2.appendChild(tr);
		}
		ptd.appendChild(table2);
		node=document.getElementById(this.termDiv);
		while (node.hasChildNodes()) node.removeChild(node.firstChild);
		node.appendChild(table);
	}
	else {
		// legacy code
		this.globals.hasSubDivs=(navigator.userAgent.indexOf('Gecko')<0);
		var s='',
			bgColorAttribute = (this.conf.bgColor && (this.conf.bgColor!=='none' || this.conf.bgColor!='transparent'))? ' bgcolor="'+this.conf.bgColor+'"':'',
			frameColorAttribute = (this.conf.frameColor && (this.conf.frameColor!=='none' || this.conf.frameColor!='transparent'))? ' bgcolor="'+this.conf.frameColor+'"':'';
		s+='<table border="0" cellspacing="0" cellpadding="'+this.conf.frameWidth+'">\n';
		s+='<tr><td'+frameColorAttribute+'><table border="0" cellspacing="0" cellpadding="2"><tr><td'+bgColorAttribute+'><table border="0" cellspacing="0" cellpadding="0">\n';
		var rstr='';
		for (var c=0; c<this.conf.cols; c++) rstr+='&nbsp;';
		for (var r=0; r<this.conf.rows; r++) {
			var termid=(this.globals.hasSubDivs)? '' : ' id="'+divPrefix+r+'"';
			s+='<tr><td nowrap height="'+this.conf.rowHeight+'"'+termid+' class="'+this.conf.fontClass+'">'+rstr+'<\/td><\/tr>\n';
		}
		s+='<\/table><\/td><\/tr>\n';
		s+='<\/table><\/td><\/tr>\n';
		s+='<\/table>\n';
		var termOffset=2+this.conf.frameWidth;
		if (this.globals.hasSubDivs) {
			for (var r=0; r<this.conf.rows; r++) {
				s+='<div id="'+divPrefix+r+'" style="position:absolute; top:'+(termOffset+r*this.conf.rowHeight)+'px; left: '+termOffset+'px;" class="'+this.conf.fontClass+'"><\/div>\n';
			}
			this.globals.termStringStart='<table border="0" cellspacing="0" cellpadding="0"><tr><td nowrap height="'+this.conf.rowHeight+'" class="'+this.conf.fontClass+'">';
			this.globals.termStringEnd='<\/td><\/tr><\/table>';
		}
		this.globals.writeElement(this.termDiv,s);
	}
	if (!rebuild) {
		this.globals.setElementXY(this.termDiv,this.conf.x,this.conf.y);
		this.globals.setVisible(this.termDiv,1);
	}
	window.status='';
},

rebuild: function() {
	// check for bounds and array lengths
	var rl=this.conf.rows;
	var cl=this.conf.cols;
	for (var r=0; r<rl; r++) {
		var cbr=this.charBuf[r];
		if (!cbr) {
			this.charBuf[r]=this.getRowArray(cl,0);
			this.styleBuf[r]=this.getRowArray(cl,0);
		}
		else if (cbr.length<cl) {
			for (var c=cbr.length; c<cl; c++) {
				this.charBuf[r][c]=0;
				this.styleBuf[r][c]=0;
			}
		}
	}
	var resetcrsr=false;
	if (this.r>=rl) {
		r=rl-1;
		resetcrsr=true;
	}
	if (this.c>=cl) {
		c=cl-1;
		resetcrsr=true;
	}
	if (resetcrsr && this.cursoractive) this.cursorOn();
	// and actually rebuild
	this._makeTerm(true);
	for (var r=0; r<rl; r++) {
		this.redraw(r);
	}
	// clear backup buffer to prevent errors
	this.backupBuffer=null;
},

moveTo: function(x,y) {
	this.globals.setElementXY(this.termDiv,x,y);
},

resizeTo: function(x,y) {
	if (this.termDivReady()) {
		x=parseInt(x,10);
		y=parseInt(y,10);
		if (isNaN(x) || isNaN(y) || x<4 || y<2) return false;
		this.maxCols=this.conf.cols=x;
		this.maxLines=this.conf.rows=y;
		this._makeTerm();
		this.clear();
		return true;
	}
	else {
		return false;
	}
},

redraw: function(r) {
	var s=this.globals.termStringStart;
	var curStyle=0;
	var tstls=this.globals.termStyles;
	var tscls=this.globals.termStyleClose;
	var tsopn=this.globals.termStyleOpen;
	var tspcl=this.globals.termSpecials;
	var tclrs=this.globals.colorCodes;
	var twclrs=this.globals.webColorCodes;
	var t_cb=this.charBuf;
	var t_sb=this.styleBuf;
	var blur=this.textBlur;
	var clr='';
	var textColor=this.textColor || '';
	for (var i=0; i<this.conf.cols; i++) {
		var c=t_cb[r][i];
		var cs=t_sb[r][i];
		if (cs!=curStyle || (i==0 && textColor)) {
			if (curStyle) {
				if (curStyle & 0xffff00) s+='</span>';
				for (var k=tstls.length-1; k>=0; k--) {
					var st=tstls[k];
					if (curStyle & st) s+=tscls[st];
				}
			}
			curStyle=cs;
			for (var k=0; k<tstls.length; k++) {
				var st=tstls[k];
				if (curStyle&st) s+=tsopn[st];
			}
			clr=textColor;
			var bgclr = null;
			if (curStyle & 0xff00) {
				var cc=((curStyle & 0xff00)>>>8) & 0xff;
				clr= (cc<16)? tclrs[cc] : 0;
			}
			if (curStyle & 0xff0000) {
				var bc=((curStyle & 0xff0000)>>>16) & 0xff;
				bgclr= (bc<16)? tclrs[bc] : 0;
			}
			if (clr) {
				if (curStyle&1) {
					s+='<span style="background-color:'+clr+' !important;">';
				}
				else if (typeof blur === 'object') {
					s+='<span style="color:'+clr+' !important; text-shadow: 0 0 '+blur.join('px '+clr+', 0 0 ')+'px '+clr+';">';
				}
				else if (blur) {
					 s+='<span style="color:'+clr+' !important; text-shadow: 0 0 '+blur+'px '+clr+';">';
				}
				else {
					s+='<span style="color:'+clr+' !important;' + (bgclr? ' background-color:' + bgclr + '!important;' : '') + '">';
				}
			}
		}
		s+= (tspcl[c])? tspcl[c] : String.fromCharCode(c);
	}
	if (curStyle>0) {
		if (curStyle & 0xffff00) s+='</span>';
		for (var k=tstls.length-1; k>=0; k--) {
			var st=tstls[k];
			if (curStyle&st) s+=tscls[st];
		}
	}
	s+=this.globals.termStringEnd;
	this.globals.writeElement(this.termDiv+'_r'+r,s);
},

guiReady: function() {
	var ready=true;
	if (this.globals.guiElementsReady(this.termDiv)) {
		for (var r=0; r<this.conf.rows; r++) {
			if (this.globals.guiElementsReady(this.termDiv+'_r'+r)==false) {
				ready=false;
				break;
			}
		}
	}
	else {
		ready=false;
	}
	return ready;
},

termDivReady: function() {
	if (document.getElementById) {
		return (document.getElementById(this.termDiv))? true:false;
	}
	else if (document.all) {
		return (document.all[this.termDiv])? true:false;
	}
	else {
		return false;
	}
},

getDimensions: function() {
	var w=0;
	var h=0;
	var d=this.termDiv;
	if (document.getElementById) {
		var obj=document.getElementById(d);
		if (obj && obj.firstChild) {
			w=parseInt(obj.firstChild.offsetWidth,10);
			h=parseInt(obj.firstChild.offsetHeight,10);
		}
		else if (obj && obj.children && obj.children[0]) {
			w=parseInt(obj.children[0].offsetWidth,10);
			h=parseInt(obj.children[0].offsetHeight,10);
		}
	}
	else if (document.all) {
		var obj=document.all[d];
		if (obj && obj.children && obj.children[0]) {
			w=parseInt(obj.children[0].offsetWidth,10);
			h=parseInt(obj.children[0].offsetHeight,10);
		}
	}
	return { width: w, height: h };
},


// global store for static data and methods (former "TermGlobals")

globals: {

	termToInitialze:null,
	activeTerm:null,
	kbdEnabled:false,
	keylock:false,
	keyRepeatDelay1: 450, // initial delay
	keyRepeatDelay2: 100, // consecutive delays
	keyRepeatTimer: null,
	lcMorePrompt1: ' -- MORE -- ',
	lcMorePromtp1Style: 1,
	lcMorePrompt2: ' (Type: space to continue, \'q\' to quit)',
	lcMorePrompt2Style: 0,
	lcMoreKeyAbort: 113,
	lcMoreKeyContinue: 32,

	// initialize global data structs

	_initGlobals: function() {
		var tg=Terminal.prototype.globals;
		tg._extendMissingStringMethods();
		tg._initWebColors();
		tg._initDomKeyRef();
		Terminal.prototype.termKey=tg.termKey;
	},

	// hex support (don't rely on generic support like Number.toString(16))

	getHexChar: function(c) {
		var tg=Terminal.prototype.globals;
		if (tg.isHexChar(c)) return tg.hexToNum[c];
		return -1;
	},

	isHexChar: function(c) {
		return ((c>='0' && c<='9') || (c>='a' && c<='f') || (c>='A' && c<='F'))? true:false;
	},

	isHexOnlyChar: function(c) {
		return ((c>='a' && c<='f') || (c>='A' && c<='F'))? true:false;
	},

	hexToNum: {
		'0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7,
		'8': 8, '9': 9, 'a': 10, 'b': 11, 'c': 12, 'd': 13, 'e': 14, 'f': 15,
		'A': 10, 'B': 11, 'C': 12, 'D': 13, 'E': 14, 'F': 15
	},

	// data for color support

	webColors: [],
	webColorCodes: [''],

	colors: {
		// ANSI bright (bold) color set
		black: 1,
		red: 2,
		green: 3,
		yellow: 4,
		blue: 5,
		magenta: 6,
		cyan: 7,
		white: 8,
		// dark color set
		grey: 9,
		red2: 10,
		green2: 11,
		yellow2: 12,
		blue2: 13,
		magenta2: 14,
		cyan2: 15,
		// synonyms
		red1: 2,
		green1: 3,
		yellow1: 4,
		blue1: 5,
		magenta1: 6,
		cyan1: 7,
		gray:  9,
		darkred: 10,
		darkgreen: 11,
		darkyellow: 12,
		darkblue: 13,
		darkmagenta: 14,
		darkcyan: 15,
		// default color
		'default': 0,
		clear: 0
	},

	colorCodes: [
		'', '#000000', '#ff0000', '#00ff00', '#ffff00', '#0066ff', '#ff00ff', '#00ffff', '#ffffff',
		'#808080', '#990000', '#009900', '#999900', '#003399', '#990099', '#009999'
	],

	_webSwatchChars: ['0','3','6','9','c','f'],
	_initWebColors: function() {
		// generate long and short web color ref
		var tg=Terminal.prototype.globals;
		var ws=tg._webColorSwatch;
		var wn=tg.webColors;
		var cc=tg.webColorCodes;
		var n=1;
		var a, b, c, al, bl, bs, cl;
		for (var i=0; i<6; i++) {
			a=tg._webSwatchChars[i];
			al=a+a;
			for (var j=0; j<6; j++) {
				b=tg._webSwatchChars[j];
				bl=al+b+b;
				bs=a+b;
				for (var k=0; k<6; k++) {
					c=tg._webSwatchChars[k];
					cl=bl+c+c;
					wn[bs+c]=wn[cl]=n;
					cc[n]=cl;
					n++;
				}
			}
		}
	},

	webifyColor: function(s) {
		// return nearest web color in 3 digit format
		// (do without RegExp for compatibility)
		var tg=Terminal.prototype.globals;
		if (s.length==6) {
			var c='';
			for (var i=0; i<6; i+=2) {
				var a=s.charAt(i);
				var b=s.charAt(i+1);
				if (tg.isHexChar(a) && tg.isHexChar(b)) {
					c+=tg._webSwatchChars[Math.round(parseInt(a+b,16)/255*5)];
				}
				else {
					return '';
				}
			}
			return c;
		}
		else if (s.length==3) {
			var c='';
			for (var i=0; i<3; i++) {
				var a=s.charAt(i);
				if (tg.isHexChar(a)) {
					c+=tg._webSwatchChars[Math.round(parseInt(a,16)/15*5)];
				}
				else {
					return '';
				}
			}
			return c;
		}
		else {
			return '';
		}
	},

	// public methods for color support

	setColor: function(label, value) {
		var tg=Terminal.prototype.globals;
		if (typeof label == 'number' && label>=1 && label<=15) {
			tg.colorCodes[label]=value;
		}
		else if (typeof label == 'string') {
			label=label.toLowerCase();
			if (label.length==1 && tg.isHexChar(label)) {
				var n=tg.hexToNum[label];
				if (n) tg.colorCodes[n]=value;
			}
			else if (typeof tg.colors[label] != 'undefined') {
				var n=tg.colors[label];
				if (n) tg.colorCodes[n]=value;
			}
		}
	},

	getColorString: function(label) {
		var tg=Terminal.prototype.globals;
		if (typeof label == 'number' && label>=0 && label<=15) {
			return tg.colorCodes[label];
		}
		else if (typeof label == 'string') {
			label=label.toLowerCase();
			if (label.length==1 && tg.isHexChar(label)) {
				return tg.colorCodes[tg.hexToNum[label]];
			}
			else if (typeof tg.colors[label] != 'undefined') {
				return tg.colorCodes[tg.colors[label]];
			}
		}
		return '';
	},

	getColorCode: function(label) {
		var tg=Terminal.prototype.globals;
		if (typeof label == 'number' && label>=0 && label<=15) {
			return label;
		}
		else if (typeof label == 'string') {
			label=label.toLowerCase();
			if (label.length==1 && tg.isHexChar(label)) {
				return parseInt(label,16);
			}
			else if (typeof tg.colors[label] != 'undefined') {
				return tg.colors[label];
			}
		}
		return 0;
	},

	// import/paste methods (methods return success)

	insertText: function(text) {
		// auto-types a given string to the active terminal
		// returns success (false indicates a lock or no active terminal)
		var tg=Terminal.prototype.globals;
		var termRef = tg.activeTerm;
		if (!termRef || termRef.closed || tg.keylock || termRef.lock || termRef.charMode || termRef.fieldMode) return false;
		// terminal open and unlocked, so type the text
		for (var i=0; i<text.length; i++) {
			tg.keyHandler({which: text.charCodeAt(i), _remapped:true});
		}
		return true;
	},

	importEachLine: function(text) {
		// import multiple lines of text per line each and execs
		// returns success (false indicates a lock or no active terminal)
		var tg=Terminal.prototype.globals;
		var termRef = tg.activeTerm;
		if (!termRef || termRef.closed || tg.keylock || termRef.lock || termRef.charMode || termRef.fieldMode) return false;
		// clear the current command line
		termRef.cursorOff();
		termRef._clearLine();
		// normalize line breaks
		text=text.replace(/\r\n?/g, '\n');
		// split lines and auto-type the text
		var t=text.split('\n');
		for (var i=0; i<t.length; i++) {
			for (var k=0; k<t[i].length; k++) {
				tg.keyHandler({which: t[i].charCodeAt(k), _remapped:true});
			}
			tg.keyHandler({which: term.termKey.CR, _remapped:true});
		}
		return true;
	},

	importMultiLine: function(text) {
		// importing multi-line text as single input with "\n" in lineBuffer
		var tg=Terminal.prototype.globals;
		var termRef = tg.activeTerm;
		if (!termRef || termRef.closed || tg.keylock || termRef.lock || termRef.charMode || termRef.fieldMode) return false;
		// lock and clear the line
		termRef.lock = true;
		termRef.cursorOff();
		termRef._clearLine();
		// normalize linebreaks and echo the text linewise
		text = text.replace(/\r\n?/g, '\n');
		var lines = text.split('\n');
		for (var i=0; i<lines.length; i++) {
			termRef.type(lines[i]);
			if (i<lines.length-1) termRef.newLine();
		}
		// fake <ENTER>;
		// (no history entry for this)
		termRef.lineBuffer = text;
		termRef.lastLine = '';
		termRef.inputChar = 0;
		termRef.handler();
		return true;
	},

	// text related service functions

	normalize: function(n,m) {
		var s=''+n;
		while (s.length<m) s='0'+s;
		return s;
	},

	fillLeft: function(t,n) {
		if (typeof t != 'string') t=''+t;
		while (t.length<n) t=' '+t;
		return t;
	},

	center: function(t,l) {
		var s='';
		for (var i=t.length; i<l; i+=2) s+=' ';
		return s+t;
	},

	// simple substitute for String.replace()
	stringReplace: function(s1,s2,t) {
		var l1=s1.length;
		var l2=s2.length;
		var ofs=t.indexOf(s1);
		while (ofs>=0) {
			t=t.substring(0,ofs)+s2+t.substring(ofs+l1);
			ofs=t.indexOf(s1,ofs+l2);
		}
		return t;
	},


	// config data for text wrap

	wrapChars: {
		// keys: charCode
		// values: 1 = white space, 2 = wrap after, 3 = wrap before, 4 = conditional word break
		9:   1, // tab
		10:  1, // new line - don't change this (used internally)!!!
		12:  4, // form feed (use this for conditional word breaks)
		13:  1, // cr
		32:  1, // blank
		40:  3, // (
		45:  2, // dash/hyphen
		61:  2, // =
		91:  3, // [
		94:  3, // caret (non-printing chars)
		123: 3  // {
	},


	// keyboard methods & controls

	setFocus: function(termref) {
		Terminal.prototype.globals.activeTerm=termref;
		Terminal.prototype.globals.clearRepeatTimer();
	},

	termKey: {
		// codes of special keys
		'NUL': 0x00,
		'SOH': 0x01,
		'STX': 0x02,
		'ETX': 0x03,
		'EOT': 0x04,
		'ENQ': 0x05,
		'ACK': 0x06,
		'BEL': 0x07,
		'BS': 0x08,
		'BACKSPACE': 0x08,
		'HT': 0x09,
		'TAB': 0x09,
		'LF': 0x0A,
		'VT': 0x0B,
		'FF': 0x0C,
		'CR': 0x0D,
		'SO': 0x0E,
		'SI': 0x0F,
		'DLE': 0x10,
		'DC1': 0x11,
		'DC2': 0x12,
		'DC3': 0x13,
		'DC4': 0x14,
		'NAK': 0x15,
		'SYN': 0x16,
		'ETB': 0x17,
		'CAN': 0x18,
		'EM': 0x19,
		'SUB': 0x1A,
		'ESC': 0x1B,
		'IS4': 0x1C,
		'IS3': 0x1D,
		'IS2': 0x1E,
		'IS1': 0x1F,
		'DEL': 0x7F,
		// other specials
		'EURO': 0x20AC,
		// cursor mapping
		'LEFT': 0x1C,
		'RIGHT': 0x1D,
		'UP': 0x1E,
		'DOWN': 0x1F
	},

	// map some DOM_VK_* properties to values defined in termKey
	termDomKeyRef: {},
	_domKeyMappingData: {
		'LEFT': 'LEFT',
		'RIGHT': 'RIGHT',
		'UP': 'UP',
		'DOWN': 'DOWN',
		'BACK_SPACE': 'BS',
		'RETURN': 'CR',
		'ENTER': 'CR',
		'ESCAPE': 'ESC',
		'DELETE': 'DEL',
		'TAB': 'TAB'
	},
	_initDomKeyRef: function() {
		var tg=Terminal.prototype.globals;
		var m=tg._domKeyMappingData;
		var r=tg.termDomKeyRef;
		var k=tg.termKey;
		for (var i in m) r['DOM_VK_'+i]=k[m[i]];
	},
	
	registerEvent: function(obj, eventType, handler, capture) {
		if (obj.addEventListener) {
			obj.addEventListener(eventType.toLowerCase(), handler, capture);
		}
		/*
		else if (obj.attachEvent) {
			obj.attachEvent('on'+eventType.toLowerCase(), handler);
		}
		*/
		else {
			var et=eventType.toUpperCase();
			if (window.Event && window.Event[et] && obj.captureEvents) obj.captureEvents(Event[et]);
			obj['on'+eventType.toLowerCase()]=handler;
		}
	},
	releaseEvent: function(obj, eventType, handler, capture) {
		if (obj.removeEventListener) {
			obj.removeEventListener(eventType.toLowerCase(), handler, capture);
		}
		/*
		else if (obj.detachEvent) {
			obj.detachEvent('on'+eventType.toLowerCase(), handler);
		}
		*/
		else {
			var et=eventType.toUpperCase();
			if (window.Event && window.Event[et] && obj.releaseEvents) obj.releaseEvents(Event[et]);
			et='on'+eventType.toLowerCase();
			if (obj[et] && obj[et]==handler) obj.et=null;
		}
	},

	enableKeyboard: function(term) {
		var tg=Terminal.prototype.globals;
		if (!tg.kbdEnabled) {
			tg.registerEvent(document, 'keypress', tg.keyHandler, true);
			tg.registerEvent(document, 'keydown', tg.keyFix, true);
			tg.registerEvent(document, 'keyup', tg.clearRepeatTimer, true);
			tg.kbdEnabled=true;
		}
		tg.activeTerm=term;
	},

	disableKeyboard: function(term) {
		var tg=Terminal.prototype.globals;
		if (tg.kbdEnabled) {
			tg.releaseEvent(document, 'keypress', tg.keyHandler, true);
			tg.releaseEvent(document, 'keydown', tg.keyFix, true);
			tg.releaseEvent(document, 'keyup', tg.clearRepeatTimer, true);
			tg.kbdEnabled=false;
		}
		tg.activeTerm=null;
	},

	// remap some special key mappings on keydown

	keyFix: function(e) {
		var tg=Terminal.prototype.globals;
		var term=tg.activeTerm;
		var ch;
		if (tg.keylock || term.lock) return true;
		if (window.event) {
			if  (!e) e=window.event;
			ch=e.keyCode;
			if (e.DOM_VK_UP) {
				for (var i in tg.termDomKeyRef) {
					if (e[i] && ch == e[i]) {
						tg.keyHandler({which:tg.termDomKeyRef[i],_remapped:true,_repeat:(ch==0x1B)? true:false});
						if (e.preventDefault) e.preventDefault();
						if (e.stopPropagation) e.stopPropagation();
						e.cancelBubble=true;
						return false;
					}
				}
				e.cancelBubble=false;
				return true;
			}
			else {
				// no DOM support
				var termKey=term.termKey;
				var keyHandler=tg.keyHandler;
				if (ch==8 && !term.isOpera) { keyHandler({which:termKey.BS,_remapped:true,_repeat:true}); }
				else if (ch==9) { keyHandler({which:termKey.TAB,_remapped:true,_repeat: (term.printTab)? false:true}); }
				else if (ch==27) { keyHandler({which:termKey.ESC,_remapped:true,_repeat: (term.printTab)? false:true}); }
				else if (ch==37) { keyHandler({which:termKey.LEFT,_remapped:true,_repeat:true}); }
				else if (ch==39) { keyHandler({which:termKey.RIGHT,_remapped:true,_repeat:true}); }
				else if (ch==38) { keyHandler({which:termKey.UP,_remapped:true,_repeat:true}); }
				else if (ch==40) { keyHandler({which:termKey.DOWN,_remapped:true,_repeat:true}); }
				else if (ch==127 || ch==46) { keyHandler({which:termKey.DEL,_remapped:true,_repeat:true}); }
				else if (ch>=57373 && ch<=57376) {
					if (ch==57373) { keyHandler({which:termKey.UP,_remapped:true,_repeat:true}); }
					else if (ch==57374) { keyHandler({which:termKey.DOWN,_remapped:true,_repeat:true}); }
					else if (ch==57375) { keyHandler({which:termKey.LEFT,_remapped:true,_repeat:true}); }
					else if (ch==57376) { keyHandler({which:termKey.RIGHT,_remapped:true,_repeat:true}); }
				}
				else {
					e.cancelBubble=false;
					return true;
				}
				if (e.preventDefault) e.preventDefault();
				if (e.stopPropagation) e.stopPropagation();
				e.cancelBubble=true;
				return false;
			}
		}
	},
	
	clearRepeatTimer: function(e) {
		var tg=Terminal.prototype.globals;
		if (tg.keyRepeatTimer) {
			clearTimeout(tg.keyRepeatTimer);
			tg.keyRepeatTimer=null;
		}
	},
	
	doKeyRepeat: function(ch) {
		Terminal.prototype.globals.keyHandler({which:ch,_remapped:true,_repeated:true})
	},

	keyHandler: function(e) {
		var tg=Terminal.prototype.globals;
		var term=tg.activeTerm;
		if (tg.keylock || term.lock || term.isMac && e && e.metaKey) return true;
		if (window.event) {
			if (window.event.preventDefault) window.event.preventDefault();
			if (window.event.stopPropagation) window.event.stopPropagation();
		}
		else if (e) {
			if (e.preventDefault) e.preventDefault();
			if (e.stopPropagation) e.stopPropagation();
		}
		var ch;
		var ctrl=false;
		var shft=false;
		var remapped=false;
		var termKey=term.termKey;
		var keyRepeat=0;
		if (e) {
			ch=e.which;
			ctrl=((e.ctrlKey && !e.altKey) || e.modifiers==2);
			shft=(e.shiftKey || e.modifiers==4);
			if (e._remapped) {
				remapped=true;
				if (window.event) {
					//ctrl=(ctrl || window.event.ctrlKey);
					ctrl=(ctrl || (window.event.ctrlKey && !window.event.altKey));
					shft=(shft || window.event.shiftKey);
				}
			}
			if (e._repeated) {
				keyRepeat=2;
			}
			else if (e._repeat) {
				keyRepeat=1;
			}
		}
		else if (window.event) {
			ch=window.event.keyCode;
			//ctrl=(window.event.ctrlKey);
			ctrl=(window.event.ctrlKey && !window.event.altKey); // allow alt gr == ctrl alt
			shft=(window.event.shiftKey);
			if (window.event._repeated) {
				keyRepeat=2;
			}
			else if (window.event._repeat) {
				keyRepeat=1;
			}
		}
		else {
			return true;
		}
		if (ch=='' && remapped==false) {
			// map specials
			if (e==null) e=window.event;
			if (e.charCode==0 && e.keyCode) {
				if (e.DOM_VK_UP) {
					var dkr=tg.termDomKeyRef;
					for (var i in dkr) {
						if (e[i] && e.keyCode == e[i]) {
							ch=dkr[i];
							break;
						}
					}
				}
				else {
					// NS4
					if (e.keyCode==28) { ch=termKey.LEFT; }
					else if (e.keyCode==29) { ch=termKey.RIGHT; }
					else if (e.keyCode==30) { ch=termKey.UP; }
					else if (e.keyCode==31) { ch=termKey.DOWN; }
					// Mozilla alike but no DOM support
					else if (e.keyCode==37) { ch=termKey.LEFT; }
					else if (e.keyCode==39) { ch=termKey.RIGHT; }
					else if (e.keyCode==38) { ch=termKey.UP; }
					else if (e.keyCode==40) { ch=termKey.DOWN; }
					// just to have the TAB mapping here too
					else if (e.keyCode==9) { ch=termKey.TAB; }
				}
			}
		}
		// leave on unicode private use area (might be function key etc)
		if ((ch>=0xE000) && (ch<= 0xF8FF)) return;
		if (keyRepeat) {
			tg.clearRepeatTimer();
			tg.keyRepeatTimer = window.setTimeout(
				'Terminal.prototype.globals.doKeyRepeat('+ch+')',
				(keyRepeat==1)? tg.keyRepeatDelay1:tg.keyRepeatDelay2
			);
		}
		// key actions
		if (term.charMode) {
			term.insert=false;
			term.inputChar=ch;
			term.lineBuffer='';
			term.handler();
			if (ch<=32 && window.event) window.event.cancelBubble=true;
			return false;
		}
		if (!ctrl) {
			// special keys
			if (ch==termKey.CR) {
				term.lock=true;
				term.cursorOff();
				term.insert=false;
				if (term.rawMode) {
					term.lineBuffer=term.lastLine;
				}
				else if (term.fieldMode) {
					term.lineBuffer=term.lastLine;
					term.exitFieldMode();
				}
				else {
					term.lineBuffer=term._getLine(true);
					if (
						term.lineBuffer!='' &&
						(!term.historyUnique || term.history.length==0 ||
						term.lineBuffer!=term.history[term.history.length-1])
					   ) {
						term.history[term.history.length]=term.lineBuffer;
					}
					term.histPtr=term.history.length;
				}
				term.lastLine='';
				term.inputChar=0;
				term.handler();
				if (window.event) window.event.cancelBubble=true;
				return false;
			}
			else if (term.fieldMode) {
				if (ch==termKey.ESC) {
					term.lineBuffer=term.lastLine='';
					term.exitFieldMode();
					term.lastLine='';
					term.inputChar=0;
					term.handler();
					if (window.event) window.event.cancelBubble=true;
					return false;
				}
				else if (ch==termKey.LEFT) {
					if (term.fieldC>0) term.fieldC--;
				}
				else if (ch==termKey.RIGHT) {
					if (term.fieldC<term.lastLine.length) term.fieldC++;
				}
				else if (ch==termKey.BS) {
					if (term.fieldC>0) {
						term.lastLine=term.lastLine.substring(0,term.fieldC-1)+term.lastLine.substring(term.fieldC);
						term.fieldC--;
					}
				}
				else if (ch==termKey.DEL) {
					if (term.fieldC<term.lastLine.length) {
						term.lastLine=term.lastLine.substring(0,term.fieldC)+term.lastLine.substring(term.fieldC+1);
					}
				}
				else if (ch>=32) {
					term.lastLine=term.lastLine.substring(0,term.fieldC)+String.fromCharCode(ch)+term.lastLine.substring(term.fieldC);
					term.fieldC++;
				}
				term.drawField();
				return false;
			}
			else if (ch==termKey.ESC && term.conf.closeOnESC) {
				term.close();
				if (window.event) window.event.cancelBubble=true;
				return false;
			}
			if (ch<32 && term.rawMode) {
				if (window.event) window.event.cancelBubble=true;
				return false;
			}
			else {
				if (ch==termKey.LEFT) {
					term.cursorLeft();
					if (window.event) window.event.cancelBubble=true;
					return false;
				}
				else if (ch==termKey.RIGHT) {
					term.cursorRight();
					if (window.event) window.event.cancelBubble=true;
					return false;
				}
				else if (ch==termKey.UP) {
					term.cursorOff();
					if (term.histPtr==term.history.length) term.lastLine=term._getLine();
					term._clearLine();
					if (term.history.length && term.histPtr>=0) {
						if (term.histPtr>0) term.histPtr--;
						term.type(term.history[term.histPtr]);
					}
					else if (term.lastLine) {
						term.type(term.lastLine);
					}
					term.cursorOn();
					if (window.event) window.event.cancelBubble=true;
					return false;
				}
				else if (ch==termKey.DOWN) {
					term.cursorOff();
					if (term.histPtr==term.history.length) term.lastLine=term._getLine();
					term._clearLine();
					if (term.history.length && term.histPtr<=term.history.length) {
						if (term.histPtr<term.history.length) term.histPtr++;
						if (term.histPtr<term.history.length) {
							term.type(term.history[term.histPtr]);
						}
						else if (term.lastLine) {
							term.type(term.lastLine);
						}
					}
					else if (term.lastLine) {
						term.type(term.lastLine);
					}
					term.cursorOn();
					if (window.event) window.event.cancelBubble=true;
					return false;
				}
				else if (ch==termKey.BS) {
					term.backspace();
					if (window.event) window.event.cancelBubble=true;
					return false;
				}
				else if (ch==termKey.DEL) {
					if (term.DELisBS) {
						term.backspace();
					}
					else {
						term.fwdDelete();
					}
					if (window.event) window.event.cancelBubble=true;
					return false;
				}
			}
		}
		if (term.rawMode) {
			if (term.isPrintable(ch)) {
				term.lastLine+=String.fromCharCode(ch);
			}
			if (ch==32 && window.event) {
				window.event.cancelBubble=true;
			}
			else if (window.opera && window.event) {
				window.event.cancelBubble=true;
			}
			return false;
		}
		else {
			if (term.conf.catchCtrlH && (ch==termKey.BS || (ctrl && ch==72))) {
				// catch ^H
				term.backspace();
				if (window.event) window.event.cancelBubble=true;
				return false;
			}
			else if (term.ctrlHandler && (ch<32 || (ctrl && term.isPrintable(ch,true)))) {
				if ((ch>=65 && ch<=96) || ch==63) {
					// remap canonical
					if (ch==63) {
						ch=31;
					}
					else {
						ch-=64;
					}
				}
				term.inputChar=ch;
				term.ctrlHandler();
				if (window.event) window.event.cancelBubble=true;
				return false;
			}
			else if (ctrl || !term.isPrintable(ch,true)) {
				if (window.event) window.event.cancelBubble=true;
				return false;
			}
			else if (term.isPrintable(ch,true)) {
				if (term.blinkTimer) clearTimeout(term.blinkTimer);
				if (term.insert) {
					term.cursorOff();
					term._scrollRight(term.r,term.c);
				}
				term._charOut(ch);
				term.cursorOn();
				if (ch==32 && window.event) {
					window.event.cancelBubble=true;
				}
				else if (window.opera && window.event) {
					window.event.cancelBubble=true;
				}
				return false;
			}
		}
		return true;
	},


	// gui mappings

	hasSubDivs: false,
	termStringStart: '',
	termStringEnd: '',

	termSpecials: {
		// special HTML escapes
		0: '&nbsp;',
		1: '&nbsp;',
		9: '&nbsp;',
		32: '&nbsp;',
		34: '&quot;',
		38: '&amp;',
		60: '&lt;',
		62: '&gt;',
		127: '&loz;',
		0x20AC: '&euro;'
	},

	// extensive list of max 8 styles (2^n, n<16)
	termStyles: [1,2,4,8, 16],
	// style markup: one letter keys, reserved keys: "p" (plain), "c" (color)
	termStyleMarkup: {
		'r': 1,
		'u': 2,
		'i': 4,
		's': 8,
		'b': 16 // map "b" to 16 (italics) for ANSI mapping
	},
	// mappings for styles (heading HTML)
	termStyleOpen: {
		1: '<span class="termReverse">',
		2: '<u>',
		4: '<i>',
		8: '<strike>',
		16: '<i>'
	},
	// mapping for styles (trailing HTML)
	termStyleClose: {
		1: '<\/span>',
		2: '<\/u>',
		4: '<\/i>',
		8: '<\/strike>',
		16: '</i>'
	},
	
	// method to install custom styles
	assignStyle: function(styleCode, markup, htmlOpen, htmlClose) {
		var tg=Terminal.prototype.globals;
		// check params
		if (!styleCode || isNaN(styleCode)) {
			if (styleCode>=256) {
				alert('termlib.js:\nCould not assign style.\n'+s+' is not a valid power of 2 between 0 and 256.');
				return;
			}
		}
		var s=styleCode&0xff;
		var matched=false;
		for (var i=0; i<8; i++) {
			if ((s>>>i)&1) {
				if (matched) {
					alert('termlib.js:\nCould not assign style code.\n'+s+' is not a power of 2!');
					return;
				}
				matched=true;
			}
		}
		if (!matched) {
			alert('termlib.js:\nCould not assign style code.\n'+s+' is not a valid power of 2 between 0 and 256.');
			return;
		}
		markup=String(markup).toLowerCase();
		if (markup=='c' || markup=='p') {
			alert('termlib.js:\nCould not assign mark up.\n"'+markup+'" is a reserved code.');
			return;
		}
		if (markup.length>1) {
			alert('termlib.js:\nCould not assign mark up.\n"'+markup+'" is not a single letter code.');
			return;
		}
		var exists=false;
		for (var i=0; i<tg.termStyles.length; i++) {
			if (tg.termStyles[i]==s) {
				exists=true;
				break;
			}
		}
		if (exists) {
			var m=tg.termStyleMarkup[markup];
			if (m && m!=s) {
				alert('termlib.js:\nCould not assign mark up.\n"'+markup+'" is already in use.');
				return;
			}
		}
		else {
			if (tg.termStyleMarkup[markup]) {
				alert('termlib.js:\nCould not assign mark up.\n"'+markup+'" is already in use.');
				return;
			}
			tg.termStyles[tg.termStyles.length]=s;
		}
		// install properties
		tg.termStyleMarkup[markup]=s;
		tg.termStyleOpen[s]=htmlOpen;
		tg.termStyleClose[s]=htmlClose;
	},
	
	// ANSI output mapping (styles & fg colors only)
	
	ANSI_regexp: /(\x1b\[|x9b)([0-9;]+?)([a-zA-Z])/g, // CSI ( = 0x1b+"[" or 0x9b ) + params + letter
	ANIS_SGR_codes: {
		'0': '%+p',
		'1': '%+b',
		'3': '%+i',
		'4': '%+u',
		'7': '%+r',
		'9': '%+s',
		'21': '%+u',
		'22': '%-b',
		'23': '%-i',
		'24': '%-u',
		'27': '%-r',
		'29': '%-s',
		'30': '%c(0)', // using default fg color for black (black: "%c(1)")
		'31': '%c(a)',
		'32': '%c(b)',
		'33': '%c(c)',
		'34': '%c(d)',
		'35': '%c(e)',
		'36': '%c(f)',
		'37': '%c(#999)',
		'39': '%c(0)',
		'90': '%c(9)',
		'91': '%c(2)',
		'92': '%c(3)',
		'93': '%c(4)',
		'94': '%c(5)',
		'95': '%c(6)',
		'96': '%c(7)',
		'97': '%c(8)',
		'99': '%c(0)',
		'trueBlack': '%c(1)'
	},
	
	ANSI_map: function(t, trueBlack) {
		// transform simple ANSI SGR codes to internal markup
		var tg=Terminal.prototype.globals;
		tg.ANSI_regexp.lastIndex=0;
		return t.replace(
			tg.ANSI_regexp,
			function (str, p1, p2, p3, offset, s) {
				return tg.ANSI_replace(p2, p3, trueBlack);
			}
		);
	},
	
	ANSI_replace: function(p, cmd, trueBlack) {
		var tg=Terminal.prototype.globals;
		if (cmd=='m') {
			if (p=='') {
				return tg.ANIS_SGR_codes[0];
			}
			else if (trueBlack && p=='30') {
				return tg.ANIS_SGR_codes.trueBlack;
			}
			else if (tg.ANIS_SGR_codes[p]) {
				return tg.ANIS_SGR_codes[p];
			}
		}
		return '';
	},


	// basic DHTML dynamics and browser abstraction

	writeElement: function(e,t) {
		if (document.getElementById) {
			var obj=document.getElementById(e);
			obj.innerHTML=t;
		}
		else if (document.all) {
			document.all[e].innerHTML=t;
		}
	},

	setElementXY: function(d,x,y) {
		if (document.getElementById) {
			var obj=document.getElementById(d);
			obj.style.left=x+'px';
			obj.style.top=y+'px';
		}
		else if (document.all) {
			document.all[d].style.left=x+'px';
			document.all[d].style.top=y+'px';
		}
	},

	setVisible: function(d,v) {
		if (document.getElementById) {
			var obj=document.getElementById(d);
			obj.style.visibility= (v)? 'visible':'hidden';
		}
		else if (document.all) {
			document.all[d].style.visibility= (v)? 'visible':'hidden';
		}
	},

	setDisplay: function(d,v) {
		if (document.getElementById) {
			var obj=document.getElementById(d);
			obj.style.display=v;
		}
		else if (document.all) {
			document.all[d].style.display=v;
		}
	},

	guiElementsReady: function(e) {
		if (document.getElementById) {
			return (document.getElementById(e))? true:false;
		}
		else if (document.all) {
			return (document.all[e])? true:false;
		}
		else {
			return false;
		}
	},


	// constructor mods (MSIE fixes)

	_termString_makeKeyref: function() {
		var tg=Terminal.prototype.globals;
		var termString_keyref= tg.termString_keyref= new Array();
		var termString_keycoderef= tg.termString_keycoderef= new Array();
		var hex= new Array('A','B','C','D','E','F');
		for (var i=0; i<=15; i++) {
			var high=(i<10)? i:hex[i-10];
			for (var k=0; k<=15; k++) {
				var low=(k<10)? k:hex[k-10];
				var cc=i*16+k;
				if (cc>=32) {
					var cs=unescape("%"+high+low);
					termString_keyref[cc]=cs;
					termString_keycoderef[cs]=cc;
				}
			}
		}
	},

	_extendMissingStringMethods: function() {
		if (!String.fromCharCode || !String.prototype.charCodeAt) {
			Terminal.prototype.globals._termString_makeKeyref();
		}
		if (!String.fromCharCode) {
			String.fromCharCode=function(cc) {
				return (cc!=null)? Terminal.prototype.globals.termString_keyref[cc] : '';
			};
		}
		if (!String.prototype.charCodeAt) {
			String.prototype.charCodeAt=function(n) {
				cs=this.charAt(n);
				return (Terminal.prototype.globals.termString_keycoderef[cs])?
					Terminal.prototype.globals.termString_keycoderef[cs] : 0;
			};
		}
	}

	// end of Terminal.prototype.globals
}

// end of Terminal.prototype
}

// initialize global data
Terminal.prototype.globals._initGlobals();

// global entities for backward compatibility with termlib 1.x applications
var TerminalDefaults = Terminal.prototype.Defaults;
var termDefaultHandler = Terminal.prototype.defaultHandler;
var TermGlobals = Terminal.prototype.globals;
var termKey = Terminal.prototype.globals.termKey;
var termDomKeyRef = Terminal.prototype.globals.termDomKeyRef;

// eof
