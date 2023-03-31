const std = @import("std");

fn LinkedList(comptime T: type) type {
    return struct {
        pub const Node = struct {
            data: T,
            next: ?*Node,
            prev: ?*Node
        };

        first: ?*Node,
        last: ?*Node,
        len: usize,
        fn head(self: @This()) Node {
            return self.first;
        }
        fn tail(self: @This()) Node {
            return self.last;
        }
        fn size(self: @This()) Node {
            return self.len;
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
                const last = self.last;
                self.last = null;
                self.first = null;
                return last;
            }

            const last = self.last;
            self.last = self.last.prev;
            self.len -= 1;
            return last;
        }
        fn pop_front(self: @This()) anyerror!Node {
            if (self.len == 0) {
                return null;
            }
            if (self.len == 1) {
                const last = self.last;
                self.last = null;
                self.first = null;
                return last;
            }

            const last = self.last;
            self.last = self.last.prev;
            self.len -= 1;
            return last;
        }
        fn pop_nth(self: @This(), n: u32) anyerror!Node {
            // if empty or n > len, return null
            // if more than 1, iter til we reach n
            //                               f
            // _ <== | 1 | <==> | 2 | <==> | 3 | <==> | 4 | ==> _
            // _ <== | 1 | ==> _

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
    const LL = LinkedList(u32) {};
    LL.insert_front(6700);
}

