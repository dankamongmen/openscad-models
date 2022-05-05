// dimensions of two FlexBays (what we're filling)
ew=150;
eh=87;

// amoled device dimensions (what we're holding)
ah=74.76;
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

// border around device, filling flexbay
difference(){
    cube([ew, eh, 5]);
    union(){
        // leave out center for actual display
        translate([ahm, avm, 0]){
            cube([aw, ah, 2* fst + at]);
        }
        // cut out on the side to slide through
        translate([0, avm, fst]){
            cube([ahm, eh - 2 * ahm, 5 - fst]);
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
translate([ahm, avm + ah, 0]){
    cube([aw, svm, fst]);
}
// back bottom
translate([ahm, avm + ah, fst + at]){
    cube([aw, 2, fst]);
}