module main

import os

struct DependencyGraph {
pub mut:
	language		string
	file_path		string
	name			[]string
	dependencies	[]string
}

fn process_file(file string, language string) !DependencyGraph {
	if !os.is_file(file) {
		return error("not a file ${file}")
	}
	mut dep := DependencyGraph{
		language: language,
		file_path: file,
	}
	if is_haskell_file(file) {
		process_file_haskell(mut dep)!
	}
	return dep
}
