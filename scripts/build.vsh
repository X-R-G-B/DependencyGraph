fn main() {
    mut p := new_process("./deps/v-master/v")
    p.set_args([".", "-o", "dg"])
    p.run()
    p.wait()
}
