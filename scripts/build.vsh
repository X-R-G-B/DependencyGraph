import os
import flag

fn main() {
    println(os.args)
    mut fp := flag.new_flag_parser(os.args)
    fp.application(os.args[0])
    fp.version("0.0.0")
    fp.description("build DependencyGraph")
    fp.skip_executable()
    fp.limit_free_args(0, 0)!
    a_static := fp.bool("static", `s`, false, "If build static binary")
    _ := fp.finalize() or {
        eprintln(err)
        eprintln(fp.usage())
        exit(1)
    }
    mut p := new_process("./deps/v-master/v")
    mut args_build := ["-o", "dg", "-prod", "-skip-unused", "."]
    if a_static {
        args_build << ["-cflags", "--static"]
    }
    p.set_args(args_build)
    p.set_redirect_stdio()
    p.run()
    for p.is_alive() {
        println(p.stdout_read())
    }
    p.wait()
    println(p.stdout_read())
}
