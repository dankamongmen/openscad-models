// we want something that can sit across the
// 5.25" bay holders and support the XTOP's
// mounts, designed to mate to a 120mm fan.
// 5.25" bay is 146.1mm wide
w = 146.1;

// we want to look like a 120mm fan
iw = 120;

// the mounts are 26mm
m = 26;

// we need a 16mm tall core to match the height
// of the other mount, sitting atop two fans and
// a radiator. on the outside, though, we don't
// want it so thicc, in case there's another
// device in the next bay up
h = 16;

// thin out at 1mm on each side
i = 1;

translate([-w/2, 0, 0]){
    translate([-1, 0, -h]){
        cube([1, m, h]);
    }
    translate([-1, 0, 0]){
        cube([i + 1, m, 1]);
    }
    // upper support (what the pump mates)
    translate([(w - iw) / 2, 0, 0]){
        cube([iw, m, h]);
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
    translate([w, 0, -h]){
        cube([1, m, h]);
    }
}