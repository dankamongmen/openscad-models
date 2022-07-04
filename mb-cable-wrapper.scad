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

// side includes top/bottom, and half of interior height
wheight = height / 2 + twall;

// additional height of the plug / depth of the receptacle
pheight = wheight - 2;

module sidefemale(l, h){
    difference(){
        cube([wthick, h, l]);
        translate([wwall, wheight - pheight, 3]){
            cube([wlock, pheight, l - 6]);
        }
    }
}

module sidemale(l, h){
    cube([wthick, h, l]);
    translate([wwall, h, 3]){
        cube([wlock - gap *2, pheight - gap, l - 6 - gap * 2]);
    }
}

module topbot(l){
    cube([width, twall, l]);
}

sidefemale(length, wheight);
translate([width + wthick, 0, 0]){
    sidemale(length, wheight);
}
translate([wthick, 0, 0]){
  topbot(length);
}