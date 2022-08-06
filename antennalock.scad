use <top-back-molex.scad>

// print with as little infill as possible, so that it's light
// (there's a lot of strain on the plugs)

// antenna is 70 at its longest and 30 at its widest
// magnets are 10 x 2 x 57.5

// total diameter from one extreme of left plug to extreme
// of right plug
diameter = 92;

// outer diameter of a single plug
plugd = 42;

// space between inner extrema
gap = diameter - plugd * 2;

// extra volume to cut out of bulk, for a
// friction key placed through the back holes
module lockhole(){
  translate([0, 0, 5]){
    cube([10, 10, 10]);
  }
}

module holder(){
		
translate([plugd / 2 + gap / 2, 6, -27]){
    plug();
}
translate([-plugd / 2 - gap / 2, 6, -27]){
    plug();
}

	difference(){
			minkowski(){
					cube([diameter, 50, 30], true);
					sphere(5);
			}
			union(){
				// cut out hole for magnet
				translate([0, -15, 9]){
					cube([57.5 + .6, 2 + .6, 22], true);
				}
				// cut out sitting area for antenna
				translate([0, -30, 0]){
					cube([70, 18, 30], true);
				}
				// cut out trench for antenna cable (3mm wide)
				translate([32, -30, -3/2]){
					cube([20, 9, 3]);
				}
				// cut out more room for lock on right...
				translate([20, 2, -25]){
					lockhole();
				}
				// and on the left...
				mirror([1, 0, 0]){
					translate([20, 2, -25]){
						lockhole();
					}
				}
			}
	}
}

// now make the lock that plugs in through the back
translate([100, 0, 3]){
	difference(){
		// first, get a cube minus the existing structure
		difference(){
			cube([80, 80, 60], true);
			holder();
		}
		union(){
			translate([0, 30, 0]){
				cube([80, 40, 60], true);
			}
			translate([0, -20, 0]){
				cube([80, 40, 60], true);
			}
			translate([0, 0, 20]){
				cube([80, 40, 60], true);
			}
			translate([0, 0, 0]){
				cube([20, 40, 54 ], true);
			}
		}
	}
}
