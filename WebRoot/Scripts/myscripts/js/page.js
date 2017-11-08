function Previous() {
	var pageNum = $("#pageNum").val();
	if (pageNum > 1) {
		$("#pageNum").val(pageNum * 1 - 1);
		$("#submit").click();
	}
}
function Next() {
	var pageNum = $("#pageNum").val();
	var pageCount = $("#pageCount");
	if (pageNum < pageCount) {
		$("#pageNum").val(eval(pageNum * 1 + 1));
		$("#submit").click();
	}
}

function ajax_post(url,data){
	$.ajax({
		cache : true,
		type : "POST",
		url : "quartzsave.action",
		data : $('#quartzform').serialize(),// 你的formid
		async : false,
		error : function(request) {
			return false;
		},
		success : function(data) {
			return true;
		}
	});
}