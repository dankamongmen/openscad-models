stubh = 10;
baseh = 3;

$fn=20;

current_color = "ALL";

module multicolor(color) {
	if (current_color != "ALL" && current_color != color) { 
		// ignore our children.
	} else {
		color(color)
		children();
	}        
}

// for each component, measure its total geometry, and the geometry
// of all standoff holes. by convention, use w/l for width and
// length of the part, and holegapw/holegapl for spacing of the
// holes (of radius r). r ought be (outergap - innergap) / 4.

module stub(r, height){
	cylinder(height, r, r);
	cylinder(height / 3, r + 0.5, r + 0.5);
}

module base(w, l, bh, s){
	difference(){
		cube([w, l, bh], true);
		translate([-w / 2 + 2, 0, bh / 2 - 1]){
			linear_extrude(1){
				text(s, size = 5, font="Prosto One");
			}
		}
	}
}

// electrocookie dev board: 5x30 + 5x30 + 2x30 + 2x30
//  88.82 x 52
// holes: 80.82/76.84 (3.98), 37.63/33.69 (3.94), r = 2
devboardl = 52;
devboardw = 88.82;
module ecookiedevboard(height, bh){
	r = 1;
	holegapl = 35.7;
	holegapw = 78.8;
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
	base(devboardw, devboardl, bh, "     devboard");
}

// 16 channel analog multiplexer: 16x1 + 8x1
//  17.83 x 40.47
// holes: 38.66/32.4 (3.44)
muxl = 17.83;
module mux16(height, bh){
	r = 3.44 / 2;
	w = 40.47;
	holegapw = 35.53;
	offsetw = 0.83;
	translate([0, -muxl / 2 + r + offsetw, 0]){
		translate([-holegapw / 2, 0, 0]){
			stub(r, height);
		}
		translate([holegapw / 2, 0, 0]){
			stub(r, height);
		}
	}
	base(w, muxl, bh, "    mux");
}

// 3V relay: 3x1 + 3x1
//  70 x 17
// holes: 63, 10
module relay3v(height, bh){
  r = 1.3;
	w = 70;
	l = 17;
	holegapl = 10 + r;
	holegapw = 63 + r;
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
	base(w, l, bh, "relay3v");
}

// 5V relay: 3x1 + 3x1
//  50 x 26
// holes: 22.89/17.58 (3.15), 46.9/41.56
relay5vh = 22.5;
module relay5v(height, bh){
	r = 3.15 / 2;
	w = 50;
	l = 26;
	holegapw = 42.8 + r;
	holegapl = 19.6 + r;
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
	base(w, l, bh, "relay5v");
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
	holegapw = 29 + r * 2;
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

// tobsun 12V->5V 15A buck converter
//  63.64x53
// holes: 59.9/54.3 (3.32)
// FIXME there are two more holes at the bottom; use them!
tobsunl = 53;
tobsunh = 28; // includes spokes+gap, ought parameterize FIXE
module tobsun5V(height, bh){
	w = 63.64;
	r = 3.32 / 2;
	holegapw = 54.3 + r;
	translate([-holegapw / 2, 7.5, 0]){
		stub(r, height);
	}
	translate([holegapw / 2, 7.5, 0]){
		stub(r, height);
	}
	base(w, tobsunl, bh, "   12V->5V 15A");
}

translate([0, tobsunl / 2, muxl + tobsunh + devboardw / 2]){
	rotate([0, 90, 0]){
		rotate([90, 0, 0]){
			ecookiedevboard(stubh, baseh);
		}
	}
}
multicolor("red"){
	translate([0, tobsunl / 2, muxl / 2 + tobsunh]){
		rotate([90, 0, 0]){
			mux16(stubh, baseh);
		}
	}
}
multicolor("blue"){
	translate([-45, 0, 0]){
		rotate([0, 0, 90]){
			relay5v(stubh, baseh);
		}
	}
}
translate([-50, 0, relay5vh + 12]){
	multicolor("green"){
		ceramheat(stubh, baseh);
	}
}

translate([-75, 0, 15.5]){
	rotate([0, 0, 90]){
		rotate([90, 0, 0]){
			multicolor("pink"){
				therm(stubh, baseh);
			}
		}
	}
}
multicolor("black"){
	translate([0, 0, 0]){
		tobsun5V(stubh, baseh);
	}
}

translate([-70, -50, 0]){
	multicolor("white"){
		relay3v(stubh, baseh);
	}
}