package zpp_nape.dynamics;
import nape.dynamics.InteractionFilter;
import nape.shape.ShapeList;
import zpp_nape.shape.Shape.ZPP_Shape;
import zpp_nape.util.Lists.ZNPList_ZPP_Shape;
#if nape_swc@:keep #end
class ZPP_InteractionFilter{
    public var next:ZPP_InteractionFilter=null;
    static public var zpp_pool:ZPP_InteractionFilter=null;
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
    public var outer:InteractionFilter=null;
    public function wrapper(){
        if(outer==null){
            outer=new InteractionFilter();
            {
                var o=outer.zpp_inner;
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        o!=null;
                    };
                    if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_InteractionFilter"+", in obj: "+"outer.zpp_inner"+")");
                    #end
                };
                o.free();
                o.next=ZPP_InteractionFilter.zpp_pool;
                ZPP_InteractionFilter.zpp_pool=o;
                #if NAPE_POOL_STATS ZPP_InteractionFilter.POOL_CNT++;
                ZPP_InteractionFilter.POOL_SUB++;
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
    public function new(){
        feature_cons();
        collisionGroup=sensorGroup=fluidGroup=1;
        collisionMask=sensorMask=fluidMask=-1;
    }
    public function copy(){
        var ret;
        {
            if(ZPP_InteractionFilter.zpp_pool==null){
                ret=new ZPP_InteractionFilter();
                #if NAPE_POOL_STATS ZPP_InteractionFilter.POOL_TOT++;
                ZPP_InteractionFilter.POOL_ADDNEW++;
                #end
            }
            else{
                ret=ZPP_InteractionFilter.zpp_pool;
                ZPP_InteractionFilter.zpp_pool=ret.next;
                ret.next=null;
                #if NAPE_POOL_STATS ZPP_InteractionFilter.POOL_CNT--;
                ZPP_InteractionFilter.POOL_ADD++;
                #end
            }
            ret.alloc();
        };
        ret.collisionGroup=collisionGroup;
        ret.collisionMask=collisionMask;
        ret.sensorGroup=sensorGroup;
        ret.sensorMask=sensorMask;
        ret.fluidGroup=fluidGroup;
        ret.fluidMask=fluidMask;
        return ret;
    }
    public var collisionGroup:Int=0;
    public var collisionMask:Int=0;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function shouldCollide(x:ZPP_InteractionFilter){
        return(collisionMask&x.collisionGroup)!=0&&(x.collisionMask&collisionGroup)!=0;
    }
    public var sensorGroup:Int=0;
    public var sensorMask:Int=0;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function shouldSense(x:ZPP_InteractionFilter){
        return(sensorMask&x.sensorGroup)!=0&&(x.sensorMask&sensorGroup)!=0;
    }
    public var fluidGroup:Int=0;
    public var fluidMask:Int=0;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function shouldFlow(x:ZPP_InteractionFilter){
        return(fluidMask&x.fluidGroup)!=0&&(x.fluidMask&fluidGroup)!=0;
    }
    public function invalidate(){
        {
            var cx_ite=shapes.begin();
            while(cx_ite!=null){
                var s=cx_ite.elem();
                s.invalidate_filter();
                cx_ite=cx_ite.next;
            }
        };
    }
}
