package nape.callbacks;
import nape.callbacks.CbEvent;
import nape.callbacks.Listener;
import zpp_nape.callbacks.Callback;
import zpp_nape.callbacks.Listener;
/**
 * Base type for Callback event objects.
 * <br/><br/>
 * Callback objects are automatically reused and you should not keep references
 * to them.
 */
#if nape_swc@:keep #end
class Callback{
    /**
     * @private
     */
    public var zpp_inner:ZPP_Callback=null;
    /**
     * CbEvent type this callback was generated for.
     */
    #if nape_swc@:isVar #end
    public var event(get_event,never):CbEvent;
    inline function get_event():CbEvent{
        return ZPP_Listener.events[zpp_inner.event];
    }
    /**
     * The Listener which was responsive for this callback being generated.
     */
    #if nape_swc@:isVar #end
    public var listener(get_listener,never):Listener;
    inline function get_listener():Listener{
        return zpp_inner.listener.outer;
    }
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Callback.internal){
            throw "Error: Callback cannot be instantiated derp!";
        }
        #end
    }
    /**
     * @private
     */
    @:keep public function toString():String{
        return "";
    }
}
