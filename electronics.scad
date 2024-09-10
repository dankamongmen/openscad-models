include <BOSL2/std.scad>
include <BOSL2/screws.scad>

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
module stub(stype, height, bh){
	translate([0, 0, bh / 2])
		screw(stype, length=height, head="flat", anchor=TOP, orient=DOWN);
}

// for the common pattern of four stubs forming a quadrilateral
module fourstubs(holegapw, holegapl, r, height, bh){
	translate([-holegapw / 2, -holegapl / 2, 0]){
		stub(r, height, bh);
		translate([holegapw, 0, 0]){
			stub(r, height, bh);
			translate([0, holegapl, 0]){
				stub(r, height, bh);
			}
		}
		translate([0, holegapl, 0]){
			stub(r, height, bh);
		}
	}
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
	fourstubs(holegapw, holegapl, "M2", height, bh);
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
			stub("M1.6", height, bh);
		}
		translate([holegapw / 2, 0, 0]){
			stub("M1.6", height, bh);
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
	fourstubs(holegapw, holegapl, "M2.5", height, bh);
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
	fourstubs(holegapw, holegapl, "M3", height, bh);
	base(w, l, bh, "relay5v");
}

rectifier2aw = 45.55;
rectifier2al = 86.7;
rectifier2ah = 24.4;
module rectifier2a(height, bh){
	r = 3.3 / 2;
	holegapw = 35;
	holegapl = 73.3;
	fourstubs(holegapw, holegapl, "M3.5", height, bh);
	base(rectifier2aw, rectifier2al, bh, "rectifier2a");
}

// ceramic heater 100C
//  28x60
// holes: 35/28.5 (3.5)
ceramheat100w = 60;
ceramheat100l = 28;
ceramheat100h = 7.22;
module ceramheat100(height, bh){
	r = 3.5 / 2;
	holegapw = 28.5 + r * 2;
	offsetl = 2.2;
	translate([-holegapw / 2, -ceramheat100l / 2 + r + offsetl, 0]){
		stub("M3", height, bh);
		translate([holegapw, 0, 0]){
			stub("M3", height, bh);
		}
	}
	base(ceramheat100w, ceramheat100l, bh, "heater100");
}

// ceramic heater 230C
//  77x62
// holes: 28.3/48.6 3.5
ceramheat230w = 77;
ceramheat230l = 62;
module ceramheat230(height, bh){
	r = 3.5 / 2;
	holegapw = 28.5 + r * 2;
	holegapl = 48.6 + r * 2;
	fourstubs(holegapw, holegapl, "M3", height, bh);
	base(ceramheat230w, ceramheat230l, bh, "heater230");
}

// thermostat control. not rectangular, holes are ovals.
thermw = 34;
module therm(height, bh){
	r = 3.5 / 2;
	holegapw = 29 + r * 2;
	p = sqrt(holegapw * holegapw / 4);
	translate([-p / 2, -p / 2, 0]){
		stub("M3", height, bh);
	}
	translate([p / 2, p / 2, 0]){
		stub("M3", height, bh);
	}
	// make it square to accomodate rotating hookup
	base(thermw, thermw, bh, "60C");
}

// hiletgo buck converter with led display
//  56.42x35.33
// holes: 53/46.69, 31.6/25.2 (3.3)
module bucklm2596(height, bh){
	r = 3.3 / 2;
	w = 56.42;
	l = 36;
	holegapw = 46.69 + r;
	holegapl = 25.2 + r;
	fourstubs(holegapw, holegapl, "M3", height, bh);
	base(w, l, bh, "12V->5V");
}

// xhm401 buck converter with led display
module buckxhm401(height, bh){
	r = 3.3 / 2;
	w = 38.2;
	l = 66;
	holegapw = 34 - r;
	holegapl = 64 - r;
	fourstubs(holegapw, holegapl, "M3", height, bh);
	base(w, l, bh, "12V->5V");
}

// tobsun 12V->5V 15A buck converter
//  63.64x53
// holes: 59.9/54.3 (3.32)
// FIXME there are two more holes at the bottom; use them!
tobsunl = 53;
tobsunh = 28; // includes spokes+gap, ought parameterize FIXE
module tobsun5v(height, bh){
	w = 63.64;
	r = 3.32 / 2;
	holegapw = 54.3 + r;
	translate([-holegapw / 2, 7.5, 0]){
		stub("M3", height, bh);
	}
	translate([holegapw / 2, 7.5, 0]){
		stub("M3", height, bh);
	}
	base(w, tobsunl, bh, "   12V->5V 15A");
}

/*
stubh = 8;
baseh = 3;
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
		ceramheat100(stubh, baseh);
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
		tobsun5v(stubh, baseh);
	}
}

translate([-70, -50, 0]){
	multicolor("white"){
		relay3v(stubh, baseh);
	}
}

translate([10, -60, 0]){
	multicolor("orange"){
		ceramheat230(stubh, baseh);
	}
}

translate([80, -30, 0]){
	multicolor("orange"){
		rectifier2a(stubh, baseh);
	}
}
*/