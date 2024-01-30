module main

import os

struct DependencyGraph {
pub mut:
	language		string
	file_path		string
	name			[]string
	dependencies	[][]string
}

fn process_file(file string, language string) !DependencyGraph {
	if !os.is_file(file) {
		return error("not a file ${file}")
	}
	mut dep := DependencyGraph{
		file_path: file,
	}
	if language == 'haskell' && is_haskell_file(file) {
		dep.language = language
		process_file_haskell(mut dep)!
	}
	return dep
}
