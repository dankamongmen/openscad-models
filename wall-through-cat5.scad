// rj45 dimensions

rj_width=15.24;
rj_height=15;

plate_width=25 * 2;
plate_height=20;
plate_thick=2;

difference(){
	union(){
		minkowski(){
			cube([plate_width, plate_height, plate_thick], center=true);
			sphere(3);
		}
	}
	union(){
		translate([-100, -100, -100]){
			cube([200, 200, 100]);
		}
		cube([rj_width * 2 + 3, rj_height + 3, 300], center=true);
	}
}
difference(){
	translate([-(rj_width * 2 + 4) / 2, -(rj_height + 4) / 2, -50]){
		cube([rj_width * 2 + 4, rj_height + 4, 50]);
	}
	cube([rj_width * 2 + 3, rj_height + 3, 300], center=true);
}
