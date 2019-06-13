package nape.phys;
import nape.geom.Vec2;
import nape.shape.ShapeList;
import zpp_nape.geom.Vec2;
import zpp_nape.phys.FluidProperties;
import zpp_nape.util.Lists.ZPP_ShapeList;
/**
 * FluidProperties providing shared parameters for fluid interaction.
 */
@:final#if nape_swc@:keep #end
class FluidProperties{
    /**
     * @private
     */
    public var zpp_inner:ZPP_FluidProperties=null;
    /**
     * Dynamic object for user to store additional data.
     * <br/><br/>
     * This object cannot be set, only its dynamically created
     * properties may be set. In AS3 the type of this property is &#42
     * <br/><br/>
     * This object will be lazily constructed so that until accessed
     * for the first time, will be null internally.
     *
     * @default {}
     */
    #if nape_swc@:isVar #end
    public var userData(get_userData,never):Dynamic<Dynamic>;
    inline function get_userData():Dynamic<Dynamic>{
        if(zpp_inner.userData==null){
            zpp_inner.userData=cast{};
        }
        return zpp_inner.userData;
    }
    /**
     * Set of all active shapes using this object.
     * <br/><br/>
     * Activeness of a shape in the sense that the Shape's Body is inside of a Space.
     * <br/><br/>
     * This list is immutable.
     */
    #if nape_swc@:isVar #end
    public var shapes(get_shapes,never):ShapeList;
    inline function get_shapes():ShapeList{
        if(zpp_inner.wrap_shapes==null)zpp_inner.wrap_shapes=ZPP_ShapeList.get(zpp_inner.shapes,true);
        return zpp_inner.wrap_shapes;
    }
    /**
     * Construct a new FluidProperties objects.
     *
     * @param density The density of the fluid in g/px/px. (default 1)
     * @param viscosity The viscosity of the fluid for drag computations in kg/px/s
     *                  (default 1)
     * @return The constructed FluidProperties object.
     */
    public function new(density:Float=1,viscosity:Float=1){
        {
            if(ZPP_FluidProperties.zpp_pool==null){
                zpp_inner=new ZPP_FluidProperties();
                #if NAPE_POOL_STATS ZPP_FluidProperties.POOL_TOT++;
                ZPP_FluidProperties.POOL_ADDNEW++;
                #end
            }
            else{
                zpp_inner=ZPP_FluidProperties.zpp_pool;
                ZPP_FluidProperties.zpp_pool=zpp_inner.next;
                zpp_inner.next=null;
                #if NAPE_POOL_STATS ZPP_FluidProperties.POOL_CNT--;
                ZPP_FluidProperties.POOL_ADD++;
                #end
            }
            zpp_inner.alloc();
        };
        zpp_inner.outer=this;
        this.density=density;
        this.viscosity=viscosity;
    }
    /**
     * Produce a copy of this FluidProperties object.
     * <br/><br/>
     * The copied object will be identical in all properties with the the
     * copied userData being assigned the same fields as 'this' Shape with the
     * same values copied over by reference for object types.
     *
     * @return The copied FluidProperties.
     */
    #if nape_swc@:keep #end
    public function copy(){
        var ret=new FluidProperties(density,viscosity);
        if(zpp_inner.userData!=null)ret.zpp_inner.userData=Reflect.copy(zpp_inner.userData);
        ret.gravity=this.gravity;
        return ret;
    }
    /**
     * Density of fluid.
     * <br/><br/>
     * This value, like Material density is of g/pixel/pixel.
     * @default 1
     */
    #if nape_swc@:isVar #end
    public var density(get_density,set_density):Float;
    inline function get_density():Float{
        return zpp_inner.density*("density"=="density"?1000:1);
    }
    inline function set_density(density:Float):Float{
        {
            if(density!=this.density){
                #if(!NAPE_RELEASE_BUILD)
                if((density!=density))throw "Error: FluidProperties::"+"density"+" cannot be NaN";
                if("density"!="density"&&density<0)throw "Error: FluidProperties::"+"density"+" ("+density+") must be >= 0";
                #end
                zpp_inner.density=density/("density"=="density"?1000:1);
                zpp_inner.invalidate();
            }
        }
        return get_density();
    }
    /**
     * Viscosity of fluid.
     * <br/><br/>
     * This value is used in drag comutations, the higher the viscosity the
     * more quickly objects will come to rest in the fluid.
     * @default 1
     */
    #if nape_swc@:isVar #end
    public var viscosity(get_viscosity,set_viscosity):Float;
    inline function get_viscosity():Float{
        return zpp_inner.viscosity*("viscosity"=="density"?1000:1);
    }
    inline function set_viscosity(viscosity:Float):Float{
        {
            if(viscosity!=this.viscosity){
                #if(!NAPE_RELEASE_BUILD)
                if((viscosity!=viscosity))throw "Error: FluidProperties::"+"viscosity"+" cannot be NaN";
                if("viscosity"!="density"&&viscosity<0)throw "Error: FluidProperties::"+"viscosity"+" ("+viscosity+") must be >= 0";
                #end
                zpp_inner.viscosity=viscosity/("viscosity"=="density"?1000:1);
                zpp_inner.invalidate();
            }
        }
        return get_viscosity();
    }
    /**
     * Local gravity for buoyancy computations.
     * <br/><br/>
     * When this value is not null, it will be used in place of the Space gravity
     * when performing buoyancy computations.
     */
    #if nape_swc@:isVar #end
    public var gravity(get_gravity,set_gravity):Null<Vec2>;
    inline function get_gravity():Null<Vec2>{
        return zpp_inner.wrap_gravity;
    }
    inline function set_gravity(gravity:Null<Vec2>):Null<Vec2>{
        {
            if(gravity==null){
                if(zpp_inner.wrap_gravity!=null){
                    zpp_inner.wrap_gravity.zpp_inner._inuse=false;
                    zpp_inner.wrap_gravity.dispose();
                    zpp_inner.wrap_gravity=null;
                }
            }
            else{
                {
                    #if(!NAPE_RELEASE_BUILD)
                    if(gravity!=null&&gravity.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
                    #end
                };
                if(zpp_inner.wrap_gravity==null)zpp_inner.getgravity();
                this.gravity.set(gravity);
            }
        }
        return get_gravity();
    }
    /**
     * @private
     */
    @:keep public function toString(){
        return "{ density: "+density+" viscosity: "+viscosity+" gravity: "+gravity+" }";
    }
}
