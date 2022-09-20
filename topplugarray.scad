// hard-won measurements

gap = 79; // 79mm apart
holey = 2.977;
gapy = 1.718;
holer = holey / 2; // radius of circles
holexshort = 4.8 - (2 * holer);
holexlong = 12.08 - (2 * holer);

module smallplug(){
  translate([-holexshort / 2, -holey / 2, 0]){
		circle(holer, $fn=50);
	}
	translate([-(holexshort / 2), -holey, 0]){
		square([holexshort, holey]);
	}
	translate([holexshort / 2, -holey / 2, 0]){
		circle(holer, $fn=50);
	}
}

module plug(){
  translate([-holexlong / 2, -holey / 2, 0]){
		circle(holer, $fn=50);
	}
	translate([-(holexlong / 2), -holey, 0]){
		square([holexlong, holey]);
	}
	translate([holexlong / 2, -holey / 2, 0]){
		circle(holer, $fn=50);
	}
}


module pair(){
	translate([(holexlong - holexshort) / 2, gapy + holey, 0]){
	  smallplug();
	}
	plug();
}

linear_extrude(10){
	for(i = [0 : 5]){
		translate([0, (holey + gapy) * 2 * i, 0]){
			pair();
		}
	}
}

translate([-(holexlong / 2) - holer, -holey, 10]){
	cube([holexlong + 2 * holer, (holey + gapy) * 12, 5]);
}