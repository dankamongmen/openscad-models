include<roundedcube.scad>

$fa=5;


/**
* An edge (or line) between 2 cylinders
*/
module line3D(start, end,d=1,h=10, fn=4) {
  hull() {
    translate(start) cylinder(h=h, d=d, $fn = fn);
    translate(end) cylinder(h=h, d=d, $fn = fn);
  }
}

/**
* 3d Spring with a sinusoidal shape
*/
module springSine3D(length=20, heigth=10, width=10, windings=4, steps=10, wireDiameter=0.7, fn=4){
    dx = length / (360 * windings);
    for(i = [steps : steps : 360 * windings]){
        x0 = (i-steps) * dx;
        y0 = sin(i-steps) * width/2;
        x = i * dx;
        y = sin(i) * width/2;
        line3D([x0,y0,0],[x,y,0],d=wireDiameter,h=heigth, fn=fn);
    }
}

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
/*
module zone(offx){
	translate([offx, wally, wallz]){
		roundedcube([zonex, zoney, zonez], false, 15, "ymin");
	}
}

module joint(offx){
	translate([offx, toty - wally * 2, totz - wallz * 2 - jointz]){
		cube([jointx, 10, jointz]);
		linear_extrude(jointz){
			polygon([[0, 0], [0, -(toty - wally * 2) + totrad], [jointx, 0]]);
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
		translate([wallx + zonex / 2, wally * 3, totz - wallz * 2]){
			roundedcube([11.5, 4.5, wallz * 3], false, 1);
		}
	}
}

mirror([1, 0, 0]){
	joint(0);
}
joint(totx);
*/

holdx = 5;
holdy = 5;
holdz = 5;

htotx = holdx * 2 + jointx * 2 + totx;
htoty = holdy + toty;
htotz = holdz + totz;
color([1, 1, 1]){
	difference(){
		translate([-jointx + -holdx, -holdy, 0]){
			cube([htotx, htoty, htotz]);
		}
		translate([-jointx, 0, 0]){
			cube([totx + jointx * 2, toty, totz]);
		}
	}
}