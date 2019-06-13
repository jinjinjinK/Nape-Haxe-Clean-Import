package zpp_nape.phys;
import nape.geom.Vec2;
import nape.phys.FluidProperties;
import nape.shape.ShapeList;
import zpp_nape.geom.Vec2;
import zpp_nape.shape.Shape.ZPP_Shape;
import zpp_nape.util.Lists.ZNPList_ZPP_Shape;
#if nape_swc@:keep #end
class ZPP_FluidProperties{
    public var next:ZPP_FluidProperties=null;
    static public var zpp_pool:ZPP_FluidProperties=null;
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
    
    public var userData:Dynamic<Dynamic>=null;
    public var outer:FluidProperties=null;
    public function wrapper(){
        if(outer==null){
            outer=new FluidProperties();
            {
                var o=outer.zpp_inner;
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        o!=null;
                    };
                    if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_FluidProperties"+", in obj: "+"outer.zpp_inner"+")");
                    #end
                };
                o.free();
                o.next=ZPP_FluidProperties.zpp_pool;
                ZPP_FluidProperties.zpp_pool=o;
                #if NAPE_POOL_STATS ZPP_FluidProperties.POOL_CNT++;
                ZPP_FluidProperties.POOL_SUB++;
                #end
            };
            outer.zpp_inner=this;
        }
        return outer;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function free(){
        outer=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    public var shapes:ZNPList_ZPP_Shape=null;
    public var wrap_shapes:ShapeList=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function feature_cons(){
        shapes=new ZNPList_ZPP_Shape();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function addShape(shape:ZPP_Shape){
        shapes.add(shape);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function remShape(shape:ZPP_Shape){
        shapes.remove(shape);
    }
    public function copy(){
        var ret;
        {
            if(ZPP_FluidProperties.zpp_pool==null){
                ret=new ZPP_FluidProperties();
                #if NAPE_POOL_STATS ZPP_FluidProperties.POOL_TOT++;
                ZPP_FluidProperties.POOL_ADDNEW++;
                #end
            }
            else{
                ret=ZPP_FluidProperties.zpp_pool;
                ZPP_FluidProperties.zpp_pool=ret.next;
                ret.next=null;
                #if NAPE_POOL_STATS ZPP_FluidProperties.POOL_CNT--;
                ZPP_FluidProperties.POOL_ADD++;
                #end
            }
            ret.alloc();
        };
        ret.viscosity=viscosity;
        ret.density=density;
        return ret;
    }
    public function new(){
        feature_cons();
        density=viscosity=1;
        wrap_gravity=null;
        {
            gravityx=0;
            gravityy=0;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((gravityx!=gravityx));
                };
                if(!res)throw "assert("+"!assert_isNaN(gravityx)"+") :: "+("vec_set(in n: "+"gravity"+",in x: "+"0"+",in y: "+"0"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((gravityy!=gravityy));
                };
                if(!res)throw "assert("+"!assert_isNaN(gravityy)"+") :: "+("vec_set(in n: "+"gravity"+",in x: "+"0"+",in y: "+"0"+")");
                #end
            };
        };
    }
    public var viscosity:Float=0.0;
    public var density:Float=0.0;
    public var gravityx:Float=0.0;
    public var gravityy:Float=0.0;
    public var wrap_gravity:Vec2=null;
    private function gravity_invalidate(x:ZPP_Vec2){
        {
            gravityx=x.x;
            gravityy=x.y;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((gravityx!=gravityx));
                };
                if(!res)throw "assert("+"!assert_isNaN(gravityx)"+") :: "+("vec_set(in n: "+"gravity"+",in x: "+"x.x"+",in y: "+"x.y"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((gravityy!=gravityy));
                };
                if(!res)throw "assert("+"!assert_isNaN(gravityy)"+") :: "+("vec_set(in n: "+"gravity"+",in x: "+"x.x"+",in y: "+"x.y"+")");
                #end
            };
        };
        invalidate();
    }
    private function gravity_validate(){
        {
            wrap_gravity.zpp_inner.x=gravityx;
            wrap_gravity.zpp_inner.y=gravityy;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((wrap_gravity.zpp_inner.x!=wrap_gravity.zpp_inner.x));
                };
                if(!res)throw "assert("+"!assert_isNaN(wrap_gravity.zpp_inner.x)"+") :: "+("vec_set(in n: "+"wrap_gravity.zpp_inner."+",in x: "+"gravityx"+",in y: "+"gravityy"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((wrap_gravity.zpp_inner.y!=wrap_gravity.zpp_inner.y));
                };
                if(!res)throw "assert("+"!assert_isNaN(wrap_gravity.zpp_inner.y)"+") :: "+("vec_set(in n: "+"wrap_gravity.zpp_inner."+",in x: "+"gravityx"+",in y: "+"gravityy"+")");
                #end
            };
        };
    }
    public function getgravity(){
        wrap_gravity=Vec2.get(gravityx,gravityy);
        wrap_gravity.zpp_inner._inuse=true;
        wrap_gravity.zpp_inner._invalidate=gravity_invalidate;
        wrap_gravity.zpp_inner._validate=gravity_validate;
    }
    public function invalidate(){
        {
            var cx_ite=shapes.begin();
            while(cx_ite!=null){
                var shape=cx_ite.elem();
                shape.invalidate_fluidprops();
                cx_ite=cx_ite.next;
            }
        };
    }
}
