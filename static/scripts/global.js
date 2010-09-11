var page_info = {
	'color': [ 
			'00ff00',
			'ffff00',
			'c0c0c0',
			'808080',
			'008000',
			'ff00ff',
			'800080',
			'0000ff',
			'000080'
	],
	'seen_color': {
	},
	'translation': {
	},
};

{
	var num = 0;

	function copy_player (row) {
		var node = row.cloneNode(true);
		var id = row.id;
		if (num <= 0) {
			var matches = id.match(/p(\d+)/);
			num = parseInt(matches[1]);
		}
		var orig_num = num;

		num++;

		if (num >= page_info.color.length) {
			alert(page_info.translations.no_more_players);
			return false;
		}

		var header = dojo.byId('h' + orig_num).cloneNode(true);
		header.id = 'h' + num;

		row.parentNode.appendChild(header);
		
		// change player number on header
		dojo.query('.id', header).forEach(function (sub_node) {
			var num = parseInt(sub_node.innerHTML);
			sub_node.innerHTML = (num + 1);
		});

		node.id = 'p' + num;

		row.parentNode.appendChild(node);

		dojo.query('input[type!=\'button\'],select', node).forEach(function (sub_node) {
				sub_node.name = sub_node.name.replace(/_\d+$/, '_' + num);
				sub_node.value = '';
		});

		dojo.query('.colorSelect', node).forEach(function(sel) {
			while(sel.options[sel.selectedIndex].value in page_info.seen_color)
				sel.selectedIndex++;

			change_color(sel, 1);
		});

		return false;
	}
}

function change_color (tar_sel, do_tar_sel) {
	tar_sel.style.backgroundColor = tar_sel.value;

	var num = page_info.seen_color[tar_sel.value] = get_id_from_input(tar_sel);
	var color_to_add;
	var color_to_add_idx;

	for(var idx in page_info.seen_color) {
		if (page_info.seen_color[idx] == num && idx != tar_sel.value) {
			color_to_add = idx;
			delete page_info.seen_color[idx];
			var color_to_add_idx = dojo.indexOf(page_info.color, idx);
		}
	}

	dojo.query('.colorSelect', dojo.byId('players')).forEach(function (sel) {
		if (!do_tar_sel && tar_sel.name == sel.name)
			return;

		if (color_to_add)
			add_opt_to_select(sel, color_to_add, color_to_add_idx);

		for (var opt_num = 0; opt_num < sel.options.length; ++opt_num) {
			if (sel.selectedIndex == opt_num)
				continue;

			if (sel.options[opt_num].value in page_info.seen_color)
				sel.remove(opt_num);
		}
	});
}

function add_opt_to_select (sel, color, place) {
	if (sel.options[place] && sel.options[place].value == color)
		return;

	var opt = create_opt(color);

	if (document.all)
		sel.add(opt, place);
	else
		sel.add(opt, sel.options[place]);
}

function get_id_from_input(inp) {
	var match = inp.parentNode.parentNode.id.match(/p(\d)$/);
	return match[1];
}

function create_opt(color) {
	var opt = document.createElement('option');
	opt.style.backgroundColor = '#' + color;
	opt.innerHTML = page_info.translations.choose_colour;
	opt.value = color;
	return opt;
}

function build_color () {
	dojo.query('.colorSelect', dojo.byId('players')).forEach(function (sel) {

		for (var idx in page_info.color) {
			var color = page_info.color[idx];
			var opt = create_opt(color);

			if (idx = 0)
				sel.selected = 1;

			sel.appendChild(opt);
		}

		change_color(sel);
	});
}
