w_unit = 3;
d_unit = 4;

is_rotate = true;
side_rotation_angle = is_rotate ? 90 : 0;
lazer_curve = 0.5;
additional_translate = is_rotate ? lazer_curve : 0;

size = 41.5;

width = w_unit * size;      
depth = d_unit * size;
height = 45;
thickness = 4;
joint_size = 11.5;
vertical_joint_size = 15;

inner_width = width - 2 * thickness;
inner_depth = depth - 2 * thickness;

module bottom() {
    translate([thickness, thickness, 0])
        cube([inner_width, inner_depth, thickness]);

    for (i = [0 : 1 : w_unit - 1]) {
        translate([i * size, 0, 0]) {
            translate([size / 2 - joint_size / 2, 0, 0])
                cube([joint_size, thickness, thickness]);

            translate([size / 2 - joint_size / 2, depth - thickness, 0])
                cube([joint_size, thickness, thickness]);
        }
    }

    for (i = [0: 1: d_unit - 1]) {
        translate([0, i * size, 0]) {
            translate([0, size / 2 - joint_size / 2, 0])
                cube([thickness, joint_size, thickness]);

            translate([width - thickness, size / 2 - joint_size / 2, 0])
                cube([thickness, joint_size, thickness]);
        }
    }
}

module widthSide() {
    difference() {
        translate([thickness, 0, 0]) {
            cube([inner_width, thickness, height]);
        }

        for (i = [0 : 1 : w_unit - 1]) {
            translate([i * size, 0, 0]) {
                translate([size / 2 - joint_size / 2, 0, 0])
                    cube([joint_size, thickness, thickness]);
            }
        }
    }
    translate([0, 0, height / 2 - vertical_joint_size / 2]) {
        cube([thickness, thickness, vertical_joint_size]);
        translate([inner_width + thickness, 0, 0])
            cube([thickness, thickness, vertical_joint_size]);
    }
}

module depthSide() {
    difference() {
        cube([thickness, depth, height]);
        
        for (i = [0: 1: d_unit - 1]) {
            translate([0, i * size, 0]) {
                translate([0, size / 2 - joint_size / 2, 0])
                    cube([thickness, joint_size, thickness]);
            }
        }

        translate([0, 0, height / 2 - vertical_joint_size / 2]) {
            cube([thickness, thickness, vertical_joint_size]);
            translate([0, depth - thickness, 0]) {
                cube([thickness, thickness, vertical_joint_size]);
            }
        }
    }
}

color([1, 0, 0, 0.9]) {
    bottom();
}

color([0, 0, 1, 0.9]) {
    rotate([side_rotation_angle, 0, 0]) {
        translate([0, 0, additional_translate]) {
            widthSide();
        }
    }
}

color([0, 0, 1, 0.9]) {
    translate([0, depth, 0]) {
        rotate([-side_rotation_angle, 0, 0]) {
            translate([0, - thickness, additional_translate]) {
                widthSide();
            }
        }
    }
}

color([0, 0, 0, 0.9]) {
    rotate([0, -side_rotation_angle, 0]) {
        translate([0, 0, additional_translate]) {
            depthSide();
        }
    }
}

color([0, 0, 0, 0.9]) {
    translate([width, 0, 0]) {
        rotate([0, side_rotation_angle, 0]) {
            translate([-thickness, 0, additional_translate]) {
                depthSide();
            }
        }
    }
}
