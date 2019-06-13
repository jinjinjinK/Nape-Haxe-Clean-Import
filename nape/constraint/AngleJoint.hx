package nape.constraint;
import nape.constraint.Constraint;
import nape.geom.MatMN;
import nape.geom.Vec3;
import nape.phys.Body;
import zpp_nape.constraint.AngleJoint;
import zpp_nape.constraint.Constraint;
import zpp_nape.geom.MatMN;
import zpp_nape.geom.Vec3;
import zpp_nape.phys.Body;
/**
 * AngleJoint constraining the relative angles of two Bodies.
 * <br/><br/>
 * The equation for this constraint is:
 * <pre>
 * jointMin <= ratio * body2.rotation - body1.rotation <= jointMax
 * </pre>
 */
@:final#if nape_swc@:keep #end
class AngleJoint extends Constraint{
    /**
     * @private
     */
    public var zpp_inner_zn:ZPP_AngleJoint=null;
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
     * Lower bound for constraint.
     * <br/><br/>
     * This value must be less than or equal to jointMax.
     *
     * @default -infinity
     */
    #if nape_swc@:isVar #end
    public var jointMin(get_jointMin,set_jointMin):Float;
    inline function get_jointMin():Float{
        return zpp_inner_zn.jointMin;
    }
    inline function set_jointMin(jointMin:Float):Float{
        {
            zpp_inner.immutable_midstep("AngleJoint::jointMin");
            #if(!NAPE_RELEASE_BUILD)
            if((jointMin!=jointMin)){
                throw "Error: AngleJoint::jointMin cannot be NaN";
            }
            #end
            if(this.jointMin!=jointMin){
                zpp_inner_zn.jointMin=jointMin;
                zpp_inner.wake();
            }
        }
        return get_jointMin();
    }
    /**
     * Upper bound for constraint.
     * <br/><br/>
     * This value must be greater than or equal to jointMin.
     *
     * @default infinity
     */
    #if nape_swc@:isVar #end
    public var jointMax(get_jointMax,set_jointMax):Float;
    inline function get_jointMax():Float{
        return zpp_inner_zn.jointMax;
    }
    inline function set_jointMax(jointMax:Float):Float{
        {
            zpp_inner.immutable_midstep("AngleJoint::jointMax");
            #if(!NAPE_RELEASE_BUILD)
            if((jointMax!=jointMax)){
                throw "Error: AngleJoint::jointMax cannot be NaN";
            }
            #end
            if(this.jointMax!=jointMax){
                zpp_inner_zn.jointMax=jointMax;
                zpp_inner.wake();
            }
        }
        return get_jointMax();
    }
    /**
     * Ratio property of constraint.
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
            zpp_inner.immutable_midstep("AngleJoint::ratio");
            #if(!NAPE_RELEASE_BUILD)
            if((ratio!=ratio)){
                throw "Error: AngleJoint::ratio cannot be NaN";
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
     * Determine if constraint is slack.
     * <br/><br/>
     * This constraint is slack if the positional error is within
     * the bounds of (jointMin, jointMax).
     *
     * @return True if positional error of constraint is between the limits
     *              indicating that the constraint is not doing any work.
     * @throws # If either of the bodies is null.
     */
    public#if NAPE_NO_INLINE#else inline #end
    function isSlack():Bool{
        #if(!NAPE_RELEASE_BUILD)
        if(body1==null||body2==null){
            throw "Error: Cannot compute slack for AngleJoint if either body is null.";
        }
        #end
        return zpp_inner_zn.is_slack();
    }
    /**
     * Construct a new AngleJoint.
     *
     * @param body1 The first body in AngleJoint.
     * @param body2 The second body in AngleJoint.
     * @param jointMin The lower bound for constraint.
     * @param jointMax The upper bound for constraint.
     * @param ratio The ratio of joint (default 1)
     * @return The constructed AngleJoint.
     */
    #if flib@:keep function flibopts_0(){}
    #end
    public function new(body1:Null<Body>,body2:Null<Body>,jointMin:Float,jointMax:Float,ratio:Float=1.0){
        zpp_inner_zn=new ZPP_AngleJoint();
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
        this.jointMin=jointMin;
        this.jointMax=jointMax;
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
            return Vec3.get(0,0,0);
        }
        else{
            return zpp_inner_zn.bodyImpulse(body.zpp_inner);
        }
    }
    /**
     * @inheritDoc
     */
    public override function visitBodies(lambda:Body->Void):Void{
        #if(!NAPE_RELEASE_BUILD)
        if(lambda==null){
            throw "Error: Cannot apply null lambda to bodies";
        }
        #end
        if(body1!=null){
            lambda(body1);
        }
        if(body2!=null&&body2!=body1){
            lambda(body2);
        }
    }
}
