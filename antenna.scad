use <top-back-molex.scad>

// print with as little infill as possible

// antenna is 70 at its longest and 30 at its widest
// magnets are 10 x 2 x 57

// total diameter from one extreme of left plug to extreme
// of right plug
diameter = 92;

// outer diameter of a single plug
plugd = 42;

// space between inner extrema
gap = diameter - plugd * 2;

translate([plugd / 2 + gap / 2, 0, 0]){
    plug();
}
translate([-plugd / 2 - gap / 2, 0, 0]){
    plug();
}

translate([0, -15, 27]){
    difference(){
        minkowski(){
            cube([diameter, 40, 30], true);
            sphere(2);
        }
        union(){
            translate([0, -17, 35]){
                cube([57 + .6, 2 + .6, 50], true);
            }
        }
    }
}

