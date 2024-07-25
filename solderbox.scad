include<roundedcube.scad>

$fa=5;

zonex = 65;
zoney = 40;
zonez = 170.172;

wallx = 8;
wally = 3;
wallz = 5;

totx = zonex * 3 + wallx * 4;
toty = zoney + wally;
totz = zonez + wallz * 2;
totrad = wallz / 2;

module zone(offx){
	translate([offx, wally, wallz]){
		roundedcube([zonex, zoney, zonez], false, 15, "ymin");
	}
}

jointx = 10;
jointz = 40;
module joint(offx){
	translate([offx, toty - wally * 2, totz - wallz * 2 - jointz]){
		cube([jointx, wally, jointz]);
		linear_extrude(jointz){
			polygon([[0, 0], [0, -zoney + wally + 3], [jointx, 0]]);
		}
	}
}

difference(){
	roundedcube([totx, toty, totz], false, totrad, "zmin");
	union(){
		zone(wallx);
		zone(wallx * 2 + zonex);
		zone(wallx * 3 + zonex * 2);
		// hole in the back for type-c cable (8.94x3.26mm)
		translate([wallx + zonex / 2, wally * 5, totz - wallz * 2]){
			roundedcube([11.5, 5.5, wallz * 3], false, 1);
		}
	}
}

mirror([1, 0, 0]){
	joint(0);
}
joint(totx);

