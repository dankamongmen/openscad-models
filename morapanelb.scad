// panel for running kool through the wall
// this one is longer than morapanel.scad, and has slightly
// wider tubes so that the other panel can lock in (kool is
// 28.5, not 28). overall width and height remain the same,
// and the tubes are centered at the same points.

wall = 150;  // thickness of transfixed wall
//zmt = 19.05; // three-fourths of an inch diameter
kool = 28.5;  // max diameter of Koolance QD4 is 28mm
x = 33.6; // amount of free space in width
w = 2 * kool + x;
// (w+h) / w = w/h
// hh = ww - wh
// hh = 8208.36 - 90.6h
// h = 55.99
h = 60;

// placement of right hole. i fucked this up on the other
// panel, so we have a fudge factor, ugh.
centx = (34.6 / 6) + (28 / 2);

module rounded(width, height, radius_corner){
	translate([radius_corner, radius_corner, 0])
		minkowski() {
			square([width - 2 * radius_corner, height - 2 * radius_corner]);
			circle(radius_corner);
		}
}

// combined thickness of walls around tubes
cthick = 2;
// combined gap room of walls around tubes
cgap = 1;

module tube(){
	difference(){
		cylinder(3 * wall / 4, (kool + cthick + cgap) / 2, (kool + cthick + cgap) / 2);
		cylinder(3 * wall / 4, (kool + cgap) / 2, (kool + cgap) / 2);
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
			circle((kool + cgap) / 2);
		}
		translate([centx, 0, 0]){
			circle((kool + cgap) / 2);
		}
	}
}
