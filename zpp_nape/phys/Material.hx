package zpp_nape.phys;
import nape.phys.Material;
import nape.shape.ShapeList;
import zpp_nape.shape.Shape.ZPP_Shape;
import zpp_nape.util.Lists.ZNPList_ZPP_Shape;
#if nape_swc@:keep #end
class ZPP_Material{
    public var next:ZPP_Material=null;
    static public var zpp_pool:ZPP_Material=null;
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
    public var outer:Material=null;
    public function wrapper(){
        if(outer==null){
            outer=new Material();
            {
                var o=outer.zpp_inner;
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        o!=null;
                    };
                    if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Material"+", in obj: "+"outer.zpp_inner"+")");
                    #end
                };
                o.free();
                o.next=ZPP_Material.zpp_pool;
                ZPP_Material.zpp_pool=o;
                #if NAPE_POOL_STATS ZPP_Material.POOL_CNT++;
                ZPP_Material.POOL_SUB++;
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
    public var dynamicFriction:Float=0.0;
    public var staticFriction:Float=0.0;
    public var density:Float=0.0;
    public var elasticity:Float=0.0;
    public var rollingFriction:Float=0.0;
    public function new(){
        feature_cons();
        elasticity=0;
        dynamicFriction=1;
        staticFriction=2;
        density=0.001;
        rollingFriction=0.01;
    }
    public function copy(){
        var ret=new ZPP_Material();
        ret.dynamicFriction=dynamicFriction;
        ret.staticFriction=staticFriction;
        ret.density=density;
        ret.elasticity=elasticity;
        ret.rollingFriction=rollingFriction;
        return ret;
    }
    public function set(x:ZPP_Material){
        dynamicFriction=x.dynamicFriction;
        staticFriction=x.staticFriction;
        density=x.density;
        elasticity=x.elasticity;
        rollingFriction=x.rollingFriction;
    }
     public static var WAKE=1;
     public static var PROPS=2;
     public static var ANGDRAG=4;
     public static var ARBITERS=8;
    public function invalidate(x:Int){
        {
            var cx_ite=shapes.begin();
            while(cx_ite!=null){
                var s=cx_ite.elem();
                s.invalidate_material(x);
                cx_ite=cx_ite.next;
            }
        };
    }
}
