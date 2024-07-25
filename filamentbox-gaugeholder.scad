// A frame for rectangular hydrogmeters, plus a dovetail joint to interface
// with the dessicant tray from https://www.thingiverse.com/thing:6254854

// dovetail joint is 3mm tall
base = 41;  // width of dovetail base
indent = 3; // how far dovetail comes in

translate([base + 3.5, -24, 0]){
	import("Slim Mount.stl");
}

linear_extrude(6){
	polygon([[0, 0], [base, 0], [base - indent, 3], [indent, 3]]);
}

translate([0, 0, indent]){
	linear_extrude(3){
		polygon([[base - indent, 3], [base - indent, 7], [indent, 7], [indent, 3]]);
	}
}