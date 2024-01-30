module main

struct ImportTree {
pub mut:
	name string
	modules []ImportTree
}

fn (tree ImportTree) print(increment int) {
	println('->'.repeat(increment) + ' ${tree.name}')
	for mod in tree.modules {
		mod.print(increment + 1)
	}
}

fn (tree ImportTree) to_d2(increment int) []string {
	mut res := []string{}
	res << '    '.repeat(increment) + '${tree.name} {'
	for mod in tree.modules {
		res << mod.to_d2(increment + 1)
	}
	res << '}'
	return res
}

fn append_dep_to_tree(name []string, mut tree ImportTree) bool {
	if name.len == 0 {
		return false
	}
	if name[0] == tree.name {
		if name.len == 1 {
			for mod in tree.modules {
				if mod.name == name[1] {
					return true
				}
			}
			tree.modules << ImportTree{
				name: name[1]
			}
			return true
		} else {
			return append_dep_to_tree(name[1..], mut tree)
		}
	}
	return false
}

fn rec_append_modules(mut treeRoot ImportTree, name []string) {
	if name.len == 0 {
		return
	}
	mut tree := ImportTree{
		name: name[0]
	}
	rec_append_modules(mut tree, name[1..])
	treeRoot.modules << tree
}

fn append_dep_to_trees(dep DependencyGraph, mut trees []ImportTree) {
	mut found := false
	for mut tree in trees {
		found = append_dep_to_tree(dep.name, mut tree)
		if found {
			break
		}
	}
	if !found {
		mut tree := ImportTree{
			name: dep.name[0]
		}
		rec_append_modules(mut tree, dep.name[1..])
		trees << tree
	}
}

fn output_d2(deps []DependencyGraph, language string) ![]string {
	mut lines := []string{}
	mut trees := []ImportTree{}
	for dep in deps {
		if dep.language != language {
			continue
		}
		println(dep)
		append_dep_to_trees(dep, mut trees)
	}
	for tree in trees {
		lines << tree.to_d2(0)
	}
	lines << ''
	for dep in deps {
		if dep.language != language {
			continue
		}
		lines << ''
		for imp in dep.dependencies {
			lines << '${dep.name.join(".")} -> ${imp.join(".")}'
		}
	}
	println(lines)
	return lines
}
