package nape.geom;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Enumeration represents the winding of a Polygon.
 * <br/><br/>
 * To appreciate what the winding of a polygon means, think of a polygon who's
 * vertices are the numbers on a clock face.
 *
 * If the vertices are ordered <code>12 -&gt; 1 -&gt; 2 ... -&gt; 12</code>
 * then this polygon is clockwise wound. The reverse order would mean the
 * polygon is wound anticlockwise.
 */
@:final#if nape_swc@:keep #end
class Winding{
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Flags.internal)throw "Error: Cannot instantiate "+"Winding"+" derp!";
        #end
    }
    /**
     * @private
     */
    @:keep public function toString(){
        if(false)return "";
        
        else if(this==UNDEFINED)return"UNDEFINED";
        else if(this==CLOCKWISE)return"CLOCKWISE";
        else if(this==ANTICLOCKWISE)return"ANTICLOCKWISE";
        else return "";
    }
    /**
     * Value represents that the polygon has no discernible, or ambiguous winding
     * <br/><br/>
     * This may be because the polygon is degenerate, or because it is self
     * intersecting. In either case it is not well defined to say that the winding
     * is either clockwise or anticlockwise.
     */
    #if nape_swc@:isVar #end
    public static var UNDEFINED(get_UNDEFINED,never):Winding;
    inline static function get_UNDEFINED(){
        if(ZPP_Flags.Winding_UNDEFINED==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.Winding_UNDEFINED=new Winding();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.Winding_UNDEFINED;
    }
    /**
     * Value represents that the polygon is wound clockwise.
     */
    #if nape_swc@:isVar #end
    public static var CLOCKWISE(get_CLOCKWISE,never):Winding;
    inline static function get_CLOCKWISE(){
        if(ZPP_Flags.Winding_CLOCKWISE==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.Winding_CLOCKWISE=new Winding();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.Winding_CLOCKWISE;
    }
    /**
     * Value represents that the polygon is wound anticlockwise.
     */
    #if nape_swc@:isVar #end
    public static var ANTICLOCKWISE(get_ANTICLOCKWISE,never):Winding;
    inline static function get_ANTICLOCKWISE(){
        if(ZPP_Flags.Winding_ANTICLOCKWISE==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.Winding_ANTICLOCKWISE=new Winding();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.Winding_ANTICLOCKWISE;
    }
}
