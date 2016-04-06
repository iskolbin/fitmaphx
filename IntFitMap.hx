package ;

class IntFitMapIterator<V> {
	public var keysIterator: Iterator<Int>;
	public var storage: Map<Int,V>;

	public inline function new( keysIterator: Iterator<Int>, storage: Map<Int,V> ) {
		this.keysIterator = keysIterator;
		this.storage = storage;
	}

	public inline function hasNext(): Bool {
		return keysIterator.hasNext();
	}

	public inline function next(): V {
		return storage[keysIterator.next()];
	}
}

class IntFitMap<V> implements haxe.Constraints.IMap<Int,V> {
	public var storage(default,null): Map<Int,V>;
	public var keysArray(default,null): Array<Int>;
	public var keysMap(default,null): Map<Int,Int>;

	public inline function get(k: Int): Null<V> {
		return storage.get( k );
	}

	public function set(k: Int, v: V): Void {
		storage.set( k, v );
		if ( !keysMap.exists( k )) {
			keysMap[k] = keysArray.length;
			keysArray.push( k );
		}
	}

	public inline function exists(k: Int): Bool {
		return storage.exists( k );
	}

	public function remove(k: Int): Bool {
		var removed = storage.remove( k );
		if ( removed ) {
			var lastIndex = keysArray.length-1;  
			if ( lastIndex > 1 ) {
				var index = keysMap[k];
				if ( index != lastIndex ) {
					keysArray[index] = keysArray[lastIndex];
				}
			}
			keysArray.pop();
			keysMap.remove( k );
		}
		return removed;
	}

	public inline function keys(): Iterator<Int> {
		return keysArray.iterator();
	}

	public inline function iterator(): Iterator<V> {
		return new IntFitMapIterator<V>( keysArray.iterator(), storage );
	}

	public inline function toString(): String {
		return storage.toString();
	}

	public inline function new() {
		this.storage = new Map<Int,V>();
		this.keysArray = new Array<Int>();
		this.keysMap = new Map<Int,Int>();
	}
}

