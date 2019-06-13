package zpp_nape.geom;
import nape.geom.AABB;
import nape.geom.Vec2;
import zpp_nape.geom.Vec2;
#if nape_swc@:keep #end
class ZPP_AABB{
    public var _invalidate:Null<ZPP_AABB->Void>=null;
    public var _validate:Null<Void->Void>=null;
    public var _immutable:Bool=false;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function validate():Void{
        if(_validate!=null){
            _validate();
        }
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function invalidate():Void{
        if(_invalidate!=null){
            _invalidate(this);
        }
    }
    public var outer:Null<AABB>=null;
    public function wrapper():AABB{
        if(outer==null){
            outer=new AABB();
            {
                var o=outer.zpp_inner;
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        o!=null;
                    };
                    if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_AABB"+", in obj: "+"outer.zpp_inner"+")");
                    #end
                };
                o.free();
                o.next=ZPP_AABB.zpp_pool;
                ZPP_AABB.zpp_pool=o;
                #if NAPE_POOL_STATS ZPP_AABB.POOL_CNT++;
                ZPP_AABB.POOL_SUB++;
                #end
            };
            outer.zpp_inner=this;
        }
        return outer;
    }
    public var next:ZPP_AABB=null;
    static public var zpp_pool:ZPP_AABB=null;
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
    function alloc():Void{}
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function free():Void{
        if(outer!=null){
            outer.zpp_inner=null;
            outer=null;
        }
        wrap_min=wrap_max=null;
        _invalidate=null;
        _validate=null;
    }
    public function new(){}
    public static#if NAPE_NO_INLINE#else inline #end
    function get(minx:Float,miny:Float,maxx:Float,maxy:Float):ZPP_AABB{
        var ret;
        {
            if(ZPP_AABB.zpp_pool==null){
                ret=new ZPP_AABB();
                #if NAPE_POOL_STATS ZPP_AABB.POOL_TOT++;
                ZPP_AABB.POOL_ADDNEW++;
                #end
            }
            else{
                ret=ZPP_AABB.zpp_pool;
                ZPP_AABB.zpp_pool=ret.next;
                ret.next=null;
                #if NAPE_POOL_STATS ZPP_AABB.POOL_CNT--;
                ZPP_AABB.POOL_ADD++;
                #end
            }
            ret.alloc();
        };
        {
            ret.minx=minx;
            ret.miny=miny;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((ret.minx!=ret.minx));
                };
                if(!res)throw "assert("+"!assert_isNaN(ret.minx)"+") :: "+("vec_set(in n: "+"ret.min"+",in x: "+"minx"+",in y: "+"miny"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((ret.miny!=ret.miny));
                };
                if(!res)throw "assert("+"!assert_isNaN(ret.miny)"+") :: "+("vec_set(in n: "+"ret.min"+",in x: "+"minx"+",in y: "+"miny"+")");
                #end
            };
        };
        {
            ret.maxx=maxx;
            ret.maxy=maxy;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((ret.maxx!=ret.maxx));
                };
                if(!res)throw "assert("+"!assert_isNaN(ret.maxx)"+") :: "+("vec_set(in n: "+"ret.max"+",in x: "+"maxx"+",in y: "+"maxy"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((ret.maxy!=ret.maxy));
                };
                if(!res)throw "assert("+"!assert_isNaN(ret.maxy)"+") :: "+("vec_set(in n: "+"ret.max"+",in x: "+"maxx"+",in y: "+"maxy"+")");
                #end
            };
        };
        return ret;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function copy():ZPP_AABB{
        return ZPP_AABB.get(minx,miny,maxx,maxy);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function width():Float{
        return maxx-minx;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function height():Float{
        return maxy-miny;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function perimeter():Float{
        return(width()+height())*2;
    }
    public var minx:Float=0.0;
    public var miny:Float=0.0;
    public var wrap_min:Null<Vec2>=null;
    public function getmin():Vec2{
        if(wrap_min==null){
            wrap_min=Vec2.get(minx,miny);
            wrap_min.zpp_inner._inuse=true;
            if(_immutable){
                wrap_min.zpp_inner._immutable=true;
            }
            else{
                wrap_min.zpp_inner._invalidate=mod_min;
            }
            wrap_min.zpp_inner._validate=dom_min;
        }
        return wrap_min;
    }
    public function dom_min():Void{
        validate();
        {
            wrap_min.zpp_inner.x=minx;
            wrap_min.zpp_inner.y=miny;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((wrap_min.zpp_inner.x!=wrap_min.zpp_inner.x));
                };
                if(!res)throw "assert("+"!assert_isNaN(wrap_min.zpp_inner.x)"+") :: "+("vec_set(in n: "+"wrap_min.zpp_inner."+",in x: "+"minx"+",in y: "+"miny"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((wrap_min.zpp_inner.y!=wrap_min.zpp_inner.y));
                };
                if(!res)throw "assert("+"!assert_isNaN(wrap_min.zpp_inner.y)"+") :: "+("vec_set(in n: "+"wrap_min.zpp_inner."+",in x: "+"minx"+",in y: "+"miny"+")");
                #end
            };
        };
    }
    public function mod_min(min:ZPP_Vec2):Void{
        if(min.x!=minx||min.y!=miny){
            {
                minx=min.x;
                miny=min.y;
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        !((minx!=minx));
                    };
                    if(!res)throw "assert("+"!assert_isNaN(minx)"+") :: "+("vec_set(in n: "+"min"+",in x: "+"min.x"+",in y: "+"min.y"+")");
                    #end
                };
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        !((miny!=miny));
                    };
                    if(!res)throw "assert("+"!assert_isNaN(miny)"+") :: "+("vec_set(in n: "+"min"+",in x: "+"min.x"+",in y: "+"min.y"+")");
                    #end
                };
            };
            invalidate();
        }
    }
    public var maxx:Float=0.0;
    public var maxy:Float=0.0;
    public var wrap_max:Null<Vec2>=null;
    public function getmax():Vec2{
        if(wrap_max==null){
            wrap_max=Vec2.get(maxx,maxy);
            wrap_max.zpp_inner._inuse=true;
            if(_immutable){
                wrap_max.zpp_inner._immutable=true;
            }
            else{
                wrap_max.zpp_inner._invalidate=mod_max;
            }
            wrap_max.zpp_inner._validate=dom_max;
        }
        return wrap_max;
    }
    public function dom_max():Void{
        validate();
        {
            wrap_max.zpp_inner.x=maxx;
            wrap_max.zpp_inner.y=maxy;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((wrap_max.zpp_inner.x!=wrap_max.zpp_inner.x));
                };
                if(!res)throw "assert("+"!assert_isNaN(wrap_max.zpp_inner.x)"+") :: "+("vec_set(in n: "+"wrap_max.zpp_inner."+",in x: "+"maxx"+",in y: "+"maxy"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((wrap_max.zpp_inner.y!=wrap_max.zpp_inner.y));
                };
                if(!res)throw "assert("+"!assert_isNaN(wrap_max.zpp_inner.y)"+") :: "+("vec_set(in n: "+"wrap_max.zpp_inner."+",in x: "+"maxx"+",in y: "+"maxy"+")");
                #end
            };
        };
    }
    public function mod_max(max:ZPP_Vec2):Void{
        if(max.x!=maxx||max.y!=maxy){
            {
                maxx=max.x;
                maxy=max.y;
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        !((maxx!=maxx));
                    };
                    if(!res)throw "assert("+"!assert_isNaN(maxx)"+") :: "+("vec_set(in n: "+"max"+",in x: "+"max.x"+",in y: "+"max.y"+")");
                    #end
                };
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        !((maxy!=maxy));
                    };
                    if(!res)throw "assert("+"!assert_isNaN(maxy)"+") :: "+("vec_set(in n: "+"max"+",in x: "+"max.x"+",in y: "+"max.y"+")");
                    #end
                };
            };
            invalidate();
        }
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function intersectX(x:ZPP_AABB):Bool{
        return!(x.minx>maxx||minx>x.maxx);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function intersectY(x:ZPP_AABB):Bool{
        return!(x.miny>maxy||miny>x.maxy);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function intersect(x:ZPP_AABB):Bool{
        return x.miny<=maxy&&miny<=x.maxy&&x.minx<=maxx&&minx<=x.maxx;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function combine(x:ZPP_AABB):Void{
        if(x.minx<minx)minx=x.minx;
        if(x.maxx>maxx)maxx=x.maxx;
        if(x.miny<miny)miny=x.miny;
        if(x.maxy>maxy)maxy=x.maxy;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function contains(x:ZPP_AABB):Bool{
        return x.minx>=minx&&x.miny>=miny&&x.maxx<=maxx&&x.maxy<=maxy;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function containsPoint(v:ZPP_Vec2):Bool{
        return v.x>=minx&&v.x<=maxx&&v.y>=miny&&v.y<=maxy;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function setCombine(a:ZPP_AABB,b:ZPP_AABB):Void{
        minx=if(a.minx<b.minx)a.minx else b.minx;
        miny=if(a.miny<b.miny)a.miny else b.miny;
        maxx=if(a.maxx>b.maxx)a.maxx else b.maxx;
        maxy=if(a.maxy>b.maxy)a.maxy else b.maxy;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function setExpand(a:ZPP_AABB,fatten:Float):Void{
        minx=a.minx-fatten;
        miny=a.miny-fatten;
        maxx=a.maxx+fatten;
        maxy=a.maxy+fatten;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function setExpandPoint(x:Float,y:Float):Void{
        if(x<minx)minx=x;
        if(x>maxx)maxx=x;
        if(y<miny)miny=y;
        if(y>maxy)maxy=y;
    }
    public function toString(){
        return "{ x: "+minx+" y: "+miny+" w: "+width()+" h: "+height()+" }";
    }
}
