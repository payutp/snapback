// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap
//= require_tree .

$(function() {
	tag = "";
	checked = [];
	allTags = [];

	// Click listener to allow clicking off navigation views to hide them
	var clearNav = function() {
		$('#tagView').css('display','none');
		$('#tagView').empty();
		tag = "";
	}
	$('html').click(clearNav);
	// Handler when a tag is checked/unchecked
	var tag_handler = function () {
		$('input').click(function(e){
			event.stopPropagation();
			console.log("clicked")
			var type = this.type;
			if (type == "checkbox") {
				console.log("checkbox")
				var chk = this.checked
				if (chk) {
					console.log("CHECKED")
					var d = $('#' +editing).data('tags');
					d.push(parseInt($(this).val()));
					$('#' +editing).data('tags',d);
					console.log($('#' +editing).data('tags'))
	    			$.ajax({ url : "add_tag",
					 success : function (result) {
						msg = result.msg;
						if (msg.indexOf("Success") > -1) {
						}
					 },
					 type : 'POST',
					 data : {tag_id:$(this).val(),note_id:$('#'+editing).data('note_id')}
					});
				} else {
					var d = $('#' +editing).data('tags');
					delete d[d.indexOf(parseInt($(this).val()))];
					$('#' +editing).data('tags',d);
					$.ajax({ url : "remove_tag",
					 success : function (result) {
						msg = result.msg;
						if (msg.indexOf("Success") > -1) {
						}
					 },
					 type : 'POST',
					 data : {tag_id:$(this).val(),note_id:$('#'+editing).data('note_id')}
					});
				}
			}
		});
	};

	// Method to allow user to load all tags from the database
	var viewTags = function(id,tags,checked) {
		var view = '<div class="tagView" id="tagView_'+id+'"></div>'
		if (id < 0){
			var position = $('#btn_filter').position();
			$('.footer').append(view);
			$("#tagView_-1").offset({left:position.left,top:position.top+300});
		} else {
			$('#note_'+id).append(view);
		}
		$.each(tags,function(index,value) {
			var c = "";
			if (checked.indexOf(value.id) > -1) {
				c = "checked";
			}
			var checkbox = '<input type="checkbox" value="'+value.id+'"'+c+'>'+value.tag+'<br>';
			$('#tagView_'+id).append(checkbox);
		});
		var input = '<input type="text" id="newTag_'+id+'" placeholder="New Tag...">';
		$('#tagView_'+id).append(input);
		$('#newTag_'+id).click(function(e){
			event.stopPropagation();
		});

		tag_handler();

		// Handler to add a new tag when needed
		$('#newTag_'+id).keypress(function(e) {
			if(e.which == 13) {
	        	$.ajax({ url : "create_tag",
				 success : function (result) {
					msg = result.msg;
					if (msg.indexOf("Success") > -1) {
						var checkbox = '<input type="checkbox" value="'+result.tag.id+'">'+result.tag.tag+'<br>';
						$('#newTag_'+id).before(checkbox);
						$('#newTag_'+id).val('');
						tag_handler();
					}
				 },
				 type : 'POST',
				 data : {tag:{tag:$('#newTag_'+id).val()}}
				});
			};
		});
	};

	// Method to allow user to load all tags from the database
	var viewFilterTags = function(id,tags) {
		var view = $('#tagView');
		if (id < 0){
			var position = $('#btn_filter').offset();
			$('#btn_filter').after(view);
			$("#tagView_-1").offset({left:position.left,top:position.top});
		} else {
			$('#note_'+id).append(view);
		}
		$.each(tags,function(index,value) {
			if (allTags.indexOf(value.id) == -1){
				allTags.push(value.id);
				checked.push(value.id);
			}
			var c = "";
			if (checked.indexOf(value.id) > -1) {
				c = "checked";
			}
			var checkbox = '<input type="checkbox" value="'+value.id+'"'+c+'>'+value.tag+'<br>';
			view.append(checkbox);
		});

		// Handler to change view when tags are checked/unchecked
		$('input').click(function(e){
			event.stopPropagation();
			var t = parseInt($(this).val());
			var type = this.type;
			if (type == "checkbox") {
				var chk = this.checked
				if (chk) {
	    			$('.lend').each(function(index){
	    				if ($(this).data('tags').indexOf(t) > -1) {
	    					$(this).css('display','table-row');
	    				}
	    			});
				} else {
					$('.lend').each(function(index){
	    				if ($(this).data('tags').indexOf(t) > -1) {
	    					$(this).css('display','none');
	    					console.log(checked[checked.indexOf(t)]);
	    					delete checked[checked.indexOf(t)];
	    					console.log(checked);
	    				}
	    			});
				}
			}
		});
	};

	// Handler for filter button
	$('#btn_filter').click(function(e) {
		console.log("CLICK")
		event.stopPropagation();
		if (tag != "") {
			$('#tagView').css('display','none');
			$('#tagView').empty();
			tag = ""
		} else {
			tag = 'btn_filter';
			$('#tagView').css('display','block');
			$.ajax({ url : "get_tags",
				 success : function (result) {
					msg = result.msg;
					if (msg.indexOf("Success") > -1) {
						if (typeof(result.tags) != "undefined") {
							viewFilterTags(-1,result.tags,result.checked);
						}
					}
				 },
				 type : 'POST',
				 data : {id:"all"}
			});
		}

	});

});