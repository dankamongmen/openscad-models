// we want something that can sit across the
// 5.25" bay holders, which are 146.1mm wide
w = 146.1;

// 40mm from xtop brace to fan
m = 40;

// don't interfere with the screws
h = 15;

// brace we're topping is 1.5mm wide. give it
// an extra half mm.
i = 2;

// the wings on the sides hold us onto the
// braces. if they're too thin, they'll break off.
ww = 3;

translate([-w/2, 0, 0]){
    // left wing
    translate([-(i + ww), 0, -h]){
        cube([ww, m, h]);
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
    translate([i + 1, -1, -4]){
        cube([w - i * 2 - 2, m, 4]);
    }
    // right wing
    translate([w + i, 0, -h]){
        cube([ww, m, h]);
    }
}