package nape.constraint;
import nape.constraint.Constraint;
import nape.geom.MatMN;
import nape.geom.Vec3;
import nape.phys.Body;
import zpp_nape.constraint.Constraint;
import zpp_nape.constraint.MotorJoint;
import zpp_nape.geom.MatMN;
import zpp_nape.geom.Vec3;
import zpp_nape.phys.Body;
/**
 * MotorJoint constraining the angular velocities of two bodies
 * <br/><br/>
 * The equation for this constraint is:
 * <pre>
 * (ratio * body2.angularVel) - body1.angularVel = rate
 * </pre>
 * This constraint operates only on the velocities of objects.
 */
@:final#if nape_swc@:keep #end
class MotorJoint extends Constraint{
    /**
     * @private
     */
    public var zpp_inner_zn:ZPP_MotorJoint=null;
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
     * MotorJoint ratio.
     *
     * @default 1
     */
    #if nape_swc@:isVar #end
    public var ratio(get_ratio,set_ratio):Float;
    inline function get_ratio():Float{
        return zpp_inner_zn.ratio;
    }
    inline function set_ratio(ratio:Float):Float{
        {
            zpp_inner.immutable_midstep("MotorJoint::ratio");
            #if(!NAPE_RELEASE_BUILD)
            if((ratio!=ratio)){
                throw "Error: MotorJoint::ratio cannot be NaN";
            }
            #end
            if(this.ratio!=ratio){
                zpp_inner_zn.ratio=ratio;
                zpp_inner.wake();
            }
        }
        return get_ratio();
    }
    /**
     * MotorJoint rate
     *
     * @default 0
     */
    #if nape_swc@:isVar #end
    public var rate(get_rate,set_rate):Float;
    inline function get_rate():Float{
        return zpp_inner_zn.rate;
    }
    inline function set_rate(rate:Float):Float{
        {
            zpp_inner.immutable_midstep("MotorJoint::rate");
            #if(!NAPE_RELEASE_BUILD)
            if((rate!=rate)){
                throw "Error: MotorJoint::rate cannot be NaN";
            }
            #end
            if(this.rate!=rate){
                zpp_inner_zn.rate=rate;
                zpp_inner.wake();
            }
        }
        return get_rate();
    }
    /**
     * Construct a new MotorJoint
     *
     * @param body1 The first body in MotorJoint
     * @param body2 The second body in MotorJoint
     * @param rate The rate of motor. (default 0)
     * @param ratio The ratio of the motor. (default 1)
     * @return The constructed MotorJoint.
    **/
    #if flib@:keep function flibopts_2(){}
    #end
    public function new(body1:Null<Body>,body2:Null<Body>,rate:Float=0.0,ratio:Float=1.0){
        zpp_inner_zn=new ZPP_MotorJoint();
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
        this.rate=rate;
        this.ratio=ratio;
    }
    /**
     * @inheritDoc
     * <br/><br/>
     * For this constraint, the MatMN will be 1x1.
     */
    public override function impulse():MatMN{
        var ret=new MatMN(1,1);
        ret.setx(0,0,zpp_inner_zn.jAcc);
        return ret;
    }
    /**
     * @inheritDoc
     * <br/><br/>
     * For this constraint, only the z coordinate will be non-zero.
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
