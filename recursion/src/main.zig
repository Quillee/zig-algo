const std = @import("std");
const u8ArrayList = std.ArrayList([]u8);
const PointArrayList = std.ArrayList(Point);
const COL_SIZE = 10;
const ROW_SIZE = 3;

const Point = struct {
    const Self = @This();

    x: i8,
    y: i8,
};

const WALK_DIRECTION_ARR: []Point = []Point {
    Point { .x = 1, .y = 0 },
    Point { .x = 0, .y = 1 },
    Point { .x = -1, .y = 0 },
    Point { .x = 0, .y = -1 },
};

fn walk(maze: [][]u8, wall: u8, cpos: Point, end: Point, seen: [][]bool, path: PointArrayList) bool {
    // Its end position
    if (cpos.x == end.x and cpos.y == end.y) {
        path.append(cpos);
        return true;
    }

    // Next position off the map
    if (cpos.x < 0 or cpos.x >= maze[0].len
        or cpos.y < 0 or cpos.y >= maze.len) {
        return false;
    }

    // Next position is a wall
    if (maze[cpos.y][cpos.x] == wall) {
        return false;
    }

    // Have we already seen this location?
    if(seen[cpos.y][cpos.x]) return true;

    seen[cpos.y][cpos.x] = true;
    path.append(cpos);
    for (WALK_DIRECTION_ARR) |it| {
        if (walk(maze, wall, Point {cpos.y + it.y, cpos.x + it.x}, end, seen, path)) {
            return true;
        }
    }

    path.pop(cpos);
}

fn solve(maze: [][]u8, wall: u8, start: Point, end: Point, path: PointArrayList) void {
    const seen: [][]bool  = undefined;
    var i: usize = 0;
    var j: usize = 0;

    // @whaa? is there a better way to do this?
    while(i < maze.len) {
        while(j < maze[0].len) {
            seen[i][j] = false;
        }
    }

    if (walk(maze, wall, start, end, seen, path)) {
        std.debug.print("Path found! {any}", .{path});
    } else {
        std.debug.print("Path not found! {any}", .{path});
    }
}

// maze problem
// [
//  ########E#
//  #        #
//  #S########
// ]
// Next position is a wall
// Next position off the map
// Have we already seen this location?
// Its end position
pub fn main() !void {
}

test "simple test" {
    const allocator = std.testing.allocator;

    const path_to_end: PointArrayList = std.ArrayList(Point).init(allocator);
    defer path_to_end.deinit();

    const maze: [ROW_SIZE][COL_SIZE]u8 = [ROW_SIZE][COL_SIZE]u8{
        [_]u8 {'#', '#', '#', '#', '#', '#', '#', 'E', '#', '#'},
        [_]u8 {'#',' ',' ',' ',' ',' ',' ',' ',' ',' '},
        [_]u8 {'#','S','#','#','#','#','#','#','#','#'},
   };
   solve(maze[0..], '#', Point { .x = 1, .y = 2 }, Point { .x = 7, .y = 0 }, path_to_end);
}
