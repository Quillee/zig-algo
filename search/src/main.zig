const std = @import("std");

const ArrSearchFindingsTuple = std.meta.Tuple(&.{ bool, u32 });
const ArrSearchFindingsStruct = struct { was_found: bool, position: u32 };

pub fn main() !void {
    var gpa_instance = std.heap.GeneralPurposeAllocator(.{}){};
    const gpa = &gpa_instance.allocator();
    var s = try gpa.alloc(u8, 5);
    var c_str = try gpa.allocSentinel(u16, 4, 0);
    c_str[0] = 'H';
    c_str[1] = 'i';
    c_str[2] = '!';

    s[0] = 2;
    std.debug.print("s type {}\n", .{@TypeOf(s)});
    std.debug.print("s type {}\n", .{s[0]});
    std.debug.print("s type {u}\n", .{c_str});
}

fn linear_search(haystack: []u8, needle: u8) anyerror!bool {
    var iter_count: u8 = 1;
    while (iter_count <= haystack.len) {
        if (haystack[iter_count - 1] == needle) {
            return true;
        }
        iter_count += 1;
    }

    return false;
}

fn binary_search(haystack: []u32, needle: u32) bool {
    const u32_haystack_len = @intCast(u32, haystack.len);
    var max: u32 = u32_haystack_len;
    var min: u32 = 0;
    var midpoint = u32_haystack_len / 2 - 1;

    while (max != midpoint and midpoint != min) {
        if (haystack[midpoint] == needle) {
            return true;
        }

        if (haystack[midpoint] > needle) {
            max = midpoint;
        } else {
            min = midpoint;
        }
        midpoint = (max + min) / 2;
    }

    return false;
}

test "linear search" {
    var array = [_]u8{ '4', 'f', '1', 'b', 'A', 'P', 'K', 'l', '5', 'b' };

    var b = try linear_search(&array, 'x');
    try std.testing.expect(!b);
    b = try linear_search(&array, 'b');
    try std.testing.expect(b);
}

test "binary search: value is there" {
    var array = [13]u32{ 1, 2, 3, 4, 5, 6, 7, 12, 20, 40, 45, 500, 1_200 };
    const first_check: u32 = 6;
    var result = binary_search(&array, first_check);
    try std.testing.expect(result);
}

test "binary search: value isn't there" {
    var array = [13]u32{ 1, 2, 3, 4, 5, 6, 7, 12, 20, 40, 45, 500, 1_200 };
    const result = binary_search(&array, 1_000);
    try std.testing.expect(!result);
}
