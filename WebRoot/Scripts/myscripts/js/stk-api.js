jQuery.fn.extend({
    stk_version:function(){return "0.0.7";},
    stk_val: function(data,data2) {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if(data == undefined)
        {
            if(cn == "checkboxgroup" || cn == "multiselect")
            {
                return stk.checkBox.getValue(name);
            }
            else if(cn == "radioboxgroup")
            {
                return stk.radioBox.getValue(name);
            }
            else if(cn == "combobox")
            {
                return $(obj).val();
            }
            else if(cn == "autocomplete")
            {
                if($(obj).attr("emptyText") == "1") return "";
                else
                    return $("#"+id+"_keyId").val();
            }
            else if(cn == "doceditor")
            {
                return KE.util.getData(id);
            }
            else if(cn == "classifiedselect" || cn=="letterselect")
            {
                var _data =[];
                $.each($("#"+id).find("input[name!='classify']:checked"), function( i, n )
                {
                    _data.push($(n).val());
                });
                return _data;
            }
            else if(cn == "removableselect")
            {
                var value = new Array();
                $.each($("input[name='" + name + "']"), function( i, n )
                {
                    value.push($(n).val());
                });
                return value;
            }
            else if(cn == "starselect")
            {
                return $(obj).find("input").eq(0).val();
            }
            else if(cn == "doubleselect")
            {
                var _data =[];
                $.each($("#"+id+"_r").find("option"), function( i, n )
                {
                    _data.push($(n).val());
                });
                return _data;
            }
            else if(cn == "slider")
            {
                return  $("#"+id+"_value").val();
            }
            else
            {
                if($(obj).attr("emptyText") == "1") return "";
                else
                    return $(obj).val();
            }
        }
        else{
            if(cn == "checkboxgroup" )
            {
                stk.checkBox.setValue(name,data);
            }
            else if(cn == "radioboxgroup")
            {
                stk.radioBox.setValue(name,data);
            }
            else if ( cn == "colorselect" )
            {
                $(obj).val(data).css("backgroundColor",data);
            }
            else if(cn == "combobox")
            {
                $(obj).val(data);
                var text = $(obj).find("option:selected").html();
                $(obj).parent().find("input").val(text);
            }
            else if(cn == "multiselect")
            {
                stk.checkBox.setValue(name,data);
                $("#"+id+"_showValue").val(stk.checkBox.getText(name));
            }
            else if(cn == "autocomplete")
            {
                $("#"+id+"_keyId").val(data);
            }
            else if(cn == "doceditor")
            {
                KE.html(id,data);
                $("#"+id+"_input").val(KE.util.getData(id));
            }
            else if(cn == "classifiedselect" || cn=="letterselect")
            {
                $("#"+id).stk_emptyOptions();
                if(typeof(data) == typeof([]))
                {
                    for(var i = 0; i < data.length; i++)
                    {
                        $("#"+id).find("input[name!='classify'][value='"+data[i]+"']").attr("checked",true);
                    }
                }
            }
            else if(cn == "textfield" && "true" == $(wrap).attr("areaEdit"))
            {
                var areaEdit = $(wrap).attr("areaEdit");
                $(obj).val(data);
                $("#"+id+"_editor").val(data);
            }
            else if(cn == "starselect")
            {
                $(obj).val(data);
                window[id+"_initStar"](data);
            }
            else if(cn == "doubleselect")
            {
                window[id+"_init"](null,data);
            }
            else if(cn == "slider")
            {
                if(typeof(data) == typeof([])) {$("#"+id).slider("option", "values", data);$("#"+id+"_value") .val(data.join(","))}
                else {$("#"+id).slider("option", "value", data);$("#"+id+"_value") .val(data)}
            }
            else
            {
                $(obj).val(data);
            }
            if (StringUtils.isNotBlank($(obj).parent().attr("emptyText")) && (data == undefined || data == "" || data == null)) {
                $(obj).css("color", "#999").attr("emptyText","1");
                $(obj).val($(obj).parent().attr("emptyText"));
            }
            if (stk.textField.isEmptyText(obj) && data != undefined && data != "" && data != null) {
                $(obj).css("color", "");
                $(obj).attr("emptyText","0");
            }
            return $(this);
        }
    },
    stk_map: function() {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if(cn == "classifiedselect" || cn=="letterselect")
        {
            var value = {};
            $.each($(obj).find("input[name!='classify']:checked"), function( i, n )
            {
                value[$(n).val()] = $(n).next().text();
            });
            return value;
        }
    },
    stk_check:function(target){
        var obj = this[0];
        var id = $(obj).attr("id");
        return stk.form.check(id,target);
    },
    stk_checkForm:function(ignor){
        var obj = this[0];
        var id = $(obj).attr("id");
        return stk.form.checkForm(id,ignor);
    },
    stk_checked:function(data){
        var obj = this[0];
        var id = $(obj).attr("id");

        if(data == undefined)
        {
            return $(obj).attr("checked");
        }
        else{
            var isSwichStyle = $("#" + id + "_style").length == 1;
            if (isSwichStyle)
            {
                var ss = $("#" + id + "_style");
                var styleType = $(ss).attr("styleType");
                if (data)
                    $(ss).removeClass().addClass("buttonswich" + styleType + "_toggle");
                else
                    $(ss).removeClass().addClass("buttonswich" + styleType);
            }
            $(obj).attr("checked",data);
        }
        return $(this);
    },
    stk_toggleChecked:function()
    {
        var obj = this[0];
        var id = $(obj).attr("id");

        var isSwichStyle = $("#"+id+"_style").length == 1;
        if(isSwichStyle)
        {
            var ss = $("#"+id+"_style");
            var styleType = $(ss).attr("styleType");
            if ($(obj).attr("checked"))
                $(ss).removeClass().addClass("buttonswich"+styleType);
            else
                $(ss).removeClass().addClass("buttonswich"+styleType+"_toggle");
        }
        if($(obj).attr("checked"))
            $(obj).attr("checked",false);
        else
            $(obj).attr("checked",true);
        return $(this);
    },
    stk_title:function(param1,param2)
    {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if(cn == "tabs")
        {
            $(wrap).stktabsTitle( param1,param2 );
        }
        return $(this);
    },
    stk_text:function(data) {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if(data == undefined)
        {
            if(cn == "checkboxgroup" || cn == "multiselect")
            {
                return stk.checkBox.getText(name);
            }
            else if(cn == "radioboxgroup" )
            {
                return stk.radioBox.getText(name);
            }
            else if(cn == "select" )
            {
                return $(obj).find("option:selected").text();
            }
            else if($(obj).attr("type") == "checkbox" || $(obj).attr("type") == "radio")
            {
                if( $(obj).next().attr('tagName') == "LABEL")
                {
                    return $(obj).next().text();
                }
            }
            else if(cn == "autocomplete")
            {
                if($(obj).attr("emptyText") == "1") return "";
                else
                    return $(obj).val();
            }
            else if(cn == "button")
            {
                if($(obj).find("span").length > 1)
                    return $(obj).find("span").eq(1).text(data);
                else
                    return $(obj).find("span").eq(0).text(data);
            }
            else if(cn == "buttonmenu" || cn == "toolbarbutton" || cn == "toolbarbuttonmenu")
            {
                return $(obj).find("span[name='text']").html();
            }
            else
            {
                if($(obj).attr("emptyText") == "1") return "";
                else
                    return $(obj).text();
            }
        }
        else{
            if(cn == "autocomplete")
            {
                $(obj).css("color","");
                $(obj).val(data);
            }
            else if(cn == "button")
            {
                if($(obj).find("span").length > 1)
                    $(obj).find("span").eq(1).text(data);
                else
                    $(obj).find("span").eq(0).text(data);
            }
            else if(cn == "buttonmenu" || cn == "toolbarbutton" || cn == "toolbarbuttonmenu")
            {
                $(obj).find("span[name='text']").html(data);
            }
            else
            {
                $(obj).text(data);
                $(obj).css("color","");
            }
            return $(this);
        }
    },
    stk_html:function(data) {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if(data == undefined)
        {
            return $(obj).html();
        }
        else{
            $(obj).html(data);
            return $(this);
        }
    },
    stk_resetOptions:function(data,defaultKey) {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if (cn == "")
        {
        }
        else
        {
            $("#" + id).find("option[value!='']").remove();
            for ( var property in data )
            {
                var key = property;
                var value = data[property];
                var option = document.createElement('option');
                option.setAttribute("value", key);
                if ( key == defaultKey )
                    option.setAttribute("selected", "selected");
                option.innerHTML = value;
                $("#" + id).append(option);
            }
        }
        return $(this);
    },
    stk_resetOptionsList:function ( data, defaultKey )
    {
        var obj = this[0];
        var id = $( obj ).attr( "id" );
        var name = $( obj ).attr( "name" );
        var wrap = $( "#" + id + "_wrap" );
        var cn = $( wrap ).attr( "cn" );
        if ( cn == "" )
        {
        }
        else
        {
            $( "#" + id ).find( "option[value!='']" ).remove();
            for(var i = 0; i < data.length; i++)
            {
                var key = data[i].key;
                var value = data[i].value;
                var option = document.createElement( 'option' );
                option.setAttribute( "value", key );
                if ( key == defaultKey )
                {
                    option.setAttribute( "selected", "selected" );
                }
                option.innerHTML = value;
                $( "#" + id ).append( option );
            }
        }
        return $( this );
    },
    stk_emptyOptions:function() {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if(cn == "removableselect")
        {
            $(obj).empty();
        }
        else if (cn == "classifiedselect" || cn == "letterselect") {
            $(obj).find("input[type='checkbox']").attr("checked",false);
        }
        else if (StringUtils.isNotBlank(cn))
        {
            $(wrap).find("option[value!='']").remove();
        }
        else
        {
            $("#" + id).find("option[value!='']").remove();
        }
        return $(this);
    },
    stk_show: function(param) {
        var obj = this[0];
        var id = $(obj).attr("id");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if (cn == "window")
        {
            if(param == undefined || param == null) param = {};
            param.clickBgClose = false;
            var objOrUrl = $(wrap).show();
            var title = $(wrap).attr("_title");
            var width = $(wrap).attr("_width");
            if(StringUtils.isNotBlank(width)) width = width.replaceAll("px","");
            var height = $(wrap).attr("_height");
            if(StringUtils.isNotBlank(height)) height = height.replaceAll("px","");
            var modal = $(wrap).attr("modal");
            var position = $(wrap).attr("position");
            param.objOrUrl = objOrUrl;
            if(StringUtils.isBlank(param.title)) param.title = title;
            if(StringUtils.isNotBlank(width)) param.width = width;
            if(StringUtils.isNotBlank(height)) param.contentBoxCss = {width:width,height:height,overflowX:'hidden',overflowY:'auto'};
            param.enableBg = (modal == "true");
            if(StringUtils.isNotBlank(position) && !param.boxCss)
            {
                param.boxCss = {};
                if(position.indexOf("left") > -1) param.boxCss.left = 0+$(window).scrollLeft();
                if(position.indexOf("top") > -1) param.boxCss.top = 0+$(window).scrollTop();
                if(position.indexOf("right") > -1) param.boxCss.right = 0;
                if(position.indexOf("bottom") > -1) param.boxCss.bottom = 0;
            }
            STK.stk_dialog(param);
            if(jQuery.isFunction(window[id+"_close"]))
            {
                $( wrap ).parent().parent().one( "close", function ()
                {
                    window[id + "_close"]();
                } );
            }
        }
        else if($(obj).attr("name") == "tabletoolbar")
        {
            $(obj).parent().show();
        }
        else if(cn == "tabs" && param)
        {
            $.each($(wrap).find("div.stk-ui-tabs-con"), function( i, n )
            {
                if((typeof(param) == 'string' && $(n).attr("id") == param) || (typeof(param) == 'number' && param == i))
                {
                    $(wrap).find("ul.stk-ui-tabs-bar").find("li.stk-ui-tabs-item").eq(i).show();
                }
            });
        }
        else if(cn=="letterselect" || cn=="classifiedselect")
        {
            if(typeof(param) == 'string') param = $("#"+param);
            window[id+"_resetPosition"](param);
            $(wrap).show();
        }
        else if(StringUtils.isNotBlank(cn))
        {
            $(wrap).show();
        }
        else
            $(obj).show();
        return $(this);
    },
    stk_hide: function(param) {
        var obj = this[0];
        var id = $(obj).attr("id");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");

        if (cn == "window")
        {
            $(wrap).stk_cancelDialog();
        }
        else if($(obj).attr("name") == "tabletoolbar")
        {
            $(obj).parent().hide();
        }
        else if(cn == "tabs" && param)
        {
            $.each($(wrap).find("div.stk-ui-tabs-con"), function( i, n )
            {
                if((typeof(param) == 'string' && $(n).attr("id") == param) || (typeof(param) == 'number' && param == i))
                {
                    $(n).hide();
                    $(wrap).find("ul.stk-ui-tabs-bar").find("li.stk-ui-tabs-item").eq(i).hide();
                }
            });
        }
        else if(StringUtils.isNotBlank(cn))
        {
            $(wrap).hide();
        }
        else
            $(obj).hide();
        return $(this);
    },
    stk_showCol: function(property) {
        var table = this[0];
        var id = $( table ).attr( "id" );

        if(stk.table.isFixTable(id))
        {
            var obj = $("#" + id + "_HT" ).find( "tr[type!='group'][fake!='1'] > th[property='"+property+"']" );
            if(obj.length == 0) return $(this);
            var isShow = $(obj ).attr("show");
            if(isShow === "false" || isShow === false)
            {
                var colNum = $( obj ).attr( "colNum" );
                $( "#" + id + "_Con" ).find( "td[colNum='" + colNum + "'][merged!='true']" ).show();
                $( "#" + id + "_HT" ).find( "th[colNum='" + colNum + "']" ).show();
                var group = $( obj ).attr( "group" );
                var groupTop = $( obj ).attr( "groupTop" );
                if ( StringUtils.isNotBlank( group ) )
                {
                    var groupObj = $( "#" + id + "_HT" ).find( "th[groupName='" + group + "']" );
                    var colspan = new Number( $( groupObj ).attr( "colspan" ) );

                    if ( $( groupObj ).css("display") == "none" )
                    {
                        $( groupObj ).show();
                    }
                    else
                    {
                        $( groupObj ).attr( "colspan", (colspan + 1) );
                    }
                }
                if ( StringUtils.isNotBlank( groupTop ) )
                {
                    var groupObj = $( "#" + id + "_HT" ).find( "th[groupTopName='" + groupTop + "']" );
                    var colspan = new Number( $( groupObj ).attr( "colspan" ) );
                    if ( $( groupObj ).css("display") == "none" )
                    {
                        $( groupObj ).show();
                    }
                    else
                    {
                        $( groupObj ).attr( "colspan", (colspan + 1) );
                    }
                }
            }
            $(obj ).attr("show","true");
        }
        else
        {
            var obj = $( "#" + id ).find( "thead > tr[type!='group'][fake!='1'] > th[property='"+property+"']" );
            if(obj.length == 0) return $(this);
            var isShow = $( obj ).attr( "show" );
            if ( isShow === "false" || isShow === false )
            {
                var colNum = $( obj ).attr( "colNum" );
                $( "#" + id ).find( "td[colNum='" + colNum + "'][merged!='true']" ).show();
                $( "#" + id ).find( "th[colNum='" + colNum + "']" ).show();
                var group = $( obj ).attr( "group" );
                var groupTop = $( obj ).attr( "groupTop" );

                if ( StringUtils.isNotBlank( group ) )
                {
                    var groupObj = $( "#" + id ).find( "thead > tr> th[groupName='" + group + "']" );
                    var colspan = new Number( $( groupObj ).attr( "colspan" ) );
                    if ( $( groupObj ).css("display") == "none" )
                    {
                        $( groupObj ).show();
                    }
                    else
                    {
                        $( groupObj ).attr( "colspan", (colspan + 1) );
                    }
                }
                if ( StringUtils.isNotBlank( groupTop ) )
                {
                    var groupObj = $( "#" + id ).find( "thead > tr> th[groupTopName='" + groupTop + "']" );
                    var colspan = new Number( $( groupObj ).attr( "colspan" ) );
                    if ( $( groupObj ).css("display") == "none" )
                    {
                        $( groupObj ).show();
                    }
                    else
                    {
                        $( groupObj ).attr( "colspan", (colspan + 1) );
                    }
                }
            }
            $(obj ).attr("show","true");
        }
    },
    stk_hideCol: function(property) {
        var table = this[0];
        var id = $( table ).attr( "id" );

        if ( stk.table.isFixTable( id ) )
        {
            var obj = $( "#" + id + "_HT" ).find( "tr[type!='group'][fake!='1'] > th[property='" + property + "']" );
            if ( obj.length == 0 )
            {
                return $( this );
            }
            var isShow = $( obj ).attr( "show" );
            if ( isShow === "true" || isShow === true )
            {
                var colNum = $( obj ).attr( "colNum" );
                $( "#" + id + "_Con" ).find( "td[colNum='" + colNum + "']" ).hide();
                $( "#" + id + "_HT" ).find( "th[colNum='" + colNum + "']" ).hide();
                var group = $( obj ).attr( "group" );
                var groupTop = $( obj ).attr( "groupTop" );
                if ( StringUtils.isNotBlank( group ) )
                {
                    var groupObj = $( "#" + id + "_HT" ).find( "th[groupName='" + group + "']" );
                    var colspan = new Number( $( groupObj ).attr( "colspan" ) );
                    if ( colspan > 1 )
                    {
                        $( groupObj ).attr( "colspan", (colspan - 1) );
                    }
                    else
                    {
                        $( groupObj ).hide();
                    }
                }
                if ( StringUtils.isNotBlank( groupTop ) )
                {
                    var groupObj = $( "#" + id + "_HT" ).find( "th[groupTopName='" + groupTop + "']" );
                    var colspan = new Number( $( groupObj ).attr( "colspan" ) );
                    if ( colspan > 1 )
                    {
                        $( groupObj ).attr( "colspan", (colspan - 1) );
                    }
                    else
                    {
                        $( groupObj ).hide();
                    }
                }
            }
            $(obj ).attr("show","false");
        }
        else
        {
            var obj = $( "#" + id ).find( "thead > tr[type!='group'][fake!='1'] > th[property='" + property + "']" );
            if ( obj.length == 0 )
            {
                return $( this );
            }
            var isShow = $( obj ).attr( "show" );
            if ( isShow === "true" || isShow === true )
            {
                var colNum = $( obj ).attr( "colNum" );
                $( "#" + id ).find( "td[colNum='" + colNum + "']" ).hide();
                $( "#" + id ).find( "th[colNum='" + colNum + "']" ).hide();
                var group = $( obj ).attr( "group" );
                var groupTop = $( obj ).attr( "groupTop" );

                if ( StringUtils.isNotBlank( group ) )
                {
                    var groupObj = $( "#" + id ).find( "thead > tr> th[groupName='" + group + "']" );
                    var colspan = new Number( $( groupObj ).attr( "colspan" ) );
                    if ( colspan > 1 )
                    {
                        $( groupObj ).attr( "colspan", (colspan - 1) );
                    }
                    else
                    {
                        $( groupObj ).hide();
                    }
                }
                if ( StringUtils.isNotBlank( groupTop ) )
                {
                    var groupObj = $( "#" + id ).find( "thead > tr> th[groupTopName='" + groupTop + "']" );
                    var colspan = new Number( $( groupObj ).attr( "colspan" ) );
                    if ( colspan > 1 )
                    {
                        $( groupObj ).attr( "colspan", (colspan - 1) );
                    }
                    else
                    {
                        $( groupObj ).hide();
                    }
                }
            }
            $(obj ).attr("show","false");
        }
    },
    stk_query: function(func) {
        var obj = this[0];
        var id = $(obj).attr("id");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");

        if (cn == "table" || cn == "tablefix")
        {
            window[id+"_query"](func);
        }
        return $(this);
    },
    stk_selectAll: function(bool) {
        if(bool == undefined) bool = true;
        var obj = this[0];
        var id = $(obj).attr("id");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");

        if (cn == "doubleselect")
        {
            $("#"+id+"_r").find("option").attr("selected",bool);
        }
        else
        {
            $("#"+id).find("option").attr("selected",bool);
        }
        return $(this);
    },
    stk_init: function(param1,param2) {
        var obj = this[0];
        var id = $(obj).attr("id");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");

        if (cn == "table" || cn == "tablefix")
        {
            window[id+"_init"](param1);
        }
        else if (cn == "doubleselect")
        {
            var tmp = [];
            if(param1 && typeof(param1) == typeof({}))
            {
                for ( var property in param1 )
                {
                    var key = property;
                    var value = param1[property];
                    tmp.push({name:value,value:key});
                }
            }
            param1 = tmp;
            window[id + "_init"](param1,param2);
        }
        return $(this);
    },
    stk_jump: function(targetPage,func) {
        var obj = this[0];
        var id = $(obj).attr("id");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");

        if (cn == "table" || cn == "tablefix")
        {
            window[id+"_jump"](targetPage,undefined,func);
        }
        return $(this);
    },
    stk_reset:function() {
        this[0].reset();
        $(this).find(".ui-state-error").removeClass("ui-state-error").hoverTipBox(false);
        return $(this);
    },
    stk_submit: function(p1,p2,p3) {
        var callBack,exceptionHandler;
        var method = undefined;
        if(jQuery.isFunction(p1)) {callBack = p1;exceptionHandler = p2;}
        else
        {
            callBack = p2;
            method = p1;
            exceptionHandler = p3;
        }
        var obj = this[0];
        if(typeof(method) == typeof({})) method = p1.method;
        if(method == undefined){
            method = $(obj).attr("_method");
        }
        var id = $(obj).attr("id");
        var allowFileUpload = $(obj).attr("allowFileUpload");
        var params = stk.form.getParameters( id, p1, "@split@" );
        var htmlConvertIgnore = $( obj ).attr( "htmlConvertIgnore" );
        if ( htmlConvertIgnore )
        {
            params["__htmlConvertIgnore"] = htmlConvertIgnore;
        }
        if(allowFileUpload == "true")
        {
            var files = [];
            var keys = [];
            $.each($(obj).find("input[type='file']"), function( i, n )
            {
                if(StringUtils.isNotBlank($(n).val()))
                {
                    var id = $(n).attr("id");
                    var name = $(n).attr("name");
                    var key;
                    if(StringUtils.isNotBlank(name)) key = name;
                    else key = id;
                    if(StringUtils.isNotBlank(key))
                    {
                        files.push(DwrUtils.getValue(n));
                        keys.push(key);
                    }
                }
            });

            SpiritFormAction.callFileSubmit($(obj).attr("clazz"),method,params, keys,files,{
                callback:function(result)
                {
                    if (jQuery.isFunction(callBack)) callBack(result);
                },
                exceptionHandler:function(message,e)
                {
                    if (jQuery.isFunction(exceptionHandler)) exceptionHandler(message,e);
                    else
                    {
                        if ( message )
                        {
                            stk.error( "error：" + message );
                        }
                        else if ( e && e.cause && e.cause.message )
                        {
                            stk.error( "error：" + e.cause.message );
                        }
                        else
                        {
                            stk.error("error")
                        }
                    }
                }
            });
        }
        else
        {
            SpiritFormAction.callSubmit($(obj).attr("clazz"),method,params, {
                callback:function(result)
                {
                    if (jQuery.isFunction(callBack)) callBack(result);
                },
                exceptionHandler:function(message,e)
                {
                    if (jQuery.isFunction(exceptionHandler)) exceptionHandler(message,e);
                    else
                    {
                        if ( message )
                        {
                            stk.error( "error：" + message );
                        }
                        else if ( e && e.cause && e.cause.message )
                        {
                            stk.error( "error：" + e.cause.message );
                        }
                        else
                        {
                            stk.error("error")
                        }
                    }
                }
            });
        }
        return $(this);
    },
    stk_call: function(param,callBack) {
        if(typeof(param) == "function" && callBack == undefined)
        {
            callBack = param;
            param={};
        }
        var obj = this[0];
        var id = $(obj).attr("id");
        window[id+"_callTablePlugin"](param,callBack);
        return $(this);
    },
    hasSelect: function(tableId) {
        //方法过期，请使用stk_hasSelect
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("pluginParam");
        var type = $(obj).attr("type");
        var value;
        if(type == "checkbox")
        {
            if(tableId)
            {
                var datas = stk.table.getCheckedData(window["_"+tableId],name,true);
                return datas && datas.length > 0;
            }
            else
            {
                value = stk.checkBox.getValue(name);
                return value.length > 0;
            }
        }
        else if(type == "radiobox")
        {
            value = stk.radioBox.getValue(name);
            return StringUtils.isNotBlank(value);
        }
    },
    stk_hasSelect:function(tableId)
    {
      return $(this).hasSelect(tableId);
    },
    stk_click: function() {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if (cn == "")
        {
        }
        else
        {
            $(obj).click();
        }
        return $(this);
    },
    stk_blur: function() {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if (cn == "")
        {
        }
        else
        {
            $(obj).blur();
        }
        return $(this);
    },
    stk_change: function() {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if (cn == "")
        {
        }
        else
        {
            $(obj).change();
        }
        return $(this);
    },
    stk_dblclick: function() {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if (cn == "")
        {
        }
        else
        {
            $(obj).dblclick();
        }
        return $(this);
    },
    stk_focus: function() {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if (cn == "")
        {
        }
        else
        {
            $(obj).focus();
        }
        return $(this);
    },
    stk_selectData:function()
    {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if(cn="table")
        {
            var tbody;
            if(stk.table.isFixTable(id))
            {
                tbody = $("#"+id+"_ConFix").find("tbody")[0];
            }
            else
                tbody = $(obj).find("tbody")[0];
            var selectTr = $(tbody).find("tr[select='select']");
            if(selectTr.length == 1)
            {
                var rowNum = $(selectTr).attr('rowNum');
                if(rowNum)
                    var data = $(obj).stk_info().data[new Number(rowNum)];
                else
                    return null;
                return data;
            }
            else
                return null;
        }
    },
    stk_selectHtmlData:function()
    {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if(cn="table")
        {
            var tbody;
            if(stk.table.isFixTable(id))
            {
                tbody = $("#"+id+"_ConFix").find("tbody")[0];
            }
            else
                tbody = $(obj).find("tbody")[0];
            var selectTr = $(tbody).find("tr[select='select']");
            if(selectTr.length == 1)
            {
                var rowNum = $(selectTr).attr('rowNum');
                if(rowNum)
                    var data = $(obj).stk_info().htmlData[new Number(rowNum)];
                else
                    return null;
                return data;
            }
            else
                return null;
        }
    },
    stk_checkedData:function(para1,param2)
    {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if(cn="table")
        {
            var config = stk.table.config[id];
            var data = stk.table.getCheckedData(config,para1,param2);
            return data;
        }
    },
    stk_checkedHtmlData:function(para1,param2)
    {
        var obj = this[0];
        var checkedData = $(obj).stk_checkedData(para1,param2);
        var data = $(obj).stk_info().data;
        var htmlData = $(obj).stk_info().htmlData;
        var result = [];
        for(var i = 0; i < data.length;i++)
        {
            for(var k = 0; k < checkedData.length; k++)
            {
                if(data[i].objid && data[i].objid == checkedData[k].objid)
                {
                    result.push(htmlData[i]);
                }
            }
        }
        return result;
    },
    stk_select: function(param1) {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if (cn == "tabs")
        {
            $(wrap).stktabsselect( param1 );
        }
        else
        {
            $(obj).select();
        }
        return $(this);
    },
    stk_attr: function(attr,value) {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if(value == undefined)
        {
            if (cn == "")
            {
            }
            else
            {
                return $(obj).attr(attr);
            }
        }
        else
        {
            if (cn == "")
            {
            }
            else
            {
                $(obj).attr(attr,value);
            }
            return $(this);
        }
    },
    stk_disabled: function(bool) {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if (cn == "checkboxgroup" || cn == "radioboxgroup" || cn == "combobox")
        {
            $(wrap).find("input").attr("disabled",bool);
        }
        else if (cn == "multiselect")
        {
            $("#"+id+"_showValue").attr("disabled",bool);
            $("#"+id+"_multiVisibleDiv").find("input").attr("disabled",bool);
        }
        else if (cn == "doceditor")
        {
            bool?KE.toolbar.disable(id, []):KE.toolbar.able(id, []);
            KE.readonly(id,bool);
            KE.g[id].newTextarea.disabled = bool;
        }
        else if (cn == "starselect")
        {
            $(obj).startsScore(bool);
        }
        else if (cn == "datefield")
        {
            $(obj).attr("disabled",bool);
            if(bool) $("#"+id+"_icon").hide();
            else $("#"+id+"_icon").show();
        }
        else if (cn == "slider")
        {
            $(obj).slider("option","disabled",bool);
        }
        else if (cn == "button")
        {
            if (bool)
                $(obj).removeClass("stk-button").find("span").css("color", "gray").css({"font-size":"12px","font-family":'宋体'});
            else
                $(obj).addClass("stk-button").find("span").css("color", "black");
            $(obj).attr("disabled", bool);
        }
        else
        {
            $(obj).attr("disabled",bool);
        }
        return $(this);
    },
    stk_readonly: function(bool) {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if (cn == "checkboxgroup" || cn == "radioboxgroup" || cn == "combobox")
        {
            $(wrap).find("input").attr("readonly",bool);
        }
        else if (cn == "multiselect")
        {
            $("#"+id+"_showValue").attr("readonly",bool);
            $("#"+id+"_multiVisibleDiv").find("input").attr("readonly",bool);
        }
        else if (cn == "starselect")
        {
            $(obj).startsScore(bool);
        }
        else if (cn == "doceditor")
        {
            bool?KE.toolbar.disable(id, []):KE.toolbar.able(id, []);
            KE.readonly(id,bool);
            KE.g[id].newTextarea.disabled = bool;
        }
        else if (cn == "datefield")
        {
            $(obj).attr("readonly",bool);
            if(bool) $("#"+id+"_icon").hide();
            else $("#"+id+"_icon").show();
        }
        else
        {
            $(obj).attr("readonly",bool);
        }
        return $(this);
    },
    stk_info: function() {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if (cn == "table" || cn == "tablefix")
        {
            return window["_"+id];
        }
        else
        {
            return null;
        }
    },
    stk_data: function(objid) {
        var obj = this[0];
        var id = $( obj ).attr( "id" );
        var name = $( obj ).attr( "name" );
        var wrap = $( "#" + id + "_wrap" );
        var cn = $( wrap ).attr( "cn" );
        if ( cn == "table" || cn == "tablefix" )
        {
            if ( objid )
            {
                var rownum = new Number( $( wrap ).find( "tr[objid='" + objid + "']" ).eq( 0 ).attr( "rownum" ) );
                return $( obj ).stk_info().data[rownum];
            }
            else
            {
                return $( obj ).stk_info().data;
            }
        }
        else
        {
            return null;
        }
    },
    stk_adjust: function() {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if (cn == "tablefix")
        {
            var adjust = function(){
                var tableConfig = $(obj).stk_info().tableConfig;
                if (StringUtils.isBlank(tableConfig.height))
                {
                    //如果固定列表格无高度
                    $(function ()
                    {
                        stk.table.fitTable(id);
                    });
                }
                window["_" + id + "_grid"].fixedGridRefresh();
            };
            adjust();
            // 渲染延迟，进行第二次重新计算，解决聚合列被遮罩
            setTimeout(adjust, 1000);

        }
        return $(this);
    },
    stk_renderRow:function(config){
        var obj = this[0];
        var id = $(obj).attr("id");
        STK.addTableRowCss($('#'+id+'_wrap'),config);
    },
    stk_collectData:function(){
        var obj = this[0];
        var id = $(obj).attr("id");
        return window["_"+id+".collectData"];
    },
    stk_refresh: function(param1,param2) {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        if(wrap == undefined) wrap = $(obj).parent();
        var cn = $(wrap).attr("cn");
        if (cn == "tree")
        {
            function refreshNode(id,obj,nodeId,callBack)
            {
                var node = $(obj).find("div[nodeId='" + nodeId + "'] > div[class='stk_tree_icon_open']");
                if(node.length == 0) node = $(obj).find("div[nodeId='" + nodeId + "'] > div[class='stk_tree_icon_close']");
                if(node.length > 0)
                {
                    node = node[0];
                    $(node).removeClass("stk_tree_icon_open");
                    $(node).addClass("stk_tree_icon_close");
                }
                else
                {
                    node = $(obj).find("div[nodeId='" + nodeId + "'] > div[class='stk_tree_icon_minus']");
                    if(node.length == 0) node = $(obj).find("div[nodeId='" + nodeId + "'] > div[class='stk_tree_icon_plus']");
                    if(node.length > 0)
                    {
                        node = node[0];
                        $(node).removeClass("stk_tree_icon_minus");
                        $(node).addClass("stk_tree_icon_plus");
                    }
                }

                stk.tree.changeNode(node, true, id,callBack);
            }
            if(StringUtils.isBlank(param1))
            {
                window[id+"_buildTree"]();
            }
            else
            {
                if(param2)
                {
                    var parent = $(obj).find("div[nodeId='"+param1+"']");
                    var parentId;
                    for(var i = 0; i < 5; i++)
                    {
                        parent =$(parent).parent();
                        if(StringUtils.isNotBlank($(parent).attr("nodeId")))
                        {
                            parentId = $(parent).attr("nodeId");
                            break;
                        }
                    }
                    if(parentId != undefined)
                    {
                        refreshNode(id,obj,parentId,function(){
                            refreshNode(id,obj,param1);
                        });
                    }
                    else
                    {
                        window[id+"_buildTree"](param1);
                    }

                }
                else
                {
                    refreshNode(id,obj,param1);
                }
            }
        }
        else if(cn == "classifiedselect" || cn == "letterselect")
        {
            if(typeof(param1) == 'function')
                window[id+"_init"](param1);
            else
                window[id+"_init"]();
        }
        else if(cn == "chart")
        {
            if(typeof(param1) == 'function')
                window[id+"_init"](param1);
            else
                window[id+"_init"]();
        }
        return $(this);
    },
    stk_emptyText:function(text)
    {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");

        $(obj).focus(function() {
            if ($(obj).val() == text) {
                $(obj).val('').css("color", "").removeAttr("emptyText");
            }
        }).blur(function() {
            if ($(obj).val().length == 0) {
                $(obj).val(text).css("color", "#999").attr("emptyText","1");
            }
        });
        if ($(obj).val().length == 0) {
            $(obj).val(text).css("color", "#999").attr("emptyText","1");
        }
        return $(this);
    },
    stk_addOptions:function(para1, para2) {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");

        if(para1 == undefined || para1 == null) return null;

        if(typeof(para1) != typeof({}))
        {
            var option = {};
            option[para1] = para2;
            para1 = option;
        }
        if (cn == "select")
        {
            for ( var key in para1 )
            {
                if($(obj).find("option[value='"+key+"']").length == 0)
                    $(obj).append("<option value='"+key+"'>"+para1[key]+"</option>");
            }
        }
        else if(cn == "removableselect")
        {
            for ( var key in para1 )
            {
                if(para1[key] != undefined)
                {
                    var html = [];
                    if($(obj).find("input[value='"+key+"']").length == 0)
                    {
                        html.push("<span class='stk-child-o'><input name='"+name+"' type='hidden' value='"+key+"'/><span style='float:left;white-space:nowrap;'>"+para1[key]+"</span><b class='stk-button-icon stk-child-close' onclick=$(this).parent().remove();");
                        var fk;
                        try{fk= window[id+"_removeFunction"];}catch(e){}
                        if(typeof(fk) == "function")
                        {
                            html.push( id+"_removeFunction('"+key+"');");
                        }
                        html.push("></b></span>");
                        $(obj).append(html.join(""));
                    }
                }
            }
        }
        else if(cn == "multiselect")
        {
            var columnWidth = $(obj).attr("columnWidth");
            obj = $("#"+id+"_multiSelDiv");
            var selectAll = $("#"+id+"_cb_all").attr("checked", "");
            var html = [];
            for ( var key in para1 )
            {
                if($(obj).find("input[type='checkbox'][value='"+key+"']").length == 0)
                {
                    html.push("<div style='text-align:left;float:left;display:inline;");
                    if(StringUtils.isNotBlank())  html.push("width:"+columnWidth+";");
                    html.push("'><input type='checkbox' name='"+name+"' value='"+key+"'/><span class='checkboxLabel'>"+para1[key]+"</span></div>");
                }
            }
            $(obj).append(html.join("\n"));
            var checkboxs = $("input[type='checkbox'][name='" + name + "']");
            for (var key in para1)
            {
                $(obj).find("input[type='checkbox'][value='" + key + "']").change(function ()
                {
                    if ($(this).attr("checked") == false)
                    {
                        selectAll.attr("checked", "");
                    }
                    if (checkboxs.length == $("input[type='checkbox'][name='" + name + "']:checked").length)
                        selectAll.attr("checked", "checked");
                });
            }
        }
        return $(this);
    },
    stk_firstOption:function() {
        var obj = this[0];

        $.each($(obj).find("option"), function(i, n)
        {
            if (i == 0)
            {
                $(obj).val($(n).val());
                return $(this);
            }
        });
        return $(this);
    },
    stk_removeOptions:function(para1) {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");

        if(para1 != null && para1 != undefined)
        {
            if(typeof(para1) != typeof([]))
            {
                para1 = [para1];
            }
        }
        if (cn == "select")
        {
            for ( var i = 0; i < para1.length; i++ )
            {
               $(obj).find("option[value='"+para1[i]+"']").remove();
            }
        }
        else if(cn == "classifiedselect")
        {
            for ( var i = 0; i < para1.length; i++ )
            {
               $(obj).find("input[name!='classify'][value='"+para1[i]+"']").attr("checked",false);
               $(obj).find("input[name!='classify'][value='"+para1[i]+"']").parent().parent().parent().find("input[name='classify']").attr("checked",false);
            }
        }
        else if(cn == "letterselect")
        {
            for ( var i = 0; i < para1.length; i++ )
            {
               $(obj).find("input[name!='classify'][value='"+para1[i]+"']").attr("checked",false);
            }
        }
        else if(cn == "removableselect")
        {
            for ( var i = 0; i < para1.length; i++ )
            {
               $(obj).find("input[value='"+para1[i]+"']").parent().remove();
            }
        }
        else if(cn == "multiselect")
        {
            obj = $("#"+id+"_multiSelDiv");
            if(para1 != null && para1 != undefined)
            {
                for ( var i = 0; i < para1.length; i++ )
                {
                   $(obj).find("input[type='checkbox'][value='"+para1[i]+"']").parent().remove();
                }
            }
            else
                $(obj).find("input[type='checkbox']").parent().remove();
        }
        return $(this);
    },
    stk_removeSelected:function() {
        var obj = this[0];
        var result = $(obj).val();
        $(obj).find("option:selected").remove();
        return result;
    },
    stk_removeRow:function(id) {
        var obj = this[0];
        var result = $(obj).val();
        $(obj).find("tr[objid='"+id+"']").remove();
        return result;
    },
    stk_remove:function(){
        var obj = this[0];
        var id = $(obj ).attr("id");
        $.each( $( obj ).children(), function ( i, n )
        {
            $(n).stk_remove();
        } );
        $(obj).stk_removeEvent();
        if(id && $("#"+id+"_wrap" ).length > 0)
            $("#"+id+"_wrap" ).remove();
        else
            $(obj).remove();
    },
    stk_empty:function ()
    {
        var obj = this[0];
        var id = $(obj ).attr("id");
        $.each( $( obj ).children(), function ( i, n )
        {
            $( n ).stk_remove();
        } );
        if ( id && $( "#" + id + "_wrap" ).length > 0 )
            $( "#" + id + "_wrap" ).empty();
        else
            $( obj ).empty();
    },
    stk_removeEvent:function ()
    {
        var id = $( this[0] ).attr( "id" );
        if ( id )
        {
            var data = stk.eventMap.val;
            for ( var property in data )
            {
                var tmp = property.substring( 0, property.lastIndexOf( "_" ) );
                if ( tmp === id )
                {
                    stk.eventMap.val[property] = undefined;
                }
            }
        }
        return $(this);
    },
    stk_removeItem:function (value)
    {
        var obj = this[0];
        var id = $( obj ).attr( "id" );
        var name = $( obj ).attr( "name" );
        var wrap = $( "#" + id + "_wrap" );
        var cn = $( wrap ).attr( "cn" );
        if ( cn == "doubleselect" )
        {
            var org = $( obj ).stk_val();
            var tmp = [];
            for ( var i = 0; i < org.length; i++ )
            {
                if ( value != org[i] )
                {
                    tmp.push( org[i] )
                }
            }
            $( obj ).stk_val( tmp );
        }
    },
    stk_callInteract:function(callBack) {
        var obj = this[0];
        var id = $(obj).attr("id");
        window[id+"_callInteract"](callBack);
        return $(this);
    },
    stk_go:function(url,title,setting) {
        if (stk.isInFramework())
            window.parent.STK.go(url, title, $.extend({},setting,{parent:window}));
        else
            window.open(url, "_blank");
        return $(this);
    },
    stk_removeTab:function(url,title,setting) {
        if(stk.isInFramework())
            window.parent.STK.removeTab(url,title,setting);
    },

    stk_getTab:function(url,title,setting) {
        var tab;
        if(stk.isInFramework())
            tab = window.parent.STK.getTab(url,title,setting);
        return tab;
    },
    stk_removeSelf:function(refreshParent) {
        if(stk.isInFramework())
            window.parent.STK.removeSelf(window,refreshParent);
        else
            window.close();
    },
    stk_getParentTab:function ()
    {
        return window.parent.STK.getParentTab( window );
    },
    stk_navigate:function(url,title,setting) {
        if(stk.isInFramework())
        {
            this.stk_go(url, title, setting);
            this.stk_removeSelf();
            //window.parent.STK.navigate(url,title,window,setting);
        }
        else
        {
            window.open(url, "_self");
        }
    },
    stk_qtip:function(text,setting)
    {
        var obj = this[0];
        $(obj).hoverTipBox(text,setting);
        return $(this);
    },
    stk_closeQtip:function()
    {
        var obj = this[0];
        $(obj).hoverTipBox(false);
        return $(this);
    },
    stk_render:function(cn,param,callBack)
    {
        var obj = this[0];
        var id = $(this).attr("id");
        var name = $(this).attr("name");
        if(StringUtils.isNotBlank("id")) param.id = id;
        if(StringUtils.isNotBlank("name")) param.name = name;
        var url = __contextPath+"/framework/componentOut/";
        url += cn+".jsp";
        $.ajax({
           type: "POST",
           url: url,
           data: param,
           success: function(html){
               var start = html.indexOf("<body>")+6;
               var end = html.indexOf("</body>");
               html = html.substring(start,end);
               $(obj).attr("id",id+"_temp");
               $(obj).after(html);
               $(obj).remove();
               if(typeof(callBack) == 'function') callBack();
           }
        });
    },
    stk_detail:function(objid)
    {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if(cn == "table" || cn == "tablefix")
        {
            stk.table.showDetail(id,objid);
        }
        return $(this);
    },
    stk_hasData: function ()
    {
        var obj = this[0];
        var id = $( obj ).attr( "id" );
        var name = $( obj ).attr( "name" );
        var wrap = $( "#" + id + "_wrap" );
        var cn = $( wrap ).attr( "cn" );
        if ( cn == "table")
        {
            return $(obj ).find("tbody > tr" ).length > 0;
        }
        if ( cn == "tablefix" )
        {
            return $( "#"+id+"_Confix" ).find( "tbody > tr" ).length > 0;
        }
     },
    stk_strength: function ()
    {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        return $.passwordStrength.getPasswordStrength($(obj).val());
    },
    stk_checkStrength: function ()
    {
        var obj = this[0];
        $(obj).trigger("keyup");
        return $(this);
    },
    stk_flushCache:function()
    {
        var obj = this[0];
        var id = $(obj).attr("id");
        var name = $(obj).attr("name");
        var wrap = $("#" + id + "_wrap");
        var cn = $(wrap).attr("cn");
        if (cn == "autocomplete") {
            $(obj).flushCache();
        }
        return $(this);
    },
    stk_refreshHomeModule:function ( objid )
    {
        if ( stk.isInFramework() )
        {
            var home = parent.frames[0].document;
            $( home ).find( "li[objid='" + objid + "']" ).find( "b.refresh" ).click();
        }
        return $(this);
    },
    stk_showMenu: function (menuId, setting)
    {
        var obj = this[0];
        var menu = $('#' + menuId);
        menu.find("a").addClass("tip-extra-dd");
        $(obj).tipExtraCancel();
        if(setting)
            $(obj).tipExtra1({ html: menu.clone().show(), x: setting.x, y: setting.y});
        else
            $(obj).tipExtra1({ html: menu.clone().show()});
        return $(this);
    },
    stk_progress:function(precent, option)
    {
        var obj = this[0];
        var id = $(obj).attr("id");
        $("#"+id+"_bar").progressBar(precent, option);
        return $(this);
    },
    stk_float: function (option)
    {
        var obj = this[0];
        $(obj).powerFloat(option);
        return $(this);
    },
    stk_showMask:function()
    {
        STK.showMask();
        return $(this);
    },
    stk_closeMask:function()
    {
        STK.closeMask();
        return $(this);
    }
});