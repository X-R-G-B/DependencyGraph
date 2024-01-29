import os

fn process_folder(folder string, language string) ![]DependencyGraph {
	if os.is_file(folder) {
		dep := process_file(folder, language)!
		return [dep]
	}
	mut deps := []DependencyGraph{}
	for elem in os.ls(folder)! {
		elem_resolved := os.join_path(folder, elem)
		if os.is_dir(elem_resolved) {
			deps_tmp := process_folder(elem_resolved, language)!
			deps << deps_tmp
		} else if os.is_file(elem_resolved) {
			dep_tmp := process_file(elem_resolved, language)!
			deps << [dep_tmp]
		} else {
			eprintln("Unprocessed ${elem_resolved}!")
		}
	}
	return deps
}
