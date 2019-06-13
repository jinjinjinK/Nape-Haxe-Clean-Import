package zpp_nape.geom;
import nape.geom.GeomPoly;
import nape.geom.GeomVertexIterator;
import nape.geom.Vec2;
import zpp_nape.geom.Vec2;
#if nape_swc@:keep #end
class ZPP_GeomVert{
    public var x:Float=0.0;
    public var y:Float=0.0;
    public var prev:ZPP_GeomVert=null;
    public var next:ZPP_GeomVert=null;
    public var wrap:Null<Vec2>=null;
    public var forced:Bool=false;
    static public var zpp_pool:ZPP_GeomVert=null;
    #if NAPE_POOL_STATS 
    /**
     * @private
     */
    static public var POOL_CNT:Int=0;
    /**
     * @private
     */
    static public var POOL_TOT:Int=0;
    /**
     * @private
     */
    static public var POOL_ADD:Int=0;
    /**
     * @private
     */
    static public var POOL_ADDNEW:Int=0;
    /**
     * @private
     */
    static public var POOL_SUB:Int=0;
    #end
    
    public#if NAPE_NO_INLINE#else inline #end
    function free():Void{
        if(wrap!=null){
            wrap.zpp_inner._inuse=false;
            wrap.dispose();
            wrap=null;
        }
        prev=next=null;
    }
    public#if NAPE_NO_INLINE#else inline #end
    function alloc():Void{
        forced=false;
    }
    public#if NAPE_NO_INLINE#else inline #end
    function wrapper():Vec2{
        if(wrap==null){
            wrap=Vec2.get(x,y);
            wrap.zpp_inner._inuse=true;
            wrap.zpp_inner._invalidate=modwrap;
            wrap.zpp_inner._validate=getwrap;
        }
        return wrap;
    }
    public#if NAPE_NO_INLINE#else inline #end
    function modwrap(n:ZPP_Vec2):Void{
        {
            this.x=n.x;
            this.y=n.y;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((this.x!=this.x));
                };
                if(!res)throw "assert("+"!assert_isNaN(this.x)"+") :: "+("vec_set(in n: "+"this."+",in x: "+"n.x"+",in y: "+"n.y"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((this.y!=this.y));
                };
                if(!res)throw "assert("+"!assert_isNaN(this.y)"+") :: "+("vec_set(in n: "+"this."+",in x: "+"n.x"+",in y: "+"n.y"+")");
                #end
            };
        };
    }
    public#if NAPE_NO_INLINE#else inline #end
    function getwrap():Void{
        {
            wrap.zpp_inner.x=this.x;
            wrap.zpp_inner.y=this.y;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((wrap.zpp_inner.x!=wrap.zpp_inner.x));
                };
                if(!res)throw "assert("+"!assert_isNaN(wrap.zpp_inner.x)"+") :: "+("vec_set(in n: "+"wrap.zpp_inner."+",in x: "+"this.x"+",in y: "+"this.y"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((wrap.zpp_inner.y!=wrap.zpp_inner.y));
                };
                if(!res)throw "assert("+"!assert_isNaN(wrap.zpp_inner.y)"+") :: "+("vec_set(in n: "+"wrap.zpp_inner."+",in x: "+"this.x"+",in y: "+"this.y"+")");
                #end
            };
        };
    }
    public static#if NAPE_NO_INLINE#else inline #end
    function get(x:Float,y:Float):ZPP_GeomVert{
        var ret;
        {
            if(ZPP_GeomVert.zpp_pool==null){
                ret=new ZPP_GeomVert();
                #if NAPE_POOL_STATS ZPP_GeomVert.POOL_TOT++;
                ZPP_GeomVert.POOL_ADDNEW++;
                #end
            }
            else{
                ret=ZPP_GeomVert.zpp_pool;
                ZPP_GeomVert.zpp_pool=ret.next;
                ret.next=null;
                #if NAPE_POOL_STATS ZPP_GeomVert.POOL_CNT--;
                ZPP_GeomVert.POOL_ADD++;
                #end
            }
            ret.alloc();
        };
        {
            ret.x=x;
            ret.y=y;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((ret.x!=ret.x));
                };
                if(!res)throw "assert("+"!assert_isNaN(ret.x)"+") :: "+("vec_set(in n: "+"ret."+",in x: "+"x"+",in y: "+"y"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((ret.y!=ret.y));
                };
                if(!res)throw "assert("+"!assert_isNaN(ret.y)"+") :: "+("vec_set(in n: "+"ret."+",in x: "+"x"+",in y: "+"y"+")");
                #end
            };
        };
        return ret;
    }
    public function new(){}
}
#if nape_swc@:keep #end
class ZPP_GeomPoly{
    public var outer:GeomPoly=null;
    public var vertices:Null<ZPP_GeomVert>=null;
    public function new(outer:GeomPoly){
        this.outer=outer;
    }
}
#if nape_swc@:keep #end
class ZPP_GeomVertexIterator{
    public var ptr:ZPP_GeomVert=null;
    public var start:ZPP_GeomVert=null;
    public var first:Bool=false;
    public var forward:Bool=false;
    public var outer:GeomVertexIterator=null;
    public var next:ZPP_GeomVertexIterator=null;
    static public var zpp_pool:ZPP_GeomVertexIterator=null;
    #if NAPE_POOL_STATS 
    /**
     * @private
     */
    static public var POOL_CNT:Int=0;
    /**
     * @private
     */
    static public var POOL_TOT:Int=0;
    /**
     * @private
     */
    static public var POOL_ADD:Int=0;
    /**
     * @private
     */
    static public var POOL_ADDNEW:Int=0;
    /**
     * @private
     */
    static public var POOL_SUB:Int=0;
    #end
    
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function free():Void{
        outer.zpp_inner=null;
        ptr=start=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    #if(!NAPE_RELEASE_BUILD)
    public static var internal=false;
    #end
    function new(){
        #if(!NAPE_RELEASE_BUILD)
        internal=true;
        #end
        outer=new GeomVertexIterator();
        #if(!NAPE_RELEASE_BUILD)
        internal=false;
        #end
    }
    public static function get(poly:ZPP_GeomVert,forward:Bool){
        var ret;
        {
            if(ZPP_GeomVertexIterator.zpp_pool==null){
                ret=new ZPP_GeomVertexIterator();
                #if NAPE_POOL_STATS ZPP_GeomVertexIterator.POOL_TOT++;
                ZPP_GeomVertexIterator.POOL_ADDNEW++;
                #end
            }
            else{
                ret=ZPP_GeomVertexIterator.zpp_pool;
                ZPP_GeomVertexIterator.zpp_pool=ret.next;
                ret.next=null;
                #if NAPE_POOL_STATS ZPP_GeomVertexIterator.POOL_CNT--;
                ZPP_GeomVertexIterator.POOL_ADD++;
                #end
            }
            ret.alloc();
        };
        ret.outer.zpp_inner=ret;
        ret.ptr=poly;
        ret.forward=forward;
        ret.start=poly;
        ret.first=poly!=null;
        return ret.outer;
    }
}
