package zpp_nape.space;
import nape.geom.Mat23;
import nape.geom.RayResult;
import nape.geom.RayResultList;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyList;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.shape.Shape;
import nape.shape.ShapeList;
import zpp_nape.dynamics.InteractionFilter.ZPP_InteractionFilter;
import zpp_nape.geom.AABB.ZPP_AABB;
import zpp_nape.geom.Mat23;
import zpp_nape.geom.Ray.ZPP_Ray;
import zpp_nape.geom.Vec2;
import zpp_nape.phys.Body;
import zpp_nape.shape.Circle;
import zpp_nape.shape.Polygon;
import zpp_nape.shape.Shape;
import zpp_nape.space.DynAABBPhase.ZPP_DynAABBPhase;
import zpp_nape.space.Space.ZPP_Space;
import zpp_nape.space.SweepPhase.ZPP_SweepPhase;
#if nape_swc@:keep #end
class ZPP_Broadphase{
    public var space:ZPP_Space=null;
    public var is_sweep:Bool=false;
    public var sweep:ZPP_SweepPhase=null;
    public var dynab:ZPP_DynAABBPhase=null;
    public function insert(shape:ZPP_Shape){
        if(is_sweep)sweep.__insert(shape);
        else dynab.__insert(shape);
    }
    public function remove(shape:ZPP_Shape){
        if(is_sweep)sweep.__remove(shape);
        else dynab.__remove(shape);
    }
    public function sync(shape:ZPP_Shape){
        if(is_sweep)sweep.__sync(shape);
        else dynab.__sync(shape);
    }
    public function broadphase(space:ZPP_Space,discrete:Bool){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("not implemented");
            #end
        };
    }
    public function clear(){}
    public function shapesUnderPoint(x:Float,y:Float,filter:ZPP_InteractionFilter,output:ShapeList):ShapeList{
        return null;
    }
    public function bodiesUnderPoint(x:Float,y:Float,filter:ZPP_InteractionFilter,output:BodyList):BodyList{
        return null;
    }
    public var aabbShape:Shape=null;
    public var matrix:Mat23=null;
    public function updateAABBShape(aabb:ZPP_AABB){
        if(aabbShape==null){
            var body=new Body(BodyType.STATIC);
            body.shapes.add(aabbShape=new Polygon(Polygon.rect(aabb.minx,aabb.miny,aabb.width(),aabb.height())));
        }
        else{
            var ab=aabbShape.zpp_inner.aabb;
            var sx=aabb.width()/ab.width();
            var sy=aabb.height()/ab.height();
            if(matrix==null)matrix=new Mat23();
            matrix.a=sx;
            matrix.b=matrix.c=0;
            matrix.d=sy;
            matrix.tx=aabb.minx-sx*ab.minx;
            matrix.ty=aabb.miny-sy*ab.miny;
            aabbShape.transform(matrix);
        }
        aabbShape.zpp_inner.validate_aabb();
        aabbShape.zpp_inner.polygon.validate_gaxi();
    }
    public function shapesInAABB(aabb:ZPP_AABB,strict:Bool,containment:Bool,filter:ZPP_InteractionFilter,output:ShapeList):ShapeList{
        return null;
    }
    public function bodiesInAABB(aabb:ZPP_AABB,strict:Bool,containment:Bool,filter:ZPP_InteractionFilter,output:BodyList):BodyList{
        return null;
    }
    public var circShape:Shape=null;
    public function updateCircShape(x:Float,y:Float,r:Float){
        if(circShape==null){
            var body=new Body(BodyType.STATIC);
            body.shapes.add(circShape=new Circle(r,Vec2.get(x,y)));
        }
        else{
            var ci=circShape.zpp_inner.circle;
            var ss=r/ci.radius;
            if(matrix==null)matrix=new Mat23();
            matrix.a=matrix.d=ss;
            matrix.b=matrix.c=0;
            matrix.tx=x-ss*ci.localCOMx;
            matrix.ty=y-ss*ci.localCOMy;
            circShape.transform(matrix);
        }
        circShape.zpp_inner.validate_aabb();
    }
    public function shapesInCircle(x:Float,y:Float,r:Float,containment:Bool,filter:ZPP_InteractionFilter,output:ShapeList):ShapeList{
        return null;
    }
    public function bodiesInCircle(x:Float,y:Float,r:Float,containment:Bool,filter:ZPP_InteractionFilter,output:BodyList):BodyList{
        return null;
    }
    public function validateShape(s:ZPP_Shape){
        if(s.isPolygon())s.polygon.validate_gaxi();
        s.validate_aabb();
        s.validate_worldCOM();
    }
    public function shapesInShape(shape:ZPP_Shape,containment:Bool,filter:ZPP_InteractionFilter,output:ShapeList):ShapeList{
        return null;
    }
    public function bodiesInShape(shape:ZPP_Shape,containment:Bool,filter:ZPP_InteractionFilter,output:BodyList):BodyList{
        return null;
    }
    public function rayCast(ray:ZPP_Ray,inner:Bool,filter:ZPP_InteractionFilter):RayResult{
        return null;
    }
    public function rayMultiCast(ray:ZPP_Ray,inner:Bool,filter:ZPP_InteractionFilter,output:RayResultList):RayResultList{
        return null;
    }
}
