holeh = 8.6;
plugh = 10;
clips = 16;
clipe = 17.5;

module plug(){
    difference(){
      union(){
        cylinder(plugh, r=17, true);
        translate([0, 0, 10]){
            cylinder(4, 21, true);
        }
        polyhedron(
          [[clips, holeh / 2, 1],
           [clips, holeh / 2, plugh - 2],
           [clips, -holeh / 2, 1],
           [clips, -holeh / 2, plugh - 2],
           [clipe, holeh / 2, plugh - 2],
           [clipe, -holeh / 2, plugh - 2]],
          [[1, 4, 5, 3], // facing top
           [5, 4, 0, 2], // inclined plane
           [0, 1, 3, 2], // back
           // side triangles
           [0, 4, 1],
           [2, 3, 5]]
        );
        polyhedron(
          [[-clips, holeh / 2, 1],
           [-clips, holeh / 2, plugh - 2],
           [-clips, -holeh / 2, 1],
           [-clips, -holeh / 2, plugh - 2],
           [-clipe, holeh / 2, plugh - 2],
           [-clipe, -holeh / 2, plugh - 2]],
          [[1, 4, 5, 3], // facing top
           [5, 4, 0, 2], // inclined plane
           [0, 1, 3, 2], // back
           // side triangles
           [0, 4, 1],
           [2, 3, 5]]
        );
      }
      cube([24, holeh, 50], true);
    }
}