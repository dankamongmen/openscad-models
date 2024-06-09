h1 = 5.93;
w1 = 25;
h2 = 4.13;
w2 = 26.3;
h3 = 1.8;
w3 = 29.53;
iw = 21.25;

split = 4.3; // distance between cutouts
cutoutd = 3.9; // diameter of cutout

$fn = 50;
difference(){
	union(){
		cylinder(h3, w3 / 2, w3 / 2);
		difference(){
			union(){
				cylinder(h2, w2 / 2, w2 / 2);
				cylinder(h1, w1 / 2, w1 / 2);
			}
			translate([0, 0, h3]){
				cylinder(h1, iw / 2, iw / 2);
			}
		}
	}
	difference(){
		union(){
			for(m = [0:1]){
				mirror([m, 0, 0]){
					translate([split / 2, 0, 0]){
						cylinder(h3, cutoutd / 2, cutoutd / 2);
					}
				}
			}
		}
		translate([-split / 2, -cutoutd / 2, 0]){
			cube([(cutoutd + split) / 2, cutoutd, h3]);
		}
	}
}
