package nape.geom;
import nape.geom.AABB;
import nape.geom.Vec2;
import zpp_nape.Const.ZPP_Const;
import zpp_nape.geom.AABB;
import zpp_nape.geom.Ray;
import zpp_nape.geom.Vec2;
import zpp_nape.geom.VecMath.ZPP_VecMath;
import zpp_nape.util.Math;
/**
 * Parametrically defined ray used in ray casting functions.
 */
@:final#if nape_swc@:keep #end
class Ray{
    /**
     * @private
     */
    public var zpp_inner:ZPP_Ray=null;
    /**
     * Dynamic object for user to store additional data.
     * <br/><br/>
     * This object cannot be set, only its dynamically created
     * properties may be set. In AS3 the type of this property is &#42
     * <br/><br/>
     * This object will be lazily constructed so that until accessed
     * for the first time, will be null internally.
     *
     * @default {}
     */
    #if nape_swc@:isVar #end
    public var userData(get_userData,never):Dynamic<Dynamic>;
    inline function get_userData():Dynamic<Dynamic>{
        if(zpp_inner.userData==null){
            zpp_inner.userData=cast{};
        }
        return zpp_inner.userData;
    }
    /**
     * Origin of ray.
     * <br/><br/>
     * This property can be set, and is equivalent to performing:
     * <code>ray.origin.set(newOrigin)</code>
     */
    #if nape_swc@:isVar #end
    public var origin(get_origin,set_origin):Vec2;
    inline function get_origin():Vec2{
        return zpp_inner.origin;
    }
    inline function set_origin(origin:Vec2):Vec2{
        {
            {
                #if(!NAPE_RELEASE_BUILD)
                if(origin!=null&&origin.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
                #end
            };
            #if(!NAPE_RELEASE_BUILD)
            if(origin==null){
                throw "Error: Ray::origin cannot be null";
            }
            #end
            zpp_inner.origin.set(origin);
        }
        return get_origin();
    }
    /**
     * Direction of ray.
     * <br/><br/>
     * This property can be set, and is equivalent to performing:
     * <code>ray.direction.set(newDirection)</code> with the additional
     * constraint that the input direction must not be degenerate.
     * <br/><br/>
     * This direction vector need not be normalised.
     */
    #if nape_swc@:isVar #end
    public var direction(get_direction,set_direction):Vec2;
    inline function get_direction():Vec2{
        return zpp_inner.direction;
    }
    inline function set_direction(direction:Vec2):Vec2{
        {
            {
                #if(!NAPE_RELEASE_BUILD)
                if(direction!=null&&direction.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
                #end
            };
            #if(!NAPE_RELEASE_BUILD)
            if(direction==null){
                throw "Error: Ray::direction cannot be null";
            }
            #end
            zpp_inner.direction.set(direction);
            zpp_inner.invalidate_dir();
        }
        return get_direction();
    }
    /**
     * The maximum distance for ray to be queried.
     * <br/><br/>
     * When used in ray test functions, no search will extend beyond this
     * distance.
     * <br/><br/>
     * This value represents a true distance, even if direction vector is
     * not normalised. This value may be equal to infinity.
     *
     * @default infinity
     */
    #if nape_swc@:isVar #end
    public var maxDistance(get_maxDistance,set_maxDistance):Float;
    inline function get_maxDistance():Float{
        return zpp_inner.maxdist;
    }
    inline function set_maxDistance(maxDistance:Float):Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if((maxDistance!=maxDistance)){
                throw "Error: maxDistance cannot be NaN";
            }
            #end
            zpp_inner.maxdist=maxDistance;
        }
        return get_maxDistance();
    }
    /**
     * Compute bounding box of ray.
     * <br/><br/>
     * This function will take into account the maxDistance property of this ray.
     * <br/>
     * The return AABB may have in the general case infinite values :)
     *
     * @return An AABB representing bounding box of ray.
     */
    public function aabb():AABB{
        return zpp_inner.rayAABB().wrapper();
    }
    /**
     * Compute point along ray at given distance.
     * <br/><br/>
     * Even if ray direction is not normalised, this value still repersents
     * a true distance. The distance may also be negative.
     * <br/><br/>
     * The Vec2 returned will be allocated from the global object pool.
     *
     * @param distance The distance along ray to compute point for.
     * @param weak If true then a weakly allocated Vec2 will be returned
     *             which will be automatically released to global object
     *             pool when used as argument to another Nape function.
     *             (default false)
     * @return Vec2 representing point at given distance along ray.
     */
    public function at(distance:Float,weak:Bool=false):Vec2{
        zpp_inner.validate_dir();
        return Vec2.get(origin.x+(distance*zpp_inner.dirx),origin.y+(distance*zpp_inner.diry),weak);
    }
    /**
     * Construct new Ray.
     *
     * @param origin Origin of ray.
     * @param direction Direction of ray.
     * @throws # If origin or direction are null, or disposed of.
     * @throws # If direction is degenerate.
     */
    #if flib@:keep function flibopts_0(){}
    #end
    public function new(origin:Vec2,direction:Vec2){
        {
            #if(!NAPE_RELEASE_BUILD)
            if(origin!=null&&origin.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
            #end
        };
        {
            #if(!NAPE_RELEASE_BUILD)
            if(direction!=null&&direction.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
            #end
        };
        zpp_inner=new ZPP_Ray();
        this.origin=origin;
        this.direction=direction;
        zpp_inner.maxdist=ZPP_Const.POSINF();
    }
    /**
     * Produce a copy of this ray.
     * <br/><br/>
     * All ray properties will be copied including maxDistance.
     *
     * @return The copy of this Ray.
     */
    public function copy(){
        var ret=new Ray(origin,direction);
        ret.maxDistance=maxDistance;
        return ret;
    }
    /**
     * Create ray representing a line segment.
     * <br/><br/>
     * This function will a ray who's origin is the start point
     * and who's direction is towards the end point with the
     * maxDistance property appropriately set to not extend
     * beyond the end point.
     *
     * @param start Start point of line segment
     * @param end End point of line segment
     * @return A Ray representing this line segment.
     * @throws # If start or end are either null or disposed of.
     * @throws # If start and end point are equal so that the
     *         direction of the ray would be degenerate.
     */
    public static function fromSegment(start:Vec2,end:Vec2){
        {
            #if(!NAPE_RELEASE_BUILD)
            if(start!=null&&start.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
            #end
        };
        {
            #if(!NAPE_RELEASE_BUILD)
            if(end!=null&&end.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
            #end
        };
        #if(!NAPE_RELEASE_BUILD)
        if(start==null){
            throw "Error: Ray::fromSegment::start is null";
        }
        if(end==null){
            throw "Error: Ray::fromSegment::end is null";
        }
        #end
        var dir=end.sub(start,true);
        var ret=new Ray(start,dir);
        ret.maxDistance=Math.sqrt(ZPP_VecMath.vec_dsq(start.x,start.y,end.x,end.y));
        ({
            if(({
                start.zpp_inner.weak;
            })){
                start.dispose();
                true;
            }
            else{
                false;
            }
        });
        ({
            if(({
                end.zpp_inner.weak;
            })){
                end.dispose();
                true;
            }
            else{
                false;
            }
        });
        return ret;
    }
}
