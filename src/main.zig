const std = @import("std");
const leftpad = @import("leftpad");

pub fn main() !void {
    const instr = "example string\n";

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const output = try leftpad.leftpad(allocator, instr, 4, ' ');
    defer allocator.free(output);

    _ = try stdout.write(output);

    try bw.flush(); // don't forget to flush!
}
