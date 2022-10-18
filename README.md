Running the computation manually in the REPL yields the expected result of `[1, 2, 12]`.
But encoding this in the function `test_gather_segsum4` in `demo.fut` yields a different
result of `[0, 0, 2]`.

Notice the preceding `test_gather_segsums{1,2,3}` tests that ensures that each
intermediate value of `flags`, `segsum` and `idxs` are as in the REPL.
Also note that `test_gather_segsums5` succeeds.

Run `make` to run all including the failing test.

```futhark
$ futhark -V
Futhark 0.22.2
git: 9550f97925171f7e89ea02048bd1e377114c87d0
Copyright (C) DIKU, University of Copenhagen, released under the ISC license.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
$ futhark repl
┃╱╱ ┃╲    ┃   ┃╲  ┃╲   ╱
┃╱  ┃ ╲   ┃╲  ┃╲  ┃╱  ╱
┃   ┃  ╲  ┃╱  ┃   ┃╲  ╲
┃   ┃   ╲ ┃   ┃   ┃ ╲  ╲
Version 0.22.2.
Copyright (C) DIKU, University of Copenhagen, released under the ISC license.

Run :help for a list of commands.
[0]> :l demo.fut
Loading demo.fut
[0]> let reps = [2,1,3]
[1]> let vals = [0,1,2,3,4,5]
[2]> let flags = idxs_to_flags_i32 reps :> [6]bool
[3]> let segsum = segmented_scan_add flags vals
[4]> let idxs = segments_end_indices_i32 reps
[5]> reps
[2, 1, 3]
[6]> vals
[0, 1, 2, 3, 4, 5]
[7]> flags
[false, false, true, true, false, false]
[8]> segsum
[0, 1, 2, 3, 7, 12]
[9]> idxs
[1, 2, 5]
[10]> map (\i -> segsum[i]) idxs
[1, 2, 12]
```
