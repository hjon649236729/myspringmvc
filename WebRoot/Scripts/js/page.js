function go_page(url, args) {
	var form = $("<form method='post'></form>"), input;
	form.attr({
		"action" : url
	});
	$.each(args, function(key, value) {
		input = $("<input type='hidden'>");
		input.attr({
			"name" : key
		});
		input.val(value);
		form.append(input);
	});
	form.submit();
}
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