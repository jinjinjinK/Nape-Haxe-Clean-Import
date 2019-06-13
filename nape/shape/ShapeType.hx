package nape.shape;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Enumeration of Nape Shape types.
 */
@:final#if nape_swc@:keep #end
class ShapeType{
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Flags.internal)throw "Error: Cannot instantiate "+"ShapeType"+" derp!";
        #end
    }
    /**
     * @private
     */
    @:keep public function toString(){
        if(false)return "";
        
        else if(this==CIRCLE)return"CIRCLE";
        else if(this==POLYGON)return"POLYGON";
        else return "";
    }
    /**
     * Circle shape type
     */
    #if nape_swc@:isVar #end
    public static var CIRCLE(get_CIRCLE,never):ShapeType;
    inline static function get_CIRCLE(){
        if(ZPP_Flags.ShapeType_CIRCLE==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.ShapeType_CIRCLE=new ShapeType();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.ShapeType_CIRCLE;
    }
    /**
     * Polygon shape type
     */
    #if nape_swc@:isVar #end
    public static var POLYGON(get_POLYGON,never):ShapeType;
    inline static function get_POLYGON(){
        if(ZPP_Flags.ShapeType_POLYGON==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.ShapeType_POLYGON=new ShapeType();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.ShapeType_POLYGON;
    }
}
