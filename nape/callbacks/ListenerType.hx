package nape.callbacks;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Enumeration of Listener types.
 */
@:final#if nape_swc@:keep #end
class ListenerType{
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Flags.internal)throw "Error: Cannot instantiate "+"ListenerType"+" derp!";
        #end
    }
    /**
     * @private
     */
    @:keep public function toString(){
        if(false)return "";
        
        else if(this==BODY)return"BODY";
        else if(this==CONSTRAINT)return"CONSTRAINT";
        else if(this==INTERACTION)return"INTERACTION";
        else if(this==PRE)return"PRE";
        else return "";
    }
    /**
     * Type for BodyListeners
     */
    #if nape_swc@:isVar #end
    public static var BODY(get_BODY,never):ListenerType;
    inline static function get_BODY(){
        if(ZPP_Flags.ListenerType_BODY==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.ListenerType_BODY=new ListenerType();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.ListenerType_BODY;
    }
    /**
     * Type for ConstraintListeners
     */
    #if nape_swc@:isVar #end
    public static var CONSTRAINT(get_CONSTRAINT,never):ListenerType;
    inline static function get_CONSTRAINT(){
        if(ZPP_Flags.ListenerType_CONSTRAINT==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.ListenerType_CONSTRAINT=new ListenerType();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.ListenerType_CONSTRAINT;
    }
    /**
     * Type for InteractionListeners
     */
    #if nape_swc@:isVar #end
    public static var INTERACTION(get_INTERACTION,never):ListenerType;
    inline static function get_INTERACTION(){
        if(ZPP_Flags.ListenerType_INTERACTION==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.ListenerType_INTERACTION=new ListenerType();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.ListenerType_INTERACTION;
    }
    /**
     * Type for PreListeners
     */
    #if nape_swc@:isVar #end
    public static var PRE(get_PRE,never):ListenerType;
    inline static function get_PRE(){
        if(ZPP_Flags.ListenerType_PRE==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.ListenerType_PRE=new ListenerType();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.ListenerType_PRE;
    }
}
