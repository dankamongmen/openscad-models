// wrapper for 24-pin ATX cable
// essential a long continuous cable comb. the cable
// will be laying in two flat rows of 12 wires each.
// 4 pins take a centimeter, so we'll be 3cm (30mm) wide
// in our core...

gap = 0.3;

// volume of the empty core, a cuboid 15cm long
width = 30;
height = 5;
length = 150;

// 3mm wall, 3mm gap, 3mm wall
wwall = 3;
wlock = 3;
wthick = wlock + 2 * wwall;

// 2mm top and bottom
twall = 2;

module sidefemale(l, h){
    difference(){
        cube([wthick, h, l]);
        translate([wwall, 1, 3]){
            cube([wlock, h - 1, l - 6]);
        }
    }
}

module sidemale(l, h){
    cube([wthick, h, l]);
    translate([wwall, h, 3]){
        cube([wlock, h - 1 - gap, l - 6 - gap * 2]);
    }
}

module topbot(l){
    cube([width, twall, l]);
}

sidefemale(length, height / 2 + twall);
translate([width, 0, 0]){
    sidemale(length, height / 2 + twall);
}
topbot(length);