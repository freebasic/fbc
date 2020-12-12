var __fb_rtlib = 
{
	console:
	{
		term: null,
		divId: 'termDiv',
		fg_color: '8',
		bg_color: '1',
		cols: 80,
		rows: 25,
		
		open: function(cols, rows)
		{
			if( this.term === null )
			{
				if( typeof Terminal !== 'undefined' )
				{
					this.cols = !cols? cols: 80;
					this.rows = !rows? rows: 25;
						
					this.term = new Terminal(
					{
						'x': 0,
						'y': 0,
						'cols': this.cols,
						'rows': this.rows,
						termDiv: this.divId,
						bgColor: '#000000',
						textColor: '#FFFFFF',
						catchCtrlH: false,
						closeOnESC: false,
						greeting: '',
						crsrBlockMode: false,
						initHandler: this.termInitHandler,
						handler: this.termHandler
						//exitHandler: this.termExitHandler
					});			
					
					this.term.open();
					this.term.resizeTo(cols, rows);
				}
			}
		},
		
		close: function()
		{
			if( this.term !== null )
			{
			}
		},
		
		write: function(text)
		{
			if( this.term === null )
			{
				console.log(text);
				return;
			}
			
			this.term.write('%c(' + this.fg_color + ',' + this.bg_color + ')' + text.replace('%(', '%%('));
		},
		
		writeSubs: function(text, len)
		{
			this.write(text.substr(0, len));
		},

		input: function()
		{
			var t=prompt();
			this.write(t+"\n");
			return t;
		},
		
		color_set: function(fg, bg)
		{
			if( fg >= 0 && fg <= 15 )
				this.fg_color = fg;
			
			if( bg >= 0 && bg <= 15 )
				this.bg_color = bg;
		},
		
		color_get: function()
		{
			return (this.bg_color << 8) | this.fg_color;
		},
		
		clear: function()
		{
			if( this.term !== null )
				this.term.clear();
		},
		
		pos_set: function(row, col)
		{
			if( this.term !== null )
				this.term.cursorSet(row, col);
		},

		pos_get: function()
		{
			if( this.term !== null )
				return (this.term.r << 8) | this.term.c;
			else
				return 0;
		},
		
		size_get: function()
		{
			if( this.term !== null )
				return (this.rows << 8) | this.cols;
			else
				return 0;
		},

		size_set: function(cols, rows)
		{
			if( this.term !== null )
			{
				if( this.term.resizeTo(cols, rows) )
				{
					this.rows = rows; 
					this.cols = cols;
					return true;
				}
				return false;
			}
			else
				return false;
		},
		
		charAt: function(col, row)
		{
			if( this.term === null || 
				col < 0 || col >= this.cols || 
				row < 0 || row >= this.rows )
				return 0;
				
			return this.term.charBuf[row][col];
		},

		colorAt: function(col, row)
		{
			if( this.term === null || 
				col < 0 || col >= this.cols || 
				row < 0 || row >= this.rows )
				return 0;
				
			return this.term.styleBuf[row][col];
		},
		
		requestFullScreen: function()
		{
			if( this.term === null )
				return false;
			
			var target = document.getElementById(this.divId);
			
			if (target.requestFullscreen) 
			  target.requestFullscreen();
			else if (target.msRequestFullscreen) 
			  target.msRequestFullscreen();
			else if (target.mozRequestFullScreen) 
			  target.mozRequestFullScreen();
			else if (target.mozRequestFullscreen) 
			  target.mozRequestFullscreen();
			else if (target.webkitRequestFullscreen) 
			  target.webkitRequestFullscreen();
			else
				return false;
			
			return true;
		},
		
		termInitHandler: function()
		{
			this.lock = false
		},
		
		termHandler: function()
		{
			this.lock = false
		}
	}
};
