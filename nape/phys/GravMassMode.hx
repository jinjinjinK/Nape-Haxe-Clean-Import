package nape.phys;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Enumeration of GravMassMode values for a Body.
 */
@:final#if nape_swc@:keep #end
class GravMassMode{
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Flags.internal)throw "Error: Cannot instantiate "+"GravMassMode"+" derp!";
        #end
    }
    /**
     * @private
     */
    @:keep public function toString(){
        if(false)return "";
        
        else if(this==DEFAULT)return"DEFAULT";
        else if(this==FIXED)return"FIXED";
        else if(this==SCALED)return"SCALED";
        else return "";
    }
    /**
     * Default method of computation.
     * <br/><br/>
     * Mass seen by gravity equal to the Body mass.
     */
    #if nape_swc@:isVar #end
    public static var DEFAULT(get_DEFAULT,never):GravMassMode;
    inline static function get_DEFAULT(){
        if(ZPP_Flags.GravMassMode_DEFAULT==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.GravMassMode_DEFAULT=new GravMassMode();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.GravMassMode_DEFAULT;
    }
    /**
     * Fixed method of computation.
     * <br/><br/>
     * Mass seen by gravity set by user.
     */
    #if nape_swc@:isVar #end
    public static var FIXED(get_FIXED,never):GravMassMode;
    inline static function get_FIXED(){
        if(ZPP_Flags.GravMassMode_FIXED==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.GravMassMode_FIXED=new GravMassMode();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.GravMassMode_FIXED;
    }
    /**
     * Scaled method of computation.
     * <br/><br/>
     * Mass seen by gravity computed as a factor of the Body mass with
     * scaling factor set by user.
     */
    #if nape_swc@:isVar #end
    public static var SCALED(get_SCALED,never):GravMassMode;
    inline static function get_SCALED(){
        if(ZPP_Flags.GravMassMode_SCALED==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.GravMassMode_SCALED=new GravMassMode();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.GravMassMode_SCALED;
    }
}
