package nape.geom;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.shape.Shape;
import zpp_nape.Const.ZPP_Const;
import zpp_nape.geom.Collide.ZPP_Collide;
import zpp_nape.geom.Geom;
import zpp_nape.geom.SweepDistance.ZPP_SweepDistance;
import zpp_nape.geom.Vec2;
import zpp_nape.phys.Body;
import zpp_nape.shape.Shape;
/**
 * Geom class provides interface to collision detection routines in nape.
 */
@:final#if nape_swc@:keep #end
class Geom{
    /**
     * Determine distance and closest points between two Bodies.
     * <br/><br/>
     * If the bodies are intersecting, then a negative value is returned
     * equal to the penetration of the bodies, and the out1/out2 vectors
     * will still be meaningful with their difference being the minimum
     * translational vector to seperate the intersecting shapes of the bodies.
     * (This may not be a global seperation vector as it is considering only
     *  one pair of shapes at a time).
     * <br/><br/>
     * As the out1/out2 vectors are used to return values from the function,
     * this is one of the rare cases where should out1/out2 be weak Vec2's
     * they will 'not' be sent to the global object pool on being passed to
     * this function.
     * <pre>
     * var closest1 = Vec2.get();
     * var closest2 = Vec2.get();
     * var distance = Geom.distanceBody(body1, body2, out1, out2);
     * if (distance < 0) {
     *     trace("Bodies intersect and penetration distance is " +
     *           (-distance) + " with witness points " + closest1.toString() +
     *           " <-> " + closest2.toString());
     * }else {
     *     trace("Bodies do not intersect and distance betweem them is " +
     *           distance + " with closest points " + closest1.toString() +
     *           " <-> " + closest2.toString());
     * }
     * </pre>
     * This algorithm is able to take shortcuts in culling pair tests between Shapes
     * based on the current state of the search, and will be more effecient than
     * a custom implementation that uses Geom.distance(..) method.
     *
     * @param body1 First input Body.
     * @param body2 Second input Body.
     * @param out1 This Vec2 object will be populated with coordinates of
     *             closest point on body1.
     * @param out2 This Vec2 object will be populated with coordinates of
     *             closest point on body2.
     * @return The distance between the two bodies if seperated, or the
     *         penetration distance (negative) if intersecting.
     * @throws # If either body has no shapes.
     * @throws # If out1 or out2 has been disposed.
     * @throws # If out1 or out2 is immutable.
     */
    #if nape_swc@:keep #end
    public static function distanceBody(body1:Body,body2:Body,out1:Vec2,out2:Vec2):Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(out1!=null&&out1.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
            #end
        };
        {
            #if(!NAPE_RELEASE_BUILD)
            if(out2!=null&&out2.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
            #end
        };
        out1.zpp_inner.immutable();
        out2.zpp_inner.immutable();
        #if(!NAPE_RELEASE_BUILD)
        if(body1.shapes.empty()||body2.shapes.empty())throw "Error: Bodies cannot be empty in calculating distances";
        #end
        {
            var cx_ite=body1.zpp_inner.shapes.begin();
            while(cx_ite!=null){
                var i=cx_ite.elem();
                ZPP_Geom.validateShape(i);
                cx_ite=cx_ite.next;
            }
        };
        {
            var cx_ite=body2.zpp_inner.shapes.begin();
            while(cx_ite!=null){
                var i=cx_ite.elem();
                ZPP_Geom.validateShape(i);
                cx_ite=cx_ite.next;
            }
        };
        return ZPP_SweepDistance.distanceBody(body1.zpp_inner,body2.zpp_inner,out1.zpp_inner,out2.zpp_inner);
    }
    /**
     * Determine distance and closest points between two Shapes.
     * <br/><br/>
     * The input Shapes must belong to a Body so that their world positions
     * and orientations are defined; these Bodies need not be different nor
     * part of any Space.
     * <br/><br/>
     * If the shapes are intersecting, then a negative value is returned
     * equal to the penetration of the shapes, and the out1/out2 vectors
     * will still be meaningful with their difference being the minimum
     * translational vector to seperate the Shapes.
     * <br/><br/>
     * As the out1/out2 vectors are used to return values from the function,
     * this is one of the rare cases where should out1/out2 be weak Vec2's
     * they will 'not' be sent to the global object pool on being passed to
     * this function.
     * <pre>
     * var closest1 = Vec2.get();
     * var closest2 = Vec2.get();
     * var distance = Geom.distance(shape1, shape2, out1, out2);
     * if (distance < 0) {
     *     trace("Shapes intersect and penetration distance is " +
     *           (-distance) + " with witness points " + closest1.toString() +
     *           " <-> " + closest2.toString());
     * }else {
     *     trace("Shapes do not intersect and distance betweem them is " +
     *           distance + " with closest points " + closest1.toString() +
     *           " <-> " + closest2.toString());
     * }
     * </pre>
     *
     * @param shape1 this shape must belong to a Body.
     * @param shape2 this shape must belong to a Body.
     * @param out1 This Vec2 object will be populated with coordinates of
     *             closest point on shape1.
     * @param out2 This Vec2 object will be populated with coordinates of
     *             closest point on shape2.
     * @return The distance between the two shapes if seperated, or the
     *         penetration distance (negative) if intersecting.
     * @throws # If shape1.body is null or shape2.body is null.
     * @throws # If out1 or out2 has been disposed.
     * @throws # If out1 or out2 is immutable.
     */
    #if nape_swc@:keep #end
    public static function distance(shape1:Shape,shape2:Shape,out1:Vec2,out2:Vec2):Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(out1!=null&&out1.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
            #end
        };
        {
            #if(!NAPE_RELEASE_BUILD)
            if(out2!=null&&out2.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
            #end
        };
        out1.zpp_inner.immutable();
        out2.zpp_inner.immutable();
        #if(!NAPE_RELEASE_BUILD)
        if(shape1.body==null||shape2.body==null)throw "Error: Shape must be part of a Body to calculate distances";
        #end
        ZPP_Geom.validateShape(shape1.zpp_inner);
        ZPP_Geom.validateShape(shape2.zpp_inner);
        var tmp;
        {
            if(ZPP_Vec2.zpp_pool==null){
                tmp=new ZPP_Vec2();
                #if NAPE_POOL_STATS ZPP_Vec2.POOL_TOT++;
                ZPP_Vec2.POOL_ADDNEW++;
                #end
            }
            else{
                tmp=ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool=tmp.next;
                tmp.next=null;
                #if NAPE_POOL_STATS ZPP_Vec2.POOL_CNT--;
                ZPP_Vec2.POOL_ADD++;
                #end
            }
            tmp.alloc();
        };
        var ret=ZPP_SweepDistance.distance(shape1.zpp_inner,shape2.zpp_inner,out1.zpp_inner,out2.zpp_inner,tmp,ZPP_Const.FMAX);
        {
            var o=tmp;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Vec2"+", in obj: "+"tmp"+")");
                #end
            };
            o.free();
            o.next=ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Vec2.POOL_CNT++;
            ZPP_Vec2.POOL_SUB++;
            #end
        };
        return ret;
    }
    /**
     * Determine if two Bodies intersect.
     * <br/><br/>
     * If you do not need distance/penetration information,
     * then using this method will be more effecient than testing for a negative
     * value using the distance method.
     *
     * @param body1 First input Body .
     * @param body2 Second input Body.
     * @return True if the Bodies are intersecting.
     * @throws # If either body has no shapes.
     */
    #if nape_swc@:keep #end
    public static function intersectsBody(body1:Body,body2:Body){
        #if(!NAPE_RELEASE_BUILD)
        if(body1.shapes.empty()||body2.shapes.empty())throw "Error: Bodies must have shapes to test for intersection.";
        #end
        {
            var cx_ite=body1.zpp_inner.shapes.begin();
            while(cx_ite!=null){
                var i=cx_ite.elem();
                ZPP_Geom.validateShape(i);
                cx_ite=cx_ite.next;
            }
        };
        {
            var cx_ite=body2.zpp_inner.shapes.begin();
            while(cx_ite!=null){
                var i=cx_ite.elem();
                ZPP_Geom.validateShape(i);
                cx_ite=cx_ite.next;
            }
        };
        if(!body1.zpp_inner.aabb.intersect(body2.zpp_inner.aabb)){
            return false;
        }
        else{
            {
                var cx_ite=body1.zpp_inner.shapes.begin();
                while(cx_ite!=null){
                    var s1=cx_ite.elem();
                    {
                        {
                            var cx_ite=body2.zpp_inner.shapes.begin();
                            while(cx_ite!=null){
                                var s2=cx_ite.elem();
                                {
                                    if(ZPP_Collide.testCollide_safe(s1,s2)){
                                        return true;
                                    }
                                };
                                cx_ite=cx_ite.next;
                            }
                        };
                    };
                    cx_ite=cx_ite.next;
                }
            };
            return false;
        }
    }
    /**
     * Determine if two Shapes intersect.
     * <br/><br/>
     * The input Shapes must belong to a Body so that their world positions
     * and orientations are defined; these Bodies need not be different nor
     * part of any Space.
     * <br/><br/>
     * If you do not need distance/penetration information,
     * then using this method will be more effecient than testing for a negative
     * value using the distance method.
     *
     * @param shape1 this shape must belong to a Body.
     * @param shape2 this shape must belong to a Body.
     * @return True if the shapes are intersecting in world space.
     * @throws # If shape1.body or shape2.body is null.
     */
    #if nape_swc@:keep #end
    public static function intersects(shape1:Shape,shape2:Shape){
        #if(!NAPE_RELEASE_BUILD)
        if(shape1.body==null||shape2.body==null)throw "Error: Shape must be part of a Body to calculate intersection";
        #end
        ZPP_Geom.validateShape(shape1.zpp_inner);
        ZPP_Geom.validateShape(shape2.zpp_inner);
        return shape1.zpp_inner.aabb.intersect(shape2.zpp_inner.aabb)&&ZPP_Collide.testCollide_safe(shape1.zpp_inner,shape2.zpp_inner);
    }
    /**
     * Determine if one Shape is entirely contained within another.
     * <br/><br/>
     * The input Shapes must belong to a Body so that their world positions
     * and orientations are defined; these Bodies need not be different nor
     * part of any Space.
     *
     * @param shape1 this shape must belong to a Body.
     * @param shape2 this shape must belong to a Body.
     * @return True if shape2 is completely contained within shape1.
     * @throws # If shape1.body or shape2.body is null.
     */
    #if nape_swc@:keep #end
    public static function contains(shape1:Shape,shape2:Shape){
        #if(!NAPE_RELEASE_BUILD)
        if(shape1.body==null||shape2.body==null)throw "Error: Shape must be part of a Body to calculate containment";
        #end
        ZPP_Geom.validateShape(shape1.zpp_inner);
        ZPP_Geom.validateShape(shape2.zpp_inner);
        return ZPP_Collide.containTest(shape1.zpp_inner,shape2.zpp_inner);
    }
}
