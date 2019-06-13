package nape.callbacks;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Enumeration of interaction states for arbiters. These values are returned
 * by PreListener callback handlers.
 */
@:final#if nape_swc@:keep #end
class PreFlag{
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Flags.internal)throw "Error: Cannot instantiate "+"PreFlag"+" derp!";
        #end
    }
    /**
     * @private
     */
    @:keep public function toString(){
        if(false)return "";
        
        else if(this==ACCEPT)return"ACCEPT";
        else if(this==IGNORE)return"IGNORE";
        else if(this==ACCEPT_ONCE)return"ACCEPT_ONCE";
        else if(this==IGNORE_ONCE)return"IGNORE_ONCE";
        else return "";
    }
    /**
     * Value denotes interaction will occur, and Nape will not ask again.
     */
    #if nape_swc@:isVar #end
    public static var ACCEPT(get_ACCEPT,never):PreFlag;
    inline static function get_ACCEPT(){
        if(ZPP_Flags.PreFlag_ACCEPT==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.PreFlag_ACCEPT=new PreFlag();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.PreFlag_ACCEPT;
    }
    /**
     * Value denotes interaction will be ignored, and Nape will not ask again.
     */
    #if nape_swc@:isVar #end
    public static var IGNORE(get_IGNORE,never):PreFlag;
    inline static function get_IGNORE(){
        if(ZPP_Flags.PreFlag_IGNORE==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.PreFlag_IGNORE=new PreFlag();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.PreFlag_IGNORE;
    }
    /**
     * Value denotes interaction will occur 'this' step, and Nape will ask what
     * to do again in the following step if interaction is still possible.
     */
    #if nape_swc@:isVar #end
    public static var ACCEPT_ONCE(get_ACCEPT_ONCE,never):PreFlag;
    inline static function get_ACCEPT_ONCE(){
        if(ZPP_Flags.PreFlag_ACCEPT_ONCE==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.PreFlag_ACCEPT_ONCE=new PreFlag();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.PreFlag_ACCEPT_ONCE;
    }
    /**
     * Value denotes interaction will be ignored 'this' step, and Nape will ask what
     * to do again in the following step if interaction is still possible.
     */
    #if nape_swc@:isVar #end
    public static var IGNORE_ONCE(get_IGNORE_ONCE,never):PreFlag;
    inline static function get_IGNORE_ONCE(){
        if(ZPP_Flags.PreFlag_IGNORE_ONCE==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.PreFlag_IGNORE_ONCE=new PreFlag();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.PreFlag_IGNORE_ONCE;
    }
}
