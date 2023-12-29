w_unit = 4;
d_unit = 4;

size = 41.5;

width = w_unit * size;
depth = d_unit * size;
thickness = 4;
joint_size = 11.5;

inner_width = width - 2 * thickness;
inner_depth = depth - 2 * thickness;

translate([thickness, thickness, 0])
    cube([inner_width, inner_depth, thickness]);

pin = cube([joint_size, thickness, thickness]);

for (i = [0 : 1 : w_unit - 1]) {
    translate([i * size, 0, 0]) {
        translate([size / 2 - joint_size / 2, 0, 0])
            pin;

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