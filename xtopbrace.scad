// we want something that can sit across the
// 5.25" bay holders and support the XTOP's
// mounts, designed to mate to a 120mm fan.
// 5.25" bay is 146.1mm wide
w = 146.1;

// we want to look like a 120mm fan
iw = 120;
hw = 105; // screw hole centers are 105mm apart

// the mounts are 26mm
m = 47;

// we need a 16mm tall core to match the height
// of the other mount, sitting atop two fans and
// a radiator. on the outside, though, we don't
// want it so thicc, in case there's another
// device in the next bay up
h = 20;

// brace we're topping is 1.5mm wide. give it
// an extra half mm.
i = 2;

// 5.55mm diameter screws
sw = 5.55 / 2;

// the wings on the sides hold us onto the
// braces. if they're too thin, they'll break off.
ww = 3;

translate([-w/2, 0, 0]){
    // left wing
    translate([-(i + ww), 0, -h]){
        cube([ww, m, h]);
    }
    // upper support (what the pump mates)
    translate([(w - iw) / 2, 0, 0]){
        difference(){
            cube([iw, m, h]);
            union(){
                translate([(iw - hw) / 2, m / 2, h - 2]){
                    cylinder(h, sw, true);
                }
                translate([(iw - hw) / 2 + hw, m / 2, h - 2]){
                    cylinder(h, sw, true);
                }
                translate([19, 4, 7]){
                    rotate([90, 0, 0]){
                        linear_extrude(4){
                            text("schwarzgerät");
                        }
                    }
                }
            }
        }
    }
    // common layer
    translate([-(i + ww), 0, 0]){
        minkowski(){
            cube([w + i * 2 + ww * 2, m, 1.5]);
            rotate([90, 90, 0]){
                cylinder(r = 2, h = 2);
            }
        }
    }
    // middle piece to wedge us atop bay mounts
    translate([i + 1, 0, -4]){
        cube([w - i * 2 - 2, m, 4]);
    }
    // right wing
    translate([w + i, 0, -h]){
        cube([ww, m, h]);
    }
}