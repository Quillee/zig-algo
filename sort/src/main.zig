const std = @import("std");

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!
}

fn bubble_sort(array: []u32) void {
    var i: u32 = 0;
    var j: u32 = 0;
    while (i < array.len): (i += 1) {
        j = i;
        while(j < array.len - 1): (j += 1) {
            if (array[j] > array[i]) {
                const temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
}

test "simple test" {
    var array = [_]u32{ 12, 42, 1, 404, 23, 4_994, 1_211_452, 13_124, 76_342, 4_133};
    std.debug.print("Before: {any}\n", .{array});
    bubble_sort(&array);
    std.debug.print("Result: {any}\n", .{array});
}
