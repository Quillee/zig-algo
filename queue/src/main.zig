const std = @import("std");

const NewStruct = struct {
    value: u64,
    name: []u8,
    isValid: bool,
};

fn Queue(comptime T: type) type {
    return struct {
        const Self = @This();

        var tail: ?*Node = null;
        var head: ?*Node = null;
        var len: usize = 0;

        alloc: std.mem.Allocator,

        pub const Node = struct {
            data: T,
            next: ?*Node = null,
        };

        pub fn size(self: Self) usize {
            return self.len;
        }

        pub fn search(self: Self, value: T) anyerror!?Node {
            var current = self.first;
            while (current != null): (current = current.next) {
                if (current.data == value) return current;
            }
            return null;
        }

        pub fn enqueue(self: Self, data: T) anyerror!void {
            const new_node = Node { .data = data, .next = self.head };
            if (self.len == 0) {
                self.tail = new_node;
            }
            self.head = new_node;
            self.len += 1;
        }

        pub fn dequeue(self: Self) !?Node {
            if (self.len == 0) {
                return null;
            }

            const last_elem = self.tail.*;
            if (self.len == 1) {
                self.tail = null;
                self.head = null;

                self.len = 0;

                return last_elem;
            }

            self.len -= 1;
            return last_elem;
        }

        pub fn peek(self: Self) ?T {
            return self.tail.?.*.data;
        }

        pub fn print(self: Self) void {
            // const prepend = std.fmt.format("DoublyLinkedList {{ len: {d}, list: [] }};
            if (self.len < 0) std.debug.print("DoublyLinkedList {{ len: 0, list: [] }}", .{});
            var current = self.first;
            const buffer: [4096]u8 = undefined;
            buffer[0..].* = "hellp world";
            while (current != null): (current = current.next) {
            }
        }
    };
}

pub fn main() !void  {
}

// test "Test Queue insert" {
//     const queue = Queue(u32) {};
//     try queue.enqueue(6700);
//     try std.testing.expect(queue.len == 1);
//     std.debug.print("{d}\n", .{queue.peek()});
//     try std.testing.expect(queue.peek() != null);
// }
//
test "Array" {
    var x = [_]u8 {'h', 'e', 'l'};
    var x_ptr = &x;
    var slice_x_ptr = x_ptr[1..];
    std.debug.print("Type of x: {any}, Type of x ptr: {any}, Type of slice of x ptr, len: {any}, {d}\n\n", .{ @TypeOf(x), @TypeOf(x_ptr), @TypeOf(slice_x_ptr), slice_x_ptr.len });


    var buffer: [1000]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const alloc = fba.allocator();

    var y = try alloc.alloc(u8, 5);
    defer alloc.free(y);

    y[0] = 'h';
    y[1] = '3';
    y[2] = 'l';
    y[3] = 'l';
    y[4] = '0';

    std.debug.print("Type of y: {any}\n\n", .{ @TypeOf(y) });

    std.debug.print("\n", .{});
}

test "New zig struct" {
    var buffer: [1000]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const alloc = fba.allocator();

    var y = try alloc.alloc(u8, 100);
    defer alloc.free(y);

    const user = "Eduardo Montaya Ramirez De la Hoya";
    y[0..user.len].* = user.*;
    var ns = NewStruct{ .name = y, .value = 121313123123, .isValid = false };
    ns.isValid = true;
    ns.name[user.len..(user.len*2)].* = user.*;

    std.debug.print("name: {s}, y: {s}", .{ ns.name[0..ns.name.len], y[0..ns.name.len] });
}

test "Queue" {
    var buffer: [1000]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const alloc = fba.allocator();

    var y = try alloc.alloc(u8, 100);
    defer alloc.free(y);
}

