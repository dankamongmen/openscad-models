// Each unit has an underside, but not a top, because
// tops are hard to print without support. The top
// comes from the bottom of the unit above, and
// discrete top pieces at the top of the collection.
//
// Each unit has holes in the top of the back and
// both sides. These can be used together with
// friction fasteners to combine units.


 // all units' heights are a multiple of 50
unithquantum = 50;
wallt = 5; // outer wall thickness (not dividers)
bottomt = 0; // bottom thickness
plugt = 3; // side plug/hole depth
topplugt = 10; // top plug/hole depth
plugr = unithquantum / 10;
backd = (plugr + wallt - plugt) * 2;
// we really only have 256x238 on the bambu x1c.
// we want to maximize width, so we'll print 90deg
// rotated from the target geometry.
unitd = 144;
unitw = 238; // leaves 228 for unitinnerw
// 2 subunits, 1 separator: 4mm sep, 112mm subunits
// 3 subunits, 2 separators: 3mm sep, 74mm subunits
// 4 subunits, 3 separators: 4mm sep, 54mm subunits
// 5 subunits, 4 separators: 2mm sep, 44mm subunits

unitinnerw = unitw - wallt * 2;
unitinnerd = unitd - backd;

module hole(t){
	cylinder(t, plugr, plugr, true);
}

module sidehole(){
	rotate([0, 90, 0]){
		hole(plugt);
	}
}

module tophole(h){
	translate([0, 0, (h - topplugt) / 2]){
		hole(topplugt);
	}
}

module bothole(h){
	translate([0, 0, -(h - topplugt) / 2]){
		hole(topplugt);
	}
}

module topholeQ1(h){
	translate([unitinnerw / 3, unitinnerd / 2, 0]){
		tophole(h);
	}
	translate([unitinnerw / 3, unitinnerd / 2, 0]){
		bothole(h);
	}
}

// a sidehole in quadrant I
module sideholeQ1(){
	// put the plugs at 2/3 and 1/3
	translate([unitinnerw / 2 + (wallt - plugt) + plugt / 2, unitinnerd / 3, 0]){
		sidehole();
	}
}

module bothsidesX(){
	children();
	mirror([1, 0, 0]){
		children();
	}
}

module bothsidesY(){
	children();
	mirror([0, 1, 0]){
		children();
	}
}

module allquads(){
	bothsidesY(){
		bothsidesX(){
			children();
		}
	}
}

// hand-calculated to yield integer widths of subunits
// based off a unitw of 238 and wallt of 5.
function dividerwidth(subs) =
	(subs == 1) ? 0 :
	(subs == 2) ? 4 :
	(subs == 3) ? 3 : 
	(subs == 4) ? 4 : 2;

drawerwallt = 3;
module drawer(h, d, w){
	drawerinnerw = w - drawerwallt * 2;
	drawerinnerd = d - drawerwallt * 2;
	drawerinnerh = h - drawerwallt;
	difference(){
		cube([w, d, h], true);
		translate([0, 0, drawerwallt]){
			cube([drawerinnerw, drawerinnerd, drawerinnerh], true);
		}
	}
}

// a handle for the drawers: a triangular prism
// (so it's easily printed sans supports), with
// fingerholes up top. they run up half the total
// height (centered), and across half the width
// (also centered).
module drawerhandle(h, d, w){
	translate([w / 4, (-d - h) / 2, -h / 4]){
		rotate([0, -90, 0]){
			difference(){
				linear_extrude(w / 2){
					polygon([
						[h / 2, 0],
						[0, h / 2],
						[h / 2, h / 2]
					]);
				}
				translate([0, 0, w / 20]){
					linear_extrude(2 * w / 5){
						polygon([
							[h / 2, h / 6],
							[h / 2, h / 2],
							[h / 5, h / 2]
						]);
					}
				}
			}
		}
	}
}

// if blockp is set, just draw the hull of the
// drawer (used to shape the containing unit).
// otherwise, draw the drawer itself, scaling it
// down slightly so it fits into the unit.
module drawers(h, subs, blockp){
	divt = dividerwidth(subs);
	subw = (unitinnerw - divt * (subs - 1)) / subs;
	for(i = [1 : 1 : subs]){
		xconsumed = (i - 1) * (divt + subw);
		translate([(subw -unitinnerw) / 2 + xconsumed, -backd / 2, 2]){
			if(blockp){
				hull(){
					drawer(h, unitinnerd, subw);
				}
			}else{
				scale(0.99){
					drawer(h, unitinnerd, subw);
				}
				drawerhandle(h, unitinnerd, subw);
			}
		}
	}
}

// a base unit, with holes for frictionfitting other
// units but *not* including plugs.
module unit(h, subs){
	difference(){
		cube([unitw, unitd, h], true);
		drawers(h - bottomt, subs, true);
		allquads(){
			sideholeQ1();
		}
		bothsidesX(){
			topholeQ1(h);
		}
	}
}

module unitanddrawers(h, subs){
	unit(h, subs);
	translate([0, -(unitd + unitinnerd) / 2, -wallt]){
		drawers(h - wallt, subs, false);
	}
}

// a set of frictional plugs
module connectors(h){
	xskip = plugr * 2 + 1;
	translate([0, 100, -h / 2 + topplugt]){
		hole(topplugt * 2);
		translate([xskip, 0, 0]){
			hole(topplugt * 2);
			translate([xskip, 0, -(topplugt - plugt)]){
				hole(plugt * 2);
				translate([xskip, 0, 0]){
					hole(plugt * 2);
				}
			}
		}
	}
}

translate([0, 0, unithquantum / 2]){
	unitanddrawers(unithquantum, 2);
	connectors(unithquantum);
}