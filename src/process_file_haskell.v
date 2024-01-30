module main

import os
import regex

fn is_haskell_file(file string) bool {
	return file.ends_with('.hs')
}

fn process_file_haskell(mut dep &DependencyGraph) ! {
	mut name := dep.file_path.split(os.path_separator)
	if name.len == 0 {
		return error("not a file ${dep.file_path}")
	}
	if name[0] == '.' {
		name.drop(1)
	}
	if 'src' in name {
		name.drop(name.index('src'))
	}
	if 'app' in name {
		name.drop(name.index('app'))
	}
	name[name.len - 1] = name.last().all_before_last(os.file_ext(name.last()))
	dep.name << name
	query := r'^import (qualified )? *([\w\.]+)'
	mut re := regex.regex_opt(query)!
	lines := os.read_file(dep.file_path)!
	imports := re.find_all_str(lines)
	for imp in imports {
		re.match_string(imp)
		dep_tmp := re.get_group_by_id(imp, 1)
		dep.dependencies << dep_tmp.split('.')
	}
}
