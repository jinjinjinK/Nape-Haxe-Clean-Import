package nape.phys;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Enumeration of MassMode values for a Body.
 */
@:final#if nape_swc@:keep #end
class MassMode{
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Flags.internal)throw "Error: Cannot instantiate "+"MassMode"+" derp!";
        #end
    }
    /**
     * @private
     */
    @:keep public function toString(){
        if(false)return "";
        
        else if(this==DEFAULT)return"DEFAULT";
        else if(this==FIXED)return"FIXED";
        else return "";
    }
    /**
     * Default method of computation.
     * <br/><br/>
     * Mass will be computed based on Body's Shape's areas and densities.
     */
    #if nape_swc@:isVar #end
    public static var DEFAULT(get_DEFAULT,never):MassMode;
    inline static function get_DEFAULT(){
        if(ZPP_Flags.MassMode_DEFAULT==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.MassMode_DEFAULT=new MassMode();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.MassMode_DEFAULT;
    }
    /**
     * Fixed method of computation.
     * <br/><br/>
     * Mass set by user.
     */
    #if nape_swc@:isVar #end
    public static var FIXED(get_FIXED,never):MassMode;
    inline static function get_FIXED(){
        if(ZPP_Flags.MassMode_FIXED==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.MassMode_FIXED=new MassMode();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.MassMode_FIXED;
    }
}
