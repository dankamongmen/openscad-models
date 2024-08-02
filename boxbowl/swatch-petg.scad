// PETG swatch for filament box bowl

difference(){
	cube([20, 20, 2], true);
	linear_extrude(1){
		translate([0, -5, 0])
			text("polyethylene", size=1.5, halign="center",
		       font="Liberation Sans:style=Bold Italic");
		translate([0, -7.5, 0])
			text("terephthalate glycol", size=1.5, halign="center",
		       font="Liberation Sans:style=Bold Italic");
		translate([0, 6, 0]){
			scale(0.015){
				import("Polyethyleneterephthalate.svg", center=true);
			}
		}
	}
}

linear_extrude(2){
	text("PETG", font="ProstoOne", size=5, valign="center", halign="center", $fn=10);
}
