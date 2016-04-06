package ;

class TestResult {
	public var t1: Float;
	public var t2: Float;
	
	public inline function new( t1: Float, t2: Float ) { 
		this.t1 = t1;
		this.t2 = t2;
	}

	public function toString() {
		return 'Map ${t1}, FitMap ${t2}';
	}
}

class Test {
	
	static var a: Map<Int,Int>;
	static var b: IntFitMap<Int>;

	static function evalTime( f1: Int->Void, f2: Int->Void, n: Int ): TestResult {
		var random = [ for (i in 0...n) Std.random(n)];
		
		var start1 = haxe.Timer.stamp();
		for ( i in 0...n ) f1(random[i]);
		var finish1 = haxe.Timer.stamp();
		
		var start2 = haxe.Timer.stamp();
		for ( i in 0...n ) f2(random[i]);
		var finish2 = haxe.Timer.stamp();
		
		return new TestResult( (finish1 - start1)/n, (finish2 - start2)/n );
	}
	
	static inline function test1a(key) a[key] = 0;
	static inline function test1b(key) b.set(key, 0);

	static inline function test2a(key) {var i = a[key];}
	static inline function test2b(key) {var j = b.get(key);}

	static inline function test3a(key) {var i = a.exists( key );}
	static inline function test3b(key) {var j = b.exists( key );}

	static inline function test4a(key) {var i = a.keys();}
	static inline function test4b(key) {var j = b.keys();}
	
	static inline function test5a(key) {var i = a.iterator();}
	static inline function test5b(key) {var j = b.iterator();}

	static inline function test6a(key) a.remove( key );
	static inline function test6b(key) b.remove( key );


	public static function main() {
		for ( n in [10,100,1000,10000] ) {
			a = new Map<Int,Int>();
			b = new IntFitMap<Int>();
		
			trace( 'FOR ${n} ITEMS' );
			trace( "set", evalTime(test1a,test1b,n));
			trace( "get", evalTime(test2a,test2b,n));
			trace( "exists", evalTime(test3a,test3b,n));
			trace( "keys", evalTime(test4a,test4b,n));
			trace( "iterator", evalTime(test5a,test5b,n));
			trace( "remove", evalTime(test6a,test6b,n));
			trace( "" );
		}
	}
}
