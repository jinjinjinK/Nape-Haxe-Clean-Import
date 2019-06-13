package nape.dynamics;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Enumeration of Arbiter types.
 */
@:final#if nape_swc@:keep #end
class ArbiterType{
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Flags.internal)throw "Error: Cannot instantiate "+"ArbiterType"+" derp!";
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
        else return "";
    }
    /**
     * Collision type Arbiter.
     */
    #if nape_swc@:isVar #end
    public static var COLLISION(get_COLLISION,never):ArbiterType;
    inline static function get_COLLISION(){
        if(ZPP_Flags.ArbiterType_COLLISION==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.ArbiterType_COLLISION=new ArbiterType();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.ArbiterType_COLLISION;
    }
    /**
     * Sensor type Arbiter.
     */
    #if nape_swc@:isVar #end
    public static var SENSOR(get_SENSOR,never):ArbiterType;
    inline static function get_SENSOR(){
        if(ZPP_Flags.ArbiterType_SENSOR==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.ArbiterType_SENSOR=new ArbiterType();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.ArbiterType_SENSOR;
    }
    /**
     * Fluid type Arbiter.
     */
    #if nape_swc@:isVar #end
    public static var FLUID(get_FLUID,never):ArbiterType;
    inline static function get_FLUID(){
        if(ZPP_Flags.ArbiterType_FLUID==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.ArbiterType_FLUID=new ArbiterType();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.ArbiterType_FLUID;
    }
}
