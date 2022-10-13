// panel for running zmt through the wall
// this one is longer than morapanel.scad, and has slightly
// wider tubes so that the other panel can lock in.
// overall width and height remain the same, and the tubes
// are centered at the same points. tubes are 3/4 of wall depth.

PHI = 1.61803398874;

wall = 150;  // thickness of transfixed wall
zmt = 19.5; // three-fourths of an inch diameter == 19.05, we leave 0.45
x = zmt * 2 / PHI; // amount of free space in width
w = 2 * zmt + x;
h = w / PHI;

centx = (x / 6) + (zmt / 2);

module rounded(width, height, radius_corner){
	translate([radius_corner, radius_corner, 0])
		minkowski() {
			square([width - 2 * radius_corner, height - 2 * radius_corner]);
			circle(radius_corner);
		}
}

// combined thickness of walls around tubes
cthick = 10;
// thickness of plugin component's walls, cgap < cthick
cgap = 5;

module tube(){
	difference(){
		cylinder(3 * wall / 4, (zmt + cthick) / 2, (zmt + cthick) / 2);
		cylinder(3 * wall / 4, (zmt + cgap) / 2, (zmt + cgap) / 2);
	}
}

difference(){
	union(){
		linear_extrude(3){
			translate([-w / 2, -h / 2, 0]){
				rounded(w, h, 5);
			}
		}
		translate([-centx, 0, 0]){
			tube();
		}
		translate([centx, 0, 0]){
			tube();
		}
	}
	linear_extrude(3){
		translate([-centx, 0, 0]){
			circle(zmt / 2);
		}
		translate([centx, 0, 0]){
			circle(zmt / 2);
		}
	}
}
