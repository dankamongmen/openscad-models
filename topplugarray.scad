// hard-won measurements

usbw = 53.5; // usb hub
usbwall = 5;
gap = 78 + 11; // 78mm apart + 11 for shrinking
holey = 2.577; // measured at 2.977
gapy = 2.118; // measured at 1.718
holer = holey / 2; // radius of circles
holexshort = 4.8 - (2 * holer);
holexlong = 12.08 - (2 * holer);
plugh = 8; // height of plugs into case

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

module copymirror(vec){
    children();
    mirror(vec) children();
}

copymirror([1, 0, 0]){
	linear_extrude(plugh){
		for(i = [0 : 5]){
			translate([-holer - (gap / 2), (holey + gapy) * 2 * i, 0]){
				pair();
			}
		}
	}
	translate([-(holexlong / 2) - holer - (gap / 2), -holey, plugh]){
		cube([holexlong / 2 * holer + (gap / 2), (holey + gapy) * 12, 5]);
	}
	translate([-(usbw / 2) - usbwall, -holey, plugh + 5]){
		cube([usbwall, 12 * (holey + gapy), 15]);
	}
}