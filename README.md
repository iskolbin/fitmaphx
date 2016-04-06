# fitmaphx
Fast iterable maps for Haxe

Haxe generates quite inefficient code for map iteration for some targets ( js, cpp, neko ). Each time you iterate map by keys/values haxe collects keys into array. While it's not so important when your maps are small, but for large maps we essentialy get O(n) overhead.

In this project there are 4 classes implemented which mirrors haxe.ds.IntMap, StringMap, ObjectMap and EnumValueMap. To remove keys collection overhead they are stored into separate Array and updated during set/remove function calls (O(1) complexity).

To run bunch of tests call

```sh
haxe test.hxml
```

This run pack of naive tests which illustrates O(n) behaviour for Map key() and iterator() functions and O(1) for FitMap. Also worth mentioning that python, cs, java targets don't have this problem.
