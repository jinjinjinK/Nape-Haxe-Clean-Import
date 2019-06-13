package nape.geom;
import nape.geom.Vec2;
import nape.shape.Shape;
import zpp_nape.geom.ConvexRayResult.ZPP_ConvexRayResult;
import zpp_nape.geom.Vec2;
import zpp_nape.shape.Shape;
/**
 * Class representing the results of a convex cast operation.
 * <br/><br/>
 * These objects are allocated from an object pool and can
 * be released back to that pool by calling its dispose method.
 */
@:final#if nape_swc@:keep #end
class ConvexResult{
    /**
     * @private
     */
    public var zpp_inner:ZPP_ConvexRayResult=null;
    /**
     * The normal of the surface at collision.
     */
    #if nape_swc@:isVar #end
    public var normal(get_normal,never):Vec2;
    inline function get_normal():Vec2{
        #if(!NAPE_RELEASE_BUILD)
        zpp_inner.disposed();
        #end
        return zpp_inner.normal;
    }
    /**
     * The position of the collision.
     */
    #if nape_swc@:isVar #end
    public var position(get_position,never):Vec2;
    inline function get_position():Vec2{
        #if(!NAPE_RELEASE_BUILD)
        zpp_inner.disposed();
        #end
        return zpp_inner.position;
    }
    /**
     * The time of impact to the collision
     */
    #if nape_swc@:isVar #end
    public var toi(get_toi,never):Float;
    inline function get_toi():Float{
        #if(!NAPE_RELEASE_BUILD)
        zpp_inner.disposed();
        #end
        return zpp_inner.toiDistance;
    }
    /**
     * The shape which was collided against.
     */
    #if nape_swc@:isVar #end
    public var shape(get_shape,never):Shape;
    inline function get_shape():Shape{
        #if(!NAPE_RELEASE_BUILD)
        zpp_inner.disposed();
        #end
        return zpp_inner.shape;
    }
    /**
     * @private
     */
    #if flib@:keep function flibopts_0(){}
    #end
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_ConvexRayResult.internal)throw "Error: ConvexResult cannot be instantiated derp!";
        #end
    }
    /**
     * Release ConvexResult object to pool.
     */
    public#if NAPE_NO_INLINE#else inline #end
    function dispose(){
        #if(!NAPE_RELEASE_BUILD)
        zpp_inner.disposed();
        #end
        zpp_inner.free();
    }
    /**
     * @private
     */
    @:keep public function toString(){
        #if(!NAPE_RELEASE_BUILD)
        zpp_inner.disposed();
        #end
        return "{ shape: "+shape+" toi: "+toi+" }";
    }
}
