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
eh=86.5;

// amoled device dimensions (what we're holding)
ah=75.5;
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
        translate([2, eh - 2, 5]){
            rotate([180, 0, 0]){
                linear_extrude(5){
                    text("“schwarzgerät III”", size=5, font="Liberation Sans:style=Italic");
                }
            }
        }
        translate([ew - 50, eh - 2, 5]){
            rotate([180, 0, 0]){
                linear_extrude(5){
                    text("nick black 2022", size=4, font="Prosto One");
                }
            }
        }
        // leave out center for actual display
        translate([ahm, avm, 0]){
            cube([aw - 3, ah, depth]);
        }
        // cut out on the side to slide through
        translate([0, avm, fst]){
            cube([ahm, eh - 2 * ahm, depth - fst - 7]);
        }
        // hole in the top for power hookup
        translate([0, -10, 5]){
            cube([70, 30, 15]);
        }
        // lap joints on back to paste flare
        // left
        translate([0, 0, depth]){
            cube([flarei - 1, eh, backdepth]);
            for(i = [1:5]){
                translate([flarei - 1, i * 15, 0]){
                    cube([3, 5, backdepth]);
                }
            }
        }
        // right
        translate([ew - flarei + 1, 0, depth]){
            cube([flarei - 1, eh, backdepth]);
            for(i = [1:5]){
                translate([-3, i * 15, 0]){
                    cube([3, 5, backdepth]);
                }
            }
        }
    }
}

// sliders to insert + hold device
// front top
translate([ahm, avm, 0]){
    cube([aw, svm, fst]);
}
// back top
translate([ahm + aw / 2 - 5, avm, fst + at]){
    cube([aw / 2 + 5, 2, depth]);
}
// front bottom
translate([ahm, avm + sh + svm, 0]){
    cube([aw, svm, fst]);
}
// back bottom
translate([ahm, sh + avm + svm + 1, fst + at]){
    cube([aw / 2, 3, depth - 3]);
}

// reinforce across top, but avoid HDMI
translate([5, 0, 23]){
    cube([ew - 14 , 10, 8]);
}

// reinforce across top of right side, but avoid power
translate([0, 0, 12]){
    cube([9.5, eh, 8]);
}