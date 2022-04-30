thickness=1.2;

module pci_bracket() {
union() {
difference() {
union () {
translate([0,-0.25,0]) cube([115,18.5,thickness],center=true);
translate([58.5,2.5,0]) cube([8,18.5,thickness],center=true);
}
translate([57,-13.7,0]) rotate([0,0,40]) cube([10,10,10],center=true);
translate([55,16,0]) rotate([0,0,40]) cube([10,10,10],center=true);
translate([-50,-12.5,0]) rotate([0,0,45]) cube([10,10,10],center=true);
translate([-50,12.5,0]) rotate([0,0,45]) cube([10,10,10],center=true);
translate([-55,-10.5,0]) cube([10,10,10],center=true);
translate([-55,10.5,0]) cube([10,10,10],center=true);
}
difference() {
translate([62,2.5,6]) cube([thickness,18.5,11],center=true);
translate([62,10.75,5.5]) cube([2,6,4],center=true);
translate([62,8,5.5]) rotate([0,90,0]) cylinder(r=2,h=2,center=true);
}
}
}

pci_bracket();
translate([0,0,-2]){
    rotate([0,90,0]){
        translate([-0.5, -5, -40]){
            difference(){
            cube([12,14,90]);
                translate([1,5,0]){
                    cube([8,6,90]);
                    cube([3,9,90]);
                }
            }
        }
    }
}
translate([-40,-6,-2]){
    cube([102,15,2]);
}

$fn=50;
