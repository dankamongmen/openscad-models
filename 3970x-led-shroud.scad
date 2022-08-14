// dimensions of the 3970X in mm
w = 55.88;
h = 7.62;
l = 77.978;

gap = 5;

difference(){
	cube([w + gap, l + gap, h + gap]);
	union(){
		translate([gap / 2, gap / 2, 0]){
			cube([w, l, h + gap]);
		}
		/*translate([gap, gap, 0]){
			cube([w - gap, l - gap, h]);
		}*/
	}
}
