// dimensions of free area in Bambu X1C chamber: 52.8mm x 112.8mm
//
// AC cord is 3x18AWG and just about 8mm external diameter
include <electronics.scad>


// area available at the left bottom of the X1C
bambux = 80.8;
bambuy = 52.8;

chamberz = 200;

// we want an enclosed region for our AC electronics
wallt = 4;
walls = 3;

// mounts for some components use the electronics.scad definitions
stub = 9;
bh = 2;

// we need a little excess room on each side for the actual board
devboardside = devboardl / sqrt(2) + 2;
chamberh = chamberz - devboardw - 2; // give it some skoosh

module mainunit(){
	translate([0, 0, bambuy]){
		rotate([270, 0, 0]){
					// still need(?):
					//  external or internal fan mount
					//  internal mount for zhf connector
					difference(){
						union(){
							// top is a trapezoidal solid.
							translate([0, 0, chamberh]){
								difference(){
									linear_extrude(chamberz - chamberh){
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
							linear_extrude(chamberh){
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
							translate([0, bambuy - devboardside - 1, chamberh - 1]){
								linear_extrude(1){
                                    difference(){
										polygon([
											[0, 0],
											[0, devboardside + 1],
                                            [devboardside + 1, devboardside + 1],
                                            
										]);
										translate([devboardside / 2 - 1, devboardside / 2 + 1, 0]){
											circle(2);
										}
									}
								}
							}
                            // fill in the space next to the floor, as we'll be blocking the top pane
                            translate([0, bambuy - 10, chamberh - 1]){
                                cube([bambux, 10, 1]);
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
						
						// hole for wires running to heater / perfboard
						translate([bambux - ceramheat100w - ceramheat100h,
											 wallt * 2, chamberz - walls]){
							cylinder(wallt, 7, 7);
						}
					} // close difference


					// we'll mount the ceramic heating element on top
					translate([1, ceramheat100l, ceramheat100w / 2 + (chamberh - ceramheat100w) / 2]){
						rotate([0, 270, 0]){
							ceramheat100(7, 1);
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
					cube([bambux - wallt * 2, bambuy - wallt * 2 - 2, walls]);
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
				linear_extrude(chamberh){
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
translate([0, chamberh, 0]){
	rotate([90, 0, 0]){
		frontwall(false);
	}
}

multicolor("blue"){
	translate([0, chamberh, 0]){
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

multicolor("purple"){
    translate([-bambux - 10, chamberz - walls, bambuy]){
        rotate([0, 180, 180]){
            backwall();
        }
    }
}
*/