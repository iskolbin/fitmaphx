package ;

class EnumValueFitMap<K:EnumValue,V> implements haxe.Constraints.IMap<K,V> {
	public var storage(default,null): Map<K,V>;
	public var keysArray(default,null): Array<K>;
	public var keysMap(default,null): Map<K,Int>;

	public inline function get(k: K): Null<V> {
		return storage.get( k );
	}

	public function set(k: K, v: V): Void {
		storage.set( k, v );
		if ( !keysMap.exists( k )) {
			keysMap[k] = keysArray.length;
			keysArray.push( k );
		}
	}

	public inline function exists(k: K): Bool {
		return storage.exists( k );
	}

	public function remove(k: K): Bool {
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

	public inline function keys(): Iterator<K> {
		return keysArray.iterator();
	}

	public inline function iterator(): Iterator<V> {
		var keysIterator = keys();
		return {
			hasNext: keysIterator.hasNext,
			next: function() {
				return storage[keysIterator.next()];
			}
		}
	}

	public inline function toString(): String {
		return storage.toString();
	}

	public inline function new() {
		this.storage = new Map<K,V>();
		this.keysArray = new Array<K>();
		this.keysMap = new Map<K,Int>();
	}
}

