module main

import os
import regex

fn is_haskell_file(file string) bool {
	return file.ends_with('.hs')
}

fn process_file_haskell(mut dep &DependencyGraph) ! {
	mut name := dep.file_path.split(os.path_separator)
	if 'src' in name {
		name.drop(name.index('src'))
	}
	if 'app' in name {
		name.drop(name.index('app'))
	}
	dep.name << name.join('.')
	query := r'^import (qualified)? ([\w.]+)'
	mut re := regex.regex_opt(query)!
	lines := os.read_file(dep.file_path)!
	for imports in re.find_all_str(lines) {
		dep_tmp := re.get_group_by_id(imports, 2)
		dep.dependencies << dep_tmp
	}
}
