// through-plug + cable box for back of caselabs T10

s=8.5;
t=10;
w=88;
h=88;
zh=15;
difference(){
    translate([-w/2, -20, -zh]){
        cube([w, h, zh]);
    }
    union(){
        // main cavity, closed bottom
        translate([-(w-10)/2, -18, -(zh -2)]){
            cube([w - 8, h, zh - 5]);
        }
        // inlet on left side
        translate([40, -10, -(zh - 1)]){
            cube([10, 20, zh]);
        }
        // inlet on right side
        translate([-46, -10, -(zh - 1)]){
            cube([10, 20, zh]);
        }
        // area intersecting with plug
        translate([-5, -25, -8]){
            cube([34, 33, 8]);
        }
    }
}
translate([28, -10, -15])
    rotate([0, 180, 0])
        linear_extrude(2)
            text("III", font="Liberation Sans:style=Bold Italic", size=55);
translate([38, 46, -15])
    rotate([180, 0, 270])
        linear_extrude(2)
            text("schwarzgerät", size=7);
// round element (plug)
difference(){
    union(){
        translate([-5, 0, 0]){
            cylinder(t, s, s);
        }
        translate([-5, -s , 0]){
          cube([30, s*2, t]);
        }
        translate([25, 0, 0]){
          cylinder(t, s, s);
        }
    }
    union(){
        translate([-5, 0, 0]){
            cylinder(15, s - 1, s- 1);
        }
        translate([-5, -12.5, 0]){
            cube([34, s*2 + 2, 35]);
        }
        translate([25, 0, 0]){
            cylinder(15, s - 1, s - 1);
        }
    }
}
