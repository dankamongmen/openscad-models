include<roundedcube.scad>

$fa=5;

catx = 55;
caty = 70;
catz = 45;

// golden ratio calculations
phiz = 27.812 / 2;
phiy = 43.262 / 5;
phix = 33.992 / 2;

// three cats max per floor with two spaces between
innerx = 3 * catx + 2 * phix;
// give them a space above equal to their own height
innery = caty + phiy;
innerz = catz + phiz;
floorthiccness = 4.944; // (phi of wallthiccness)
wallthiccness = 8;
backthiccness = 3;

/*for(i = [0 : 2]){
	translate([0, i * (innery + floorthiccness), 0]){
		cube([innerx + wallthiccness * 2, floorthiccness, innerz + backthiccness]);
	}
}*/

totalheight = 3 * (innery + floorthiccness) + floorthiccness;
sideheight = 2 * (innery + floorthiccness);

/*for(i = [0 : 1]){
	translate([i * (innerx + wallthiccness), 0, 0]){
		cube([wallthiccness, sideheight, innerz + backthiccness]);
	}
}*/

totalwidth = 2 * wallthiccness + innerx;

/*translate([0, 0, innerz]){
	cube([totalwidth, sideheight, backthiccness]);
}*/

totaldepth = innerz + backthiccness;

difference(){
	roundedcube([totalwidth, totalheight, totaldepth], false, 20, "ymax");
	union(){
		for(i = [0 : 2]){
			translate([wallthiccness, floorthiccness + i * (innery + floorthiccness), 0]){
				roundedcube([innerx, innery, innerz], false, 10, "zmax");
			}
		}
		translate([0, -40, totaldepth - 4])
      linear_extrude(height=backthiccness)
		    import("bitmap.dxf");
	}
}