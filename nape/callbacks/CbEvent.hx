package nape.callbacks;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Enumeration of possible callback event types.
 */
@:final#if nape_swc@:keep #end
class CbEvent{
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Flags.internal)throw "Error: Cannot instantiate "+"CbEvent"+" derp!";
        #end
    }
    /**
     * @private
     */
    @:keep public function toString(){
        if(false)return "";
        
        else if(this==PRE)return"PRE";
        else if(this==BEGIN)return"BEGIN";
        else if(this==ONGOING)return"ONGOING";
        else if(this==END)return"END";
        else if(this==WAKE)return"WAKE";
        else if(this==SLEEP)return"SLEEP";
        else if(this==BREAK)return"BREAK";
        else return "";
    }
    /**
     * BEGIN event corresponds to the start of an interaction
     */
    #if nape_swc@:isVar #end
    public static var BEGIN(get_BEGIN,never):CbEvent;
    inline static function get_BEGIN(){
        if(ZPP_Flags.CbEvent_BEGIN==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.CbEvent_BEGIN=new CbEvent();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.CbEvent_BEGIN;
    }
    /**
     * ONGOING event corresponds to any step in which an interaction is occuring
     * overlapping with the BEGIN event.
     */
    #if nape_swc@:isVar #end
    public static var ONGOING(get_ONGOING,never):CbEvent;
    inline static function get_ONGOING(){
        if(ZPP_Flags.CbEvent_ONGOING==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.CbEvent_ONGOING=new CbEvent();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.CbEvent_ONGOING;
    }
    /**
     * END event corresponds to the end of an interaction.
     */
    #if nape_swc@:isVar #end
    public static var END(get_END,never):CbEvent;
    inline static function get_END(){
        if(ZPP_Flags.CbEvent_END==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.CbEvent_END=new CbEvent();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.CbEvent_END;
    }
    /**
     * WAKE event corresponds to the waking of a Body or Constraint in the space.
     */
    #if nape_swc@:isVar #end
    public static var WAKE(get_WAKE,never):CbEvent;
    inline static function get_WAKE(){
        if(ZPP_Flags.CbEvent_WAKE==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.CbEvent_WAKE=new CbEvent();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.CbEvent_WAKE;
    }
    /**
     * SLEEP event corresponds to the sleeping of a Body or Constraint in the space.
     */
    #if nape_swc@:isVar #end
    public static var SLEEP(get_SLEEP,never):CbEvent;
    inline static function get_SLEEP(){
        if(ZPP_Flags.CbEvent_SLEEP==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.CbEvent_SLEEP=new CbEvent();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.CbEvent_SLEEP;
    }
    /**
     * BREAK event corresponds to the breaking of a defined limit on a Constraint.
     */
    #if nape_swc@:isVar #end
    public static var BREAK(get_BREAK,never):CbEvent;
    inline static function get_BREAK(){
        if(ZPP_Flags.CbEvent_BREAK==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.CbEvent_BREAK=new CbEvent();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.CbEvent_BREAK;
    }
    /**
     * PRE event corresponds to a special mid-step event that occurs after it is determined
     * that two objects 'will' begin to interact, but before any interaction commences.
     */
    #if nape_swc@:isVar #end
    public static var PRE(get_PRE,never):CbEvent;
    inline static function get_PRE(){
        if(ZPP_Flags.CbEvent_PRE==null){
            ZPP_Flags.internal=true;
            ZPP_Flags.CbEvent_PRE=new CbEvent();
            ZPP_Flags.internal=false;
        }
        return ZPP_Flags.CbEvent_PRE;
    }
}
