package zpp_nape.geom;
import nape.geom.ConvexResult;
import nape.geom.RayResult;
import nape.geom.Vec2;
import nape.shape.Shape;
import zpp_nape.geom.Vec2;
import zpp_nape.shape.Shape;
#if nape_swc@:keep #end
class ZPP_ConvexRayResult{
    public var normal:Vec2=null;
    public var shape:Shape=null;
    static var convexPool:ZPP_ConvexRayResult=null;
    public var convex:ConvexResult=null;
    public var position:Vec2=null;
    static var rayPool:ZPP_ConvexRayResult=null;
    public var ray:RayResult=null;
    public var inner:Bool=false;
    public var next:ZPP_ConvexRayResult=null;
    public var toiDistance:Float=0.0;
    public function new(){}
    public static var internal=false;
    public static function getRay(normal:Vec2,time:Float,inner:Bool,shape:Shape){
        var ret:RayResult;
        if(rayPool==null){
            internal=true;
            ret=new RayResult();
            ret.zpp_inner=new ZPP_ConvexRayResult();
            ret.zpp_inner.ray=ret;
            internal=false;
        }
        else{
            ret=rayPool.ray;
            rayPool=rayPool.next;
            ret.zpp_inner.next=null;
        }
        var zinner=ret.zpp_inner;
        zinner.normal=normal;
        normal.zpp_inner._immutable=true;
        zinner.toiDistance=time;
        zinner.inner=inner;
        zinner.shape=shape;
        return ret;
    }
    public static function getConvex(normal:Vec2,position:Vec2,toiDistance:Float,shape:Shape){
        var ret:ConvexResult;
        if(convexPool==null){
            internal=true;
            ret=new ConvexResult();
            ret.zpp_inner=new ZPP_ConvexRayResult();
            ret.zpp_inner.convex=ret;
            internal=false;
        }
        else{
            ret=convexPool.convex;
            convexPool=convexPool.next;
            ret.zpp_inner.next=null;
        }
        var inner=ret.zpp_inner;
        inner.normal=normal;
        inner.position=position;
        normal.zpp_inner._immutable=true;
        position.zpp_inner._immutable=true;
        inner.toiDistance=toiDistance;
        inner.shape=shape;
        return ret;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function disposed(){
        #if(!NAPE_RELEASE_BUILD)
        if(next!=null)throw "Error: This object has been disposed of and cannot be used";
        #end
    }
    public function free(){
        normal.zpp_inner._immutable=false;
        normal.dispose();
        if(position!=null){
            position.zpp_inner._immutable=false;
            position.dispose();
        }
        shape=null;
        toiDistance=0.0;
        if(convex!=null){
            next=convexPool;
            convexPool=this;
        }
        else{
            next=rayPool;
            rayPool=this;
        }
    }
}
