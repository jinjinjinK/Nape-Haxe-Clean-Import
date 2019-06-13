package nape.callbacks;
import nape.callbacks.BodyCallback;
import nape.callbacks.CbEvent;
import nape.callbacks.Listener;
import nape.callbacks.OptionType;
import zpp_nape.callbacks.Listener;
import zpp_nape.callbacks.OptionType;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Event listener for Body type events.
 * <br/><br/>
 * The events that can be caught are WAKE and SLEEP type events.
 * Theses listeners will only operate on Bodys, not Interactors in general.
 */
@:final#if nape_swc@:keep #end
class BodyListener extends Listener{
    /**
     * @private
     */
    public var zpp_inner_zn:ZPP_BodyListener=null;
    /**
     * The OptionType used to match against Bodies.
     * <br/><br/>
     * When added to the same Space, any Body who's CbType list matches
     * against this OptionType will be issued a callback when the relevant
     * event occurs.
     */
    #if nape_swc@:isVar #end
    public var options(get_options,set_options):OptionType;
    inline function get_options():OptionType{
        return zpp_inner_zn.options.outer;
    }
    inline function set_options(options:OptionType):OptionType{
        {
            zpp_inner_zn.options.set(options.zpp_inner);
        }
        return get_options();
    }
    /**
     * The callback handler for this listener.
     */
    #if nape_swc@:isVar #end
    public var handler(get_handler,set_handler):BodyCallback->Void;
    inline function get_handler():BodyCallback->Void{
        return zpp_inner_zn.handler;
    }
    inline function set_handler(handler:BodyCallback->Void):BodyCallback->Void{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(handler==null){
                throw "Error: BodyListener::handler cannot be null";
            }
            #end
            zpp_inner_zn.handler=handler;
        }
        return get_handler();
    }
    /**
     * Construct a new BodyListener.
     * <br/><br/>
     * The possible event types are WAKE and SLEEP.
     * <br/><br/>
     * The options argument is typed Dynamic, and is permitted to be either an
     * <code>OptionType</code> or one of:
     * <code>CbType, CbTypeList, Array&lt;CbType&gt;, flash.Vector&lt;CbType&gt;</code>
     * In which case the input CbType's will be used to construct an OptionType
     * whose included types will be the set of CbTypes supplied.
     *
     * @param event The event type to listen for.
     * @param options The OptionType to match Bodys against, passing null
     *                will equate to an empty OptionType.
     * @param handler The callback handler for this listener.
     * @param precedence The precedence of this listener used to sort
     *                   the order of callbacks in the case of more than
     *                   one suitable BodyListener existing for the same
     *                   event on the same Body. (default 0)
     * @return The newly constructed BodyListener
     * @throws # If handler is null.
     * @throws # If the event type is not permitted for this listener.
     * @throws # If options is not of the expected Type.
     */
    #if flib@:keep function flibopts_1(){}
    #end
    public function new(event:CbEvent,options:Null<Dynamic>,handler:BodyCallback->Void,precedence:Int=0){
        #if(!NAPE_RELEASE_BUILD)
        ZPP_Listener.internal=true;
        #end
        super();
        #if(!NAPE_RELEASE_BUILD)
        ZPP_Listener.internal=false;
        #end
        #if(!NAPE_RELEASE_BUILD)
        if(handler==null){
            throw "Error: BodyListener::handler cannot be null";
        }
        #end
        var xevent=-1;
        if(event==CbEvent.WAKE)xevent=ZPP_Flags.id_CbEvent_WAKE;
        else if(event==CbEvent.SLEEP)xevent=ZPP_Flags.id_CbEvent_SLEEP;
        else{
            #if(!NAPE_RELEASE_BUILD)
            throw "Error: cbEvent '"+event.toString()+"' is not a valid event type for a BodyListener";
            #end
        }
        zpp_inner_zn=new ZPP_BodyListener(ZPP_OptionType.argument(options),xevent,handler);
        zpp_inner=zpp_inner_zn;
        zpp_inner.outer=this;
        zpp_inner_zn.outer_zn=this;
        zpp_inner.precedence=precedence;
    }
}
