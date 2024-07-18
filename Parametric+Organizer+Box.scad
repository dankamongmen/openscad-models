include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/shapes3d.scad>
include <BOSL2/shapes2d.scad>;


/* [Style and Performance (influences render performance)] */
Generate_Style = "Rounded"; // [Simple: Simple-Faster, Rounded: Rounded-Slower]
Generate_With_Cutouts = "Hex"; // [None: None-Faster, Hex: Hexagons-Slower ]
Generate_a_Lid = true;
Tray_Cutouts_Size = 10.0; // 0.1
Tray_Cutouts_Distance = 2.0; // 0.1
Tray_Connector_Type = "HSW-Plug"; // [HSW-Plug: HSW Plug Into Insert Hole - 13.2mm, IKEA-Skadis:  IKEA Skadis Pegboard System - 4.7mm, MB-PushFit: Multiboard Push-Fit - 13.5mm-13.22mm, None: No Connector - Standard Tray ]

/* [Tray Dimensions] */
Tray_Inner_Height = 40.0; //0.1
Tray_Back_Extension_Height = 40; // 0.5
Tray_Back_Thickness = 4.0; //0.1
Tray_Sides_Thickness = 3.0; // 0.1
Tray_Separators_Thickness = 1.5; // 0.1
Tray_Bottom_Thickness = 2.0; // 0.1
Tray_Corners_Radius = 5.0; // 0.1

/* [Tray Lid] */
Lid_Thickness = 3; // 0.1
Lid_Lip_Height = 3; // 0.1
Lid_Lip_Thickness = 1.5; // 0.1
Lid_Lip_Clearance = 0.15; // 0.05
Lid_Front_Notch_Width = 10.0; // 0.1
Lid_Front_Notch_Height = 1.0; // 0.1

/* [Compartments] */ // OpensCad customizer is limited to 4, but Makerworld is unlimited
Compartments_Columns_Widths = [40,40,40,0,0,0,0,0,0,0]; // 0.1
Compartments_Rows_Depths = [40,40,0,0,0,0,0,0,0,0]; // 0.1

/* [Honeycomb Storage Wall] */
// Value reduced from connector total spec size, use negative to increse
HSW_Connector_Tolerance = 0.00; // 0.05

/* [IKEA Skadis Board] */
// Value reduced from connector diameter (most importantly affects width)
SKADIS_Connector_Diameter_Tolerance = 0.00; // 0.05
// Value added to the slot for the board
SKADIS_Connector_Depth_Tolerance = 0.00; // 0.05

/* [Multiboard] */;
MB_Connector_Tolerance = 0.0; // 0.05

/* [Hidden] */

// Calculate total depth/width and separators locations from compartments
function add(v) = [for(p=v) 1]*v;
function subset(v, l) = [for (p=[0:l-1]) v[p]];

Compartments_Columns_Widths_NoZero = [for (i = Compartments_Columns_Widths) if (i!=0) i];
Compartments_Rows_Depths_NoZero = [for (i = Compartments_Rows_Depths) if (i!=0) i];

n_comp_w = len(Compartments_Columns_Widths_NoZero);
n_comp_d = len(Compartments_Rows_Depths_NoZero);

Tray_Depth_Separators = n_comp_d <= 1 ? [] : [for (i=[1:n_comp_d-1]) add(subset(Compartments_Rows_Depths_NoZero, i))+(i-1)*Tray_Separators_Thickness+Tray_Separators_Thickness/2];
Tray_Width_Separators = n_comp_w <= 1 ? [] : [for (i=[1:n_comp_w-1]) add(subset(Compartments_Columns_Widths_NoZero, i))+(i-1)*Tray_Separators_Thickness+Tray_Separators_Thickness/2];
Tray_Inner_Width = add(Compartments_Columns_Widths)+(len([for (x=Tray_Width_Separators) if (x != 0) x]))*Tray_Separators_Thickness; // [0:1000]
Tray_Inner_Depth = add(Compartments_Rows_Depths)+(len([for (x=Tray_Depth_Separators) if (x != 0) x]))*Tray_Separators_Thickness; // [0:1000]

Tray_Width_Separators_NoZero = [for (i = Tray_Width_Separators) if (i!=0 && i<=Tray_Inner_Width) i];
Tray_Depth_Separators_NoZero = [for (i = Tray_Depth_Separators) if (i!=0 && i <= Tray_Inner_Depth) i];

Tray_Outer_Depth = Tray_Inner_Depth+Tray_Back_Thickness+Tray_Sides_Thickness;
Tray_Outer_Width = Tray_Inner_Width+2*Tray_Sides_Thickness;
Tray_Outer_Height = Tray_Inner_Height+Tray_Bottom_Thickness;
Tray_Outer_Height_Ext = Tray_Outer_Height + Tray_Back_Extension_Height;

module cutouts_to_remove() {
  if (Generate_With_Cutouts == "Hex") {
    up(Tray_Outer_Height/2+(max(Tray_Corners_Radius, Tray_Bottom_Thickness)-Tray_Corners_Radius)/2) {
       {
        h_dist = (Tray_Cutouts_Size/2*cos(30)*2+Tray_Cutouts_Distance)*cos(30)*2;
        v_dist = (Tray_Cutouts_Size/2*cos(30)*2+Tray_Cutouts_Distance)*sin(30)*2;

        z_num = ceil(Tray_Outer_Depth/(v_dist/2)/4);
        x_num = ceil(Tray_Outer_Height/(h_dist)/2)+2;
        y_num = ceil(Tray_Outer_Width/(h_dist)/2);

        fwd(Tray_Outer_Depth+0.01) intersection() {
          dd = 0.02;
          union() {
            cube([Tray_Outer_Width - Tray_Corners_Radius*2, Tray_Sides_Thickness+dd, Tray_Outer_Height-Tray_Corners_Radius-max(Tray_Corners_Radius, Tray_Bottom_Thickness)], anchor=FWD);
            // Horizontal Separators
            for (y=Tray_Depth_Separators_NoZero) 
            {
              // Horizontal separator cube
              fwd(Tray_Separators_Thickness/2-Tray_Sides_Thickness) back(y)
                cube([Tray_Outer_Width - Tray_Corners_Radius*2, Tray_Separators_Thickness+dd, Tray_Outer_Height-Tray_Corners_Radius-max(Tray_Corners_Radius, Tray_Bottom_Thickness)], anchor=FWD);
            }
          }
          for (z = [-z_num:z_num]) {
            for (y = [-y_num:y_num]) {
                // Horizontal separator cutouts
                back(Tray_Outer_Depth/2) up(z*v_dist/2) left(h_dist*y + (z%2==0 ? 0:h_dist/2)) zrot(90) xrot(30) yrot(90) cylinder(r=Tray_Cutouts_Size/2, h=Tray_Outer_Depth+2*dd, center=true, $fn=6); 
            }
          }
        }

        cutout_depth = Tray_Outer_Depth-Tray_Corners_Radius-max(Tray_Corners_Radius, Tray_Back_Thickness);
        fwd_from_initial = Tray_Back_Thickness > Tray_Corners_Radius ? 
                              Tray_Back_Thickness+cutout_depth/2 :
                              Tray_Back_Thickness+Tray_Inner_Depth/2;
                                                                     
        fwd(fwd_from_initial) intersection() {
          dd = 0.02;
          union() {
            left(Tray_Outer_Width/2+0.01)  cube([Tray_Sides_Thickness+dd, cutout_depth, Tray_Outer_Height-Tray_Corners_Radius-max(Tray_Corners_Radius, Tray_Bottom_Thickness)], anchor=LEFT);
            // Vertical separators cubes
            for (x=Tray_Width_Separators_NoZero)
            {
              // Vertical separator cubes
              left((Tray_Inner_Width+Tray_Sides_Thickness)/2-Tray_Sides_Thickness/2) right(x) 
                cube([Tray_Separators_Thickness+2*dd, cutout_depth, Tray_Outer_Height-Tray_Corners_Radius-max(Tray_Corners_Radius, Tray_Bottom_Thickness)], anchor=CENTER);
            }
            right(Tray_Outer_Width/2+0.01) cube([Tray_Sides_Thickness+dd, cutout_depth, Tray_Outer_Height-Tray_Corners_Radius-max(Tray_Corners_Radius, Tray_Bottom_Thickness)], anchor=RIGHT);
          }
          for (z = [-z_num:z_num]) {
            for (x = [-x_num:x_num]) {
                // Vertical separators cutouts
                up(z*v_dist/2) fwd(h_dist*x + (z%2==0 ? 0:h_dist/2)) xrot(30) yrot(90) cylinder(r=Tray_Cutouts_Size/2, h=Tray_Outer_Width+2*dd, center=true, $fn=6); //rounded_prism(hexagon(7), height=Tray_Inner_Width+0.01, joint_sides=0.6);
            }
          }
        }

      }
    }
  }
}


zero_depth_d = Tray_Back_Thickness==0 && Tray_Sides_Thickness ==0 ? 0.01 : 0;
zero_sides_d = Tray_Sides_Thickness ==0 ? 0.01 : 0;

module back_extension() {
    if (Tray_Back_Thickness != 0 && Tray_Back_Extension_Height > 0) {
      up(Tray_Outer_Height/2) up((Tray_Outer_Height+Tray_Back_Extension_Height)/2)
        if (Generate_Style == "Rounded") {
          // assumption here is that corner_radius is larger than the top rouding of 2, if less not sure the eventual rounding will be that of an issue
          fwd ((Tray_Corners_Radius*2+1)/2) down(1) {
            difference() {
              rounded_prism(rect([Tray_Outer_Width-zero_sides_d, Tray_Corners_Radius*2+1]), height=Tray_Back_Extension_Height+2, joint_top=2, joint_bot=0, joint_sides=Tray_Corners_Radius);
              fwd(max(Tray_Back_Thickness-2, 0.01/2)) cube([Tray_Outer_Width-zero_sides_d+0.01, Tray_Corners_Radius*2+1, Tray_Back_Extension_Height+2+0.01], true);
            }

            intersection() {
              rounded_prism(rect([Tray_Outer_Width-zero_sides_d, Tray_Corners_Radius*2+1]), height=Tray_Back_Extension_Height+2, joint_top=2, joint_bot=0, joint_sides=Tray_Corners_Radius);
              back(2+(Tray_Corners_Radius*2+1)/2-(Tray_Back_Thickness-2))
              difference() {
                rounded_prism(rect([Tray_Outer_Width-zero_sides_d, 8]), height=Tray_Back_Extension_Height+2, joint_top=2, joint_bot=0, joint_sides=2);
                back(2) cube([Tray_Outer_Width+0.01, 8, Tray_Back_Extension_Height+2+0.01], true);
              }
            }
          }
        } else if (Generate_Style == "Simple") {
          fwd((Tray_Back_Thickness)/2) cube([Tray_Outer_Width-zero_sides_d, Tray_Back_Thickness, Tray_Back_Extension_Height], true);
        }
    }
}

external_rounding = max(1, min(Tray_Back_Thickness, Tray_Sides_Thickness))/2;

module tray() {
  joint_top_size = Generate_a_Lid ? 0 : 2;
  difference() {
    fwd(Tray_Outer_Depth/2) up(Tray_Outer_Height/2) difference() {
        if (Generate_Style == "Rounded") {
          rounded_prism(rect([Tray_Outer_Width-zero_sides_d, Tray_Outer_Depth-zero_depth_d]), height=Tray_Outer_Height, joint_top=joint_top_size, joint_bot=2,joint_sides=Tray_Corners_Radius); // joint_bot and joint_sides must be different ...
        } else if (Generate_Style == "Simple") {
          cube([Tray_Outer_Width-zero_sides_d, Tray_Outer_Depth-zero_depth_d, Tray_Outer_Height], true);
        }
        x_separators = concat([0], Tray_Width_Separators_NoZero, Tray_Outer_Width-Tray_Sides_Thickness);
        y_separators = concat([0], Tray_Depth_Separators_NoZero, Tray_Inner_Depth+Tray_Sides_Thickness);
        for (i_x = [0:len(x_separators)-2]) {
          for (i_y = [0:len(y_separators)-2]) {
            x_left = x_separators[i_x] + (i_x>0 ? Tray_Separators_Thickness/2 : 0);
            x_right = x_separators[i_x+1] + (i_x<len(x_separators)-2 ? Tray_Separators_Thickness/2 : 0);

            y_near = y_separators[i_y] + (i_y>0 ? Tray_Separators_Thickness/2 : 0);
            y_far = y_separators[i_y+1]  + (i_y<len(y_separators)-2 ? Tray_Separators_Thickness/2 : 0);

            int_width = x_right - x_left - (i_x <len(x_separators)-2 ? Tray_Separators_Thickness : Tray_Sides_Thickness);
            int_depth = y_far - y_near - (i_y<len(y_separators)-2 ? Tray_Separators_Thickness : Tray_Sides_Thickness);

            is_top = (i_y == len(y_separators)-2);
            is_bottom = (i_y == 0);
            is_left = (i_x == 0);
            is_right = (i_x == len(x_separators)-2);
            large_joint = max(min(Tray_Corners_Radius-Tray_Sides_Thickness, int_width/2, int_depth/2),1);
            small_joint_check = max(min(Tray_Separators_Thickness/2, int_width/2, int_depth/2), 1);
            small_joint = 1; //min(large_joint, small_joint_check);
            side_joints = [is_bottom && is_right ? large_joint : small_joint, 
                           is_bottom && is_left ? large_joint : small_joint, 
                           is_top && is_left ? large_joint : small_joint,
                           is_top && is_right ? large_joint : small_joint ];
            sides_thickness_for_rounding = Tray_Sides_Thickness > 0 ? Tray_Sides_Thickness : Tray_Separators_Thickness;
            top_rounding = (is_top && is_bottom && is_left && is_right) ? sides_thickness_for_rounding/2 :  min(Tray_Separators_Thickness, sides_thickness_for_rounding)/2;
            bottom_rounding = (Tray_Sides_Thickness == 0 || Tray_Back_Thickness ==0 ? 
                                Tray_Separators_Thickness/2 : 
                                (Tray_Bottom_Thickness == 0 ? -1 : 1)*min(sides_thickness_for_rounding, Tray_Separators_Thickness));

            left(Tray_Inner_Width/2+Tray_Sides_Thickness/2)
            fwd(Tray_Outer_Depth/2-Tray_Sides_Thickness/2)
            right(x_left+Tray_Sides_Thickness/2 + int_width/2) 
            back(y_near + Tray_Sides_Thickness/2 + int_depth/2)
            up(Tray_Bottom_Thickness/2) 
              if (Generate_Style == "Rounded") {
                rounded_prism(rect([int_width, int_depth]), height=Tray_Inner_Height+0.01, joint_top = -top_rounding, joint_bot=bottom_rounding ,joint_sides=side_joints); // joint_bot and joint_sides must be different ...
              } else {
                cube([int_width, int_depth, Tray_Inner_Height+0.01], true);
              }
          }
        }
    }
    cutouts_to_remove();
  }
}

// Code related to attaching HWS  connectors

HSW_Plug_Depth = 10;
HSW_Plug_Side_To_Side = 13.2;
HSW_V_DIST = 11.8;
HSW_H_DIST = 40.88;

SKADIS_Connector_Diameter = 4.7;
SKADIS_Connector_Height = 12;
SKADIS_Connector_Depth = 10;
SKADIS_V_DIST = 20;
SKADIS_H_DIST = 40;

MB_SIZE_1 = 13.5;
MB_SIZE_2 = 13.22;
MB_SIZE_3 = 13.22-1.02;
MB_DEPTH_1 =1;
MB_DEPTH_2 = 6.9;
MB_DEPTH_3 = 0.5;
MB_H_DIST = 25;
MB_V_DIST = 25;

module any_connectors(connector_h_dist, connector_v_dist, connector_width, connector_height, tolerances, connector_subtype=1, align_top=false, shifted_rows=true) {
  module hsw_connector() {
      //translate([0,0,HSW_Plug_Depth/2-Tray_Back_Thickness/4]) 
      back(HSW_Plug_Depth/2 - Tray_Back_Thickness/4)
      up((HSW_Plug_Side_To_Side- HSW_Connector_Tolerance)/2) 
        xrot(-90) rounded_prism(hexagon(d=(HSW_Plug_Side_To_Side - HSW_Connector_Tolerance)/cos(30)), height=HSW_Plug_Depth+Tray_Back_Thickness/2, joint_sides=0.1, joint_top=1 );
      //cylinder(d=(plug_diameter-reduce_tolerance)/cos(30), h = plug_depth, $fn=6);
  }

  module multiboard_connector() {
    up(MB_SIZE_1/2) 
    back((MB_DEPTH_1+Tray_Back_Thickness/2)/2-Tray_Back_Thickness/2) xrot(90) zrot(360/16) 
    rounded_prism(octagon(d=(MB_SIZE_1-MB_Connector_Tolerance)/cos(360/16)), h=MB_DEPTH_1+Tray_Back_Thickness/2);

    up(MB_SIZE_1/2) 
    back(MB_DEPTH_2/2+1) xrot(90) zrot(360/16) 
    rounded_prism(octagon(d=(MB_SIZE_2-MB_Connector_Tolerance)/cos(360/16)), octagon(d=(MB_SIZE_1-MB_Connector_Tolerance)/cos(360/16)), h=MB_DEPTH_2);

    up(MB_SIZE_1/2) 
    back(0.5/2+MB_DEPTH_2+1) xrot(90) zrot(360/16) 
    rounded_prism(octagon(d=(MB_SIZE_3-MB_Connector_Tolerance)/cos(360/16)), octagon(d=(MB_SIZE_2-MB_Connector_Tolerance)/cos(360/16)), h=MB_DEPTH_3);
  }

  module ikea_skadis_connector() {
    plug_height = SKADIS_Connector_Height;
    plug_depth = SKADIS_Connector_Depth;
    plug_diameter = SKADIS_Connector_Diameter- SKADIS_Connector_Diameter_Tolerance;

    external_rounding = Tray_Back_Thickness/2;
    up (SKADIS_Connector_Height/2) {
        hull() {
          up ((plug_height- SKADIS_Connector_Diameter)/2) back( (plug_depth-plug_diameter/2) / 2) {
            for (downs = [-SKADIS_Connector_Diameter_Tolerance/2, 2]) {
              fwd(Tray_Back_Thickness/4) down (downs) xrot(90) cylinder(h = plug_depth-plug_diameter/2+Tray_Back_Thickness/2, d = plug_diameter, center = true, $fn=32);
            }
          }
        }
        back (plug_depth-plug_diameter/2) up((plug_height-plug_diameter)/2) sphere(d = plug_diameter, $fn = 32);
        down (plug_diameter/4) back(plug_depth-plug_diameter/2) {
            difference() {
                 cylinder(h = plug_height-plug_diameter/2, d = plug_diameter, center = true, $fn=32);
                 fwd(plug_diameter/2) cube([plug_diameter, plug_diameter, plug_height-plug_diameter/2+0.01], center=true);
            }
            fwd(plug_diameter/4+(5-plug_diameter)/2-SKADIS_Connector_Depth_Tolerance/2) cube([plug_diameter, plug_depth-plug_diameter/2-5-SKADIS_Connector_Depth_Tolerance, plug_height-plug_diameter/2], true);
        }
      }
  }

  function get_layout(N, V) = let (
    S=3,
    D = (N-1)/S,
    L = [0, round(D*1), round(2*D), N-1]
  )[for (i=[0:N-1]) len(search(i, L)) >0 ? V : 0 ];

  module place_connector(connectors_layout, x, y) {
    shift = shifted_rows ? (y%2 != 0) ? connector_h_dist/2 : 0 : 0;
    translate([x*connector_h_dist+shift, 0, y*connector_v_dist]) 
      if (Tray_Connector_Type == "HSW-Plug") {
        hsw_connector();
      } else if (Tray_Connector_Type == "IKEA-Skadis") {
        ikea_skadis_connector();
      } else if (Tray_Connector_Type == "MB-PushFit") {
        multiboard_connector();
      } 
       
  }

  module place_connectors(connectors_layout)
  {
      for (y_pos = [0:len(connectors_layout) - 1])
      {
          for (x_pos = [0:len(connectors_layout[y_pos]) - 1])
          {
              if (connectors_layout[y_pos][x_pos] != 0)
              {
                  place_connector(connectors_layout, x_pos, y_pos);
              }
          }
      }
  }

  function max_odd_in(N) = floor((N-1)/2)*2+1;

  possible_h_connectors = max(0, floor((Tray_Outer_Width-2*Tray_Corners_Radius-connector_width)/connector_h_dist))+1;
  possible_v_connectors_norm = floor((Tray_Outer_Height_Ext - connector_height)/connector_v_dist)+1;
  possible_v_connectors = shifted_rows ? max(1, possible_h_connectors <= 1  ? max(1,max_odd_in(possible_v_connectors_norm)):possible_v_connectors_norm) : possible_v_connectors_norm;

  possible_v_connectors_no_ext_norm = floor((Tray_Outer_Height - connector_height)/connector_v_dist)+1;
  possible_v_connectors_no_ext = shifted_rows ? max(1, possible_h_connectors <= 1  ? max(1,max_odd_in(possible_v_connectors_no_ext_norm)):possible_v_connectors_no_ext_norm) : possible_v_connectors_no_ext_norm;

  mid_row_init = (possible_v_connectors - possible_v_connectors_no_ext >= 2) && !(possible_h_connectors == 1 && shifted_rows)? possible_v_connectors_no_ext : -1;

  margin_y = align_top ? Tray_Outer_Height_Ext - (possible_v_connectors-1)*connector_v_dist-connector_height : 0;

  mid_row = (abs((margin_y +connector_height/2+(mid_row_init-1)*connector_v_dist) - Tray_Outer_Height) < abs((margin_y+connector_height/2+(mid_row_init)*connector_v_dist) - Tray_Outer_Height) ? mid_row_init : mid_row_init+1);

  connectors_layout_top = get_layout(possible_h_connectors, 1);

  v_even_mid = shifted_rows ? ((possible_v_connectors-mid_row-1) % 2 == 0) ? true : false : false;
  connectors_layout_mid_net = shifted_rows? v_even_mid ? get_layout( max(1, possible_h_connectors-1), connector_subtype) : get_layout(possible_h_connectors, connector_subtype) : get_layout(possible_h_connectors, connector_subtype);
  connectors_layout_mid = v_even_mid ?  concat( [0], connectors_layout_mid_net) : connectors_layout_mid_net;

  v_even = shifted_rows ? (possible_v_connectors % 2 == 0) ? true : false : false;
  connectors_layout_bottom_net = shifted_rows? v_even ? get_layout(max(1, possible_h_connectors-1), connector_subtype) : get_layout(possible_h_connectors, connector_subtype) : get_layout(possible_h_connectors, connector_subtype);
  connectors_layout_bottom = v_even ?  concat( [0], connectors_layout_bottom_net) : connectors_layout_bottom_net;

  margin_net = (Tray_Outer_Width-2*Tray_Corners_Radius-connector_h_dist*(possible_h_connectors-1))/2;
  margin = shifted_rows ? v_even ? margin_net - connector_h_dist/2 : margin_net : margin_net;
 
  connectors_layout = (possible_v_connectors == 1 ) ? [connectors_layout_bottom] :  
              (possible_v_connectors == 2) ? [connectors_layout_bottom, connectors_layout_top] : 
              [connectors_layout_bottom, for (i = [1:max(possible_v_connectors-2, 1)]) (i == mid_row-1 ? connectors_layout_mid : [0]), connectors_layout_top ];

  difference() {
      up ( margin_y) left(Tray_Outer_Width/2 - Tray_Corners_Radius - margin) place_connectors(connectors_layout);
      // 50 is just an arbitrary number larger than any connector height & depth
      down(50/2) back(50/2) cube([Tray_Inner_Width, 50, 50], true);
  }
}


module lid() {
  large_joint = Generate_Style == "Rounded" ? max(Tray_Corners_Radius-Tray_Sides_Thickness,1) :0;
  top_joint = Generate_Style == "Rounded" ? min(Lid_Thickness, 2) : 0;
  sides_joint = Generate_Style == "Rounded" ? Tray_Corners_Radius : 0; 
  small_joint = 0;
  difference() {
    up (Tray_Outer_Height) fwd(Tray_Outer_Depth/2) {
      up (Lid_Thickness/2) 
          rounded_prism(rect([Tray_Outer_Width, Tray_Outer_Depth]), height=Lid_Thickness, joint_top=top_joint,  joint_bot=0,joint_sides=sides_joint); // joint_bot and joint_sides must be different ...
        difference() {
          fwd((Tray_Back_Thickness-Tray_Sides_Thickness)/2) up (Lid_Lip_Height/2-Lid_Thickness) 
            rounded_prism(rect([Tray_Outer_Width-2*Tray_Sides_Thickness-Lid_Lip_Clearance, Tray_Outer_Depth-Tray_Back_Thickness-Tray_Sides_Thickness-Lid_Lip_Clearance]), 
            height=Lid_Lip_Height, joint_top=0, joint_bot=0,joint_sides=large_joint);
            cut_width = Tray_Outer_Width-2*Tray_Sides_Thickness-Lid_Lip_Clearance-2*Lid_Lip_Thickness;
            cut_depth = Tray_Outer_Depth-Tray_Back_Thickness-Tray_Sides_Thickness-Lid_Lip_Clearance-2*Lid_Lip_Thickness;
          fwd((Tray_Back_Thickness-Tray_Sides_Thickness)/2) up (Lid_Lip_Height/2-Lid_Thickness) 
            rounded_prism(rect([cut_width, cut_depth]), 
            height=Lid_Lip_Height+0.01, joint_top=0, joint_bot=0,joint_sides=large_joint);
          // grooves in lip for separators
          for (x_sep = Tray_Width_Separators_NoZero) {
            down(Lid_Thickness) fwd(Tray_Outer_Depth/2) left(Tray_Inner_Width/2+Tray_Separators_Thickness) right(x_sep) 
              cube([Tray_Separators_Thickness*2, Tray_Outer_Depth, Lid_Thickness+0.01]);
          }
          for (y_sep = Tray_Depth_Separators_NoZero) {
            down(Lid_Thickness) left(Tray_Outer_Width/2) fwd(Tray_Inner_Depth/2+Tray_Separators_Thickness) back(y_sep) 
              cube([Tray_Outer_Width, Tray_Separators_Thickness*2, Lid_Thickness+0.01]);
          }
        }
    }
    // Notch
    up(Tray_Outer_Height+Lid_Front_Notch_Height/2-0.01) fwd(Tray_Outer_Depth-Tray_Sides_Thickness/2+0.01)
      cube([Lid_Front_Notch_Width, Tray_Sides_Thickness,Lid_Front_Notch_Height ], center = true);

    // Back
    back(Tray_Back_Thickness/2-Lid_Lip_Clearance)
    if (Tray_Back_Thickness != 0 && Tray_Back_Extension_Height > 0)
      up(Tray_Outer_Height/2) up((Tray_Outer_Height+Tray_Back_Extension_Height)/2)
      fwd((Tray_Back_Thickness)*3/4) cube([Tray_Outer_Width+0.01, Tray_Back_Thickness, Tray_Back_Extension_Height], true);
    fwd(Lid_Lip_Clearance/2) back_extension();

    if (Generate_With_Cutouts == "Hex") {
      depth = Tray_Outer_Depth - max(Tray_Back_Thickness+Lid_Lip_Thickness+Lid_Lip_Clearance/2, max(Tray_Corners_Radius, Lid_Lip_Thickness)) - max(Tray_Sides_Thickness+Lid_Lip_Thickness+Lid_Lip_Clearance/2, max(Tray_Corners_Radius, Lid_Lip_Thickness));

      up (Tray_Outer_Height) back(depth/2) 
      fwd(Tray_Outer_Depth-max(Tray_Sides_Thickness+Lid_Lip_Thickness+Lid_Lip_Clearance/2, max(Tray_Corners_Radius, Lid_Lip_Thickness)))
      intersection() {
        cube([Tray_Outer_Width-2*max(Tray_Corners_Radius, Tray_Sides_Thickness + Lid_Lip_Thickness + Lid_Lip_Clearance/2), 
                        depth,
                        (Lid_Thickness+Lid_Lip_Height)*2+0.01], center=true);

        h_dist = (Tray_Cutouts_Size/2*cos(30)*2+Tray_Cutouts_Distance)*cos(30)*2;
        v_dist = (Tray_Cutouts_Size/2*cos(30)*2+Tray_Cutouts_Distance)*sin(30)*2;
        y_num = ceil(Tray_Outer_Width/(h_dist)/2);
        x_num = ceil(Tray_Outer_Depth/(v_dist));

        for (x = [-x_num:x_num]) {
          for (y = [-y_num:y_num]) {
              // Horizontal separator cutouts
              back(x*v_dist/2) left(h_dist*y + (x%2==0 ? 0:h_dist/2))  cylinder(r=Tray_Cutouts_Size/2, h=(Lid_Thickness+Lid_Lip_Height)*4, center=true, $fn=6); 
          }
        }
      }
    }
  }
}

tray_lid_distance = 10;

back(Generate_a_Lid ? Tray_Outer_Depth+tray_lid_distance/2 : 0) {
  tray();
  back_extension();
  if (Tray_Connector_Type == "HSW-Plug")
    any_connectors(connector_h_dist = HSW_H_DIST, connector_v_dist = HSW_V_DIST, connector_width = (HSW_Plug_Side_To_Side- HSW_Connector_Tolerance)/cos(30), connector_height = (HSW_Plug_Side_To_Side-HSW_Connector_Tolerance), [HSW_Connector_Tolerance]);
  if (Tray_Connector_Type == "IKEA-Skadis")
    any_connectors(connector_h_dist = SKADIS_H_DIST, connector_v_dist = SKADIS_V_DIST, connector_width = (SKADIS_Connector_Diameter - SKADIS_Connector_Diameter_Tolerance), connector_height = SKADIS_Connector_Height, [SKADIS_Connector_Diameter_Tolerance, SKADIS_Connector_Depth_Tolerance], align_top=true);
  if (Tray_Connector_Type == "MB-PushFit")
    any_connectors(connector_h_dist = MB_H_DIST, connector_v_dist = MB_V_DIST, connector_width = (MB_SIZE_1 - MB_Connector_Tolerance), connector_height = MB_SIZE_1, [MB_Connector_Tolerance], align_top=false, shifted_rows = false);

  if (Generate_a_Lid) fwd(Tray_Outer_Depth+tray_lid_distance) up(Lid_Thickness) yrot(180) down(Tray_Outer_Height) lid();
}
// if (Generate_a_Lid) up(5) lid(); // Placement above the tray

