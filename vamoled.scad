// vertically-held AMOLED 2-bay frame
// with vertical holds, there's less area under pressure, and we can
// leave the top entirely unoccupied (aside from in the very front),
// which makes HDMI/power hookups easier.

include <cyl_head_bolt.scad>

// area of 2x5.25" FlexBays. we want to fill all of this in up front.
ew = 149.5;
eh = 86.5;

// the screen is 10mm in from the front of the brace, placing it behind the
// actual case cutaway, simplifying the running of cables.
insetdepth = 10;

// the device in toto, including its bezel. we will hide the bezel, and must
// hold the device.
devw = 140.4;
devh = 74.76;

// the visible area
vieww = 121.76;
viewh = 68.7;
viewt = 5; // measured thickness of bezel section

frameb = 10; // 10mm for bottom frame, with text
framet = eh - viewh - frameb;
framel = (ew - vieww) / 2;
framer = framel;

backt = 5; // thickness behind the device
frontt = insetdepth + viewt + backt;

// we put the front on the top (z-axis wise), as it has the most delicate
// printing to do, and we want the finest finish there
translate([8, 0, 0]){
    difference(){
        union(){
            cube([ew, eh, frontt]);
        }
        union(){
            translate([framel, frameb, 0]){
                cube([vieww, viewh, frontt]);
            }
            // underneath the front frame, we have the section where the screen is
            // held in place/inserted, by widening the cutaway to not include the
            // device's side bezel
            translate([(ew - devw) / 2, frameb, backt]){
                cube([devw, viewh + framet, viewt]);
            }
            // cut away the top behind the device, and everything on the left,
            // where we run a power cable
            translate([0, eh - framet, 0]){
                cube([vieww + framel, framet, backt]);
            }
            translate([2, 2, 0]){
                linear_extrude(frontt){
                    text("“schwarzgerät III”", size=6, font="Liberation Sans:style=Italic");
                }
            }
            translate([ew - 61, 2, 0]){
                linear_extrude(frontt){
                    text("nick black 2022", size=5, font="Prosto One");
                }
            }
        }
    }
}

flare = 11;
flarei = 5;
backdepth = 10;

difference(){
    union(){
        cube([8, eh - framet, backdepth]);
    }
    union(){
        for(i = [23, 37, 63, 79]){
            translate([4, i, -2]){
                rotate([180, 0, 90]){
                    hole_through("M4", l=100, cld=0.1, h=1, hcld=1);
                }
            }
        }
    }
}
translate([8 + ew, 0, 0]){
    difference(){
        union(){
            cube([8, eh, backdepth]);
        }
        union(){
            for(i = [23, 37, 63, 79]){
                translate([4, i, -2]){
                    rotate([180, 0, 90]){
                        hole_through("M4", l=100, cld=0.1, h=1, hcld=1);
                    }
                }
            }
        }
    }
}