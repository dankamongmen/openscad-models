// vertically-held AMOLED 2-bay frame
// with vertical holds, there's less area under pressure, and we can
// leave the top entirely unoccupied (aside from in the very front),
// which makes HDMI/power hookups easier.
include <roundedcube.scad>
include <cyl_head_bolt.scad>
use </home/dank/.local/share/fonts/StencilDisco.ttf>
use </home/dank/.local/share/fonts/Stencil Brush.ttf>
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
vieww = 121.76 + 0.3 * 2; // measured + 0.3 * 2 tolerance
viewh = 68.7; // 68.7 measured
viewt = 9.5; // measured thickness of bezel section

frameb = 10; // 10mm for bottom frame, with text
framet = eh - viewh - frameb;
framel = (ew - vieww) / 2;
framer = framel;

backt = 5; // thickness behind the device
frontt = insetdepth + viewt + backt;
backw = 9;
backdepth = 10;

// we put the front on the top (z-axis wise), as it has the most delicate
// printing to do, and we want the finest finish there
translate([backw, 0, 0]){
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
                cube([vieww + framel, framet, backt + viewt]);
            }
            // we need bridge out the holes in the letters here
            difference(){
              translate([0, 2.5, 0]){
                  linear_extrude(frontt){
                      text("“schwarzgerät III”", size=6.5, font="Liberation Serif:style=Italic");
                  }
              }
              // first 'a'
              translate([24.5, 2.7, 0]){
                cube([0.5, 0.5, frontt]);
              }
              // 'g'
              translate([36, 2.3, 0]){
                cube([0.5, 2, frontt]);
              }
 
              // 'e'
              translate([40, 4, 0]){
                cube([1, 1, frontt]);
              }
              // second 'a'
              translate([47.5, 2, 0]){
                cube([0.5, 2, frontt]);
              }
            }
            translate([ew - 42, 0, 0]){
                linear_extrude(frontt){
                    text("nick black", size=8, font="Stencil Brush");
                }
            }
        }
    }
}

difference(){
    union(){
        cube([backw, eh - framet, backdepth]);
    }
    union(){
        for(i = [25, 39, 66, 82]){
            translate([4, i, -2]){
                rotate([180, 0, 90]){
                    hole_through("M3", l=100, cld=0.1, h=1, hcld=1);
                }
            }
        }
    }
}
translate([backw + ew, 0, 0]){
    difference(){
        union(){
          cube([backw, eh, backdepth]);
        }
        union(){
            for(i = [25, 39, 66, 82]){
                translate([6, i, -2]){
                    rotate([180, 0, 90]){
                        hole_through("M3", l=100, cld=0.1, h=1, hcld=1);
                    }
                }
            }
        }
    }
}