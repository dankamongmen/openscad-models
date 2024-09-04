// dimensions of free area in Bambu X1C chamber: 52.8mm x 112.8mm
//
// AC cord is 3x18AWG and just about 8mm external diameter
include <electronics.scad>

bambux = 92.8;
bambuy = 52.8;

// we need enough room to hold our ac adapter, which will
// be standing up at an angle (125x54x33). we need lots of
// spare room for the inflexible elements of cabling.
chamberz = 200;

// we want an enclosed region for our AC electronics
wallt = 5;
walls = 3;

// mounts for some components use the electronics.scad definitions
stub = 8;
bh = 2;

// we need a little excess room on each side for the actual board
devboardside = devboardl / sqrt(2) + 2;

translate([0, 0, bambuy]){
	rotate([270, 0, 0]){
		// still need:
		//  external or internal fan mount
		//  internal mount for zhf connector
		difference(){
			linear_extrude(chamberz){
				polygon([
					[0, 0],
					[bambux, 0],
					[bambux, bambuy],
					[devboardside, bambuy],
					[0, bambuy - devboardside]
				]);
			}
			translate([0, 0, walls]){
				linear_extrude(chamberz - walls * 2){
					polygon([
						[wallt, wallt],
						[bambux - wallt, wallt],
						[bambux - wallt, bambuy - wallt],
						[devboardside, bambuy - wallt],
						[wallt, bambuy - devboardside]
					]);
				}
			}
			// remove the back, so we can pack stuff into the chamber.
			translate([0, 0, walls]){
				linear_extrude(chamberz - walls){
					polygon([
							[wallt + wallt, 0],
							[wallt, wallt],
							[bambux - wallt, wallt],
							[bambux - wallt - wallt, 0]
						]);
				}
			}
			// hole for wires running to heater / perfboard
			translate([bambux - ceramheat100w - ceramheat100h - 2, ceramheat100l / 2 + wallt, chamberz - walls]){
				cylinder(wallt, 3, 3);
			}
		}

		// we'll mount the ceramic heating element on top
		translate([bambux - ceramheat100w / 2, ceramheat100l / 2 + wallt, chamberz - bh / 2]){
			ceramheat100(stub, bh);
		}

		translate([bambux - thermw / 2 - 25, bambuy - wallt + bh / 2, chamberz - 60]){
			rotate([90, 90, 0]){
				relay5v(stub, bh);
			}
		}

		translate([devboardside + tobsunh - 5, bambuy - wallt + bh / 2, chamberz - 90 - tobsunh]){
			rotate([90, 270, 0]){
				tobsun5v(stub, bh);
			}
		}

		translate([bambux - thermw / 2, bambuy - wallt + bh / 2, chamberz - thermw / 2]){
			rotate([90, 0, 0]){
				therm(stub, bh);
			}
		}
		
		// our perfboard is just wide enough not to fit in a typical
// orientation. instead, it goes up the external side.
		translate([devboardside / 2 + bh / 2, bambuy - devboardside / 2 - bh / 2, chamberz - devboardw / 2]){
			rotate([0, 270, -45]){
				ecookiedevboard(stub, bh);
			}
		}
	}
}

translate([0, 0, wallt]){
	rotate([270, 0, 0]){
		// back side
		translate([bambux + 10, 0, 0]){
			difference(){
				translate([wallt * 2, 0, 0]){
					cube([bambux - wallt * 4, wallt, chamberz - walls]);
				}
				translate([wallt * 4, wallt, walls * 2]){
					rotate([90, 0, 0]){
						cylinder(wallt, 8 / 2, 8 / 2);
					}
				}
			}
			linear_extrude(chamberz - walls){
				polygon([
						[wallt, wallt],
						[wallt * 2, wallt],
						[wallt * 2, 0]
					]);
				translate([bambux - wallt * 2, 0, 0]){
					polygon([
							[0, wallt],
							[wallt, wallt],
							[0, 0]
						]);
				}
			}
		}
	}
}