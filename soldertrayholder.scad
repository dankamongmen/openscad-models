include<roundedcube.scad>

$fa=5;

zonex = 65;
zoney = 50;
zonez = 170.172;

wallx = 8;
wally = 3;
wallz = 5;

totx = zonex * 3 + wallx * 4;
toty = zoney + wally;
totz = zonez + wallz * 2;
totrad = wallz / 2;

jointx = 10;
jointz = 40;

//containing box

holdx = 3;
holdy = 5;
holdz = 5;

htotx = holdx * 2 + jointx * 2 + totx;
htoty = holdy + toty;
htotz = holdz + totz;

module jointslide(offx){
	translate([offx, toty - wally * 2, 10]){
		//cube([jointx, wally, jointz]);
		linear_extrude(htotz - 30){
			polygon([[0, 0], [0, -zoney + wally + 3], [jointx, 0]]);
		}
	}
}

module jointslot(offx){
	translate([offx, htoty - wally * 4, totz - wallz * 2 - jointz]){
		cube([jointx, wally + 20, jointz - 5]);
	}
}

difference(){
	translate([-jointx + -holdx, -holdy, 0]){
		roundedcube([htotx, htoty, htotz], false, 5);
	}
	union(){
		// center hollow for main box
		cube([totx, toty, totz]);
		// slides for wings
		mirror([1, 0, 0]){
			jointslide(0);
		}
		jointslide(totx);
		// slot for wings
		mirror([1, 0, 0]){
			jointslot(0);
		}
		jointslot(totx);
		// hole for usb-c
		translate([wallx + zonex / 2, wally * 5, totz - wallz * 2]){
			roundedcube([11.5, 6.5, wallz * 3], false, 1);
		}
		// hole in bottom to access box
		translate([20, -holdy * 2, 20]){
			roundedcube([totx - 40, htoty, totz - 40], false, 15);
		}
	}
}