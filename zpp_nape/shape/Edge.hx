package zpp_nape.shape;
import nape.geom.Vec2;
import nape.shape.Edge;
import zpp_nape.geom.Vec2;
import zpp_nape.shape.Polygon.ZPP_Polygon;
#if nape_swc@:keep #end
class ZPP_Edge{
    public var next:ZPP_Edge=null;
    static public var zpp_pool:ZPP_Edge=null;
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
    function free(){
        polygon=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    public var polygon:ZPP_Polygon=null;
    static public var internal:Bool=false;
    public var outer:Edge=null;
    public function wrapper(){
        if(outer==null){
            internal=true;
            outer=new Edge();
            internal=false;
            outer.zpp_inner=this;
        }
        return outer;
    }
    public var lnormx:Float=0.0;
    public var lnormy:Float=0.0;
    public var wrap_lnorm:Vec2=null;
    public var gnormx:Float=0.0;
    public var gnormy:Float=0.0;
    public var wrap_gnorm:Vec2=null;
    public var length:Float=0.0;
    public var lprojection:Float=0.0;
    public var gprojection:Float=0.0;
    public var lp0:ZPP_Vec2=null;
    public var gp0:ZPP_Vec2=null;
    public var lp1:ZPP_Vec2=null;
    public var gp1:ZPP_Vec2=null;
    public var tp0:Float=0.0;
    public var tp1:Float=0.0;
    private function lnorm_validate(){
        #if(!NAPE_RELEASE_BUILD)
        if(polygon==null)throw "Error: Edge not currently in use";
        #end
        polygon.validate_laxi();
        {
            wrap_lnorm.zpp_inner.x=lnormx;
            wrap_lnorm.zpp_inner.y=lnormy;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((wrap_lnorm.zpp_inner.x!=wrap_lnorm.zpp_inner.x));
                };
                if(!res)throw "assert("+"!assert_isNaN(wrap_lnorm.zpp_inner.x)"+") :: "+("vec_set(in n: "+"wrap_lnorm.zpp_inner."+",in x: "+"lnormx"+",in y: "+"lnormy"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((wrap_lnorm.zpp_inner.y!=wrap_lnorm.zpp_inner.y));
                };
                if(!res)throw "assert("+"!assert_isNaN(wrap_lnorm.zpp_inner.y)"+") :: "+("vec_set(in n: "+"wrap_lnorm.zpp_inner."+",in x: "+"lnormx"+",in y: "+"lnormy"+")");
                #end
            };
        };
    }
    private function gnorm_validate(){
        #if(!NAPE_RELEASE_BUILD)
        if(polygon==null)throw "Error: Edge not currently in use";
        if(polygon.body==null)throw "Error: Edge worldNormal only makes sense if the parent Polygon is contained within a rigid body";
        #end
        polygon.validate_gaxi();
        {
            wrap_gnorm.zpp_inner.x=gnormx;
            wrap_gnorm.zpp_inner.y=gnormy;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((wrap_gnorm.zpp_inner.x!=wrap_gnorm.zpp_inner.x));
                };
                if(!res)throw "assert("+"!assert_isNaN(wrap_gnorm.zpp_inner.x)"+") :: "+("vec_set(in n: "+"wrap_gnorm.zpp_inner."+",in x: "+"gnormx"+",in y: "+"gnormy"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((wrap_gnorm.zpp_inner.y!=wrap_gnorm.zpp_inner.y));
                };
                if(!res)throw "assert("+"!assert_isNaN(wrap_gnorm.zpp_inner.y)"+") :: "+("vec_set(in n: "+"wrap_gnorm.zpp_inner."+",in x: "+"gnormx"+",in y: "+"gnormy"+")");
                #end
            };
        };
    }
    public function getlnorm(){
        wrap_lnorm=Vec2.get(lnormx,lnormy);
        wrap_lnorm.zpp_inner._immutable=true;
        wrap_lnorm.zpp_inner._validate=lnorm_validate;
    }
    public function getgnorm(){
        wrap_gnorm=Vec2.get(gnormx,gnormy);
        wrap_gnorm.zpp_inner._immutable=true;
        wrap_gnorm.zpp_inner._validate=gnorm_validate;
    }
    public function new(){
        {
            lnormx=0;
            lnormy=0;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((lnormx!=lnormx));
                };
                if(!res)throw "assert("+"!assert_isNaN(lnormx)"+") :: "+("vec_set(in n: "+"lnorm"+",in x: "+"0"+",in y: "+"0"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((lnormy!=lnormy));
                };
                if(!res)throw "assert("+"!assert_isNaN(lnormy)"+") :: "+("vec_set(in n: "+"lnorm"+",in x: "+"0"+",in y: "+"0"+")");
                #end
            };
        };
        {
            gnormx=0;
            gnormy=0;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((gnormx!=gnormx));
                };
                if(!res)throw "assert("+"!assert_isNaN(gnormx)"+") :: "+("vec_set(in n: "+"gnorm"+",in x: "+"0"+",in y: "+"0"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((gnormy!=gnormy));
                };
                if(!res)throw "assert("+"!assert_isNaN(gnormy)"+") :: "+("vec_set(in n: "+"gnorm"+",in x: "+"0"+",in y: "+"0"+")");
                #end
            };
        };
        length=0;
        lprojection=0;
        gprojection=0;
    }
}
