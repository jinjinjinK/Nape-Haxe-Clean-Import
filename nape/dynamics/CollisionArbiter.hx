package nape.dynamics;
import nape.dynamics.Arbiter;
import nape.dynamics.ContactList;
import nape.geom.Vec2;
import nape.geom.Vec3;
import nape.phys.Body;
import nape.shape.Edge;
import zpp_nape.dynamics.Arbiter;
import zpp_nape.geom.Vec2;
import zpp_nape.geom.Vec3;
import zpp_nape.phys.Body;
import zpp_nape.shape.Edge;
/**
 * Arbiter sub type for collision interactions.
 */
@:final#if nape_swc@:keep #end
class CollisionArbiter extends Arbiter{
    /**
     * Set of contact points for the related pairs of shapes.
     */
    #if nape_swc@:isVar #end
    public var contacts(get_contacts,never):ContactList;
    inline function get_contacts():ContactList{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        if(zpp_inner.colarb.wrap_contacts==null)zpp_inner.colarb.setupcontacts();
        return zpp_inner.colarb.wrap_contacts;
    }
    /**
     * Normal of contact for collision interaction.
     * <br/><br/>
     * This normal will always point from arbiter's shape1, towards shape2 and
     * corresponds to the direction of the normal before positional integration
     * and erorr resolvement took place (Correct at time of pre-listener).
     */
    #if nape_swc@:isVar #end
    public var normal(get_normal,never):Vec2;
    inline function get_normal():Vec2{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        if(zpp_inner.colarb.wrap_normal==null)zpp_inner.colarb.getnormal();
        return zpp_inner.colarb.wrap_normal;
    }
    /**
     * This radius property describes the sum of the circle's radii for the pair of shapes, with
     * a Polygon having 0 radius. This value is used in positional iterations to resolve penetrations
     * between the Shapes.
     */
    #if nape_swc@:isVar #end
    public var radius(get_radius,never):Float;
    inline function get_radius():Float{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        return zpp_inner.colarb.radius;
    }
    /**
     * The reference edge for the collision on the first Polygon
     * If the first shape in Arbiter is a Circle this value is null.
     */
    #if nape_swc@:isVar #end
    public var referenceEdge1(get_referenceEdge1,never):Null<Edge>;
    inline function get_referenceEdge1():Null<Edge>{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        var edge=zpp_inner.colarb.__ref_edge1;
        if(edge!=null&&(!shape1.isPolygon()||shape1.zpp_inner!=edge.polygon))edge=zpp_inner.colarb.__ref_edge2;
        return(edge==null)?null:edge.wrapper();
    }
    /**
     * The reference edge for the collision on the second Polygon
     * If the second shape in Arbiter is a Circle this value is null.
     */
    #if nape_swc@:isVar #end
    public var referenceEdge2(get_referenceEdge2,never):Null<Edge>;
    inline function get_referenceEdge2():Null<Edge>{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        var edge=zpp_inner.colarb.__ref_edge1;
        if(edge!=null&&(!shape2.isPolygon()||shape2.zpp_inner!=edge.polygon))edge=zpp_inner.colarb.__ref_edge2;
        return(edge==null)?null:edge.wrapper();
    }
    /**
     * In the case that we have a Circle-Polygon collision, then this
     * function will return true, if the circle collided with the first
     * vertex of edge.
     * <br/><br/>
     * If both firstVertex() and secondVertex() are false, it indicates
     * the Circle collided with the edge.
     *
     * @returns True if Circle collided with first reference vertex.
     */
    public function firstVertex(){
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        var poly2circle=(zpp_inner.colarb.__ref_edge1!=null)!=(zpp_inner.colarb.__ref_edge2!=null);
        return if(poly2circle)(zpp_inner.colarb.__ref_vertex==-1)else false;
    }
    /**
     * Check if colliding Circle hit second vertex of reference edge.
     * <br/><br/>
     * In the case that we have a Circle-Polygon collision, then this
     * function will return true, if the circle collided with the second
     * vertex of edge.
     * <br/><br/>
     * If both firstVertex() and secondVertex() are false, it indicates
     * the Circle collided with the edge.
     *
     * @returns True if Circle collided with second reference vertex.
     */
    public function secondVertex(){
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        var poly2circle=(zpp_inner.colarb.__ref_edge1!=null)!=(zpp_inner.colarb.__ref_edge2!=null);
        return if(poly2circle)(zpp_inner.colarb.__ref_vertex==1)else false;
    }
    /**
     * Evaluate normal reactive impulses for collision interaction for a given body.
     * <br/><br/>
     * If body argument is null, then the sum of the contact normal impulses will be returned instead
     * with no angular impulse derivable, the direction of this impulse will be the direction of the normal.
     * <br/>
     * If body argument is not null, then this will return the actual impulse applied to that specific body
     * rather than simply the sum of contact normal impulses, this will include angular impulses due to
     * positions of contact points and normal.
     *
     * @param body The Body to query normal impulse for. (default null)
     * @param freshOnly If true, then only 'new' contact points will be considered in computation.
     *                  (default false)
     * @return The impulse applied to the given body, considering normal reactive forces.
     * @throws # If body is non-null, and unrelated to this Arbiter.
     */
    #if nape_swc@:keep #end
    public function normalImpulse(body:Body=null,freshOnly:Bool=false):Vec3{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        #if(!NAPE_RELEASE_BUILD)
        if(body!=null&&body!=body1&&body!=body2)throw "Error: Arbiter does not relate to body";
        #end
        var retx:Float=0;
        var rety:Float=0;
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !((retx!=retx));
            };
            if(!res)throw "assert("+"!assert_isNaN(retx)"+") :: "+("vec_new(in n: "+"ret"+",in x: "+"0"+",in y: "+"0"+")");
            #end
        };
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !((rety!=rety));
            };
            if(!res)throw "assert("+"!assert_isNaN(rety)"+") :: "+("vec_new(in n: "+"ret"+",in x: "+"0"+",in y: "+"0"+")");
            #end
        };
        var retz:Float=0;
        var colarb=zpp_inner.colarb;
        {
            if(!freshOnly||colarb.oc1.fresh){
                var imp=colarb.oc1.wrapper().normalImpulse(body);
                {
                    var t=(1);
                    {
                        var t=(t);
                        {
                            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                            var res={
                                !((t!=t));
                            };
                            if(!res)throw "assert("+"!assert_isNaN(t)"+") :: "+("vec_addeq(in a: "+"ret"+",in b: "+"imp."+",in s: "+"t"+")");
                            #end
                        };
                        retx+=imp.x*t;
                        rety+=imp.y*t;
                    };
                    retz+=imp.z*t;
                };
                imp.dispose();
            }
        };
        if(colarb.hc2){
            if(!freshOnly||colarb.oc2.fresh){
                var imp=colarb.oc2.wrapper().normalImpulse(body);
                {
                    var t=(1);
                    {
                        var t=(t);
                        {
                            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                            var res={
                                !((t!=t));
                            };
                            if(!res)throw "assert("+"!assert_isNaN(t)"+") :: "+("vec_addeq(in a: "+"ret"+",in b: "+"imp."+",in s: "+"t"+")");
                            #end
                        };
                        retx+=imp.x*t;
                        rety+=imp.y*t;
                    };
                    retz+=imp.z*t;
                };
                imp.dispose();
            }
        };
        return Vec3.get(retx,rety,retz);
    }
    /**
     * Evaluate tangent impulses for collision interaction.
     * <br/><br/>
     * If body argument is null, then the sum of the contact friction impulses is returned with
     * no angular impulse derivable, the direction of this impulse will be against the relative
     * velocity of the first body against the second.
     * <br/>
     * If the body argument is non-null, then the actual impulse applied to that body due to tangent
     * frictino impulses will be returned, including angular effects due to contact positions and normal.
     * <br/><br/>
     * These tangent impulses correspond to the forces of static and dynamic friction.
     *
     * @param body The Body to query tangent impulse for. (default null)
     * @param freshOnly If true, then only 'new' contact points will be considered in computation.
     *                  (default false)
     * @return The impulse applied to the given body, considering standard frictional forces.
     * @throws # If body is non-null, and unrelated to this Arbiter.
     */
    #if nape_swc@:keep #end
    public function tangentImpulse(body:Body=null,freshOnly:Bool=false):Vec3{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        #if(!NAPE_RELEASE_BUILD)
        if(body!=null&&body!=body1&&body!=body2)throw "Error: Arbiter does not relate to body";
        #end
        var retx:Float=0;
        var rety:Float=0;
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !((retx!=retx));
            };
            if(!res)throw "assert("+"!assert_isNaN(retx)"+") :: "+("vec_new(in n: "+"ret"+",in x: "+"0"+",in y: "+"0"+")");
            #end
        };
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !((rety!=rety));
            };
            if(!res)throw "assert("+"!assert_isNaN(rety)"+") :: "+("vec_new(in n: "+"ret"+",in x: "+"0"+",in y: "+"0"+")");
            #end
        };
        var retz:Float=0;
        var colarb=zpp_inner.colarb;
        {
            if(!freshOnly||colarb.oc1.fresh){
                var imp=colarb.oc1.wrapper().tangentImpulse(body);
                {
                    var t=(1);
                    {
                        var t=(t);
                        {
                            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                            var res={
                                !((t!=t));
                            };
                            if(!res)throw "assert("+"!assert_isNaN(t)"+") :: "+("vec_addeq(in a: "+"ret"+",in b: "+"imp."+",in s: "+"t"+")");
                            #end
                        };
                        retx+=imp.x*t;
                        rety+=imp.y*t;
                    };
                    retz+=imp.z*t;
                };
                imp.dispose();
            }
        };
        if(colarb.hc2){
            if(!freshOnly||colarb.oc2.fresh){
                var imp=colarb.oc2.wrapper().tangentImpulse(body);
                {
                    var t=(1);
                    {
                        var t=(t);
                        {
                            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                            var res={
                                !((t!=t));
                            };
                            if(!res)throw "assert("+"!assert_isNaN(t)"+") :: "+("vec_addeq(in a: "+"ret"+",in b: "+"imp."+",in s: "+"t"+")");
                            #end
                        };
                        retx+=imp.x*t;
                        rety+=imp.y*t;
                    };
                    retz+=imp.z*t;
                };
                imp.dispose();
            }
        };
        return Vec3.get(retx,rety,retz);
    }
    /**
     * Evaluate total contact impulses for collision interaction.
     * <br/><br/>
     * If body argument is null, then this will return the sum of linear contact impulses, and the sum
     * of contact rolling impulses.
     * <br/>
     * When body argument is non-null, this impulse will be the actual change in (mass weighted)
     * velocity that this collision caused to the Body in the previous time step.
     *
     * @param body The Body to query total impulse for. (default null)
     * @param freshOnly If true, then only 'new' contact points will be considered in computation.
     *                  (default false)
     * @return The impulse applied to the given body
     * @throws # If body is non-null, and unrelated to this Arbiter.
     */
    #if nape_swc@:keep #end
    public override function totalImpulse(body:Body=null,freshOnly:Bool=false):Vec3{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        #if(!NAPE_RELEASE_BUILD)
        if(body!=null&&body!=body1&&body!=body2)throw "Error: Arbiter does not relate to body";
        #end
        var retx:Float=0;
        var rety:Float=0;
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !((retx!=retx));
            };
            if(!res)throw "assert("+"!assert_isNaN(retx)"+") :: "+("vec_new(in n: "+"ret"+",in x: "+"0"+",in y: "+"0"+")");
            #end
        };
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !((rety!=rety));
            };
            if(!res)throw "assert("+"!assert_isNaN(rety)"+") :: "+("vec_new(in n: "+"ret"+",in x: "+"0"+",in y: "+"0"+")");
            #end
        };
        var retz:Float=0;
        var colarb=zpp_inner.colarb;
        {
            if(!freshOnly||colarb.oc1.fresh){
                var imp=colarb.oc1.wrapper().totalImpulse(body);
                {
                    var t=(1);
                    {
                        var t=(t);
                        {
                            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                            var res={
                                !((t!=t));
                            };
                            if(!res)throw "assert("+"!assert_isNaN(t)"+") :: "+("vec_addeq(in a: "+"ret"+",in b: "+"imp."+",in s: "+"t"+")");
                            #end
                        };
                        retx+=imp.x*t;
                        rety+=imp.y*t;
                    };
                    retz+=imp.z*t;
                };
                imp.dispose();
            }
        };
        if(colarb.hc2){
            if(!freshOnly||colarb.oc2.fresh){
                var imp=colarb.oc2.wrapper().totalImpulse(body);
                {
                    var t=(1);
                    {
                        var t=(t);
                        {
                            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                            var res={
                                !((t!=t));
                            };
                            if(!res)throw "assert("+"!assert_isNaN(t)"+") :: "+("vec_addeq(in a: "+"ret"+",in b: "+"imp."+",in s: "+"t"+")");
                            #end
                        };
                        retx+=imp.x*t;
                        rety+=imp.y*t;
                    };
                    retz+=imp.z*t;
                };
                imp.dispose();
            }
        };
        return Vec3.get(retx,rety,retz);
    }
    /**
     * Evaluate rolling friction impulses for collision interaction.
     * <br/><br/>
     * If body argument is null, then the sum of the rolling impulses of each contact will be returned
     * instead of the angular impulse applied to the specific body as a result of the rolling impulses.
     *
     * @param body The Body to query rolling impulse for. (default null)
     * @param freshOnly If true, then only 'new' contact points will be considered in computation.
     *                  (default false)
     * @return The angular impulse applied to the given body.
     * @throws # If body is non-null, and unrelated to this Arbiter.
     */
    #if nape_swc@:keep #end
    public function rollingImpulse(body:Body=null,freshOnly:Bool=false):Float{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        #if(!NAPE_RELEASE_BUILD)
        if(body!=null&&body!=body1&&body!=body2)throw "Error: Arbiter does not relate to body";
        #end
        var colarb=zpp_inner.colarb;
        if(!freshOnly||colarb.oc1.fresh)return colarb.oc1.wrapper().rollingImpulse(body);
        else return 0.0;
    }
    /**
     * Coeffecient of combined elasticity for collision interaction.
     * <br/><br/>
     * The value is computed as the average of the Shape Material's elasticities
     * clamped to be in the range [0,1]
     * <br/><br/>
     * This value may be modified only during a PreListener, and once modified
     * will no longer be under Nape's control. Values must be in the range 0
     * to 1.
     */
    #if nape_swc@:isVar #end
    public var elasticity(get_elasticity,set_elasticity):Float;
    inline function get_elasticity():Float{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        var colarb=zpp_inner.colarb;
        colarb.validate_props();
        return colarb.restitution;
    }
    inline function set_elasticity(elasticity:Float):Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(!zpp_inner.colarb.mutable)throw "Error: CollisionArbiter::"+"elasticity"+" is only mutable during a pre-handler";
            #end
            #if(!NAPE_RELEASE_BUILD)
            if((elasticity!=elasticity))throw "Error: CollisionArbiter::"+"elasticity"+" cannot be NaN";
            if(elasticity<0)throw "Error: CollisionArbiter::"+"elasticity"+" cannot be negative";
            if("elasticity"=="restitution"&&elasticity>1)throw "Error: CollisionArbiter::restitution cannot be greater than 1";
            #end
            var colarb=zpp_inner.colarb;
            colarb.restitution=elasticity;
            colarb.userdef_restitution=true;
        }
        return get_elasticity();
    }
    /**
     * Coeffecient of combined dynamic friction for collision interaction.
     * <br/><br/>
     * The value is computed as the square root of the product of the Shape
     * Material's dynamicFriction coeffecients.
     * <br/><br/>
     * This value may be modified only during a PreListener, and once modified
     * will no longer be under Nape's control. Values must not be negative.
     */
    #if nape_swc@:isVar #end
    public var dynamicFriction(get_dynamicFriction,set_dynamicFriction):Float;
    inline function get_dynamicFriction():Float{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        var colarb=zpp_inner.colarb;
        colarb.validate_props();
        return colarb.dyn_fric;
    }
    inline function set_dynamicFriction(dynamicFriction:Float):Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(!zpp_inner.colarb.mutable)throw "Error: CollisionArbiter::"+"dynamicFriction"+" is only mutable during a pre-handler";
            #end
            #if(!NAPE_RELEASE_BUILD)
            if((dynamicFriction!=dynamicFriction))throw "Error: CollisionArbiter::"+"dynamicFriction"+" cannot be NaN";
            if(dynamicFriction<0)throw "Error: CollisionArbiter::"+"dynamicFriction"+" cannot be negative";
            if("dynamicFriction"=="restitution"&&dynamicFriction>1)throw "Error: CollisionArbiter::restitution cannot be greater than 1";
            #end
            var colarb=zpp_inner.colarb;
            colarb.dyn_fric=dynamicFriction;
            colarb.userdef_dyn_fric=true;
        }
        return get_dynamicFriction();
    }
    /**
     * Coeffecient of combined static friction for collision interaction.
     * <br/><br/>
     * The value is computed as the square root of the product of the Shape
     * Material's staticFriction coeffecients.
     * <br/><br/>
     * This value may be modified only during a PreListener, and once modified
     * will no longer be under Nape's control. Values must not be negative.
     */
    #if nape_swc@:isVar #end
    public var staticFriction(get_staticFriction,set_staticFriction):Float;
    inline function get_staticFriction():Float{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        var colarb=zpp_inner.colarb;
        colarb.validate_props();
        return colarb.stat_fric;
    }
    inline function set_staticFriction(staticFriction:Float):Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(!zpp_inner.colarb.mutable)throw "Error: CollisionArbiter::"+"staticFriction"+" is only mutable during a pre-handler";
            #end
            #if(!NAPE_RELEASE_BUILD)
            if((staticFriction!=staticFriction))throw "Error: CollisionArbiter::"+"staticFriction"+" cannot be NaN";
            if(staticFriction<0)throw "Error: CollisionArbiter::"+"staticFriction"+" cannot be negative";
            if("staticFriction"=="restitution"&&staticFriction>1)throw "Error: CollisionArbiter::restitution cannot be greater than 1";
            #end
            var colarb=zpp_inner.colarb;
            colarb.stat_fric=staticFriction;
            colarb.userdef_stat_fric=true;
        }
        return get_staticFriction();
    }
    /**
     * Coeffecient of combined rolling friction for collision interaction.
     * <br/><br/>
     * The value is computed as the square root of the product of the Shape
     * Material's rollingFriction coeffecients.
     * <br/><br/>
     * This value may be modified only during a PreListener, and once modified
     * will no longer be under Nape's control. Values must not be negative.
     */
    #if nape_swc@:isVar #end
    public var rollingFriction(get_rollingFriction,set_rollingFriction):Float;
    inline function get_rollingFriction():Float{
        #if(!NAPE_RELEASE_BUILD)
        if(zpp_inner.inactiveme())throw "Error: Arbiter not currently in use";
        #end
        var colarb=zpp_inner.colarb;
        colarb.validate_props();
        return colarb.rfric;
    }
    inline function set_rollingFriction(rollingFriction:Float):Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(!zpp_inner.colarb.mutable)throw "Error: CollisionArbiter::"+"rollingFriction"+" is only mutable during a pre-handler";
            #end
            #if(!NAPE_RELEASE_BUILD)
            if((rollingFriction!=rollingFriction))throw "Error: CollisionArbiter::"+"rollingFriction"+" cannot be NaN";
            if(rollingFriction<0)throw "Error: CollisionArbiter::"+"rollingFriction"+" cannot be negative";
            if("rollingFriction"=="restitution"&&rollingFriction>1)throw "Error: CollisionArbiter::restitution cannot be greater than 1";
            #end
            var colarb=zpp_inner.colarb;
            colarb.rfric=rollingFriction;
            colarb.userdef_rfric=true;
        }
        return get_rollingFriction();
    }
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Arbiter.internal)throw "Error: Cannot instantiate CollisionArbiter derp!";
        #end
        super();
    }
}
