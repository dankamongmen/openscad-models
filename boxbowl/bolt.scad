include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <bowl.scad>

module bolt(){
	screw("M5", length = fpanelx * 3, head="hex");
}