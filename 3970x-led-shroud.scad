// dimensions of the 3970X in mm
w = 76;
h = 7.62;
l = 120;

gap = 5;
hgap = 3;
shroud = 11;

// temporary split in half
difference(){

difference(){
	cube([w + gap, l + gap, h + gap + hgap]);
	union(){
		translate([gap / 2 + shroud, gap / 2 + shroud, 0]){
			cube([w - shroud * 2, l - shroud * 2, h + gap + hgap]);
		}
		translate([gap / 2, gap / 2, 0]){
			cube([w, l, h + hgap]);
		}
	}
}

//translate([20, 0, 0]){
	//	cube([100, 14, 60]);
//}

}