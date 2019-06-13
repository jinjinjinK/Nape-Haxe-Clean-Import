package nape.dynamics;
import nape.callbacks.PreFlag;
import nape.dynamics.ArbiterType;
import nape.dynamics.CollisionArbiter;
import nape.dynamics.FluidArbiter;
import nape.geom.Vec3;
import nape.phys.Body;
import nape.shape.Shape;
import zpp_nape.dynamics.Arbiter;
import zpp_nape.geom.Vec3;
import zpp_nape.phys.Body;
import zpp_nape.shape.Shape;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Arbiter representing the state of an interaction between two Bodys.
 * <br/><br/>
 * These objects are automatically reused, and you should not keep your own
 * references to them.
 */
#if nape_swc@:keep #end
class Arbiter{
    /**
     * @private
     */
    public var zpp_inner:ZPP_Arbiter=null;
    /**
     * Flag representing arbiter sleep state.
     * <br/><br/>
     * When true, this arbiter is sleeping.
     */
    #if nape_swc@:isVar #end
    public var isSleeping(get_isSleeping,never):Bool;
    inline function get_isSleeping():Bool{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        return zpp_inner.sleeping;
    }
    /**
     * The type of this Arbiter.
     */
    #if nape_swc@:isVar #end
    public var type(get_type,never):ArbiterType;
    inline function get_type():ArbiterType{
        return ZPP_Arbiter.types[zpp_inner.type];
    }
    /**
     * Equivalent to: <code>arb.type == ArbiterType.COLLISION</code>
     * </br><br/>
     *
     * @return True if this Arbiter is a Collision type arbiter.
     */
    #if nape_swc@:keep #end
    public#if NAPE_NO_INLINE#else inline #end
    function isCollisionArbiter(){
        return zpp_inner.type==ZPP_Arbiter.COL;
    }
    /**
     * Equivalent to: <code>arb.type == ArbiterType.FLUID</code>
     * </br><br/>
     *
     * @return True if this Arbiter is a Fluid type arbiter.
     */
    #if nape_swc@:keep #end
    public#if NAPE_NO_INLINE#else inline #end
    function isFluidArbiter(){
        return zpp_inner.type==ZPP_Arbiter.FLUID;
    }
    /**
     * Equivalent to: <code>arb.type == ArbiterType.SENSOR</code>
     * </br><br/>
     *
     * @return True if this Arbiter is a Sensor type arbiter.
     */
    #if nape_swc@:keep #end
    public#if NAPE_NO_INLINE#else inline #end
    function isSensorArbiter(){
        return zpp_inner.type==ZPP_Arbiter.SENSOR;
    }
    /**
     * Fast equivalent to casting this object to a CollisionArbiter.
     * <br/><br/>
     * This value is null when this arbiter is not a collision type.
     */
    #if nape_swc@:isVar #end
    public var collisionArbiter(get_collisionArbiter,never):Null<CollisionArbiter>;
    inline function get_collisionArbiter():Null<CollisionArbiter>{
        return if(isCollisionArbiter())zpp_inner.colarb.outer_zn else null;
    }
    /**
     * Fast equivalent to casting this object to a FluidArbiter.
     * <br/><br/>
     * This value is null when this arbiter is not a fluid type.
     */
    #if nape_swc@:isVar #end
    public var fluidArbiter(get_fluidArbiter,never):Null<FluidArbiter>;
    inline function get_fluidArbiter():Null<FluidArbiter>{
        return if(isFluidArbiter())zpp_inner.fluidarb.outer_zn else null;
    }
    /**
     * The first shape in Arbiter interaction.
     * <br/><br/>
     * It will always be the case that <code>arb.shape1.id < arb.shape2.id</code>
     */
    #if nape_swc@:isVar #end
    public var shape1(get_shape1,never):Shape;
    inline function get_shape1():Shape{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        return(zpp_inner.ws1.id>zpp_inner.ws2.id)?zpp_inner.ws2.outer:zpp_inner.ws1.outer;
    }
    /**
     * The second shape in Arbiter interaction.
     * <br/><br/>
     * It will always be the case that <code>arb.shape1.id < arb.shape2.id</code>
     */
    #if nape_swc@:isVar #end
    public var shape2(get_shape2,never):Shape;
    inline function get_shape2():Shape{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        return(zpp_inner.ws1.id>zpp_inner.ws2.id)?zpp_inner.ws1.outer:zpp_inner.ws2.outer;
    }
    /**
     * The first body in Arbiter interaction.
     * <br/><br/>
     * It will always be the case that <code>arb.shape1.body == arb.body1</code>
     */
    #if nape_swc@:isVar #end
    public var body1(get_body1,never):Body;
    inline function get_body1():Body{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        return(zpp_inner.ws1.id>zpp_inner.ws2.id)?zpp_inner.b2.outer:zpp_inner.b1.outer;
    }
    /**
     * The second body in Arbiter interaction.
     * <br/><br/>
     * It will always be the case that <code>arb.shape2.body == arb.body2</code>
     */
    #if nape_swc@:isVar #end
    public var body2(get_body2,never):Body;
    inline function get_body2():Body{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        return(zpp_inner.ws1.id>zpp_inner.ws2.id)?zpp_inner.b1.outer:zpp_inner.b2.outer;
    }
    /**
     * The interaction state of this Arbiter.
     * <br/><br/>
     * This flag will, except for in a PreListener handler, always be either
     * <code>ImmState.ACCEPT</code> or <code>ImmState.IGNORE</code>
     * <br/>
     * During a PreListener handler, you can query this property to see what
     * the current state of the arbiter has been set to, and returning null from
     * the handler will keep the state unchanged.
     */
    #if nape_swc@:isVar #end
    public var state(get_state,never):PreFlag;
    inline function get_state():PreFlag{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        return switch(zpp_inner.immState){
            case x if(x==ZPP_Flags.id_ImmState_ACCEPT|ZPP_Flags.id_ImmState_ALWAYS):PreFlag.ACCEPT;
            case ZPP_Flags.id_ImmState_ACCEPT:PreFlag.ACCEPT_ONCE;
            case x if(x==ZPP_Flags.id_ImmState_IGNORE|ZPP_Flags.id_ImmState_ALWAYS):PreFlag.IGNORE;
            default:PreFlag.IGNORE_ONCE;
        }
    }
    /**
     * Evaluate the total impulse this arbiter applied to the given body for
     * the previous space step including angular impulse based on things like
     * contact position, or centre of buoyancy etc.
     * <br/><br/>
     * If body is null, then the constraint space impulse will be returned instead
     *
     * @param body The body to query impulse for. (default null)
     * @param freshOnly If true, then only 'new' contact points will be queried for
     *                  collision type arbiters. This field has no use on fluid type
     *                  arbiters. (default false)
     * @return The total impulse applied to the given body, or the constraint
     *         space impule if the body is null.
     * @throws # If body is non-null, but not related to this Arbiter.
     */
    #if nape_swc@:keep #end
    public function totalImpulse(body:Body=null,freshOnly:Bool=false){
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        #if(!NAPE_RELEASE_BUILD)
        if(body!=null&&body!=body1&&body!=body2)throw "Error: Arbiter does not relate to body";
        #end
        return Vec3.get(0,0,0);
    }
    /**
     * @private
     */
    public function new(){
        if(!ZPP_Arbiter.internal){
            #if(!NAPE_RELEASE_BUILD)
            throw "Error: Cannot instantiate Arbiter derp!";
            #end
        }
    }
    /**
     * @private
     */
    @:keep public function toString(){
        var ret=if(isCollisionArbiter())"CollisionArbiter";
        else if(isFluidArbiter())"FluidArbiter";
        else "SensorArbiter";
        #if NAPE_POOL_STATS ret+="#"+zpp_inner.arbid;
        #end
        if(zpp_inner.cleared)return ret+"(object-pooled)";
        else return ret+"("+shape1.toString()+"|"+shape2.toString()+")"+(isCollisionArbiter()?"["+["SD","DD"][zpp_inner.colarb.stat?0:1]+"]":"")+"<-"+state.toString();
    }
}
