package zpp_nape.shape;
import nape.Config;
import nape.geom.Mat23;
import nape.geom.Vec2;
import nape.shape.Circle;
import zpp_nape.geom.Mat23;
import zpp_nape.geom.Vec2;
import zpp_nape.shape.Shape.ZPP_Shape;
import zpp_nape.util.Flags.ZPP_Flags;
import zpp_nape.util.Math;
#if nape_swc@:keep #end
class ZPP_Circle extends ZPP_Shape{
    public var outer_zn:Circle=null;
    public var radius:Float=0.0;
    public function new(){
        super(ZPP_Flags.id_ShapeType_CIRCLE);
        circle=this;
        zip_localCOM=false;
    }
    public function __clear(){}
    public function invalidate_radius(){
        invalidate_area_inertia();
        invalidate_angDrag();
        invalidate_aabb();
        if(body!=null)body.wake();
    }
    private function localCOM_validate(){
        wrap_localCOM.zpp_inner.x=localCOMx;
        wrap_localCOM.zpp_inner.y=localCOMy;
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !((wrap_localCOM.zpp_inner.x!=wrap_localCOM.zpp_inner.x));
            };
            if(!res)throw "assert("+"!assert_isNaN(wrap_localCOM.zpp_inner.x)"+") :: "+("vec_set(in n: "+"wrap_localCOM.zpp_inner."+",in x: "+"localCOMx"+",in y: "+"localCOMy"+")");
            #end
        };
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !((wrap_localCOM.zpp_inner.y!=wrap_localCOM.zpp_inner.y));
            };
            if(!res)throw "assert("+"!assert_isNaN(wrap_localCOM.zpp_inner.y)"+") :: "+("vec_set(in n: "+"wrap_localCOM.zpp_inner."+",in x: "+"localCOMx"+",in y: "+"localCOMy"+")");
            #end
        };
    }
    private function localCOM_invalidate(x:ZPP_Vec2){
        {
            localCOMx=x.x;
            localCOMy=x.y;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((localCOMx!=localCOMx));
                };
                if(!res)throw "assert("+"!assert_isNaN(localCOMx)"+") :: "+("vec_set(in n: "+"localCOM"+",in x: "+"x.x"+",in y: "+"x.y"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((localCOMy!=localCOMy));
                };
                if(!res)throw "assert("+"!assert_isNaN(localCOMy)"+") :: "+("vec_set(in n: "+"localCOM"+",in x: "+"x.x"+",in y: "+"x.y"+")");
                #end
            };
        };
        invalidate_localCOM();
        if(body!=null)body.wake();
    }
    #if(!NAPE_RELEASE_BUILD)
    private function localCOM_immutable(){
        if(body!=null&&body.isStatic()&&body.space!=null)throw "Error: Cannot modify localCOM of Circle added to a static Body whilst within a Space";
    }
    #end
    public function setupLocalCOM(){
        var me=this;
        wrap_localCOM=Vec2.get(localCOMx,localCOMy);
        wrap_localCOM.zpp_inner._inuse=true;
        wrap_localCOM.zpp_inner._validate=localCOM_validate;
        wrap_localCOM.zpp_inner._invalidate=localCOM_invalidate;
        #if(!NAPE_RELEASE_BUILD)
        wrap_localCOM.zpp_inner._isimmutable=localCOM_immutable;
        #end
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function __validate_aabb(){
        validate_worldCOM();
        var rx:Float=radius;
        var ry:Float=radius;
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !((rx!=rx));
            };
            if(!res)throw "assert("+"!assert_isNaN(rx)"+") :: "+("vec_new(in n: "+"r"+",in x: "+"radius"+",in y: "+"radius"+")");
            #end
        };
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !((ry!=ry));
            };
            if(!res)throw "assert("+"!assert_isNaN(ry)"+") :: "+("vec_new(in n: "+"r"+",in x: "+"radius"+",in y: "+"radius"+")");
            #end
        };
        {
            aabb.minx=worldCOMx-rx;
            aabb.miny=worldCOMy-ry;
        };
        {
            aabb.maxx=worldCOMx+rx;
            aabb.maxy=worldCOMy+ry;
        };
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function _force_validate_aabb(){
        {
            worldCOMx=body.posx+(body.axisy*localCOMx-body.axisx*localCOMy);
            worldCOMy=body.posy+(localCOMx*body.axisx+localCOMy*body.axisy);
        };
        aabb.minx=worldCOMx-radius;
        aabb.miny=worldCOMy-radius;
        aabb.maxx=worldCOMx+radius;
        aabb.maxy=worldCOMy+radius;
    }
    public function __validate_sweepRadius(){
        sweepCoef=Math.sqrt((localCOMx*localCOMx+localCOMy*localCOMy));
        sweepRadius=sweepCoef+radius;
    }
    public function __validate_area_inertia(){
        var r2=radius*radius;
        area=r2*Math.PI;
        inertia=r2*0.5+(localCOMx*localCOMx+localCOMy*localCOMy);
    }
    public function __validate_angDrag(){
        var lc=(localCOMx*localCOMx+localCOMy*localCOMy);
        var r2=radius*radius;
        var skin=material.dynamicFriction*Config.fluidAngularDragFriction;
        angDrag=(lc+2*r2)*skin+0.5*Config.fluidAngularDrag*(1+Config.fluidVacuumDrag)*lc;
        angDrag/=(2*(lc+0.5*r2));
    }
    public function __scale(sx:Float,sy:Float){
        var factor=((sx<0?-sx:sx)+(sy<0?-sy:sy))/2;
        radius*=factor<0?-factor:factor;
        invalidate_radius();
        if((localCOMx*localCOMx+localCOMy*localCOMy)>0){
            localCOMx*=sx;
            localCOMy*=sy;
            invalidate_localCOM();
        }
    }
    public function __translate(x:Float,y:Float){
        {
            var t=(1.0);
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((t!=t));
                };
                if(!res)throw "assert("+"!assert_isNaN(t)"+") :: "+("vec_addeq(in a: "+"localCOM"+",in b: "+""+",in s: "+"1.0"+")");
                #end
            };
            localCOMx+=x*t;
            localCOMy+=y*t;
        };
        invalidate_localCOM();
    }
    public function __rotate(x:Float,y:Float){
        if((localCOMx*localCOMx+localCOMy*localCOMy)>0){
            var tx:Float=0.0;
            var ty:Float=0.0;
            {
                tx=(y*localCOMx-x*localCOMy);
                ty=(localCOMx*x+localCOMy*y);
            };
            {
                localCOMx=tx;
                localCOMy=ty;
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        !((localCOMx!=localCOMx));
                    };
                    if(!res)throw "assert("+"!assert_isNaN(localCOMx)"+") :: "+("vec_set(in n: "+"localCOM"+",in x: "+"tx"+",in y: "+"ty"+")");
                    #end
                };
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        !((localCOMy!=localCOMy));
                    };
                    if(!res)throw "assert("+"!assert_isNaN(localCOMy)"+") :: "+("vec_set(in n: "+"localCOM"+",in x: "+"tx"+",in y: "+"ty"+")");
                    #end
                };
            };
            invalidate_localCOM();
        }
    }
    public function __transform(m:Mat23){
        var det=(m.a*m.d-m.b*m.c);
        if(det<0)det=-det;
        radius*=Math.sqrt(det);
        {
            var t=m.a*localCOMx+m.b*localCOMy+m.tx;
            localCOMy=m.c*localCOMx+m.d*localCOMy+m.ty;
            localCOMx=t;
        };
        invalidate_radius();
        invalidate_localCOM();
    }
    public function __copy(){
        var ret=new Circle(radius).zpp_inner_zn;
        {
            ret.localCOMx=localCOMx;
            ret.localCOMy=localCOMy;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((ret.localCOMx!=ret.localCOMx));
                };
                if(!res)throw "assert("+"!assert_isNaN(ret.localCOMx)"+") :: "+("vec_set(in n: "+"ret.localCOM"+",in x: "+"localCOMx"+",in y: "+"localCOMy"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((ret.localCOMy!=ret.localCOMy));
                };
                if(!res)throw "assert("+"!assert_isNaN(ret.localCOMy)"+") :: "+("vec_set(in n: "+"ret.localCOM"+",in x: "+"localCOMx"+",in y: "+"localCOMy"+")");
                #end
            };
        };
        ret.zip_localCOM=false;
        return ret;
    }
}
