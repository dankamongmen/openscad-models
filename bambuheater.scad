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
wallt = 4;
walls = 3;

// mounts for some components use the electronics.scad definitions
stub = 9;
bh = 2;

// we need a little excess room on each side for the actual board
devboardside = devboardl / sqrt(2) + 2;

module mainunit(){
	translate([0, 0, bambuy]){
		rotate([270, 0, 0]){
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
							
							// bottom is a rectangular prism with two cutouts.
							linear_extrude(chamberz - devboardw){
								difference(){
									polygon([
										[0, 0],
										[bambux, 0],
										[bambux, bambuy],
										[bambux - wallt * 2, bambuy],
										[bambux - wallt * 2, bambuy - 2],
										[bambux - wallt, bambuy - 2],
										[bambux - wallt * 2, bambuy - wallt - 2],
										[wallt * 2, bambuy - wallt - 2],
										[wallt, bambuy - 2],
										[wallt * 2, bambuy - 2],
										[wallt * 2, bambuy],
										[0, bambuy]
									]);
									// remove core
									polygon([
										[wallt, wallt],
										[bambux - wallt, wallt],
										[bambux - wallt, bambuy - wallt - 2],
										[wallt, bambuy - wallt - 2]
									]);
								}
							}
							
							// put a floor underneath the cutout devboard area, with a hole for wires
							translate([0, bambuy - devboardside - 3, chamberz - devboardw - 1]){
								linear_extrude(1){
									difference(){
										polygon([
											[0, 0],
											[0, devboardside - wallt],
											[devboardside - wallt, devboardside - wallt]
										]);
										translate([devboardside / 2 - 4, devboardside / 2 + 4, 0]){
											circle(2);
										}
									}
								}
							}
						} // close union

						// remove the back, so we can pack stuff into the chamber.
						linear_extrude(chamberz - walls){
							polygon([
									[wallt + wallt, 0],
									[wallt, wallt],
									[bambux - wallt, wallt],
									[bambux - wallt - wallt, 0]
								]);
						}
						
						// hole for wires running to heater / perfboard (must admit ~10mm USBA plug)
						translate([bambux - ceramheat100w - ceramheat100h,
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

					translate([bambux - thermw / 2 - 7, bambuy - wallt + bh / 2, chamberz - thermw / 2]){
						rotate([90, 0, 0]){
							therm(stub, bh);
						}
					}
					
					// our perfboard is just wide enough not to fit in a typical
					// orientation. instead, it goes up the external side.
					translate([devboardside / 2 + bh / 2, bambuy - devboardside / 2 - bh / 2, chamberz - devboardw / 2]){
						rotate([0, 270, -45]){
							ecookiedevboard(stub - 2, bh);
						}
					}

					// supports upon which the back slides
					translate([0, 0, walls]){
						linear_extrude(chamberz - walls * 2){
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
					}
					// supports for the front
					translate([0, 0, walls]){
						linear_extrude(chamberz - walls * 2){
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
					}

		} // end rotate
	} // end translate
} // end module

// back side, held into place with dovetail joints. we subtract
// some smudge to ensure it fits.
module backwall(){
	translate([2 * bambux - 25, chamberz - 60, wallt - bh / 2]){
		rectifier2a(stub + 2, bh);
	}
	translate([2 * bambux - 25, 50, wallt - bh / 2]){
		buckxhm401(stub + 2, bh);
	}
	translate([0, chamberz - walls, 0]){
		rotate([90, 0, 0]){
			smudge = 0.2;
			translate([bambux + 10, 0, 0]){
				translate([wallt, wallt, 0]){
					cube([bambux - wallt * 2, bambuy - wallt * 2, walls]);
				}
				difference(){
					translate([wallt * 2, 0, 0]){
						cube([bambux - wallt * 4, wallt, chamberz - walls]);
					}
					translate([wallt * 4, wallt, wallt * 3]){
						rotate([90, 0, 0]){
							cylinder(wallt, 6, 6);
						}
					}
				}
				linear_extrude(chamberz - walls){
					polygon([
							[wallt + smudge, wallt],
							[wallt * 2, wallt],
							[wallt * 2, 0]
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
}

module bling(){
	// bling
	translate([70, wallt - 1, 100]){
		rotate([270, 90, 0]){
			words = [[2, "midtown"], [1, "ignition"], [0, "facility"]];
			for(s = words){
				translate([0, s[0] * 20 + 5, 0]){
					linear_extrude(1){
						text(s[1], font="Prosto One", size=14);
					}
				}
			}
		}
	}
}

module frontwall(justtext){
	// front bottom
	translate([bambux * 2 + 20, 0, 0]){
		if(!justtext){
			difference(){
				linear_extrude(chamberz - devboardw){
					polygon([
						[wallt * 2, 0],
						[bambux - wallt * 2, 0],
						[bambux - wallt, wallt],
						[wallt, wallt]
					]);
				}
				bling();
			}
		}else{
			bling();
		}
	}
}

mainunit();
backwall();	
translate([0, chamberz - devboardw, 0]){
	rotate([90, 0, 0]){
		frontwall(false);
	}
}

multicolor("blue"){
	translate([0, chamberz - devboardw, 0]){
		rotate([90, 0, 0]){
			frontwall(true);
		}
	}
}

// testing
/*multicolor("red"){
	translate([-182, 0, 6]){
		rotate([270, 0, 0]){
			frontwall();
		}
	}
}
*/