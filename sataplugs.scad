// we're not describing SATA power plugs,
// but rather the three EVGA plugs that connect to
// our PSU's three SATA ports.


give = 0.2; // gaps on fittings

evgawidth = 15; // studs only extend the height
evgaheight = 9; // does NOT include studs

// there are two of these 3x1x1 studs, one on either
// side of the EVGA connector.
evgacstudwidth = 3;
evgastudheight = 1;
evgastuddepth = 1 + give;

// then there's a center clip which plugs in. it's
// only about 2mm in front of the studs.
evgastudgap = 2;
// 4mm covers the top of the stud through the
// bottom of the center spoke. we need be at least
// this tall to wedge against both
evgastudcenterheight = 4;

plugs = 3;

// total geometry of the EVGA connector
totalheight = evgastudcenterheight + evgaheight + evgastudheight;
totalwidth = 3 * evgawidth;

extrawidth = 4; // per side
plugwidth = 2;

depth = 10; // random for now

w = totalwidth + extrawidth * 2;
// the bottom, where the plugs nestle
translate([-totalwidth / 2, 0, 0]){
    difference(){
        cube([totalwidth, 5, depth]);
        union(){
            // lop off the top until we clear the plug (3 deep)
            translate([0, 4, 0]){
                cube([totalwidth, 1, evgastudgap + evgastuddepth]);
            }
            // cut out hole for stud
            translate([0, 3, evgastudgap]){
                cube([totalwidth, 1, evgastuddepth]);
            }
        }
    }
}

// side walls (each extrawidth thick, with a hole)
module sidewall(){
    translate([w / 2 - extrawidth, 0, 0]){
        difference(){
            cube([extrawidth, totalheight / 2, depth]);
            translate([1 + give / 2, 1, 1]){
                cube([plugwidth + give, totalheight / 2 - 1, depth - 2]);
            }
        }
    }
}
sidewall();
mirror([1, 0, 0]){
    sidewall();
}

// now our top piece

// top sides are solid with a plug
module topsidewall(){
    translate([w / 2 - extrawidth, 0, 0]){
        cube([extrawidth, totalheight / 2, depth]);
        translate([1 + give, totalheight / 2, 1 + give]){
            cube([plugwidth - give * 2, totalheight / 2 - 1 - give, depth - 2 - give * 2]);
        }
    }
}

translate([0, 0, -20]){
    translate([-w / 2, 0, 0]){
        cube([w, 1, depth]);
    }
    topsidewall();
    mirror([1, 0, 0]){
        topsidewall();
    }
}
