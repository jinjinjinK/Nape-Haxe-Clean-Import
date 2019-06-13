package nape.dynamics;
import nape.dynamics.Arbiter;
import nape.geom.Vec2;
import nape.geom.Vec3;
import nape.phys.Body;
import zpp_nape.dynamics.Arbiter;
import zpp_nape.geom.Vec2;
import zpp_nape.geom.Vec3;
import zpp_nape.phys.Body;
import zpp_nape.util.Math;
/**
 * Fluid interaction subtype for Arbiter.
 */
@:final#if nape_swc@:keep #end
class FluidArbiter extends Arbiter{
    /**
     * Centre of buoyancy for fluid interaction.
     * <br/><br/>
     * This value can be modified during a related PreListener handler.
     */
    #if nape_swc@:isVar #end
    public var position(get_position,set_position):Vec2;
    inline function get_position():Vec2{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        if(zpp_inner.fluidarb.wrap_position==null)zpp_inner.fluidarb.getposition();
        return zpp_inner.fluidarb.wrap_position;
    }
    inline function set_position(position:Vec2):Vec2{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(!zpp_inner.fluidarb.mutable)throw "Error: Arbiter is mutable only within a pre-handler";
            #end
            #if(!NAPE_RELEASE_BUILD)
            if(position==null)throw "Error: FluidArbiter::position cannot be null";
            #end
            this.position.set(position);
        }
        return get_position();
    }
    /**
     * Overlap area of Shapes in fluid interaction.
     * <br/><br/>
     * This value is strictly positive, and represents the amount of overlap between the Shapes
     * used in buoyancy computations.
     * <br/><br/>
     * This value can be modified during a related PreListener handler.
     */
    #if nape_swc@:isVar #end
    public var overlap(get_overlap,set_overlap):Float;
    inline function get_overlap():Float{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        return zpp_inner.fluidarb.overlap;
    }
    inline function set_overlap(overlap:Float):Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(!zpp_inner.fluidarb.mutable)throw "Error: Arbiter is mutable only within a pre-handler";
            #end
            #if(!NAPE_RELEASE_BUILD)
            if((overlap!=overlap))throw "Error: FluidArbiter::overlap cannot be NaN";
            #end
            #if(!NAPE_RELEASE_BUILD)
            if(overlap<=0||overlap==Math.POSITIVE_INFINITY)throw "Error: FluidArbiter::overlap must be strictly positive and non infinite";
            #end
            zpp_inner.fluidarb.overlap=overlap;
        }
        return get_overlap();
    }
    /**
     * Determine impulse on a given body due to buoyancy.
     * <br/><br/>
     * If the body is null, then the buoyancy impulse will be returned without consideration to any specific
     * body involved, and no angular impulses can be derived.
     *
     * @param body The body to query impulse for. (default null)
     * @return The buoyancy impulse for given body.
     * @throws # If body is non-null, and unrelated to this Arbiter.
     */
    #if nape_swc@:keep #end
    public function buoyancyImpulse(body:Body=null):Vec3{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        #if(!NAPE_RELEASE_BUILD)
        if(body!=null&&body!=body1&&body!=body2)throw "Error: Arbiter does not relate to body";
        #end
        var farb=zpp_inner.fluidarb;
        if(body==null){
            return Vec3.get(farb.buoyx,farb.buoyy,0);
        }
        else if(body.zpp_inner==zpp_inner.b2){
            return Vec3.get(farb.buoyx,farb.buoyy,(farb.buoyy*farb.r2x-farb.buoyx*farb.r2y));
        }
        else{
            return Vec3.get(-farb.buoyx,-farb.buoyy,-(farb.buoyy*farb.r1x-farb.buoyx*farb.r1y));
        }
    }
    /**
     * Determine impulse on a given body due to fluid drag.
     * <br/><br/>
     * If the body is null, then the drag impulse will be returned without consideration to any specific
     * body involved.
     *
     * @param body The body to query impulse for. (default null)
     * @return The drag impulse for given body.
     * @throws # If body is non-null, and unrelated to this Arbiter.
     */
    #if nape_swc@:keep #end
    public function dragImpulse(body:Body=null):Vec3{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        #if(!NAPE_RELEASE_BUILD)
        if(body!=null&&body!=body1&&body!=body2)throw "Error: Arbiter does not relate to body";
        #end
        var farb=zpp_inner.fluidarb;
        var scale=(body==null||body.zpp_inner==zpp_inner.b2?1:-1);
        return Vec3.get(farb.dampx*scale,farb.dampy*scale,farb.adamp*scale);
    }
    /**
     * Determine total impulse on a given body due to fluid interaction.
     * <br/><br/>
     * If the body is null, then the total impulse will be computed without consideration to any specific
     * body involved, and no angular impulses can be derived for the linear portion of the impulses.
     *
     * @param body The body to query impulse for. (default null)
     * @param freshOnly This parameter is unused for FluidArbiters. (default false)
     * @return The total impulse for given body.
     * @throws # If body is non-null, and unrelated to this Arbiter.
     */
    #if nape_swc@:keep #end
    public override function totalImpulse(body:Body=null,freshOnly:Bool=false){
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        #if(!NAPE_RELEASE_BUILD)
        if(body!=null&&body!=body1&&body!=body2)throw "Error: Arbiter does not relate to body";
        #end
        var tmp=this.buoyancyImpulse(body);
        var ret=this.dragImpulse(body);
        ret.x+=tmp.x;
        ret.y+=tmp.y;
        ret.z+=tmp.z;
        tmp.dispose();
        return ret;
    }
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Arbiter.internal)throw "Error: Cannot instantiate FluidArbiter derp!";
        #end
        super();
    }
}
