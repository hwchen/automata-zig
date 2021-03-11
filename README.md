## automata-zig

Game of Life in zig

First zig project, first commit took me three hours (just initial setup).

 Sticking points:
 - when i and j were declared without type, it was called `comptime_int` and I was confused.
 - not obvious how to print to stdout, had to search
 - did not know about items field, saw only toOwnedSlice, had to search github for even toSlice, then compiler message lead me to items.
 - tried arrays at first, that was also hard to initialize a multidimensional array using repeats.
 - can't do `ArrayList.init`, need to do it on `ArrayList(T)`, but somehow I didn't get it at first.
      Maybe because Rust would be `ArrayList::init::<T>()`

Unfortunately, none of these points were due to confusion about overall model (e.g. more explicit allocation), it was figuring out what the language wanted to get me there.
