// roof is ~75mm
// fan is ~27mm tall
// put fan at 43mm, leaves 5mm
difference(){
    cube([145,145,60]);
    translate([5,5,5]){
        cube([140,140,70]);
    }
    translate([0, 5, 5]){
        cube([5, 130, 50]);
    }
    translate([5, 0, 5]){
        cube([130, 5, 50]);
    }
    translate([5, 5, 0]){
       cube([130, 130, 5]);
    }
    for(i = [1:5]){
        translate([140, i * 23, 0]){
            cube([5, 10, 5]);
        }
        translate([140, i * 23 - 2, 0]){
            cube([2, 14, 5]);
        }
    }
}
translate([135,0,0]){
    cube([10, 15, 43]);
}
cube([10,10,43]);
translate([0, 135, 0]){
    cube([15,10,43]);
}
translate([135,135,0]){
    cube([10,10,43]);
}
for(i = [1:5]){
    translate([i * 23, 145, 0]){
        cube([10, 5, 5]);
    }
    translate([i * 23 - 2, 148, 0]){
        cube([14, 2, 5]);
    }
}
