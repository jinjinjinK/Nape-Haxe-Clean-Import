package nape.phys;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Enumeration of InertiaMode values for a Body.
 */
@:final#if nape_swc@:keep #end
class InertiaMode{
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Flags.internal)throw "Error: Cannot instantiate "+"InertiaMode"+" derp!";
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
     * Moment of inertia will be computed based on Body's Shape's inertias and densities.
     */
    #if nape_swc@:isVar #end
    public static var DEFAULT(get_DEFAULT,never):InertiaMode;
    inline static function get_DEFAULT(){
        if(ZPP_Flags.InertiaMode_DEFAULT==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.InertiaMode_DEFAULT=new InertiaMode();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.InertiaMode_DEFAULT;
    }
    /**
     * Fixed method of computation.
     * <br/><br/>
     * Moment of inertia set by user.
     */
    #if nape_swc@:isVar #end
    public static var FIXED(get_FIXED,never):InertiaMode;
    inline static function get_FIXED(){
        if(ZPP_Flags.InertiaMode_FIXED==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.InertiaMode_FIXED=new InertiaMode();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.InertiaMode_FIXED;
    }
}
