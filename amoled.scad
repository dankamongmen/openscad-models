// this brace holds a 5" Waveshare AMOLED capacitance screen in two 5.25"
// FlexBays in my CaseLabs Magnum T10. the brace itself will fit in any two
// colocated 5.25" bays; the mounts (amoled_flare.scad) are specific to
// the CaseLabs FlexBays. two mounts ought be printed along with this brace.
// they can then be glued together using e.g. Loctite along the lap joints.
//
// TODO: ought use a dovetail joint.
//
// if your printer can do more than 150mm, you can print the whole thing as
// a single piece, which is obviously desirable.

// dimensions of two FlexBays (what we're filling)
ew=149.5;
eh=87;

// amoled device dimensions (what we're holding)
ah=75;
aw=140.4;
at=1.5;
avm = (eh - ah) / 2; // device vertical margin
ahm = (ew - aw) / 2; // device horizontal margin

// screen dimensions (what we're viewing)
sh=68.7;
sw=121.76;
svm = (ah - sh) / 2; // screen vertical margin
shm = (aw - sw) / 2; // screen horizontal margin

fst = 2; // front slider thickness

depth=20; // unflared depth
backdepth=11; // flare-out depth
// unfortunately, my 150mm printer can't handle the flare, so
// we need print them as distinct pieces.
flare=0; // flare width
flarei = 5; // flare inset

// border around device, filling flexbay
difference(){
    union(){
        translate([aw + ahm - flarei, 0, depth]){
            cube([ahm + flare + flarei, eh, backdepth]);
        }
        translate([-flare, 0, depth]){
            cube([ahm + flare + flarei, eh, backdepth]);
        }
        cube([ew, eh, depth]);
    }
    union(){
        // leave out center for actual display
        translate([ahm, avm, 0]){
            cube([aw, ah, depth]);
        }
        // cut out on the side to slide through
        translate([0, avm, fst]){
            cube([ahm, eh - 2 * ahm, depth - fst - 7]);
        }
        // hole in the top for power hookup
        translate([15, -10, 5]){
            cube([55, 30, 15]);
        }
        // lap joints on back to paste flare
        translate([0, 0, depth]){
            cube([flarei - 1, eh, backdepth]);
        }
        translate([ew - flarei + 1, 0, depth]){
            cube([flarei - 1, eh, backdepth]);
        }
    }
}

// sliders to insert + hold device (front bottom)
translate([ahm, avm, 0]){
    cube([aw, svm, fst]);
}
// back bottom
translate([ahm, avm, fst + at]){
    cube([aw, 2, fst]);
}
// front top
translate([ahm, avm + sh + svm, 0]){
    cube([aw, svm, fst]);
}
// back top
translate([ahm, sh + avm + svm + 1, fst + at]){
    cube([aw, 2, fst]);
}
