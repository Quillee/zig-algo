const std = @import("std");

fn DoublyLinkedList(comptime T: type) type {
    return struct {
        pub const Node = struct {
            data: T,
            next: ?*Node = null,
            prev: ?*Node = null
        };

        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,
        fn head(self: @This()) ?Node {
            return self.first.?;
        }
        fn tail(self: @This()) ?Node {
            return self.last.?;
        }
        fn size(self: @This()) usize {
            return self.len;
        }
        fn search(self: @This(), value: T) anyerror!?Node {
            var current = self.first;
            while (current != null): (current = current.next) {
                if (current.data == value) return current;
            }
            return null;
        }
        fn insert_front(self: @This(), data: T) anyerror!void {
            const new_node = Node { .data = data, .next = self.first };
            if (self.len == 0) {
                self.first = new_node;
            }
            self.first = new_node;
            self.len += 1;
        }
        fn insert_back(self: @This(), data: T) anyerror!void {
            const new_node = Node { .data = data, .prev = self.last };
            if (self.len == 0) {
                self.first = new_node;
            }
            self.last = new_node;
            self.len += 1;
        }
        fn pop_back(self: @This()) anyerror!Node {
            if (self.len == 0) {
                return null;
            }
            if (self.len == 1) {
                const last_elem = self.last;
                self.last = null;
                self.first.* = null;
                return last_elem;
            }

            const last_elem = self.last;
            self.last = self.last.prev;
            self.len -= 1;
            return last_elem;
        }
        fn pop_front(self: @This()) anyerror!Node {
            if (self.len == 0) {
                return null;
            }
            if (self.len == 1) {
                const last_elem = self.last;
                self.last.* = null;
                self.first.* = null;
                return last_elem;
            }

            const last_elem = self.last;
            self.last = self.last.prev;
            self.len -= 1;
            return last_elem;
        }
        fn pop_nth(self: @This(), n: u32) anyerror!Node {
            // if empty or n > len, return null
            // if more than 1, iter til we reach n
            //                               f
            // _ <== | 1 | <==> | 2 | <==> | 3 | <==> | 4 | ==> _
            // _ <== | 1 | ==> _
            if (self.len == 0 or n > self.len) {
                return null;
            }

            var i = 0;
            var current = self.first.*;
            while(i < n): (i += 1) {
                current = current.next;
            }
            const prev = current.prev;
            prev.next = current.next;
            current.next.prev = prev;
        }
        fn print(self: @This()) void {
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

test "Test LinkList insert" {
    const LL = DoublyLinkedList(u32) {};
    try LL.insert_front(6700);
    try std.testing.expect(LL.len == 1);
    try std.testing.expect(try LL.search(6700) != null);
}

test "Array tests" {
    var buffer: [100]u8 = undefined;
    std.debug.print("{any}", .{ buffer });
    const buffer2 = buffer ++ [_]u8{'H', 'e', 'l', 'l', 'o', 'w', 'o', 'r', 'l', 'd', '!'};
    std.debug.print("{any}", .{buffer2});
    // buffer[50..75].* = "Goodbye world";
    // buffer[55..].* = &"Yo mama!";
}

