(function($){
var myflow = $.myflow;

/**
 * props:{所有内容}
 * k:{props中的某个的名字}
 * div:{一般都是“p”+k}
 * src:{a.rect}
 * r:{}
 */




$.extend(true, myflow.editors, {
    textLaber : function(arg){
        var _props,_k,_div,_src,_r;
        this.init = function(props, k, div, src, r){
            _props=props; _k=k; _div=div; _src=src; _r=r;

            var label = $('<label style="width:99%;"/>').text(props[_k].value).appendTo('#'+_div);

            if(typeof arg === 'string'){
                $.ajax({
                    type: "POST",
                    url: myflow.config.basePath + arg,
                    cache:false,
                    async: false,
                    success: function(data){
                        label.text(data);
                    }
                });
            }

            $('#'+_div).data('editor', this);
        }
        this.destroy = function(){
            if (!myflow.config.editable) {
                return;
            }
            $('#'+_div+' label').each(function(){
                _props[_k].value = $(this).html();
            });
        }
    },
	inputEditor : function(){
		var _props,_k,_div,_src,_r;
		this.init = function(props, k, div, src, r){
			_props=props; _k=k; _div=div; _src=src; _r=r;

            if (!myflow.config.editable) {
                $("<label></label>").text(props[_k].value).appendTo("#" + _div);
                $("#" + _div).data("editor", this);
                return;
            }

			$('<input style="width:99%;"/>').val(props[_k].value).appendTo('#'+_div);
			
			$('#'+_div).data('editor', this);
		}
		this.destroy = function(){
            if (!myflow.config.editable) {
                return;
            }
			$('#'+_div+' input').each(function(){
				_props[_k].value = $(this).val();
			});
		}
	},
    textAreaEditor : function(){
        var _props,_k,_div,_src,_r;
        this.init = function(props, k, div, src, r){
            _props=props; _k=k; _div=div; _src=src; _r=r;

            if (!myflow.config.editable) {
                $("<label></label>").text(props[_k].value.replaceAll("\n", "</br>")).appendTo("#" + _div);
                $("#" + _div).data("editor", this);
                return;
            }

            $('<textarea rows="3" style="width:99%;"/>').val(props[_k].value).appendTo('#'+_div);

            $('#'+_div).data('editor', this);
        }
        this.destroy = function(){
            if (!myflow.config.editable) {
                return;
            }
            $('#'+_div+' textarea').each(function(){
                _props[_k].value = $(this).val();
            });
        }
    },
	selectEditor : function(arg){
		var _props,_k,_div,_src,_r;
		this.init = function(props, k, div, src, r){
			_props=props; _k=k; _div=div; _src=src; _r=r;

            var options = "", _label = "";
            if (typeof arg === 'string') {
                $.ajax({
                    type: "POST",
                    url: myflow.config.basePath + arg,
                    async: false,
                    success: function (data) {
                        var opts = eval(data);
                        if (opts && opts.length) {
                            for (var idx = 0; idx < opts.length; idx++) {
                                options += ("<option value=\"" + opts[idx].value + "\">" + opts[idx].name + "</option>");
                                if (opts[idx].value == props[_k].value){
                                    _label = opts[idx].name;
                                }
                            }
                        }
                    }
                });
            } else {
                for (var idx = 0; idx < arg.length; idx++) {
                    options += ("<option value=\"" + arg[idx].value + "\">" + arg[idx].name + "</option>");
                    if (arg[idx].value == props[_k].value){
                        _label = arg[idx].name;
                    }
                }
            }

            if (!myflow.config.editable) {
                $("<label></label>").text(_label).appendTo("#" + _div);
                $("#" + _div).data("editor", this);
                return;
            }

            $("<select style=\"width: 99%\">" + options + "</select>").val(props[_k].value).appendTo("#" + _div);

            $('#' + _div).data('editor', this);
		};
		this.destroy = function(){
            if (!myflow.config.editable) {
                return;
            }
			$('#'+_div+' select').each(function(){
				_props[_k].value = $(this).val();
			});
		};
	},

    /**
     * 选人按钮
     */
    selectOrg : function(){
        var _props,_k,_div,_src,_r;
        this.init = function(props, k, div, src, r){
            _props=props; _k=k; _div=div; _src=src; _r=r;

            if (!myflow.config.editable) {
                var _ownernames = "";
                if(props[_k].value) {
                    var _org = props[_k].value.split(",");
                    for (var i = 0; i < _org.length; i++) {
                        _ownernames += _org[i].split(":")[1] + ",";
                    }
                    if (_ownernames.substring(_ownernames.length - 1, _ownernames.length) == ",") {
                        _ownernames = _ownernames.substring(0, _ownernames.length - 1)
                    }
                }else{
                    _ownernames = "无";
                }
                $("<label></label>").text(_ownernames).appendTo("#" + _div);
                $("#" + _div).data("editor", this);
                return;
            }

            $('<input type="button" style="width:100px;"/>').val(props[_k].btname).click(function(){
                myflow.config.tools.showorg.onclick("_showorgdiv", _k);
            }).appendTo('#'+_div);

            $("<div id=\"_showorgdiv\" class=\"phone-result-table\"/>").html(props[_k].showdiv).appendTo('#'+_div);

            $("<input id=\"" + _k + "\" type=\"hidden\"/>").val(props[_k].value).appendTo('#'+_div);

            if(!props[_k].showdiv && props[_k].value)
                showframe("user", "_showorgdiv", _k, "www", props[_k].value);           //用于初始化

            $('#'+_div).data('editor', this);
        }
        this.destroy = function(){
            if (!myflow.config.editable) {
                return;
            }

            _props[_k].value = $("#" + _k).val();
            _props[_k].showdiv = $("#_showorgdiv").html();
        }
    },

    /**
     * 选择处理类型
     */
    selectJudgeType : function(arg){
        var _props,_k,_div,_src,_r;
        this.init = function(props, k, div, src, r){
            _props=props; _k=k; _div=div; _src=src; _r=r;

            var _value1, _value2, _value3, _value4;
            if(props[_k].value){
                _value1 = props[_k].value.split(':')[0];
                _value2 = props[_k].value.split(':')[1];
                _value3 = props[_k].value.split(':')[2];
                _value4 = props[_k].value.split(':')[3];
            }
            if (!_value1) _value1 = 1;
            if (!_value2) _value2 = 1;
            if (!_value3) _value3 = "";
            if (!_value4) _value4 = 0;


            var sle1 = $("<select id=\"JudgeType\" style=\"width: 32%; \"></select>");
            var sle2 = $("<select id=\"CooJudge\" style=\"width:40%; margin-left: 3px;\"></select>");
            var sle3 = $("<input id=\"CooJudgeAds\" style=\"width:50px; margin-left: 3px;\"/>");
            var sle4 = $("<select id=\"ResultDeal\" style=\"width:35%; margin-left: 3px;\"></select>");

            var _laber1 = "", _laber2 = "", _laber4 = "";
//            if(typeof arg === 'string'){
//                $.ajax({
//                    type: "POST",
//                    url: myflow.config.basePath + arg,
//                    async: false,
//                    success: function(data){
                        var _opts = _judgetypeList;//eval(data);
                        if(_opts && _opts.length){
                            var opts = _opts[0];
                            if (opts.JudgeType && opts.JudgeType.length) {
                                var tmp = opts.JudgeType;
                                for (var idx = 0; idx < tmp.length; idx++) {
                                    sle1.append('<option value="' + tmp[idx].value + '">' + tmp[idx].name + '</option>');
                                    if (tmp[idx].value == _value1){
                                        _laber1 = tmp[idx].name;
                                    }
                                }
                                sle1.val(_value1);
                            }
                            if(opts.CooJudge && opts.CooJudge.length){
                                var tmp = opts.CooJudge;
                                for (var idx = 0; idx < tmp.length; idx++) {
                                    sle2.append('<option value="' + tmp[idx].value + '">' + tmp[idx].name + '</option>');
                                    if (tmp[idx].value == _value2){
                                        _laber2 = tmp[idx].name;
                                    }
                                }
                                sle2.val(_value2);
                            }
                            if(opts.ResultDeal && opts.ResultDeal.length){
                                var tmp = opts.ResultDeal;
                                for (var idx = 0; idx < tmp.length; idx++) {
                                    sle4.append('<option value="' + tmp[idx].value + '">' + tmp[idx].name + '</option>');
                                    if (tmp[idx].value == _value4){
                                        _laber4 = tmp[idx].name;
                                    }
                                }
                                sle4.val(_value4);
                            }
                        }
//                    }
//                });
//            }

            if (!myflow.config.editable) {      //只读模式
                var _laber = _laber1;
                if(_value1 == 1){
                }else if(_value1 == 2 || _value1 == 5){
                    _laber += "    " + _laber2 + "    " + _value3;
                }else if(_value1 == 100){
                    _laber += "    " + _laber4;
                }
                $("<label></label>").text(_laber).appendTo("#" + _div);
                $("#" + _div).data("editor", this);
                return;
            }

            sle1.val(_value1).change(function(){
                _value1 = $(this).val();
                if(_value1 == 1){
                    sle2.hide();
                    sle3.hide();
                    sle4.hide();
                }else if(_value1 == 2 || _value1 == 5){     //投票和等待
                    sle2.show();
                    sle3.show();
                    sle4.hide();
                }else if(_value1 == 100){
                    sle2.hide();
                    sle3.hide();
                    sle4.show();
                }
            }).appendTo('#'+_div);
            sle2.val(_value2).appendTo('#'+_div);
            sle3.val(_value3).appendTo('#'+_div);
            sle4.val(_value4).appendTo('#'+_div);
            sle1.trigger("change");


            $('#'+_div).data('editor', this);
        }
        this.destroy = function(){
            if (!myflow.config.editable) {
                return;
            }

            var _value1 = $("#JudgeType").val();
            var _value2 = $("#CooJudge").val();
            var _value3 = $("#CooJudgeAds").val();
            var _value4 = $("#ResultDeal").val();
            _props[_k].value = _value1 + ":" + _value2 + ":" + _value3 + ":" + _value4;
        }
    },

    /**
     * 选择步骤条件
     */
    selectStepCondition : function(arg){
        var _props,_k,_div,_src,_r;

        this.init = function(props, k, div, src, r){
            _props=props; _k=k; _div=div; _src=src; _r=r;


            var linkIfTypeOptions, mathMarkOptions, judgeResultOptions, linkIfResultOptions;
            var _linkIfTypeLaber = {},  _mathMarkLaber = {}, _judgeResultLaber = {}, _linkIfResultLaber = {};
//            if(typeof arg === 'string'){
//                $.ajax({
//                    type: "POST",
//                    url: myflow.config.basePath + arg,
//                    async: false,
//                    success: function(data){
                        var _opts = _stepconditionlist; //eval(data);
                        if(_opts && _opts.length){
                            var opts = _opts[0];
                            if (opts.LinkIfType && opts.LinkIfType.length) {
                                var tmp = opts.LinkIfType;
                                for (var idx = 0; idx < tmp.length; idx++) {
                                    linkIfTypeOptions += ('<option value="' + tmp[idx].value + '">' + tmp[idx].name + '</option>');
                                    _linkIfTypeLaber[tmp[idx].value] = tmp[idx].name;
                                }
                            }
                            if(opts.MathMark && opts.MathMark.length){
                                var tmp = opts.MathMark;
                                for (var idx = 0; idx < tmp.length; idx++) {
                                    mathMarkOptions += ('<option value="' + tmp[idx].value + '">' + tmp[idx].name + '</option>');
                                    _mathMarkLaber[tmp[idx].value] = tmp[idx].name;
                                }
                            }
                            if(opts.JudgeResult && opts.JudgeResult.length){
                                var tmp = opts.JudgeResult;
                                for (var idx = 0; idx < tmp.length; idx++) {
                                    judgeResultOptions += ('<option value="' + tmp[idx].value + '">' + tmp[idx].name + '</option>');
                                    _judgeResultLaber[tmp[idx].value] = tmp[idx].name;
                                }
                            }
                            if(opts.LinkIfResult && opts.LinkIfResult.length){
                                var tmp = opts.LinkIfResult;
                                for (var idx = 0; idx < tmp.length; idx++) {
                                    linkIfResultOptions += ('<option value="' + tmp[idx].value + '">' + tmp[idx].name + '</option>');
                                    _linkIfResultLaber[tmp[idx].value] = tmp[idx].name;
                                }
                            }
                        }
//                    }
//                });
//            }

            var maintable = $("<table></table>");
            var maintr1 = $("<tr></tr>");
            var maintd11 = $("<td></td>");
            maintd11.appendTo(maintr1);

            var maintr2 = $("<tr></tr>");
            var maintd21 = $("<td></td>");
            maintd21.appendTo(maintr2);
            var stepConditionTable = $("<table id=\"stepConditionTable\"></table>");
            stepConditionTable.appendTo(maintd21);

            maintr1.appendTo(maintable);
            maintr2.appendTo(maintable);
            maintable.appendTo('#'+_div);

            if(!myflow.config.editable) {
                if(_props[_k].value){
                    var conditionArrArr = _props[_k].value.split(",");
                    var table = $("#stepConditionTable");
                    for (var i = 0, j = 1; i < conditionArrArr.length; i++, j++) {
                        var conditionMark = conditionArrArr[i];
                        var conditionArr = conditionMark.split(":");
                        var option;

                        var tr = $("<tr></tr>");

                        var td1 = $("<td></td>");

                        var lian0 = $('<label style="margin-left: 3px;display:inline;"></label>').text(_linkIfTypeLaber[conditionArr[0]]).appendTo(td1);
                        var lian1 = $('<label style="margin-left: 5px;display:inline;"></label>').text(_mathMarkLaber[conditionArr[1]]).appendTo(td1);
                        var lian3 = $('<label style="margin-left: 5px;display:inline;"></label>').appendTo(td1);
                        var lian2 = $('<label style="margin-left: 5px;display:inline;"></label>').appendTo(td1);

                        td1.appendTo(tr);
                        tr.appendTo(table);

                        lian0.parent().parent().parent().stk_show();
                        lian0.show();

                        if (conditionArr[0] == 1) {
                            lian1.stk_show();
                            lian2.stk_show();
                            lian2.text(_judgeResultLaber[conditionArr[2]]);
                        } else if (conditionArr[0] == 2) {
                            lian1.show();
                            lian2.show();
                            lian3.hide();
                            lian2.text(_judgeResultLaber[conditionArr[2]]);
                        } else if (conditionArr[0] == 4) {
                            lian1.show();
                            lian2.hide();
                            lian3.hide();
                        } else if (conditionArr[0] >= 100000) {
                            lian1.hide();
                            lian2.hide();
                            lian3.show();
                            lian3.text(_linkIfResultLaber[conditionArr[2]]);
                        }
                    }
                }
                return;
            }


            $("<input type=\"hidden\" id=\"stepifnum\" name=\"stepifnum\"/>").val(0).appendTo('#'+_div);


            var mainbt1 = $('<input type="button" style="width:60px;margin-left: 5px;margin-right: 5px;"/>').val("添加").click(function () {
                $("#stepifnum").stk_val(parseInt($("#stepifnum").stk_val())+1);
                var num = parseInt($("#stepifnum").stk_val());
                var option;

                var table = $("#stepConditionTable");
                var tr = $("<tr></tr>");

                var td1 = $("<td></td>");
                $("<a href='javascript:void(0)' title='删除'><b class='icon-del'></b></a>").click(function(){
                    $(this).parent().parent().stk_remove();
                }).appendTo(td1);

                var select0 = $("<select id=\"stepifmain"+ num +"\" style=\"width:150px; margin-left: 3px;display:none;\"></select>").change(function(){
                    var status = $(this).attr("id").substring(10);
                    if ($(this).val() == 1) {
                        var lian = $("#stepifand" + status);
                        var lian2 = $("#stepif2ads" + status);
                        lian.stk_show();
                        lian2.stk_show();
                    } else if ($(this).val() == 2) {
                        var lian = $("#stepifand" + status);
                        var lian2 = $("#stepif2ads" + status);
                        var lian3 = $("#stepif3ads" + status);
                        lian.stk_show();
                        lian2.stk_show();
                        lian3.stk_hide();
                    } else if ($(this).val() == 4) {
                        var lian = $("#stepifand" + status);
                        lian.stk_show();
                        var lian2 = $("#stepif2ads" + status);
                        var lian3 = $("#stepif3ads" + status);
                        lian2.stk_hide();
                        lian3.stk_hide();
                    } else if ($(this).val() >= 100000) {
                        var lian = $("#stepifand" + status);
                        lian.stk_hide();
                        var lian2 = $("#stepif2ads" + status);
                        lian2.stk_hide();
                        var lian3 = $("#stepif3ads" + status);
                        lian3.stk_show();
                    }
                });
                option = $(linkIfTypeOptions);
                option.appendTo(select0);
                select0.appendTo(td1);
                select0.val(2);

                var select21 = $("<select id=\"stepifand"+num +"\" style=\"width:40px; margin-left: 3px;display:none;\"></select>");
                option = $(mathMarkOptions);
                option.appendTo(select21);
                select21.appendTo(td1);
                select21.val(1);

                var select22 = $("<select id=\"stepif3ads"+num +"\" style=\"width:60px;margin-left: 3px;display:none;\"></select>");
                option = $(linkIfResultOptions);
                option.appendTo(select22);
                select22.appendTo(td1);
                select22.val(0);

                var select31 = $("<select id=\"stepif2ads"+num +"\" style=\"width:60px;margin-left: 3px;display:none;\"></select>");
                option = $(judgeResultOptions);
                option.appendTo(select31);
                select31.appendTo(td1);
                select31.val(1);

                td1.appendTo(tr);
                tr.appendTo(table);

                $("#stepifmain"+$("#stepifnum").stk_val()).parent().parent().parent().stk_show();
                $("#stepifmain"+$("#stepifnum").stk_val()).stk_show();
                $("#stepifand"+$("#stepifnum").stk_val()).stk_show();
                $("#stepif2ads"+$("#stepifnum").stk_val()).stk_show();
                $("#stepif3ads"+$("#stepifnum").stk_val()).stk_hide();
            });

            mainbt1.appendTo(maintd11);




            //初始化操作
            if(_props[_k].value){
                var conditionArrArr = _props[_k].value.split(",");
                $("#stepifnum").val(conditionArrArr.length);
                var table = $("#stepConditionTable");
                for (var i = 0, j = 1; i < conditionArrArr.length; i++, j++) {
                    var conditionMark = conditionArrArr[i];
                    var conditionArr = conditionMark.split(":");
                    var option;

                    var tr = $("<tr></tr>");

                    var td1 = $("<td></td>");
                    $("<a href='javascript:void(0)' title='删除'><b class='icon-del'></b></a>").click(function(){
                        $(this).parent().parent().stk_remove();
                    }).appendTo(td1);

                    var select0 = $("<select id=\"stepifmain"+j +"\" style=\"width:150px; margin-left: 3px;display:none;\"></select>").change(function(){
                        var status = $(this).attr("id").substring(10);
                        if ($(this).val() == 1) {
                            var lian = $("#stepifand" + status);
                            var lian2 = $("#stepif2ads" + status);
                            lian.stk_show();
                            lian2.stk_show();
                        } else if ($(this).val() == 2) {
                            var lian = $("#stepifand" + status);
                            var lian2 = $("#stepif2ads" + status);
                            var lian3 = $("#stepif3ads" + status);
                            lian.show();
                            lian2.show();
                            lian3.hide();
                        } else if ($(this).val() == 4) {
                            var lian = $("#stepifand" + status);
                            lian.show();
                            var lian2 = $("#stepif2ads" + status);
                            var lian3 = $("#stepif3ads" + status);
                            lian2.hide();
                            lian3.hide();
                        } else if ($(this).val() >= 100000) {
                            var lian = $("#stepifand" + status);
                            lian.hide();
                            var lian2 = $("#stepif2ads" + status);
                            lian2.hide();
                            var lian3 = $("#stepif3ads" + status);
                            lian3.show();
                        }
                    });
                    option = $(linkIfTypeOptions);
                    option.appendTo(select0);
                    select0.appendTo(td1);

                    var select21 = $("<select id=\"stepifand"+j +"\" style=\"width:40px;margin-left: 3px;display:none;\"></select>");
                    option = $(mathMarkOptions);
                    option.appendTo(select21);
                    select21.appendTo(td1);

                    var select22 = $("<select id=\"stepif3ads"+j +"\" style=\"width:60px;margin-left: 3px;display:none;\"></select>");
                    option = $(linkIfResultOptions);
                    option.appendTo(select22);
                    select22.appendTo(td1);

                    var select31 = $("<select id=\"stepif2ads"+j +"\" style=\"width:60px;margin-left: 3px;display:none;\"></select>");
                    option = $(judgeResultOptions);
                    option.appendTo(select31);
                    select31.appendTo(td1);

                    td1.appendTo(tr);
                    tr.appendTo(table);

                    $("#stepifmain" + j).parent().parent().parent().stk_show();
                    $("#stepifmain" + j).show();
                    $("#stepifand" + j).show();
                    $("#stepif2ads" + j).show();
                    $("#stepifmain" + j).val(conditionArr[0]);
                    $("#stepifmain" + j).trigger("change");
                    $("#stepifand" + j).val(conditionArr[1]);
                    $("#stepif2ads" + j).val(conditionArr[2]);
                    $("#stepif3ads" + j).val(conditionArr[2]);
                }
            }


            $('#'+_div).data('editor', this);
        }
        this.destroy = function(){
            if (!myflow.config.editable) {
                return;
            }
            // 临时保存数据
            var conditionNum = $("#stepifnum").stk_val();
            var conditionArray = new Array();
            var conditionMarkArray = new Array();
            var _showtext  = new Array();
            var _num = 1;
            for(var i=1;i<=conditionNum;i++) {
                var condition = $("#stepifmain" + i).find("option:selected").text();
                var conditionId = $("#stepifmain" + i).find("option:selected").val();
                var choice="";
                var state="";
                var stateId = 0;
                if(conditionId<100000){
                    choice = $("#stepifand" + i).find("option:selected").text();
                    if(conditionId==4){
                        state = $("#stepif4ads" + i).find("option:selected").text();
                        stateId = $("#stepif4ads" + i).find("option:selected").val();
                    }else{
                        state = $("#stepif2ads" + i).find("option:selected").text();
                        stateId = $("#stepif2ads" + i).find("option:selected").val();
                    }
                }else if(conditionId>=100000){
                    state = $("#stepif3ads" + i).find("option:selected").text();
                    stateId = $("#stepif3ads" + i).find("option:selected").val();
                }
                var choiceId = $("#stepifand" + i).find("option:selected").val();
                if(condition==undefined || conditionId==undefined || choice==undefined || choiceId==undefined || state==undefined || stateId==undefined)
                    continue;

                var conditionDesc = condition + " " + choice + " " + state;
                conditionArray.push(conditionDesc);
                var conditionMarkDesc = conditionId + ":" + choiceId + ":" + stateId ;
                conditionMarkArray.push(conditionMarkDesc);

                if(_num < 3){
                    _showtext.push(conditionDesc);
                }else if(_num == 3){
                    _showtext.push("。。。");
                }
                _num++;

            }
            _props[_k].value = conditionMarkArray.toString();
            if(StringUtils.isBlank(_showtext)){
                _showtext.push("条件");
            }
            $(_r).trigger("textchange", [_showtext.toString().replaceAll(",", "\n"), _src]);
        }
    },

    /**
     * 选择步骤执行
     */
    selectStepLinkDo : function(arg){
        var _props,_k,_div,_src,_r;
        this.init = function(props, k, div, src, r){
            _props=props; _k=k; _div=div; _src=src; _r=r;


            var specialTaskOptions;
            var _specialTaskLaber = {};
//            if(typeof arg === 'string'){
//                $.ajax({
//                    type: "POST",
//                    url: myflow.config.basePath + arg,
//                    async: false,
//                    success: function(data){
                        var opts = arg; //eval(data);
                        if (opts && opts.length) {
                            for (var idx = 0; idx < opts.length; idx++) {
                                specialTaskOptions += ("<option value=\"" + opts[idx].value + "\">" + opts[idx].name + "</option>");
                                _specialTaskLaber[opts[idx].value] = opts[idx].name;
                            }
                        }
//                    }
//                });
//            }

            var maintable = $("<table></table>");
            var maintr1 = $("<tr></tr>");
            var maintd11 = $("<td></td>");
            maintd11.appendTo(maintr1);

            var maintr2 = $("<tr></tr>");
            var maintd21 = $("<td></td>");
            maintd21.appendTo(maintr2);
            var stepConditionTable = $("<table id=\"" + _div + "stepExecuteTable\"></table>");
            stepConditionTable.appendTo(maintd21);

            maintr1.appendTo(maintable);
            maintr2.appendTo(maintable);
            maintable.appendTo('#'+_div);


            if(!myflow.config.editable) {       //只读模式
                if(_props[_k].value){
                    var autoTaskArrArr = _props[_k].value.split(",");
                    var table = $("#" + _div + "stepExecuteTable");
                    for (var i = 0, j = 1; i < autoTaskArrArr.length; i++, j++) {
                        var autoTaskMark = autoTaskArrArr[i];

                        var tr = $("<tr></tr>").appendTo(table);
                        var td1 = $("<td></td>").appendTo(tr);

                        var _laber223 = $('<label style="margin-left: 5px;display:none;"/>').text(_specialTaskLaber[autoTaskMark]).appendTo(td1);

                        _laber223.parent().parent().parent().show();
                        _laber223.show();
                    }
                }
                return;
            }


            $("<input type=\"hidden\" id=\"" + _div + "stepdonum\"/>").val(0).appendTo('#'+_div);

            var mainbt1 = $('<input type="button" style="width:60px;margin-left: 5px;margin-right: 5px;"/>').val("添加").click(function () {
                $("#" + _div + "stepdonum").stk_val(parseInt($("#" + _div + "stepdonum").stk_val())+1);
                var num = parseInt($("#" + _div + "stepdonum").stk_val());
                var option;

                var table = $("#" + _div + "stepExecuteTable");
                var tr = $("<tr></tr>");

                var td1 = $("<td></td>");
                $("<a href='javascript:void(0)' title='删除'><b class='icon-del'></b></a>").click(function(){
                    $(this).parent().parent().stk_remove();
                }).appendTo(td1);

                var select0 = $("<select id=\"" + _div + "stepdomain"+num +"\" style=\"width:150px;margin-left: 5px;display:none;\"></select>");
                option = $(specialTaskOptions);
                option.appendTo(select0);
                select0.appendTo(td1);

                td1.appendTo(tr);
                tr.appendTo(table);

                $("#" + _div + "stepdomain"+$("#" + _div + "stepdonum").stk_val()).parent().parent().parent().show();
                $("#" + _div + "stepdomain"+$("#" + _div + "stepdonum").stk_val()).show();
            });

            mainbt1.appendTo(maintd11);

            if(_props[_k].value){
                 var autoTaskArrArr = _props[_k].value.split(",");
                 $("#" + _div + "stepdonum").val(autoTaskArrArr.length);
                 var table = $("#" + _div + "stepExecuteTable");
                 for (var i = 0, j = 1; i < autoTaskArrArr.length; i++, j++) {
                     var autoTaskMark = autoTaskArrArr[i];
                     var option;

                     var tr = $("<tr></tr>");

                     var td1 = $("<td></td>");
                     $("<a href='javascript:void(0)' title='删除'><b class='icon-del'></b></a>").click(function(){
                         $(this).parent().parent().stk_remove();
                     }).appendTo(td1);

                     var select21 = $("<select id=\"" + _div + "stepdomain"+j +"\" style=\"width:150px;margin-left: 5px;display:none;\"></select>");
                     option = $(specialTaskOptions);
                     option.appendTo(select21);
                     select21.appendTo(td1);

                     td1.appendTo(tr);
                     tr.appendTo(table);

                     $("#" + _div + "stepdomain" + j).parent().parent().parent().show();
                     $("#" + _div + "stepdomain" + j).show();
                     $("#" + _div + "stepdomain" + j).val(autoTaskMark);
                 }
            }

            $('#'+_div).data('editor', this);
        }
        this.destroy = function(){
            if (!myflow.config.editable) {
                return;
            }
            var autotaskNum = $("#" + _div + "stepdonum").stk_val();
            var autotaskArray = new Array();
            var autotaskMarkArray = new Array();
            for(var i=1;i<=autotaskNum;i++) {
                var autotask = $("#" + _div + "stepdomain" + i).find("option:selected").text();
                var autotaskId = $("#" + _div + "stepdomain" + i).find("option:selected").val();
                if(autotaskId == undefined || StringUtils.isBlank(autotaskId)){
                    continue;
                }
                autotaskArray.push(autotask);
                autotaskMarkArray.push(autotaskId);
            }
            _props[_k].value = autotaskMarkArray.toString();
        }
    },

    /**
     * 选择消息通知
     */
    selectMessageNotice : function(arg){
        var _props,_k,_div,_src,_r;
        this.init = function(props, k, div, src, r){
            _props=props; _k=k; _div=div; _src=src; _r=r;

            var sle1 = $("<select id=\"messagenotice\" style=\"width: 35%; \"></select>");
            var sle2 = $("<select id=\"specialnoticer\" style=\"width:32%; margin-left: 3px;\"></select>");
            var bt1 = $('<input type="button" style="width:60px;margin-left: 5px;margin-right: 5px;"/>').val(props[_k].btname).click(function () {
                myflow.config.tools.showorg.onclick("_shownoticeownersdiv", "noticeowners");
            });

            var _laber1 = "", _laber2 = "";
//            if(typeof arg === 'string'){
//                $.ajax({
//                    type: "POST",
//                    url: myflow.config.basePath + arg,
//                    async: false,
//                    success: function(data){
                        var _opts = _messagenoticelist;//eval(data);
                        if(_opts && _opts.length){
                            var opts = _opts[0];
                            if (opts.messagenotice && opts.messagenotice.length) {
                                var tmp = opts.messagenotice;
                                for (var idx = 0; idx < tmp.length; idx++) {
                                    sle1.append('<option value="' + tmp[idx].value + '">' + tmp[idx].name + '</option>');
                                    if(tmp[idx].value == _props[_k].value){
                                        _laber1 = tmp[idx].name;
                                    }
                                }
                                sle1.val(_props[_k].value);
                            }
                            if(opts.specialnoticer && opts.specialnoticer.length){
                                var tmp = opts.specialnoticer;
                                for (var idx = 0; idx < tmp.length; idx++) {
                                    sle2.append('<option value="' + tmp[idx].value + '">' + tmp[idx].name + '</option>');
                                    if(tmp[idx].value == _props[_k].specialnoticer){
                                        _laber2 = tmp[idx].name;
                                    }
                                }
                                sle2.val(_props[_k].specialnoticer);
                            }
                        }
//                    }
//                });
//            }

            if (!myflow.config.editable) {      //只读模式
                var _ownernames = "";
                if(_props[_k].noticeowners) {
                    var _org = _props[_k].noticeowners.split(",");
                    for (var i = 0; i < _org.length; i++) {
                        _ownernames += _org[i].split(":")[1] + ",";
                    }
                    if (_ownernames.substring(_ownernames.length - 1, _ownernames.length) == ",") {
                        _ownernames = _ownernames.substring(0, _ownernames.length - 1)
                    }
                }else{
                    _ownernames = "无";
                }

                var _showtable = $("<table></table>").appendTo("#" + _div);
                var _showtr1 = $("<tr></tr>").appendTo(_showtable);
                var _showtr2 = $("<tr></tr>").appendTo(_showtable);
                var _showtr3 = $("<tr></tr>").appendTo(_showtable);
                var _td11 = $("<td style='text-align: left;'></td>").appendTo(_showtr1);
                var _td12 = $("<td></td>").appendTo(_showtr1);
                var _td21 = $("<td style='text-align: left;'></td>").appendTo(_showtr2);
                var _td22 = $("<td></td>").appendTo(_showtr2);
                var _td31 = $("<td style='text-align: left;'></td>").appendTo(_showtr3);
                var _td32 = $("<td></td>").appendTo(_showtr3);
                $("<label></label>").text("通知模板").appendTo(_td11);
                $("<label></label>").text("通知人").appendTo(_td21);
                $("<label></label>").text("特殊逻辑").appendTo(_td31);
                $('<label style="margin-left: 10px"></label>').text(_laber1).appendTo(_td12);
                $('<label style="margin-left: 10px"></label>').text(_ownernames).appendTo(_td22);
                $('<label style="margin-left: 10px"></label>').text(_laber2).appendTo(_td32);

//                $('<label style="margin-left: 10px;"/>').text(_laber1).appendTo(_td12);
//                $('<label style="margin-left: 10px;"/>').text(_ownernames).appendTo(_td22);
//                $('<label style="margin-left: 10px;"/>').text(_laber2).appendTo(_td32);

                $("#" + _div).data("editor", this);
                return;
            }


            var table = $("<table></table>");
            var _tr1 = $("<tr></tr>");
            var _tr2 = $("<tr></tr>");
            var _td1 = $("<td></td>");
            var _td2 = $("<td></td>");

            sle1.appendTo(_td1);
            bt1.appendTo(_td1);
            sle2.appendTo(_td1);

            $("<div id=\"_shownoticeownersdiv\" class=\"phone-result-table\"/>").html(props[_k].showdiv).change(function(){
//                props[_k].showdiv = $(this).html();
            }).appendTo(_td2);
            _td1.appendTo(_tr1);
            _td2.appendTo(_tr2);
            _tr1.appendTo(table);
            _tr2.appendTo(table);
            table.appendTo('#'+_div);

            $("<input id=\"noticeowners\" type=\"hidden\"/>").val(_props[_k].noticeowners).appendTo('#'+_div);

            if(!props[_k].showdiv && _props[_k].noticeowners)
                showframe("user", "_shownoticeownersdiv", "noticeowners", "www", _props[_k].noticeowners);           //用于初始化

            $('#'+_div).data('editor', this);
        }
        this.destroy = function(){
            if (!myflow.config.editable) {
                return;
            }
            _props[_k].value = $("#messagenotice").val();
            _props[_k].showdiv = $("#_shownoticeownersdiv").html();
            _props[_k].noticeowners = $("#noticeowners").val();
            _props[_k].specialnoticer = $("#specialnoticer").val();
        }
    },

    /**
     * 目标处理
     */
    selectOwnerLink: function (arg) {
        var _props, _k, _div, _src, _r;
        this.init = function (props, k, div, src, r) {
            _props = props;
            _k = k;
            _div = div;
            _src = src;
            _r = r;

            if (!myflow.config.editable) {

                $("<a href=\"javascript:void(0)\" class='ownerlinka'>查看目标处理</a>").click(function () {
                    $("#showownerlinkwindow").stk_show();
                    $("#showownerlinktable").find(".ownerlinktr").each(function () {
                        $(this).remove();
                    });

                    var ownerlinkIds2 = _props[_k].value;
                    var ownertypes2 = _props[_k].ownertype;
                    var ownerstarters2 = _props[_k].ownerstarter;
                    var ownerenders2 = _props[_k].ownerender;
                    var autoskips2 = _props[_k].autoskip;

                    //  初始化操作
                    if (StringUtils.isNotBlank(ownerlinkIds2)) {
                        var table = $("#showownerlinktable");

                        var linkidsArr = ownerlinkIds2.split(",");
                        var ownertypesArr = ownertypes2.split(",");
                        var ownerstartersArr = ownerstarters2.split(";");
                        var ownerendersArr = ownerenders2.split(";");
                        var autoskipsArr = autoskips2.split(",");

                        var _opts = _ownerlink.ownerlinkoriginlist;     //eval("${ownerlinkoriginlistJSON}");
                        var _typenames = {};
                        for (var i = 0; i < _opts.length; i++) {
                            _typenames[_opts[i].key] = _opts[i].value;
                        }

                        for (var k = 0; k < linkidsArr.length; k++) {
                            var linkmark = linkidsArr[k];
                            var linkoriginid = ownertypesArr[k];
                            var linkorigin = _typenames[linkoriginid];
                            var startowner = ownerstartersArr[k];
                            var endowner = ownerendersArr[k];
                            var ownerautoskip = autoskipsArr[k];

                            var tr = $("<tr class=\"ownerlinktr\"></tr>");

                            var td1 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
                            var td2 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
                            var td3 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");

                            $("<div style='padding-left:7px;padding-top:5px;'>" + linkorigin + "</div>" +
                                "<input type='hidden' id='ownertype" + linkmark + "' name='ownertype" + linkmark + "' value='" + linkoriginid + "'/>").appendTo(td1);

                            if (startowner != null && startowner.length != 0) {
                                var starter = "";
                                var starterArr = startowner.split(",");
                                for (var i = 0; i < starterArr.length; i++) {
                                    var starterArrArr = starterArr[i].split(":");
                                    starter += starterArrArr[1] + "，";
                                }
                                $("<div style='padding-left:7px;padding-top:5px;'>" + starter.substring(0, starter.length - 1) + "</div>" +
                                    "<input type='hidden' id='ownerstarter" + linkmark + "' name='ownerstarter" + linkmark + "' value='" + startowner + "'>").appendTo(td2);
                            }
                            if (endowner != null && endowner.length != 0) {
                                var ender = "";
                                var enderArr = endowner.split(",");
                                for (var i = 0; i < enderArr.length; i++) {
                                    var enderArrArr = enderArr[i].split(":");
                                    ender += enderArrArr[1] + "，";
                                }
                                $("<div style='padding-left:7px;padding-top:5px;'>" + ender.substring(0, ender.length - 1) + "</div>" +
                                    "<input type='hidden' id='ownerender" + linkmark + "' name='ownerender" + linkmark + "' value='" + endowner + "'>").appendTo(td3);
                            }

                            td1.appendTo(tr);
                            td2.appendTo(tr);
                            td3.appendTo(tr);
                            tr.appendTo(table);
                        }
                    }

                }).appendTo('#' + _div);

                $("#" + _div).data("editor", this);
                return;
            }

            $("#ownerlinkIds").stk_val(_props[_k].value);
            $("#ownertypes").stk_val(_props[_k].ownertype);
            $("#ownerstarters").stk_val(_props[_k].ownerstarter);
            $("#ownerenders").stk_val(_props[_k].ownerender);
            $("#autoskips").stk_val(_props[_k].autoskip);
            $("#ownerlinkmark").val(-1);

            $("<a href=\"javascript:void(0)\" class='ownerlinka'>编辑目标处理</a>").click(function () {
                $("#managerownerlinkwindow").stk_show();
                $("#ownerlinktable").find(".ownerlinktr").each(function () {
                    $(this).remove();
                });
                $("#ownerlinkmark").val(-1);
                var ownerlinkIds2 = $("#ownerlinkIds").stk_val();
                var ownertypes2 = $("#ownertypes").stk_val();
                var ownerstarters2 = $("#ownerstarters").stk_val();
                var ownerenders2 = $("#ownerenders").stk_val();
                var autoskips2 = $("#autoskips").stk_val();

                //  初始化操作
                if (StringUtils.isNotBlank(ownerlinkIds2)) {
                    var table = $("#ownerlinktable");

                    var linkidsArr = ownerlinkIds2.split(",");
                    var ownertypesArr = ownertypes2.split(",");
                    var ownerstartersArr = ownerstarters2.split(";");
                    var ownerendersArr = ownerenders2.split(";");
                    var autoskipsArr = autoskips2.split(",");

                    var _opts = _ownerlink.ownerlinkoriginlist;  //eval("${ownerlinkoriginlistJSON}");
                    var _typenames = {};
                    for (var i = 0; i < _opts.length; i++) {
                        _typenames[_opts[i].key] = _opts[i].value;
                    }

                    for (var k = 0; k < linkidsArr.length; k++) {
                        var linkmark = linkidsArr[k];
                        var linkoriginid = ownertypesArr[k];
                        var linkorigin = _typenames[linkoriginid];
                        var startowner = ownerstartersArr[k];
                        var endowner = ownerendersArr[k];
                        var ownerautoskip = autoskipsArr[k];

                        if (linkmark < 0) {
                            $("#ownerlinkmark").val(parseInt(linkmark) < parseInt($("#ownerlinkmark").val()) ? linkmark - 1 : $("#ownerlinkmark").val() - 1);
                        }
                        var tr = $("<tr class=\"ownerlinktr\" id=\"ownerlink" + linkmark + "\"></tr>");

                        var td0 = $("<td class='stk-table-td' align='center' width='4%' style='border:1px #BBBBBB solid;'>" +
                            "<input type='checkbox' id='" + linkmark + "' name='ownerlink' value=" + linkmark + " onclick=\"selectmainownerlink();\"></td>");
                        var td1 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
                        var td2 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
                        var td3 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
                        var param = "<a href='javascript:void(0)' onclick=\"editOwnerLinkInfo('" + startowner + "','" + endowner + "'," + linkmark + "," + linkoriginid + "," + ownerautoskip + ");\">编辑</a>";
                        var tdInfo = "<td align='center' class='stk-table-td' style='border:1px #BBBBBB solid;'>" + param + "</td>";
                        var td4 = $(tdInfo);
                        var td5 = $("<td class='stk-table-td' align='center' style='border:1px #BBBBBB solid;'>" +
                            "<input type='hidden' id='autoskip" + linkmark + "' name='autoskip" + linkmark + "' value='" + ownerautoskip + "'/>" +
                            "<a href='javascript:void(0)' onclick='moveOwnerUp(this)'><b class=\"icon-st16\"></b></a>&nbsp;|&nbsp;" +
                            "<a href='javascript:void(0)' onclick='moveOwnerDown(this)'><b class=\"icon-st17\"></a>" + "</td>");

                        $("<div style='padding-left:7px;padding-top:5px;'>" + linkorigin + "</div>" +
                            "<input type='hidden' id='ownertype" + linkmark + "' name='ownertype" + linkmark + "' value='" + linkoriginid + "'/>").appendTo(td1);

                        if (startowner != null && startowner.length != 0) {
                            var starter = "";
                            var starterArr = startowner.split(",");
                            for (var i = 0; i < starterArr.length; i++) {
                                var starterArrArr = starterArr[i].split(":");
                                starter += starterArrArr[1] + "，";
                            }
                            $("<div style='padding-left:7px;padding-top:5px;'>" + starter.substring(0, starter.length - 1) + "</div>" +
                                "<input type='hidden' id='ownerstarter" + linkmark + "' name='ownerstarter" + linkmark + "' value='" + startowner + "'>").appendTo(td2);
                        }
                        if (endowner != null && endowner.length != 0) {
                            var ender = "";
                            var enderArr = endowner.split(",");
                            for (var i = 0; i < enderArr.length; i++) {
                                var enderArrArr = enderArr[i].split(":");
                                ender += enderArrArr[1] + "，";
                            }
                            $("<div style='padding-left:7px;padding-top:5px;'>" + ender.substring(0, ender.length - 1) + "</div>" +
                                "<input type='hidden' id='ownerender" + linkmark + "' name='ownerender" + linkmark + "' value='" + endowner + "'>").appendTo(td3);
                        }

                        td0.appendTo(tr);
                        td1.appendTo(tr);
                        td2.appendTo(tr);
                        td3.appendTo(tr);
                        td4.appendTo(tr);
                        td5.appendTo(tr);
                        tr.appendTo(table);
                    }
                }

            }).appendTo('#' + _div);

            $('#' + _div).data('editor', this);
        }
        this.destroy = function () {
            if (!myflow.config.editable) {
                return;
            }
            //  目标处理的数据保存
            _props[_k].value = $("#ownerlinkIds").val();
            _props[_k].ownertype = $("#ownertypes").val();
            _props[_k].ownerstarter = $("#ownerstarters").val();
            _props[_k].ownerender = $("#ownerenders").val();
            _props[_k].autoskip = $("#autoskips").val();
        }
    }


});

})(jQuery);