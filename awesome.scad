include <MCAD/regular_shapes.scad>
include <MCAD/2Dshapes.scad>

/*
hull(){
difference(){
  octagon_prism(40, 10);
  octagon_prism(40, 8);
}
translate([14, 14, 0]){
  octagon_tube(40, 10, 1);
}
}
*/
module skew(dims) {
matrix = [
	[ 1, tan(dims[0]), tan(dims[1]), 0 ],
	[ tan(dims[2]), 1, tan(dims[3]), 0 ],
	[ tan(dims[4]), tan(dims[5]), 1, 0 ],
	[ 0, 0, 0, 1 ]
];
multmatrix(matrix)
children();
}

module shearAlongX(p) {
  multmatrix([
    [1, 0, 0, 0],
    [p.y / p.x, 1, 0, 0],
    [p.z / p.x, 0, 1, 0]
  ]) children();
}


module shearAlongZ(p) {
  multmatrix([
    [1,0,p.x/p.z,0],
    [0,1,p.y/p.z,0],
    [0,0,1,0]
  ]) children();
}

module cubetube(l, w, h){
  difference(){
    cube([l, w, h], center=true);
    scale([0.9, 0.9, 1]){
      cube([l, w, h], center=true);
    }
  }
}

union(){
  cylinder_tube(40, 10, 1, center=true);
  
  cubetube(20, 10, 40);
  //cube([20, 10, 40], center=true);
  rotate([0, 0, 90]){
    cubetube(20, 10, 40);
    //cube([20, 10, 40], center=true);
  }
}


shearAlongX([1, 0, 2]){
  translate([15, 0, -20]){
    difference(){
      cube([10, 10, 40], center=true);
      scale([1, 0.9, 0.9]){
        cube([10, 10, 40], center=true);
      }
    }
  }
}

translate([30, 0, 20]){
  cylinder_tube(40, 10, 1, center=true);
  rotate([0, 0, 90]){
    cubetube(20, 10, 40);
  }
}
translate([30, 0, 20]){
  cubetube(20, 10, 40);
}

/*
linear_extrude(height = 100, twist = 900, slices = 100) {
  difference(){
    pieSlice([50, 100], start_angle=0, end_angle=180);
    pieSlice([40, 90], start_angle=0, end_angle=180);  
  }
}
*/