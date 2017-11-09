
(function($){
	//jQuery扩展方法
	$.extend($,{
		//获得屏幕可视高度
		offHeight : function(){
			if($.browser.msie){
				return document.documentElement.clientHeight;
			}else{
				return window.innerHeight;
			}
		},
		stopBubble : function(e){
			if ( e && e.stopPropagation ){
				 e.stopPropagation();
			} else {
	        	window.event.cancelBubble = true;
	        }
		}
	});
	//jQuery扩展方法
	$.extend($.fn,{
		tipExtra : function(setting){
			var opt = $.extend({
				html : '',
				width : 'auto',
				baseLine : 'right'
			},setting);
			var tip = $('<div/>').css({
				"position" : "absolute",
				"width" : opt.width,
				"z-index" : 10000,
				"display" : "none",
				"border" : "1px solid #bfbfbf",
				"background-color" : "#fff"
			}).append(opt.html).appendTo('body').show();
			var _x = $(this).offset().left;
			var _y = $(this).offset().top;
			_y = _y + $(this).outerHeight();
			if('left' != opt.baseLine.toLowerCase){
				var _tw = $(this).outerWidth();
				_x = _x + _tw - tip.width();
			}
			tip.css({"left" : _x + "px","top" : _y + "px"});
			var _wh = $('body').outerHeight();
			var bg = $('<div style="position:absolute;top:0;left:0;width:100%;height:'+_wh+'px;z-index:9999;background-color:transparent"></div>').appendTo('body').show().click(function(){
				tip.remove();
				bg.remove();
			});
			$(this).data({'bg':bg,'tip':tip});
			return $(this);
		},
		tipExtraCancel : function(){
			var tip = $(this).data('tip');
			var bg = $(this).data('bg');
			if(tip){tip.remove()}
			if(bg){bg.remove()}
		},
		//通用上传
		uploadFile : function(setting){
			
		},
		//img-loading
		loadingImg : function(){
			$(this).each(function(){
				var img = $(this);
				img.hide();
				var imageReady = new Image();
				imageReady.src = img.attr('src');
				$(imageReady).load(function(){
					img.show();
				}).each(function(){
					if (this.complete)$(this).trigger("load");
				});
			});
		},
		//指定模块的内容页面load刷新
		loads : function(url,data,callback){
			//Constant.ajaxLoading.show();
			$(this).load(url,data,function(){
				if(typeof callback == 'function'){
					callback();
				}
				//Constant.ajaxLoading.hide();
				STKCommon.initMainDiv();
			});
		},
		//自动浮动功能
		autoFloatFixed : function(setting){
			var opt = $.extend({
				speed : 'slow',
				top : false,
				bottom :false,
				beforeSlideDo : null,
				afterSlideDo : null
			},setting);
			var $this = $(this);
			var _isNumberType = true;
			var _isTop = false;
			$this.css({'position':'absolute'});
			if((typeof opt.top == 'number' || typeof opt.top == 'string') && /^[0-9]+%?$/.test(opt.top)){
				_isTop = true;
				if(/^[0-9]+%$/.test(opt.top)){
					_isNumberType = false;
					opt.top = parseFloat(opt.top.replace('%',''));
					$this.css({'bottom':'auto','top':opt.top+'%'});
				}else{
					$this.css({'bottom':'auto','top':opt.top+'px'});
				}
			}else if((typeof opt.bottom == 'number' || typeof opt.bottom == 'string') && /^[0-9]+%?$/.test(opt.bottom)){
				if(/^[0-9]+%$/.test(opt.bottom)){
					_isNumberType = false;
					opt.bottom = parseFloat(opt.bottom.replace('%',''));
					$this.css({'bottom':opt.bottom+'%','top':'auto'});
				}else{
					$this.css({'bottom':opt.bottom+'px','top':'auto'});
				}
			}else{
				return;
			}
			if(opt.speed === 0 && !($.browser.msie && $.browser.version == '6.0')){
				$this.css({'position':'fixed'});
				return;
			}
			var _offHeight = 0;
			var _scrollTop = 0;
			var _value;
			var _toCss;
			$(window).scroll(function(){
				$this.stop(true);
				reDo();
			});
			function reDo(){
				initOffParam();
				if(opt.beforeSlideDo){
					opt.beforeSlideDo();
				}
				if(opt.speed === 0){
					$this.css(_toCss);
				}else{
					$this.animate(_toCss,opt.speed,function(){
						if(opt.afterSlideDo){
							opt.afterSlideDo(_scrollTop);
						}
					});
				}
			};
			function initOffParam(){
				if ($.browser.msie) {
					_offHeight = document.documentElement.clientHeight;
					if ($.browser.version == "6.0") {
						$('body').find('select')
								.css('visibility', 'hidden');
					}
				} else {
					_offHeight = window.innerHeight;
				}
				if (typeof window.pageYOffset != 'undefined') {
					_scrollTop = window.pageYOffset;
				} else if (typeof document.compatMode != 'undefined'
						&& document.compatMode != 'BackCompat') {
					_scrollTop = document.documentElement.scrollTop;
				} else if (typeof document.body != 'undefined') {
					_scrollTop = document.body.scrollTop;
				}
				if(_isTop){
					if(_isNumberType){
						_value = (_scrollTop + opt.top) + 'px';
					}else{
						_value = (_scrollTop + opt.top*_offHeight/100) + 'px';
					}
					_toCss = {top:_value};
				}else{
					if(_isNumberType){
						_value = (_scrollTop + opt.bottom)  + 'px';
					}else{
						_value = (((_scrollTop + _offHeight) - (1-opt.bottom)*_offHeight/100)) + 'px';
					}
					_toCss = {bottom:_value};
				}
			}
		}
	});


	if(typeof STK == 'undefined') STK = new Object();
	var STKCommon = new Object();
	var Constant = new Object();
	var CachePageData = new Object();
	Constant.menuUlMark = {};//左菜�?
	Constant.navigateMap = {}; //TAB
	$.extend(STKCommon,{
		removeTabsContextMenu : function(){
			if(Constant.contextMenu){
				Constant.contextMenu.remove();
				delete Constant.contextMenu;
				
			}
		},
		//初始�?
		init : function(){
			//页面布局初始化处�?
			$(document).ready(function(){
				/*Constant.resizeSetting = {
					minWidth : 110,
					maxWidth : 390
				}
				Constant.resizeVerHorDom = $('<b class="resize-hor"></b>').appendTo('body');
				Constant.resizeVerBarDom = $('<b class="resize-ver"></b>').appendTo('body');
				var _x;
				var _movestop = false;
				var bodyHeight = $('body').outerHeight(true);
				var bodyWidth = $('body').outerWidth(true);
				var _secCover;
				Constant.resizeVerBarDom.mousedown(function(event){
					_movestop = true;
					bodyHeight = $('body').outerHeight(true);
					bodyWidth = $('body').outerWidth(true);
					Constant.resizeVerHorDom.show();
					Constant.resizeVerBarDom.addClass('resize-ver-active');
					var offset = Constant.resizeVerBarDom.offset();
					_x = event.pageX - offset.left;
					if(!_secCover)_secCover = $('<div style="width:100%;height:100%;display:block; position:absolute;top:0;left:0;zoom:1;z-index:999;background-color:transparent"></div>');
					_secCover.appendTo($('#J_common_panel_section'));
					
				});
				$(document).mousemove(function(event){
					if(_movestop){
						Constant.resizeVerBarDom.css({
							left : (event.pageX - _x) <= Constant.resizeSetting.minWidth ? Constant.resizeSetting.minWidth : ((event.pageX - _x)>Constant.resizeSetting.maxWidth?Constant.resizeSetting.maxWidth:(event.pageX - _x) )
							//top : (event.pageY - _y) <= 0 ? 0 : (event.pageY - _y)
						});
					}
				}).mouseup(function(event) {
					if(_movestop){
						Constant.resizeVerHorDom.hide();
						Constant.resizeVerBarDom.removeClass('resize-ver-active');
						var offset = Constant.resizeVerBarDom.offset();
						_x = offset.left;
						$('#J_common_section').css({"padding-left":_x+"px"});
						$('#J_common_aside').css({"width":_x+"px","margin-left":(-1*_x)+"px"});
						$('#J_left_nav_ext_btn').css({"left":_x+'px'}).data('left',_x);
						Constant.navigateDisWidth = $('#J_common_article').innerWidth() - 60 > 0 ? $('#J_common_article').innerWidth() - 60 : 0;
						//Constant.resizeVerBarDom.css({"height":_h1+"px","left" : "163px"});
						STKCommon.navOrderReset();
						
					}
					if(_secCover){
						_secCover.remove();
					}
					_movestop = false;
				});*/
				
				$('#J_left_nav_ext_btn').click(function(){
					var _t = $(this);
					if(_t.hasClass('left-nav-ext-btn-1')){
						$('#J_common_aside').show();
						var _w = $('#J_common_aside').width();
						_t.css({'left':_w+'px'});
						$('#J_common_section').css({'padding-left':_w+'px'});
						_t.removeClass('left-nav-ext-btn-1');
					}else{
						$('#J_common_aside').hide();
						_t.css({'left':0});
						$('#J_common_section').css({'padding-left':0});
						_t.addClass('left-nav-ext-btn-1');
					}
				});
				STKCommon.initMainDiv();
			});
			
			STK.resize(STKCommon.initMainDiv);
		},
		leftMenuSwitch : function(menuIdA){
			if(Constant.menuUlMark.expAId == menuIdA){
				return;
			}
			var _menuObj = getMenuObjByMenuIdA(menuIdA);
            if(_menuObj){
			    $('#J_main_title').html(_menuObj.name);
            }
			if(Constant.menuUlMark[menuIdA]){
				//if(Constant.menuUlMark.expBId)Constant.menuUlMark["exp_"+Constant.menuUlMark.expBId].hide();
				if(Constant.menuUlMark.expAId){
					Constant.menuUlMark[Constant.menuUlMark.expAId].hide();
				}
				Constant.menuUlMark[Constant.menuUlMark.expAId].children('.nav-expand').hide();
				Constant.menuUlMark[Constant.menuUlMark.expAId].find('.nav-icon-opt').addClass('close');
				Constant.menuUlMark.expAId = menuIdA;
				Constant.menuUlMark[menuIdA].show();
                STK.showFirstMenu();
				return;
			}else{
				if(_menuObj){
					if(Constant.menuUlMark.expBId)Constant.menuUlMark["exp_"+Constant.menuUlMark.expBId].hide();
					if(Constant.menuUlMark.expAId){
						Constant.menuUlMark[Constant.menuUlMark.expAId].hide();
					}
					Constant.menuUlMark.expAId = menuIdA;
					menuObjHtmlInit(_menuObj);
				}
			}
			function getMenuObjByMenuIdA(menuIdA){
				for ( var i = 0; i < Constant.menuObj.length; i++) {
					if(menuIdA == Constant.menuObj[i].id){
						return Constant.menuObj[i];
					}
				}
			};
			function menuObjHtmlInit(menuObj){
				var _menuUl = $('<ul/>');
				if(menuObj.children){
					for ( var i = 0; i < menuObj.children.length; i++) {
						var _m = menuObj.children[i];
                        var _ml;
                        if(_m.children && _m.children.length > 0)
					         _ml = $('<li/>').addClass('nav-li').append('<b class="nav-icon-opt close"></b><span>'+_m.name+'</span>').appendTo(_menuUl);
                        else
                            _ml = $('<li/>').addClass('nav-li').append('<b></b><span>'+_m.name+'</span>').appendTo(_menuUl).css("textDecoration","underline");

						_ml.data('id',_m.id);
						_ml.click(function(){
                            if(_m.url ) STK.go(_m.url,_m.name,{refresh:true});
                            if(!_m.children || _m.children.length==0) return;
							var _id = parseInt($(this).data('id'));
							//if(Constant.menuUlMark["exp_"+Constant.menuUlMark.expBId])Constant.menuUlMark["exp_"+Constant.menuUlMark.expBId].hide();
							//if(Constant.menuUlMark.curBMark)Constant.menuUlMark.curBMark.children('b').addClass('close');
							
							if(Constant.menuUlMark["exp_"+_id]){
								Constant.menuUlMark["exp_"+_id].toggle();
							}
							$(this).children('b').toggleClass('close');
							Constant.menuUlMark[Constant.menuUlMark.expAId].children('.nav-expand').not(Constant.menuUlMark["exp_"+_id]).hide();
							Constant.menuUlMark[Constant.menuUlMark.expAId].find('.nav-icon-opt').not($(this).children('b')).addClass('close');
							Constant.menuUlMark.expBId = _id;
							Constant.menuUlMark.curBMark = $(this);
							return true;
						});
						var _mcUl = $('<ul/>').addClass('nav-expand-ul');
						Constant.menuUlMark['exp_'+_m.id] = $('<li/>').addClass('nav-expand').append(_mcUl).appendTo(_menuUl);
                        if(_m.children){
							for ( var j = 0; j < _m.children.length; j++) {
								var _mc = _m.children[j];
								var _a = $('<a href="javascript:void(0);" title="'+_mc.name+'"><b class="common-bg-icon l-arr"></b>'+_mc.name+'</a>');
								(function(url,name){
									_a.click(function(){
										STK.go(url,name,{refresh:true});
										if($(this) == Constant.menuUlMark.curExpCNav) return false;
										if(Constant.menuUlMark.curExpCNav){
											Constant.menuUlMark.curExpCNav.removeClass('selected');
										}
										$(this).addClass('selected');
										Constant.menuUlMark.curExpCNav = $(this);
										return false;
									});
								})(_mc.url,_mc.name);
								$('<li/>').append(_a).appendTo(_mcUl);
							}
						}
					}
				}
				_menuUl.appendTo($('#J_common_sec_aside_nav'));
				Constant.menuUlMark[menuIdA] = _menuUl;
                STK.showFirstMenu();
			}
		},
		navOrderReset : function(){
			if($('#J_commonNavTabBar li').length <= 0){
				return;
			}
			var _maxW = Constant.navigateDisWidth <100 ? 100 : Constant.navigateDisWidth;
//			_maxW = _maxW - 50;
			var _w = _maxW/$('#J_commonNavTabBar li').length-1;
			_w = _w > 150 ? 150 : _w;
			$('#J_commonNavTabBar li').width(_w);
		},
		//菜单排序重构
		navOrderReset1 : function(){
			if($('#J_commonNavTabBar li').length <= 0){
				return;
			}
			var navArr = $('#J_commonNavTabBar li');
			var curIndex = getNavIndex();
			var startIndex=endIndex = curIndex;
			var navWMark = 0;
			var navLockWidth = 0;
			for ( var i = 0; i < navArr.length; i++) {
				if(!$(navArr[i]).data('enableClose')){
					navLockWidth += $(navArr[i]).outerWidth();
				}
			}
			navLockWidth = Constant.navigateDisWidth - navLockWidth;
			if(navLockWidth <=0){
				alert('没有足够的空间展示新的tab，请关掉一些锁定窗口！');
				return;
			}
			for ( var i = curIndex; i < navArr.length; i++) {
				if(!$(navArr[i]).data('enableClose')){
					continue;
				}
				navWMark += $(navArr[i]).outerWidth();
				if(navWMark < navLockWidth){
					endIndex = i;
				}else{
					break;
				}
			}
			//alert(startIndex+'|'+endIndex);
			if(endIndex < navArr.length && navWMark < navLockWidth){
				for ( var i = curIndex-1; i >=0 ; i--) {
					if(!$(navArr[i]).data('enableClose')){
						continue;
					}
					navWMark += $(navArr[i]).outerWidth();
					if(navWMark < navLockWidth){
						startIndex = i;
					}else{
						break;
					}
				}
			}
			//alert(Constant.navigateDisWidth +'|'+ navLockWidth +'|'+navWMark +'|'+startIndex+'|'+endIndex + '|' +curIndex);
			for ( var i = 0; i < navArr.length; i++) {
				if(!$(navArr[i]).data('enableClose')){
					continue;
				}
				if(i>=startIndex && i<=endIndex){
					$(navArr[i]).show();
				}else{
					$(navArr[i]).hide();
				}
			}
			function getNavIndex(){
				for ( var i = 0; i < $('#J_commonNavTabBar li').length; i++) {
					if($($('#J_commonNavTabBar li')[i]).data('key') == Constant.navigateMap.currentNavKey){
						return i;
					}
				}
				return 0;
			}
		},
		//菜单排序重构
		navOrderReset2 : function(){
			if($('#J_commonNavTabBar li').length <= 0){
				return;
			}
			var navArr = $('#J_commonNavTabBar li');
			var curIndex = getNavIndex();
			var startIndex = -1;
			var endIndex = curIndex;
			var navWMark = 0;
			var navLockWidth = 0;
			var navNowWidth = 0;
			for ( var i = 0; i < navArr.length; i++) {
				if(!$(navArr[i]).data('enableClose')){
					navLockWidth += $(navArr[i]).outerWidth();
//					if(i == curIndex){
//						return;
//					}
					continue;
				}
				if($(navArr[i]).is(':visible') && startIndex<0){
					startIndex = i;
					break;
				}
			}
			if(startIndex<0){
				return;
			}
//			alert(Constant.navigateDisWidth);
			navLockWidth = Constant.navigateDisWidth - navLockWidth;
			if(navLockWidth <=0){
				alert('没有足够的空间展示新的tab，请关掉一些锁定窗口！');
				return;
			}
			if(startIndex < curIndex){
//				if(curIndex==navArr.length-1){
//					startIndex = 0;
//					endIndex = curIndex;
//					for ( var i = curIndex; i >=0 ; i--) {
//						if(!$(navArr[i]).data('enableClose')){
//							continue;
//						}
//						navWMark += $(navArr[i]).outerWidth();
//						if(navWMark < navLockWidth){
//							startIndex = i;
//						}else{
//							break;
//						}
//					}
//				}else{
					for(var i=startIndex;i<navArr.length;i++){
						if(!$(navArr[i]).data('enableClose')){
							continue;
						}
						navNowWidth+=$(navArr[i]).width();
						if(navNowWidth > navLockWidth){
							break;
						}
						endIndex = i;
//						if(i>=curIndex && i==navArr.length-1){
//							startIndex = 0;
//							break;//返回！！�?
//						}
					}
					if(navNowWidth > navLockWidth && endIndex <= curIndex){
						startIndex = 0;
						endIndex = curIndex;
						for ( var i = curIndex; i >=0 ; i--) {
							if(!$(navArr[i]).data('enableClose')){
								continue;
							}
							navWMark += $(navArr[i]).outerWidth();
							if(navWMark < navLockWidth){
								startIndex = i;
							}else{
								break;
							}
						}
					} else if(navNowWidth <= navLockWidth && endIndex == navArr.length-1){
						startIndex = 0;
						for ( var i = endIndex; i >=0 ; i--) {
							if(!$(navArr[i]).data('enableClose')){
								continue;
							}
							navWMark += $(navArr[i]).outerWidth();
							if(navWMark < navLockWidth){
								startIndex = i;
							}else{
								break;
							}
						}
					}
//				}
				
//				startIndex = 0;
//				for ( var i = curIndex; i >=0 ; i--) {
//					if(!$(navArr[i]).data('enableClose')){
//						continue;
//					}
//					navWMark += $(navArr[i]).outerWidth();
//					if(navWMark < navLockWidth){
//						startIndex = i;
//					}else{
//						break;
//					}
//				}
//				//alert(startIndex+'|'+endIndex);
//				if(startIndex >=0 && navWMark < navLockWidth){
//					for ( var i = curIndex+1; i < navArr.length; i++) {
//						if(!$(navArr[i]).data('enableClose')){
//							continue;
//						}
//						navWMark += $(navArr[i]).outerWidth();
//						if(navWMark < navLockWidth){
//							endIndex = i;
//						}else{
//							break;
//						}
//					}
//				}
			}else{
				startIndex = curIndex;
				for ( var i = curIndex; i < navArr.length; i++) {
					if(!$(navArr[i]).data('enableClose')){
						continue;
					}
					navWMark += $(navArr[i]).outerWidth();
					if(navWMark < navLockWidth){
						endIndex = i;
					}else{
						break;
					}
				}
				//alert(startIndex+'|'+endIndex);
				if(endIndex < navArr.length && navWMark < navLockWidth){
					for ( var i = curIndex-1; i >=0 ; i--) {
						if(!$(navArr[i]).data('enableClose')){
							continue;
						}
						navWMark += $(navArr[i]).outerWidth();
						if(navWMark < navLockWidth){
							startIndex = i;
						}else{
							break;
						}
					}
				}
			}
			
			//alert(Constant.navigateDisWidth +'|'+ navLockWidth +'|'+navWMark +'|'+startIndex+'|'+endIndex + '|' +curIndex);
			Constant.navHideExtra  = undefined;
			for ( var i = 0; i < navArr.length; i++) {
				if(!$(navArr[i]).data('enableClose')){
					continue;
				}
				
				if(i>=startIndex && i<=endIndex){
					$(navArr[i]).show();
				}else{
					if(typeof Constant.navHideExtra == 'undefined'){
						Constant.navHideExtra = $('<div/>');
					}
					$(navArr[i]).hide();
					var _setting = $(navArr[i]).data('setting');
					$('<a class="tip-extra-dd" href="javascript:void(0);" onclick="STK.go(\''+_setting.url+'\',\''+_setting.summaryTitle+'\',{})">'+_setting.summaryTitle+'</a>').click(function(){
						//$('#J_navExtraHide').tipExtraCancel();
					}).appendTo(Constant.navHideExtra);
				}
			}
			function getNavIndex(){
				for ( var i = 0; i < $('#J_commonNavTabBar li').length; i++) {
					if($($('#J_commonNavTabBar li')[i]).data('key') == Constant.navigateMap.currentNavKey){
						return i;
					}
				}
				return 0;
			}
		},
		navigateOpenLimit : function(key){
			if(typeof Constant.navigateMap[key] == 'undefined' && $('#J_commonNavTabBar').find('li').length >= Constant.navigateMap.navArrMax){
				alert('请最多打开'+Constant.navigateMap.navArrMax+'个子页面');
				return true;
			}
			return false;
		},
		navigateDo : function(url,setting){
			var opt = $.extend({
				enableClose : true,
				firstFlag : false
			},setting);
			var key = '';
			if($.isPlainObject(url)){
				for(var u in url){
					key += encodeURI(opt.keyWithoutParams ? u.split('?')[0] : u);
				}
				key += encodeURI(opt.summaryTitle);
			}else{
				key = encodeURI((opt.keyWithoutParams ? url.split('?')[0] : opt.url) + opt.summaryTitle);
			}
//			if($('#J_commonNavTabBar').find('li').length > Constant.navigateMap.navArrMax){
//				alert('请最多打�?+Constant.navigateMap.navArrMax+'个子页面');
//				return false;
//			}
			if(Constant.navigateMap[Constant.navigateMap['currentNavKey']]){
				Constant.navigateMap[Constant.navigateMap['currentNavKey']].removeClass('selected');
//				CachePageData[Constant.navigateMap['currentNavKey']] = $('#J_common_panel_section').children().clone(true);
			}
			Constant.navigateMap['currentNavKey'] = key;
			if(Constant.navigateMap[key]){
				Constant.navigateMap[key].addClass('selected');
				Constant.navigateMap[key].data({
					url : url,
					setting : opt
				});
			}else{
				var _span = $('<span/>').attr('title',opt.summaryTitle).addClass('nav-l-bg').append(opt.summaryTitle);
				if(opt.enableClose){
					_span.append($('<i class="common-bg-icon nav-close"></i>').mousedown(function(e){STK.closeNav(key);return false;}));
				}else{
					_span.append('<i class="common-bg-icon nav-lock"></i>');
				}
				Constant.navigateMap[key] = $('<li/>').addClass('selected').append(_span).appendTo($('#J_commonNavTabBar'));
//				setting.refresh = false;
//				var _setting = $.extend(setting,{
//					refresh : opt.switchTabRefresh
//				});
				Constant.navigateMap[key].bind("contextmenu",function(e){
						STKCommon.removeTabsContextMenu();
						var _t = $(this);
						var _urlC = _t.data('url');
						var _settingC = _t.data('setting');
						var _rightClickHtml = $('<div/>').addClass('stk-disk-extra-box');
						var _bg = $('<div/>').addClass('deb-bd').appendTo(_rightClickHtml);
						$('<a href="javascript:void(0);" class="link"><span class="mag">刷新</span></a>').mousedown(function(e){
							e.preventDefault();
							e.stopPropagation();
						}).click(_rightClickHtml,function(e){
                            var dataUrl = _t.data('url');
                            if($.isPlainObject(dataUrl)){
                                var _setting = _t.data('setting');
                                $.extend(_setting,{
                                    refresh : true
                                });
                                STK.go(dataUrl,_setting);
                            } else {
                                CachePageData[key][0].contentWindow.location.reload();
                            }
							e.preventDefault();
							e.data.remove();
						}).appendTo(_bg);
						if(_settingC.enableClose){
							$('<a href="javascript:void(0);" class="link"><span class="mag">关闭</span></a>').mousedown(function(e){
								e.preventDefault();
								e.stopPropagation();
							}).click(_rightClickHtml,function(e){
								var key = _t.data('key');
								STK.closeNav(key);
								e.data.remove();
								e.preventDefault();
							}).appendTo(_bg);
						}
						$('<a href="javascript:void(0);" class="link"><span class="mag">关闭其他</span></a>').mousedown(function(e){
							e.preventDefault();
							e.stopPropagation();
						}).click(_rightClickHtml,function(e){
							var key = _t.data('key');
							STK.closeNav(key,'OTHER');
							e.data.remove();
							e.preventDefault();
						}).appendTo(_bg);
						$('<a href="javascript:void(0);" class="link"><span class="mag">关闭左侧</span></a>').mousedown(function(e){
							e.preventDefault();
							e.stopPropagation();
						}).click(_rightClickHtml,function(e){
							var key = _t.data('key');
							STK.closeNav(key,'LEFT');
							e.data.remove();
							e.preventDefault();
						}).appendTo(_bg);
						$('<a href="javascript:void(0);" class="link"><span class="mag">关闭右侧</span></a>').mousedown(function(e){
							e.preventDefault();
							e.stopPropagation();
						}).click(_rightClickHtml,function(e){
							var key = _t.data('key');
							STK.closeNav(key,'RIGHT');
							e.data.remove();
							e.preventDefault();
						}).appendTo(_bg);
						var _x = e.pageX;
						var _y = e.pageY;
						var rchm = $('<div/>').css({
                            "top" : (_y+5)+"px",
                            "left" : (document.documentElement.clientWidth >_x + 95 ? _x + 5 : _x - 90) + "px",
							"position" : "absolute",
							"width" : "90px"
						}).append(_rightClickHtml).appendTo('body');
						Constant.contextMenu = rchm;
			          return false;
			    }).mousedown(function(e){
			    	STKCommon.removeTabsContextMenu();
					var _t = $(this);
					var _urlC = _t.data('url');
					var _settingC = _t.data('setting');
					if(!_t.hasClass('selected')){
						_settingC.refresh = _settingC.switchTabRefresh;
						STK.go(_urlC,_settingC);
					}
				});
//				Constant.navigateMap[key].click(function(){
//					var _urlC = $(this).data('url');
//					var _settingC = $(this).data('setting');
//					_settingC.refresh = _settingC.switchTabRefresh;
//					STK.go(_urlC,_settingC);
//				});
				$('<b/>').addClass('nav-r-bg').appendTo(Constant.navigateMap[key]);
				Constant.navigateMap[key].data({
					width : Constant.navigateMap[key].outerWidth(),
					enableClose : opt.enableClose,
					firstFlag : opt.firstFlag,
					url : url,
					setting : setting,
					key : key
				});
			}
			STKCommon.navOrderReset();
		},
		loadsWithTimestamp : function(key,setting){
			if(Constant.navigateMap['currentNavKey'] && CachePageData[Constant.navigateMap['currentNavKey']]){
				CachePageData[Constant.navigateMap['currentNavKey']].css({
					position:'absolute',
					top:-10000,
					left:-10000
				});
			}

            function buildTabs(){
                var tabPanel = CachePageData[_key] = $('<div class="tab3 clearfix" style="height:100%"><ul/><div/></div>').appendTo('#J_common_panel_section');
                var tabs = tabPanel.children('ul');
                var tabCon = tabPanel.children('div');
                for(var k in key){
                    var o = $.extend({url:k},key[k]);
                    var ke = encodeURI((o.keyWithoutParams ? k.split('?')[0] : k) + o.summaryTitle);
                    var first = tabs.children().length === 0;
                    Constant.navigateMap[ke] = $('<li><a href="#"'+ (!first ? '':' class="first-child"') + '><span>'+o.summaryTitle+'</span><b></b></a></li>').appendTo(tabs);
                    Constant.navigateMap[ke].data({
                        width : Constant.navigateMap[ke].outerWidth(),
                        enableClose : o.enableClose,
                        firstFlag : o.firstFlag,
                        url : k,
                        setting : o,
                        key : ke
                    });
                    var iff = buildIfr(ke,o).appendTo(tabCon);
                    if(!first){
                        iff.hide();
                    }else{
						iff.attr("src",o.url)
					}
                }
                tabPanel.delegate('ul>li','click',function(){
                    var ifr = tabCon.children('iframe');
                    tabs.find('li>a.first-child').removeClass('first-child');
                    ifr.hide();
                    var li = $(this);
                    li.children('a').addClass('first-child');
                    ifr = ifr.eq(li.index());
                    ifr.show();
                    if(ifr.attr('src') === 'about:blank')
						ifr.attr("src",ifr.data('setting').url)
                });
                
                function h(){
                    tabCon.css({
                        height:tabPanel.height()-tabs.height()
                    });
                }
                $(window).resize(h);
                h();
            }
			
			var opt = $.extend({
			},setting);
			var _key = '';
			if($.isPlainObject(key)){
				for(var u in key){
					_key += encodeURI(opt.keyWithoutParams ? u.split('?')[0] : u);
				}
				_key += encodeURI(opt.summaryTitle);
			}else{
				_key = key;
			}
			if(CachePageData[_key]){
				CachePageData[_key].css({
					position:'',
					top:'',
					left:''
				});
				if(Constant.navigateMap[_key].data('url') != opt.url || opt.refresh){
                    if($.isPlainObject(key)){
                        CachePageData[_key].remove();
                        buildTabs();
                    }else{
                        CachePageData[_key].get(0).src=opt.url;
                    }
				}
			}else{
				function buildIfr(k,o){
					var __url = o.url;
					if($.isPlainObject(key)){
						__url = 'about:blank';
					}
                    CachePageData[k] = $('<iframe src="'+__url+'" frameborder="0" scrolling="yes"/>').data({setting:o}).css(
                    {
                        "width" : "100%",
                        "height": "100%",
                        //修复不出现滚动条的问题
                        //						"overflow-x" : "hidden",
                        //						"overflow-y" : "auto",
                        "border": "0 none"
                    } );
                    return CachePageData[k];
				}
				if($.isPlainObject(key)){
                    buildTabs();
				}else{
					buildIfr(_key,setting || {}).appendTo($('#J_common_panel_section'));
				}
			}
			return CachePageData[key];
			
//			Constant.stkUrlVersion = opt.thisTime;
//			Constant.ajaxLoading.show();
//			$.ajax({
//				url : opt.url,
//				type : opt.type,
//				data : opt.data,
//				cache : false,
//				complete : function(XMLHttpRequest,textStatus){
//					Constant.ajaxLoading.hide();
//					Constant.curRequestUrl = null;
//					if(textStatus != 'success'){
//						alert('加载失败，请重新尝试�?);
//						return;
//					}
//					if(Constant.stkUrlVersion != opt.thisTime){
//						XMLHttpRequest.abort();
//						return;
//					}
//					$('#J_common_panel_section').append('<div/>').html(XMLHttpRequest.responseText);
//					CachePageData[key] = XMLHttpRequest.responseText;
//					if(typeof opt.callback == 'function')opt.callback();
//				}
//			});
			
			
		},
		//处理布局div高度
		initMainDiv : function(){
			var _headerH = $('#J_common_header').outerHeight();
			var _oh = $.offHeight();
			if(Constant.loadMark){
				Constant.loadMark.height(_oh);
			}else{
				Constant.loadMark = $('<div style="width:100%;position:absolute;top:0;left:0;z-index:99999;"></div>')
				.append('<div style="width:100%;height:100%; background-color:#fff;opacity:0.5;filter:Alpha(Opacity=50);"></div>')
				.append('<div class="loading-st1" style="position:absolute; width:32px; height:32px; left:50%;top:50%;margin-left:-16px; margin-top:-16px;z-index:1000000"></div>')
				.height(_oh).hide().appendTo('body');
			}
			var _h = _oh > _headerH ? (_oh - _headerH): 0;
			$('#J_common_section').css("height",_h);
			var _h1 = (_h - 27)>0 ? (_h - 27) : 0;
			$('#J_common_panel_section').css("height",_h1);
			_h1 = (_h - 25)>0 ? (_h - 25) : 0;
			$('#J_common_sec_aside_nav').css("height",_h1);
			//Constant.navigateDisWidth = $('#J_common_section').innerWidth() - 220 > 0 ? $('#J_common_section').innerWidth() - 220 : 0;
			Constant.navigateDisWidth = (($('#J_common_article').innerWidth() - 60) > 0) ? ($('#J_common_article').innerWidth() - 60) : 0;
//			Constant.resizeVerBarDom.css({"height":_h1+"px"});
			STKCommon.navOrderReset();
//			alert(Constant.navigateDisWidth);
		},
		//json数据拼接字符�?
		JsonToQueryString : function(data){
			var ret = [];
			for(var d in data){
				ret.push(d + '=' + data[d]);
			}
			return ret.join('&');
		}
	});
	$.extend(STK,{
		removeTabsContextMenu : function(){
			STKCommon.removeTabsContextMenu();
		},
		showMask : function(){
			Constant.loadMark.show();
		},
		closeMask : function(){
			Constant.loadMark.hide();
		},
		//通知弹出�?
		popNoticeBox : function(setting){
			var opt = $.extend({
				html : '内容内容内容',
				timeout : 5000
			},setting);
			if(typeof Constant.popNotice == 'undefined'){
				Constant.popNotice = {};
				Constant.popNotice.box = $('<div/>').addClass('com-pop-notice-box').hide().appendTo('body');
				Constant.popNotice.close = $('<b class="close"></b>');
				Constant.popNotice.con = $('<div class="J_pop_con p-con"></div>');
				$('<div class="p-title"></div>').append('<span>通知</span>').append(Constant.popNotice.close).appendTo(Constant.popNotice.box);
				Constant.popNotice.con.appendTo(Constant.popNotice.box);
				Constant.popNotice.close.click(function(){
					if(typeof Constant.popNotice.wt!='undefined'){
						window.clearTimeout(Constant.popNotice.wt);
					}
					Constant.popNotice.box.fadeOut(1000,function(){
						Constant.popNotice.con.html('');
					});
				});
				Constant.popNotice.box.hover(function(){
					window.clearTimeout(Constant.popNotice.wt);
				},function(){
					window.clearTimeout(Constant.popNotice.wt);
					Constant.popNotice.wt = window.setTimeout(function(){
						Constant.popNotice.box.fadeOut(1000,function(){
							Constant.popNotice.con.html('');
						});
					},opt.timeout);
				});
			}
			Constant.popNotice.con.html(opt.html);
			Constant.popNotice.box.fadeIn(1000);
			window.clearTimeout(Constant.popNotice.wt);
			Constant.popNotice.wt = window.setTimeout(function(){
				Constant.popNotice.box.fadeOut(1000,function(){
					Constant.popNotice.con.html('');
				});
			},opt.timeout);
			
		},
		//框架初始
		init : function(setting){
			var opt = $.extend({
				menuObj : [],
				defaultMenuId : 1,
				maxNavNum : 100
			},setting);
			if(typeof opt.menuObj != 'undefined'){
				if(typeof opt.menuObj == 'string'){
					Constant.menuObj = $.parseJSON(opt.menuObj);
				}else{
					Constant.menuObj = opt.menuObj;
				}
				
				/////////////////////////////////////////////////////////////////
				/////////全局搜索部分开始
				////////////////////////////////////////////////////////////////
				var gSearch = $('span.search-input.position');
				var searchInput = gSearch.children('input');
				var searchTirgger = gSearch.children('b.com-sec-aside-more-opt');
				searchInput.attr('disabled', true);
				var hideSearchInput = function(){
					var w = 12;
					if(searchInput.width() === 12){
						w = 140;
					}
					searchInput.attr('disabled', true);
					searchInput.stop().animate({
						width:w
					}, 250, function(){
						if(w === 140){
							searchInput.attr('disabled', false);
							searchInput.focus();
						}else{
							searchInput.blur();
						}
					});
				};
				searchInput.blur(hideSearchInput);
				searchTirgger.click(hideSearchInput);

				if(typeof opt.searchDataClass === 'string'){
                   searchInput.stk_autocomplete(
                    {
                        clazz       : opt.searchDataClass,
                        callback:function(data){
                            searchInput.blur();
                            setTimeout( function ()
                            {
                                STK.go( data.orgData.url, data.orgData.name, {refresh: true} );
                            }, 200 );
                        },
                        delay       : 500,
                        minChars    : 1,
                        showId      : false,
                        scrollHeight: 150,
                        maxNum      : 100,
                        width       : 300,
                        showOnFocus : true
                    } );

				} else {
					var searchMenuData = [];

					var buildChildData = function(m){
						var cData = [],
						c = m.children;
						for(var j = 0, clen = c.length; j < clen; j++){
							if(c[j].url&&(!c[j].children||c[j].children.length>0)){
								cData[cData.length] = $.extend({parent:m.name},c[j]);
							}else if(c[j].children && c[j].children.length>0){
								cData = cData.concat(buildChildData(c[j]));
							}
						}
						return cData;
					};

					for(var i = 0,len = Constant.menuObj.length; i < len; i++){
						var data = buildChildData(Constant.menuObj[i]);
						if(data.length > 0){
							searchMenuData = searchMenuData.concat(data);
						}
					}

					new $.Autocompleter(searchInput[0], $.extend({}, $.Autocompleter.defaults, {
						max: 1500,
						width : 240,
						showOnFocus : true,
						matchContains: true,
						data:searchMenuData,
						formatMatch:function(menu){
							return menu.name;
						},
						formatItem : function(data, i, max){
							var _d = [];
							if(data.value){
								_d.push('<strong style="float:left;">'+data.value+'</strong>');
								if(data.data.parent){
									_d.push('<span style="float:right">'+data.data.parent+'</span>');
								}
							}
							return _d.join("\n");
						},
						highlight : function(value) { return value; }
					}));
//                    searchInput.bind("result", function(event, data, formatted){
//                        searchInput.blur();
//                        setTimeout( function ()
//                        {
//                            STK.go( data.data.url, data.data.name, {refresh: true} );
//                        }, 200 );
//                    } );
                }
				/////////////////////////////////////////////////////////////////
				/////////全局搜索部分结束
				////////////////////////////////////////////////////////////////

				STKCommon.leftMenuSwitch(opt.defaultMenuId);
			}
			
			Constant.navigateMap.navArrMax = opt.maxNavNum;
//			STK.go('home.html','个人中心',{
//				enableClose : false,
//				switchTabRefresh : false
//			});
//			$('#J_navExtraHide').click(function(){
//				if(typeof Constant.navHideExtra != 'undefined'){
//					$(this).tipExtra({
//						html : Constant.navHideExtra
//					});
//				}
//			});
			
		},
		//窗口变化回调函数
		resize : function(fun){
			if(typeof fun == 'function'){
				$(window).resize(function(){
					fun();
				});
			}
		},
		//窗口滚动回调函数
		scroll : function(fun){
			if(typeof fun == 'function'){
				$(window).scroll(function(){
					fun();
				});
			}
		},
		//menuDo 
		menuDo : function(mId,sId){
			STKCommon.leftMenuSwitch(mId);
		},
		//通用的go连接跳转
		go : function(url,summaryTitle,setting){
			if(typeof summaryTitle != 'string'){
				setting = summaryTitle;
				summaryTitle = '';
			}
			try{
				var a = setting&&setting.parent.window;
			}catch(e){
				delete setting.parent;
			}
			var opt = $.extend({
				url : url,
				type : 'GET',
				callback : undefined,
				data : {},
				summaryTitle : summaryTitle,
				keyWithoutParams : false,
				refresh : false,
				switchTabRefresh : false
			},setting);
			var curUrl = encodeURI(opt.url + opt.summaryTitle);
			var key = '';
			if($.isPlainObject(url)){
				for(var u in url){
					key += encodeURI((opt.keyWithoutParams ? u.split('?')[0] : u));
				}
				key += encodeURI(opt.summaryTitle);
			}else{
				key = encodeURI((opt.keyWithoutParams ? url.split('?')[0] : url) + opt.summaryTitle);
			}
			if(STKCommon.navigateOpenLimit(key)){
				return;
			}
			if(Constant.curRequestUrl === curUrl && !opt.refresh) return CachePageData[key];
			Constant.curRequestUrl = curUrl;
			if($.isPlainObject(url)){
				var ret = STKCommon.loadsWithTimestamp(url,opt);
			}else{
				var ret = STKCommon.loadsWithTimestamp(key,opt);
			}
			
			STKCommon.navigateDo(url,opt);
			return ret;
		},
		getTab : function(url,summaryTitle,setting){
			var opt = $.extend({
				url : url,
				type : 'GET',
				callback : undefined,
				data : {},
				summaryTitle : summaryTitle,
				keyWithoutParams : false,
				refresh : false
			},setting);
			var key = encodeURI((opt.keyWithoutParams ? url.split('?')[0] : opt.url) + opt.summaryTitle);
			return CachePageData[key];
		},
        getParentTab:function(root){
            return root.parent.STK && root.parent.STK.closeNav && root.frameElement ? top.$(root.frameElement).data('setting').parent : root.parent;
        },
		removeTab : function(url,summaryTitle,setting){
			var opt = $.extend({
				url : url,
				type : 'GET',
				callback : undefined,
				data : {},
				summaryTitle : summaryTitle,
				keyWithoutParams : false,
				refresh : false
			},setting);
			var key = encodeURI((opt.keyWithoutParams ? url.split('?')[0] : opt.url) + opt.summaryTitle);
			return STK.closeNav(key);
		},
        removeSelf : function(w,c){
			for(var o in CachePageData){
				if(CachePageData[o].get(0).contentWindow == w){
					return STK.closeNav(o,c);
				}
			}
		},
		navigate : function(url,summaryTitle,w,setting){
			var key;
			for(var o in CachePageData){
				if(CachePageData[o].get(0).contentWindow == w){
					key = o;
					break;
				}
			}
			if(typeof key == 'undefined')return;
			var keysetting = Constant.navigateMap[key].data('setting');
			var opt = $.extend(
					{}
					,keysetting);
			$.extend(opt,{
				url : url,
				summaryTitle : summaryTitle
			})
			var newkey = encodeURI((opt.keyWithoutParams ? url.split('?')[0] : url) + summaryTitle);
			if(typeof Constant.navigateMap[newkey] != 'undefined'){
//				var ret = STKCommon.loadsWithTimestamp(key,opt);
//				STKCommon.navigateDo(url,opt);
				return STK.go(url,summaryTitle,opt);
			}
			Constant.navigateMap[key].children('span').html(summaryTitle).append('<i class="common-bg-icon nav-close" onclick="STK.closeNav(\''+newkey+'\')"></i>');
			CachePageData[key].get(0).src = url;
			Constant.navigateMap[key].data({
				url : opt.url,
				setting : opt
			});
			CachePageData[key].data({
				url : opt.url,
				setting : opt
			});
			Constant.navigateMap[newkey] = Constant.navigateMap[key];
			Constant.navigateMap['currentNavKey'] = newkey;
			Constant.curRequestUrl = newkey;
			CachePageData[newkey] = CachePageData[key];
			delete CachePageData[key];
			delete Constant.navigateMap[key];

		},
		//通用的表单提交函�?
//		formGo : function(formId){
//			var _form = $('#'+formId);
//			if(_form.length == 0){
//				return;
//			}
//			var _action = _form.attr('action');
//			var _type = _form.attr('method');
//			var _params = _form.serialize();
//			if("POST" === _type.toUpperCase()){
//				Constant.ajaxLoading.show();
//				$.ajaxSetup ({cache:false});
//				$('#J_common_section').load(_action,encodeURI(_params),function(){
//					Constant.ajaxLoading.hide();
//				});
//			}else{
//				Constant.ajaxLoading.show();
//				$.ajaxSetup ({cache:false});
//				$('#J_common_section').load(_action+'?'+encodeURI(_params),function(){
//					Constant.ajaxLoading.hide();
//				});
//			}
//		},
		//管理菜单
		closeNav : function(key,type){
			var _type = key === 'ALL' ? 'ALL' : type;
			if(_type === 'ALL'){
				for ( var k in Constant.navigateMap){
					if(k == 'currentNavKey' || k == 'navArrMax'){continue;}
					if(Constant.navigateMap[k].data('enableClose')){
                        try{
						    var w = CachePageData[k][0].contentWindow;
                            var result = w.$(w).triggerHandler('close',[Constant.navigateMap[k].data('setting'), CachePageData[k]]);
                            if(result === false) {
                                return;
                            }
                        } catch (e){}
                        CachePageData[k].triggerHandler('close',[CachePageData[k]]);
						Constant.navigateMap[k].remove();
						Constant.navigateMap[k].removeData();
						CachePageData[k].remove();
						CachePageData[k].removeData();
						delete Constant.navigateMap[k];
						delete CachePageData[k];
					}
				}
				for ( var k in Constant.navigateMap){
					if(k == 'currentNavKey' || k == 'navArrMax'){continue;}
					STK.go(Constant.navigateMap[k].data('url'),Constant.navigateMap[k].data('setting'));
					break;
				}
			}else if(_type ==='LEFT'){
				var _liArr = $('#J_commonNavTabBar').children('li');
				var len = _liArr.length;
				var i = 0;
				do{
					var _li = _liArr.eq(i);
					var k = _li.data('key');
					if(k == key)break;
					if(_li.data('enableClose')){
                        try{
                            var w = CachePageData[k][0].contentWindow;
                            var result = w.$(w).triggerHandler('close',[Constant.navigateMap[k].data('setting'), CachePageData[k]]);
                            if(result === false) {
                                return;
                            }
                        } catch (e){}
						CachePageData[k].triggerHandler('close',[CachePageData[k]]);
						Constant.navigateMap[k].remove();
						Constant.navigateMap[k].removeData();
						CachePageData[k].remove();
						CachePageData[k].removeData();
						delete Constant.navigateMap[k];
						delete CachePageData[k];
					}
				}while(i++<len-1);
			}else if(_type === 'RIGHT'){
				var _liArr = $('#J_commonNavTabBar').children('li');
				var len = _liArr.length;
				while(len-->0){
					var _li = _liArr.eq(len);
					var k = _li.data('key');
					if(_li.data('key') == key)break;
					if(_li.data('enableClose')){
						var w = CachePageData[k][0].contentWindow;
                        try {
                            var result = w.$(w).triggerHandler('close',[Constant.navigateMap[k].data('setting'), CachePageData[k]]);
                            if(result === false) {
                                return;
                            }
                        } catch (e){}
						CachePageData[k].triggerHandler('close',[CachePageData[k]]);
						Constant.navigateMap[k].remove();
						Constant.navigateMap[k].removeData();
						CachePageData[k].remove();
						CachePageData[k].removeData();
						delete Constant.navigateMap[k];
						delete CachePageData[k];
					}
				};
			}else if(_type === 'OTHER'){
				var _liArr = $('#J_commonNavTabBar').children('li');
				var len = _liArr.length;
				while(len-->0){
					var _li = _liArr.eq(len);
					var k = _li.data('key');
					if(_li.data('key') == key)continue;
					if(_li.data('enableClose')){
                        try {
                            var w = CachePageData[k][0].contentWindow;
                            var result = w.$(w).triggerHandler('close',[Constant.navigateMap[k].data('setting'), CachePageData[k]]);
                            if(result === false) {
                                return;
                            }
                        } catch (e){}
						CachePageData[k].triggerHandler('close',[CachePageData[k]]);
						Constant.navigateMap[k].remove();
						Constant.navigateMap[k].removeData();
						CachePageData[k].remove();
						CachePageData[k].removeData();
						delete Constant.navigateMap[k];
						delete CachePageData[k];
					}
				};
			}else{
                try {
                    var w = CachePageData[key][0].contentWindow;
                    var result = w.$(w).triggerHandler('close',[Constant.navigateMap[key].data('setting'), CachePageData[key]]);
                    if(result === false) {
                        return;
                    }
                } catch (e){}
                CachePageData[key].triggerHandler('close',[CachePageData[k]]);
                if(Constant.navigateMap.currentNavKey == key){
                    var se = Constant.navigateMap[key].data('setting');
                    try{
                        var pse = se.parent&&se.parent.frameElement&&$(se.parent.frameElement).data('setting');
                    }catch(e){}
                    if (se && pse && se.parent.window && se.parent.window === se.parent.window.window && se.parent !== window){
                        var args = {};
                        for (var name in pse){
                            try{
                                args[name] = pse[name];
                            } catch (e) {}
                        }
                        $.extend(args, {refresh: type === true ? true : false});
                        STK.go(args.url, args);
                    }else{
                        var _li;
                        if($('#J_commonNavTabBar').children('li.selected').next('li').get(0)){
                            _li = $('#J_commonNavTabBar').children('li.selected').next('li').get(0);
                        }else if($('#J_commonNavTabBar').children('li.selected').prev('li').get(0)){
                            _li = $('#J_commonNavTabBar').children('li.selected').prev('li').get(0);
                        }
                        //$(_li).addClass('selected');
                        if(_li){
                            var _setting = $(_li).data('setting');
                            _setting = $.extend({},_setting,{refresh: type === true ? true : false});
                            STK.go($(_li).data('url'),_setting);
                        }
                    }
                }
                Constant.navigateMap[key].removeData();
                Constant.navigateMap[key].remove();
                CachePageData[key].removeData();
                CachePageData[key].remove();
                delete Constant.navigateMap[key];
                delete CachePageData[key];
				
//				STK.go(Constant.navigateMap[k].data('url'),Constant.navigateMap[k].data('setting'));
//				if(Constant.navigateMap.currentNavKey == key){
//					for ( var k in Constant.navigateMap) {
//						if(k == 'currentNavKey' || k == 'navArrMax'){continue;}
//						if(Constant.navigateMap[k]){
//							Constant.navigateMap[k].addClass('selected');
//							STK.go(Constant.navigateMap[k].data('url'),Constant.navigateMap[k].data('setting'));
//							break;
//						}
//					}
//				}
			}
			STKCommon.navOrderReset();
		},
		//左右切换菜单right,left
		switchNav : function(flag){
			var _index = getNavIndex();
			var _next;
			if(flag == 'right'){
				_next = _index+1 >= $('#J_commonNavTabBar li').length ? 0 : _index+1;
			}else if(flag == 'left'){
				_next = _index-1 < 0 ? $('#J_commonNavTabBar li').length-1 : _index-1;
			}
			var _li = $($('#J_commonNavTabBar li')[_next]);
			STK.go(_li.data('url'),_li.data('setting'));
			function getNavIndex(){
				for ( var i = 0; i < $('#J_commonNavTabBar li').length; i++) {
					if($($('#J_commonNavTabBar li')[i]).data('key') == Constant.navigateMap.currentNavKey){
						return i;
					}
				}
				return 0;
			}
		},
		//扩展全部
		showAllMenu : function(){
			if(Constant.menuUlMark.expAId){
				Constant.menuUlMark[Constant.menuUlMark.expAId].children('.nav-expand').show();
				Constant.menuUlMark[Constant.menuUlMark.expAId].find('.nav-icon-opt').removeClass('close');
			}
		},
        //扩展第一�?
        showFirstMenu : function(){
			if(Constant.menuUlMark.expAId){
				Constant.menuUlMark[Constant.menuUlMark.expAId].children('.nav-expand').eq(0).show();
				Constant.menuUlMark[Constant.menuUlMark.expAId].find('.nav-icon-opt').eq(0).removeClass('close');
			}
		},
		initNoticeTip:function(){
			if(!STK.__noticeTip){
				var tipTpl = '<div class="notice-tips">'+
				'	<div class="notice-content">'+
				'		<ul class="notice-collect">'+
				'		</ul>'+
				'		<ul class="notice-box">'+
				'		</ul>'+
				'	</div>'+
				'	<a href="#" class="online-icon-close" onclick="STK.hideNoticeTip()"></a>'+
				'</div>';
				STK.__noticeTip = $(tipTpl).appendTo('body').hide();
				STK.__noticeTip.collect = STK.__noticeTip.find('ul.notice-collect');
				STK.__noticeTip.collect.map = {};
				STK.__noticeTip.message = STK.__noticeTip.find('ul.notice-box');
				STK.__noticeTip.message.map = {};
			}
		},
		showNoticeTip:function(){
			STK.__noticeTip && STK.__noticeTip.fadeIn(300);
		},
		hideNoticeTip:function(){
			STK.__noticeTip && STK.__noticeTip.fadeOut(300);
		},
		pushNoticeTipCollect:function(id,con){
			//<strong>15</strong>条未处理事宜，<a href="#">查看事宜</a>
			var tip = STK.__noticeTip;
			var continer = tip.collect;
			var map = continer.map;
			var max = continer.max || 3;
			pushNoticeTipItem(map, id, continer, con, max);
		},
		pushNoticeTipMessage:function(id, title, desc, click){
			var msgTpl = '<a href="#"><p style="font-weight: bold;">'+ title +'</p><p class="detail text-overflow">'+ desc +'</p></a>';

			var tip = STK.__noticeTip;
			var continer = tip.message;
			var map = continer.map;
			var max = continer.max || 5;
			var con = $(msgTpl);
			con.click(function(){
				click && click.apply(this, arguments);
				return false;
			});
			pushNoticeTipItem(map, id, continer, con, max);
		},
		removeNoticeTipCollect:function(id){
			var map = STK.__noticeTip.collect.map;
			removeNoticeTipItem(map, id);
		},
		removeNoticeTipMessage:function(id){
			var map = STK.__noticeTip.message.map;
			removeNoticeTipItem(map, id);
		},
		/***
		 *设置无限制显示汇总信息数目，默认为3，-1则无限制
		 **/
		setNoticeTipMaxCollect:function(num){
			STK.__noticeTip.collect.max = num;
		},
		/**
		 *设置无限制显示消息数目，默认为5，-1则无限制
		 **/
		setNoticeTipMaxMessage:function(num){
			STK.__noticeTip.message.max = num;
		}
	});
	var removeNoticeTipItem = function(map, id){
		if(map[id]){
			map[id].remove();
			delete map[id];
		}
	},pushNoticeTipItem = function(map, id, continer, con, max){
			//<strong>15</strong>条未处理事宜，<a href="#">查看事宜</a>
			var collectTpl = $('<li/>').append(con);
			if(map[id]){
				var tpl = $(collectTpl);
				map[id].replaceWith(tpl);
				map[id] = tpl;
			} else {
				map[id] = $(collectTpl);
			}
			map[id].prependTo(continer);
			var cl = continer.children();
			if(cl.length > max && max !== -1){
				cl.last().remove();
			}
		};
STKCommon.init();
})(jQuery);

