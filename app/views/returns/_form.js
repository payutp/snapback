<script type="text/javascript">
$(function() {
	//$(".chzn-select").attr("data-placeholder", "select email..");
	//$(".chzn-select").chosen({ max_selected_options: 1 });
	var tags = <%= @people.map{ |i| i.email}.to_json.html_safe %>;
	$("#to_email").autocomplete({
		source: tags
	});

	$("#return_date").datepicker({ minDate: 0 });
});
</script>