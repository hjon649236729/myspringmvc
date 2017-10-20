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