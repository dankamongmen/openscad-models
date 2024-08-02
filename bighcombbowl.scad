include <BOSL2/std.scad>
include <BOSL2/screws.scad>

// OpenSCAD Parameterized Honeycomb Storage Wall
// Inspired by: https://www.printables.com/model/152592-honeycomb-storage-wall
// v1.0 - Initial version
// v1.1 - Updates
//        + Added tiny chamfer that was in the STEP file but not the diagram
//        + Added solid section modifier
//        + Added cutout modifier
//        + Added mirror modifier
//        + Added V-slot modifier
//        + Added mounting screws

// a carton is 210mm long.
// two next to one another are 225mm wide.
// a carton is 250mm tall.


/* [Size of the wall] */

// 9x4 is 90mm tall and 224mm long
// 8x4 is 90mm tall and ~200mm long


// Number of hexagons to make in the X axis
numx=9.5;

// Number of hexagons to make in the Y axis
numy=4;

// Mirror along the X axis which can help odd-numbered segments fit together
odd = false;

/* [Wall Modifiers: Solid section]  */

// Solid section for extra modifiers
solid_section = false;

solid_start=4;
solid_end=9;

/* [Wall Modifiers: cutout]  */

// Cutout so you can route larger cables through the wall or make room for a power outlet
cutout = false;

cutout_wall = 3;
cutout_x = 46;
cutout_y = 75;
cutout_x_offset = 53;
cutout_y_offset = 0;

/* [Wall Modifiers: vslot]  */

// Vslot modifier so you can use nuts intended for 2020 extrusion in the front (only really useful with a solid section)
vslot = false;

vslot_length = 260;
vslot_x = 0;

/* [Wall Modifiers: mounting screw holes]  */

// Mounting screw hole modifier - Screws that will go through the front of the panel so you can bolt into a wall (only really useful with a solid section)
mounting_screw = false;

// Mounting screw hole size
mounting_screw_spec = "M4"; // [M3, M4, #6, #8]

// Mounting screw head shape
mounting_screw_head = "flat"; // [none, flat, socket, button, pan]

mounting_screw_spacing = 50;

mounting_screw_distance = 180;

mounting_screw_x = 0;

/* [Shape of the hexes - you probably don't want to mess with these]  */
// thickness of the thinner wall
wall=1.8; //[:0.01]

// Height of the hexagon
height=20;

// fill in one 2-d hexagon with the lower right vertex at [ox, oy]
module hex(ox, oy){
	polygon([[ox, oy], [ox, oy + 12], [ox + 12, oy + 20],
					[ox + 24, oy + 12], [ox + 24, oy], [ox + 12, oy - 8]]);
}

module mirror_copy(v){
	children();
	mirror(v) children();
}

longd = 236;
hexd = 8;
y = -44;

// fill in the partial hexagons on the bottom of a face
module bottom(){
	hexw = 23.5;
	hexh = 8;
	for(x = [-longd / 2 + hexw:hexw:longd / 2 - hexw]){
		linear_extrude(hexd){
			polygon([[x - hexw / 2, y], [x + hexw / 2, y], [x, y + hexh]]);
		}
	}
	/*linear_extrude(hexd){
		polygon([[(longd / 2), y], [(longd / 2), y + hexh], [(longd / 2) - hexw / 2, y]]);
	}*/
}

// fill in the partial hexagons on the top of a face
module top(){
/*	rotate([180, 180, 0]){
		bottom();
	}*/
}

// fill in the four hexagons on the right side of a face
module oneside(){
	for(oy = [y:40:20]){
		translate([-longd / 2, 20, 0]){
			linear_extrude(hexd){
  			polygon([[0, oy], [0, oy + 28], [12, oy + 21], [12, oy + 7]]);
			}
		}
	}
	for(oy = [y - 20:40:0]){
		translate([-longd / 2, 28, 0]){
			linear_extrude(hexd){
				hex(0, oy);
			}
		}
	}
}

// flip and move the side filling produced by oneside()
module translate_copy(v){
	children();
	mirror([1, 0, 0]){
		translate(v){
			children();
		}
	}
}

// fills in the two partial hexagons on either side of a face
module sides(){
	translate_copy([0, 0, 0]){
		oneside();
	}
}

// Calculates the long diagonal (the diameter of a circle inscribed on the hexagon) from the short diagonal (the height of the hexagon)
function ld_from_sd(short_diameter) =
    (2/sqrt(3)*short_diameter);
    
// Calculates the edge length (length of one side) from the short diagonal (the height of the hexagon)
function a_from_sd(short_diameter) =
    (short_diameter/sqrt(3));

module cell(height, wall) {
    union() {
        tube(od=ld_from_sd(height+wall*2), id1=ld_from_sd(height)+0.5, id2=ld_from_sd(height), h=0.5, $fn=6, anchor=BOTTOM);
        up(0.5) tube(od=ld_from_sd(height+wall*2), id=2/sqrt(3)*height, h=4.5, $fn=6, anchor=BOTTOM);
        up(5) tube(od=ld_from_sd(height+wall*2), id1=ld_from_sd(height),id2=ld_from_sd(height+wall), h=1, $fn=6, anchor=BOTTOM);
        up(6) tube(od=ld_from_sd(height+wall*2), id=ld_from_sd(height+wall), h=2, $fn=6, anchor=BOTTOM);
    }
}

module section(numx, numy) {
    grid_copies(n=[numx,numy], spacing=sqrt(3)/2 * (height+wall*4), stagger=true) {
        if (solid_section && $col > solid_start && $col <= solid_end) {
            zrot(30) cyl(d=2/sqrt(3)*(height+wall*2),h=8, anchor=BOTTOM,$fn=6);
        } else {
            zrot(30) cell(height, wall);
        }
    }
}

module section_unioned_with_cutout(numx,numy) {
    if (cutout) {
        union() {
            difference() {
                section(numx,numy);
                translate([cutout_x_offset,cutout_y_offset,0]) cuboid([cutout_x,cutout_y,30]);
            }
            translate([cutout_x_offset,cutout_y_offset,0]) rect_tube(size=[cutout_x,cutout_y], h=8, wall=cutout_wall);
        }
    } else {
        section(numx,numy);
    }
}

// make a face, filling in the partial hexagons on all four sides
module hcomb() {
	difference() {
			if (odd) {
					section_unioned_with_cutout(numx*2,numy);
			} else {
					mirror([1,0,0]) section_unioned_with_cutout(numx*2,numy);
			}
			if (vslot) {
					xrot(-90) right(vslot_x) fwd(9.9) down(vslot_length/2) linear_extrude(vslot_length) polygon([[-3,10],[-3,8.5],[-6,8.5],[-6,7],[-2.5,3.4],[2.5,3.4],[6,7],[6,8.5],[3,8.5],[3,10]]);
			}
			if (mounting_screw) {
					right(mounting_screw_x) ycopies(spacing=mounting_screw_spacing, l=mounting_screw_distance) screw_hole(mounting_screw_spec,head=mounting_screw_head,anchor=TOP,l=20,orient=BOTTOM);
			}
	}
	bottom();
	top();
	sides();
}

difference(){
	union(){
		// solid bottom
		both = 3;
		translate([-(longd / 2), y - both, 0]){
			cube([longd, both, longd]);
		}
		
		// side at z==0
		hcomb();
		/*linear_extrude(hexd){
				polygon([[-110, 36], [-104, 36], [-104, 42]]);
		}*/
		
		// side opposite previous
		translate([0, 0, longd]){
			rotate([0, 180, 0]){
				hcomb();
			}
		}
		
		
		// left and right sides
		translate([-(longd / 2), 0, longd / 2]){
			rotate([0, 90, 0]){
				hcomb();
			}
		}
		
		translate([longd / 2, 0, longd / 2]){
			rotate([0, 270, 0]){
				hcomb();
			}
		}
	} // union of main material
	// subtract out front panel
	union(){
		translate([0, -20.25, longd - 5]){
			cube([longd - 95.5, 31, 10], center=true);
		}		
	}
}

difference(){				
	union(){
		// hanging panel with mounting holes
		//translate([0, 54, hexd / 2]){
		linear_extrude(hexd){
			for(ox=[-24:24:28]){
				for(oy=[y + 8:40:11]){
					hex(ox, oy);
					hex(ox - 12, oy + 20);
				}
			}
		}
		// hacks to fill in mesh until we fix hex() geometry
		translate([-24, y, 0]){
			cube([60, 2 * -y - 8, hexd]);
		}
	}
	translate([0, 20, hexd]){
		screw_hole("M3", length=2 * hexd);
	}
}