// This took me three hours.
//
// Sticking points:
// - when i and j were declared without type, it was called `comptime_int` and I was confused.
// - not obvious how to print to stdout, had to search
// - did not know about items field, saw only toOwnedSlice, had to search github for even toSlice, then compiler message lead me to items.
// - tried arrays at first, that was also hard to initialize a multidimensional array using repeats.
// - can't do `ArrayList.init`, need to do it on `ArrayList(T)`, but somehow I didn't get it at first.
//      Maybe because Rust would be `ArrayList::init::<T>()
const std = @import("std");
const rand = std.crypto.random;
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

const Grid = ArrayList(ArrayList(bool));
const Row = ArrayList(bool);

const Game = struct {
    grid: ArrayList(ArrayList(bool)),

    fn init(x: u16, y: u16, alloc: *Allocator) !Game {
        var grid = try Grid.initCapacity(alloc, x);

        var i: u16 = 0;
        while (i < x) : (i += 1) {
            var row = try Row.initCapacity(alloc, y);
            var j: u16 = 0;
            while (j < y) : (j += 1) {
                try row.append(false);
            }
            try grid.append(row);
        }

        return Game{
            .grid = grid,
        };
    }

    fn deinit(self: *Game) void {
        for (self.grid.items) |row| {
            row.deinit();
        }
        self.grid.deinit();
    }

    fn print(self: *Game) !void {
        var stdout = std.io.getStdOut().writer();

        for (self.grid.items) |row| {
            for (row.items) |x| {
                if (x) {
                    try stdout.print("|", .{});
                } else {
                    try stdout.print("0", .{});
                }
            }
            try stdout.print("\n", .{});
        }
        try stdout.print("\n", .{});
    }
};

pub fn main() anyerror!void {
    var gpalloc = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.debug.assert(!gpalloc.deinit());

    const alloc = &gpalloc.allocator;

    var game = try Game.init(20, 20, alloc);
    defer game.deinit();

    try game.print();
}
