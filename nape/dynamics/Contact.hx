package nape.dynamics;
import nape.dynamics.CollisionArbiter;
import nape.geom.Vec2;
import nape.geom.Vec3;
import nape.phys.Body;
import zpp_nape.dynamics.Contact;
import zpp_nape.geom.Vec2;
import zpp_nape.geom.Vec3;
import zpp_nape.phys.Body;
/**
 * Contact point for collision interactions
 * <br/><br/>
 * These objects are automatically reused and you should not keep references to them.
 */
@:final#if nape_swc@:keep #end
class Contact{
    /**
     * @private
     */
    public var zpp_inner:ZPP_Contact=null;
    /**
     * Reference to the CollisionArbiter this contact belongs to
     */
    #if nape_swc@:isVar #end
    public var arbiter(get_arbiter,never):CollisionArbiter;
    inline function get_arbiter():CollisionArbiter{
        return if(zpp_inner.arbiter==null)null else zpp_inner.arbiter.outer.collisionArbiter;
    }
    /**
     * Penetration of bodies along normal for this contact.
     * <br/><br/>
     * This value may be negative and corresponds to the penetration (if at all)
     * of the contact point before positional integration and error resolvement
     * took place (correct at time of pre-listeners).
     */
    #if nape_swc@:isVar #end
    public var penetration(get_penetration,never):Float;
    inline function get_penetration():Float{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Contact not currently in use";
        #end
        return(-zpp_inner.dist);
    }
    /**
     * The world-space position of contact.
     * <br/><br/>
     * This value corresponds to the position
     * of the contact point before positional integration and error resolvement
     * took place (correct at time of pre-listeners).
     */
    #if nape_swc@:isVar #end
    public var position(get_position,never):Vec2;
    inline function get_position():Vec2{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Contact not currently in use";
        #end
        if(zpp_inner.wrap_position==null)zpp_inner.getposition();
        return zpp_inner.wrap_position;
    }
    /**
     * Whether this contact is newly generated, or persistant from previous step.
     */
    #if nape_swc@:isVar #end
    public var fresh(get_fresh,never):Bool;
    inline function get_fresh():Bool{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Contact not currently in use";
        #end
        return zpp_inner.fresh;
    }
    /**
     * Evaluate normal reactive impulses for this contact for a given body.
     * <br/><br/>
     * If body argument is null, then the contact normal impulses will be returned instead
     * with no angular impulse derivable, the direction of this impulse will be the direction of the normal.
     * <br/>
     * If body argument is not null, then this will return the actual impulse applied to that specific body
     * for this contact this will include angular impulses due to position of contact point and normal.
     *
     * @param body The Body to query normal impulse for. (default null)
     * @return The impulse applied to the given body, considering normal reactive forces.
     * @throws # If body is non-null, and unrelated to this Contact.
     */
    #if nape_swc@:keep #end
    public function normalImpulse(body:Body=null){
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Contact not currently in use";
        #end
        var colarb=zpp_inner.arbiter.colarb;
        var cin=zpp_inner.inner;
        var jnAcc=cin.jnAcc;
        if(body==null)return Vec3.get(colarb.nx*jnAcc,colarb.ny*jnAcc);
        else{
            #if(!NAPE_RELEASE_BUILD)
            if(body!=colarb.b1.outer&&body!=colarb.b2.outer)throw "Error: Contact does not relate to the given body";
            #end
            if(body==colarb.b1.outer)return Vec3.get(colarb.nx*-jnAcc,colarb.ny*-jnAcc,-(colarb.ny*cin.r1x-colarb.nx*cin.r1y)*jnAcc);
            else return Vec3.get(colarb.nx*jnAcc,colarb.ny*jnAcc,(colarb.ny*cin.r2x-colarb.nx*cin.r2y)*jnAcc);
        }
    }
    /**
     * Evaluate tangent impulses for this contact for a given body.
     * <br/><br/>
     * If body argument is null, then the contact friction impulses is returned with
     * no angular impulse derivable, the direction of this impulse will be against the relative
     * velocity of the first body against the second.
     * <br/>
     * If the body argument is non-null, then the actual impulse applied to that body due to tangent
     * frictino impulses will be returned, including angular effects due to contact position and normal.
     * <br/><br/>
     * These tangent impulses correspond to the forces of static and dynamic friction for this contact.
     *
     * @param body The Body to query tangent impulse for. (default null)
     * @return The impulse applied to the given body, considering standard frictional forces.
     * @throws # If body is non-null, and unrelated to this Contact.
     */
    #if nape_swc@:keep #end
    public function tangentImpulse(body:Body=null){
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Contact not currently in use";
        #end
        var colarb=zpp_inner.arbiter.colarb;
        var cin=zpp_inner.inner;
        var jtAcc=cin.jtAcc;
        if(body==null)return Vec3.get(-colarb.ny*jtAcc,colarb.nx*jtAcc);
        else{
            #if(!NAPE_RELEASE_BUILD)
            if(body!=colarb.b1.outer&&body!=colarb.b2.outer)throw "Error: Contact does not relate to the given body";
            #end
            if(body==colarb.b1.outer)return Vec3.get(colarb.ny*jtAcc,-colarb.nx*jtAcc,-(cin.r1x*colarb.nx+cin.r1y*colarb.ny)*jtAcc);
            else return Vec3.get(-colarb.ny*jtAcc,colarb.nx*jtAcc,(cin.r2x*colarb.nx+cin.r2y*colarb.ny)*jtAcc);
        }
    }
    /**
     * Evaluate rolling friction impulses for this contact for a given body.
     * <br/><br/>
     * If body argument is null, then the rolling impulse of this contact will be returned
     * instead of the angular impulse applied to the specific body as a result of the rolling impulse.
     *
     * @param body The Body to query rolling impulse for. (default null)
     * @return The angular impulse applied to the given body.
     * @throws # If body is non-null, and unrelated to this Contact.
     */
    #if nape_swc@:keep #end
    public function rollingImpulse(body:Body=null){
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Contact not currently in use";
        #end
        var colarb=zpp_inner.arbiter.colarb;
        var jrAcc=zpp_inner.arbiter.colarb.jrAcc;
        if(body==null)return jrAcc;
        else{
            #if(!NAPE_RELEASE_BUILD)
            if(body!=colarb.b1.outer&&body!=colarb.b2.outer)throw "Error: Contact does not relate to the given body";
            #end
            if(body==colarb.b1.outer)return-jrAcc;
            else return jrAcc;
        }
    }
    /**
     * Evaluate total contact impulse for a given body.
     * <br/><br/>
     * If body argument is null, then this will return the sum of normal and tangent contact impulse, and the contact
     * rolling impulse.
     * <br/>
     * When body argument is non-null, this impulse will be the actual change in (mass weighted)
     * velocity that this contact caused to the Body in the previous time step.
     *
     * @param body The Body to query total impulse for. (default null)
     * @return The impulse applied to the given body
     * @throws # If body is non-null, and unrelated to this Contact.
     */
    #if nape_swc@:keep #end
    public function totalImpulse(body:Body=null){
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Contact not currently in use";
        #end
        var colarb=zpp_inner.arbiter.colarb;
        var cin=zpp_inner.inner;
        var jnAcc=cin.jnAcc;
        var jtAcc=cin.jtAcc;
        var jrAcc=colarb.jrAcc;
        if(body==null){
            return Vec3.get(colarb.nx*jnAcc-colarb.ny*jtAcc,colarb.ny*jnAcc+colarb.nx*jtAcc,jrAcc);
        }
        else{
            #if(!NAPE_RELEASE_BUILD)
            if(body!=colarb.b1.outer&&body!=colarb.b2.outer)throw "Error: Contact does not relate to the given body";
            #end
            var jx:Float=colarb.nx*jnAcc-colarb.ny*jtAcc;
            var jy:Float=colarb.ny*jnAcc+colarb.nx*jtAcc;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((jx!=jx));
                };
                if(!res)throw "assert("+"!assert_isNaN(jx)"+") :: "+("vec_new(in n: "+"j"+",in x: "+"colarb.nx*jnAcc-colarb.ny*jtAcc"+",in y: "+"colarb.ny*jnAcc+colarb.nx*jtAcc"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((jy!=jy));
                };
                if(!res)throw "assert("+"!assert_isNaN(jy)"+") :: "+("vec_new(in n: "+"j"+",in x: "+"colarb.nx*jnAcc-colarb.ny*jtAcc"+",in y: "+"colarb.ny*jnAcc+colarb.nx*jtAcc"+")");
                #end
            };
            if(body==colarb.b1.outer)return Vec3.get(-jx,-jy,-(jy*cin.r1x-jx*cin.r1y)-jrAcc);
            else return Vec3.get(jx,jy,(jy*cin.r2x-jx*cin.r2y)+jrAcc);
        }
    }
    /**
     * The specific coeffecient of friction for this contact.
     * <br/><br/>
     * This value is equal either to the static or dynamic friction coeffecient of the arbiter
     * based on the relative velocity at contact point.
     * <br/><br/>
     * This value cannot be set, though you may implicitly set it exactly by modifying
     * the arbiter to have the same static and dynamic friction in the PreListener.
     */
    #if nape_swc@:isVar #end
    public var friction(get_friction,never):Float;
    inline function get_friction():Float{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Contact not currently in use";
        #end
        return zpp_inner.inner.friction;
    }
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Contact.internal)throw "Error: Cannot instantiate Contact derp!";
        #end
    }
    /**
     * @private
     */
    @:keep public function toString(){
        if(zpp_inner.arbiter==null||zpp_inner.arbiter.cleared)return "{object-pooled}";
        else return "{Contact}";
    }
}
