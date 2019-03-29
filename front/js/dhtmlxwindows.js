//v.3.6 build 130417

/*
Copyright DHTMLX LTD. http://www.dhtmlx.com
You allowed to use this component or parts of it under GPL terms
To use it on other terms or get Professional edition of the component please contact us at sales@dhtmlx.com
*/
/**
*	@desc: constructor, creates a single window under dhtmlxWindows system
*	@pseudonym: win
*	@type: public
*/
function dhtmlXWindowsSngl(){
 	
}
/**
*	@desc: constructor, creates a button for a window under dhtmlxWindows system
*	@pseudonym: btn
*	@type: public
*/
function dhtmlXWindowsBtn(){
 	
}

/**
*   @desc: constructor, creates a new dhtmlxWindows object
*   @type: public
*/

function dhtmlXWindows() {
	
	if (!window.dhtmlXContainer) {
		alert(this.i18n.dhx);
		return;
	}
	// engine
	this.engine = "dhx";
	// this.engine = "clear";
	var engineFunc = "_"+this.engine+"_Engine";
	if (!this[engineFunc]) {
		alert(this.i18n.noenginealert);
		return;
	} else {
		this[engineFunc]();
	}
	
	this._isIPad = (navigator.userAgent.search(/iPad/gi)>=0);
	
	var that = this;
	// image manipulation
	this.pathPrefix = "dhxwins_";
	this.imagePath = dhtmlx.image_path||"codebase/imgs/";
	/**
	*   @desc: sets path to the directory where used images are located
	*   @param: path - url to the directory where images are located
	*   @type: public
	*/
	this.setImagePath = function(path) {
		this.imagePath = path;
	}
	
	// skins
	this.skin = (typeof(dhtmlx) != "undefined" && typeof(dhtmlx.skin) == "string" ? dhtmlx.skin : "dhx_skyblue");
	this.skinParams = { // dhx
			    "dhx_black"		: { "header_height": 21, "border_left_width": 2, "border_right_width": 2, "border_bottom_height": 2 },
			    "dhx_blue"		: { "header_height": 21, "border_left_width": 2, "border_right_width": 2, "border_bottom_height": 2 },
			    "dhx_skyblue"	: { "header_height": 21, "border_left_width": 2, "border_right_width": 2, "border_bottom_height": 2 }
	};
	/**
	*   @desc: changes window's skin
	*   @param: skin - skin's name
	*   @type: public
	*/
	this.setSkin = function(skin) {
		this.skin = skin;
		this._engineRedrawSkin();
		
		//this.skin = skin;
		//this._redrawSkin();
	}
	/*
	this._redrawSkin = function() {
		
		for (var a in this.wins) {
			var win = this.wins[a];
			var skinParams = (win._skinParams!=null?win._skinParams:this.skinParams[this.skin]);
			//
			win.childNodes[0].className = "dhtmlx_wins_"+this.skin;
			// icon
			win.childNodes[1].className = "dhtmlx_wins_icon_"+this.skin;
			this._restoreWindowIcons(win);
			// title
			win.childNodes[2].className = "dhtmlx_wins_title_"+this.skin;
			// butons
			win.childNodes[3].className = "dhtmlx_wins_buttons_"+this.skin;
			// this._redrawWindow(win);
			// this._engineRedrawWindowSize(win);
			alert("stop PGhNyVSe");
			
		}
		// this._restoreWindowIcons(this.getTopmostWindow());
	}
	*/
	// return true if window with specified id is exists
	/**
	*   @desc: returns true if the window with specified id exists
	*   @param: id
	*   @type: public
	*/
	this.isWindow = function(id) {
		var t = (this.wins[id] != null);
		return t;
	}
//#wind_uber:09062008{
	// return array of handlers finded by text
	/**
	*   @desc: returns array of window handlers found by header text
	*   @param: id
	*   @type: public
	*/
	this.findByText = function(text) {
		var wins = new Array();
		for (var a in this.wins) {
			if (this.wins[a].getText().search(text, "gi") >= 0) {
				wins[wins.length] = this.wins[a];
			}
		}
		return wins;
	}
//#}	
	// return handler by id
	/**
	*   @desc: returns the window handler (dhtmlXWindowSngl object) found by id
	*   @param: id
	*   @type: public
	*/
	this.window = function(id) {
		var win = null;
		if (this.wins[id] != null) { win = this.wins[id]; }
		return win;
	}
//#wind_uber:09062008{
	// iterator
	/**
	*   @desc: iterator - goes through all windows and calls a user handler
	*   @param: hander (user function)
	*   @type: public
	*/
	this.forEachWindow = function(handler) {
		for (var a in this.wins) {
			handler(this.wins[a]);
		}
	}
	
	// return bottommost focused window handler
	/**
	*   @desc: returns the bottommost window
	*   @type: public
	*/
	this.getBottommostWindow = function() {
		var bottommost = this.getTopmostWindow();
		for (var a in this.wins) {
			if (this.wins[a].zi < bottommost.zi) {
				bottommost = this.wins[a];
			}
		}
		return (bottommost.zi != 0 ? bottommost : null);
	}
//#}	

	// return topmost focused window handler
	/**
	*   @desc: returns the topmost window
	*   @type: public
	*/
	this.getTopmostWindow = function(visibleOnly) {
		var topmost = {"zi": 0};
		for (var a in this.wins) {
			
			if (this.wins[a].zi > topmost.zi) {
				if (visibleOnly == true && !this._isWindowHidden(this.wins[a])) {
					topmost = this.wins[a];
				}
				if (visibleOnly != true) {
					topmost = this.wins[a];
				}
			}
		}
		return (topmost.zi != 0 ? topmost : null);
	}
	
	// windows storage
	this.wins = {};
	for (var a in this.wins) delete this.wins[a];
	
	// viewport
	this.autoViewport = true;
	this._createViewport = function() {
		this.vp = document.body;
		this._clearVPCss();
		this.vp._css = (String(this.vp.className).length > 0 ? this.vp.className : "");
		this.vp.className += " dhtmlx_skin_"+this.skin+(this._r?" dhx_wins_rtl":"");
		// modal cover
		this.modalCoverI = document.createElement("IFRAME");
		this.modalCoverI.frameBorder = "0";
		this.modalCoverI.className = "dhx_modal_cover_ifr";
		this.modalCoverI.setAttribute("src","javascript:false;");
		this.modalCoverI.style.display = "none";
		this.modalCoverI.style.zIndex = 0;
		this.vp.appendChild(this.modalCoverI);
		this.modalCoverD = document.createElement("DIV");
		this.modalCoverD.className = "dhx_modal_cover_dv";
		this.modalCoverD.style.display = "none";
		this.modalCoverD.style.zIndex = 0;
		this.vp.appendChild(this.modalCoverD);
		// vp move/resize cover
		this._vpcover = document.createElement("DIV");
		this._vpcover.className = "dhx_content_vp_cover";
		this._vpcover.style.display = "none";
		this.vp.appendChild(this._vpcover);
		// resize/move carcass
		this._carcass = document.createElement("DIV");
		this._carcass.className = "dhx_carcass_resmove";
		this._carcass.style.display = "none";
		if (_isIE) {
			this._carcass.innerHTML = "<iframe border=0 frameborder=0 style='filter: alpha(opacity=0); width: 100%; height:100%; position: absolute; top: 0px; left: 0px; width: 100%; height: 100%; z-index:1;'></iframe>"+
							"<div style='position: absolute; top: 0px; left: 0px; width: 100%; height: 100%;z-index:2;background:white;filter:alpha(opacity=0);opacity:0;'></div>";
			if (navigator.userAgent.indexOf("MSIE 10") >= 0) {
				
			} else {
				this._carcass.childNodes[0].setAttribute("src","javascript:false;");
			}
		}
		this._carcass.onselectstart = function(e) {
			e = e||event;
			e.returnValue = false;
		}
		this.vp.appendChild(this._carcass);
	}
	this._clearVPCss = function(css) {
		this.vp.className = String(this.vp.className).replace(/[a-z_]{1,}/gi,function(t){return({"dhtmlx_skin_dhx_skyblue":1,"dhtmlx_skin_dhx_blue":1,"dhtmlx_skin_dhx_black":1,"dhtmlx_skin_dhx_web":1,"dhtmlx_skin_dhx_terrace":1}[t]==1?"":t);});
	}
	this._autoResizeViewport = function() {
		for (var a in this.wins) {
			if (this.wins[a]._isFullScreened) {
				/*
				this.wins[a]._content.style.width = document.body.offsetWidth-(_isIE?4:0)+"px";
				// doctype fix
				if (document.body.offsetHeight == 0) {
					if (window.innerHeight) {
						this.wins[a]._content.style.height = window.innerHeight+"px";
					} else {
						this.wins[a]._content.style.height = document.body.scrollHeight+"px";
					}
				} else {
					this.wins[a]._content.style.height = document.body.offsetHeight-(_isIE?4:0)+"px";
				}
				// this.wins[a]._content.style.height = document.body.offsetHeight-(_isIE?4:0)+"px";
				if (this.wins[a].layout != null && _isOpera) { this.wins[a].layout._fixCellsContentOpera950(); }
				this.wins[a].updateNestedObjects();
				*/
				this.wins[a].adjustContent(document.body, 0, 0, false, 0);
				this.wins[a].updateNestedObjects();
				
			}
			if (this.wins[a]._isMaximized && this.wins[a].style.display != "none") {
				this._restoreWindow(a);
				this._maximizeWindow(a);
			}
		}
		
		if (this.vp == document.body) return;
		if (this.autoViewport == false) return;
		this.vp.style.width = (_isIE ? document.body.offsetWidth - 4 : window.innerWidth) + "px";
		this.vp.style.height = (_isIE ? document.body.offsetHeight - 4 : window.innerHeight) + "px";
		//
		// check windows out of viewports edge
		for (var a in this.wins) {
			var win = this.wins[a];
			var overX = false;
			var overY = false;
			if (win.x > this.vp.offsetWidth - 10) {
				win.x = this.vp.offsetWidth - 10;
				overX = true;
			}
			var skinParams = (win._skinParams!=null?win._skinParams:this.skinParams[this.skin]);
			if (win.y + skinParams["header_height"] > this.vp.offsetHeight) {
				win.y = this.vp.offsetHeight - skinParams["header_height"];
				overY = true;
			}
			if (overX || overY) {
				// this._redrawWindow(win);
				this._engineRedrawWindowPos(win);
			}
		}
	}
	/**
	*   @desc: if true - allows an object to adjust the viewport automatically to document.body
	*   @param: state - true|false
	*   @type: public
	*/
	this.enableAutoViewport = function(state) {
		
		if (this.vp != document.body) return;
		this.autoViewport = state;
		if (state == false) {
			// clear old vp
			if (this.vp == document.body) document.body.className = this.vp._css;
			this.vp.removeChild(this.modalCoverI);
			this.vp.removeChild(this.modalCoverD);
			this.vp.removeChild(this._vpcover);
			this.vp.removeChild(this._carcass);
			this.vp = null;
			// create a new one
			this.vp = document.createElement("DIV");
			this.vp.autocreated = true;
			this.vp.className = "dhtmlx_winviewport dhtmlx_skin_"+this.skin+(this._r?" dhx_wins_rtl":"");
			this.vp.style.left = "0px";
			this.vp.style.top = "0px";
			document.body.appendChild(this.vp);
			this.vp.ax = 0;
			this.vp.ay = 0;
			this._autoResizeViewport();
			this.vp.appendChild(this.modalCoverI);
			this.vp.appendChild(this.modalCoverD);
			this.vp.appendChild(this._vpcover);
			this.vp.appendChild(this._carcass);
		}
	}
	/**
	*   @desc: attaches a vp to an existing object on page (renders an object as a viewport)
	*   @param: objId - object id
	*   @type: public
	*/
	this.attachViewportTo = function(objId) {
		if (this.autoViewport == false) {
			// clear old vp
			this.vp.removeChild(this.modalCoverI);
			this.vp.removeChild(this.modalCoverD);
			this.vp.removeChild(this._vpcover);
			this.vp.removeChild(this._carcass);
			if (this.vp != document.body) this.vp.parentNode.removeChild(this.vp);
			this.vp = null;
			// create a new one
			this.vp = (typeof(objId)=="string"?document.getElementById(objId):objId);
			this.vp.autocreated = false;
			this._clearVPCss();
			this.vp.className += " dhtmlx_skin_"+this.skin+(this._r?" dhx_wins_rtl":"");
			this.vp.style.position = "relative";
			this.vp.style.overflow = "hidden";
			this.vp.ax = 0;
			this.vp.ay = 0;
			// attach data
			this.vp.appendChild(this.modalCoverI);
			this.vp.appendChild(this.modalCoverD);
			this.vp.appendChild(this._vpcover);
			this.vp.appendChild(this._carcass);
		}
	}
	/**
	*   @desc: sets user-defined viewport if enableAutoViewport(false)
	*   @param: x - top-left viewport corner's X-coordinate
	*   @param: y - top-left viewport corner's Y-coordinate
	*   @param: width - viewport's width
	*   @param: height - viewport's height
	*   @type: public
	*/
	this.setViewport = function(x, y, width, height, parentObj) {
		if (this.autoViewport == false) {
			this.vp.style.left = x + "px";
			this.vp.style.top = y + "px";
			this.vp.style.width = width + "px";
			this.vp.style.height = height + "px";
			// attach to parent
			if (parentObj != null) { parentObj.appendChild(this.vp); }
			this.vp.ax = getAbsoluteLeft(this.vp);
			this.vp.ay = getAbsoluteTop(this.vp);
		}
	}
	// effects
	this._effects = {"move" : false, "resize" : false};
	/**
	*   @desc: sets a visual effect
	*   @param: efName - effect's name
	*   @param: efValue - true/false to enable/disable
	*   @type: public
	*/
	this.setEffect = function(efName, efValue) {
		if ((this._effects[efName] != null) && (typeof(efValue) == "boolean")) {
			this._effects[efName] = efValue;
		}
	}
	/**
	*   @desc: returns true if the effect is enabled
	*   @param: efName - effect's name
	*   @type: public
	*/
	this.getEffect = function(efName) {
		return this._effects[efName];
	}
	// windows
	/**
	*   @desc: creates a new window and returns its handler
	*   @param: id - window's id
	*   @param: x - top-left window corner's X-coordinate
	*   @param: y - top-left window corner's Y-coordinate
	*   @param: width - window's width
	*   @param: height - window's height
	*   @type: public
	*/
	this.createWindow = function(id, x, y, width, height) {
		
		var win = document.createElement("DIV");
		
		// win.className = "dhtmlx_window_inactive";
		win.className = "dhtmlx_window_inactive";
		win.dir = "ltr";
		// move all available windows up
		for (var a in this.wins) {
			this.wins[a].zi += this.zIndexStep;
			this.wins[a].style.zIndex = this.wins[a].zi;
			if (this.iframeMode && this.wins[a].ifr) {
				this.wins[a].ifr.style.zIndex = this.wins[a].style.zIndex-1;
			}
		}
		// bottom, bring on top will at the end of createWindow function
		win.zi = this.zIndexStep;// this._getTopZIndex(true) + this.zIndexStep;
		win.style.zIndex = win.zi;
		//
		win.active = false;
		//
		win._isWindow = true;
		
		win.isWindow = true;
		//
		// win.that = this;
		//
		win.w = Number(width);
		win.h = Number(height);
		win.x = x;
		win.y = y;
		// this._fixWindowPositionInViewport(win);
		this._engineFixWindowPosInViewport(win);
		//
		// win.style.width = win.w + "px";
		// win.style.height = win.h + "px";
		// win.style.left = win.x + "px";
		// win.style.top = win.y + "px";
		win._isModal = false;
		// resize params
		win._allowResize = true;
		win.maxW = "auto"; // occupy all viewport on click or 
		win.maxH = "auto";
		win.minW = 200;
		win.minH = 140;
		win.iconsPresent = true;
		win.icons = new Array(this.imagePath+this.pathPrefix+this.skin+"/active/icon_normal.gif", this.imagePath+this.pathPrefix+this.skin+"/inactive/icon_normal.gif");
		//
		win._allowMove = true;
		win._allowMoveGlobal = true;
		win._allowResizeGlobal = true;
		//
		win._keepInViewport = false;
		//
		var skin = this.skinParams[this.skin];
		win.idd = id;
		//win._midd = "dhxWMNObj_"+this._genStr(12);
		//win._tidd = "dhxWTBObj_"+this._genStr(12);
		//win._sidd = "dhxSTBObj_"+this._genStr(12);
		//
		this.vp.appendChild(win);
		this._engineSetWindowBody(win);
		this._engineRedrawWindowPos(win);
		this._engineRedrawWindowSize(win);
		this._engineUpdateWindowIcon(win, win.icons[0]);
		
		this._engineDiableOnSelectInWindow(win, true);
		//
		this.wins[id] = win;
		//
		dhtmlxEventable(win);
		//
		// this._makeActive(win, true);
		
		// moving
		this._engineGetWindowHeader(win)[this._isIPad?"ontouchstart":"onmousedown"] = function(e) {
			
			e = e||event;
			
			var w = that.wins[this.idd];
			if (!w.isOnTop()) w.bringToTop();
			
			if (that._engineGetWindowHeaderState(w)) return;
			
			if (!that._engineCheckHeaderMouseDown(w, e)) return;
			
			if (!w._allowMove || !w._allowMoveGlobal) return;
			
			that._wasMoved = false;
			//
			w.moveOffsetX = w.x - (that._isIPad?e.touches[0].clientX:e.clientX);
			w.moveOffsetY = w.y - (that._isIPad?e.touches[0].clientY:e.clientY);
			that.movingWin = w;
			
			// carcass
			if (that._effects["move"] == false) {
				that._carcass.x = that.movingWin.x;
				that._carcass.y = that.movingWin.y;
				that._carcass.w = parseInt(that.movingWin.style.width)+(_isIE?0:-2);
				that._carcass.h = parseInt(that.movingWin.style.height)+(_isIE?0:-2);
				that._carcass.style.left = that._carcass.x+"px";
				that._carcass.style.top = that._carcass.y+"px";
				that._carcass.style.width = that._carcass.w+"px";
				that._carcass.style.height = that._carcass.h+"px";
				// that._carcass.style.zIndex = that.movingWin.style.zIndex+that._getTopZIndex()+10;
				that._carcass.style.zIndex = that._getTopZIndex(true)+1;
				// that._carcass.style.cursor = "move";
				that._carcass._keepInViewport = win._keepInViewport;
			}
			that._blockSwitcher(true);
			// cursor
			// that._engineGetWindowHeader(that.movingWin).style.cursor = "move";
			// vpcover
			that._vpcover.style.zIndex = that.movingWin.style.zIndex-1;
			that._vpcover.style.display = "";
			//
			// w = null;
			e.returnValue = false;
			e.cancelBubble = true;
			
			return false;
		}
		/*
		win.ongesturestart = function(e) {
			
			e.preventDefault();
			
			that._carcass.x = this.x;
			that._carcass.y = this.y;
			that._carcass.w = this.w;
			that._carcass.h = this.h;
			
			that._carcass.style.left = that._carcass.x+"px";
			that._carcass.style.top = that._carcass.y+"px";
			that._carcass.style.width = that._carcass.w+"px";
			that._carcass.style.height = that._carcass.h+"px";
			
			that._carcass.style.display = "";
			that._carcass.style.zIndex = this.style.zIndex+1;
			
			
		}
		win.ongesturechange = function(e) {
			
			e.preventDefault();
			
			var scale = e.scale;
			
			var cx = that._carcass.x+that._carcass.w/2;
			var cy = that._carcass.y+that._carcass.h/2;
			
			var nw = that._carcass.w*scale;
			var nh = that._carcass.h*scale;
			
			var ncx = cx-nw/2;
			var ncy = cy-nh/2;
			
			
			that._carcass.style.left = Math.round(ncx)+"px";
			that._carcass.style.top = Math.round(ncy)+"px";
			that._carcass.style.width = Math.round(nw)+"px";
			that._carcass.style.height = Math.round(nh)+"px";
			
			//console.log(e.scale+","+e.rotation)
		}
		
		win.ongestureend = function(e) {
			
			e.preventDefault();
			
			that._carcass.style.display = "none";
			this.setPosition(parseInt(that._carcass.style.left), parseInt(that._carcass.style.top));
			this.setDimension(parseInt(that._carcass.style.width), parseInt(that._carcass.style.height));
		}
		*/
		this._engineGetWindowHeader(win).ondblclick = function(e) {
			
			var w = that.wins[this.idd];
			
			// maximize/minimize
			if (!that._engineCheckHeaderMouseDown(w, e||event)) { return; }
			if (w._allowResizeGlobal && !w._isParked) {
				if (w._isMaximized == true) {
					that._restoreWindow(w.idd);
				} else {
					that._maximizeWindow(w.idd);
				}
			}
			
			// parkup/parkup
			/*
			if (w._isParkedAllowed && w.button("park").isEnabled()) {
				that._parkWindow(w);
			}
			*/
			
			w = null;
			
		}
		
		// set text
		/**
		*   @desc: sets window's header text
		*   @param: text
		*   @type: public
		*/
		win.setText = function(text) {
			that._engineGetWindowLabel(this).innerHTML = text;
		}
		// get text
		/**
		*   @desc: returns window's header text
		*   @type: public
		*/
		win.getText = function() {
			return that._engineGetWindowLabel(this).innerHTML;
		}
		// het id by handler
		/**
		*   @desc: returns window's id
		*   @type: public
		*/
		win.getId = function() {
			return this.idd;
		}
		// show
		/**
		*   @desc: shows a window
		*   @type: public
		*/
		win.show = function() {
			that._showWindow(this);
		}
		// hide
		/**
		*   @desc: hides a window
		*   @type: public
		*/
		win.hide = function() {
			that._hideWindow(this);
		}
		// minimize
		/**
		*   @desc: minimizes a window
		*   @type: public
		*/
		win.minimize = function() {
			that._restoreWindow(this.idd);
		}
		// maximize
		/**
		*   @desc: maximizes a window
		*   @type: public
		*/
		win.maximize = function() {
			that._maximizeWindow(this.idd);
		}
		// close
		/**
		*   @desc: closes a window
		*   @type: public
		*/
		win.close = function() {
			that._closeWindow(this.idd);
		}
		// park
		/**
		*   @desc: parks a window (next action is based on window's current state)
		*   @type: public
		*/
		win.park = function() {
			if (this._isParkedAllowed) {
				that._parkWindow(this.idd);
			}
		}
		// stick/unstick
		/**
		*   @desc: sticks a window
		*   @type: public
		*/
		win.stick = function() {
			that._stickWindow(this.idd);
		}
		/**
		*   @desc: unsticks a window
		*   @type: public
		*/
		win.unstick = function() {
			that._unstickWindow(this.idd);
		}
		/**
		*   @desc: returns true if the window is sticked
		*   @type: public
		*/
		win.isSticked = function() {
			return this._isSticked;
		}
		// set icon
		/**
		*   @desc: sets window's header icon
		*   @param: iconEnabled - url to the icon for the enabled state
		*   @param: iconDisabled - url to the icon for the disabled state
		*   @type: public
		*/
		win.setIcon = function(iconEnabled, iconDisabled) {
			that._setWindowIcon(win, iconEnabled, iconDisabled);
		}
		// return array(iconEnabled, iconDisabled) icons for window
		/**
		*   @desc: returns current window's header icon
		*   @param: text
		*   @type: public
		*/
		win.getIcon = function() {
			return that._getWindowIcon(this);
		}
		// clear icon
		/**
		*   @desc: clears window's header icon
		*   @type: public
		*/
		win.clearIcon = function() {
			that._clearWindowIcons(this);
		}
		// restore default window icon according the loaded skin
		/**
		*   @desc: restores default window's header icon (based on skin)
		*   @type: public
		*/
		win.restoreIcon = function() {
			that._restoreWindowIcons(this);
		}
		//
		/**
		*   @desc: keeps a window within the viewport
		*   @param: state - if true - window is not allowed to be placed outside the viewport
				    if false - window is not allowed to be placed outside the viewport leaving only a small part of its header within the viewport
		*   @type: public
		*/
		win.keepInViewport = function(state) {
			this._keepInViewport = state;
		}
		// ask window be/not be modal
		/**
		*   @desc: makes a window modal/modeless
		*   @param: state - true|false
		*   @type: public
		*/
		win.setModal = function(state) {
			if (state == true) {
				if (that.modalWin != null || that.modalWin == this) return;
				that._setWindowModal(this, true);
			} else {
				if (that.modalWin != this) return;
				that._setWindowModal(this, false);
			}
		}
		// return true if window is modal
		/**
		*   @desc: returns true if the window is modal
		*   @type: public
		*/
		win.isModal = function() {
			return this._isModal;
		}
		// return true if window is hidden
		/**
		*   @desc: returns true if the window is hidden
		*   @type: public
		*/
		win.isHidden = function() {
			return that._isWindowHidden(this);
		}
		// return true if window is maximized
		/**
		*   @desc: returns true if the window is maximized
		*   @type: public
		*/
		win.isMaximized = function() {
			return this._isMaximized;
		}
		// return true if window is parkded
		/**
		*   @desc: returns true if the window is parked
		*   @type: public
		*/
		win.isParked = function() {
			return this._isParked;
		}
		// allow/deny park
		/**
		*   @desc: allows a window to be parked
		*   @type: public
		*/
		win.allowPark = function() {
			that._allowParking(this);
		}
		/**
		*   @desc: denies a window from parking
		*   @type: public
		*/
		win.denyPark = function() {
			that._denyParking(this);
		}
		/**
		*   @desc: returns true if the window is parkable
		*   @type: public
		*/
		win.isParkable = function() {
			return this._isParkedAllowed;
		}
		// allow/deny for allow window to be resized
		/**
		*   @desc: allows a window to be resized
		*   @type: public
		*/
		win.allowResize = function() {
			that._allowReszieGlob(this);
		}
		/**
		*   @desc: denies a window from resizing
		*   @type: public
		*/
		win.denyResize = function() {
			that._denyResize(this);
		}
		// return true if window resizeable
		/**
		*   @desc: returns true if the window is resizable
		*   @type: public
		*/
		win.isResizable = function() {
			return this._allowResizeGlobal;
		}
		// move
		/**
		*   @desc: allows a window to be moved
		*   @type: public
		*/
		win.allowMove = function() {
			if (!this._isMaximized) { this._allowMove = true; }
			this._allowMoveGlobal = true;
		}
		/**
		*   @desc: denies a window from moving
		*   @type: public
		*/
		win.denyMove = function() {
			this._allowMoveGlobal = false;
		}
		/**
		*   @desc: returns true if the window is movable
		*   @type: public
		*/
		win.isMovable = function() {
			return this._allowMoveGlobal;
		}
		// bring window to top and set focus
		/**
		*   @desc: brings/sends a window on top (z-positioning)
		*   @type: public
		*/
		win.bringToTop = function() {
			that._bringOnTop(this);
			that._makeActive(this);
		}
		// bring window to bottom and set focus
		/**
		*   @desc: brings/sends a window to bottom (z-positioning)
		*   @type: public
		*/
		win.bringToBottom = function() {
			that._bringOnBottom(this);
		}
		// return true if window is on top
		/**
		*   @desc: returns true if the window is on top
		*   @type: public
		*/
		win.isOnTop = function() {
			return that._isWindowOnTop(this);
		}
		// return true if window if on bottom
		/**
		*   @desc: returns true if the window is on bottom
		*   @type: public
		*/
		win.isOnBottom = function() {
			return that._isWindowOnBottom(this);
		}
		// set new position for window, if it will outlay the viewport it was moved into it visible area
		/**
		*   @desc: sets window's position (moves a window to the point set by user)
		*   @param: x - x coordinate
		*   @param: y - y coordinate
		*   @type: public
		*/
		win.setPosition = function(x, y) {
			this.x = x;
			this.y = y;
			// that._fixWindowPositionInViewport(this);
			// fixing mozilla artefakts
			/*
			if (_isFF) {
				this.h++;
				that._redrawWindow(this);
				this.h--;
			}
			*/
			that._engineFixWindowPosInViewport(this);
			that._engineRedrawWindowPos(this);
			// that._redrawWindow(this);
		}
		// return array(x, y) with position of window
		/**
		*   @desc: returns current window's position
		*   @type: public
		*/
		win.getPosition = function() {
			return new Array(this.x, this.y);
		}
		// set new dimension for window, if it will outlay the viewport it was moved into it visible area
		/**
		*   @desc: sets window's dimension
		*   @param: width
		*   @param: height
		*   @type: public
		*/
		win.setDimension = function(width, height) {
			// alert(2)
			if (width != null) {
				if (this.maxW != "auto") if (width > this.maxW) width = this.maxW;
				if (width < this.minW) width = this.minW;
				this.w = width;
			}
			if (height != null) {
				if (this.maxH != "auto") if (height > this.maxH) height = this.maxH;
				if (height < this.minH) height = this.minH;
				this.h = height;
			}
			that._fixWindowDimensionInViewport(this);
			// that._fixWindowPositionInViewport(this);
			that._engineFixWindowPosInViewport(this);
			//
			// that._redrawWindow(this);
			that._engineRedrawWindowSize(this);
			//
			this.updateNestedObjects();
		}
		// return array(width, height) with current dimension of window
		/**
		*   @desc: returns current window's dimension
		*   @type: public
		*/
		win.getDimension = function() {
			return new Array(this.w, this.h);
		}
		// set max dimension for window
		/**
		*   @desc: sets max window's dimension
		*   @param: maxWidth
		*   @param: maxHeight
		*   @type: public
		*/
		win.setMaxDimension = function(maxWidth, maxHeight) {
			this.maxW = (isNaN(maxWidth)?"auto":maxWidth);
			this.maxH = (isNaN(maxHeight)?"auto":maxHeight);
			//that._redrawWindow(this);
			that._engineRedrawWindowSize(this);
		}
		// return array(maxWidth, maxheight) with max dimension for window
		/**
		*   @desc: returns current max window's dimension
		*   @type: public
		*/
		win.getMaxDimension = function() {
			return new Array(this.maxW, this.maxH);
		}
		// set min dimensuion for window
		/**
		*   @desc: sets min window's dimension
		*   @param: minWidth
		*   @param: minHeight
		*   @type: public
		*/
		win.setMinDimension = function(minWidth, minHeight) {
			if (minWidth != null) { this.minW = minWidth; }
			if (minHeight != null) { this.minH = minHeight; }
			that._fixWindowDimensionInViewport(this);
			// that._redrawWindow(this);
			that._engineRedrawWindowPos(this);
		}
		// return array(minWidth, minHeight) with min dimension for window
		/**
		*   @desc: returns current min window's dimension
		*   @type: public
		*/
		win.getMinDimension = function() {
			return new Array(this.minW, this.minH);
		}
		
		win._adjustToContent = function(cw, ch) {
			that._engineAdjustWindowToContent(this, cw, ch);
		}
		win._doOnAttachMenu = function() {
			that._engineRedrawWindowSize(this);
			this.updateNestedObjects();
		}
		win._doOnAttachToolbar = function() {
			that._engineRedrawWindowSize(this);
			this.updateNestedObjects();
		}
		win._doOnAttachStatusBar = function() {
			that._engineRedrawWindowSize(this);
			this.updateNestedObjects();
		}
		win._doOnFrameMouseDown = function() {
			this.bringToTop();
		}
		win._doOnFrameContentLoaded = function() {
			that.callEvent("onContentLoaded",[this]);
		}
		/*
		win._doOnAttachURL = function(addIFrameEvents) {
			if (!addIFrameEvents) {
				// just call onContentLoaded
				that.callEvent("onContentLoaded", [this]);
				return;
			}
			// attach events into iframe
			if (_isIE) {
				// ie
				var w = this;
				var f = this._frame;
				f.onreadystatechange = function(a) {
					if (f.readyState == "complete") {
						try{f.contentWindow.document.body.onmousedown = function(){try{w.bringToTop();}catch(e){};};}catch(e){};
						try{that.callEvent("onContentLoaded",[w]);}catch(e){}
					}
				}
			} else {
				// ff, opera, safari
				var w = this;
				var f = this._frame;
				f.onload = function() {
					try {f.contentWindow.onmousedown = function(){try{w.bringToTop();}catch(e){};};}catch(e){};
					that.callEvent("onContentLoaded",[w]);
				}
			}
		}
		*/
//#wind_buttons:09062008{
		// add user button
		/**
		*   @desc: adds a user button
		*   @param: id - button's id
		*   @param: pos - button's position
		*   @param: title - button's tooltip
		*   @param: label - button's name (according to css)
		*   @type: public
		*/
		win.addUserButton = function(id, pos, title, label) {
			var userBtn = that._addUserButton(this, id, pos, title, label);
			return userBtn;
		}
		// remove user button
		/**
		*   @desc: removes a user button
		*   @param: id - button's id
		*   @type: public
		*/
		win.removeUserButton = function(id) {
			id = String(id).toLowerCase();
			if (!((id == "minmax1") || (id == "minmax2") || (id == "park") || (id == "close") || (id == "stick") || (id == "unstick") || (id == "help"))) {
				if (btn != null) { that._removeUserButton(this, id); }
			}
		}
//#}				
		/**
		*   @desc: shows a progress indicator
		*   @type: public
		*/
		win.progressOn = function() {
			that._engineSwitchWindowProgress(this, true);
		}
		/**
		*   @desc: hides a progress indicator
		*   @type: public
		*/
		win.progressOff = function() {
			that._engineSwitchWindowProgress(this, false);
		}
		/**
		*   @desc: sets a window to the fullscreen mode
		*   @param: state - true|false
		*   @type: public
		*/
		win.setToFullScreen = function(state) {
			that._setWindowToFullScreen(this, state);
		}
		/**
		*   @desc: shows window's header
		*   @type: public
		*/
		win.showHeader = function() {
			that._engineSwitchWindowHeader(this, true);
			// that._showWindowHeader(this);
		}
		/**
		*   @desc: hides window's header
		*   @type: public
		*/
		win.hideHeader = function() {
			that._engineSwitchWindowHeader(this, false);
			// that._hideWindowHeader(this);
		}
		//
		win.progressOff();
		// resize cursor modifications and handlers
		win.canStartResize = false;
		
		win.onmousemove = function(e) {
			
			if (_isIE && this._isMaximized) return true;
			e = e || event;
			
			var targetObj = e.target || e.srcElement;
			if (String(targetObj.className).search("dhtmlx_wins_resizer") < 0) targetObj = null;
			
			// resize not allowed
			if (!this._allowResize || this._allowResizeGlobal == false || !targetObj) {
				if (targetObj) { if (targetObj.style.cursor != "default") targetObj.style.cursor = "default"; }
				if (this.style.cursor != "default") this.style.cursor = "default";
				this.canStartResize = false;
				return true; // required to allow selection in IE
			}
			// resize can't be realized
			if (that.resizingWin != null) return;
			if (that.movingWin != null) return;
			if (this._isParked) return;
			// coords
			if (that._isIPad) {
				var px = e.touches[0].clientX;
				var py = e.touches[0].clientY;
			} else {
				var px = (_isIE||_isOpera?e.offsetX:e.layerX);
				var py = (_isIE||_isOpera?e.offsetY:e.layerY);
			}
			
			// direction
			var resDir = that._engineAllowWindowResize(win, targetObj, px, py);
			if (resDir == null) {
				this.canStartResize = false;
				if (targetObj.style.cursor != "default") targetObj.style.cursor = "default";
				if (this.style.cursor != "default") this.style.cursor = "default";
				return;
			}
			// prepare
			that.resizingDirs = resDir;
			var xy = {x:e.clientX,y:e.clientY};
			
			switch (that.resizingDirs) {
				case "border_left":
					targetObj.style.cursor = "w-resize";
					this.resizeOffsetX = this.x - xy.x;
					break;
				case "border_right":
					targetObj.style.cursor = "e-resize";
					this.resizeOffsetXW = this.x + this.w - xy.x;
					break;
				case "border_top":
					targetObj.style.cursor = "n-resize";
					this.resizeOffsetY = this.y - xy.y;
					break;
				case "border_bottom":
					targetObj.style.cursor = "n-resize";
					this.resizeOffsetYH = this.y + this.h - xy.y;
					break;
				case "corner_left":
					targetObj.style.cursor = "sw-resize";
					this.resizeOffsetX = this.x - e.clientX;
					this.resizeOffsetYH = this.y + this.h - xy.y;
					break;
				case "corner_up_left":
					targetObj.style.cursor = "nw-resize";
					this.resizeOffsetY = this.y - xy.y;
					this.resizeOffsetX = this.x - xy.x;
					break;
				case "corner_right":
					targetObj.style.cursor = "nw-resize";
					this.resizeOffsetXW = this.x + this.w - xy.x;
					this.resizeOffsetYH = this.y + this.h - xy.y;
					break;
				case "corner_up_right":
					targetObj.style.cursor = "sw-resize";
					this.resizeOffsetY = this.y - xy.y;
					this.resizeOffsetXW = this.x + this.w - xy.x;
					break;
			}
			this.canStartResize = true;
			this.style.cursor = targetObj.style.cursor;
			
			e.cancelBubble = true;
			e.returnValue = false;
			
			return false;
		}
		win.onmousedown = function(e) {
			
			if (that._getActive() != this) that._makeActive(this);
			that._bringOnTop(this);
			
			if (this.canStartResize) {
				that._blockSwitcher(true);
				that.resizingWin = this;
				if (!that._effects["resize"]) {
					that._carcass.x = that.resizingWin.x;
					that._carcass.y = that.resizingWin.y;
					that._carcass.w = Number(that.resizingWin.w)+(_isIE?0:-2);
					that._carcass.h = Number(that.resizingWin.h)+(_isIE?0:-2);
					that._carcass.style.left = that._carcass.x+"px";
					that._carcass.style.top = that._carcass.y+"px";
					that._carcass.style.width = that._carcass.w+"px";
					that._carcass.style.height = that._carcass.h+"px";
					that._carcass.style.zIndex = that._getTopZIndex(true)+1;
					that._carcass.style.cursor = this.style.cursor;
					that._carcass._keepInViewport = this._keepInViewport;
					that._carcass.style.display = "";
					
				}
				// vpcover
				that._vpcover.style.zIndex = that.resizingWin.style.zIndex-1;
				that._vpcover.style.display = "";
				// updated for 2.6-views
				if (this.vs[this.av].layout) { this.callEvent("_onBeforeTryResize", [this]); }
				e = e||event;
				//e.returnValue = false;
				//e.cancelBubble = true;
				//return false;
			}
			
		}
		// add buttons
		this._addDefaultButtons(win.idd);
		//
//#wind_buttons:09062008{
		// return button handler
		win.button = function(id) {
			id = String(id).toLowerCase();
			var b = null;
			if (this.btns[id] != null) { b = this.btns[id]; }
			return b;
		}
//#}		
		//
		/**
		*   @desc: centers a window in the viewport
		*   @type: public
		*/	
		win.center = function() {
			that._centerWindow(this, false);
		}
		/**
		*   @desc: centers a window on the screen
		*   @type: public
		*/
		win.centerOnScreen = function() {
			that._centerWindow(this, true);
		}
		//
		
		
		win._attachContent("empty", null);
		
		win._redraw = function() {
			that._engineRedrawWindowSize(this);
		}
		
		win.bringToTop();
		this._engineRedrawWindowSize(win);
		//win.setDimension(win.w, win.h);
		//window.setTitemout(function(){win.setDimension(win.w+100, win.h+100);},100);
		//
		return this.wins[id];
	}
	
	this.zIndexStep = 2000;
	this._getTopZIndex = function(ignoreSticked) {
		var topZIndex = 0;
		for (var a in this.wins) {
			if (ignoreSticked == true) {
				if (this.wins[a].zi > topZIndex) { topZIndex = this.wins[a].zi; }
			} else {
				if (this.wins[a].zi > topZIndex && !this.wins[a]._isSticked) { topZIndex = this.wins[a].zi; }
			}
		}
		return topZIndex;
	}
	
	this.movingWin = null;
//#wind_move:09062008{
	this._moveWindow = function(e) {
		
		if (this.movingWin != null) {
			//
			if (!this.movingWin._allowMove || !this.movingWin._allowMoveGlobal) { return; }
			if (this._effects["move"] == true) {
				//
				// cursor
				if (this._engineGetWindowHeader(this.movingWin).style.cursor != "move") { this._engineGetWindowHeader(this.movingWin).style.cursor = "move"; }
				//
				this._wasMoved = true;
				//
				this.movingWin.x = (this._isIPad?e.touches[0].clientX:e.clientX) + this.movingWin.moveOffsetX;
				this.movingWin.y = (this._isIPad?e.touches[0].clientY:e.clientY) + this.movingWin.moveOffsetY;
				//
				// check out of viewport
				// this._fixWindowPositionInViewport(this.movingWin);
				this._engineFixWindowPosInViewport(this.movingWin);
				//
				// this._redrawWindow(this.movingWin);
				this._engineRedrawWindowPos(this.movingWin);
				
			} else {
				
				if (this._carcass.style.display != "") { this._carcass.style.display = ""; }
				// cursor
				if (this._carcass.style.cursor != "move") { this._carcass.style.cursor = "move"; }
				if (this._engineGetWindowHeader(this.movingWin).style.cursor != "move") { this._engineGetWindowHeader(this.movingWin).style.cursor = "move"; }
				//
				this._carcass.x = (this._isIPad?e.touches[0].clientX:e.clientX) + this.movingWin.moveOffsetX;
				this._carcass.y = (this._isIPad?e.touches[0].clientY:e.clientY) + this.movingWin.moveOffsetY;
				
				this._wasMoved = true;
				
				// this._fixWindowPositionInViewport(this._carcass);
				
				this._engineFixWindowPosInViewport(this._carcass);
				this._carcass.style.left = this._carcass.x+"px";
				this._carcass.style.top = this._carcass.y+"px";
				
			}
		}
		
		if (this.resizingWin != null) {
			//
			
			if (!this.resizingWin._allowResize) { return; }
			//
			
			// resize through left border
			var xy = {x:e.clientX,y:e.clientY};
			
			if (this.resizingDirs == "border_left" || this.resizingDirs == "corner_left" || this.resizingDirs == "corner_up_left") {
				if (this._effects["resize"]) {
					var ofs = xy.x + this.resizingWin.resizeOffsetX;
					var sign = (ofs > this.resizingWin.x ? -1 : 1);
					newW = this.resizingWin.w + Math.abs(ofs - this.resizingWin.x)*sign;
					if ((newW < this.resizingWin.minW) && (sign < 0)) {
						this.resizingWin.x = this.resizingWin.x + this.resizingWin.w - this.resizingWin.minW;
						this.resizingWin.w = this.resizingWin.minW;
					} else {
						this.resizingWin.w = newW;
						this.resizingWin.x = ofs;
					}
					this._engineRedrawWindowPos(this.resizingWin);
					this._engineRedrawWindowSize(this.resizingWin);
				} else {
					var ofs = xy.x + this.resizingWin.resizeOffsetX;
					var sign = (ofs > this._carcass.x ? -1 : 1);
					newW = this._carcass.w + Math.abs(ofs - this._carcass.x)*sign;
					if (newW > this.resizingWin.maxW) {
						newW = this.resizingWin.maxW;
						ofs = this._carcass.x + this._carcass.w - this.resizingWin.maxW;
					}
					if ((newW < this.resizingWin.minW) && (sign < 0)) {
						this._carcass.x = this._carcass.x + this._carcass.w - this.resizingWin.minW;
						this._carcass.w = this.resizingWin.minW;
					} else {
						this._carcass.w = newW;
						this._carcass.x = ofs;
					}
					this._carcass.style.left = this._carcass.x+"px";
					this._carcass.style.width = this._carcass.w+"px";
					
				}
			}
			// resize through right border
			if (this.resizingDirs == "border_right" || this.resizingDirs == "corner_right" || this.resizingDirs == "corner_up_right") {
				if (this._effects["resize"]) {
					var ofs = xy.x - (this.resizingWin.x + this.resizingWin.w) + this.resizingWin.resizeOffsetXW;
					newW = this.resizingWin.w + ofs;
					if (newW < this.resizingWin.minW) { newW = this.resizingWin.minW; }
					this.resizingWin.w = newW;
					this._engineRedrawWindowPos(this.resizingWin);
					this._engineRedrawWindowSize(this.resizingWin);
				} else {
					var ofs = xy.x - (this._carcass.x + this._carcass.w) + this.resizingWin.resizeOffsetXW;
					newW = this._carcass.w + ofs;
					if (newW < this.resizingWin.minW) newW = this.resizingWin.minW;
					if (this.resizingWin.maxW != "auto") if (newW > this.resizingWin.maxW) newW = this.resizingWin.maxW;
					this._carcass.w = newW;
					this._carcass.style.width = this._carcass.w+"px";
				}
			}
			// resize through bottom border
			if (this.resizingDirs == "border_bottom" || this.resizingDirs == "corner_left" || this.resizingDirs == "corner_right") {
				if (this._effects["resize"]) {
					var ofs = xy.y - (this.resizingWin.y + this.resizingWin.h) + this.resizingWin.resizeOffsetYH;
					newH = this.resizingWin.h + ofs;
					if (newH < this.resizingWin.minH) newH = this.resizingWin.minH;
					this.resizingWin.h = newH;
					this._engineRedrawWindowPos(this.resizingWin);
					this._engineRedrawWindowSize(this.resizingWin);
				} else {
					var ofs = xy.y - (this._carcass.y + this._carcass.h) + this.resizingWin.resizeOffsetYH;
					newH = this._carcass.h + ofs;
					if (newH < this.resizingWin.minH) newH = this.resizingWin.minH;
					if (newH > this.resizingWin.maxH) newH = this.resizingWin.maxH;
					this._carcass.h = newH;
					this._carcass.style.height = this._carcass.h+"px";
				}
			}
			if (this.resizingDirs == "border_top" || this.resizingDirs == "corner_up_right" || this.resizingDirs == "corner_up_left") {
				if (this._effects["resize"]) {
					
				} else {
					var ofs = xy.y + this.resizingWin.resizeOffsetY;
					var sign = (ofs > this.resizingWin.y ? -1 : 1);
					newH = this.resizingWin.h + Math.abs(ofs - this.resizingWin.y)*sign;
					if (newH > this.resizingWin.maxH) {
						newH = this.resizingWin.maxH;
						ofs = this.resizingWin.y + this.resizingWin.h - this.resizingWin.maxH;
					}
					if ((newH < this.resizingWin.minH) && (sign < 0)) {
						this._carcass.y = this._carcass.y + this._carcass.h - this.resizingWin.minH;
						this._carcass.h = this.resizingWin.minH;
					} else {
						this._carcass.h = newH+(_isIE?0:-2);
						this._carcass.y = ofs;
					}
					this._carcass.style.top = this._carcass.y+"px";
					this._carcass.style.height = this._carcass.h+"px";
				}
			}
		}
	}
	
	this._stopMove = function() {
		if (this.movingWin != null) {
			if (this._effects["move"]) {
				var win = this.movingWin;
				this.movingWin = null;
				this._blockSwitcher(false);
				// cursor
				// win.childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[1].style.cursor = "";
				// win.childNodes[2].style.cursor = "";
				this._engineGetWindowHeader(win).style.cursor = "";
				// fixing mozilla artefakts
				if (_isFF) {
					win.h++;
					// this._redrawWindow(win);
					that._engineRedrawWindowPos(win);
					win.h--;
					// this._redrawWindow(win);
					that._engineRedrawWindowPos(win);
				}
			} else {
				this._carcass.style.cursor = "";
				this._carcass.style.display = "none";
				var win = this.movingWin;
				this._engineGetWindowHeader(win).style.cursor = "";
				this.movingWin = null;
				this._blockSwitcher(false);
				win.setPosition(parseInt(this._carcass.style.left), parseInt(this._carcass.style.top));
			}
			// vpcover
			this._vpcover.style.display = "none";
			// events
			if (this._wasMoved) {
				//
				if (win.checkEvent("onMoveFinish")) {
					win.callEvent("onMoveFinish",[win]);
				} else {
					this.callEvent("onMoveFinish",[win]);
				}
			}
			this._wasMoved = false;
		}
		if (this.resizingWin != null) {
			var win = this.resizingWin;
			this.resizingWin = null;
			this._blockSwitcher(false);
			if (!this._effects["resize"]) {
				this._carcass.style.display = "none";
				win.setDimension(this._carcass.w+(_isIE?0:2), this._carcass.h+(_isIE?0:2));
				win.setPosition(this._carcass.x, this._carcass.y);
			} else {
				// sizes in attached components
				win.updateNestedObjects();
			}
			// event in layout
			if (win.vs[win.av].layout) { win.vs[win.av].layout.callEvent("onResize", []); }
			// opera fix
			/*
			if (_isOpera) {
				win._content.childNodes[2].style.border="#FFFFFF 0px solid";
				var w = win._content.childNodes[2];
				window.setTimeout(function(){ w.style.border="none"; }, 1);
			}
			*/
			// vpcover
			this._vpcover.style.display = "none";
			// events
			if (win.checkEvent("onResizeFinish")) {
				win.callEvent("onResizeFinish",[win]);
			} else {
				this.callEvent("onResizeFinish",[win]);
			}
		}
	}
//#}	
	
	// check viewport overflow
	/*
	this._fixWindowPositionInViewport = function(win) {
		
		return;
		
		var skin = (win._skinParams!=null?win._skinParams:this.skinParams[this.skin]);
		if (win._keepInViewport) { // keep strongly in viewport
			if (win.x < 0) { win.x = 0; }
			if (win.x + win.w > this.vp.offsetWidth) { win.x = this.vp.offsetWidth - win.w; }
			// if (win.y < 0) { win.y = 0; }
			if (win.y + win.h > this.vp.offsetHeight) { win.y = this.vp.offsetHeight - win.h; }
			if (win.y < 0) { win.y = 0; }
		} else {
			// if (win.y < 0) { win.y = 0; }
			if (win.y + skin["header_height"] > this.vp.offsetHeight) { win.y = this.vp.offsetHeight - skin["header_height"]; }
			if (win.y < 0) { win.y = 0; }
			if (win.x + win.w - 10 < 0) { win.x = 10 - win.w; }
			if (win.x > this.vp.offsetWidth - 10) { win.x = this.vp.offsetWidth - 10; }
		}
	}
	*/
	
	// check and correct window dimensions
	this._fixWindowDimensionInViewport = function(win) {
		if (win.w < win.minW) { win.w = win.minW; }
		if (win._isParked) return;
		if (win.h < win.minH) { win.h = win.minH; }
	}
	
	this._bringOnTop = function(win) {
		var cZIndex = win.zi;
		var topZIndex = this._getTopZIndex(win._isSticked);
		for (var a in this.wins) {
			if (this.wins[a] != win) {
				if (win._isSticked || (!win._isSticked && !this.wins[a]._isSticked)) {
					if (this.wins[a].zi > cZIndex) {
						this.wins[a].zi = this.wins[a].zi - this.zIndexStep;
						this.wins[a].style.zIndex = this.wins[a].zi;
						if (this.iframeMode && this.wins[a].ifr) {
							this.wins[a].ifr.style.zIndex = this.wins[a].style.zIndex-1;
						}
					}
				}
			}
		}
		win.zi = topZIndex;
		win.style.zIndex = win.zi;
        if (this.iframeMode && win.ifr) {
            win.ifr.style.zIndex = topZIndex-1;
        }
	}
	
	this._makeActive = function(win, ignoreFocusEvent) {
		for (var a in this.wins) {
			if (this.wins[a] == win) {
				var needEvent = false;
				if (this.wins[a].className != "dhtmlx_window_active" && !ignoreFocusEvent) { needEvent = true; }
				this.wins[a].className = "dhtmlx_window_active";
				this._engineUpdateWindowIcon(this.wins[a], this.wins[a].icons[0]);
				if (needEvent == true) {
					if (win.checkEvent("onFocus")) {
						win.callEvent("onFocus",[win]);
					} else {
						this.callEvent("onFocus",[win]);
					}
				}
			} else {
				this.wins[a].className = "dhtmlx_window_inactive";
				this._engineUpdateWindowIcon(this.wins[a], this.wins[a].icons[1]);
			}
		}
	}
	
	this._getActive = function() {
		var win = null;
		for (var a in this.wins) {
			if (this.wins[a].className == "dhtmlx_window_active") {
				win = this.wins[a];
			}
		}
		return win;
	}
	
	this._centerWindow = function(win, onScreen) {
		if (win._isMaximized == true) return;
		// if (win._isParked == true) return;
		if (onScreen == true) {
			var vpw = (_isIE?document.body.offsetWidth:window.innerWidth);
			var vph = (_isIE?document.body.offsetHeight:window.innerHeight);
		} else {
			var vpw = (this.vp==document.body?document.body.offsetWidth:(Number(parseInt(this.vp.style.width))&&String(this.vp.style.width).search("%")==-1?parseInt(this.vp.style.width):this.vp.offsetWidth));
			var vph = (this.vp==document.body?document.body.offsetHeight:(Number(parseInt(this.vp.style.height))&&String(this.vp.style.height).search("%")==-1?parseInt(this.vp.style.height):this.vp.offsetHeight));
		}
		var newX = Math.round((vpw/2) - (win.w/2));
		var newY = Math.round((vph/2) - (win.h/2));
		win.x = newX;
		win.y = newY;
		// this._fixWindowPositionInViewport(win);
		this._engineFixWindowPosInViewport(win);
		// this._redrawWindow(win);
		this._engineRedrawWindowPos(win);
	}
	
	this._addDefaultButtons = function(winId) {
//#wind_buttons:09062008{
		
		var win = this.wins[winId];
		
		// stick
		var btnStick = this._engineGetWindowButton(win, "stick");
		btnStick.title = this.i18n.stick;
		btnStick.isVisible = false;
		btnStick.style.display = "none";
		btnStick._isEnabled = true;
		btnStick.isPressed = false;
		btnStick.label = "stick";
		btnStick._doOnClick = function() {
			this.isPressed = true;
			that._stickWindow(this.winId);
		}
		
		// sticked
		var btnSticked = this._engineGetWindowButton(win, "sticked");
		btnSticked.title = this.i18n.unstick;
		btnSticked.isVisible = false;
		btnSticked.style.display = "none";
		btnSticked._isEnabled = true;
		btnSticked.isPressed = false;
		btnSticked.label = "sticked";
		btnSticked._doOnClick = function() {
			this.isPressed = false;
			that._unstickWindow(this.winId);
		}
		
		// help
		var btnHelp = this._engineGetWindowButton(win, "help");
		btnHelp.title = this.i18n.help;
		btnHelp.isVisible = false;
		btnHelp.style.display = "none";
		btnHelp._isEnabled = true;
		btnHelp.isPressed = false;
		btnHelp.label = "help";
		btnHelp._doOnClick = function() { that._needHelp(this.winId); }
		
		// park
		var btnPark = this._engineGetWindowButton(win, "park");
		btnPark.titleIfParked = this.i18n.parkdown;
		btnPark.titleIfNotParked = this.i18n.parkup;
		btnPark.title = btnPark.titleIfNotParked;
		btnPark.isVisible = true;
		btnPark._isEnabled = true;
		btnPark.isPressed = false;
		btnPark.label = "park";
		btnPark._doOnClick = function() { that._parkWindow(this.winId); }
		
		// minmax maximize
		var btnMinMax1 = this._engineGetWindowButton(win, "minmax1");
		btnMinMax1.title = this.i18n.maximize;
		btnMinMax1.isVisible = true;
		btnMinMax1._isEnabled = true;
		btnMinMax1.isPressed = false;
		btnMinMax1.label = "minmax1";
		btnMinMax1._doOnClick = function() { that._maximizeWindow(this.winId); }
		
		// minmax restore
		var btnMinMax2 = this._engineGetWindowButton(win, "minmax2");
		btnMinMax2.title = this.i18n.restore;
		btnMinMax2.isVisible = false;
		btnMinMax2.style.display = "none";
		btnMinMax2._isEnabled = true;
		btnMinMax2.isPressed = false;
		btnMinMax2.label = "minmax2";
		btnMinMax2._doOnClick = function() { that._restoreWindow(this.winId); }
		
		// close
		var btnClose = this._engineGetWindowButton(win, "close");
		btnClose.title = this.i18n.close;
		btnClose.isVisible = true;
		btnClose._isEnabled = true;
		btnClose.isPressed = false;
		btnClose.label = "close";
		btnClose._doOnClick = function() { that._closeWindow(this.winId); }
		
		// dock
		var btnDock = this._engineGetWindowButton(win, "dock");
		btnDock.title = this.i18n.dock;
		btnDock.style.display = "none";
		btnDock.isVisible = false;
		btnDock._isEnabled = true;
		btnDock.isPressed = false;
		btnDock.label = "dock";
		btnDock._doOnClick = function() {
			
			// that._closeWindow(win);
		}
		
		//
		win._isSticked = false;
		win._isParked = false;
		win._isParkedAllowed = true;
		win._isMaximized = false;
		win._isDocked = false;
		
		//
		win.btns = {};
		win.btns["stick"] = btnStick;
		win.btns["sticked"] = btnSticked;
		win.btns["help"] = btnHelp;
		win.btns["park"] = btnPark;
		win.btns["minmax1"] = btnMinMax1;
		win.btns["minmax2"] = btnMinMax2;
		win.btns["close"] = btnClose;
		win.btns["dock"] = btnDock;
		
		// events
		for (var a in win.btns) {
			win.btns[a].winId = win.idd;
			this._attachEventsOnButton(win.idd, a);
		}
		
		win = btnStick = btnSticked = btnHelp = btnPark = btnMinMax1 = btnMinMax2 = btnClose = btnDock = null;
		//*/
//#}		
	}
//#wind_buttons:09062008{
	this._attachEventsOnButton = function(winId, btnId) {
		
		var btn = this.wins[winId].btns[btnId];
		
		// add events
		if (!this._isIPad) {
			
			btn.onmouseover = function() {
				if (this._isEnabled) {
					this.className = "dhtmlx_wins_btns_button dhtmlx_button_"+this.label+"_over_"+(this.isPressed?"pressed":"default");
				} else {
					this.className = "dhtmlx_wins_btns_button dhtmlx_button_"+this.label+"_disabled";
				}
			}
			btn.onmouseout = function() {
				if (this._isEnabled) {
					this.isPressed = false;
					this.className = "dhtmlx_wins_btns_button dhtmlx_button_"+this.label+"_default";
				} else {
					this.className = "dhtmlx_wins_btns_button dhtmlx_button_"+this.label+"_disabled";
				}
			}
			btn.onmousedown = function() {
				if (this._isEnabled) {
					this.isPressed = true;
					this.className = "dhtmlx_wins_btns_button dhtmlx_button_"+this.label+"_over_pressed";
				} else {
					this.className = "dhtmlx_wins_btns_button dhtmlx_button_"+this.label+"_disabled";
				}
			}
			btn.onmouseup = function() {
				if (this._isEnabled) {
					var wasPressed = this.isPressed;
					this.isPressed = false;
					this.className = "dhtmlx_wins_btns_button dhtmlx_button_"+this.label+"_over_default";
					if (wasPressed) {
						// events
						if (this.checkEvent("onClick")) {
							this.callEvent("onClick", [that.wins[this.winId], this]);
						} else {
							this._doOnClick();
						}
					}
				} else {
					this.className = "dhtmlx_wins_btns_button dhtmlx_button_"+this.label+"_disabled";
				}
			}
			
		} else {
			
			btn.ontouchstart = function(e) {
				e.cancelBubble = true;
				e.returnValue = false;
				return false;
			}
			btn.ontouchend = function(e) {
				e.cancelBubble = true;
				e.returnValue = false;
				if (!this._isEnabled) return false;
				
				// events
				if (this.checkEvent("onClick")) {
					this.callEvent("onClick", [that.wins[this.winId], this]);
				} else {
					this._doOnClick();
				}
				
				
				return false;
			}
			
		}
	
/**
*   @desc: shows a button
*   @type:  public
*/
		btn.show = function() {
			that._showButton(that.wins[this.winId], this.label, true);
		}
/**
*   @desc: hides a button
*   @type:  public
*/
		btn.hide = function() {
			that._hideButton(that.wins[this.winId], this.label, true);
		}
/**
*   @desc: enables a button
*   @type:  public
*/

		btn.enable = function() {
			that._enableButton(that.wins[this.winId], this.label);
		}

/**
*   @desc: disables a button
*   @type:  public
*/
		btn.disable = function() {
			that._disableButton(that.wins[this.winId], this.label);
		}
/**
*   @desc: checks if a button is enabled
*	@returns: true if enabled, otherwise - false
*   @type:  public
*/
		btn.isEnabled = function() {
			return this._isEnabled;
		}

/**
*   @desc: checks  if a button is hidden
*	@returns: true if hidden, otherwise - false
*   @type:  public
*/
		btn.isHidden = function() {
			return (!this.isVisible);
		}
		
		dhtmlxEventable(btn);
		
		btn = null;
	}
//#}	
//#wind_park:09062008{
	this._parkWindow = function(winId, parkBeforeMinMax) {
		var win = this.wins[winId];
		if (!win._isParkedAllowed && !parkBeforeMinMax) return;
		if (this.enableParkEffect && win.parkBusy) return;
		if (win._isParked) {
			// park down
			if (this.enableParkEffect && !parkBeforeMinMax) {
				// effect
				win.parkBusy = true;
				this._doParkDown(win);
			} else {
				// no effect
				win.h = win.lastParkH;
				this._engineRedrawWindowSize(win);
				this._engineDoOnWindowParkDown(win);
				win.updateNestedObjects();
				win.btns["park"].title = win.btns["park"].titleIfNotParked;
				if (win._allowResizeGlobal == true) {
					this._enableButton(win, "minmax1");
					this._enableButton(win, "minmax2");
				}
				win._isParked = false;
				// onParkDown event
				if (!parkBeforeMinMax) if (win.checkEvent("onParkDown")) win.callEvent("onParkDown", [win]); else this.callEvent("onParkDown", [win]);
			}
		} else {
			// park up
			if (this.enableParkEffect && !parkBeforeMinMax) {
				win.lastParkH = (String(win.h).search(/\%$/)==-1?win.h:win.offsetHeight);
				if (win._allowResizeGlobal == true) {
					this._disableButton(win, "minmax1");
					this._disableButton(win, "minmax2");
				}
				if (this.enableParkEffect) {
					win.parkBusy = true;
					this._doParkUp(win);
				} else {
					var skinParams = (win._skinParams!=null?win._skinParams:this.skinParams[this.skin]);
					win.h = skinParams["header_height"] + skinParams["border_bottom_height"];
					win.btns["park"].title = win.btns["park"].titleIfParked;
				}
			} else {
				win.lastParkH = (String(win.h).search(/\%$/)==-1?win.h:win.offsetHeight);
				win.h = this._engineGetWindowParkedHeight(win);
				this._engineRedrawWindowSize(win);
				this._engineDoOnWindowParkUp(win);
				win.btns["park"].title = win.btns["park"].titleIfParked;
				win._isParked = true;
				// onParkUp event
				if (!parkBeforeMinMax) if (win.checkEvent("onParkUp")) win.callEvent("onParkUp", [win]); else this.callEvent("onParkUp", [win]);
			}
		}
		win = null;
	}
	
	this._allowParking = function(win) {
		win._isParkedAllowed = true;
		this._enableButton(win, "park");
	}
	this._denyParking = function(win) {
		win._isParkedAllowed = false;
		this._disableButton(win, "park");
	}
	
	// park with effects
	this.enableParkEffect = false;
	this.parkStartSpeed = 80;
	this.parkSpeed = this.parkStartSpeed;
	this.parkTM = null;
	this.parkTMTime = 5;
	
	this._doParkUp = function(win) {
		if (String(win.h).search(/\%$/) != -1) { win.h = win.offsetHeight; }
		win.h -= this.parkSpeed;
		var hh = this._engineGetWindowParkedHeight(win);
		if (win.h <= hh) {
			// end purkUp
			win.h = hh;
			this._engineGetWindowButton(win, "park").title = this._engineGetWindowButton(win, "park").titleIfParked;
			win._isParked = true;
			win.parkBusy = false;
			this._engineRedrawWindowSize(win);
			this._engineDoOnWindowParkUp(win);
			if (win.checkEvent("onParkUp")) win.callEvent("onParkUp", [win]); else this.callEvent("onParkUp", [win]);
		} else {
			// continue purkUp
			this._engineRedrawWindowSize(win);
			this.parkTM = window.setTimeout(function(){that._doParkUp(win);}, this.parkTMTime);
		}
	}
	
	this._doParkDown = function(win) {
		win.h += this.parkSpeed;
		if (win.h >= win.lastParkH) {
			win.h = win.lastParkH;
			this._engineGetWindowButton(win, "park").title = this._engineGetWindowButton(win, "park").titleIfNotParked;
			if (win._allowResizeGlobal == true) {
				this._enableButton(win, "minmax1");
				this._enableButton(win, "minmax2");
			}
			win._isParked = false;
			win.parkBusy = false;
			this._engineRedrawWindowSize(win);
			win.updateNestedObjects();
			this._engineDoOnWindowParkDown(win);
			if (win.checkEvent("onParkDown")) win.callEvent("onParkDown", [win]); else this.callEvent("onParkDown", [win]);
		} else {
			// continue purkDown
			this._engineRedrawWindowSize(win);
			this.parkTM = window.setTimeout(function(){that._doParkDown(win);}, this.parkTMTime);
		}
	}
//#}
//#wind_buttons:09062008{
	this._enableButton = function(win, btn) {
		var button = this._engineGetWindowButton(win, btn);
		if (!button) return;
		button._isEnabled = true;
		button.className = "dhtmlx_wins_btns_button dhtmlx_button_"+button.label+"_default";
		button = null;
	}
	
	this._disableButton = function(win, btn) {
		var button = this._engineGetWindowButton(win, btn);
		if (!button) return;
		button._isEnabled = false;
		button.className = "dhtmlx_wins_btns_button dhtmlx_button_"+win.btns[btn].label+"_disabled";
		button = null;
	}
//#}
	// resize
	this._allowReszieGlob = function(win) {
		win._allowResizeGlobal = true;
		this._enableButton(win, "minmax1");
		this._enableButton(win, "minmax2");
	}
	
	this._denyResize = function(win) {
		win._allowResizeGlobal = false;
		this._disableButton(win, "minmax1");
		this._disableButton(win, "minmax2");
	}
	
	this._maximizeWindow = function(winId) {
		
		var win = this.wins[winId];
		
		if (win._allowResizeGlobal == false) return;
		
		var isParkedBeforeMinMax = win._isParked;
		if (isParkedBeforeMinMax) this._parkWindow(win.idd, true);
		
		win.lastMaximizeX = win.x;
		win.lastMaximizeY = win.y;
		win.lastMaximizeW = win.w;
		win.lastMaximizeH = win.h;
		// put window into top/left corner if complete maximize or center new maximized window if maxDimension set
		if (win.maxW != "auto" && win.maxW != "auto") {
			win.x = Math.round(win.x+(win.w-win.maxW)/2);
			win.y = Math.round(win.y+(win.h-win.maxH)/2);
			win._allowMove = true;
		} else {
			win.x = 0;
			win.y = 0;
			win._allowMove = false;
		}
		win._isMaximized = true;
		win._allowResize = false;
		// win.w = (win.maxW == "auto" ? (this.vp == document.body ? document.body.offsetWidth:parseInt(this.vp.style.width)) : win.maxW);
		// win.h = (win.maxH == "auto" ? (this.vp == document.body ? document.body.offsetHeight:parseInt(this.vp.style.height)) : win.maxH);
		//
		win.w = (win.maxW == "auto" ? (this.vp == document.body ? "100%" : (this.vp.style.width != "" && String(this.vp.style.width).search("%") == -1 ? parseInt(this.vp.style.width) : this.vp.offsetWidth)) : win.maxW);
		win.h = (win.maxH == "auto" ? (this.vp == document.body ? "100%" : (this.vp.style.height != "" && String(this.vp.style.width).search("%") == -1 ? parseInt(this.vp.style.height) : this.vp.offsetHeight)) : win.maxH);
		
		//
		this._hideButton(win, "minmax1");
		this._showButton(win, "minmax2");
		this._engineRedrawWindowPos(win);
		
		if (isParkedBeforeMinMax) {
			this._parkWindow(win.idd, true);
		} else {
			this._engineRedrawWindowSize(win);
			win.updateNestedObjects();
		}
		// event
		if (win.checkEvent("onMaximize")) win.callEvent("onMaximize", [win]); else this.callEvent("onMaximize", [win]);
		win = null;
	}
	
	this._restoreWindow = function(winId) {
		var win = this.wins[winId];
		if (win._allowResizeGlobal == false) return;
		if (win.layout) win.layout._defineWindowMinDimension(win);
		
		var isParkedBeforeMinMax = win._isParked;
		if (isParkedBeforeMinMax) this._parkWindow(win.idd, true);
		
		// put window to prev place if auto max dimension or center
		if (win.maxW != "auto" && win.maxW != "auto") {
			win.x = Math.round(win.x+(win.w-win.lastMaximizeW)/2);
			win.y = Math.round(win.y+(win.h-win.lastMaximizeH)/2);
		} else {
			win.x = win.lastMaximizeX;
			win.y = win.lastMaximizeY;
		}
		win.w = win.lastMaximizeW;
		win.h = win.lastMaximizeH;
		win._isMaximized = false;
		win._allowMove = win._allowMoveGlobal;
		win._allowResize = true;
		this._fixWindowDimensionInViewport(win);
		this._hideButton(win, "minmax2");
		this._showButton(win, "minmax1");
		this._engineRedrawWindowPos(win);
		
		if (isParkedBeforeMinMax) {
			this._parkWindow(win.idd, true);
		} else {
			this._engineRedrawWindowSize(win);
			win.updateNestedObjects();
		}
		// events
		if (win.checkEvent("onMinimize")) win.callEvent("onMinimize", [win]); else this.callEvent("onMinimize", [win]);
		win = null;
	}
//#wind_buttons:09062008{	
	this._showButton = function(win, btn, userShow) {
		var button = this._engineGetWindowButton(win, btn);
		if (!button) return;
		if ((!userShow && button._userHide) || button.isVisible === true) return;
		button.isVisible = true;
		button.style.display = "";
		button.style.visibility = "visible";
		button._userHide = !(userShow==true);
		this._engineRedrawWindowTitle(win);
		button = null;
	}
	
	this._hideButton = function(win, btn, userHide) {
		var button = this._engineGetWindowButton(win, btn);
		if (!button || (!userHide && button.isVisible === false)) return;
		button.isVisible = false;
		button.style.display = "none";
		button.style.visibility = "hidden";
		button._userHide = (userHide==true);
		this._engineRedrawWindowTitle(win);
		button = null;
	}
//#}	
	this._showWindow = function(win) {
		win.style.display = "";
		// event
		if (win.checkEvent("onShow")) {
			win.callEvent("onShow", [win]);
		} else {
			this.callEvent("onShow", [win]);
		}
		// fixed 24.03.2008
		var w = this._getActive();
		if (w == null) {
			this._bringOnTop(win);
			this._makeActive(win);
		} else if (this._isWindowHidden(w)) {
			this._bringOnTop(win);
			this._makeActive(win);
		}
		if (this.iframeMode && win.ifr) win.ifr.style.display = "";
	}
	
	this._hideWindow = function(win) {
		win.style.display = "none";
		// event
		if (win.checkEvent("onHide")) {
			win.callEvent("onHide", [win]);
		} else {
			this.callEvent("onHide", [win]);
		}
		// fixed 24.03.2008
		var w = this.getTopmostWindow(true);
		if (w != null) {
			this._bringOnTop(w);
			this._makeActive(w);
		}
		if (this.iframeMode && win.ifr) win.ifr.style.display = "none";
	}
	
	this._isWindowHidden = function(win) {
		var isHidden = (win.style.display == "none");
		return isHidden;
	}
	
	this._closeWindow = function(winId) {
		
		var win = this.wins[winId];
		
		// ie focus fix
		if (this._focusFixIE) {
			this._focusFixIE.style.top = (this.vp==document.body?0:getAbsoluteTop(this.vp))+Number(win.y)+"px";
			this._focusFixIE.focus();
		}
		
		// event
		if (win.checkEvent("onClose")) {
			if (!win.callEvent("onClose", [win])) return;
		} else {
			if(!this.callEvent("onClose", [win])) return;
		}
		
		// closing
		// for (var a in win.btns) { this._removeButtonGlobal(win, a, win.btns[a]); }
		
		win = null;
		
		this._removeWindowGlobal(winId);
		
		/*
		this.vp.removeChild(win);
		delete this.wins[win.idd];
		// make active latest window
		*/
		
		var latest = { "zi": 0 };
		for (var a in this.wins) { if (this.wins[a].zi > latest.zi) { latest = this.wins[a]; } }
		if (latest != null) { this._makeActive(latest); }
		
		/*
		// toolbar clicks events, temporary removed
		if (_isFF && this.vp != document.body) {
			this.vp.style.display = "none";
			var vp = this.vp;
			window.setTimeout(function(){vp.style.display="";},1);
		}
		*/
	}
	
	this._needHelp = function(winId) {
		// event only
		var win = this.wins[winId];
		if (win.checkEvent("onHelp")) {
			win.callEvent("onHelp", [win]);
		} else {
			this.callEvent("onHelp", [win]);
		}
		win = null;
	}
	this._setWindowIcon = function(win, iconEnabled, iconDisabled) {
		win.iconsPresent = true;
		win.icons[0] = this.imagePath + iconEnabled;
		win.icons[1] = this.imagePath + iconDisabled;
		this._engineUpdateWindowIcon(win, win.icons[win.isOnTop()?0:1]);
	}
	
	this._getWindowIcon = function(win) {
		if (win.iconsPresent) {
			return new Array(win.icons[0], win.icons[1]);
		} else {
			return new Array(null, null);
		}
	}
	
	this._clearWindowIcons = function(win) {
		win.iconsPresent = false;
		win.icons[0] = this.imagePath + this.pathPrefix + this.skin + "/active/icon_blank.gif";
		win.icons[1] = this.imagePath + this.pathPrefix + this.skin + "/inactive/icon_blank.gif";
		this._engineUpdateWindowIcon(win, win.icons[win.isOnTop()?0:1]);
	}
	
	this._restoreWindowIcons = function(win) {
		win.iconsPresent = true;
		win.icons[0] = this.imagePath + this.pathPrefix + this.skin + "/active/icon_normal.gif";
		win.icons[1] = this.imagePath + this.pathPrefix + this.skin + "/inactive/icon_normal.gif";
		this._engineUpdateWindowIcon(win, win.icons[win.className=="dhtmlx_window_active"?0:1]);
	}
	
	this._attachWindowContentTo = function(win, obj, w, h) {
		
		var data = this._engineGetWindowContent(win).parentNode;
		data.parentNode.removeChild(data);
		win.hide();
		data.style.left = "0px";
		data.style.top = "0px";
		data.style.width = (w!=null?w:obj.offsetWidth)+"px";
		data.style.height = (h!=null?h:obj.offsetHeight)+"px";
		data.style.position = "relative";
		//
		obj.appendChild(data);
		this._engineGetWindowContent(win).style.width = data.style.width;
		this._engineGetWindowContent(win).style.height = data.style.height;
		/*
		
		var data = win._content;
		data.parentNode.removeChild(data);
		win.hide();
		//
		data.style.left = "0px";
		data.style.top = "0px";
		data.style.width = (w!=null?w:obj.offsetWidth)+"px";
		data.style.height = (h!=null?h:obj.offsetHeight)+"px";
		data.style.position = "relative";
		//
		obj.appendChild(data);
		
		*/
		
	}
	
	this._setWindowToFullScreen = function(win, state) {
		
		if (state == true && !win._isFullScreened) {
			//
			win._p1 = win.vs[win.av].dhxcont.nextSibling;
			win._p1.parentNode.removeChild(win.vs[win.av].dhxcont);
			win.hide();
			win._isFullScreened = true;
			
			win._FSoffsetHeight = win._offsetHeight;
			win._FSoffsetHeightSaved = win._offsetHeightSaved;
			win._FSoffsetLeft = win._offsetLeft;
			win._FSoffsetWidth = win._offsetWidth;
			
			win._offsetHeight = 0;
			win._offsetHeightSaved = 0;
			win._offsetLeft = 0;
			win._offsetWidth = 0;
			
			win.vs[win.av].dhxcont.style.position = "absolute";
			document.body.appendChild(win.vs[win.av].dhxcont);
			win.adjustContent(document.body, 0, 0, false, 0);
			win.updateNestedObjects();
		}
		
		if (state == false && win._isFullScreened) {
			
			win._p1.parentNode.insertBefore(win.vs[win.av].dhxcont, win._p1);
			win._p1 = null;
			win._isFullScreened = false;
			
			win._offsetHeight = win._FSoffsetHeight;
			win._offsetHeightSaved = win._FSoffsetHeightSaved;
			win._offsetLeft = win._FSoffsetLeft;
			win._offsetWidth = win._FSoffsetWidth;
			
			win._FSoffsetHeight = win._FSoffsetHeightSaved = win._FSoffsetLeft = win._FSoffsetWidth = null;
			
			win.show();
			win.setDimension(win.w, win.h);
			
			win.bringToTop();
			
		}
		
	}
	
	this._isWindowOnTop = function(win) {
		var state = (this.getTopmostWindow() == win);
		return state;
	}
	
	this._bringOnBottom = function(win) {
		for (var a in this.wins) {
			if (this.wins[a].zi < win.zi) {
				this.wins[a].zi += this.zIndexStep;
				this.wins[a].style.zIndex = this.wins[a].zi;
			}
		}
		win.zi = 50;
		win.style.zIndex = win.zi;
		//
		this._makeActive(this.getTopmostWindow());
	}
	
	this._isWindowOnBottom = function(win) {
		var state = true;
		for (var a in this.wins) {
			if (this.wins[a] != win) {
				state = state && (this.wins[a].zi > win.zi);
			}
		}
		return state;
	}
	
	this._stickWindow = function(winId) {
		var win = this.wins[winId];
		win._isSticked = true;
		this._hideButton(win, "stick");
		this._showButton(win, "sticked");
		this._bringOnTop(win);
		win = null;
	}
	
	this._unstickWindow = function(winId) {
		var win = this.wins[winId];
		win._isSticked = false;
		this._hideButton(win, "sticked");
		this._showButton(win, "stick");
		this._bringOnTopAnyStickedWindows();
		win = null;
	}
//#wind_buttons:09062008{
	// add user button
	this._addUserButton = function(win, id, pos, title) {
		id = String(id).toLowerCase();
		var userButton = this._engineAddUserButton(win, id, pos);
		userButton.title = title;
		userButton.isVisible = true;
		userButton._isEnabled = true;
		userButton.isPressed = false;
		userButton.label = id;
		win.btns[id] = userButton;
		win.btns[id].winId = win.idd
		win.btns[id]._doOnClick = function(){};
		// attach events
		this._attachEventsOnButton(win.idd, id);
		userButton = null;
	}
	
	// remove user button
	this._removeUserButton = function(win, buttonId) {
		this._removeButtonGlobal(win, buttonId);
	}
//#}	
	// add iframe blockers before drag and resize
	this._blockSwitcher = function(state) {
		for (var a in this.wins) {
			if (state == true) {
				this.wins[a].showCoverBlocker();
			} else {
				this.wins[a].hideCoverBlocker();
			}
		}
	}
	
	this.resizingWin = null;
	this.modalWin = null;
	this.resizingDirs = "none";
	
	// init functions
	
	// focus fix ie case
	if (_isIE) {
		this._focusFixIE = document.createElement("INPUT");
		this._focusFixIE.className = "dhx_windows_ieonclosefocusfix";
		this._focusFixIE.style.position = "absolute";
		this._focusFixIE.style.width = "1px";
		this._focusFixIE.style.height = "1px";
		this._focusFixIE.style.border = "none";
		this._focusFixIE.style.background = "none";
		this._focusFixIE.style.left = "-10px";
		this._focusFixIE.style.fontSize = "1px";
		document.body.appendChild(this._focusFixIE);
	}
	
	this._createViewport();
//#wind_move:09062008{	
	this._doOnMouseUp = function() {
		if (that != null) that._stopMove();
	}
	this._doOnMoseMove = function(e) {
		e = e||event;
		if (that != null) that._moveWindow(e);
	}
//#}	
	this._resizeTM = null;
	this._resizeTMTime = 200;
	this._lw = null;
	this._doOnResize = function() {
		if (that._lw != document.documentElement.clientHeight) {
			window.clearTimeout(that._resizeTM);
			that._resizeTM = window.setTimeout(function(){that._autoResizeViewport();}, that._resizeTMTime);
		}
		that._lw = document.documentElement.clientHeight;
	}
	this._doOnUnload = function() {
		that.unload();
	}
	this._doOnSelectStart = function(e) {
		e = e||event;
		if (that.movingWin != null || that.resizingWin != null) e.returnValue = false;
	}
	if (_isIE) {
		document.body.attachEvent("onselectstart", this._doOnSelectStart);
	}
	
	dhtmlxEvent(window, "resize", this._doOnResize);
	dhtmlxEvent(document.body, "unload", this._doOnUnload);
	
	if (this._isIPad) {
		document.addEventListener("touchmove", this._doOnMoseMove, false);
		document.addEventListener("touchend", this._doOnMouseUp, false);
	} else {
//#wind_move:09062008{		
		dhtmlxEvent(document.body, "mouseup", this._doOnMouseUp);
		dhtmlxEvent(this.vp, "mousemove", this._doOnMoseMove);
		dhtmlxEvent(this.vp, "mouseup", this._doOnMouseUp);
//#}
	}
	
	
	this._setWindowModal = function(win, state) {
		
		if (state == true) {
			
			this._makeActive(win);
			this._bringOnTop(win);
			this.modalWin = win;
			win._isModal = true;
			//
			this.modalCoverI.style.zIndex = win.zi - 2;
			this.modalCoverI.style.display = "";
			//
			this.modalCoverD.style.zIndex = win.zi - 2;
			this.modalCoverD.style.display = "";
		} else {
			this.modalWin = null;
			win._isModal = false;
			//
			this.modalCoverI.style.zIndex = 0;
			this.modalCoverI.style.display = "none";
			//
			this.modalCoverD.style.zIndex = 0;
			this.modalCoverD.style.display = "none";
		}
	}
	
	this._bringOnTopAnyStickedWindows = function() {
		var wins = new Array();
		for (var a in this.wins) { if (this.wins[a]._isSticked) { wins[wins.length] = this.wins[a]; } }
		for (var q=0; q<wins.length; q++) { this._bringOnTop(wins[q]); }
		// if no more sticked search any non-top active and move them on top
		if (wins.length == 0) {
			for (var a in this.wins) {
				if (this.wins[a].className == "dhtmlx_window_active") { this._bringOnTop(this.wins[a]); }
			}
		}
	}
	
	/**
	*   @desc: unloads an object and clears memory
	*   @param: id - button's id
	*   @type: public
	*/
	this.unload = function() {
		this._clearAll();
	}
	
	this._removeButtonGlobal = function(winId, buttonId) {
//#wind_buttons:09062008{
		//
		if (!this.wins[winId]) return;
		if (!this.wins[winId].btns[buttonId]) return;
		
		var btn = this.wins[winId].btns[buttonId];
		
		btn.title = null;
		btn.isVisible = null;
		btn._isEnabled = null;
		btn.isPressed = null;
		btn.label = null;
		
		btn._doOnClick = null;
		
		btn.detachAllEvents();
		
		btn.attachEvent = null;
		btn.callEvent = null;
		btn.checkEvent = null;
		btn.detachEvent = null;
		btn.detachAllEvents = null;
		btn.disable = null;
		btn.enable = null;
		btn.eventCatcher = null;
		btn.hide = null;
		btn.isEnabled = null;
		btn.isHidden = null;
		btn.show = null;
		
		btn.onmousedown = null;
		btn.onmouseout = null;
		btn.onmouseover = null;
		btn.onmouseup = null;
		btn.ontouchstart = null;
		btn.ontouchend = null;
		
		if (btn.parentNode) btn.parentNode.removeChild(btn);
		btn = null;
		
		this.wins[winId].btns[buttonId] = null;
		delete this.wins[winId].btns[buttonId];
//#}
	}
	
	
	this._removeWindowGlobal = function(winId) {
		
		var win = this.wins[winId];
		
		// modal check
		if (this.modalWin == win) this._setWindowModal(win, false);
		
		if (this.iframeMode && win.ifr) {
			win.ifr.parentNode.removeChild(win.ifr);
			win.ifr = null;
		}
		
		// clear attached frame events
		/*
		if (win._frame) {
			if (_isIE) {
				try {
					win._frame.onreadystatechange = null;
					win._frame.contentWindow.document.body.onmousedown = null;
					win._frame.onload = null;
				} catch(e) {}
			} else {
				try {
					win._frame.contentWindow.onmousedown = null;
					win._frame.onload = null;
				} catch(e) {}
			}
		}
		*/
		// clear cover events
		var t = win.coverBlocker();
		t.onselectstart = null;
		t = null;
		
		// remove onselect event
		this._engineDiableOnSelectInWindow(win, false);
		
		// remove dhxcont
		win._dhxContDestruct();
		
		// remove header events
		this._engineGetWindowHeader(win).onmousedown = null;
		this._engineGetWindowHeader(win).ondblclick = null;
		
		// clear links
		this.movingWin = null;
		this.resizingWin = null;
		
		// clearing buttons
		for (var a in win.btns) this._removeButtonGlobal(win, a);
		win.btns = null;
		
		win.detachAllEvents();
		
		// clear win other events
		win._adjustToContent = null;
		win._doOnAttachMenu = null;
		win._doOnAttachStatusBar = null;
		win._doOnAttachToolbar = null;
		win._doOnFrameMouseDown = null;
		win._doOnFrameContentLoaded = null;
		//
		win._redraw = null;
		win.addUserButton = null;
		win.allowMove = null;
		win.allowPark = null;
		win.allowResize = null;
		win.attachEvent = null;
		win.bringToBottom = null;
		win.bringToTop = null;
		win.callEvent = null;
		win.center = null;
		win.centerOnScreen = null;
		win.checkEvent = null;
		win.clearIcon = null;
		win.close = null;
		win.denyMove = null;
		win.denyPark = null;
		win.denyResize = null;
		win.detachEvent = null;
		win.detachAllEvents = null;
		win.eventCatcher = null;
		win.getDimension = null;
		win.getIcon = null;
		win.getId = null;
		win.getMaxDimension = null;
		win.getMinDimension = null;
		win.getPosition = null;
		win.getText = null;
		win.hide = null;
		win.hideHeader = null;
		win.isHidden = null;
		win.isMaximized = null;
		win.isModal = null;
		win.isMovable = null;
		win.isOnBottom = null;
		win.isOnTop = null;
		win.isParkable = null;
		win.isParked = null;
		win.isResizable = null;
		win.isSticked = null;
		win.keepInViewport = null;
		win.maximize = null;
		win.minimize = null;
		win.park = null;
		win.progressOff = null;
		win.progressOn = null;
		win.removeUserButton = null;
		win.restoreIcon = null;
		win.setDimension = null;
		win.setIcon = null;
		win.setMaxDimension = null;
		win.setMinDimension = null;
		win.setModal = null;
		win.setPosition = null;
		win.setText = null;
		win.setToFullScreen = null;
		win.show = null;
		win.showHeader = null;
		win.stick = null;
		win.unstick = null;
		
		win.onmousemove = null;
		win.onmousedown = null;
		
		win.icons = null;
		win.button = null;
		
		win._dhxContDestruct = null;
		
		win.dhxContGlobal.obj = null;
		win.dhxContGlobal.setContent = null;
		win.dhxContGlobal.dhxcont = null;
		win.dhxContGlobal = null;
		
		// frame
		if (win._frame) {
			while (win._frame.childNodes.length > 0) win._frame.removeChild(win._frame.childNodes[0]);
			win._frame = null;
		}
		
		// clear functions
		this._parseNestedForEvents(win);
		
		// remove from page
		win._content = null;
		win.innerHTML = "";
		win.parentNode.removeChild(win);
		
		win = null;
		
		this.wins[winId] = null;
		delete this.wins[winId];
		
	}
	
	this._removeEvents = function(obj) {
		obj.onmouseover = null;
		obj.onmouseout = null;
		obj.onmousemove = null;
		obj.onclick = null;
		obj.ondblclick = null;
		obj.onmouseenter = null;
		obj.onmouseleave = null;
		obj.onmouseup = null;
		obj.onmousewheel = null;
		obj.onmousedown = null;
		obj.onselectstart = null;
		obj.onfocus = null;
		obj.style.display = "";
		obj = null;
	}
	this._parseNestedForEvents = function(obj) {
		this._removeEvents(obj);
		for (var q=0; q<obj.childNodes.length; q++) {
			if (obj.childNodes[q].tagName != null) { this._parseNestedForEvents(obj.childNodes[q]); }
		}
		obj = null;
	}
	
	this._clearAll = function() {
		
		// remove events attached to document.body/window/viewport
		this._clearDocumentEvents();
		
		// remove windows
		for (var a in this.wins) this._removeWindowGlobal(a);
		this.wins = null;
		
		// remove carcass
		this._parseNestedForEvents(this._carcass);
		while (this._carcass.childNodes.length > 0) this._carcass.removeChild(this._carcass.childNodes[0]);
		this._carcass.onselectstart = null;
		this._carcass.parentNode.removeChild(this._carcass);
		this._carcass = null;
		
		// remove viewport cover
		this._parseNestedForEvents(this._vpcover);
		this._vpcover.parentNode.removeChild(this._vpcover);
		this._vpcover = null;
		
		// remove modal covers
		this._parseNestedForEvents(this.modalCoverD);
		this.modalCoverD.parentNode.removeChild(this.modalCoverD);
		this.modalCoverD = null;
		this._parseNestedForEvents(this.modalCoverI);
		this.modalCoverI.parentNode.removeChild(this.modalCoverI);
		this.modalCoverI = null;
		
		
		// remove viewport
		// this.vp.className = String(this.vp.className).replace(/[a-z_]{1,}/gi,function(t){return({"dhtmlx_skin_dhx_skyblue":1,"dhtmlx_skin_dhx_blue":1,"dhtmlx_skin_dhx_black":1,"dhtmlx_skin_dhx_web":1}[t]==1?"":t);});
		if (this.vp.autocreated == true) this.vp.parentNode.removeChild(this.vp);
		this.vp = null;
		
		// skin params
		for (var a in this.skinParams) { delete this.skinParams[a]; }
		this.skinParams = null;
		
		this._effects = null;
		this._engineSkinParams = null;
		
		this._addDefaultButtons = null;
		this._addUserButton = null;
		this._allowParking = null;
		this._allowReszieGlob = null;
		this._attachEventsOnButton = null;
		this._attachWindowContentTo = null;
		this._autoResizeViewport = null;
		this._blockSwitcher = null;
		this._bringOnBottom = null;
		this._bringOnTop = null;
		this._bringOnTopAnyStickedWindows = null;
		this._centerWindow = null;
		this._clearAll = null;
		this._clearDocumentEvents = null;
		this._clearWindowIcons = null;
		this._closeWindow = null;
		this._createViewport = null;
		this._denyParking = null;
		this._denyResize = null;
		this._dhx_Engine = null;
		this._disableButton = null;
		this._doOnMoseMove = null;
		this._doOnMouseUp = null;
		this._doOnResize = null;
		this._doOnSelectStart = null;
		this._doOnUnload = null;
		this._doParkDown = null;
		this._doParkUp = null;
		this._enableButton = null;
		this._engineAddUserButton = null;
		this._engineAdjustWindowToContent = null;
		this._engineAllowWindowResize = null;
		this._engineCheckHeaderMouseDown = null;
		this._engineDiableOnSelectInWindow = null;
		this._engineDoOnWindowParkDown = null;
		this._engineDoOnWindowParkUp = null;
		this._engineFixWindowPosInViewport = null;
		this._engineGetWindowButton = null;
		this._engineGetWindowContent = null;
		this._engineGetWindowHeader = null;
		this._engineGetWindowHeaderState = null;
		this._engineGetWindowLabel = null;
		this._engineGetWindowParkedHeight = null;
		this._engineRedrawSkin = null;
		this._engineRedrawWindowPos = null;
		this._engineRedrawWindowSize = null;
		this._engineRedrawWindowTitle = null;
		this._engineSetWindowBody = null;
		this._engineSwitchWindowHeader = null;
		this._engineSwitchWindowProgress = null;
		this._engineUpdateWindowIcon = null;
		this._fixWindowDimensionInViewport = null;
		this._genStr = null;
		this._getActive = null;
		this._getTopZIndex = null;
		this._getWindowIcon = null;
		this._hideButton = null;
		this._hideWindow = null;
		this._isWindowHidden = null;
		this._isWindowOnBottom = null;
		this._isWindowOnTop = null;
		this._makeActive = null;
		this._maximizeWindow = null;
		this._moveWindow = null;
		this._needHelp = null;
		this._parkWindow = null;
		this._parseNestedForEvents = null;
		this._removeButtonGlobal = null;
		this._removeEvents = null;
		this._removeUserButton = null;
		this._removeWindowGlobal = null;
		this._restoreWindow = null;
		this._restoreWindowIcons = null;
		this._setWindowIcon = null;
		this._setWindowModal = null;
		this._setWindowToFullScreen = null;
		this._showButton = null;
		this._showWindow = null;
		this._stickWindow = null;
		this._stopMove = null;
		this._unstickWindow = null;
		
		this.attachEvent = null;
		this.attachViewportTo = null;
		this.callEvent = null;
		this.checkEvent = null;
		this.createWindow = null;
		this.detachEvent = null;
		this.enableAutoViewport = null;
		this.eventCatcher = null;
		this.findByText = null;
		this.forEachWindow = null;
		this.getBottommostWindow = null;
		this.getEffect = null;
		this.getTopmostWindow = null;
		this.isWindow = null;
		this.setEffect = null;
		this.setImagePath = null;
		this.setSkin = null;
		this.setViewport = null;
		this.unload = null;
		this.window = null;
		
		that = null;
	}
	
	this._clearDocumentEvents = function() {
		if (_isIE) {
			window.detachEvent("onresize", this._doOnResize);
			document.body.detachEvent("onselectstart", this._doOnSelectStart);
			document.body.detachEvent("onmouseup", this._doOnMouseUp);
			document.body.detachEvent("onunload", this._doOnUnload);
			this.vp.detachEvent("onmousemove", this._doOnMoseMove);
			this.vp.detachEvent("onmouseup", this._doOnMouseUp);
		} else {
			window.removeEventListener("resize", this._doOnResize, false);
			document.body.removeEventListener("mouseup", this._doOnMouseUp, false);
			document.body.removeEventListener("unload", this._doOnUnload, false);
			this.vp.removeEventListener("mousemove", this._doOnMoseMove, false);
			this.vp.removeEventListener("mouseup", this._doOnMouseUp, false);
		}
	}
	
	/* additional features */
	/*
	if (this._enableStatusBar != null) { this._enableStatusBar(); }
	if (this._enableWebMenu != null) { this._enableWebMenu(); }
	if (this._enableWebToolbar != null) { this._enableWebToolbar(); }
	*/
	
	this._genStr = function(w) {
		var s = ""; var z = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		for (var q=0; q<w; q++) s += z.charAt(Math.round(Math.random() * (z.length-1)));
		return s;
	}
	
	dhtmlxEventable(this);
	return this;
};
dhtmlXWindows.prototype._dhx_Engine = function() {
	
	// engine init params
	this._engineEnabled = true;
	this._engineName = "dhx";
	
	// skin params
	// mh = menu height
	// th = toolbar height
	// sh = statusbar height
	this._engineSkinParams = {dhx_blue:	{"hh": 21, "lbw": 2, "rbw": 2, "lch": 2, "lcw": 14, "rch": 14, "rcw": 14, "bbh": 2, "mnh": 23, "tbh": 25, "sbh": 20, "noh_t": null, "noh_h": null},
				  dhx_black:	{"hh": 21, "lbw": 2, "rbw": 2, "lch": 2, "lcw": 14, "rch": 14, "rcw": 14, "bbh": 2, "mnh": 23, "tbh": 25, "sbh": 20, "noh_t": null, "noh_h": null},
				  dhx_skyblue:	{"hh": 29, "lbw": 2, "rbw": 2, "lch": 2, "lcw": 14, "rch": 14, "rcw": 14, "bbh": 2, "mnh": 23, "tbh": 25, "sbh": 20, "noh_t": 5, "noh_h": -10},
				  dhx_web:	{"hh": 27, "lbw": 5, "rbw": 5, "lch": 5, "lcw": 14, "rch": 14, "rcw": 14, "bbh": 5, "mnh": 23, "tbh": 25, "sbh": 20, "noh_t": 5, "noh_h": -10},
				  dhx_terrace:	{"hh": 37, "lbw": 5, "rbw": 5, "lch": 5, "lcw": 14, "rch": 14, "rcw": 14, "bbh": 5, "mnh": 23, "tbh": 25, "sbh": 20, "noh_t": 0, "noh_h": -10}
	};
	
	this._isIE6 = false;
	if (_isIE) this._isIE6 = (window.XMLHttpRequest==null?true:false);
	
	// forms window html
	this._engineSetWindowBody = function(win) {
		win.innerHTML = "<div iswin='1' class='dhtmlx_wins_body_outer' style='position: relative;'>"+
					(this._isIE6?"<iframe src='javascript:false;' frameborder='0' class='dhtmlx_wins_ie6_cover_fix' onload='this.contentWindow.document.body.style.overflow=\"hidden\";'></iframe>":"")+
					"<div class='dhtmlx_wins_icon'></div>"+
					"<div class='dhtmlx_wins_progress'></div>"+
					"<div class='dhtmlx_wins_title'>dhtmlxWindow</div>"+
					"<div class='dhtmlx_wins_btns'>"+
						"<div class='dhtmlx_wins_btns_button dhtmlx_button_sticked_default'></div>"+
						"<div class='dhtmlx_wins_btns_button dhtmlx_button_stick_default'></div>"+
						"<div class='dhtmlx_wins_btns_button dhtmlx_button_help_default'></div>"+
						"<div class='dhtmlx_wins_btns_button dhtmlx_button_park_default'></div>"+
						"<div class='dhtmlx_wins_btns_button dhtmlx_button_minmax2_default'></div>"+
						"<div class='dhtmlx_wins_btns_button dhtmlx_button_minmax1_default'></div>"+
						"<div class='dhtmlx_wins_btns_button dhtmlx_button_close_default'></div>"+
						"<div class='dhtmlx_wins_btns_button dhtmlx_button_dock_default'></div>"+
					"</div>"+
					"<div class='dhtmlx_wins_body_inner'></div>"+
					"<div winResT='yes' class='dhtmlx_wins_resizer_t' style='display:none;'></div>"+
					"<div winResL='yes' class='dhtmlx_wins_resizer_l'></div>"+
					"<div winResR='yes' class='dhtmlx_wins_resizer_r'></div>"+
					"<div winResB='yes' class='dhtmlx_wins_resizer_b'></div>"+
					"<div class='white_line'></div>"+
					"<div class='white_line2'></div>"+
				"</div>";
		
		// dhxCont(win);
		win.dhxContGlobal = new dhtmlXContainer(win);
		if (this.skin == "dhx_skyblue") {
			win.dhxContGlobal.obj._offsetWidth = -10;
			win.dhxContGlobal.obj._offsetHeight = -5;
			win.dhxContGlobal.obj._offsetLeft = 5;
			win.dhxContGlobal.obj._offsetHeightSaved = win.dhxContGlobal.obj._offsetHeight;
		}
		if (this.skin == "dhx_web") {
			win.dhxContGlobal.obj._offsetWidth = -10;
			win.dhxContGlobal.obj._offsetHeight = -5;
			win.dhxContGlobal.obj._offsetLeft = 5;
			win.dhxContGlobal.obj._offsetHeightSaved = win.dhxContGlobal.obj._offsetHeight;
		}
		win.skin = this.skin;
		win.dhxContGlobal.setContent(win.childNodes[0].childNodes[(this._isIE6?5:4)]);
		
		var t = win.coverBlocker();
		t.onselectstart = function(e) {
			e = e||event;
			e.returnValue = false;
			e.cancelBubble = true;
		}
		t = null;
		
		if (this.iframeMode) {
			win.ifr = document.createElement("IFRAME");
			win.ifr.style.position = "absolute";
			win.ifr.style.left = win.style.left;
			win.ifr.style.top = win.style.top;
			win.ifr.style.width = win.style.width;
			win.ifr.style.height = win.style.height;
			win.ifr.style.zIndex = win.style.zIndex-1;
			win.ifr.style.backgroundColor = "white";
			win.ifr.frameBorder = 0;
			win.ifr.setAttribute("src","javascript:false;");
			win.parentNode.appendChild(win.ifr);
		}
	}
	
	// block selection
	this._engineDiableOnSelectInWindow = function(win, state) {
		var data = new Array();
		data[0] = win.childNodes[0].childNodes[(this._isIE6?1:0)];
		data[1] = win.childNodes[0].childNodes[(this._isIE6?2:1)];
		data[2] = win.childNodes[0].childNodes[(this._isIE6?3:2)];
		data[3] = win.childNodes[0].childNodes[(this._isIE6?4:3)];
		// resizers
		data[4] = win.childNodes[0].childNodes[(this._isIE6?6:5)];
		data[5] = win.childNodes[0].childNodes[(this._isIE6?7:6)];
		data[6] = win.childNodes[0].childNodes[(this._isIE6?8:7)];
		data[7] = win.childNodes[0].childNodes[(this._isIE6?9:8)];
		for (var q=0; q<data.length; q++) {
			//console.log(data[q])
			data[q].onselectstart = (state?function(e){e=e||event;e.returnValue=false;return false;}:null);
			data[q] = null;
		}
		data = null;
	}
	
	// return window header
	this._engineGetWindowHeader = function(win) {
		win.childNodes[0].idd = win.idd;
		return win.childNodes[0];
	}
	
	// setting correct size for window
	this._engineRedrawWindowSize = function(win) {
		
		win.style.width = (String(win.w).search("%")==-1?win.w+"px":win.w);
		win.style.height = (String(win.h).search("%")==-1?win.h+"px":win.h);
		
		var body = win.childNodes[0];
		
		body.style.width = win.clientWidth+"px";
		body.style.height = win.clientHeight+"px";
		
		if (body.offsetWidth > win.clientWidth) { body.style.width = win.clientWidth*2-body.offsetWidth+"px"; }
		if (body.offsetHeight > win.clientHeight) {
			// park check
			var px = win.clientHeight*2-body.offsetHeight;
			if (px < 0) px = 0;
			//
			body.style.height = px+"px";
		}
		
		var hh = (win._noHeader==true?win._hdrSize:this._engineSkinParams[this.skin]["hh"]);
		
		if (this.iframeMode && win.ifr) {
			win.ifr.style.width = win.style.width;
			win.ifr.style.height = win.style.height;
		}
		
		// header
		this._engineRedrawWindowTitle(win);
		
		win.adjustContent(body, hh);
		// this.updateNestedObjects();
	}
	
	// redraw window position
	this._engineRedrawWindowPos = function(win) {
		
		if (win._isFullScreened) return;
		win.style.left = win.x + "px";
		win.style.top = win.y + "px";
		
		if (this.iframeMode && win.ifr) {
			win.ifr.style.top = win.style.top;
			win.ifr.style.left = win.style.left;
		}
		
	}
	
	// fixing window position in viewport
	this._engineFixWindowPosInViewport = function(win) {
		
		// var hh = this._engineSkinParams[this.skin]["hh"];
		var hh = (win._noHeader==true?win._hdrSize:this._engineSkinParams[this.skin]["hh"]);
		if (win._keepInViewport) { // keep strongly in viewport
			if (win.x < 0) { win.x = 0; }
			if (win.x + win.w > this.vp.offsetWidth) { win.x = this.vp.offsetWidth - win.w; }
			// if (win.y < 0) { win.y = 0; }
			if (win.y + win.h > this.vp.offsetHeight) { win.y = this.vp.offsetHeight - win.h; }
			if (win.y < 0) { win.y = 0; }
		} else {
			// if (win.y < 0) { win.y = 0; }
			if (win.y + hh > this.vp.offsetHeight) { win.y = this.vp.offsetHeight - hh; }
			if (win.y < 0) { win.y = 0; }
			if (win.x + win.w - 10 < 0) { win.x = 10 - win.w; }
			if (win.x > this.vp.offsetWidth - 10) { win.x = this.vp.offsetWidth - 10; }
		}
		
	}
	
	// check is header in onmousedown
	this._engineCheckHeaderMouseDown = function(win, ev) {
		if (this._isIPad) {
			var x = ev.touches[0].clientX;
			var y = ev.touches[0].clientY;
			var obj = ev.target||ev.srcElement;
			if (obj == win.childNodes[0] || obj == win.childNodes[0].childNodes[0] || obj == win.childNodes[0].childNodes[2] || obj == win.childNodes[0].childNodes[3]) return true;
			return false;
		} else {
			var x = (_isIE||_isOpera?ev.offsetX:ev.layerX);
			var y = (_isIE||_isOpera?ev.offsetY:ev.layerY);
			var obj = ev.target||ev.srcElement;
		}
		
		var hh = (win._noHeader==true?win._hdrSize:this._engineSkinParams[this.skin]["hh"]);
		if (y <= hh && (obj == win.childNodes[0] || obj == win.childNodes[0].childNodes[(this._isIE6?1:0)] || obj == win.childNodes[0].childNodes[(this._isIE6?3:2)] || obj == win.childNodes[0].childNodes[(this._isIE6?4:3)])) return true;
		return false;
	}
	
	// return window content
	this._engineGetWindowContent = function(win) {
		alert("_engineGetWindowContent");
		/*
		var contObj = null;
		var contPoly = win.childNodes[0].childNodes[(this._isIE6?5:4)];
		for (var q=0; q<contPoly.childNodes.length; q++) { if (contPoly.childNodes[q].getAttribute("iscont") != null) { if (contPoly.childNodes[q].getAttribute("iscont") === "1") { contObj = contPoly.childNodes[q]; } } }
		if (contObj != null) {
			win._contObj = contObj;
		} else {
			if (win._contObj != null) {
				contObj = win._contObj;
			}
		}
		return contObj; //.childNodes[0];
		*/
	}
	
	// return window button
	this._engineGetWindowButton = function(win, buttonName) {
		buttonName = String(buttonName).toLowerCase();
		var buttonObj = null;
		var buttonStyle = "dhtmlx_button_"+buttonName+"_";
		for (var q=0; q<win.childNodes[0].childNodes[(this._isIE6?4:3)].childNodes.length; q++) {
			var buttonTemp = win.childNodes[0].childNodes[(this._isIE6?4:3)].childNodes[q];
			if (String(buttonTemp.className).search(buttonStyle) != -1) { buttonObj = buttonTemp; }
			buttonTemp = null;
		}
		return buttonObj;
	}
	
	// adding user button
	this._engineAddUserButton = function(win, buttonName, buttonPos) {
		if (isNaN(buttonPos)) buttonPos = 0;
		var button = document.createElement("DIV");
		button.className = "dhtmlx_wins_btns_button dhtmlx_button_"+buttonName+"_default";
		var buttonPoly = win.childNodes[0].childNodes[(this._isIE6?4:3)];
		buttonPos = buttonPoly.childNodes.length - buttonPos;
		if (buttonPos < 0) buttonPos = 0;
		if (buttonPos >= buttonPoly.childNodes.length) {
			buttonPoly.appendChild(button);
		} else {
			buttonPoly.insertBefore(button, buttonPoly.childNodes[buttonPos]);
		}
		this._engineRedrawWindowTitle(win);
		return button;
	}
	
	// return min park height
	this._engineGetWindowParkedHeight = function(win) {
		return this._engineSkinParams[this.skin]["hh"]+1;
	}
	
	// do on window park down
	this._engineDoOnWindowParkDown = function(win) {
		// console.log(1)
		win.childNodes[0].childNodes[(this._isIE6?6:5)].style.display = (win._noHeader==true?"":"none");
		win.childNodes[0].childNodes[(this._isIE6?7:6)].style.display = "";
		win.childNodes[0].childNodes[(this._isIE6?8:7)].style.display = "";
		win.childNodes[0].childNodes[(this._isIE6?9:8)].style.display = "";
	}
	
	// do on window park up
	this._engineDoOnWindowParkUp = function(win) {
		win.childNodes[0].childNodes[(this._isIE6?6:5)].style.display = "none";
		win.childNodes[0].childNodes[(this._isIE6?7:6)].style.display = "none";
		win.childNodes[0].childNodes[(this._isIE6?8:7)].style.display = "none";
		win.childNodes[0].childNodes[(this._isIE6?9:8)].style.display = "none";
	}
	
	// update window's icon
	this._engineUpdateWindowIcon = function(win, icon) {
		win.childNodes[0].childNodes[(this._isIE6?1:0)].style.backgroundImage = "url('"+icon+"')";
		
	}
	
	// check is targetObj a windows node and is resize allowed
	this._engineAllowWindowResize = function(win, targetObj, mouseX, mouseY) {
		 // IE fix for disabled input
		if (!targetObj.getAttribute) return;
		//
		var sk = this._engineSkinParams[this.skin];
		var hh = (win._noHeader==true?win._hdrSize:this._engineSkinParams[this.skin]["hh"]);
		if (targetObj.getAttribute("winResL") != null) {
			if (targetObj.getAttribute("winResL") == "yes") {
				if (mouseY >= hh) {
					if (mouseY >= win.h - sk["lch"]) return "corner_left";
					if (mouseY <= sk["lch"] && win._noHeader == true) return "corner_up_left";
					return "border_left";
				}
			}
		}
		if (targetObj.getAttribute("winResR") != null) {
			if (targetObj.getAttribute("winResR") == "yes") {
				if (mouseY >= hh) {
					if (mouseY >= win.h - sk["rch"]) return "corner_right";
					if (mouseY <= sk["rch"] && win._noHeader == true) return "corner_up_right";
					 return "border_right";
				}
			}
		}
		if (targetObj.getAttribute("winResT") != null) {
			if (targetObj.getAttribute("winResT") == "yes" && win._noHeader == true) {
				if (mouseX <= sk["lcw"]) return "corner_up_left";
				if (mouseX >= win.w - sk["rcw"]) return "corner_up_right";
				return "border_top";
			}
		}
		if (targetObj.getAttribute("winResB") != null) {
			if (targetObj.getAttribute("winResB") == "yes") {
				if (mouseX <= sk["lcw"]) return "corner_left";
				if (mouseX >= win.w - sk["rcw"]) return "corner_right";
				return "border_bottom";
			}
		}
		return null;
	}
	
	// adjusting window to content size
	this._engineAdjustWindowToContent = function(win, w, h) {
		var newW = w+win.w-win.vs[win.av].dhxcont.clientWidth;
		var newH = h+win.h-win.vs[win.av].dhxcont.clientHeight;
		win.setDimension(newW, newH);
	}
	
	// redraw windows skin
	this._engineRedrawSkin = function() {
		this.vp.className = (this.vp==document.body&&this.vp._css?this.vp._css+" ":"")+"dhtmlx_winviewport dhtmlx_skin_"+this.skin+(this._r?" dhx_wins_rtl":"");
		var sk = this._engineSkinParams[this.skin];
		for (var a in this.wins) {
			if (this.skin == "dhx_skyblue") {
				this.wins[a].dhxContGlobal.obj._offsetTop = (this.wins[a]._noHeader?sk["noh_t"]:null);
				this.wins[a].dhxContGlobal.obj._offsetWidth = -10;
				this.wins[a].dhxContGlobal.obj._offsetHeight = (this.wins[a]._noHeader?sk["noh_h"]:-5);
				this.wins[a].dhxContGlobal.obj._offsetLeft = 5;
				this.wins[a].dhxContGlobal.obj._offsetHeightSaved = -5;
			} else {
				this.wins[a].dhxContGlobal.obj._offsetWidth = null;
				this.wins[a].dhxContGlobal.obj._offsetHeight = null;
				this.wins[a].dhxContGlobal.obj._offsetLeft = null;
				this.wins[a].dhxContGlobal.obj._offsetTop = null;
				this.wins[a].dhxContGlobal.obj._offsetHeightSaved = null;
			}
			this.wins[a].skin = this.skin;
			this._restoreWindowIcons(this.wins[a]);
			this._engineRedrawWindowSize(this.wins[a]);
		}
	}
	
	// enable/disable window loader
	this._engineSwitchWindowProgress = function(win, state) {
		if (state == true) {
			win.childNodes[0].childNodes[(this._isIE6?1:0)].style.display = "none";
			win.childNodes[0].childNodes[(this._isIE6?2:1)].style.display = "";
		} else {
			win.childNodes[0].childNodes[(this._isIE6?2:1)].style.display = "none";
			win.childNodes[0].childNodes[(this._isIE6?1:0)].style.display = "";
		}
	}
	
	// show/hide window header
	this._engineSwitchWindowHeader = function(win, state) {
		if (!win._noHeader) win._noHeader = false;
		if (state != win._noHeader) return;
		//
		win._noHeader = (state==true?false:true);
		win._hdrSize = 0;
		win.childNodes[0].childNodes[(this._isIE6?5:4)].className = "dhtmlx_wins_body_inner"+(win._noHeader?" dhtmlx_wins_no_header":"");
		win.childNodes[0].childNodes[(this._isIE6?6:5)].style.display = (win._noHeader?"":"none");
		win.childNodes[0].childNodes[(this._isIE6?1:0)].style.display = (win._noHeader?"none":"");
		// title
		win.childNodes[0].childNodes[(this._isIE6?3:2)].style.display = (win._noHeader?"none":"");
		// buttons
		win.childNodes[0].childNodes[(this._isIE6?4:3)].style.display = (win._noHeader?"none":"");
		//
		var sk = this._engineSkinParams[this.skin];
		if (win._noHeader) {
			win.dhxContGlobal.obj._offsetHeightSaved = win.dhxContGlobal.obj._offsetHeight;
			win.dhxContGlobal.obj._offsetHeight = sk["noh_h"];
			win.dhxContGlobal.obj._offsetTop = sk["noh_t"];
		} else {
			win.dhxContGlobal.obj._offsetHeight = win.dhxContGlobal.obj._offsetHeightSaved;
			win.dhxContGlobal.obj._offsetTop = null;
		}
		this._engineRedrawWindowSize(win);
	}
	
	// return true if header is visible
	this._engineGetWindowHeaderState = function(win) {
		return (win._noHeader?true:false);
	}
	
	// return window label
	this._engineGetWindowLabel = function(win) {
		return win.childNodes[0].childNodes[(this._isIE6?3:2)];
	}
	
	// redraw window's header text
	this._engineRedrawWindowTitle = function(win) {
		if (win._noHeader!==true) {
			var p2 = win.childNodes[0].childNodes[(this._isIE6?1:0)].offsetWidth; // icon
			var p3 = win.childNodes[0].childNodes[(this._isIE6?4:3)].offsetWidth; // buttons
			var newW = win.offsetWidth-p2-p3-24;
			if (newW < 0) newW = "100%"; else newW += "px";
			win.childNodes[0].childNodes[(this._isIE6?3:2)].style.width = newW;
			/*
				var p1 = win.childNodes[0].childNodes[(this._isIE6?3:2)].offsetLeft;
				var p2 = win.childNodes[0].childNodes[(this._isIE6?4:3)].offsetWidth;
				var newW = win.offsetWidth-p1-p2-16;
				if (newW < 0) { newW = "100%"; } else { newW += "px"; }
				win.childNodes[0].childNodes[(this._isIE6?3:2)].style.width = newW;
			*/
		}
	}
	
};

dhtmlXWindows.prototype.i18n = {
	dhxcontaler: "dhtmlxcontainer.js is missed on the page",
	noenginealert: "No dhtmlxWindows engine was found.",
	stick: "Stick",
	unstick: "Unstick",
	help: "Help",
	parkdown: "Park Down",
	parkup: "Park Up",
	maximize: "Maximize",
	restore: "Restore",
	close: "Close",
	dock: "Dock"
};

(function(){
	
	dhtmlx.extend_api("dhtmlXWindows",{
		_init:function(obj){
			return [];
		},
		_patch:function(obj){
			obj.old_createWindow=obj.createWindow;
			obj.createWindow=function(obj){
				if (arguments.length>1) return this.old_createWindow.apply(this,arguments);
				var res = this.old_createWindow(obj.id,(obj.x||obj.left),(obj.y||obj.top),obj.width,obj.height);
				
				res.allowMoveA=function(mode){
					if (mode) this.allowMove();
					else this.denyMove();
				}
				res.allowParkA=function(mode){
					if (mode) this.allowPark();
					else this.denyPark();
				}
				res.allowResizeA=function(mode){
					if (mode) this.allowResize();
					else this.denyResize();
				}
				
				//local settings
				for (var a in obj){
					if (map[a]) res[map[a]](obj[a]);
					else if (a.indexOf("on")==0){
						res.attachEvent(a,obj[a]);
					}
				}
				return res;
			}
		},
		animation:"setEffect",
		image_path:"setImagePath",
		skin:"setSkin",
		viewport:"_viewport",
		wins:"_wins"
	},{
		_viewport:function(data){
			if (data.object) {
				this.enableAutoViewport(false);
				this.attachViewportTo(data.object);
			} else {
				this.enableAutoViewport(false);
				this.setViewport(data.left, data.top, data.width, data.height, data.parent);
			}
		},
		_wins:function(arr){
			for (var q=0; q<arr.length; q++) {
				var win = arr[q];
				this.createWindow(win.id, win.left, win.top, win.width, win.height);
				if (win.text) this.window(win.id).setText(win.text);
				if (win.keep_in_viewport) this.window(win.id).keepInViewport(true);
				if (win.deny_resize) this.window(win.id).denyResize();
				if (win.deny_park) this.window(win.id).denyPark();
				if (win.deny_move) this.window(win.id).denyMove();
			}
		}
	});
	
	var map={
		move:"allowMoveA",
		park:"allowParkA",
		resize:"allowResizeA",
		center:"center",
		modal:"setModal",
		caption:"setText",
		header:"showHeader"
	};
})();