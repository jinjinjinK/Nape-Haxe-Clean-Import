package nape.geom;
import nape.geom.Vec2;
import zpp_nape.geom.AABB;
import zpp_nape.geom.Vec2;
/**
 * Axis Aligned Bounding Box (AABB)
 * <br/><br/>
 * Note that in many cases of an AABB object being returned by a Nape function
 * the AABB object will be marked internally as an 'immutable' AABB. This will
 * always be documented and trying to mutate such an AABB will result in an
 * error being thrown.
 */
@:final#if nape_swc@:keep #end
class AABB{
    /**
     * @private
     */
    public var zpp_inner:ZPP_AABB=null;
    /**
     * Construct a new AABB.
     * <br/><br/>
     * As input width/height are permitted to be negative it is not guaranteed
     * that the resultant AABB will have the same parameters as those
     * specified as the AABB parameters are guaranteed to always have positive
     * width/height, and for x/y to always be the top-left corner.
     *
     * @param x      The x coordinate of the top-left corner of the AABB.
     *               (default 0)
     * @param y      The y coordinate of the top-left corner of the AABB
     *               (default 0)
     * @param width  The width of the AABB. This value may be negative.
     *               (default 0)
     * @param height The height of the AABB. This value may be negative.
     *               (default 0)
     * @return       The newly constructed AABB object.
     */
    public function new(x:Float=0,y:Float=0,width:Float=0,height:Float=0){
        #if(!NAPE_RELEASE_BUILD)
        if((x!=x)||(y!=y)){
            throw "Error: AABB position cannot be NaN";
        }
        if((width!=width)||(height!=height)){
            throw "Error: AABB dimensions cannot be NaN";
        }
        #end
        zpp_inner=ZPP_AABB.get(x,y,x+width,y+height);
        zpp_inner.outer=this;
    }
    /**
     * Produce a copy of this AABB.
     * <br/><br/>
     * As would be expected, if you produce a copy of an 'immutable' AABB then
     * the copy will be 'mutable'.
     *
     * @return The copy of this AABB.
     */
    #if nape_swc@:keep #end
    public function copy(){
        zpp_inner.validate();
        return zpp_inner.copy().wrapper();
    }
    #if(flash9||openfl||nme)
    /**
     * Construct an AABB from an AS3 Rectangle object.
     * <br/><br/>
     * This method is only available on <code>flash</code> and
     * <code>openfl||nme</code> targets.
     *
     * @param rect The AS3 Rectangle to construct AABB from, this value
     *             must not be null.
     * @return The constructed AABB matching the input Rectangle.
     * @throws # If the input rectangle is null.
     */
    #if nape_swc@:keep #end
    public static function fromRect(rect:flash.geom.Rectangle):AABB{
        #if(!NAPE_RELEASE_BUILD)
        if(rect==null){
            throw "Error: Cannot create AABB from null Rectangle";
        }
        #end
        return new AABB(rect.x,rect.y,rect.width,rect.height);
    }
    /**
     * Create an AS3 Rectangle object from AABB.
     * <br/><br/>
     * This method is available only on <code>flash</code> and
     * <code>openfl||nme</code> targets.
     *
     * @return The AS3 Rectangle object representing AABB.
     */
    #if nape_swc@:keep #end
    public function toRect():flash.geom.Rectangle{
        return new flash.geom.Rectangle(x,y,width,height);
    }
    #end
    /**
     * The minimum bounds for the AABB.
     * <br/><br/>
     * Euivalent to the top-left corner.
     * <br/>
     * This Vec2 is intrinsically linked to the AABB so that modifications
     * to this object are reflected in changes to the AABB and vice-versa.
     * <br/><br/>
     * If the AABB is immutable, then this Vec2 will also be immutable.
     * <br/><br/>
     * This value can be set with the = operator, equivalent to performing
     * <code>aabb.min.set(value)</code>.
     * @default (0, 0)
     */
    #if nape_swc@:isVar #end
    public var min(get_min,set_min):Vec2;
    inline function get_min():Vec2{
        return zpp_inner.getmin();
    }
    inline function set_min(min:Vec2):Vec2{
        {
            {
                #if(!NAPE_RELEASE_BUILD)
                if(min!=null&&min.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
                #end
            };
            #if(!NAPE_RELEASE_BUILD)
            if(zpp_inner._immutable){
                throw "Error: AABB is immutable";
            }
            if(min==null){
                throw "Error: Cannot assign null to AABB::"+"min";
            }
            if((x!=x)||(y!=y)){
                throw "Error: AABB::"+"min"+" components cannot be NaN";
            }
            if("min"=="min"){
                if(min.x>max.x)throw "Error: Assignment would cause negative width";
                if(min.y>max.y)throw "Error: Assignment would cause negative height";
            }
            else{
                if(min.x<min.x)throw "Error: Assignment would cause negative width";
                if(min.y<min.y)throw "Error: Assignment would cause negative height";
            }
            #end
            this.min.set(min);
        }
        return get_min();
    }
    /**
     * The maximum bounds for the AABB.
     * <br/><br/>
     * Euivalent to the bottom-right corner.
     * <br/>
     * This Vec2 is intrinsically linked to the AABB so that modifications
     * to this object are reflected in changes to the AABB and vice-versa.
     * <br/><br/>
     * If the AABB is immutable, then this Vec2 will also be immutable.
     * <br/><br/>
     * This value can be set with the = operator, equivalent to performing
     * <code>aabb.max.set(value)</code>.
     * @default (0, 0)
     */
    #if nape_swc@:isVar #end
    public var max(get_max,set_max):Vec2;
    inline function get_max():Vec2{
        return zpp_inner.getmax();
    }
    inline function set_max(max:Vec2):Vec2{
        {
            {
                #if(!NAPE_RELEASE_BUILD)
                if(max!=null&&max.zpp_disp)throw "Error: "+"Vec2"+" has been disposed and cannot be used!";
                #end
            };
            #if(!NAPE_RELEASE_BUILD)
            if(zpp_inner._immutable){
                throw "Error: AABB is immutable";
            }
            if(max==null){
                throw "Error: Cannot assign null to AABB::"+"max";
            }
            if((x!=x)||(y!=y)){
                throw "Error: AABB::"+"max"+" components cannot be NaN";
            }
            if("max"=="min"){
                if(max.x>max.x)throw "Error: Assignment would cause negative width";
                if(max.y>max.y)throw "Error: Assignment would cause negative height";
            }
            else{
                if(max.x<min.x)throw "Error: Assignment would cause negative width";
                if(max.y<min.y)throw "Error: Assignment would cause negative height";
            }
            #end
            this.max.set(max);
        }
        return get_max();
    }
    /**
     * The x coordinate of the AABB's top-left corner.
     * <br/><br/>
     * Equivalent to accessing/mutating min.x.
     * @default 0
     */
    #if nape_swc@:isVar #end
    public var x(get_x,set_x):Float;
    inline function get_x():Float{
        zpp_inner.validate();
        return zpp_inner.minx;
    }
    inline function set_x(x:Float):Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(zpp_inner._immutable){
                throw "Error: AABB is immutable";
            }
            #end
            if(this.x!=x){
                #if(!NAPE_RELEASE_BUILD)
                if((x!=x))throw "Error: AABB::"+"x"+" cannot be NaN";
                #end
                zpp_inner.maxx+=x-zpp_inner.minx;
                zpp_inner.minx=x;
                zpp_inner.invalidate();
            }
        }
        return get_x();
    }
    /**
     * The y coordinate of the AABB's top-left corner.
     * <br/><br/>
     * Equivalent to accessing/mutating min.y.
     * @default 0
     */
    #if nape_swc@:isVar #end
    public var y(get_y,set_y):Float;
    inline function get_y():Float{
        zpp_inner.validate();
        return zpp_inner.miny;
    }
    inline function set_y(y:Float):Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(zpp_inner._immutable){
                throw "Error: AABB is immutable";
            }
            #end
            if(this.y!=y){
                #if(!NAPE_RELEASE_BUILD)
                if((y!=y))throw "Error: AABB::"+"y"+" cannot be NaN";
                #end
                zpp_inner.maxy+=y-zpp_inner.miny;
                zpp_inner.miny=y;
                zpp_inner.invalidate();
            }
        }
        return get_y();
    }
    /**
     * width of AABB.
     * <br/><br/>
     * This value is and must always be positive.
     * @default 0
     */
    #if nape_swc@:isVar #end
    public var width(get_width,set_width):Float;
    inline function get_width():Float{
        zpp_inner.validate();
        return zpp_inner.width();
    }
    inline function set_width(width:Float):Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(zpp_inner._immutable){
                throw "Error: AABB is immutable";
            }
            #end
            if(this.width!=width){
                #if(!NAPE_RELEASE_BUILD)
                if((width!=width)){
                    throw "Error: AABB::"+"width"+" cannot be NaN";
                }
                if(width<0){
                    throw "Error: AABB::"+"width"+" ("+width+") must be >= 0";
                }
                #end
                zpp_inner.maxx=this.x+width;
                zpp_inner.invalidate();
            }
        }
        return get_width();
    }
    /**
     * height of AABB.
     * <br/><br/>
     * This value is and must always be positive.
     * @default 0
     */
    #if nape_swc@:isVar #end
    public var height(get_height,set_height):Float;
    inline function get_height():Float{
        zpp_inner.validate();
        return zpp_inner.height();
    }
    inline function set_height(height:Float):Float{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(zpp_inner._immutable){
                throw "Error: AABB is immutable";
            }
            #end
            if(this.height!=height){
                #if(!NAPE_RELEASE_BUILD)
                if((height!=height)){
                    throw "Error: AABB::"+"height"+" cannot be NaN";
                }
                if(height<0){
                    throw "Error: AABB::"+"height"+" ("+height+") must be >= 0";
                }
                #end
                zpp_inner.maxy=this.y+height;
                zpp_inner.invalidate();
            }
        }
        return get_height();
    }
    /**
     * @private
     */
    @:keep public function toString(){
        zpp_inner.validate();
        return zpp_inner.toString();
    }
}
