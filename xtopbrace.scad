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
h = 16;

// brace we're topping is 1.5mm wide. give it
// an extra half mm.
i = 2;

// 5.55mm diameter screws
sw = 5.55 / 2;

translate([-w/2, 0, 0]){
    translate([-i, 0, -h]){
        cube([1, m, h]);
    }
    translate([-i, 0, 0]){
        cube([i + 2, m, 1]);
    }
    // upper support (what the pump mates)
    translate([(w - iw) / 2, 0, 0]){
        difference(){
            cube([iw, m, h]);
            union(){
                translate([(iw - hw) / 2, m / 2, h - 2]){
                    cylinder(h - 2, sw, true);
                }
                translate([(iw - hw) / 2 + hw, m / 2, h - 2]){
                    cylinder(h - 2, sw, true);
                }
                translate([19, 4, 4]){
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
    translate([i, 0, 0]){
        cube([w, m, 1]);
    }
    // middle piece to wedge us atop bay mounts
    translate([i + 1, 0, -4]){
        cube([w - i * 2 - 2, m, 4]);
    }
    translate([w - i, 0, 0]){
        cube([i + 1, m, 1]);
    }
    translate([w + i - 1, 0, -h]){
        cube([1, m, h]);
    }
}