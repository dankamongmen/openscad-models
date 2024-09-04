// chamber for a high-temperature (140C) filament dryer
// intended to be printed in polycarbonate
// the top is lifted up and out to insert a spool
// the spool sits on corner chords
include <electronics.scad>

// we need to hold a spool up to 205mm in diameter and 75mm wide
spoold = 205;
spoolw = 75;

// our chords in the four corners
chordz = 2; // thickness; don't want much
chordelevation = 10;

totalx = spoold + 10;
totaly = spoold + 10;
totalz = spoolw + chordz;

// we'll want some room around the spool, but the larger our
// chamber, the more heat we lose.

// our ceramic heating element is 77x62mm
heaterl = 77;
heaterw = 62;
heaterh = 6.5;

difference(){
	cube([totalx, totaly, totalz]);
	translate([(totalx - spoold) / 2, (totaly - spoold) / 2, totalz - spoolw]){
		cube([spoold, spoold, spoolw]);
	}
}

// pegs for the ceramic heating element
translate([totalx / 2, totaly / 2, 0]){
	ceramheat230(5, 5);
}

// chords to support the spool


/*
module spool(){
	cylinder(spoolw, spoold / 2, spoold / 2);
}

translate([totalx / 2, totaly / 2, totalz - spoolw]){
	spool();
}*/