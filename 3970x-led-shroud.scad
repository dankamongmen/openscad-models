// dimensions of the 3970X in mm
w = 76;
h = 7.62;
l = 120;

gap = 5;
hgap = 3;
shroud = 11;

// plastic junctions are 24.7mm square, 4.5 tall
junc = 24.7;
junch = 4.5;

// cable is 4.6mm wide
cable = 5;

difference(){
	cube([w + gap, l + gap, h + gap + hgap]);
	union(){
		translate([gap / 2 + shroud, 0, 0]){
			cube([w - shroud * 2, l - shroud + gap / 2, h + gap + hgap]);
		}
		translate([gap / 2, gap / 2, 0]){
			cube([w, l, h + hgap]);
		}
		// allow room for the plastic juntions
		translate([gap / 2, gap / 2, h + hgap]){
			cube([w, junc, junch]);
		}
		// 18 and 5 are experimentally-derived
		translate([w, 18, 0]){
			cube([gap, cable, 5]);
		}
	}
}