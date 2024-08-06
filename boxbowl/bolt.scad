include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <bowl.scad>

module bolt(){
	spec = screw_info("M5", head="socket", drive="hex");
	newspec = struct_set(spec,["head_size",10,"head_height",10]);
	screw(newspec, length = fpanelx + 18.8);
}