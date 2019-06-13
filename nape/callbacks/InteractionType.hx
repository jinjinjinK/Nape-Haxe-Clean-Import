package nape.callbacks;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Enumeration of Interaction types.
 */
@:final#if nape_swc@:keep #end
class InteractionType{
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Flags.internal)throw "Error: Cannot instantiate "+"InteractionType"+" derp!";
        #end
    }
    /**
     * @private
     */
    @:keep public function toString(){
        if(false)return "";
        
        else if(this==COLLISION)return"COLLISION";
        else if(this==SENSOR)return"SENSOR";
        else if(this==FLUID)return"FLUID";
        else if(this==ANY)return"ANY";
        else return "";
    }
    /**
     * Collision interaction type.
     */
    #if nape_swc@:isVar #end
    public static var COLLISION(get_COLLISION,never):InteractionType;
    inline static function get_COLLISION(){
        if(ZPP_Flags.InteractionType_COLLISION==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.InteractionType_COLLISION=new InteractionType();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.InteractionType_COLLISION;
    }
    /**
     * Sensor interaction type.
    ""*/#if nape_swc@:isVar #end
    public static var SENSOR(get_SENSOR,never):InteractionType;
    inline static function get_SENSOR(){
        if(ZPP_Flags.InteractionType_SENSOR==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.InteractionType_SENSOR=new InteractionType();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.InteractionType_SENSOR;
    }
    /**
     * Fluid interaction type.
     */
    #if nape_swc@:isVar #end
    public static var FLUID(get_FLUID,never):InteractionType;
    inline static function get_FLUID(){
        if(ZPP_Flags.InteractionType_FLUID==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.InteractionType_FLUID=new InteractionType();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.InteractionType_FLUID;
    }
    /**
     * Special enum corresponding to 'all' interaction types.
     */
    #if nape_swc@:isVar #end
    public static var ANY(get_ANY,never):InteractionType;
    inline static function get_ANY(){
        if(ZPP_Flags.InteractionType_ANY==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.InteractionType_ANY=new InteractionType();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.InteractionType_ANY;
    }
}
