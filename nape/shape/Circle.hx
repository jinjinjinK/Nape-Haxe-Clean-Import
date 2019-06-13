package nape.shape;
import nape.Config;
import nape.callbacks.CbType;
import nape.dynamics.InteractionFilter;
import nape.geom.Vec2;
import nape.phys.Material;
import nape.shape.Shape;
import zpp_nape.callbacks.CbType;
import zpp_nape.dynamics.InteractionFilter;
import zpp_nape.geom.Vec2;
import zpp_nape.phys.Material;
import zpp_nape.shape.Circle;
import zpp_nape.shape.Shape;
/**
 * Shape subtype representing a Circle
 */
@:final#if nape_swc@:keep #end
class Circle extends Shape{
    /**
     * @private
     */
    public var zpp_inner_zn:ZPP_Circle=null;
    /**
     * Construct a new Circle
     *
     * @param radius The radius of the circle, this value must be positive.
     * @param localCOM The local offset for the circle. (default &#40;0,0&#41;)
     * @param material The material for this circle. (default new Material&#40;&#41;)
     * @param filter The interaction filter for this circle.
     *               (default new InteractionFilter&#40;&#41;)
     * @return The constructed Circle
     * @throws # If radius is not strictly positive
     * @throws # If localCOM is non-null, but has been disposed of.
     */
    #if flib@:keep function flibopts_3(){}
    #end
    public function new(radius:Float,localCOM:Vec2=null,material:Material=null,filter:InteractionFilter=null){
        #if(!NAPE_RELEASE_BUILD)
        Shape.zpp_internalAlloc=true;
        super();
        Shape.zpp_internalAlloc=false;
        #end
        #if NAPE_RELEASE_BUILD 
        super();
        #end
        zpp_inner_zn=new ZPP_Circle();
        zpp_inner_zn.outer=this;
        zpp_inner_zn.outer_zn=this;
        zpp_inner=zpp_inner_zn;
        zpp_inner_i=zpp_inner;
        zpp_inner_i.outer_i=this;
        this.radius=radius;
        if(localCOM==null){
            zpp_inner.localCOMx=0;
            zpp_inner.localCOMy=0;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((zpp_inner.localCOMx!=zpp_inner.localCOMx));
                };
                if(!res)throw "assert("+"!assert_isNaN(zpp_inner.localCOMx)"+") :: "+("vec_set(in n: "+"zpp_inner.localCOM"+",in x: "+"0"+",in y: "+"0"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((zpp_inner.localCOMy!=zpp_inner.localCOMy));
                };
                if(!res)throw "assert("+"!assert_isNaN(zpp_inner.localCOMy)"+") :: "+("vec_set(in n: "+"zpp_inner.localCOM"+",in x: "+"0"+",in y: "+"0"+")");
                #end
            };
        };
        else{
            {
                #if(!NAPE_RELEASE_BUILD)
                if(localCOM!=null&&localCOM.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
                #end
            };
            {
                zpp_inner.localCOMx=localCOM.x;
                zpp_inner.localCOMy=localCOM.y;
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        !((zpp_inner.localCOMx!=zpp_inner.localCOMx));
                    };
                    if(!res)throw "assert("+"!assert_isNaN(zpp_inner.localCOMx)"+") :: "+("vec_set(in n: "+"zpp_inner.localCOM"+",in x: "+"localCOM.x"+",in y: "+"localCOM.y"+")");
                    #end
                };
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        !((zpp_inner.localCOMy!=zpp_inner.localCOMy));
                    };
                    if(!res)throw "assert("+"!assert_isNaN(zpp_inner.localCOMy)"+") :: "+("vec_set(in n: "+"zpp_inner.localCOM"+",in x: "+"localCOM.x"+",in y: "+"localCOM.y"+")");
                    #end
                };
            };
            ({
                if(({
                    localCOM.zpp_inner.weak;
                })){
                    localCOM.dispose();
                    true;
                }
                else{
                    false;
                }
            });
        }
        if(material==null){
            if(ZPP_Material.zpp_pool==null){
                zpp_inner.material=new ZPP_Material();
                #if NAPE_POOL_STATS ZPP_Material.POOL_TOT++;
                ZPP_Material.POOL_ADDNEW++;
                #end
            }
            else{
                zpp_inner.material=ZPP_Material.zpp_pool;
                ZPP_Material.zpp_pool=zpp_inner.material.next;
                zpp_inner.material.next=null;
                #if NAPE_POOL_STATS ZPP_Material.POOL_CNT--;
                ZPP_Material.POOL_ADD++;
                #end
            }
            zpp_inner.material.alloc();
        };
        else this.material=material;
        if(filter==null){
            if(ZPP_InteractionFilter.zpp_pool==null){
                zpp_inner.filter=new ZPP_InteractionFilter();
                #if NAPE_POOL_STATS ZPP_InteractionFilter.POOL_TOT++;
                ZPP_InteractionFilter.POOL_ADDNEW++;
                #end
            }
            else{
                zpp_inner.filter=ZPP_InteractionFilter.zpp_pool;
                ZPP_InteractionFilter.zpp_pool=zpp_inner.filter.next;
                zpp_inner.filter.next=null;
                #if NAPE_POOL_STATS ZPP_InteractionFilter.POOL_CNT--;
                ZPP_InteractionFilter.POOL_ADD++;
                #end
            }
            zpp_inner.filter.alloc();
        };
        else this.filter=filter;
        zpp_inner_i.insert_cbtype(CbType.ANY_SHAPE.zpp_inner);
    }
    /**
     * Radius of circle
     * <br/><br/>
     * This value must be strictly positive, and attempting to set this value
     * whilst this Circle is part of a static Body inside a Space will result
     * in a debug time error.
     */
    #if nape_swc@:isVar #end
    public var radius(get_radius,set_radius):Float;
    inline function get_radius():Float{
        return zpp_inner_zn.radius;
    }
    inline function set_radius(radius:Float):Float{
        {
            zpp_inner.immutable_midstep("Circle::radius");
            #if(!NAPE_RELEASE_BUILD)
            if(zpp_inner.body!=null&&zpp_inner.body.isStatic()&&zpp_inner.body.space!=null)throw "Error: Cannot modifiy radius of Circle contained in static object once added to space";
            #end
            if(radius!=this.radius){
                #if(!NAPE_RELEASE_BUILD)
                if((radius!=radius))throw "Error: Circle::radius cannot be NaN";
                if(radius<Config.epsilon)throw "Error: Circle::radius ("+radius+") must be > Config.epsilon";
                if(radius>ZPP_Const.FMAX)throw "Error: Circle::radius ("+radius+") must be < PR(Const).FMAX";
                #end
                zpp_inner_zn.radius=radius;
                zpp_inner_zn.invalidate_radius();
            }
        }
        return get_radius();
    }
}
