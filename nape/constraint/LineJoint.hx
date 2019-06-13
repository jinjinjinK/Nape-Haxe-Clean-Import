package nape.constraint;
import nape.constraint.Constraint;
import nape.geom.MatMN;
import nape.geom.Vec2;
import nape.geom.Vec3;
import nape.phys.Body;
import zpp_nape.constraint.Constraint;
import zpp_nape.constraint.LineJoint;
import zpp_nape.geom.MatMN;
import zpp_nape.geom.Vec2;
import zpp_nape.geom.Vec3;
import zpp_nape.phys.Body;
/**
 * LineJoint constraining anchor of one body, to a line segment of the other.
 * <br/><br/>
 * The equation for this constraint could be written like:
 * <pre>
 *        0  = [dir.cross(delta)]  = 0
 * jointMin <= [dor.dot  (delta)] <= jointMax
 * </pre>
 * where:
 * <pre>
 * dir   = body1.localVectorToWorld(direction).unit();
 * delta = body2.localPointToWorld(anchor2).sub(body1.localPointToWorld(anchor1));
 * </pre>
 * This is a 2 dimensional constraint, and is (when at the limits) solved as a
 * block constraint for better stability. This is however not the most stable
 * of joint when chained and put under stress and is a rather rare case where
 * using a non-stiff joint can actually be more stable than
 * using a stiff one.
 * <br/><br/>
 * When <code> jointMin = jointMax </code>, it would be better to use a PivotJoint
 *instead with suitable
 * placed anchors.
 * <br/><br/>
 * The line segment is defined implicitly via the
 * <code>anchor1, direction, jointMin and jointMax</code> properties with end
 * points defined in local coordinate system of body1 like:
 * <pre>
 * start = anchor1.add(direction.unit().mul(jointMin))
 * end   = anchor1.add(direction.unit().mul(jointMax))
 * </pre>
 * The reason for this more general description of a line segment is that one or
 * both of jointMin, jointMax are permitted to be infinite and a line segment
 * defined with a start and end point is not sufficient to describe such lines.
 */
@:final#if nape_swc@:keep #end
class LineJoint extends Constraint{
    /**
     * @private
     */
    public var zpp_inner_zn:ZPP_LineJoint=null;
    /**
     * First Body in constraint, defining the line segment.
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
     * Anchor point on first Body, defining position on line.
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
     * Direction of line on first Body.
     * <br/><br/>
     * This direction is defined in the local coordinate system of body1 and
     * need not be normalised.
     */
    #if nape_swc@:isVar #end
    public var direction(get_direction,set_direction):Vec2;
    inline function get_direction():Vec2{
        if(zpp_inner_zn.wrap_n==null)zpp_inner_zn.setup_n();
        return zpp_inner_zn.wrap_n;
    }
    inline function set_direction(direction:Vec2):Vec2{
        {
            {
                #if(!NAPE_RELEASE_BUILD)
                if(direction!=null&&direction.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
                #end
            };
            #if(!NAPE_RELEASE_BUILD)
            if(direction==null)throw "Error: Constraint::"+"direction"+" cannot be null";
            #end
            this.direction.set(direction);
        }
        return get_direction();
    }
    /**
     * Lower bound for constraint.
     * <br/><br/>
     * This value must be less than or equal to jointMax.
     */
    #if nape_swc@:isVar #end
    public var jointMin(get_jointMin,set_jointMin):Float;
    inline function get_jointMin():Float{
        return zpp_inner_zn.jointMin;
    }
    inline function set_jointMin(jointMin:Float):Float{
        {
            zpp_inner.immutable_midstep("LineJoint::jointMin");
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
     */
    #if nape_swc@:isVar #end
    public var jointMax(get_jointMax,set_jointMax):Float;
    inline function get_jointMax():Float{
        return zpp_inner_zn.jointMax;
    }
    inline function set_jointMax(jointMax:Float):Float{
        {
            zpp_inner.immutable_midstep("LineJoint::jointMax");
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
     * Construct a new LineJoint.
     *
     * @param body1 The first body in LineJoint.
     * @param body2 The second body in LineJoint.
     * @param anchor1 The first local anchor for joint.
     * @param anchor2 The second local anchor for joint.
     * @param direction The direction of local line for joint.
     * @param jointMin The lower bound for constraint.
     * @param jointMax The upper bound for constraint.
     * @return The constructed LineJoint.
     */
    #if flib@:keep function flibopts_0(){}
    #end
    public function new(body1:Null<Body>,body2:Null<Body>,anchor1:Vec2,anchor2:Vec2,direction:Vec2,jointMin:Float,jointMax:Float){
        zpp_inner_zn=new ZPP_LineJoint();
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
        this.direction=direction;
        this.jointMin=jointMin;
        this.jointMax=jointMax;
    }
    /**
     * @inheritDoc
     * <br/><br/>
     * For this constraint, the MatMN will be 2x1.
     */
    public override function impulse():MatMN{
        var ret=new MatMN(2,1);
        ret.setx(0,0,zpp_inner_zn.jAccx);
        ret.setx(1,0,zpp_inner_zn.jAccy);
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
