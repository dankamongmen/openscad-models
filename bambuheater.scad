// dimensions of free area in Bambu X1C chamber: 52.8mm x 112.8mm
//
// AC cord is 3x18AWG and just about 8mm external diameter
include <electronics.scad>

bambux = 80.8;
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
		difference(){
			union(){
				// still need(?):
				//  external or internal fan mount
				//  internal mount for zhf connector
				difference(){
					union(){
						// top is a trapezoidal solid.
						translate([0, 0, chamberz - devboardw]){
							difference(){
								linear_extrude(devboardw){
									polygon([
										[0, 0],
										[bambux, 0],
										[bambux, bambuy],
										[devboardside, bambuy],
										[0, bambuy - devboardside]
									]);
								}
								linear_extrude(devboardw - walls){
									polygon([
										[wallt, wallt],
										[bambux - wallt, wallt],
										[bambux - wallt, bambuy - wallt],
										[devboardside, bambuy - wallt],
										[wallt, bambuy - devboardside]
									]);
								}
							}
						}
						
						// bottom is a rectangular prism.
						difference(){
							linear_extrude(chamberz - devboardw){
								polygon([
									[0, 0],
									[bambux, 0],
									[bambux, bambuy],
									[0, bambuy]
								]);
							}
							translate([0, 0, walls]){
								linear_extrude(chamberz - devboardw){
									polygon([
										[wallt, wallt],
										[bambux - wallt, wallt],
										[bambux - wallt, bambuy - wallt],
										[wallt, bambuy - wallt]
									]);
								}
							}
						}
						
						// put a floor underneath the cutout devboard area
						translate([0, 0, chamberz - devboardw - walls]){
							linear_extrude(walls){
								difference(){
									polygon([
										[0, bambuy],
										[0, bambuy - devboardside],
										[devboardside, bambuy]
									]);
									translate([wallt * 2, bambuy - wallt * 2, 0]){
										circle(5);
									}
								}
							}
						}
					} // close union

					// remove the back, so we can pack stuff into the chamber.
					translate([0, 0, 0]){
						linear_extrude(chamberz - walls){
							polygon([
									[wallt + wallt, 0],
									[wallt, wallt],
									[bambux - wallt, wallt],
									[bambux - wallt - wallt, 0]
								]);
						}
					}
					// hole for wires running to heater / perfboard (must admit ~10mm USBA plug)
					translate([bambux - ceramheat100w - ceramheat100h - 2,
										 wallt * 2, chamberz - walls]){
						cylinder(wallt, 6, 6);
					}
				} // close difference


				// we'll mount the ceramic heating element on top
				translate([bambux - ceramheat100w / 2, ceramheat100l / 2 + wallt, chamberz - bh / 2]){
					rotate([0, 0, 180]){
						ceramheat100(stub, bh);
					}
				}

				translate([bambux - thermw / 2 - 10, bambuy - wallt + bh / 2, chamberz - 60]){
					rotate([90, 90, 0]){
						relay5v(stub, bh);
					}
				}

				translate([devboardside + 3, bambuy - wallt + bh / 2, chamberz - 100 - tobsunh]){
					rotate([90, 270, 0]){
						tobsun5v(stub, bh);
					}
				}

				translate([bambux - thermw / 2 - 7, bambuy - wallt + bh / 2, chamberz - thermw / 2]){
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

				// supports upon which the back slides
				linear_extrude(chamberz - walls){
					polygon([
						[bambux - wallt, wallt],
						[bambux - wallt * 2, wallt],
						[bambux - wallt, wallt * 2]
					]);
					polygon([
						[wallt, wallt],
						[wallt * 2, wallt],
						[wallt, wallt * 2]
					]);
				}
			} // end union
			// bling
			translate([bambux - wallt * 2, bambuy - wallt, 90]){
				rotate([0, 90, 90]){
					linear_extrude(wallt){
						words = [[2, "midtown"], [1, "ignition"], [0, "facility"]];
						for(s = words){
							translate([0, s[0] * 15 + 10, 0]){
								text(s[1], font="Prosto One", size=12);
							}
						}
					}
				}
			}	
		} // end difference
	} // end rotate
} // end translate

// back side, held into place with dovetail joints. we subtract
// some smudge to ensure it fits.
translate([0, 0, wallt]){
	rotate([270, 0, 0]){
		smudge = 0.2;
		translate([bambux + 10, 0, 0]){
			difference(){
				translate([wallt * 2 + smudge, 0, 0]){
					cube([bambux - wallt * 4 - smudge * 2, wallt, chamberz - walls]);
				}
				translate([wallt * 4, wallt, walls * 3]){
					rotate([90, 0, 0]){
						cylinder(wallt, 6, 6);
					}
				}
			}
			linear_extrude(chamberz - walls){
				polygon([
						[wallt + smudge, wallt],
						[wallt * 2 + smudge, wallt],
						[wallt * 2 + smudge, 0]
					]);
				translate([bambux - wallt * 2 - smudge, 0, 0]){
					polygon([
							[0, wallt],
							[wallt - smudge, wallt],
							[0, 0]
						]);
				}
			}
		}
	}
}