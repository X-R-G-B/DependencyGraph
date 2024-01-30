module main

import os
import flag

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application(os.args[0])
	fp.version("0.0.0")
	fp.description("output d2 dependency graph")
	fp.skip_executable()
	a_language := fp.string_opt("language", `l`, "Language to use for the folders") or {
		eprintln(fp.usage())
		exit(1)
	}
	a_output := fp.string_opt("output", `o`, "Output file") or {
		"dependency_graph.d2"
	}
	folders := fp.finalize() or {
		eprintln(err)
		eprintln(fp.usage())
		exit(1)
	}
	mut deps := []DependencyGraph{}
	for folder in folders {
		println('Processing ${folder} ...')
		dep := process_folder(folder, a_language) or {
			eprintln(err)
			continue
		}
		deps << dep
	}
	lines := output_d2(deps, a_language) or {
		eprintln(err)
		exit(1)
	}
	os.write_file(a_output, lines.join('\n')) or {
		eprintln(err)
		exit(1)
	}
}
