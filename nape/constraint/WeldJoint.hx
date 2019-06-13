package nape.constraint;
import nape.constraint.Constraint;
import nape.geom.MatMN;
import nape.geom.Vec2;
import nape.geom.Vec3;
import nape.phys.Body;
import zpp_nape.constraint.Constraint;
import zpp_nape.constraint.WeldJoint;
import zpp_nape.geom.MatMN;
import zpp_nape.geom.Vec2;
import zpp_nape.geom.Vec3;
import zpp_nape.phys.Body;
/**
 * WeldJoint constraining two bodies to be exactly locked together.
 * <br/><br/>
 * The equation for this constraint is:
 * <pre>
 * [ body2.localPointToWorld(anchor2) ] = [ body1.localPointToWorld(anchor1) ]
 * [          body2.rotation          ]   [      body1.rotation + phase      ]
 * </pre>
 * This constraint is equivalent to using a PivotJoint and AngleJoint
 * together except that it is solved as a single constraint and thus
 * will be more stable.
 * <br/><br/>
 * This constraint is 3 dimensional.
 * <br/><br/>
 * Although this constraint is very stable, if you chain bodies together
 * using this constraint, you should except to see a small amount of rotation
 * about the anchor points so you should chose them accordingly.
 */
@:final#if nape_swc@:keep #end
class WeldJoint extends Constraint{
    /**
     * @private
     */
    public var zpp_inner_zn:ZPP_WeldJoint=null;
    /**
     * First Body in constraint.
     * <br/><br/>
     * This value may be null, but trying to simulate the constraint whilst
     * this body is null will result in an error.
     */
    #if nape_swc@:isVar #end
    public var body1(get_body1,set_body1):Null<Body>;
    inline function get_body1():Null<Body>{
        return if(zpp_inner_zn.b1==null)null else zpp_inner_zn.b1.outer;
    }
    inline function set_body1(body1:Null<Body>):Null<Body>{
        {
            zpp_inner.immutable_midstep("Constraint::"+"body1");
            var inbody1=if(body1==null)null else body1.zpp_inner;
            if(inbody1!=zpp_inner_zn.b1){
                if(zpp_inner_zn.b1!=null){
                    if(space!=null&&zpp_inner_zn.b2!=zpp_inner_zn.b1){
                        {
                            if(zpp_inner_zn.b1!=null)zpp_inner_zn.b1.constraints.remove(this.zpp_inner);
                        };
                    }
                    if(active&&space!=null)zpp_inner_zn.b1.wake();
                }
                zpp_inner_zn.b1=inbody1;
                if(space!=null&&inbody1!=null&&zpp_inner_zn.b2!=inbody1){
                    {
                        if(inbody1!=null)inbody1.constraints.add(this.zpp_inner);
                    };
                }
                if(active&&space!=null){
                    zpp_inner.wake();
                    if(inbody1!=null)inbody1.wake();
                }
            }
        }
        return get_body1();
    }
    /**
     * Second Body in constraint.
     * <br/><br/>
     * This value may be null, but trying to simulate the constraint whilst
     * this body is null will result in an error.
     */
    #if nape_swc@:isVar #end
    public var body2(get_body2,set_body2):Null<Body>;
    inline function get_body2():Null<Body>{
        return if(zpp_inner_zn.b2==null)null else zpp_inner_zn.b2.outer;
    }
    inline function set_body2(body2:Null<Body>):Null<Body>{
        {
            zpp_inner.immutable_midstep("Constraint::"+"body2");
            var inbody2=if(body2==null)null else body2.zpp_inner;
            if(inbody2!=zpp_inner_zn.b2){
                if(zpp_inner_zn.b2!=null){
                    if(space!=null&&zpp_inner_zn.b1!=zpp_inner_zn.b2){
                        {
                            if(zpp_inner_zn.b2!=null)zpp_inner_zn.b2.constraints.remove(this.zpp_inner);
                        };
                    }
                    if(active&&space!=null)zpp_inner_zn.b2.wake();
                }
                zpp_inner_zn.b2=inbody2;
                if(space!=null&&inbody2!=null&&zpp_inner_zn.b1!=inbody2){
                    {
                        if(inbody2!=null)inbody2.constraints.add(this.zpp_inner);
                    };
                }
                if(active&&space!=null){
                    zpp_inner.wake();
                    if(inbody2!=null)inbody2.wake();
                }
            }
        }
        return get_body2();
    }
    /**
     * Anchor point on first Body.
     * <br/><br/>
     * This anchor point is defined in the local coordinate system of body1.
     */
    #if nape_swc@:isVar #end
    public var anchor1(get_anchor1,set_anchor1):Vec2;
    inline function get_anchor1():Vec2{
        if(zpp_inner_zn.wrap_a1==null)zpp_inner_zn.setup_a1();
        return zpp_inner_zn.wrap_a1;
    }
    inline function set_anchor1(anchor1:Vec2):Vec2{
        {
            {
                #if(!NAPE_RELEASE_BUILD)
                if(anchor1!=null&&anchor1.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
                #end
            };
            #if(!NAPE_RELEASE_BUILD)
            if(anchor1==null)throw "Error: Constraint::"+"anchor1"+" cannot be null";
            #end
            this.anchor1.set(anchor1);
        }
        return get_anchor1();
    }
    /**
     * Anchor point on second Body.
     * <br/><br/>
     * This anchor point is defined in the local coordinate system of body2.
     */
    #if nape_swc@:isVar #end
    public var anchor2(get_anchor2,set_anchor2):Vec2;
    inline function get_anchor2():Vec2{
        if(zpp_inner_zn.wrap_a2==null)zpp_inner_zn.setup_a2();
        return zpp_inner_zn.wrap_a2;
    }
    inline function set_anchor2(anchor2:Vec2):Vec2{
        {
            {
                #if(!NAPE_RELEASE_BUILD)
                if(anchor2!=null&&anchor2.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
                #end
            };
            #if(!NAPE_RELEASE_BUILD)
            if(anchor2==null)throw "Error: Constraint::"+"anchor2"+" cannot be null";
            #end
            this.anchor2.set(anchor2);
        }
        return get_anchor2();
    }
    /**
     * Angular phase of bodies in WeldJoint.
     *
     * @default 0
     */
    #if nape_swc@:isVar #end
    public var phase(get_phase,set_phase):Float;
    inline function get_phase():Float{
        return zpp_inner_zn.phase;
    }
    inline function set_phase(phase:Float):Float{
        {
            zpp_inner.immutable_midstep("WeldJoint::phase");
            #if(!NAPE_RELEASE_BUILD)
            if((phase!=phase)){
                throw "Error: WeldJoint::phase cannot be NaN";
            }
            #end
            if(this.phase!=phase){
                zpp_inner_zn.phase=phase;
                zpp_inner.wake();
            }
        }
        return get_phase();
    }
    /**
     * Construct a new WeldJoint.
     *
     * @param body1 The first body in WeldJoint.
     * @param body2 The second body in WeldJoint.
     * @param anchor1 The first local anchor for joint.
     * @param anchor2 The second local anchor for joint.
     * @param phase The angular phase of joint. (default 0)
     * @return The constructed WeldJoint.
     */
    #if flib@:keep function flibopts_1(){}
    #end
    public function new(body1:Null<Body>,body2:Null<Body>,anchor1:Vec2,anchor2:Vec2,phase:Float=0.0){
        zpp_inner_zn=new ZPP_WeldJoint();
        zpp_inner=zpp_inner_zn;
        zpp_inner.outer=this;
        zpp_inner_zn.outer_zn=this;
        #if(!NAPE_RELEASE_BUILD)
        Constraint.zpp_internalAlloc=true;
        super();
        Constraint.zpp_internalAlloc=false;
        #end
        #if NAPE_RELEASE_BUILD 
        super();
        #end
        this.body1=body1;
        this.body2=body2;
        this.anchor1=anchor1;
        this.anchor2=anchor2;
        this.phase=phase;
    }
    /**
     * @inheritDoc
     * <br/><br/>
     * For this constraint, the MatMN will be 3x1.
     */
    public override function impulse():MatMN{
        var ret=new MatMN(3,1);
        ret.setx(0,0,zpp_inner_zn.jAccx);
        ret.setx(1,0,zpp_inner_zn.jAccy);
        ret.setx(1,0,zpp_inner_zn.jAccz);
        return ret;
    }
    /**
     * @inheritDoc
     */
    public override function bodyImpulse(body:Body):Vec3{
        #if(!NAPE_RELEASE_BUILD)
        if(body==null){
            throw "Error: Cannot evaluate impulse on null body";
        }
        if(body!=body1&&body!=body2){
            throw "Error: Body is not linked to this constraint";
        }
        #end
        if(!active){
            return Vec3.get();
        }
        else{
            return zpp_inner_zn.bodyImpulse(body.zpp_inner);
        }
    }
    /**
     * @inheritDoc
     */
    public override function visitBodies(lambda:Body->Void):Void{
        if(body1!=null){
            lambda(body1);
        }
        if(body2!=null&&body2!=body1){
            lambda(body2);
        }
    }
}
