
(function ($) {
    var myflow = $.myflow;

    $.extend(true, myflow.config.rect, {
        attr: {
            r: 8,
            fill: '#F6F7FF',
            stroke: '#03689A',
            "stroke-width": 2
        }
    });

//    $.extend(true, myflow.config.props.props, {
//        name: {name: 'name', label: '流程名称', value: '新建流程', editor: function () {
//            return new myflow.editors.inputEditor();
//        }},
//        processcode: {name: 'processcode', label: '流程code', value: '', editor: function () {
//            return new myflow.editors.inputEditor();
//        }},
//        processtype: {name: 'processtype', label: '流程类型', value: '', editor: function () {
//            return new myflow.editors.textLaber("getProcessTypeName.action?processtype=" + myflow.config.processtype);
//        }},
//        processbrief: {name: 'processbrief', label: '流程备注', value: '', editor: function () {
//            return new myflow.editors.textAreaEditor();
//        }}
//    });


    $.extend(true, myflow.config.tools.states, {
        'start': {
            showType: 'image',
            type: 'start',
            name: {text: '<<start>>'},
            text: {text: '开始步骤'},
            img: {src: '/workflow/configurate/drawprocess/img/48/start_event_empty.png', width: 48, height: 48},
//            attr: {width: 50, heigth: 50 , r: 25, fill: "#7fd924", stroke: "#AAA", "stroke-width": 1},
            attr: {width: 50, heigth: 50 },
            props: {
                stepname: {name: 'stepname', label: '步骤名称', value: '', editor: function () {
                    return new myflow.editors.stepnameEditor();
                }},
                stepcode: {name: 'stepcode', label: '', value: '0'},
                steptype: {name: 'steptype', label: '步骤类型', value: '开始节点', editor: function () {
                    return new myflow.editors.textLaber();
                }}
            }},
        'end': {
            showType: 'image',
            type: 'end',
            name: {text: '<<end>>'},
            text: {text: '结束步骤'},
            img: {src: '/workflow/configurate/drawprocess/img/48/end_event_terminate.png', width: 48, height: 48},
            attr: {width: 50, heigth: 50 },
            props: {
                stepname: {name: 'stepname', label: '步骤名称', value: '', editor: function () {
                    return new myflow.editors.stepnameEditor();
                }},
                stepcode: {name: 'stepcode', label: '', value: '0'},
                steptype: {name: 'steptype', label: '步骤类型', value: '结束节点', editor: function () {
                    return new myflow.editors.textLaber();
                }},
                steppredo: {name: 'steppredo', label: '步骤前执行', value: '', editor: function () {
                    return new myflow.editors.selectStepLinkDo(_specialtaskList);
                }}
            }},
        'submit': {
            showType: 'text',
            type: 'submit',
            name: {text: '<<submit>>'},
            text: {text: '提交步骤'},
            img: {src: '/workflow/configurate/drawprocess/img/48/task_yellow.png', width: 48, height: 48},
            attr: {x: 10, y: 10, width: 100, height: 50, r: 5, fill: "90-#fff-#F7E9BC", stroke: "#000", "stroke-width": 1},
            props: {
                stepname: {name: 'stepname', label: '步骤名称', value: '', editor: function () {
                    return new myflow.editors.stepnameEditor();
                }},
                stepcode: {name: 'stepcode', label: '', value: '0'},
                steptype: {name: 'steptype', label: '步骤类型', value: '提交节点', editor: function () {
                    return new myflow.editors.textLaber();
                }},
                pointtypeid: {name: 'pointtypeid', label: '步骤阶段', value: '0', editor: function () {
                    return new myflow.editors.selectEditor(_pointtypelist);
                }},
                processurl: {name: 'processurl', label: '处理页面', value: '0', editor: function () {
                    return new myflow.editors.selectEditor(_processurllist);
                }},
                submitowner: {name: 'submitowner', label: '处理类型', value: '2', editor: function () {
                    return new myflow.editors.selectEditor(_submitownerlist);
                }},
                conditionowner: {name: 'conditionowner', label: '默认处理人', value: '',showdiv: '' , btname: '处理人', editor: function () {
                    return new myflow.editors.selectOrg();
                }},
                stepdealer: {name: 'stepdealer', label: '自定义处理人', value: '0', editor: function () {
                    return new myflow.editors.selectEditor(_stepdealerlist);
                }},
                agenttype: {name: 'agenttype', label: '代理设置', value: '2', editor: function () {
                    return new myflow.editors.selectEditor([{'name':'允许代理','value':1},{'name':'禁止代理','value':2}]);
                }},
                phoneshow: {name: 'phoneshow', label: '手机展示', value: '-1', editor: function () {
                    return new myflow.editors.selectEditor([{'name':'禁止手机展示','value':-1},{'name':'允许手机展示','value':1}]);
                }},
                messageremind: {name: 'messageremind', label: '任务提醒', value: '', editor: function () {
                    return new myflow.editors.selectEditor(_messageremindlist);
                }},
                messagenotice: {name: 'messagenotice', label: '消息通知', value: '', btname: '通知人', noticeowners:"", showdiv: '', specialnoticer:"", editor: function () {
                    return new myflow.editors.selectMessageNotice();
                }},
                steppredo: {name: 'steppredo', label: '步骤前执行', value: '', editor: function () {
                    return new myflow.editors.selectStepLinkDo(_specialtaskList);
                }},
                stepaftdo: {name: 'stepaftdo', label: '步骤后执行', value: '', editor: function () {
                    return new myflow.editors.selectStepLinkDo(_specialtaskList);
                }}
            }},
        'judge': {
            showType: 'text',
            type: 'judge',
            name: {text: '<<judge>>'},
            text: {text: '处理步骤'},
            img: {src: '/workflow/configurate/drawprocess/img/48/task_empty.png', width: 48, height: 48},
            props: {
                stepname: {name: 'stepname', label: '步骤名称', value: '', editor: function () {
                    return new myflow.editors.stepnameEditor();
                }},
                stepcode: {name: 'stepcode', label: '', value: '0'},
                steptype: {name: 'steptype', label: '步骤类型', value: '处理节点', editor: function () {
                    return new myflow.editors.textLaber();
                }},
                pointtypeid: {name: 'pointtypeid', label: '步骤阶段', value: '0', editor: function () {
                    return new myflow.editors.selectEditor(_pointtypelist);
                }},
                processurl: {name: 'processurl', label: '处理页面', value: '0', editor: function () {
                    return new myflow.editors.selectEditor(_processurllist);
                }},
                judgetype: {name: 'judgetype', label: '处理类型', value: '', editor: function () {
                    return new myflow.editors.selectJudgeType();
                }},
                conditionowner: {name: 'conditionowner', label: '默认处理人', value: '',showdiv: '' , btname: '处理人', editor: function () {
                    return new myflow.editors.selectOrg();
                }},
                ownerlink: {name: 'ownerlink', label:'目标处理', value:'', ownertype:"", ownerstarter:"", ownerender:"", autoskip:"", editor: function(){
                    return new myflow.editors.selectOwnerLink();
                }},
                stepdealer: {name: 'stepdealer', label: '自定义处理人', value: '0', editor: function () {
                    return new myflow.editors.selectEditor(_stepdealerlist);
                }},
                agenttype: {name: 'agenttype', label: '代理设置', value: '2', editor: function () {
                    return new myflow.editors.selectEditor([{'name':'允许代理','value':1},{'name':'禁止代理','value':2}]);
                }},
                phoneshow: {name: 'phoneshow', label: '手机展示', value: '-1', editor: function () {
                    return new myflow.editors.selectEditor([{'name':'禁止手机展示','value':-1},{'name':'允许手机展示','value':1}]);
                }},
                messageremind: {name: 'messageremind', label: '任务提醒', value: '', editor: function () {
                    return new myflow.editors.selectEditor(_messageremindlist);
                }},
                messagenotice: {name: 'messagenotice', label: '消息通知', value: '', btname: '通知人', noticeowners:"", showdiv: '', specialnoticer:"", editor: function () {
                    return new myflow.editors.selectMessageNotice();
                }},
                steppredo: {name: 'steppredo', label: '步骤前执行', value: '', editor: function () {
                    return new myflow.editors.selectStepLinkDo(_specialtaskList);
                }},
                stepaftdo: {name: 'stepaftdo', label: '步骤后执行', value: '', editor: function () {
                    return new myflow.editors.selectStepLinkDo(_specialtaskList);
                }}
            }},
        'state': {
            showType: 'text',
            type: 'state',
            name: {text: '<<state>>'},
            text: {text: '条件'},
            img: {src: '/workflow/configurate/drawprocess/img/48/task_empty.png', width: 48, height: 48},
            attr: {x: 10, y: 10, width: 50, height: 50, r: 5, fill: "#b1c9ed", stroke: "#000", "stroke-width": 0},
            props: {
                stepcondition: {name: 'stepcondition', label: '步骤条件', value: '', editor: function () {
                    return new myflow.editors.selectStepCondition();
                }},
                steplinkdo: {name: 'steplinkdo', label: '步骤执行', value: '', editor: function () {
                    return new myflow.editors.selectStepLinkDo(_specialtaskList);
                }}
            }},


        'task': {
            showType: 'image&rect',
            type: 'task',
            name: {text: '<<task>>'},
            text: {text: '任务'},
            img: {src: '/workflow/configurate/drawprocess/img/48/task_java.png', width: 48, height: 48},
            attr: {width: 50, heigth: 50 },
            props: {
                text: {name: 'text', label: '显示', value: '', editor: function () {
                    return new myflow.editors.textEditor();
                }, value: '任务'},
                assignee: {name: 'assignee', label: '用户', value: '', editor: function () {
                    return new myflow.editors.inputEditor();
                }},
                form: {name: 'form', label: '表单', value: '', editor: function () {
                    return new myflow.editors.inputEditor();
                }},
                desc: {name: 'desc', label: '描述', value: '', editor: function () {
                    return new myflow.editors.inputEditor();
                }}
            }},

        'end-cancel': {
            showType: 'image',
            type: 'end-cancel',
            name: {text: '<<end-cancel>>'},
            text: {text: '取消'},
            img: {src: '/workflow/configurate/drawprocess/img/48/end_event_cancel.png', width: 48, height: 48},
            attr: {width: 50, heigth: 50 },
            props: {
                text: {name: 'text', label: '显示', value: '', editor: function () {
                    return new myflow.editors.textEditor();
                }, value: '取消'},
                temp1: {name: 'temp1', label: '文本', value: '', editor: function () {
                    return new myflow.editors.inputEditor();
                }},
                temp2: {name: 'temp2', label: '选择', value: '', editor: function () {
                    return new myflow.editors.selectEditor([
                        {name: 'aaa', value: 1},
                        {name: 'bbb', value: 2}
                    ]);
                }}
            }},
        'end-error': {
            showType: 'image',
            type: 'end-error',
            name: {text: '<<end-error>>'},
            text: {text: '错误1'},
            img: {src: '/workflow/configurate/drawprocess/img/48/end_event_error.png', width: 48, height: 48},
            attr: {width: 50, heigth: 50 },
            props: {
                text: {name: 'text', label: '显示', value: '错误2', editor: function () {
                    return new myflow.editors.textEditor();
                }, valuename: '错误3'}
            }},
        'fork': {
            showType: 'image',
            type: 'fork',
            name: {text: '<<fork>>'},
            text: {text: '分支'},
            img: {src: '/workflow/configurate/drawprocess/img/48/gateway_parallel.png', width: 48, height: 48},
            attr: {width: 50, heigth: 50 },
            props: {
                text: {name: 'text', label: '显示', value: '', editor: function () {
                    return new myflow.editors.textEditor();
                }, value: '分支'},
                temp1: {name: 'temp1', label: '文本', value: '', editor: function () {
                    return new myflow.editors.inputEditor();
                }},
                temp2: {name: 'temp2', label: '选择', value: '', editor: function () {
                    return new myflow.editors.selectEditor('select.json');
                }}
            }},
        'join': {
            showType: 'image',
            type: 'join',
            name: {text: '<<join>>'},
            text: {text: '合并'},
            img: {src: '/workflow/configurate/drawprocess/img/48/gateway_parallel.png', width: 48, height: 48},
            attr: {width: 50, heigth: 50 },
            props: {
                text: {name: 'text', label: '显示', value: '', editor: function () {
                    return new myflow.editors.textEditor();
                }, value: '合并'},
                temp1: {name: 'temp1', label: '文本', value: '', editor: function () {
                    return new myflow.editors.inputEditor();
                }},
                temp2: {name: 'temp2', label: '选择', value: '', editor: function () {
                    return new myflow.editors.selectEditor('select.json');
                }}
            }},
        'linkif': {
            showType: 'image',
            type: 'linkif',
            name: {text: '<<linkif>>'},
            text: {text: '条件'},
            img: {src: '/workflow/configurate/drawprocess/img/48/gateway_parallel.png', width: 48, height: 48},
            attr: {width: 50, heigth: 50 },
            props: {
                brief: {name: 'brief', label: '说明', value: '用于指向两个状态', editor: function () {
                    return new myflow.editors.textLaber();
                }}
            }}
    });
})(jQuery);