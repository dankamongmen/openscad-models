stubh = 15;
baseh = 3;

$fn=20;

// for each component, measure its total geometry, and the geometry
// of all standoff holes. by convention, use w/l for width and
// length of the part, and holegapw/holegapl for spacing of the
// holes (of radius r). r ought be (outergap - innergap) / 4.

module stub(r, height){
	cylinder(height, r, r);
	cylinder(2 * height / 3, r + 0.5, r + 0.5);
}

module base(w, l, bh, s){
	difference(){
		cube([w, l, bh], true);
		translate([-w / 2 + 2, 0, bh / 2 - 1]){
			linear_extrude(1){
				text(s, size = 5);
			}
		}
	}
}

// electrocookie dev board: 5x30 + 5x30 + 2x30 + 2x30
//  88.82 x 52
// holes: 80.82/76.84 (3.98), 37.63/33.69 (3.94), r = 2
module ecookiedevboard(height, bh){
	r = 1.14;
	w = 52;
	l = 88.82;
	holegapw = 35.7;
	holegapl = 78.8;
	translate([-holegapw / 2, -holegapl / 2, 0]){
		stub(r, height);
		translate([holegapw, 0, 0]){
			stub(r, height);
			translate([0, holegapl, 0]){
				stub(r, height);
			}
		}
		translate([0, holegapl, 0]){
			stub(r, height);
		}
	}
	base(w, l, bh, "devboard");
}

// 16 channel analog multiplexer: 16x1 + 8x1
//  17.83 x 40.47
// holes: 38.66/32.4 (3.44)
module mux16(height, bh){
	r = 3.44 / 2;
	w = 17.83;
	l = 40.47;
	holegapl = 35.53;
	offsetw = 0.83;
	translate([-w / 2 + r + offsetw, -holegapl / 2, 0]){
		stub(r, height);
		translate([0, holegapl, 0]){
			stub(r, height);
		}
	}
	base(w, l, bh, "mux");
}

// 5V relay: 3x1 + 3x1
//  50 x 26
// holes: 22.89/17.58 (3.15), 46.9/41.56
module relay5v(height, bh){
	r = 3.15 / 2;
	w = 50;
	l = 26;
	holegapw = 41 + r;
	holegapl = 17 + r;
	translate([-holegapw / 2, -holegapl / 2, 0]){
		stub(r, height);
		translate([holegapw, 0, 0]){
			stub(r, height);
			translate([0, holegapl, 0]){
				stub(r, height);
			}
		}
		translate([0, holegapl, 0]){
			stub(r, height);
		}
	}
	base(w, l, bh, "relay");
}

// ceramic heater
//  28x60
// holes: 35/28.5 (3.5)
module ceramheat(height, bh){
	r = 3.5 / 2;
	w = 60;
	l = 28;
	holegapw = 28.5 + r * 2;
	offsetl = 2.2;
	translate([-holegapw / 2, -l / 2 + r + offsetl, 0]){
		stub(r, height);
		translate([holegapw, 0, 0]){
			stub(r, height);
		}
	}
	base(w, l, bh, "heater");
}

// thermostat control. not rectangular, holes are ovals.
module therm(height, bh){
	w = 34;
	l = 18;
	r = 3.5 / 2;
	holegapw = 20 + r * 2;
	p = sqrt(holegapw * holegapw / 4);
	translate([-p / 2, -p / 2, 0]){
		stub(r, height);
	}
	translate([p / 2, p / 2, 0]){
		stub(r, height);
	}
	// make it square to accomodate rotating hookup
	base(w, w, bh, "60C");
}

// hiletgo buck converter with led display
//  56.42x35.33
// holes: 53/46.69, 31.6/25.2 (3.3)
module buck(height, bh){
	r = 3.3 / 2;
	w = 56.42;
	l = 35.33;
	holegapw = 46.69 + r;
	holegapl = 25.2 + r;
	translate([-holegapw / 2, -holegapl / 2, 0]){
		stub(r, height);
		translate([holegapw, 0, 0]){
			stub(r, height);
			translate([0, holegapl, 0]){
				stub(r, height);
			}
		}
		translate([0, holegapl, 0]){
			stub(r, height);
		}
	}
	base(w, l, bh, "12V->5V");
}

ecookiedevboard(stubh, baseh);
translate([50, 50, 0]){
	mux16(stubh, baseh);
}
translate([60, 0, 0]){
	relay5v(stubh, baseh);
}
translate([0, 60, 0]){
	ceramheat(stubh, baseh);
}
translate([60, -40, 0]){
	therm(stubh, baseh);
}
translate([90, 50, 0]){
	buck(stubh, baseh);
}