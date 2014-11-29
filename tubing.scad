// l = length
// od = outer diameter
// w = wall thickness
module tube(l, od, w) {
	radius = od / 2;
	inner_offset = w;
	inner_radius = radius - inner_offset;

	difference() { 
		cylinder(r=radius, h=l); 
		translate([0, 0, -1])
			cylinder(r=inner_radius, h=l+2); 
	}
}

// Angle (a) must be less than 270
module tube_bend(a, r, od, w) {
	tube_radius = od / 2;
	tube_inner_radius = tube_radius - w;

	cube_height = od + 2;
	cube_z_offset = cube_height / 2 * -1;
	cube_width = r + od + 1;
	segment = (270 - a) / 4;
	
	difference() {
		rotate_extrude()
			translate([r, 0, 0])
				circle(r=tube_radius);
		rotate_extrude()
			translate([r, 0, 0])
				circle(r=tube_inner_radius);
		for ( i = [0 : -4] ) {
			rotate([0, 0, segment * i])
				translate([0, 0, cube_z_offset])
					cube([cube_width, cube_width, cube_height]);
		}
	}
}

// PI * radius * angle / 180