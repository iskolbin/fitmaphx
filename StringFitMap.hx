package ;

class StringFitMapIterator<V> {
	public var keysIterator: Iterator<String>;
	public var storage: Map<String,V>;

	public inline function new( keysIterator: Iterator<String>, storage: Map<String,V> ) {
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

class StringFitMap<V> implements haxe.Constraints.IMap<String,V> {
	public var storage(default,null): Map<String,V>;
	public var keysArray(default,null): Array<String>;
	public var keysMap(default,null): Map<String,Int>;

	public inline function get(k: String): Null<V> {
		return storage.get( k );
	}

	public function set(k: String, v: V): Void {
		storage.set( k, v );
		if ( !keysMap.exists( k )) {
			keysMap[k] = keysArray.length;
			keysArray.push( k );
		}
	}

	public inline function exists(k: String): Bool {
		return storage.exists( k );
	}

	public function remove(k: String): Bool {
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

	public inline function keys(): Iterator<String> {
		return keysArray.iterator();
	}

	public inline function iterator(): Iterator<V> {
		return new StringFitMapIterator<V>( keysArray.iterator(), storage );
	}

	public inline function toString(): String {
		return storage.toString();
	}

	public inline function new() {
		this.storage = new Map<String,V>();
		this.keysArray = new Array<String>();
		this.keysMap = new Map<String,Int>();
	}
}

