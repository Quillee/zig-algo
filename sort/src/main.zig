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

// start in 0th pos
// check next elem
//  if > swap
fn bubble_sort(array: []u32) void {
    var i: u32 = 2;
    var j: u32 = 0;
    while (i < array.len): (i += 1) {
        j = 0;
        while(j < array.len - i): (j += 1) {
            if (array[j] > array[j + 1]) {
                const temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
}

test "simple test" {
    var array = [_]u32{ 12, 42, 1, 404, 23, 4_994, 1_211_452, 13_124, 76_342, 4_133};
    bubble_sort(&array);
    const sorted_example = [_]u32{ 1, 12, 23, 42, 404, 4_133, 4_994, 13_124, 76_342, 1_211_452 };
    std.testing.expectEqualSlices(u32, &array, &sorted_example);
}
