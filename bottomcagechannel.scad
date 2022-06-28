/// cable runner from PSU to drive cages, enclosing two SATA cables with
// four power plugs each
// width of SATA molex power connector is 23mm (male) or 21mm (female)

use <MCAD/regular_shapes.scad>  
include <joiner.scad>
height = 136; // measured
sidew = 150; // 30 on, 120 off
sidet = 4;
depth = 40;
latchh = 4;
backt = 4;
risergap = 8; // space occupied by drive mounts
riserspace = 2; // space occupied by drive cage
// with 14, we're getting close to the top screw
riserdepth = 14; // how far riser descends

difference(){
  union(){
        union(){
          // side face, with indentations for labeling drives
          translate([backt, latchh, 0]){
            difference(){
              cube([sidew, height, sidet]);
              union(){
                linear_extrude(2){
                  for(ul = [1 : 4]){
                    polygon([[16, height - ul * height / 5 - 10],
                             [sidew - 100, height - ul * height / 5],
                             [sidew - 100, height - ul * height / 5 + 10],
                             [16, height - ul * height / 5]]);
                  }
                }
              }
            }
          }
          // top and bottom faces
          translate([backt, 0, 0]){
            cube([sidew, latchh, depth]);
          }
          translate([backt, latchh + height, 0]){
            cube([sidew, latchh, depth]);
          }
          // back face
          cube([backt, height + 2 * latchh, depth]);
        }
        // riserlock on the top
        translate([0, height + latchh - riserdepth, backt]){
          cube([sidew + backt, riserdepth, risergap]);
          translate([0, 0, riserspace + risergap]){
            cube([sidew + backt, riserdepth, 4]);
          }
        }
        
        // riserlock on the bottom
        translate([0, latchh, backt]){
          cube([sidew + backt, riserdepth, risergap]);
        }
        translate([0, latchh + 4, risergap + backt + 4]){
          cube([sidew + backt, 4, 24]);
        }
        translate([5, 124, 15]){
            rotate([0, 0, 30]){
                triangle_prism(25, 5);
            }
        }        
        translate([5, 76, 15]){
            rotate([0, 0, 30]){
                triangle_prism(25, 5);
            }
        }
        // two triprisms to hold plugin
        translate([5, 124, 15]){
            rotate([0, 0, 30]){
                triangle_prism(25, 5);
            }
        }        
        translate([5, 76, 15]){
            rotate([0, 0, 30]){
                triangle_prism(25, 5);
            }
        }
  }
  union(){
    translate([0, 80, 15]){
        cube([4, 40, 30]);
    }
    // prep for corner rounding
    cube([5, height + latchh * 2, 5]);
    translate([150, 0, 0]){
      cube([4, height + latchh * 2, 4]);
    }
  }
  /*
  translate([0, 126, 32]){
    rotate([0, 90, 0]){
      cylinder(4, 5, 5);
    }
  }*/
}


// round the primary corner
translate([6, 0, 6]){
  difference(){
    rotate([270, 0, 0]){
      cylinder(height + latchh * 2, 6, 6);
    }
    translate([-6, 0, 0]){
      cube([12, height + latchh * 2, 12]);
    }
    translate([0, 0, -6]){
      cube([6, height + latchh * 2, 12]);
    }
  }
}

// round the far corner
translate([151, 0, 3]){
  difference(){
    rotate([270, 0, 0]){
      cylinder(height + latchh * 2, 3, 3);
    }
    translate([-3, 0, 0]){
      cube([6, height + latchh * 2, 6]);
    }
    translate([3, 0, -3]){
      cube([3, height + latchh * 2, 6]);
    }
  }
}

/*
fchunk(height, sidew);
shearAlongX([1, -1, 0]){
  translate([-40, -40, 0]){
    fchunk(height, sidew);
  }
}
translate([-80, 40, 0]){
  fchunk(height, sidew);
}
*/