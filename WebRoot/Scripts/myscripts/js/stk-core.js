/**
 * 构造函数
 */
var stk={version:"20130913"};
/********************************************************************
 **                        0. 公共                                 **
 ********************************************************************/
stk.table_td_select_color="#c0d4f3";
stk.tree_link_select_color="#3399FF";
stk.dynamicCallBack = function(callBack)
{
    if(typeof(callBack) == 'function') callBack();
};
stk.setModuleLink = function(id,html)
{
    if(window.parent)
        window.parent.setModuleLink(id,html);
};
stk.stopSubmit = undefined;

stk.call = function(config)
{
    var className = config.className;
    var method = config.method;
    var async = true;
    if(config.async != undefined) async = config.async;
    if(!method) method = "call";
    if(!className)
    {
        stk.error("类名不可为空!");
    }
    var param = config.param;
    if(!param) param = {};
    var callBack = config.callBack;
    var exceptionHandler = config.exceptionHandler;
    SpiritFormAction.callSubmit(className, method, param, {
        callback:function(result) {
            if (jQuery.isFunction(callBack)) callBack(result);
        },
        exceptionHandler:function(message,e) {
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
                    stk.error( "error" )
                }
            }
        },
        async:async
    });
};
stk.changeTheme = function(name)
{
    SpiritCommonAction.changeTheme(name, {
        callback:function() {
            location.reload();
        }
    });
};

stk.isInFramework = function()
{
    function isCurrentInFramework(w)
    {
        if(!w) w = window;
        return w.parent != w && w.parent.STK != undefined && w.parent.STK['closeNav'] != undefined;
    }
    var isIn = false;
    try{
        isIn = isCurrentInFramework() || isCurrentInFramework(window.parent);
    }catch(e){
        isIn = false;
    }
    return isIn;
};

stk.logout = function()
{
    if(stk.isInFramework())
        window.parent.document.location = __contextPath+"/logout.jsp";
    else
        document.location = __contextPath+"/logout.jsp";
};

stk.login = function()
{
    if(stk.isInFramework())
        window.parent.document.location = __contextPath+"/login.jsp";
    else
        document.location = __contextPath+"/login.jsp";
};

stk.timeout = function()
{
    if(!window['__hasTimeout'])
    {
        window['__hasTimeout'] = true;
        alert('网页已过期，请重新登录！');
    }
    window['__hasTimeout'] = true;
    stk.logout();
};
stk.showMask = function ()
{
    STK.showMask();
};
stk.closeMask = function ()
{
    STK.closeMask();
};
/********************************************************************
 **                        1. table                                 **
 ********************************************************************/
stk.table = {};
stk.table.config = {};
stk.table.fitTable = function ( id )
{
    var body = $( 'body' ),
	documentHeight = document.documentElement.clientHeight,
            tableWrap = $( '#' + id + '_wrap' ),
            tableRightHeader = $( '#' + id + '_HT' ),
            tableLeft = tableWrap.find('.stk-fixed-left'),
	    tableRightTable = $( '#' + id + '_Con' ),
            tableRightCon = tableRightTable.parent(),
            tableBottomBar = $( '#' + id + '_pageInfo' ),
            tableTopbar = tableWrap.find( '.stk-ui-bar.stk-table-opt-bar:visible').eq(0),
            tableScrollY = tableRightCon.children( '.stk-scrollY' ),
            tableScrollYBar = tableScrollY.children( '.stk-scrollBar' ),
            tableScrollYScrLine = tableScrollYBar.children( '.scrLine' );
    var tableOffset = tableWrap.offset(),
    tableHeight = documentHeight - tableOffset.top,
    tableBottomBarHeight = tableBottomBar.outerHeight( true ),
    tableContentHeight = tableHeight - tableBottomBarHeight - tableTopbar.outerHeight( true ) - 4,
    tableRightHeaderHeight = tableRightHeader.outerHeight( true );
    tableWrap.height(tableHeight);
    tableRightCon.height(tableContentHeight - tableRightHeaderHeight);
    tableLeft.height(tableContentHeight);
    var fit = tableWrap.data( 'fit' );
    if ( !fit )
    {
        tableWrap.data( 'fit', true );
	tableScrollY.css( 'height', '100%');
        body.css( 'overflow-y', 'hidden' );
        document.documentElement.style.overflow = 'hidden';
        if($( '#' + id + '_HL' ).find('th').length==0){
            $('#'+id).css('padding-left','0' ).find(".stk-fixed-left" ).css("width","0");
        }
    }

    tableScrollYBar.css( 'height', tableScrollY.height() - 17);
    tableScrollYScrLine.css( 'height', tableRightTable.height());
};

stk.table.initEmptyBody = function(config)
{
    var tableConfig = config.tableConfig;
    var columnConfig = config.columnConfig;
    var id = tableConfig.id;

    if(stk.table.isFixTable(id))
    {
        if(jQuery.isFunction(window[id+'_beforetableinit'])) window[id+'_beforetableinit']();
        window['_'+id+"_grid"] = new STK.fixedGrid({
            headTopId : id+'_HT',
            headLeftId : id+'_ConFix',
            conBoxId : id+'_Con',
            scrollXId : id+'_scrollX',
            scrollYId : id+'_scrollY',
            hoverCss : 'hover'
        });
        if ( $( "#" + id + "_HL" ).find( 'th' ).length == 0 )
        {
            $( '#' + id ).css( 'padding-left', '0' ).find( ".stk-fixed-left" ).css( "width", "0" );
        }
        if(StringUtils.isBlank(tableConfig.height))
        {
            $("#"+id ).stk_adjust();
            $( window ).resize( function ()
            {
                $("#"+id ).stk_adjust();
            } );
        }
        if(jQuery.isFunction(window[id+'_aftertableinit'])) window[id+'_aftertableinit']();
    }

    var pageSize = tableConfig.pageSize;
    if(StringUtils.isNotBlank(pageSize))
    {
        pageSize = new Number(pageSize);
    }
    else
    {
        pageSize = 0;
    }
    if(stk.table.isFixTable(id))
    {
        if($("#"+id+"_HL").find("tr > th[group]").length + $("#"+id+"_HT").find("tr > th[group]").length > 0)
        {
            var groupHtml = [];
            groupHtml.push("<tr class='stk_table_groupTitle' type='group'>");
            var count = 0;
            var name = "&nbsp;";
            $.each($("#"+id+"_HL").find("tr > th"), function( i, n )
            {
                var size = $("#"+id+"_HL").find("tr > th").length;
                var tmp = $(n).attr("group");
                if(StringUtils.isBlank(tmp)) tmp = "&nbsp";

                if(count == 0)
                {
                    name = tmp;
                    count = 1;
                }
                else
                {
                    if(tmp == name) count++;
                    else{
                        groupHtml.push("<th class='stk-table-th' style='background-image:none;' _group='1' groupName='"+name+"' colspan='"+count+"'>" + name + "</th>");
                        name = tmp;
                        count = 1;
                    }
                }
                if(size == (i+1))
                {
                    groupHtml.push("<th class='stk-table-th' style='background-image:none;' _group='1' groupName='"+name+"' colspan='"+count+"'>" + name + "</th>");
                }
            });

            if ( $( "#" + id + "_HL" ).find( "tr > th[groupTop]" ).length + $( "#" + id + "_HT" ).find( "tr > th[groupTop]" ).length > 0 )
            {
                var groupTopHtml = [];
                groupTopHtml.push( "<tr class='stk_table_groupTitle' type='groupTop'>" );
                var count = 0;
                var name = "&nbsp;";
                $.each( $( "#" + id + "_HL" ).find( "tr > th" ), function ( i, n )
                {
                    var size = $( "#" + id + "_HL" ).find( "tr > th" ).length;
                    var tmp = $( n ).attr( "groupTop" );
                    if ( StringUtils.isBlank( tmp ) )
                    {
                        tmp = "&nbsp";
                    }

                    if ( count == 0 )
                    {
                        name = tmp;
                        count = 1;
                    }
                    else
                    {
                        if ( tmp == name )
                        {
                            count++;
                        }
                        else
                        {
                            groupTopHtml.push( "<th class='stk-table-th' style='background-image:none;' _groupTop='1' groupTopName='" + name + "' colspan='" + count + "'>" + name + "</th>" );
                            name = tmp;
                            count = 1;
                        }
                    }
                    if ( size == (i + 1) )
                    {
                        groupTopHtml.push( "<th class='stk-table-th' style='background-image:none;' _groupTop='1' groupTopName='" + name + "' colspan='" + count + "'>" + name + "</th>" );
                    }
                } );
            }
            groupHtml.push("</tr>");
            $("#"+id+"_HL").find("tr > th").removeClass("stk-table-th").addClass("stk-table-th-nor stk-table-th-bdline");
            $("#"+id+"_HL").prepend(groupHtml.join("\n"));
            if ( $( "#" + id + "_HL" ).find( "tr > th[groupTop]" ).length + $( "#" + id + "_HT" ).find( "tr > th[groupTop]" ).length > 0 )
            {
                groupTopHtml.push( "</tr>" );
                $("#"+id+"_HL").find("tr > th[_group]").removeClass("stk-table-th").addClass("stk-table-thtop");
                $("#"+id+"_HL").prepend(groupTopHtml.join("\n"));
                $( "<tr>" ).append( $( "#" + id + "_HL" ).find( "th[_group!='1'][_groupTop!='1']" ).clone().css( "height", "0" ).removeClass().addClass("stk-table-th-nor stk-table-th-bdline").html( "" ) ).prependTo( $( "#" + id + "_HL" ) ).removeClass().attr( "fake", "1" ).css( "height", "0" );

            }
            else
            {
                $( "<tr>" ).append( $( "#" + id + "_HL" ).find( "th[_group!='1']" ).clone().css( "height", "0" ).removeClass().addClass("stk-table-th-nor stk-table-th-bdline").html( "" ) ).prependTo( $( "#" + id + "_HL" ) ).removeClass().attr( "fake", "1" ).css( "height", "0" );
            }

            groupHtml = [];
            groupHtml.push("<tr class='stk_table_groupTitle' type='group'>");
            count = 0;
            name = "&nbsp;";
            $.each($("#"+id+"_HT").find("tr > th"), function( i, n )
            {
                var size = $("#"+id+"_HT").find("tr > th").length;
                var tmp = $(n).attr("group");
                if(StringUtils.isBlank(tmp)) tmp = "&nbsp";

                if(count == 0)
                {
                    name = tmp;
                    count = 1;
                }
                else
                {
                    if(tmp == name) count++;
                    else{
                        groupHtml.push("<th class='stk-table-th' style='background-image:none;' _group='1' groupName='"+name+"' colspan='"+count+"'>" + name + "</th>");
                        name = tmp;
                        count = 1;
                    }
                }
                if(size == (i+1))
                {
                    groupHtml.push("<th class='stk-table-th' style='background-image:none;' _group='1' groupName='"+name+"' colspan='"+count+"'>" + name + "</th>");
                }
            });

            if ( $( "#" + id + "_HL" ).find( "tr > th[groupTop]" ).length + $( "#" + id + "_HT" ).find( "tr > th[groupTop]" ).length > 0 )
            {
                groupTopHtml = [];
                groupTopHtml.push( "<tr class='stk_table_groupTitle' type='groupTop'>" );
                count = 0;
                name = "&nbsp;";
                $.each( $( "#" + id + "_HT" ).find( "tr > th" ), function ( i, n )
                {
                    var size = $( "#" + id + "_HT" ).find( "tr > th" ).length;
                    var tmp = $( n ).attr( "groupTop" );
                    if ( StringUtils.isBlank( tmp ) )
                    {
                        tmp = "&nbsp";
                    }

                    if ( count == 0 )
                    {
                        name = tmp;
                        count = 1;
                    }
                    else
                    {
                        if ( tmp == name )
                        {
                            count++;
                        }
                        else
                        {
                            groupTopHtml.push( "<th class='stk-table-th' style='background-image:none;' _groupTop='1' groupTopName='" + name + "' colspan='" + count + "'>" + name + "</th>" );
                            name = tmp;
                            count = 1;
                        }
                    }
                    if ( size == (i + 1) )
                    {
                        groupTopHtml.push( "<th class='stk-table-th' style='background-image:none;' _groupTop='1' groupTopName='" + name + "' colspan='" + count + "'>" + name + "</th>" );
                    }
                } );
            }
            groupHtml.push("</tr>");
            $("#"+id+"_HT").find("tr > th").removeClass("stk-table-th").addClass("stk-table-th-nor stk-table-th-bdline");
            $("#"+id+"_HT").prepend(groupHtml.join("\n"));
            if ( $( "#" + id + "_HL" ).find( "tr > th[groupTop]" ).length + $( "#" + id + "_HT" ).find( "tr > th[groupTop]" ).length > 0)
            {
                groupTopHtml.push( "</tr>" );
                $("#"+id+"_HT").find("tr > th[_group]").removeClass("stk-table-th").addClass("stk-table-thtop");
                $("#"+id+"_HT").prepend(groupTopHtml.join("\n"));
                $( "<tr>" ).append( $( "#" + id + "_HT" ).find( "th[_group!='1'][_groupTop!='1']" ).clone().css( "height", "0" ).removeClass().addClass("stk-table-th-nor stk-table-th-bdline").html( "" ) ).prependTo( $( "#" + id + "_HT" ) ).removeClass().attr( "fake", "1" ).css( "height", "0" );
            }
            else
            {
                $( "<tr>" ).append( $( "#" + id + "_HT" ).find( "th[_group!='1']" ).clone().css( "height", "0" ).removeClass().addClass("stk-table-th-nor stk-table-th-bdline").html( "" ) ).prependTo( $( "#" + id + "_HT" ) ).removeClass().attr( "fake", "1" ).css( "height", "0" );
            }
        }
    }
    else
    {
        if($("#"+id).find("thead > tr > th[group]").length > 0)
        {
            var groupHtml = [];
            groupHtml.push("<tr class='stk_table_groupTitle' type='group'>");
            var count = 0;
            var name = "&nbsp;";
            $.each($("#"+id).find("thead > tr > th"), function( i, n )
            {
                var size = $("#"+id).find("thead > tr > th").length;
                var tmp = $(n).attr("group");
                if(StringUtils.isBlank(tmp)) tmp = "&nbsp";

                if(count == 0)
                {
                    name = tmp;
                    count = 1;
                }
                else
                {
                    if(tmp == name) count++;
                    else{
                        groupHtml.push("<th class='stk-table-th' style='background-image:none;' _group='1' groupName='"+name+"' colspan='"+count+"'>" + name + "</th>");
                        name = tmp;
                        count = 1;
                    }
                }
                if(size == (i+1))
                {
                    groupHtml.push("<th class='stk-table-th' style='background-image:none;' _group='1' groupName='"+name+"' colspan='"+count+"'>" + name + "</th>");
                }
            });

            if ( $( "#" + id ).find( "thead > tr > th[groupTop]" ).length > 0 )
            {
                var groupTopHtml = [];
                groupTopHtml.push( "<tr class='stk_table_groupTitle' type='groupTop'>" );
                var count = 0;
                var name = "&nbsp;";
                $.each( $( "#" + id ).find( "thead > tr > th" ), function ( i, n )
                {
                    var size = $( "#" + id ).find( "thead > tr > th" ).length;
                    var tmp = $( n ).attr( "groupTop" );
                    if ( StringUtils.isBlank( tmp ) )
                    {
                        tmp = "&nbsp";
                    }

                    if ( count == 0 )
                    {
                        name = tmp;
                        count = 1;
                    }
                    else
                    {
                        if ( tmp == name )
                        {
                            count++;
                        }
                        else
                        {
                            groupTopHtml.push( "<th class='stk-table-th' style='background-image:none;' _groupTop='1' groupTopName='" + name + "' colspan='" + count + "'>" + name + "</th>" );
                            name = tmp;
                            count = 1;
                        }
                    }
                    if ( size == (i + 1) )
                    {
                        groupTopHtml.push( "<th class='stk-table-th' style='background-image:none;' _groupTop='1' groupTopName='" + name + "' colspan='" + count + "'>" + name + "</th>" );
                    }
                } );
            }

            groupHtml.push( "</tr>" );
            $( "#" + id ).find( "thead > tr > th" ).removeClass( "stk-table-th" ).addClass( "stk-table-th-nor stk-table-th-bdline" );
            $( "#" + id ).find( "thead" ).prepend( groupHtml.join( "\n" ) );
            if ( $( "#" + id ).find( "thead > tr > th[groupTop]" ).length > 0 )
            {
                groupTopHtml.push( "</tr>" );
                $( "#" + id ).find( "thead > tr > th[_group]" ).removeClass( "stk-table-th" ).addClass( "stk-table-thtop" );
                $( "#" + id ).find( "thead" ).prepend( groupTopHtml.join( "\n" ) );
                $( "<tr>" ).append( $( "#" + id ).find( "thead th[_groupTop!='1'][_group!='1']" ).clone().css( "height", "0" ).removeClass().addClass("stk-table-th-nor stk-table-th-bdline").html( "" ) ).prependTo( $( "#" + id ).find( "thead" ) ).removeClass().attr( "fake", "1" ).css( "height", "0" );
            }
            else
            {
                $( "<tr>" ).append( $( "#" + id ).find( "thead th[_group!='1']" ).clone().css( "height", "0" ).removeClass().addClass("stk-table-th-nor stk-table-th-bdline").html( "" ) ).prependTo( $( "#" + id ).find( "thead" ) ).removeClass().attr( "fake", "1" ).css( "height", "0" );
            }
        }
    }

    if(tableConfig.allowBlankRow == "true")
    {
        var html = [];
        var height = tableConfig.rowHeight;
        if(stk.table.isFixTable(id))
        {
            for(var i = 0; i < pageSize; i++)
            {
                html.push("<tr height='"+height+"'>");
                for(var j = 0; j < columnConfig.length; j++)
                {
                    if(columnConfig[j].fixed == "true")
                    {
                        html.push("<td width='"+columnConfig[j].width+"' property='"+columnConfig[j].property+"' colNum='"+columnConfig[j].colNum+"' class='stk-table-tdline'>&nbsp</td>");
                    }
                }
                html.push("</tr>");
            }
            $("#" + id+"_ConFix").find("tbody").html(html.join("\n"));

            html = [];
            for(var i = 0; i < pageSize; i++)
            {
                html.push("<tr height='"+height+"'>");
                for(var j = 0; j < columnConfig.length; j++)
                {
                    if(columnConfig[j].fixed != "true")
                    {
                        html.push("<td width='"+columnConfig[j].width+"' property='"+columnConfig[j].property+"' colNum='"+columnConfig[j].colNum+"' class='stk-table-tdline'>&nbsp</td>");
                    }
                }
                html.push("</tr>");
            }
            $("#" + id+"_Con").find("tbody").html(html.join("\n"));
        }
        else
        {
            for(var i = 0; i < pageSize; i++)
            {
                html.push("<tr height='"+height+"'>");
                for(var j = 0; j < columnConfig.length; j++)
                {
                    var width = columnConfig[j].width;
                    html.push("<td width='"+columnConfig[j].width+"' property='"+columnConfig[j].property+"' colNum='"+columnConfig[j].colNum+"' class='stk-table-tdline' width='"+width+"'>&nbsp</td>");
                }
                html.push("</tr>");
            }
            $("#" + id).find("tbody").html(html.join("\n"));
        }
    }
    //初始化帮助信息
    $(document ).ready(function(){
        $.each( $( "#" + id + "_wrap" ).find( ".icon-help" ), function ( i, n ){
            $( n ).stktip( $( n ).attr( "helpContent" ), 500 );
        });
    });
    stk.table.adjustScroll(id);
};
stk.table.getCollecConfig = function(id)
{
    var collectConfig = null;
    if(stk.table.isFixTable(id))
    {
        $.each($("#"+id+"_HT").find("tr[type!='group'][fake!='1'] > th[collect][property]"), function( i, n )
        {
            if(collectConfig == null) collectConfig = {};
            collectConfig[$(n).attr("property") + "__" + $(n).attr("colNum")] = $(n).attr("collect");
        });
        $.each($("#"+id+"_HL").find("tr[type!='group'][fake!='1'] > th[collect][property]"), function( i, n )
        {
            if ( collectConfig == null ) collectConfig = {};
            collectConfig[$( n ).attr( "property" ) + "__" + $( n ).attr( "colNum" )] = $( n ).attr( "collect" );
        } );
    }
    else
    {
        $.each($("#"+id).find("thead > tr[type!='group'][fake!='1'] > th[collect][property]"), function( i, n )
        {
            if(collectConfig == null) collectConfig = {};
            collectConfig[$(n).attr("property") + "__" + $(n).attr("colNum")] = $(n).attr("collect");
        });
    }
    return collectConfig;
};
stk.table.getTableConfig = function(id)
{
    $("#"+id+"_HL").find("tr").append($("#"+id+"_HT").find("th[fixed='true']"));
    var obj = $("#"+id+"_wrap");
    return {
        id:id,
        cn:$(obj).attr("cn"),
        type:$(obj).attr("type"),
        mode:$(obj).attr("mode"),
        pageSize:$(obj).attr("pageSize"),
        actionClass:$(obj).attr("actionClass"),
        width:$(obj).attr("_width"),
        height:$(obj).attr("_height"),
        tableWidth:$(obj).attr("tableWidth"),
        rowHeight:$(obj).attr("rowHeight"),
        allowInit:$(obj).attr("allowInit"),
        personal:$(obj).attr("personal"),
        allowDetail:$(obj).attr("allowDetail"),
        allowDuplicate:$(obj).attr("allowDuplicate"),
        allowColumnOrd:$(obj).attr("allowColumnOrd"),
        allowExport:$(obj).attr("allowExport"),
        exportOption:$(obj).attr("exportOption"),
        extraOrderBy:$(obj).attr("extraOrderBy"),
        title:$(obj).attr("title"),
        sortType:$(obj).attr("sortType"),
        pageInfoType:$(obj).attr("pageInfoType"),
        allowBlankRow:$(obj).attr("allowBlankRow"),
        blankText:$(obj).attr("blankText"),
        allowConfigPageSize:$(obj).attr("allowConfigPageSize"),
        exportFileName:$(obj).attr("exportFileName"),
        exportMaxRow:$(obj).attr("exportMaxRow"),
        queryForm:$(obj).attr("queryForm"),
        adjustRow:$(obj).attr("adjustRow"),
        subList:$(obj).attr("subList"),
        faster:$(obj).attr("faster"),
        nulls:$(obj).attr("nulls"),
        nullsFixed:$(obj).attr("nullsFixed")
    };
};

stk.table.getColumnInfo = function(n)
{
    var plugin = $(n).attr("plugin");
    var pluginObj = "";
    var pluginType = "";
    var pluginParam = "";
    var pluginParam2 = "";
    var pluginParam3 = "";
    if (StringUtils.isNotBlank(plugin)) {
        var plugins = plugin.split(",");
        for (var i = 0; i < plugins.length; i++) {
            pluginObj = $("#" + plugins[i]);
            pluginType += $(pluginObj).attr("type") + ",";
            pluginParam += $(pluginObj).attr("pluginParam") + ",";
            pluginParam2 += $(pluginObj).attr("pluginParam2") + ",";
            pluginParam3 += $(pluginObj).attr("pluginParam3") + ",";
        }
    }
    return {
        tableId:$(n).attr("tableId"),
        colType:$(n).attr("colType"),
        property:$(n).attr("property"),
        expr:$(n).find("div[type='express']").html(),
        width:$(n).attr("width"),
        xlsColWidth:$(n).attr("xlsColWidth"),
        height:$(n).attr("height"),
        align:$(n).attr("_align"),
        valign:$(n).attr("_valign"),
        allowSort:$(n).attr("allowSort"),
        allowExport:$(n).attr("allowExport"),
        allowDetail:$(n).attr("allowDetail"),
        maxWords:$(n).attr("maxWords"),
        fixed:$(n).attr("fixed"),
        filter:$(n).attr("filter"),
        collect:$(n).attr("collect"),
        show:$(n).attr("show"),
        title:$(n).attr("_title"),
        pointPlace:$(n).attr("pointPlace"),
        afterText:$(n).attr("afterText"),
        beforeText:$(n).attr("beforeText"),
        isMoney:$(n).attr("isMoney"),
        format:$(n).attr("format"),
        entityName:$(n).attr("entityName"),
        foreignProperty:$(n).attr("foreignProperty"),
        tableName:$(n).attr("tableName"),
        columnName:$(n).attr("columnName"),
        group:$(n).attr("group"),
        groupTop:$(n).attr("groupTop"),
        clazz:$(n).attr("clazz"),
        method:$(n).attr("_method"),
        nowrap:$(n).attr("_nowrap"),
        allowTip:$(n).attr("allowTip"),
        colNum:$(n).attr("colNum"),
        helpContent:$(n).attr("helpContent"),
        mergeCol:$(n).attr("mergeCol"),
        plugin:plugin,
        pluginType:pluginType,
        pluginParam:pluginParam,
        pluginParam2:pluginParam2,
        pluginParam3:pluginParam3,
        nulls:$(n).attr("nulls"),
        nullsFixed:$(n).attr("nullsFixed"),
        schema:$(n).attr("schema")
    };
}
stk.table.isFixTable = function(id)
{
    var cn = $("#"+id+"_wrap").attr("cn");
    return cn == "tablefix";
}
stk.table.getColumnConfig = function(id)
{
    var array = [], obj;
    if(stk.table.isFixTable(id))
    {
        obj = $("#"+id+"_HL").find("th");
        $.each(obj, function( i, n )
        {
            array.push(stk.table.getColumnInfo(n));
        });

        obj = $("#"+id+"_HT").find("th");
        $.each(obj, function( i, n )
        {
            array.push(stk.table.getColumnInfo(n));
        });
    }
    else
    {
        obj = $("#"+id).find("thead > tr[fake!='1'] > th");
        $.each(obj, function( i, n )
        {
            array.push(stk.table.getColumnInfo(n));
        });
    }
    return array;
};

stk.table.getQueryForm = function(config,options)
{
    var tableConfig = config.tableConfig;
    var queryForm = tableConfig.queryForm;
    if(StringUtils.isNotBlank(queryForm))
    {
        if(queryForm.indexOf(",") > -1)
        {
            var result = {};
            var forms = queryForm.split(",");
            for(var i = 0; i < forms.length; i++)
            {
                var _queryForm = forms[i];
                if($("#"+queryForm).length > 0) {
                    var data = stk.form.getParameters(_queryForm,options);
                    for ( var property in data )
                    {
                        var key = property;
                        var value = data[property];
                        result[key] = value;
                    }
                }
            }
            return result;
        }
        else
        {
            if($("#"+queryForm).length == 0) {
                stk.alert("queryForm:"+queryForm +"不存在");
                return {};
            }
            else
            {
                return stk.form.getParameters(queryForm,options);
            }
        }
    }
    else
        return {};
}

stk.table.getOrderBy = function(id)
{
    var config = window["_"+id];
    var sortObj = config.orderOrd;
    var columnInfo = config.orderColumnInfo;
    var tmp = [];
    for (var key in sortObj)
    {
        if(sortObj[key] != undefined)
        {
            var num = sortObj[key].split("_")[1];
            var sort = sortObj[key].split("_")[0];
            if(num!=undefined && sort != undefined)
                tmp[new Number(num)] = (columnInfo && columnInfo.schema ? columnInfo.schema + '.':'') + key + " " +sort;
        }
    }
    var sortInfo = "";
    for(var i = 0; i < tmp.length; i++)
    {
        sortInfo += tmp[i];
        if(tmp.length != (i+1)) sortInfo += ",";
    }
    return {
        sortInfo: sortInfo,
        columnInfo: columnInfo
    };
};
stk.table.setSort = function(td,callBack)
{
    var property = $(td).attr("property");
    var type = $(td).attr("sortType");
    if(type == 'normal'){
        $(td).parent().find("th[property!='"+property+"']").removeAttr("orderType").find("b[type='sortIcon']").remove();
    }

    if(property)
    {
        $(td).find("b[type='sortIcon']").remove();
        var orderType = $(td).attr("orderType");
        var ci = stk.table.getColumnInfo(td);
        if(StringUtils.isBlank(orderType))
        {
            $(td).attr("orderType","asc");
            $(td).find("div[name='textWrap']").append("<b type='sortIcon' class='stk-ui-sort-asc'></b>");
            if(typeof(callBack) == "function") callBack(type,property,"asc",ci);
        }
        else if(orderType == "asc")
        {
            $(td).attr("orderType","desc");
            $(td).find("div[name='textWrap']").append("<b type='sortIcon' class='stk-ui-sort-desc'></b>");
            if(typeof(callBack) == "function") callBack(type,property,"desc",ci);
        }
        else
        {
            $(td).removeAttr("orderType");
            if(typeof(callBack) == "function") callBack(type,property,undefined,ci);
        }
    }
};

stk.table.init = function(config,callBack)
{
    var tableConfig = config.tableConfig;
    var columnConfig = config.columnConfig;

    var id = tableConfig.id;
    SpiritTableAction.init(tableConfig, columnConfig, 1,{},null, {
        callback:function(result)
        {
            stk.table.genTable(config, result,callBack);
        },
        exceptionHandler: function (message, e)
        {
            if (message)
            {
                stk.error("error：" + message);
            }
            else if (e && e.cause && e.cause.message)
            {
                stk.error("error：" + e.cause.message);
            }
            else
            {
                stk.error("error")
            }
        }
    });
};

stk.table.query = function(config,callBack)
{
    var tableConfig = config.tableConfig;
    var columnConfig = config.columnConfig;
    var id = tableConfig.id;
    SpiritTableAction.init(tableConfig, columnConfig, 1, stk.table.getQueryForm(config), stk.table.getOrderBy(id), {
        callback : function (result)
        {
            stk.table.genTable(config, result, callBack);
        },
        exceptionHandler: function (message,e)
        {
            if (message)
            {
                stk.error("error：" + message);
            }
            else if (e && e.cause && e.cause.message)
            {
                stk.error("error：" + e.cause.message);
            }
            else
            {
                stk.error("error")
            }
        }
    });
};

stk.table.jump = function(config,targetPage,callBack)
{

    var tableConfig = config.tableConfig;
    var columnConfig = config.columnConfig;
    if(StringUtils.isBlank(""+targetPage))
    {
        var pageInfo = config.pageInfo;
        if(pageInfo == undefined) targetPage = "1";
        else
        {
            targetPage = pageInfo.targetPage;
        }
        if(StringUtils.isBlank(targetPage)) targetPage = "1";
    }
    var id = tableConfig.id;
    SpiritTableAction.init(tableConfig, columnConfig, targetPage, stk.table.getQueryForm(config),stk.table.getOrderBy(id), {
        callback:function(result)
        {
            stk.table.genTable(config, result,callBack);
        },
        exceptionHandler:function(msg)
        {
            stk.alert("error："+msg);
        }
    });
};
stk.table.genTable = function(config,result, callBack)
{
    var tableConfig = config.tableConfig;
    var columnConfig = config.columnConfig;
    var id = tableConfig.id;
    var data = result.data;
    var html = result.html;
    var htmlleft = result.htmlleft;
    var pageInfo = result.pageInfo;

    if (data != null)
    {
        if(stk.table.isFixTable(id))
        {
            var collectConfig = stk.table.getCollecConfig(id);
            $("#" + id+"_ConFix").find("tbody").empty();
            if(tableConfig.faster == "true")
            {
                stk.table.fixLazyLoad(id,$("#" + id+"_ConFix"),$("#" + id+"_Con"),result.dataLeftArray,result.dataArray);
            }
            else
            {
                if ($(htmlleft).find("td").length > 0) $("#" + id + "_ConFix").find("tbody").html(htmlleft);
                $("#" + id + "_Con").find("tbody").html(html);
            }
            window['_'+id+"_grid"].fixedGridRefresh();
        }
        else
        {
            if (tableConfig.faster == "true")
            {
                stk.table.lazyLoad($("#" + id), result.dataArray);

            } else
            {
                $("#" + id).find("tbody").html(html);
            }
        }
        stk.table.genPageInfo(config, pageInfo);
        stk.table.setColShow(id);
        if (callBack != null) callBack(result);
    }
    $("#"+id+"_wrap").find("div[name='__wait']").hide();
};
stk.table.lazyLoad = function(table,data,start,end)
{
    if(!data) return;
    if (start >= data.length) return;
    if(start)
    {
        setTimeout(function ()
        {
            var subData = data.slice(start, end).join("\n");
            $(table).append(subData);
            start = end;
            if (data.length >= (start+20))
                stk.table.lazyLoad(table, data, start, start+20);
            else
            {
                stk.table.lazyLoad(table, data, start, data.length);
            }
        }, 200);
    }
    else
    {
        if (data.length <= 50) $(table).append(data.join("\n"));
        else
        {
            $(table).html(data.slice(0,50).join("\n"));
            if(data.length >= 70)
                stk.table.lazyLoad(table,data,50,70);
            else
            {
                stk.table.lazyLoad(table,data,50,data.length);
            }
        }
    }
}

stk.table.fixLazyLoad = function(id,tablefix,table,datafix,data,start,end)
{
    if(!data) return;
    if (start >= data.length) return;
    if(start)
    {
        setTimeout(function ()
        {
            var subDataFix = datafix.slice(start, end).join("\n");
            var subData = data.slice(start, end).join("\n");
            $(tablefix).append(subDataFix);
            $(table).append(subData);
            start = end;
            if (data.length >= (start+20))
                stk.table.fixLazyLoad(id,tablefix,table,datafix,data, start,start+20);
            else
            {
                stk.table.fixLazyLoad(id,tablefix,table,datafix,data, start, data.length);
                window['_'+id+"_grid"].fixedGridRefresh();
            }
        }, 200);
    }
    else
    {
        if (data.length <= 50) {
            $(tablefix).html(datafix.join("\n"));
            $(table).html(data.join("\n"));
            window['_'+id+"_grid"].fixedGridRefresh();
        }
        else
        {
            $(table).html(data.slice(0,50).join("\n"));
            $(tablefix).html(datafix.slice(0,50).join("\n"));
            if(data.length >= 70)
            {
                stk.table.fixLazyLoad(id,tablefix,table,datafix,data,50,70);
            }
            else
            {
                stk.table.fixLazyLoad(id,tablefix,table,datafix,data,50,data.length);
                window['_'+id+"_grid"].fixedGridRefresh();
            }
        }
    }
}
stk.table.genTableCollect = function(config,callBack)
{
    var tableConfig = config.tableConfig;
    var columnConfig = config.columnConfig;
    var id = tableConfig.id;
    var collectConfig = stk.table.getCollecConfig(id);
    if(collectConfig != null)
    {
        SpiritTableAction.initCollect(tableConfig, columnConfig,collectConfig,stk.table.getQueryForm(config),{
            callback:function(result)
            {
                var resultHtml = result.html;
                var height = tableConfig.rowHeight;
                var count = 0;
                for ( var key in resultHtml )
                {
                    var html = [];
                    html.push("<tr height='"+height+"'>");
                    count++;
                    for(var j = 0; j < columnConfig.length; j++)
                    {
                        if(columnConfig[j].fixed == "true") continue;
                        var width = columnConfig[j].width;
                        var hasFind = false;
                        for(var k = 0; k < resultHtml[key].length; k++)
                        {
                            var colNum = resultHtml[key][k].colNum;
                            if(j == colNum)
                            {
                                hasFind = true;
                                html.push(resultHtml[key][k].html);
                            }
                        }
                        if(!hasFind)
                            html.push("<td colNum='"+columnConfig[j].colNum+"' class='stk-table-td' width='"+width+"'>&nbsp</td>");
                    }
                    html.push("</tr>");
                    if(stk.table.isFixTable(id))
                    {
                        var htmlleft = [];
                        for(var i  = 0; i < count; i++)
                        {
                            htmlleft.push("<tr height='"+height+"'>");
                            for(var j = 0; j < columnConfig.length; j++)
                            {
                                if(columnConfig[j].fixed == "true"){
                                    htmlleft.push("<td property='"+columnConfig[j].property+"' colNum='"+columnConfig[j].colNum+"' class='stk-table-tdline'>&nbsp</td>");}
                            }
                            htmlleft.push("</tr>");
                        }
                        htmlleft.push("</tr>");
                        $("#"+id+"_Con").find("tbody").append(html.join("\n"));
                        $("#"+id+"_ConFix").find("tbody").append(htmlleft.join("\n"));
                    }
                    else
                    {
                        $("#"+id).find("tbody").append(html.join("\n"));
                    }
                    stk.table.adjustScroll(id);
                }
                if (callBack != null) callBack(result);
            },
            exceptionHandler:function(msg)
            {
                stk.alert("error："+msg);
            }
        });
    }
};
stk.table.beforeInit = function(config,loadCache)
{
    var columnConfig = config.columnConfig;
    var tableConfig = config.tableConfig;
    var tableData = config.data;
    var id = tableConfig.id;
    if(jQuery.isFunction(window[id+'_beforetablequery'])) window[id+'_beforetablequery']();
    $.each(columnConfig, function( i, n )
    {

        if(StringUtils.isNotBlank(n.pluginType))
        {
            var plugins = n.plugin.split(",");
            var plugintypes = n.pluginType.split(",");
            var pluginParams = n.pluginParam.split(",");
            var pluginParams2 = n.pluginParam2.split(",");
            var pluginParams3 = n.pluginParam3.split(",");
            for(var i = 0; i < plugins.length; i++)
            {
                if(plugintypes[i]=='checkbox')
                {
                    if(loadCache && pluginParams3[i] == "true")
                        stk.cache.pluginCheckbox.func.read(tableData,pluginParams[i]);
                    else
                        delete stk.cache.pluginCheckbox[pluginParams[i]];
                }
            }
        }
    });
};
stk.table.adjustRow = function(config)
{
    var tableConfig = config.tableConfig;
    var id = tableConfig.id;
    var grid = $('#'+id+'_grid');
    var rightTableTr = grid.find('div.stk-fixed-left table>tbody>tr');
    grid.find('div.stk-fixed-right table>tbody>tr').each(function(i,el){
       var rightHeight = rightTableTr[i].offsetHeight;
       var leftHeight = el.offsetHeight;
       if(rightHeight != leftHeight){
          if(leftHeight > rightHeight){
             rightTableTr[i].style.height = leftHeight + 'px';
          } else {
             el.style.height = rightHeight + 'px';
          }
       }
    });
};
stk.table.afterInit = function(config,loadCache)
{
    var columnConfig = config.columnConfig;
    var tableConfig = config.tableConfig;
    var tableData = config.data;
    var id = tableConfig.id;
    if(tableConfig.adjustRow=='true')
    {
        stk.table.adjustRow(config);
    }
    if(jQuery.isFunction(window[id+'_aftertablequery'])) window[id+'_aftertablequery'](window['_'+id].data);
    $.each(columnConfig, function( i, n )
    {

        if(StringUtils.isNotBlank(n.pluginType))
        {
            var plugins = n.plugin.split(",");
            var plugintypes = n.pluginType.split(",");
            var pluginParams = n.pluginParam.split(",");
            var pluginParams2 = n.pluginParam2.split(",");

            for(var i = 0; i < plugins.length; i++)
            {
                if(plugintypes[i]=='checkbox' && pluginParams2[i] == "true")
                {
                    if(stk.table.isFixTable(id))
                    {
                        if($("#"+n.tableId+"_HL").find("tr[type!='group'][type!='groupTop'][fake!='1'] > th" ).length == 0)
                        {
                            $("#"+n.tableId+"_HT").find("tr[type!='group'][type!='groupTop'][fake!='1'] > th").eq(i).html("<input type='checkbox' id='"+pluginParams[i]+"_all'>");
                        }
                        $("#"+n.tableId+"_HL").find("tr[type!='group'][type!='groupTop'][fake!='1'] > th").eq(i).html("<input type='checkbox' id='"+pluginParams[i]+"_all'>");
                    }
                    else{
                        $("#"+n.tableId).find("thead > tr[type!='group'][type!='groupTop'][fake!='1'] > th").eq(i).html("<input type='checkbox' id='"+pluginParams[i]+"_all'>");
                    }
                    stk.checkBox.buildSelectAll(pluginParams[i]+"_all",pluginParams[i]);
                }
                if(plugintypes[i]=='checkbox' && loadCache)
                {
                    stk.cache.pluginCheckbox.func.write(tableData,pluginParams[i]);
                    if($("input[type='checkbox'][name='"+pluginParams[i]+"']").length == $("input[type='checkbox'][name='"+pluginParams[i]+"']:checked").length)
                        $("#"+pluginParams[i]+"_all").stk_checked(true);
                    else
                        $("#"+pluginParams[i]+"_all").stk_checked(false);
                }
            }
        }
    });
    $.each($("#"+id).find("tbody").find("button"), function( i, n )
    {
        if($(n).attr("class").indexOf("stk-button") < 0)
        {
            var text = $(n).text();
            $(n).html("");
            $(n).addClass("stk-button stk-button-st-3");
            if(StringUtils.isNotBlank($(n).attr("icon")))
            {
                $(n).append("<span class='stk-button-icon "+$(n).attr("icon")+"'></span>");
            }
            if(StringUtils.isNotBlank(text))
            {
                $(n).append("<span>"+text+"</span>");
            }
        }
    });
    $.each($("#"+id).find("tbody").find("input[type='button']"), function( i, n )
    {
        $(n).button({icons: StringUtils.isBlank($(n).attr("icon"))?false:{
            primary: $(n).attr("icon")
        },
        text:StringUtils.isBlank($(n).val())?false:$(n).val()
        });
    });
    $("#"+id).find("tbody > tr[rowNum]").bind("click",function(){
       $("#"+id).find("tbody > tr[select='select']").removeClass("stk-table-selected").removeAttr("select");
       $(this).addClass("stk-table-selected").attr("select","select");

        if(stk.table.isFixTable(id))
        {
            var rowNum = $(this).attr("rowNum");
            var objid = $(this).attr("objid");
            var datatype = $(this).parent().attr("dataType");
            var target;
            if(datatype == 'left') target = $("#"+id).find("tbody[dataType='right']");
            else target = $("#"+id).find("tbody[dataType='left']");
            if($(target).find("tr[rowNum='"+rowNum+"']"))
            {
                target = $(target).find("tr[rowNum='"+rowNum+"']");
            }
            else
            {
                target = $(target).find("tr[objid='"+objid+"']");
            }
            $(target).addClass("stk-table-selected").attr("select","select");
        }
        if(typeof(window[id+"_tableclick"]) == 'function')
        {
            window[id+"_tableclick"]($('#'+id).stk_selectData());
        }
    }).bind('dblclick',function(){
        if(typeof(window[id+"_tabledbclick"]) == 'function')
        {
            window[id+"_tabledbclick"]($('#'+id).stk_selectData());
        }
    });
    //添加qtip
    /*$.each($('#'+id+"_wrap" ).find("[title]" ),function(i,n){
        if(StringUtils.isNotBlank($(n).attr("title")))
        {
            var align = $(n).attr( "tipPos" );
            var x = "center";
            var y = "bottom";
            if ( align == "left" )
            {
                x = "left";
                y = "center"
            }
            else if ( align == "right" )
            {
                x = "right";
                y = "center";
            }
            else
            {
                x = "center";
                y = "bottom";
            }
            $(n).poshytip( {
                className: 'tip-yellow',
                alignTo: 'cursor',
                alignY:'top',
                allowTipHover: false,
                offsetY: 15,
                offsetX: -15
            });
        }
    });*/
    stk.table.adjustScroll(id);
    var hasMergeCol = false;
    if(stk.table.isFixTable(id))
    {
        var fixNum = 0;
        $.each( columnConfig, function ( i, n )
        {
            if($(n).attr("fixed") == "true") fixNum++;
        } );
        $.each( columnConfig, function ( i, n )
        {
            if ( $(n).attr("mergeCol")=="true" )
            {
                hasMergeCol = true;
                if( $(n ).attr("fixed") == "true")
                {
                    stk.table.mergeCol( id+"_ConFix", new Number( n.colNum ) + 1 );
                }
                else
                {
                    stk.table.mergeCol( id+"_Con", new Number( n.colNum ) + 1- fixNum);
                }
            }
        } );
    }
    else
    {
        $.each( columnConfig, function ( i, n )
        {
            if ( $(n).attr("mergeCol")=="true" )
            {
                hasMergeCol = true;
                stk.table.mergeCol(id, new Number(n.colNum)+1);
            }
        } );
    }
    if(hasMergeCol)
    {
        $("#"+id ).find(".stk-table-tr-even" ).removeClass("stk-table-tr-even" );
        $("#"+id ).find(".stk-table-td" ).css("border-width","1px 1px");
    }
    stk.table.adjustColWidth(id,config.pageInfo);

    $('#'+id).stk_adjust();
};

stk.table.mergeCol = function(id,colNum)
{
    function _w_table_rowspan(_w_table_id,_w_table_colnum){
        var _w_table_firsttd = "";
        var _w_table_currenttd = "";
        var _w_table_SpanNum = 0;
        var _w_table_Obj = $(_w_table_id + " tr td:nth-child(" + _w_table_colnum + ")");
        _w_table_Obj.each(function(i){
            if(i==0){
                _w_table_firsttd = $(this);
                _w_table_SpanNum = 1;
            }else{
                _w_table_currenttd = $(this);
                if(_w_table_firsttd.text()==_w_table_currenttd.text()){
                    _w_table_SpanNum++;
                    _w_table_currenttd.attr("merged","true");
                    _w_table_currenttd.hide();
                    _w_table_firsttd.attr("rowSpan",_w_table_SpanNum);
                    $(_w_table_firsttd ).css("height","auto");
                }else{
                    _w_table_firsttd = $(this);
                    _w_table_SpanNum = 1;
                }
            }
        });
    }
    _w_table_rowspan("#"+id,colNum);
};

stk.table.adjustColWidth = function(id,pageInfo)
{
    var table = $( "#" + id );

    $.each( $( table ).find( "th[plugin]" ), function ( i, n )
    {
        var pluginId = $( n ).attr( "plugin" );
        var plugin = $( "#" + pluginId );
        var colNum = $( n ).attr( "colNum" );
        var pluginType = $( plugin ).attr( "type" );
        var width;
        if ( pluginType == "rownum" )
        {
            var maxNum = pageInfo.targetPage *  pageInfo.pageSize;
            if(maxNum > pageInfo.allCount) maxNum = pageInfo.allCount;
            if(maxNum >= 1000000) width = 50;
            var numLength = (""+maxNum).length;
            if(numLength < 2) numLength = 2;
            width = 20 + (numLength-2)*7;//每多一个数字增加7像素
        }
        else if(pluginType == "checkbox" || pluginType == "radiobox")
        {
            width = 20;
        }
        if(width)
        {
            $( table ).find( "th[colNum='" + colNum + "']" ).css( "width", width + "px" );
            $( table ).find( "td[colNum='" + colNum + "']" ).css( "width", width + "px" );
        }
    } )
};
stk.table.addExport = function(id)
{
    var config = window["_"+id].tableConfig;
    var columnConfig = window["_"+id].columnConfig;
    if(config.allowExport == "true")
    {
        if(config.exportOption.indexOf(",") > -1)
        {
            if($("#"+id+"_topBar").find("a[name='table_export']").length == 0)
            {
                $("#"+id+"_topBar").append("<li><a name='table_export' id='"+id+"_exportLink' class='ext stk-button' href='javascript:void(0)'><b class='stk-button-icon ui-icon-extlink'></b><span>导出</span><b class='b-down stk-button'><b id='"+id+"_exportBtn' onclick='$.stopBubble(event);'  class='stk-button-icon  stk-button-icon-bi1 ui-icon-triangle-1-s'></b></b></a><b class='split'></b></li>");
                $("#"+id+"_topBar").parent().show();
                var html = [];
                html.push("<div style='display:none' id='"+id+"_exportDiv'>");
                if(config.exportOption && config.exportOption.indexOf("all") > -1)
                    html.push("<a class='tip-extra-dd' href='javascript:void(0)' onclick=stk.table.exportExcel('"+id+"',true)>全部</a>");
                if(columnConfig[0].pluginType == "checkbox," && config.exportOption.indexOf("select") > -1)
                {
                    html.push("<a class='tip-extra-dd' href='javascript:void(0)' onclick=stk.table.exportExcel('"+id+"',false)>勾选</a>");
                }
                html.push("</div>");
                $("#"+id+"_topBar").append(html.join("\n"));
                $('#'+id+'_exportBtn').click(function() {
                    $('#'+id+'_exportBtn').tipExtraCancel();
                    $('#'+id+'_exportBtn').tipExtra1({
                        html : $('#'+id+'_exportDiv').clone().show()
                    });
                });
                $('#'+id+'_exportLink').click(function(e) {
                    $('#'+id+'_exportBtn').tipExtraCancel();
                    $('#'+id+'_exportBtn').tipExtra1({
                        html : $('#'+id+'_exportDiv').clone().show()
                    });
                });

            }

        }
        else
        {
            if($("#"+id+"_topBar").find("a[name='table_export']").length == 0)
            {
                $("#"+id+"_topBar").append("<li><a name='table_export' id='"+id+"_exportLink' class='normal stk-button' href='javascript:void(0)' onclick=stk.table.exportExcel('"+id+"',"+(config.exportOption=='all'?"true":"false")+")><b class='stk-button-icon ui-icon-extlink'></b><span>导出</span></b></a><b class='split'></b></li>");
                $("#"+id+"_topBar").parent().show();
            }
        }
    }
};
stk.table.exportExcel = function(id, isAll)
{
    var tableConfig = window["_"+id].tableConfig;
    var columnConfig;
    if($("#"+id+"_wrap").find("div[name='tableexportDiv']").length == 0)
    {
        columnConfig = window["_"+id].columnConfig;
    }
    else
    {
        columnConfig = [];
        var obj = $("#"+id+"_wrap").find("div[name='tableexportDiv'] > div");
        $.each(obj, function( i, n )
        {
            columnConfig.push(stk.table.getColumnInfo(n));
        });
    }
    var fileName = id+"_"+ new Date().format("yyyyMMddhhmmss");
    if(StringUtils.isNotBlank(tableConfig.exportFileName)) fileName = tableConfig.exportFileName;
    fileName += "_"+ new Date().format("yyyyMMddhhmmss")+".xlsx";

    var ids;
    if(isAll) ids = undefined;
    else
    {
        var name = window["_"+id].columnConfig[0].pluginParam.replace(",","");
        ids = [];
        var datas = stk.table.getCheckedData(window["_"+id],name,true);
        if(!datas)
            datas = stk.table.getCheckedData(window["_"+id],name);
        if(!datas || datas.length == 0) {stk.alert("请至少勾选一条，才能导出！");return;}
        for(var i = 0; i < datas.length; i++)
        {
            var objid = datas[i].objid;
            if(objid == undefined) objid = datas[i].OBJID;
            if(objid) ids.push(objid);
        }
    }

    SpiritTableAction.exportExcel(tableConfig, columnConfig,stk.table.getQueryForm(window["_"+id]), stk.table.getOrderBy(id), fileName,ids , {
        callback:function()
        {
            if($.browser.msie){
                stk.alert("<a target='_blank' href='"+__contextPath+"/webcontrol.action?fileName="+encodeURIComponent(encodeURIComponent(fileName))+"' style='color:blue;text-decoration:underline '>请点击下载</a>","文件下载");
            }
            else
            {
                if ( $( "#" + id + "_tableExportForm" ).length == 0 )
                {
                    $( document ).find( "body" ).append( "<form action='" + __contextPath + "/webcontrol.action' method='post' id='" + id + "_tableExportForm'><input type='hidden' name='fileName'></form>" );
                }
                var tableForm = $( "#" + id + "_tableExportForm" );
                $( tableForm ).find( "input[name='fileName']" ).val( fileName );
                $( tableForm )[0].submit();
            }

        },
        exceptionHandler:function(msg)
        {
            stk.alert("error："+msg);
        }
    });
};
stk.table.addDetail = function(id)
{
    var config = window["_"+id].tableConfig;
    if(config.allowDetail == "true")
    {
        if($("#"+id+"_topBar").find("a[name='table_detail']").length == 0)
        {
            $("#"+id+"_topBar").append("<li><a name='table_detail' id='"+id+"_detailLink' class='normal stk-button' href='javascript:void(0)' onclick=stk.table.showDetail('"+id+"')><b class='stk-button-icon ui-icon-zoomin'></b><span>详细</span></b></a><b class='split'></b></li>");
            $("#"+id+"_topBar").parent().show();
        }
    }
};
stk.table.showDetail = function(id,_objid)
{
    var tableConfig = window["_"+id].tableConfig;
    var columnConfig;
    if($("#"+id+"_wrap").find("div[name='tabledetailDiv']").length == 0)
    {
        columnConfig = window["_"+id].columnConfig;
    }
    else
    {
        columnConfig = [];
        var obj = $("#"+id+"_wrap").find("div[name='tabledetailDiv'] > div");
        $.each(obj, function( i, n )
        {
            columnConfig.push(stk.table.getColumnInfo(n));
        });
    }
    var data = $("#"+id).stk_selectData();
    if(!data && !_objid) {stk.alert("请选中要查看的数据，该行高亮表示选中！"); return;}
    var objid;
    if(_objid) objid = _objid;
    else {
        objid = data.objid;
        if(objid == undefined) objid = data.OBJID
    }
    if(!objid) {stk.error("错误：数据没有objid"); return;}
    if($("#"+id+"_detailWindow_wrap").length == 0)
    {
        $(document).find("body").append("<div cn='window' id='"+id+"_detailWindow_wrap' _title='详细' _width='600' ><div id='"+id+"_detailWindow'></div><div style='font-size:0;font-family:Arial;height:0;line-height:0;overflow:hidden;display:block;clear:both;'></div></div>");
    }
    SpiritTableAction.detail(tableConfig, columnConfig,stk.table.getQueryForm(window["_"+id]),objid , {
        callback:function(result)
        {
            $("#"+id+"_detailWindow").html(result);
            $("#"+id+"_detailWindow").stk_show();
        },
        exceptionHandler:function(msg)
        {
            stk.alert("error："+msg);
        }
    });
};
stk.table.adjustScroll = function(id)
{
    var tableConfig = window["_"+id].tableConfig;
    var gr,gp = $("#"+id);
    if($.browser.msie && !stk.table.isFixTable(id))
    {

        gr = $('#'+id+'_grid')
        if($.browser.version <= 9) {
            gr.css('zoom', '').css('zoom', 1);
        }

        if(gr[0].clientWidth < gr[0].scrollWidth && $("#"+id+"_wrap").attr("tableWidth") != undefined){
            gp.parent().height(gp.height()+17);
        }
    }
    gp.parent().css("overflow-x","auto");
    if(tableConfig.height)
        $("#"+id).parent().css("overflow-y","auto");
    if(stk.table.isFixTable(id) && $.browser.msie && $.browser.version <= 9){
        if(!gr)
            gr = $('#'+id+'_grid');
        gr.css("zoom", '').css('zoom', 1);
    }
};

stk.table.setColShow = function(id)
{
    if(stk.table.isFixTable(id))
    {
        var obj = $("#"+id+"_HT").find("tr[type!='group'][fake!='1'] > th[show='false']");
        $.each(obj, function( i, n )
        {
            var colNum = $(n).attr("colNum");
            $("#"+id+"_Con").find("td[colNum='"+colNum+"']").hide();
            $("#"+id+"_HT").find("th[colNum='"+colNum+"']").hide();
            var group = $(n).attr("group");
            var groupTop = $(n).attr("groupTop");
            if(StringUtils.isNotBlank(group))
            {
                var groupObj =  $("#"+id+"_HT").find("th[groupName='"+group+"']");
                var colspan = new Number($(groupObj).attr("colspan"));
                if(colspan > 1)
                    $(groupObj).attr("colspan",(colspan-1));
                else
                    $(groupObj).hide();
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
        });
    }
    else
    {
        var obj = $("#"+id).find("thead > tr[type!='group'][fake!='1'] > th[show='false']");
        $.each(obj, function( i, n )
        {
            var colNum = $(n).attr("colNum");
            $("#"+id).find("td[colNum='"+colNum+"']").hide();
            $("#"+id).find("th[colNum='"+colNum+"']").hide();
            var group = $(n).attr("group");
            var groupTop = $(n).attr("groupTop");

            if(StringUtils.isNotBlank(group))
            {
                var groupObj =  $("#"+id).find("thead > tr> th[groupName='"+group+"']");
                var colspan = new Number($(groupObj).attr("colspan"));
                if(colspan > 1)
                    $(groupObj).attr("colspan",(colspan-1));
                else
                    $(groupObj).hide();
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
        });
    }
};

stk.table.genPageInfo = function(config,pageInfo)
{
    var tableConfig = config.tableConfig;
    var pageSize;
    if(pageInfo.pageSize != undefined && pageInfo.pageSize != null && pageInfo.pageSize > 0)
    {
        pageSize = pageInfo.pageSize;
    }
    else
    {
        if(StringUtils.isNotBlank(tableConfig.pageSize))
        {
            pageSize = new Number(tableConfig.pageSize);
        }
    }
    if(pageSize != undefined && pageSize != null && pageSize > 1)
    {
        var targetPage = new Number(pageInfo.targetPage);
        var allPage = new Number(pageInfo.allPage);
        var pageInfoType = tableConfig.pageInfoType;
        var pageMaxCount = 5;
        var start = targetPage-2;
        var end = targetPage+2;
        if(start < 1) {end += (1-start);start = 1;}
        else if(end > allPage) {start -= (end-allPage);end = allPage;}
        if(start < 1) start = 1;
        if(end > allPage) end = allPage;

        /*var jumpstart = targetPage;
        var jumpend = targetPage;
        var jumpPage = Math.ceil((targetPage/pageMaxCount));
        start = (jumpPage-1)*pageMaxCount + 1;
        end = (jumpPage-1)*pageMaxCount + pageMaxCount;
        jumpstart -= pageMaxCount;
        jumpend += pageMaxCount;
        if(start < 1) start = 1;
        if(end > allPage) end = allPage;
        if(jumpstart < 1) jumpstart = 1;
        if(jumpend > allPage) jumpend = allPage;*/
        var id = tableConfig.id;
        var func;
        var html = [];
        if(pageInfoType == "normal")
        {
            html.push("<div class='stk-fl'>共"+pageInfo.allCount+"条记录&nbsp;&nbsp;");
            html.push("<select name='pageSizeSelect' onchange='"+id+"_resetPageSize(this)'>");
            html.push("<option value='10'"+((pageSize==10)?" selected='selected'":"")+">10</option>");
            html.push("<option value='15'"+((pageSize==15)?" selected='selected'":"")+">15</option>");
            html.push("<option value='20'"+((pageSize==20)?" selected='selected'":"")+">20</option>");
            html.push("<option value='30'"+((pageSize==30)?" selected='selected'":"")+">30</option>");
            html.push("<option value='50'"+((pageSize==50)?" selected='selected'":"")+">50</option>");
            html.push("<option value='100'"+((pageSize==100)?" selected='selected'":"")+">100</option>");
            html.push("<option value='200'"+((pageSize==200)?" selected='selected'":"")+">200</option>");
            html.push("</select>");
            html.push("/页</div>");
        }
        html.push("<div class='stk-fr stk-page-jump-box'>");
        func = id + "_jump(" + 1 + ")";
        html.push("<a href='#first' title='首页' class='p-first");
        if (targetPage > 1)
            html.push("' onclick='eval(" + func + ");'");
        else html.push(" p-first-invalid'");
        html.push("></a>");

        func = id + "_jump(" + (targetPage - 1) + ")";
        html.push("<a href='#prev' title='上一页' class='p-prev");
        if (targetPage > 1)
            html.push("' onclick='eval(" + func + ");'");
        else html.push(" p-prev-invalid'");
        html.push("></a>");

        func = id + "_jump(this)";
        html.push("<div class='stk-page-jump'><button name='go' type='button' class='stk-button stk-button-st-3'><span>Go</span></button><input name='pageNum' type='text' value='"+targetPage+"'></div><span class='stk-page-jump-sum'>共"+allPage+"页</span>");

        func = id + "_jump(" + (targetPage + 1) + ")";
        html.push("<a href='#next' title='下一页'  class='p-next");
        if (targetPage < allPage)
            html.push("' onclick='eval(" + func + ");'");
        else html.push(" p-next-invalid'");
        html.push("></a>");

        func = id + "_jump(" + allPage + ")";
        html.push("<a href='#last' title='尾页' class='p-last");
        if (targetPage < allPage)
            html.push("' onclick='eval(" + func + ");'");
        else html.push(" p-last-invalid'");
        html.push("></a>");
        html.push("</div>");
        $("#"+id+"_pageInfo").html(html.join("\n"));
        $("#"+id+"_pageInfo").find("input[name='pageNum']").keypress(function(cc){
            if(cc.keyCode == 13)
                window[id+"_jump"](this,allPage);
        });
        $("#"+id+"_pageInfo").find("button[name='go']").click(function(){
            window[id+"_jump"]($(this).next(),allPage);
        });
        $("#"+id+"_pageInfo").show();
    }
};
stk.table.savePageSize = function(id,pageSize)
{
    var tableConfig = window["_"+id].tableConfig;
    UserConfigAware.savePageSize(id, tableConfig.actionClass, pageSize, {
        async:false,
        exceptionHandler:function(message,e) {
             stk.alert("error：" + message);
        }
    });
};
stk.table.getCheckedData = function (config, name,allowCache)
{
    var tableId = config.id;
    var tableData = config.data;
    var _tr = $("#"+tableId).find("input[name='"+name+"']");
    var result;
    var _cache;
    if(allowCache)
    {
        _cache = stk.cache.pluginCheckbox[name];
        result = stk.cache.pluginCheckbox.func.val(name);
    }
    if(_cache == undefined) _cache = {};
    if(result == undefined) result = [];
    $.each(_tr, function(i, n)
    {
        var objid = tableData[i].objid;
        if(objid == undefined) objid = tableData[i].OBJID;
        if($(n).attr("checked") && _cache[objid] == undefined)
            _cache[objid] = tableData[i];
        if(!$(n).attr("checked") && _cache[objid] != undefined)
            _cache[objid] = undefined;
    });
    if(allowCache)
    {
        stk.cache.pluginCheckbox[name] = _cache;
        result = stk.cache.pluginCheckbox.func.val(name);
    }
    else
    {
        var data = _cache;
        for (var property in data)
        {
            var key = property;
            var value = data[property];
            if(value)
            {
                result.push(value);
            }
        }
    }
    return result;
};
stk.table.getRadioData = function (config, name)
{
    var tableId = config.id;
    var tableData = config.data;
    var result;
    $.each($("#"+tableId).find("input[type='radio'][name='"+name+"']"), function( i, n )
    {
        if($(n).attr("checked"))
            result = tableData[i];
    });
    return result;
};
<!-- ################################################################## -->
<!-- ##                        2.  alert                             ## -->
<!-- ################################################################## -->
/**
 * closeDialog 关闭对话框
 */
stk.closeDialog = function()
{
    if($("#__alertDiv").length != 0)
    {
        $("#__alertDiv").dialog("close");
    }
};
stk.alert = function(param1,param2,param3)
{
    var title;
    var buttons;
    if(param3 == undefined) param3 = {"确认":function(){$("#__alertDiv").dialog("close");}};
    if($("#__alertDiv").length == 0)
    {
        $("body").append("<div style='display:none' id='__alertDiv'></div>");
    }
    var alertDiv = $("#__alertDiv");
    if (typeof(param2) == typeof({})) {
        buttons = param2;
    }
    else if (typeof(param3) == typeof({})) {
        buttons = param3;
        title = param2;
    }
    if (StringUtils.isBlank(title)) {
        title = "警告";
    }
    $(alertDiv).html(""+param1);
    $( alertDiv ).dialog({
        title:title,
        modal:true,
        resizable:false,
        buttons:buttons,
        zIndex:99999*2
    });
    $( alertDiv ).parent().find(".ui-dialog-titlebar-close").hide();
};

stk.confirm = function(msg,func)
{
    stk.alert(msg,"询问",{"是":function(){stk.closeDialog();if(typeof(func) == 'function') func();},"否":function(){stk.closeDialog();}});
};

stk.error = function(param1,param3)
{
    stk.alert(param1,"错误",param3);
};

stk.warn = function(param1,param3)
{
    stk.alert(param1,"警告",param3);
};

stk.info = function(param1,param3)
{
    stk.alert(param1,"提示",param3);
};

stk.debug =
function(data, level, depth)
{
    var text = DebugUtils.toString(data, level, depth).replaceAll("\n","<br>");
    if($("#__debugDiv").length == 0)
    {
        $("body").append("<div style='display:none' id='__debugDiv'></div>");
    }
    var alertDiv = $("#__debugDiv");
    $(alertDiv).html(text);
    $( alertDiv ).dialog({
        width:500,
        title:"Debug",
        modal:true,
        resizable:false,
        zIndex:99999
    });
};

stk.message = function(message, option)
{
    if(option)
        $.growlUI(option.title, message, option.timeout, option.onClose, option.className,option.icon);
    else
        $.growlUI("提示", message, 2000,null,'growlUI');
}
<!-- ################################################################## -->
<!-- ##                        3.  checkBox                          ## -->
<!-- ################################################################## -->
stk.checkBox = {};

/**
 * 建立复选框全选联动
 * @param id 全选框id
 * @param targetName 复选框name
 */
stk.checkBox.buildSelectAll = function(id, targetName)
{
    var obj = $("#" + id);
    var checkboxs = $("input[type='checkbox'][name='" + targetName + "']");
    obj.attr("checked", "");
    obj.change(function () {
        if (obj.attr("checked"))
            checkboxs.attr("checked", "checked");
        else
            checkboxs.attr("checked", "");
    });
    checkboxs.change(function() {
        if ($(this).attr("checked") == false)
            obj.attr("checked", "");
        if (checkboxs.length == $("input[type='checkbox'][name='" + targetName + "']:checked").length)
            obj.attr("checked", "checked");
    });
};

/**
 * 获得复选框组的值，用sign分隔符隔开
 * @param name 复选框name
 */
stk.checkBox.getValue = function(name)
{
    var value = new Array();
    var obj = $("input[name='" + name + "']:checked");
    $.each(obj, function( i, n )
    {
        value.push($(n).val());
    });
    return value;
};

/**
 * 获得复选框组的文本，用sign分隔符隔开
 * @param name 复选框name
 */
stk.checkBox.getText = function(name)
{
    var value = new Array();
    var obj = $("input[name='" + name + "']:checked");
    $.each(obj, function( i, n )
    {
        value.push($(n).next().text());
    });
    return value;
};

/**
 * 设置复选框组的值，用sign分隔符隔开
 * @param obj string/array
 * @param name 复选框name
 * @param sign 分隔符，默认“，”（可选）
 */
stk.checkBox.setValue = function( name,obj, sign)
{
    if(StringUtils.isBlank(sign)) sign = ",";
    var strArrays;
    if(typeof(obj) == 'string')
        strArrays = obj.split(sign);
    else
        strArrays = obj;
    var chbox = $("input[name='" + name + "']").attr("checked","");
    $.each(strArrays, function( i, n )
    {
        chbox.filter("[value='"+n+"']").attr("checked", "checked");
    });
};
stk.checkBox.buildSelectAll = function(id, targetName)
{
    $("#" + id).attr("checked", "");
    $("#" + id).click(function ()
    {
        if ( $("#" + id).attr("checked") )
            $("input[type='checkbox'][name='" + targetName + "']:not(:disabled)").attr("checked", "checked");
        else
            $("input[type='checkbox'][name='" + targetName + "']:not(:disabled)").attr("checked", "");
    });
    $("input[type='checkbox'][name='"+targetName+"']").click(function(){
        if ( $(this).attr("checked") == false )
            $("#" + id).attr("checked", "");
        if( $("input[type='checkbox'][name='"+targetName+"']").length == $("input[type='checkbox'][name='"+targetName+"']:checked").length)
            $("#" + id).attr("checked", "checked");
    });
};
<!-- ################################################################## -->
<!-- ##                        4.  radio                             ## -->
<!-- ################################################################## -->
stk.radioBox = {};

/**
 * 获得radio组选中的值
 * @param name radio组name
 */
stk.radioBox.getValue = function(name)
{
   var value = "";
    $.each($("input[name='" + name + "']:checked"), function( i, n )
    {
        value = $(n).val();
    });
    return value;
};

/**
 * 获得radio组选中的文字
 * @param name radio组name
 */
stk.radioBox.getText = function(name)
{
    var value = "";
    $.each($("input[name='" + name + "']:checked"), function( i, n )
    {
        value = $(n).next().text();
    });
    return value;
};

/**
 * 设置radio组选中的值
 * @param name radio组name
 * @param name 选中的值
 */
stk.radioBox.setValue = function(name, value)
{
    $.each($("input[name='" + name + "']"), function( i, n )
    {
        if($(n).attr("checked")) $(n).removeAttr("checked");
        if($(n).val() == value)
            $(n).attr("checked",true);
    });
};
<!-- ################################################################## -->
<!-- ##                        5. tree                               ## -->
<!-- ################################################################## -->
stk.tree = {};
stk.tree.changeNode = function(obj,genChildren,id,callBack)
{
    var className = $(obj).attr("class");
    var config = window[id+"_config"];
    var emptyNum = $(obj).parent().children("div[class^='stk_tree_icon']").length-1;
    var isAllLast= "true" == $(obj).attr("isAllLast");
    var jsParam=$(obj).attr("jsParam");
    if(StringUtils.isBlank(className)) return;
    if(className.indexOf("close") > -1)
    {
        $(obj).removeClass("stk_tree_icon_close");
        $(obj).addClass("stk_tree_icon_open");
        if(genChildren)
        {
            var param = {};
            if (StringUtils.isNotBlank(jsParam)) {
                var tmp = window[jsParam];
                if (typeof(tmp) == "function")
                    param = tmp();
            }
            SpiritTreeAction.genChildren(config,$(obj).parent().attr("nodeId"),param,{
            callback:function(result) {
                var data = result.children;
                var html = [];
                if(data != null && data != undefined)
                {
                    for(var i = 0; i < data.length; i++)
                    {
                        html.push(build(id,data[i],(i+1)==data.length,isAllLast,jsParam));
                    }
                    $(obj).parent().children("div[name='childDiv']").html(html.join("\n")).show();
                }
                else
                {
                    $(obj).parent().children("div[name='childDiv']").html("");
                }
                $(obj).parent().children("div[name='childDiv']").find("a").bind("click",function(){
                    $("#"+id).find("a").css("background-color","").css("color","");
                    $(this).css("background-color",stk.tree_link_select_color).css("color","white");
                });
                if(typeof(callBack) == 'function') callBack();
            }
            });
        }
        else
        {
            $(obj).parent().children("div[name='childDiv']").show();
        }
    }
    else if(className.indexOf("open") > -1)
    {
        $(obj).removeClass("stk_tree_icon_open");
        $(obj).addClass("stk_tree_icon_close");
         $(obj).parent().children("div[name='childDiv']").hide();
    }
    else if(className.indexOf("plus") > -1)
    {
        $(obj).removeClass("stk_tree_icon_plus");
        $(obj).addClass("stk_tree_icon_minus");
        if(genChildren)
        {
            var param = {};
            if (StringUtils.isNotBlank(jsParam)) {
                var tmp = window[jsParam];
                if (typeof(tmp) == "function")
                    param = tmp();
            }
            SpiritTreeAction.genChildren(config,$(obj).parent().attr("nodeId"),param,{
            callback:function(result) {
                var data = result.children;
                var html = [];
                if(data != null && data != undefined)
                {
                    for(var i = 0; i < data.length; i++)
                    {
                        html.push(build(id,data[i],(i+1)==data.length,isAllLast,jsParam));
                    }
                    $(obj).parent().children("div[name='childDiv']").html(html.join("\n")).show();
                }
                else
                {
                    $(obj).parent().children("div[name='childDiv']").html("");
                }
                $(obj).parent().children("div[name='childDiv']").find("a").bind("click",function(){
                    $("#"+id).find("a").css("background-color","").css("color","");
                    $(this).css("background-color",stk.tree_link_select_color).css("color","white");
                });
                if(typeof(callBack) == 'function') callBack();
            }
            });
        }
        else
            $(obj).parent().children("div[name='childDiv']").show();
    }
    else if(className.indexOf("minus") > -1)
    {
        $(obj).removeClass("stk_tree_icon_minus");
        $(obj).addClass("stk_tree_icon_plus");
        $(obj).parent().children("div[name='childDiv']").hide();
    }

    function getOpen(id,icon,config,isAllLast,jsParam)
    {
        var genChildren = config.genChildren;
        if(StringUtils.isNotBlank(icon))
            return "<div jsParam='"+jsParam+"' isAllLast='"+isAllLast+"' name='open_close' class='stk_tree_icon_minus' onclick='stk.tree.changeNode(this,"+genChildren+",\""+id+"\","+isAllLast+")'/><div class='"+icon+"'/>";
        else
            return "<div jsParam='"+jsParam+"' isAllLast='"+isAllLast+"' name='open_close' class='stk_tree_icon_open' onclick='stk.tree.changeNode(this,"+genChildren+",\""+id+"\","+isAllLast+")'/><div class='stk_tree_icon_folder'/>";
    }

    function getClose(id,icon,config,isAllLast,jsParam)
    {
        var genChildren = config.genChildren;
        if(StringUtils.isNotBlank(icon))
            return "<div jsParam='"+jsParam+"' isAllLast='"+isAllLast+"' name='open_close' class='stk_tree_icon_plus' onclick='stk.tree.changeNode(this,"+genChildren+",\""+id+"\","+isAllLast+")'/><div class='"+icon+"'/>";
        else
            return "<div jsParam='"+jsParam+"' isAllLast='"+isAllLast+"' name='open_close' class='stk_tree_icon_close' onclick='stk.tree.changeNode(this,"+genChildren+",\""+id+"\","+isAllLast+")'/><div class='stk_tree_icon_folder'/>";
    }

    function getLeaf(icon,isLast,isAllLast,config)
    {
        var prefix = "";
        if(!config.lines)
        {
            prefix = "<div class='stk_tree_icon_empty'/>";
        }
        else
        {
            if(isLast) prefix = "<div class='stk_tree_icon_end2'/>";
            else prefix = "<div class='stk_tree_icon_sub'/>";
        }
        if(StringUtils.isNotBlank(icon))
            return prefix + "<div class='"+icon+"'/>";
        else
            return prefix + "<div class='stk_tree_icon_leaf'/>";
    }

    var preType = new Array(20);
    function getEmpty(isLast, isAllLast, isLeaf)
    {
        var tmp = [];
        for(var i = 0 ; i < emptyNum; i++)
        {
            if(config.lines)
            {
                if(i == (emptyNum - 1))
                {
                    if(isLast)
                    {
                        tmp.push("<div class='stk_tree_icon_end'/>");
                        preType[i] = "elbow-end";
                    }
                    else
                    {
                        if(isLeaf) tmp.push("<div class='stk_tree_icon_line'/>");
                        else tmp.push("<div class='stk_tree_icon_elbow'/>");
                        preType[i] = "elbow";
                    }
                }
                else
                {
                    if(!isAllLast)
                    {
                        if(preType[i] == "elbow-end" || preType[i] == "empty")
                        {
                            tmp.push("<div class='stk_tree_icon_empty'/>");
                            preType[i] = "empty";
                        }
                        else
                        {
                            tmp.push("<div class='stk_tree_icon_line'/>");
                            preType[i] = "elbow-line";
                        }
                    }
                    else
                    {
                        if(isLast)
                        {
                            tmp.push("<div class='stk_tree_icon_empty'/>");
                            preType[i] = "empty";
                        }
                        else
                        {
                            tmp.push("<div class='stk_tree_icon_line'/>");
                            preType[i] = "elbow-line";
                        }
                    }
                }
            }
            else
                tmp.push("<div class='stk_tree_icon_empty'/>");
        }
        return tmp.join("\n");
    }

    function build(id,d,isLast,isAllLast,jsParam)
    {
        var nodeId = d.id==undefined?"":d.id;
        var node = [];
        node.push("<div nodeId='"+nodeId+"' style='clear:both;white-space:nowrap; overflow:hidden;'>");
        if(!d.genChildren)
        {
            if(d.children)
            {
                if(d.isOpen)
                {
                    node.push(getEmpty(isLast,isAllLast,false) + getOpen(id,d.icon,d,isAllLast,jsParam) + "&nbsp;" + d.text);
                    node.push("<div name='childDiv' style='clear:both;white-space:nowrap; overflow:hidden;'>");
                }
                else
                {
                    node.push(getEmpty(isLast,isAllLast,false) + getClose(id,d.icon,d,isAllLast,jsParam) + "&nbsp;" + d.text);
                    node.push("<div name='childDiv' style='clear:both;display:none;white-space:nowrap; overflow:hidden;'>");
                }
                emptyNum++;
                for(var i = 0; i < d.children.length; i++)
                {
                    node.push(build(id,d.children[i],(i+1)==d.children.length,isAllLast,jsParam));
                }
                emptyNum--;
                node.push("</div>");
            }
            else
            {
                if(d.href)
                {
                    node.push("<div name='childDiv' style='clear:both;white-space:nowrap; overflow:hidden;'>"+getEmpty(isLast,isAllLast,true) + getLeaf(d.icon,isLast,isAllLast,config) + "&nbsp;");
                    node.push("<a class='treeHref' href='"+d.href+"' target='"+config.hrefTarget+"'>" + d.text + "</a></div>");
                }
                else
                {
                    node.push("<div name='childDiv' style='clear:both;white-space:nowrap; overflow:hidden;'>"+getEmpty(isLast,isAllLast,true) + getLeaf(d.icon,isLast,isAllLast,config) + "&nbsp;" + d.text + "</div>");
                }
            }
        }
        else
        {
            node.push(getEmpty(isLast, isAllLast,false) + getClose(id,d.icon,d,isAllLast,jsParam) + "&nbsp;" + d.text);
            node.push("<div name='childDiv' style='clear:both;display:none;white-space:nowrap; overflow:hidden;'>");
            emptyNum++;
            for (var i = 0; i < d.children.length; i++)
            {
                node.push(build(id,d.children[i], (i + 1) == d.children.length, isAllLast,jsParam));
            }
            emptyNum--;
            node.push("</div>");
        }

        node.push("</div>");
        return node.join("\n");
    }
};

stk.tree.build = function(id, data, config, jsParam)
{
    var treePanel = $("#"+id);

    $(treePanel).empty();

    var html = [];

    var emptyNum = 0;

    function getOpen(id,icon,config,isAllLast,jsParam)
    {
        var genChildren = config.genChildren;
        if(StringUtils.isNotBlank(icon))
            return "<div jsParam='"+jsParam+"' name='open_close' isAllLast='"+isAllLast+"' class='stk_tree_icon_minus' onclick='stk.tree.changeNode(this,"+genChildren+",\""+id+"\")'/><div class='"+icon+"'/>";
        else
            return "<div jsParam='"+jsParam+"' name='open_close' isAllLast='"+isAllLast+"' class='stk_tree_icon_open' onclick='stk.tree.changeNode(this,"+genChildren+",\""+id+"\")'/><div class='stk_tree_icon_folder'/>";
    }

    function getClose(id,icon,config,isAllLast,jsParam)
    {
        var genChildren = config.genChildren;
        var nodeId = config.id;
        if(StringUtils.isNotBlank(icon))
            return "<div jsParam='"+jsParam+"' name='open_close' isAllLast='"+isAllLast+"' class='stk_tree_icon_plus' onclick='stk.tree.changeNode(this,"+genChildren+",\""+id+"\")'/><div class='"+icon+"'/>";
        else
            return "<div jsParam='"+jsParam+"' name='open_close' isAllLast='"+isAllLast+"' class='stk_tree_icon_close' onclick='stk.tree.changeNode(this,"+genChildren+",\""+id+"\")'/><div class='stk_tree_icon_folder'/>";
    }

    function getLeaf(icon,isLast,isAllLast,config)
    {
        var prefix = "";
        if(!config.lines)
        {
            prefix = "<div class='stk_tree_icon_empty'/>";
        }
        else
        {
            if(isLast) prefix = "<div class='stk_tree_icon_end2'/>";
            else prefix = "<div class='stk_tree_icon_sub'/>";
        }
        if(StringUtils.isNotBlank(icon))
            return prefix + "<div class='"+icon+"'/>";
        else
            return prefix + "<div class='stk_tree_icon_leaf'/>";
    }

    var preType = new Array(20);
    function getEmpty(isLast, isAllLast, isLeaf)
    {
        var tmp = [];
        for(var i = 0 ; i < emptyNum; i++)
        {
            if(config.lines)
            {
                if(i == (emptyNum - 1))
                {
                    if(isLast)
                    {
                        tmp.push("<div class='stk_tree_icon_end'/>");
                        preType[i] = "elbow-end";
                    }
                    else
                    {
                        if(isLeaf) tmp.push("<div class='stk_tree_icon_line'/>");
                        else tmp.push("<div class='stk_tree_icon_elbow'/>");
                        preType[i] = "elbow";
                    }
                }
                else
                {
                    if(!isAllLast)
                    {
                        if(preType[i] == "elbow-end" || preType[i] == "empty")
                        {
                            tmp.push("<div class='stk_tree_icon_empty'/>");
                            preType[i] = "empty";
                        }
                        else
                        {
                            tmp.push("<div class='stk_tree_icon_line'/>");
                            preType[i] = "elbow-line";
                        }
                    }
                    else
                    {
                        tmp.push("<div class='stk_tree_icon_empty'/>");
                        preType[i] = "empty";
                    }
                }
            }
            else
                tmp.push("<div class='stk_tree_icon_empty'/>");
        }
        return tmp.join("\n");
    }

    function build(id,d,isLast,isAllLast)
    {
        var nodeId = d.id==undefined?"":d.id;
        var node = [];
        node.push("<div nodeId='"+nodeId+"' style='clear:both;white-space:nowrap; overflow:hidden;'>");
        if(!d.genChildren)
        {
            if(d.children)
            {
                if(d.isOpen)
                {
                    node.push(getEmpty(isLast,isAllLast,false) + getOpen(id,d.icon,d,isAllLast,jsParam) + "&nbsp;" + d.text);
                    node.push("<div name='childDiv' style='clear:both;white-space:nowrap; overflow:hidden;'>");
                }
                else
                {
                    node.push(getEmpty(isLast,isAllLast,false) + getClose(id,d.icon,d,isAllLast,jsParam) + "&nbsp;" + d.text);
                    node.push("<div name='childDiv' style='clear:both;display:none;white-space:nowrap; overflow:hidden;'>");
                }
                emptyNum++;
                for(var i = 0; i < d.children.length; i++)
                {
                    node.push(build(id,d.children[i],(i+1)==d.children.length,isAllLast&&isLast));
                }
                emptyNum--;
                node.push("</div>");
            }
            else
            {
                if(d.href)
                {
                    node.push("<div name='childDiv' style='clear:both;white-space:nowrap; overflow:hidden;'>"+getEmpty(isLast,isAllLast,true) + getLeaf(d.icon,isLast,isAllLast,config) + "&nbsp;");
                    node.push("<a class='treeHref' href='"+d.href+"' target='"+config.hrefTarget+"'>" + d.text + "</a></div>");
                }
                else
                {
                    node.push("<div name='childDiv' style='clear:both;white-space:nowrap; overflow:hidden;'>"+getEmpty(isLast,isAllLast,true) + getLeaf(d.icon,isLast,isAllLast,config) + "&nbsp;" + d.text + "</div>");
                }
            }
        }
        else
        {
            node.push(getEmpty(isLast, isAllLast,false) + getClose(id,d.icon,d,isAllLast,jsParam) + "&nbsp;" + d.text);
            node.push("<div name='childDiv' style='clear:both;display:none;white-space:nowrap; overflow:hidden;'>");
            emptyNum++;
            for (var i = 0; i < d.children.length; i++)
            {
                node.push(build(id,d.children[i], (i + 1) == d.children.length, isAllLast && isLast));
            }
            emptyNum--;
            node.push("</div>");
        }

        node.push("</div>");
        return node.join("\n");
    }

    if(StringUtils.isNotBlank(config.rootText))
    {
        if(!config.rootExpanded) html.push("<div style='clear:both;white-space:nowrap; overflow:hidden;'>" + getClose(id,config.rootIcon,config,jsParam) + "nbsp;" + config.rootText);
        else html.push("<div style='clear:both;white-space:nowrap; overflow:hidden;'>" + getOpen(id,config.rootIcon,config,jsParam) + "&nbsp;" + config.rootText);
        html = html.reverse();
        html.push("<div>");
        html = html.reverse();
        emptyNum++;
    }
    else
    {
        html = [];
        html.push("<div>");
    }

    html.push("<div name='childDiv' style='clear:both;white-space:nowrap; overflow:hidden;'>");

    for(var i = 0; i < data.length; i++)
    {
        html.push(build(id,data[i],(i+1)==data.length,(i+1)==data.length));
    }

    html.push("</div>");
    html.push("</div>");

    $(treePanel).append(html.join("\n"));

    if(config.hidden) $(treePanel).hide();

    $("#"+id).find("a").bind("click",function(){
        $("#"+id).find("a").css("background-color","").css("color","");
        $(this).css("background-color",stk.tree_link_select_color).css("color","white");
    });

    $("#"+id+"_wait").remove();
    if(typeof(window[id+"_aftertreeinit"]) == 'function') window[id+"_aftertreeinit"](data);
};


/**
 * 生成树状
 * @param id
 * @param parents 父map
 * @param children 子map （map里key对应父map的key，value是list）
 */
stk.tree.init = function( id, parents, children, genChildren )
{
    var obj = document.createElement('div');
    $(obj).attr('id', id);
    for ( var parent in parents )
    {
        var p = document.createElement('div');
        $(p).attr("name", id + "_" + parent);
        $(p).css("float", "none");
        var img = document.createElement('div');
        $(img).addClass("stk_tree_icon_plus");
        $(img).attr("open", "false");
        $(img).click(function ()
        {
            if ( $(this).attr("open") == "false" )
            {
                $(this).attr("open", "true");
                $(this).parent().parent().find("div[name='" + $(this).parent().attr("name") + "_sub']").show();
                $(this).removeClass("stk_tree_icon_plus").addClass("stk_tree_icon_minus");
            }
            else
            {
                $(this).attr("open", "false");
                $(this).parent().parent().find("div[name='" + $(this).parent().attr("name") + "_sub']").hide();
                $(this).removeClass("stk_tree_icon_minus").addClass("stk_tree_icon_plus");
            }
        });
        $(p).append(img);
        $(p).append(parents[parent]);
        $(obj).append(p);
    }
    for ( var child in children )
    {

        for ( var j = 0; j < children[child].length; j++ )
        {
            var c = document.createElement('div');
            $(c).attr("name", id + "_" + child + "_sub");
            $(c).css("float", "none");
            $(c).append("<div class='stk_tree_icon_line'/>");
            $(c).append(children[child][j]);
            $(c).hide();
            $(obj).find("div[name='" + id + "_" + child + "']").append(c);
        }
    }
    return obj;
};
/********************************************************************
 **                        6 . 表单验证                             **
 ********************************************************************/
stk.form={};
stk.form.checkersMsg="";
stk.form.getParameters = function( id, options, sign )
{
    if(StringUtils.isBlank(sign)) sign = ",";
    if(typeof(options) != typeof({})) options = {};
    var map = {};

    function putMap(n)
    {
        if(!stk.textField.isEmptyText(n))
        {
            if($(n).attr("name"))
            {
                if(map[$(n).attr("name")] == undefined)
                {
                    map[$(n).attr("name")] = $(n).val();
                }
                else
                {
                    var tmp = map[$(n).attr("name")];
                    tmp += sign + $(n).val();
                    map[$(n).attr("name")] = tmp;
                }
            }
            else if($(n).attr("id")) map[$(n).attr("id")] = $(n).val();
        }
    }

    $.each($("#" + id).find("input"), function(i, n)
    {
        var type = $(n).attr("type");
        var value = $(n).val();
        if(options.allowNull && StringUtils.isBlank($(n).val())) value = "[null]";
        if(StringUtils.isNotBlank(value) && type=="text" || type=="password" || type=="hidden" || type=="file")
        {
            putMap(n);
        }
    });
    $.each($("#" + id).find("input[type='checkbox']:checked"), function(i, n)
    {
        if(map[$(n).attr("name")] == undefined)
        {
            map[$(n).attr("name")] = $(n).val();
        }
        else
        {
            var tmp = map[$(n).attr("name")];
            tmp += sign + $(n).val();
            map[$(n).attr("name")] = tmp;
        }
    });

    $.each($("#" + id).find("input[type='radio']:checked"), function(i, n)
    {
        if(StringUtils.isNotBlank($(n).val()))
        {
            putMap(n);
        }
    });

    $.each($("#" + id).find("select"), function(i, n)
    {
        var result = "";
        var obj;
        if($(n).attr("multiValue") == "1")
            obj = $(n).find("option");
        else
            obj = $(n).find("option:selected");
        $.each(obj, function(i, n)
        {
            result += $(n).val();
            if (i != (obj.length - 1))
                result += sign;
        });
        if(StringUtils.isNotBlank(result))
        {
            if($(n).attr("name"))
            {
                if(map[$(n).attr("name")] == undefined)
                {
                    map[$(n).attr("name")] = result;
                }
                else
                {
                    var tmp = map[$(n).attr("name")];
                    tmp += sign + result;
                    map[$(n).attr("name")] = tmp;
                }
            }
            else if($(n).attr("id")) map[$(n).attr("id")] = result;
        }
    });
    $.each($("#" + id).find("textArea"), function(i, n)
    {
        var value = $(n).val();
        if(options.allowNull && StringUtils.isBlank($(n).val())) value = "[null]";
        if(StringUtils.isNotBlank(value) && !stk.textField.isEmptyText(n))
        {
            putMap(n);
        }
    });
    return map;
};
stk.form.setCheckerOnBlur = function(id,target)
{
    var current = $("#" + target);
    if (current[0] == undefined) {
        current = $("#"+id).find("input[name='" + target + "']")[0];
        if (current == undefined) current = $("#"+id).find("textArea[name='" + target + "']")[0];
        if (current == undefined) current = $("#"+id).find("select[name='" + target + "']")[0];
        if ($(current).attr("type") == "checkbox" || $(current).attr("type") == "radio");
    }
    if (current != undefined)
    {
        if($(current).attr("type") == 'combobox') current = $(current).parent().find("input");
        $(current).bind("blur",function(){
            try{
                stk.form.check(id,target);
            }catch(e){alert(e.description)}
        } ).bind("keyup",function(){
            if ( $( this ).val() )
            {
                $( current ).mouseout();
            }
        });
    }
};
stk.form.getCheckTarget = function(id,target)
{
    var current = $("#" + target);
    if (current[0] == undefined) {
        current = $("#"+id).find("input[name='" + target + "']")[0];
        if (current == undefined) current = $("#"+id).find("textArea[name='" + target + "']")[0];
        if (current == undefined) current = $("#"+id).find("select[name='" + target + "']")[0];
        if ($(current).attr("type") == "checkbox" || $(current).attr("type") == "radio");
    }
    if($(current).attr("type") == 'multiselect') current = $(current).find("#"+$(current).attr("id")+"_showValue");
    if($(current).attr("type") == 'combobox') current = $(current).parent().find("input");
    var uiId = $(current).attr("id");
    if($("#"+uiId+"_wrap").attr("cn") == "checkboxgroup" || $("#"+uiId+"_wrap").attr("cn") == "removableselect")
    {
        current = $("#"+uiId+"_wrap");
    }
    return current;
};
stk.form.cleanFormTip = function( id )
{
    var all_msgTarget = $("div[formId='"+id+"'][type='checkers']").attr("msgTarget");
    $.each($("div[formId='"+id+"'][type='checkers']").find("span[type='checker']"), function(i, n)
    {
        var msgTarget = $(n).attr("msgTarget");
        if(StringUtils.isBlank(msgTarget))  msgTarget = all_msgTarget;
        stk.form.cleanTip(stk.form.getCheckTarget(id,$(n).attr("target")),msgTarget);
    });
};
stk.form.cleanTip = function(current,msgTarget)
{
    var otherId = $(current).attr("id") + "_input";
    if ($("#" + otherId).length > 0)
        current = $("#" + otherId);
    $(current).removeClass("ui-state-error");
    if (msgTarget == "qtip")
    {
        $(current).stk_closeQtip();
    }
    if (msgTarget == "title" )
    {
        $(current).removeAttr("title");
    }
    else if (msgTarget == "under" || msgTarget == "side")
    {
        var next = $(current).next();
        if($(next).attr("name") == msgTarget+"_errorIcon")
            $(next).remove();
    }
    else
    {
        $("#"+msgTarget).empty();
    }
};
stk.form.check = function(id,target)
{
    var config = $("#"+id).find("span[type='checker'][target='"+target+"']");
    if($(config).length == 0)  config =  $("span[type='checker'][target='"+target+"']");
    var targetName = $(config).attr("targetName");
    var allowBlank = $(config).attr("allowBlank");
    var blankText = $(config).attr("blankText");
    var maxLength = $(config).attr("maxLength");
    var maxLengthText = $(config).attr("maxLengthText");
    var minLength = $(config).attr("minLength");
    var minLengthText = $(config).attr("minLengthText");
    var regex = $(config).attr("regex");
    var regexText = $(config).attr("regexText");
    var validator = $(config).attr("validator");
    var msgTarget = $(config).attr("msgTarget");
    var validateOnBlur = $(config).attr("validateOnBlur");
    var all_msgTarget = $(config).parent().attr("msgTarget");
    var all_validateOnBlur = $(config).parent().attr("validateOnBlur");
    if(StringUtils.isBlank(msgTarget))  msgTarget = all_msgTarget;
    if(StringUtils.isBlank(validateOnBlur))  validateOnBlur = all_validateOnBlur;

    function displayTip(msg)
    {
        if (StringUtils.isNotBlank(msg))
        {
            stk.form.checkersMsg += msg + "<br>";
            var otherId = $(current).attr("id")+"_input";
            if($("#"+otherId).length > 0)
                current = $("#"+otherId);
            $(current).addClass("ui-state-error");
            if(validateOnBlur == "false")
                $(current).focus();
            if (msgTarget == "qtip")
            {
                $(current).stk_qtip(msg);
            }
            else if (msgTarget == "title")
            {
                $(current).attr("title",msg);
            }
            else if (msgTarget == "alert")
            {
                stk.alert(msg);
            }
            else if(msgTarget == "side")
            {
                $(current).after("<span name='"+msgTarget+"_errorIcon' style='color:red'><img src='/images/icon/exclamation.gif'>"+msg+"</span>");
            }
            else if(msgTarget == "under")
            {
                $(current).after("<div name='"+msgTarget+"_errorIcon' style='color:red;float:none;clear:both'><img src='/images/icon/exclamation.gif'>"+msg+"</div>");
            }
            else
            {
                $("#"+msgTarget).append("<span name='"+msgTarget+"_errorIcon' style='color:red'><img src='/images/icon/exclamation.gif'>"+msg+"</span>");
            }
        }
    }

    function getTargetName()
    {
        if (StringUtils.isNotBlank(targetName))
            return targetName;
        else
            return target;
    }

    function getValue(obj)
    {
        if($(obj).attr("emptyText") == "1") return "";
        if($(obj).find("option").length>0)
        {
            var value;
            $.each($(obj).find("option:selected"), function( i, n )
            {
                value = $(n).val();
            });
            value == "" ? null : value;
            return value;
        }
        else
            return $(obj).val();
    }

    var current = stk.form.getCheckTarget(id,target);
    var type = 0;
    var msg = "";

    if (current == undefined)
    {
        alert("未找到检查目标:" + target);
        return null;
    }
    if($(current).attr("cn") == "checkboxgroup" || $(current).attr("cn") == "radioboxgroup") type = "1";
    else if($(current).attr("cn") == "removableselect") type = "2";
    stk.form.cleanTip(current, msgTarget);
    if (allowBlank == "false")
    {
        if (StringUtils.isNotBlank(blankText))
            msg = blankText;
        else
            msg = getTargetName() + "不可为空";

        if (type == 0)
        {
            if (StringUtils.isBlank(getValue(current)))
            {
                displayTip(msg);
                return false;
            }
        }
        else if(type == 1){
            if ($(current).find("input:checked").length == 0)
            {
                displayTip(msg);
                return false;
            }
        }
        else if(type == 2){
            if ($(current).find("input").length == 0)
            {
                displayTip(msg);
                return false;
            }
        }
    }
    if(StringUtils.isNotBlank(getValue(current)))
    {
        if (StringUtils.isNotBlank(maxLength) && StringUtils.isAllNumber(maxLength) && new Number(maxLength) < (getValue(current)).length)
        {
            if (StringUtils.isNotBlank(maxLengthText))
                msg = maxLengthText;
            else
                msg = getTargetName() + "的最大长度是" + maxLength;
            if (type == 0)
            {
                displayTip(msg);
                return false;
            }
        }
        if (StringUtils.isNotBlank(minLength) && StringUtils.isAllNumber(minLength) && new Number(minLength) > (getValue(current)).length)
        {
            if (StringUtils.isNotBlank(minLengthText))
                msg = minLengthText;
            else
                msg = getTargetName() + "的最小长度是" + minLength;
            if (type == 0)
            {
                displayTip(msg);
                return false;
            }
        }
        if (StringUtils.isNotBlank(regex))
        {
            if (StringUtils.isNotBlank(regexText))
                msg = regexText;
            else
                msg = getTargetName() + "数据非法";
            if (type == 0)
            {
                var pattern = new RegExp(regex);
                if (!pattern.test(getValue(current)))
                {
                    displayTip(msg);
                    return false;
                }
            }
        }
    }
    if (StringUtils.isNotBlank(validator)) {
        var resultVal = eval(validator);
        if (resultVal != true)
            msg = resultVal;
        else
            msg = getTargetName() + "数据非法";
        if (type == 0) {
            if (resultVal != true) {
                displayTip(msg);
                return false;
            }
        }
    }
    return true;
};
stk.form.checkForm = function( id,ignor )
{
    stk.form.checkersMsg = "";
    var checkers = $("div[formId='"+id+"'][type='checkers']");
    var ignorMap = {};
    if(ignor != undefined)
    {
        for(var i = 0; i < ignor.length; i++)
        {
            ignorMap[ignor[i]] = true;
        }
    }
    if($(checkers).length==0)
    {
        alert("未配置Form检查器");
        return null;
    }
    var oneByOne = $(checkers).attr("oneByOne");
    var alertOnFalse = $(checkers).attr("alertOnFalse");
    var msgTarget = $(checkers).attr("msgTarget");
    if("alert" == msgTarget) oneByOne = "true";
    var allRight = true;
    var list = $(checkers).find("span[type='checker']");
    for(var i = 0; i < list.length; i++)
    {
        var result = true;
        var target = $(list[i]).attr("target");
        try{
            if(ignorMap[target] != true)
                result = stk.form.check(id,target);
        }catch(e){alert(e.description)}
        if(!result && allRight) allRight = false;
        if(oneByOne == "true" && !result) return false;
    }
    if("true" == alertOnFalse && StringUtils.isNotBlank(stk.form.checkersMsg))
    {
        stk.alert(stk.form.checkersMsg,"警告");
    }
    return allRight;
};
<!-- ################################################################## -->
<!-- ##                        8.  panel                             ## -->
<!-- ################################################################## -->
stk.panel={};
stk.panel.toggleCollapse = function(id)
{
    var obj = $("#"+id+"_collapse_button");
    var type = $(obj).attr("class");
    if(type == "stk_panel_collapse_button_open")
    {
        $(obj).removeClass("stk_panel_collapse_button_open").addClass("stk_panel_collapse_button_close");
        $("#"+id).slideDown();
    }
    else
    {
        $(obj).removeClass("stk_panel_collapse_button_close").addClass("stk_panel_collapse_button_open");
        $("#"+id).slideUp();
    }
};
stk.panel.collapse = function(id, bool)
{
    var obj = $("#"+id+"_collapse_button");
    if(bool)
    {
        $(obj).removeClass("stk_panel_collapse_button_open").addClass("stk_panel_collapse_button_close");
        $("#"+id).slideDown();
    }
    else
    {
        $(obj).removeClass("stk_panel_collapse_button_close").addClass("stk_panel_collapse_button_open");
        $("#"+id).slideUp();
    }
};
<!-- ################################################################## -->
<!-- ##                        9.  fieldSet                             ## -->
<!-- ################################################################## -->
stk.fieldset={};
stk.fieldset.toggleCollapse = function(id)
{
    var obj = $("#"+id+"_collapse_button");
    var type = $(obj).attr("class");
    if(type == "stk_fieldset_collapse_button_open")
    {
        $(obj).removeClass("stk_fieldset_collapse_button_open").addClass("stk_fieldset_collapse_button_close");
        $("#"+id+"_body").slideDown();
    }
    else
    {
        $(obj).removeClass("stk_fieldset_collapse_button_close").addClass("stk_fieldset_collapse_button_open");
        $("#"+id+"_body").slideUp();
    }
};
stk.fieldset.collapse = function(id, bool)
{
    var obj = $("#"+id+"_collapse_button");
    if(bool)
    {
        $(obj).removeClass("stk_fieldset_collapse_button_open").addClass("stk_fieldset_collapse_button_close");
        $("#"+id+"_body").slideDown();
    }
    else
    {
        $(obj).removeClass("stk_fieldset_collapse_button_close").addClass("stk_fieldset_collapse_button_open");
        $("#"+id+"_body").slideUp();
    }
};
<!-- ################################################################## -->
<!-- ##                      10. ClassifiedSelector                  ## -->
<!-- ################################################################## -->
stk.classifiedSelector={};
stk.classifiedSelector.init = function(id,result,options)
{
    var html = [];
    if(result == undefined || result == null) return;
    if(options.multiple == "false")
    {
        for(var i = 0; i < result.length; i++)
        {
            var object = result[i];
            if(options.allowSelectClass == "false")
                html.push("<div class='stk-child-o-row'><div class='stk-child-o-head'>"+object.text+"</div><div class='stk-child-o-list'>");
            else
                html.push("<div class='stk-child-o-row'><div class='stk-child-o-head'><a href='javascript:void(0)' dataId='"+object.id+"' multiple='"+options.multiple+"' onclick=stk.classifiedSelector.select('"+id+"',this)>"+object.text+"</a></div><div class='stk-child-o-list'>");
            if(object.children != undefined && object.children != null)
            {
                for(var j = 0; j < object.children.length; j++)
                {
                    var data = object.children[j];
                    html.push("<span title='"+data.text+"' alt='"+data.text+"' style='float:left;margin-right:2px;height:21px;overflow:hidden;word-break: break-all;width:"+options.cellWidth+"''><a href='javascript:void(0)' dataId='"+data.id+"' multiple='"+options.multiple+"' onclick=stk.classifiedSelector.select('"+id+"',this)>"+data.text+"</a></span>");
                }
            }
            html.push("</div></div>");
        }
    }
    else
    {
        if(options.selectAll)
        {
            html.push("<div class='stk-button stk-ext-button'><input type='checkbox' name='classify_all' id='class_all_"+options.id+"'><label for='class_all_"+options.id+"'>全选</label></div>");
        }
        for(var i = 0; i < result.length; i++)
        {
            var object = result[i];
                html.push("<div class='stk-child-o-row'><div class='stk-child-o-head'><input type='checkbox' name='classify' id='class"+id+"_"+object.id+"'><label for='class"+id+"_"+object.id+"'>"+object.text+"</label></div><div class='stk-child-o-list'>");
            if(object.children != undefined && object.children != null)
            {
                for(var j = 0; j < object.children.length; j++)
                {
                    var data = object.children[j];
                    html.push("<span title='"+data.text+"' alt='"+data.text+"' style='float:left;margin-right:2px;height:21px;overflow:hidden;word-break: break-all;width:"+options.cellWidth+"'><input name='sub"+id+"_"+object.id+"' id='sub"+id+"_"+j+"_"+object.id+"' type='checkbox' value='"+data.id+"'><label for='sub"+id+"_"+j+"_"+object.id+"'>"+data.text+"</label></span>");
                }
            }
            html.push("</div></div>");
        }
    }
    $("#"+id).find("div[name='content']").html(html.join("\n"));
    if(options.multiple == "true")
    {
        $("#"+id).find("div[name='buttonGroup']").html("<button type='button' class='stk-button stk-button-st-3' multiple='true' onclick=stk.classifiedSelector.select('"+id+"',this)><span>确定</span></button>");
        $.each($("#"+id).find("input[name='classify']"), function( i, n )
        {
            var _id = $(n).attr("id");
            var _name = "sub"+id+"_"+_id.split("_")[1];
            stk.checkBox.buildSelectAll(_id,_name);
        });
        if(options.selectAll)
        {
            $("#class_all_"+options.id ).bind("change",function(){
                $("#"+id).find("div[name='content']" ).find("input[type='checkbox']" ).attr("checked",$(this ).attr("checked"))
            })
            stk.checkBox.buildSelectAll("class_all"+id+"_"+options.id,"classify");
            $("#"+id).find("input[type='checkbox'][nmame!='classify_all']" ).bind("change",function(){
                var div = $("#"+id);
                $("#"+id).find("input[type='checkbox'][name='classify_all']" ).attr("checked",div.find("input[type='checkbox'][name!='classify_all']" ).length == div.find("input[type='checkbox'][name!='classify_all']:checked" ).length)
            })
        }
    }
    else
    {
        $("#"+id).find("div[name='buttonGroup']").html("<button type='button' class='stk-button stk-button-st-3' multiple='true' onclick=$('#"+id+"').stk_hide();><span>关闭</span></button>");
    }
};

stk.classifiedSelector.select = function(id,obj)
{
    var multiple = $(obj).attr("multiple");
    var dataId = $(obj).attr("dataId");
    if(multiple == "false")
    {
        var text = $(obj).text();
        window[id+"_interactFunction"](dataId,text);
    }
    else
    {
        var _data ={};
        $.each($("#"+id).find("input[name!='classify']:checked"), function( i, n )
        {
            _data[$(n).val()] = $(n).next().text();
        });
        window[id+"_interactFunction"](_data);
    }
    $("#"+id).stk_hide();
};

<!-- ################################################################## -->
<!-- ##                      11. LetterSelector                  ## -->
<!-- ################################################################## -->
stk.letterSelector={};
stk.letterSelector.init = function(id,result,options)
{
    var html = [];
    var htmlTab = [];
    htmlTab.push("<ul>");
    if(result == undefined || result == null) return;
    if(options.multiple == "false")
    {
            for(var i = 0; i < result.length; i++)
        {
            var object = result[i];
            htmlTab.push("<li><a href='javascript:void(0)' name='classify' num='"+i+"' onclick=stk.letterSelector.change('"+id+"',this) style='");
            if(i==0) htmlTab.push("background-color:#ffdddd;");
            htmlTab.push("'>"+object.text+"</a></li>");
            html.push("<div name='sub' class='stk-child-list' num='"+i+"' style='");
            if(i!=0) html.push("display:none");
            html.push("'>");
            if(object.children != undefined && object.children != null)
            {
                for(var j = 0; j < object.children.length; j++)
                {
                    var data = object.children[j];
                    html.push("<span title='"+data.text+"' alt='"+data.text+"' style='float:left;margin-right:2px;height:21px;word-break: break-all;overflow:hidden;width:"+options.cellWidth+"''><a href='javascript:void(0)' dataId='"+data.id+"' multiple='"+options.multiple+"' onclick=stk.classifiedSelector.select('"+id+"',this)>"+data.text+"</a></span>");
                }
            }
            html.push("</div></div>");
        }
    }
    else
    {
        for(var i = 0; i < result.length; i++)
        {
            var object = result[i];
            htmlTab.push("<li><a href='javascript:void(0)' name='classify' num='"+i+"' onclick=stk.letterSelector.change('"+id+"',this) style='");
            if(i==0) htmlTab.push("background-color:#ffdddd;");
            htmlTab.push("'>");
            if(options.selectAll)
            {
                htmlTab.push("<input type='checkbox' num='"+i+"' name='classify_all' id='class_all_"+i+"_"+options.id+"'>")
            }
            htmlTab.push(object.text+"</a></li>");
            html.push("<div name='sub' class='stk-child-list' num='"+i+"' style='");
            if(i!=0) html.push("display:none");
            html.push("'>");
            if(object.children != undefined && object.children != null)
            {
                for(var j = 0; j < object.children.length; j++)
                {
                    var data = object.children[j];
                    html.push("<span title='"+data.text+"' alt='"+data.text+"' style='float:left;margin-right:2px;height:21px;word-break: break-all;overflow:hidden;width:"+options.cellWidth+"'><input name='sub"+id+"_"+data.id+"' id='sub"+id+"_"+i+"_"+j+"_"+data.id+"' type='checkbox' value='"+data.id+"'><label for='sub"+id+"_"+i+"_"+j+"_"+data.id+"'>"+data.text+"</label></span>");
                }
            }
            html.push("</div></div>");
        }
    }
    htmlTab.push("</ul>");

    $("#"+id).find("div[name='tab']").html(htmlTab.join("\n"));
    $("#"+id).find("div[name='content']").html(html.join("\n"));
    if(options.multiple == "true")
    {
        $("#"+id).find("div[name='buttonGroup']").html("<button type='button' class='stk-button stk-button-st-3' multiple='true' onclick=stk.classifiedSelector.select('"+id+"',this)><span>确定</span></button>");
        $.each($("#"+id).find("input[name='classify']"), function( i, n )
        {
            var _id = $(n).attr("id");
            var _name = "sub"+id+"_"+_id.split("_")[1];
            stk.checkBox.buildSelectAll(_id,_name);
        });
        $("#"+id ).find("input[type='checkbox'][name='classify_all']" ).bind("change",function(){
            $("#"+id ).find("div[num='"+$(this).attr("num")+"']" ).find("input[type='checkbox']" ).attr("checked",$(this ).attr("checked"));
        })
    }
    else
    {
        $("#"+id).find("div[name='buttonGroup']").html("<button type='button' class='stk-button stk-button-st-3' multiple='true' onclick=$('#"+id+"').stk_hide();><span>关闭</span></button>");
    }
};

stk.letterSelector.select = function(id,obj)
{
    var multiple = $(obj).attr("multiple");
    var dataId = $(obj).attr("dataId");
    if(multiple == "false")
    {
        var text = $(obj).text();
        window[id+"_interactFunction"](dataId,text);
    }
    else
    {
        var _data ={};
        $.each($("#"+id).find("input[name!='classify']:checked"), function( i, n )
        {
            _data[$(n).val()] = $(n).next().text();
        });
        window[id+"_interactFunction"](_data);
    }
    $("#"+id).stk_hide();
};
stk.letterSelector.change = function(id,obj)
{
    var num = $(obj).attr('num');
    $("#"+id).find("a[name='classify']").css("background-color","white");
    $("#"+id).find("a[name='classify'][num='"+num+"']").css("background-color","#ffdddd");
    $("#"+id).find("div[name='sub']").hide();
    $("#"+id).find("div[name='sub'][num='"+num+"']").show();

};

<!-- ################################################################## -->
<!-- ##                      12. textField                                  ## -->
<!-- ################################################################## -->
stk.textField={};
stk.textField.isEmptyText = function(obj)
{
    return $(obj).attr("emptyText") == "1";
};
/********************************************************************
 **                        97. cache                               **
 ********************************************************************/
stk.cache = {};
stk.cache.pluginCheckbox = {};
stk.cache.pluginCheckbox.func = {};
stk.cache.pluginCheckbox.func.read = function(tableData,name)
{
    if(!stk.cache.pluginCheckbox[name])
        stk.cache.pluginCheckbox[name] = {};
    var tmp = stk.cache.pluginCheckbox[name];
    $.each($("input[type='checkbox'][name='"+name+"']"), function( i, n )
    {
        if( n.checked){
            tmp[n.value] = tableData[i];
        }
        else
        {
            if(tmp[n.value])
                delete tmp[n.value];
        }
    });
    stk.cache.pluginCheckbox[name] = tmp;
};

stk.cache.pluginCheckbox.func.write = function(tableData,name)
{
    var data = stk.cache.pluginCheckbox[name];
    if(data == undefined || data == null) return;
    var chbox = $("input[name='" + name + "']");
    chbox.each(function(i,dom){
        var value = data[dom.value];
        if(value){
            dom.checked = true;
        }
    });
};
stk.cache.pluginCheckbox.func.val = function(name)
{
    var data = stk.cache.pluginCheckbox[name];
    if(data == undefined || data == null) return;
    var result = [];
    for (var property in data)
    {
        var value = data[property];
        if(value)
        {
            result.push(value);
        }
    }
    return result;
}
/********************************************************************
 **                        98. eventMap                            **
 ********************************************************************/
stk.eventMap={};
stk.eventMap.val={};
stk.eventMap.hasBind = function(id,event)
{
    return stk.eventMap.val[id + "_" + event] == true;
};
stk.eventMap.add = function(id, event)
{
    stk.eventMap.val[id+"_"+event] = true;
};
/********************************************************************
 **                        99. framework                            **
 ********************************************************************/
stk.remoteCount = 0;
stk.displayUserLoadingMessage = function(loadingMessage)
{
    $(document).stk_showMask();
};
stk.hideUserLoadingMessage = function()
{
     $(document).stk_closeMask();
};
stk.useLoadingMessage = function( message )
{
    try{
        var loadingMessage;
        if ( message ) loadingMessage = message;
        else loadingMessage = "读取数据...";

        dwr.engine.setPreHook(function()
        {
            stk.displayUserLoadingMessage(loadingMessage);
        });
        var _recordOver = true;
        dwr.engine.setPostHook(function()
        {
            stk.hideUserLoadingMessage();
        });
    }
    catch(e){}
};

stk.fixIE9TableBug = function(el) {
    var expr = new RegExp('>[ \t\r\n\v\f]*<', 'g');
    el = $(el);
    el.html(el.html().replace(expr, '><'));
}
$(document).ready(function(){
    stk.useLoadingMessage();
});
