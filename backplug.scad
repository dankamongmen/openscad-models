s=7.5;
t=20;
w=65;
h=50;
zh=15;
difference(){
    translate([-w/2 + 7, -20, -zh]){
        cube([w + 7, h, zh]);
    }
    union(){
        // main cavity, closed top
        translate([-(w-10)/2 + 7, -40, -(zh -2)]){
            cube([w - 3, h, zh - 5]);
        }
        // inlet on left side
        translate([55, -10, -(zh - 1)]){
            cube([10, 20, zh]);
        }
        // area intersecting with plug
        translate([-15, -15, -3]){
            cube([30, 22, 3]);
        }
    }
}
translate([30, -15, -15])
    rotate([0, 180, 0])
        linear_extrude(2)
            text("III", font="Liberation Sans:style=Bold Italic", size=40);
translate([40, 25, -15])
    rotate([180, 0, 270])
        linear_extrude(2)
            text("schwarzgerät", size=5);
// round element (plug)
difference(){
    union(){
        translate([-15, 0, 0]){
            cylinder(t, s, s);
        }
        translate([-15, -s , 0]){
          cube([30, s*2  ,t]);
        }
        translate([15, 0, 0]){
          cylinder(t , s, s);
        }
    }
    union(){
        translate([-15, 0, 0]){
            cylinder(15, s - 1, s- 1);
        }
        translate([-14, -7.5, 0]){
            cube([28, s*2 -2, 25]);
        }
        translate([15, 0, 0]){
            cylinder(15, s - 1, s - 1);
        }
    }
}