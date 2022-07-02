// wedge to lock into cage channels for sata cables
use <MCAD/regular_shapes.scad>
module satawedge(){
    difference(){
        hull(){
            translate([0, 48, 0]){
                rotate([0, 0, 30]){
                    triangle_prism(25, 5);
                }                   
            }
            rotate([0, 0, 30]){ 
                triangle_prism(25, 5);
            }
        }
        union(){
            translate([0, 48, 0]){
                rotate([0, 0, 30]){
                    triangle_prism(25, 5);
                }                   
            }
            rotate([0, 0, 30]){ 
                triangle_prism(25, 5);
            }
        }
    }
}