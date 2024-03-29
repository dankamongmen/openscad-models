// two quasi-elliptical plugs separated by a long rod, fit for bridging
// the top two central plugs and supporting a CCFL.

r = 9; // radius of 9 on the plug cylinders
outerr = 7.5; // thickness of plug wrap
innerplug = 45;                     // inner plug width
cyldist = innerplug - r * 2;        // width between cylinder foci
outerplug = innerplug + 2 * outerr; // full plug width
distance = 92;                     // distance between extremal outer points
plugheight = 40; // arbitrary, enough to test FIXME

module plug2dsolid(){
  hull(){
    mirror([1, 0, 0]){
      translate([cyldist / 2, 0, 0]){
        circle(r);
      }
    }
    translate([cyldist / 2, 0, 0]){
      circle(r);
    }
  }
}

module plug2d(){
  difference(){
    plug2dsolid();
    offset(-1.5){
      plug2dsolid();
    }
  }  
}

module shearAlongX(p) {
  multmatrix([
    [1, 0, 0, 0],
    [p.y / p.x, 1, 0, 0],
    [p.z / p.x, 0, 1, 0]
  ]) children();
}

module crossbar(){
  // cuboid joiners on top/bottom
  translate([-(distance / 2 + r + outerr), r - 2, -2]){
    cube([distance + (r + outerr) * 2, 2, 6]);
  }
  translate([-(distance / 2 + r + outerr), -r, 0]){
    cube([distance + (r + outerr) * 2, 2, 4]);
  }
  shearAlongX([1, .125, 0]){
    translate([-(distance / 2 + r + outerr), -1, 0]){
      cube([distance + (r + outerr) * 2, 2, 4]);
    }
  }
  shearAlongX([1, -.125, 0]){
    translate([-(distance / 2 + r + outerr), -1, 0]){
      cube([distance + (r + outerr) * 2, 2, 4]);
    }
  }
}

module angle(){
  translate([0, r / 2 + 2, 0]){
    shearAlongX([1, -.125, 0]){
      cube([(distance + r + outerr) / 2, 2, 4]);
    }
  }
}

module invcross(){
  angle();
  mirror([0, 1, 0]){
    angle();
  }
  
  mirror([1, 0, 0]){
    angle();
    mirror([0, 1, 0]){
      angle();
    }
  }
}

module bridge(){
  crossbar();
  invcross();
}

/*
bridge();

translate([0, 0, -10]){
  bridge();
}
*/

// cpu side

jheight = 25;
jradius = 9;
lwidth = 29;

module topplug(){
  hull(){
    circle(jradius + 1);
    translate([lwidth, 0, 0]){
      circle(jradius + 1);
    }
  }
}

module cplug(jh = jheight){
  difference(){
    hull(){
      cylinder(jh, jradius, jradius);
      translate([lwidth, 0, 0]){
        cylinder(jh, jradius, jradius);
      }
    }
		union(){
			scale([0.9, 0.9, 1]){
				hull(){
					cylinder(jh, jradius, jradius);
					translate([lwidth, 0, 0]){
						cylinder(jh, jradius, jradius);
					}
				}
			}
			// remove back
			translate([0, 0, 0]){
			  cube([jh, 48, 30]);
			}
		}
  }
}


module shearAlongY(p) {
  multmatrix([
    [1, p.x / p.y, 0, 0],
    [0, 1, 0, 0],
    [0, p.z / p.y, 1, 0]
  ]) children();
}

module shearAlongZ(p) {
  multmatrix([
    [1, 0, p.x / p.z, 0],
    [0, 1, p.y / p.z, 0],
    [0, 0, 1, 0]
  ]) children();
}

module horn(){
         
        // first, the curved section emerging from the hole
        // into the motherboard chamber
        difference(){
          union(){
            rotate_extrude(angle=90){
              translate([20, 0, 0]){
                rotate([0, 0, 90]){
                  topplug();
                }
              }
            }
        
						
          // right horn bottom:
          // hollow vertical straightaway, without back
          difference(){  
            scale([1, 1.7, 1])
              translate([20, -39, -7]){
                rotate([270, 90, 0]){
                  cplug();
                }
              }
          }
						
          
					//not big enough for power!
					// right horn middle: sheared joiner
            shearAlongY([0, -20, -30]){
              translate([20, 0, lwidth - 28]){
                rotate([90, 270, 0]){
                  cplug();
                }
              }  
            }
					
					
  
            // hollow horizontal straightaway behind curved section
            scale([5, 1, 1]){
              translate([0, 20, lwidth]){
                rotate([180, 90, 0]){
                  cplug(jheight / 2);
                }
              }
            }
        
    }

        
          // hollow out top bend  
          union(){
            rotate_extrude(angle=90){
              translate([20, 3, 0]){
                scale([0.9, 0.9, 0.9]){
                  rotate([0, 0, 90]){
                    topplug();
                  }
                }
              }
            }
          }
        
        }
    
    }

translate([-90, -20, -10]){
    rotate([0, 90, 0]){
        horn();
    }
}

/*
// left horn gets cut off higher up
// we'll also want to remove its back to hide the molex
difference(){
  mirror([1, 0, 0]){
      translate([-90, -20, -10]){
          rotate([0, 90, 0]){
              horn();
						// right horn middle: sheared joiner
            shearAlongY([0, -20, -30]){
              translate([20, 0, lwidth]){
                rotate([90, 90, 0]){
                  cplug();
                }
              }  
            }
          }
				}
  }
  union(){
    translate([50, -100, -100]){
      cube([100, 70, 100]);
    }
    translate([75, -30, -30]){
      shearAlongY([1, -1, 0]){
        cube([20, 20, 10]);
      }
    }
  }
}

// now we bring left horn even further to the left, and cap it at the bottom
//scale([1.1, 0, 0])
translate([90.5, -29.5, -30]){
  rotate([90, 0, 0]){
    linear_extrude(1, scale=1.1){
      hull(){
        plug2d();
      }
    }
  }
}
*/