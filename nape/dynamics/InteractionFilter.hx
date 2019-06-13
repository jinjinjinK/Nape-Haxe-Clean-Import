package nape.dynamics;
import nape.shape.ShapeList;
import zpp_nape.dynamics.InteractionFilter;
import zpp_nape.util.Lists.ZPP_ShapeList;
/**
 * InteractionFilter provides bit flags for low-level filtering of interactions.
 * <br/><br/>
 * For a given interaction type, two Shapes will be permitted to interact only if
 * <code>(shape1.group & shape2.mask) != 0 && (shape2.group & shape1.mask) != 0</code>
 * <br/><br/>
 * There are 32 real groups corresponding to a set bit in the group/mask fields. For instance
 * a group value of 0x120 corresponds to the 'real' groups 5 and 8 as <code>0x120 = (1<<5) | (1<<8)</code>
 * <br/><br/>
 * Nape provides group/mask for each interaction type. The actual precedence of interactions
 * is further defined simply as: Sensor > Fluid > Collision.
 * <br/>
 * Two static bodies can never interact, and with the exception of sensor interaction, at least one
 * of the two bodies must be dynamic.
 * <br/>
 * Sensor interactions have the highest precedence, followed by fluid and then collisions.
 * Sensor interaction is permitted only if one of the shapes is sensorEnabled, whilst fluid
 * is permitted only if one of the shapes is fluidEnabled.
 * <pre>
 * if ((shapeA.sensorEnabled || shapeB.sensorEnabled) && shapeA.filter.shouldSense(shapeB.filter)) {
 *     SENSOR INTERACTION!!
 * }
 * else if (bodyA.isDynamic() || bodyB.isDynamic()) {
 *     if ((shapeA.fluidEnabled || shapeB.fluidEnabled) && shapeA.filter.shouldFlow(shapeB.filter)) {
 *         FLUID INTERACTION!!
 *     }
 *     else if (shapeA.filter.shouldCollide(shapeB.filter)) {
 *         COLLISION INTERACTION!!
 *     }
 * }
 * </pre>
 */
@:final#if nape_swc@:keep #end
class InteractionFilter{
    /**
     * @private
     */
    public var zpp_inner:ZPP_InteractionFilter=null;
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
     * Set of all active shapes using this object.
     * <br/><br/>
     * Activeness of a shape in the sense that the Shape's Body is inside of a Space.
     * <br/><br/>
     * This list is immutable.
     */
    #if nape_swc@:isVar #end
    public var shapes(get_shapes,never):ShapeList;
    inline function get_shapes():ShapeList{
        if(zpp_inner.wrap_shapes==null)zpp_inner.wrap_shapes=ZPP_ShapeList.get(zpp_inner.shapes,true);
        return zpp_inner.wrap_shapes;
    }
    /**
     * Group bitfield for Collision type interactions.
     * @default 1
     */
    #if nape_swc@:isVar #end
    public var collisionGroup(get_collisionGroup,set_collisionGroup):Int;
    inline function get_collisionGroup():Int{
        return zpp_inner.collisionGroup;
    }
    inline function set_collisionGroup(collisionGroup:Int):Int{
        {
            if(this.collisionGroup!=collisionGroup){
                zpp_inner.collisionGroup=collisionGroup;
                zpp_inner.invalidate();
            }
        }
        return get_collisionGroup();
    }
    /**
     * Mask bitfield for Collision type interactions.
     * @default -1 (all bits set)
     */
    #if nape_swc@:isVar #end
    public var collisionMask(get_collisionMask,set_collisionMask):Int;
    inline function get_collisionMask():Int{
        return zpp_inner.collisionMask;
    }
    inline function set_collisionMask(collisionMask:Int):Int{
        {
            if(this.collisionMask!=collisionMask){
                zpp_inner.collisionMask=collisionMask;
                zpp_inner.invalidate();
            }
        }
        return get_collisionMask();
    }
    /**
     * Group bitfield for Sensor type interactions.
     * @default 1
     */
    #if nape_swc@:isVar #end
    public var sensorGroup(get_sensorGroup,set_sensorGroup):Int;
    inline function get_sensorGroup():Int{
        return zpp_inner.sensorGroup;
    }
    inline function set_sensorGroup(sensorGroup:Int):Int{
        {
            if(this.sensorGroup!=sensorGroup){
                zpp_inner.sensorGroup=sensorGroup;
                zpp_inner.invalidate();
            }
        }
        return get_sensorGroup();
    }
    /**
     * Mask bitfield for Sensor type interactions.
     * @default -1 (all bits set)
     */
    #if nape_swc@:isVar #end
    public var sensorMask(get_sensorMask,set_sensorMask):Int;
    inline function get_sensorMask():Int{
        return zpp_inner.sensorMask;
    }
    inline function set_sensorMask(sensorMask:Int):Int{
        {
            if(this.sensorMask!=sensorMask){
                zpp_inner.sensorMask=sensorMask;
                zpp_inner.invalidate();
            }
        }
        return get_sensorMask();
    }
    /**
     * Group bitfield for Fluid type interactions.
     * @default 1
     */
    #if nape_swc@:isVar #end
    public var fluidGroup(get_fluidGroup,set_fluidGroup):Int;
    inline function get_fluidGroup():Int{
        return zpp_inner.fluidGroup;
    }
    inline function set_fluidGroup(fluidGroup:Int):Int{
        {
            if(this.fluidGroup!=fluidGroup){
                zpp_inner.fluidGroup=fluidGroup;
                zpp_inner.invalidate();
            }
        }
        return get_fluidGroup();
    }
    /**
     * Mask bitfield for Fluid type interactions.
     * @default -1 (all bits set)
     */
    #if nape_swc@:isVar #end
    public var fluidMask(get_fluidMask,set_fluidMask):Int;
    inline function get_fluidMask():Int{
        return zpp_inner.fluidMask;
    }
    inline function set_fluidMask(fluidMask:Int):Int{
        {
            if(this.fluidMask!=fluidMask){
                zpp_inner.fluidMask=fluidMask;
                zpp_inner.invalidate();
            }
        }
        return get_fluidMask();
    }
    /**
     * Construct a new InteractionFilter.
     *
     * @param collisionGroup The Group bitfield for Collision interactions. (default 1)
     * @param collisionMask  The Mask bitfield for Collision interactions. (default -1)
     * @param sensorGroup    The Group bitfield for Sensor interactions. (default 1)
     * @param sensorMask     The Mask bitfield for Sensor interactions. (default -1)
     * @param fluidGroup     The Group bitfield for Fluid interactions. (default 1)
     * @param fluidMask      The Mask bitfield for Fluid interactions. (default -1)
     * @return The newly constructed InteractionFilter.
     */
    #if flib@:keep function flibopts_6(){}
    #end
    public function new(collisionGroup=1,collisionMask=-1,sensorGroup=1,sensorMask=-1,fluidGroup=1,fluidMask=-1){
        {
            if(ZPP_InteractionFilter.zpp_pool==null){
                zpp_inner=new ZPP_InteractionFilter();
                #if NAPE_POOL_STATS ZPP_InteractionFilter.POOL_TOT++;
                ZPP_InteractionFilter.POOL_ADDNEW++;
                #end
            }
            else{
                zpp_inner=ZPP_InteractionFilter.zpp_pool;
                ZPP_InteractionFilter.zpp_pool=zpp_inner.next;
                zpp_inner.next=null;
                #if NAPE_POOL_STATS ZPP_InteractionFilter.POOL_CNT--;
                ZPP_InteractionFilter.POOL_ADD++;
                #end
            }
            zpp_inner.alloc();
        };
        zpp_inner.outer=this;
        this.collisionGroup=collisionGroup;
        this.collisionMask=collisionMask;
        this.sensorGroup=sensorGroup;
        this.sensorMask=sensorMask;
        this.fluidGroup=fluidGroup;
        this.fluidMask=fluidMask;
    }
    /**
     * Determine if objects are permitted to collide based on InteractionFilters
     * <br/><br/>
     * A collision type interaction can occur only if this returns True.
     *
     * @param filter The filter to evaluate possibility of collision with.
     * @return True, if based on interaction filters only the two objects would be able to collide.
     * @throws # If filter is null.
     */
    #if nape_swc@:keep #end
    public function shouldCollide(filter:InteractionFilter){
        #if(!NAPE_RELEASE_BUILD)
        if(filter==null)throw "Error: filter argument cannot be null for shouldCollide";
        #end
        return zpp_inner.shouldCollide(filter.zpp_inner);
    }
    /**
     * Determine if objects are permitted to sense based on InteractionFilters
     * <br/><br/>
     * A sensor type interaction can occur only if this returns True.
     *
     * @param filter The filter to evaluate possibility of sensor with.
     * @return True, if based on interaction filters only the two objects would be able to sense.
     * @throws # If filter is null.
     */
    #if nape_swc@:keep #end
    public function shouldSense(filter:InteractionFilter){
        #if(!NAPE_RELEASE_BUILD)
        if(filter==null)throw "Error: filter argument cannot be null for shouldSense";
        #end
        return zpp_inner.shouldSense(filter.zpp_inner);
    }
    /**
     * Determine if objects are permitted to interact as fluids based on InteractionFilters
     * <br/><br/>
     * A fluid type interaction can occur only if this returns True.
     *
     * @param filter The filter to evaluate possibility of fluid with.
     * @return True, if based on interaction filters only the two objects would be able to interact as fluids.
     * @throws # If filter is null.
     */
    #if nape_swc@:keep #end
    public function shouldFlow(filter:InteractionFilter){
        #if(!NAPE_RELEASE_BUILD)
        if(filter==null)throw "Error: filter argument cannot be null for shouldFlow";
        #end
        return zpp_inner.shouldFlow(filter.zpp_inner);
    }
    /**
     * Produce a copy of this InteractionFilter
     *
     * @return The copy of this filter.
     */
    #if nape_swc@:keep #end
    public function copy(){
        return new InteractionFilter(collisionGroup,collisionMask,sensorGroup,sensorMask,fluidGroup,fluidMask);
    }
    /**
     * @private
     */
    #if nape_swc@:keep #end
    public function toString(){
        return "{ collision: "+StringTools.hex(collisionGroup,8)+"~"+StringTools.hex(collisionMask,8)+" sensor: "+StringTools.hex(sensorGroup,8)+"~"+StringTools.hex(sensorMask,8)+" fluid: "+StringTools.hex(fluidGroup,8)+"~"+StringTools.hex(fluidMask,8)+" }";
    }
}
