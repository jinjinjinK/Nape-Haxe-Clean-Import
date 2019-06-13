package zpp_nape.geom;
import nape.geom.Mat23;
#if nape_swc@:keep #end
class ZPP_Mat23{
    public var outer:Null<Mat23>=null;
    public function wrapper():Mat23{
        if(outer==null){
            outer=new Mat23();
            {
                var o=outer.zpp_inner;
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        o!=null;
                    };
                    if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Mat23"+", in obj: "+"outer.zpp_inner"+")");
                    #end
                };
                o.free();
                o.next=ZPP_Mat23.zpp_pool;
                ZPP_Mat23.zpp_pool=o;
                #if NAPE_POOL_STATS ZPP_Mat23.POOL_CNT++;
                ZPP_Mat23.POOL_SUB++;
                #end
            };
            outer.zpp_inner=this;
        }
        return outer;
    }
    public var a:Float=0.0;
    public var b:Float=0.0;
    public var c:Float=0.0;
    public var d:Float=0.0;
    public var tx:Float=0.0;
    public var ty:Float=0.0;
    public var _invalidate:Null<Void->Void>=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function invalidate(){
        if(_invalidate!=null){
            _invalidate();
        }
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function set(m:ZPP_Mat23):Void{
        setas(m.a,m.b,m.c,m.d,m.tx,m.ty);
    }
    public function setas(a:Float,b:Float,c:Float,d:Float,tx:Float,ty:Float):Void{
        {
            this.tx=tx;
            this.ty=ty;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((this.tx!=this.tx));
                };
                if(!res)throw "assert("+"!assert_isNaN(this.tx)"+") :: "+("vec_set(in n: "+"this.t"+",in x: "+"tx"+",in y: "+"ty"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((this.ty!=this.ty));
                };
                if(!res)throw "assert("+"!assert_isNaN(this.ty)"+") :: "+("vec_set(in n: "+"this.t"+",in x: "+"tx"+",in y: "+"ty"+")");
                #end
            };
        };
        {
            this.a=a;
            this.b=b;
            this.c=c;
            this.d=d;
        };
    }
    public var next:ZPP_Mat23=null;
    static public var zpp_pool:ZPP_Mat23=null;
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
    function free():Void{}
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc():Void{}
    public function new(){}
     public static function get():ZPP_Mat23{
        var ret;
        {
            if(ZPP_Mat23.zpp_pool==null){
                ret=new ZPP_Mat23();
                #if NAPE_POOL_STATS ZPP_Mat23.POOL_TOT++;
                ZPP_Mat23.POOL_ADDNEW++;
                #end
            }
            else{
                ret=ZPP_Mat23.zpp_pool;
                ZPP_Mat23.zpp_pool=ret.next;
                ret.next=null;
                #if NAPE_POOL_STATS ZPP_Mat23.POOL_CNT--;
                ZPP_Mat23.POOL_ADD++;
                #end
            }
            ret.alloc();
        };
        return ret;
    }
    public static function identity():ZPP_Mat23{
        var ret=ZPP_Mat23.get();
        ret.setas(1,0,0,1,0,0);
        return ret;
    }
}
