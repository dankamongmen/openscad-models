// we want something that can sit across the
// 5.25" bay holders and support the XTOP's
// mounts, designed to mate to a 120mm fan.
// 5.25" bay is 146.1mm wide
w = 146.1;

// we want to look like a 120mm fan
iw = 120;
hw = 105; // screw hole centers are 105mm apart

// the mounts are 26mm
m1 = 47;

// we need a 16mm tall core to match the height
// of the other mount, sitting atop two fans and
// a radiator. on the outside, though, we don't
// want it so thicc, in case there's another
// device in the next bay up
h1 = 20;

// come just about down to the bottom
h2 = 70;

// brace we're topping is 1.5mm wide. give it
// an extra half mm.
i = 2;

// 5.55mm diameter screws
sw = 5.55 / 2;

// the wings on the sides hold us onto the
// braces. if they're too thin, they'll break off.
ww = 3;

translate([-w/2, 0, 0]){
    // left wing is extended to the bottom
    translate([-(i + ww), 0, -h2]){
        cube([ww, m1, h2]);
    }
    // upper support (what the pump mates)
    translate([(w - iw) / 2, 0, 0]){
        
        difference(){
            minkowski(){
                cube([iw, m1, h1]);
                cylinder(r = 2, h = 2);
            }
            union(){
                translate([(iw - hw) / 2, m1 / 2, h1 - 2]){
                    cylinder(h1, sw, true);
                }
                translate([(iw - hw) / 2 + hw, m1 / 2, h1 - 2]){
                    cylinder(h1, sw, true);
                }
            }
        }
    }
    // common layer
    translate([-(i + ww), 0, 0]){
        minkowski(){
            cube([w + i * 2 + ww * 2, m1, 1.5]);
            rotate([90, 90, 0]){
                cylinder(r = 2, h = 2);
            }
        }
    }
    // middle piece to wedge us atop bay mounts
    translate([i + 1, 0, -4]){
        cube([w - i * 2 - 2, m1, 4]);
    }
    // right wing
    translate([w + i, 0, -h1]){
        cube([ww, m1, h1]);
    }
}

// 15mm from xtop brace to back
m2 = 15;

translate([0, m1, 0]){
translate([-w/2, 0, 0]){
    // left wing
    translate([-(i + ww), 0, -h2]){
      cube([ww, m2, h2]);
    }
    translate([-(i + ww), 15, -h2]){
      cube([ww, m2, h2 - 15]);
    }
    
    // common layer
    translate([-(i + ww), 0, 0]){
        minkowski(){
            cube([w + i * 2 + ww * 2, m2, 1.5]);
            rotate([90, 90, 0]){
                cylinder(r = 2, h = 2);
            }
        }
    }
    // middle piece to wedge us atop bay mounts
    translate([i + 1, -1, -4]){
        cube([w - i * 2 - 2, m2, 4]);
    }
    // right wing
    translate([w + i, 0, -h2]){
      cube([ww, m2, h2]);
    }
    translate([w + i, 15, -h2]){
      cube([ww, m2, h2 - 15]);
    }

    // backplate
    translate([-i, m2 + 12, -h2]){
      cube([w + i * 2, ww, h2 - 15]);
    }

}

difference(){
  translate([0, m2, -m2 + 1]){
    rotate([0, 90, 0]){
      minkowski(){
        cylinder(w + i * 3, m2, m2, true);
        rotate([90, 90, 0]){
          cylinder(2, 2, 2);
        }
      }
    }
  }
  union(){
    translate([0, 0, -45]){
      cube([w + i * 15, m2 * 4, m2 * 4], true);
    }
    translate([0, -m2, -m2]){
      cube([w + i * 15, m2 * 4, m2 * 4], true);
    }
  }
}
}

// 40mm from xtop brace to fan
m3 = 40;

// don't interfere with the screws
h3 = 15;

translate([-w/2, -m3, 0]){
    // left wing
    translate([-(i + ww), 0, -h3]){
        cube([ww, m3, h3]);
    }
    // common layer
    translate([-(i + ww), 0, 0]){
        minkowski(){
            cube([w + i * 2 + ww * 2, m3, 1.5]);
            rotate([90, 90, 0]){
                cylinder(r = 2, h = 2);
            }
        }
    }
    // middle piece to wedge us atop bay mounts
    translate([i + 1, -1, -4]){
        cube([w - i * 2 - 2, m3, 4]);
    }
    // right wing
    translate([w + i, 0, -h3]){
        cube([ww, m3, h3]);
    }
}