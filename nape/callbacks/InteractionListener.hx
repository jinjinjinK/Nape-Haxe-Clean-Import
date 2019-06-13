package nape.callbacks;
import nape.callbacks.CbEvent;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionType;
import nape.callbacks.Listener;
import nape.callbacks.OptionType;
import zpp_nape.callbacks.Listener;
import zpp_nape.callbacks.OptionType;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Event listener for Interaction type events.
 * <br/><br/>
 * Interaction type events can occur between any two Interactors (whether they
 * be Shapes, Bodys, Compounds or a mix thereof).
 * <br/><br/>
 * The events that can be caught are BEGIN, ONGOING, and END type events.
 * Theses listeners will operate between pairs of Interactors.
 * <pre>
 *          _Space
 *         /      \
 *     Cmp1        Cmp3
 *    /    \         |
 * Body1  Cmp2     Body3
 *   |      |        |
 * Shp1   Body2    Shp3
 *          |
 *        Shp2
 * </pre>
 * The possible interactor pairs for callbacks are formed by finding the most
 * recent common ancestor in the world for the given pair of shapes and taking all
 * possible pairings. In the above situation we have:
 * <pre>
 * MRCA(Shp1, Shp2) = Cmp1  --> Possible pairings = [Shp1, Body1] x [Shp2, Body2, Cmp2]
 * MRCA(Shp1, Shp3) = Space --> Possible pairings = [Shp1, Body1, Cmp1] x [Shp3, Body3, Cmp3]
 * MRCA(Shp2, Shp3) = Space --> Possible pairings = [Shp2, Body2, Cmp2, Cmp1] x [Shp3, Body3, Cmp3]
 * </pre>
 * Of course, not all of these pairings will generate callbacks, only those for which
 * a valid listener exists for the event type, and for the cbtypes of each interactor.
 * <br/><br/>
 * Furthermore, the listener specifies an interaction type which works even in mixed
 * cases where many types of interaction between two objects is happening at once.
 */
@:final#if nape_swc@:keep #end
class InteractionListener extends Listener{
    /**
     * @private
     */
    public var zpp_inner_zn:ZPP_InteractionListener=null;
    /**
     * The OptionType used to match against Interactors for the first object.
     */
    #if nape_swc@:isVar #end
    public var options1(get_options1,set_options1):OptionType;
    inline function get_options1():OptionType{
        return zpp_inner_zn.options1.outer;
    }
    inline function set_options1(options1:OptionType):OptionType{
        {
            zpp_inner_zn.options1.set(options1.zpp_inner);
        }
        return get_options1();
    }
    /**
     * The OptionType used to match against Interactors for the second object.
     */
    #if nape_swc@:isVar #end
    public var options2(get_options2,set_options2):OptionType;
    inline function get_options2():OptionType{
        return zpp_inner_zn.options2.outer;
    }
    inline function set_options2(options2:OptionType):OptionType{
        {
            zpp_inner_zn.options2.set(options2.zpp_inner);
        }
        return get_options2();
    }
    /**
     * The specific type of interaction that is to be listened for.
     * <br/><br/>
     * If we specify that we only want to listen for a fluid type interaction, then
     * this listener will operate so that any other interactions for the same pair
     * of objects is ignored.
     */
    #if nape_swc@:isVar #end
    public var interactionType(get_interactionType,set_interactionType):InteractionType;
    inline function get_interactionType():InteractionType{
        var ret=zpp_inner_zn.itype;
        return if(ret==ZPP_Flags.id_InteractionType_COLLISION)InteractionType.COLLISION;
        else if(ret==ZPP_Flags.id_InteractionType_SENSOR)InteractionType.SENSOR;
        else if(ret==ZPP_Flags.id_InteractionType_FLUID)InteractionType.FLUID;
        else if(ret==ZPP_Flags.id_InteractionType_ANY)InteractionType.ANY;
        else null;
    }
    inline function set_interactionType(interactionType:InteractionType):InteractionType{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(interactionType==null){
                throw "Error: Cannot set listener interaction type to null";
            }
            #end
            if(this.interactionType!=interactionType){
                var xtype=if(interactionType==InteractionType.COLLISION)ZPP_Flags.id_InteractionType_COLLISION else if(interactionType==InteractionType.SENSOR)ZPP_Flags.id_InteractionType_SENSOR else if(interactionType==InteractionType.FLUID)ZPP_Flags.id_InteractionType_FLUID else ZPP_Flags.id_InteractionType_ANY;
                zpp_inner_zn.setInteractionType(xtype);
            }
        }
        return get_interactionType();
    }
    /**
     * The callback handler for this listener.
     */
    #if nape_swc@:isVar #end
    public var handler(get_handler,set_handler):InteractionCallback->Void;
    inline function get_handler():InteractionCallback->Void{
        return zpp_inner_zn.handleri;
    }
    inline function set_handler(handler:InteractionCallback->Void):InteractionCallback->Void{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(handler==null){
                throw "Error: InteractionListener::handler cannot be null";
            }
            #end
            zpp_inner_zn.handleri=handler;
        }
        return get_handler();
    }
    /**
     * For ONGOING listeners only, permit ONGOING callbacks whilst sleeping.
     * <br/><br/>
     * This property determines whether we will still receive
     * ONGOING callbacks between two sleeping Interactors. The default action is to
     * inhibit callbacks between sleeping objects for performance. Setting this field to true
     * will permit Nape to always generate callbacks.
     */
    #if nape_swc@:isVar #end
    public var allowSleepingCallbacks(get_allowSleepingCallbacks,set_allowSleepingCallbacks):Bool;
    inline function get_allowSleepingCallbacks():Bool{
        return zpp_inner_zn.allowSleepingCallbacks;
    }
    inline function set_allowSleepingCallbacks(allowSleepingCallbacks:Bool):Bool{
        {
            zpp_inner_zn.allowSleepingCallbacks=allowSleepingCallbacks;
        }
        return get_allowSleepingCallbacks();
    }
    /**
     * Construct a new InteractionListener.
     * <br/><br/>
     * The possible event types are BEGIN, ONGOING and END.
     * <br/><br/>
     * The options arguments are typed Dynamic, and are permitted to be either an
     * <code>OptionType</code> or one of:
     * <code>CbType, CbTypeList, Array&lt;CbType&gt;, flash.Vector&lt;CbType&gt;</code>
     * In which case the input CbType's will be used to construct an OptionType
     * whose included types will be the set of CbTypes supplied.
     *
     * @param event The event type to listen for.
     * @param interactionType The interaction type to listen for.
     * @param options1 The OptionType to match first Interactor against, passing null
     *                will equate to an empty OptionType.
     * @param options2 The OptionType to match second Interactor against, passing null
     *                will equate to an empty OptionType.
     * @param handler The callback handler for this listener.
     * @param precedence The precedence of this listener used to sort
     *                   the order of callbacks in the case of more than
     *                   one suitable BodyListener existing for the same
     *                   event on the same Body. (default 0)
     * @return The newly constructed InteractionListener
     * @throws # If handler is null.
     * @throws # If the event type is not permitted for this listener.
     * @throws # If either option is not of the expected Type.
     */
    #if flib@:keep function flibopts_1(){}
    #end
    public function new(event:CbEvent,interactionType:InteractionType,options1:Null<Dynamic>,options2:Null<Dynamic>,handler:InteractionCallback->Void,precedence:Int=0){
        #if(!NAPE_RELEASE_BUILD)
        ZPP_Listener.internal=true;
        #end
        super();
        #if(!NAPE_RELEASE_BUILD)
        ZPP_Listener.internal=false;
        #end
        #if(!NAPE_RELEASE_BUILD)
        if(handler==null){
            throw "Error: InteractionListener::handler cannot be null";
        }
        if(event==null){
            throw "Error: CbEvent cannot be null for InteractionListener";
        }
        #end
        var xevent=-1;
        if(event==CbEvent.BEGIN)xevent=ZPP_Flags.id_CbEvent_BEGIN;
        else if(event==CbEvent.END)xevent=ZPP_Flags.id_CbEvent_END;
        else if(event==CbEvent.ONGOING)xevent=ZPP_Flags.id_CbEvent_ONGOING;
        else{
            #if(!NAPE_RELEASE_BUILD)
            throw "Error: CbEvent '"+event.toString()+"' is not a valid event type for InteractionListener";
            #end
        }
        zpp_inner_zn=new ZPP_InteractionListener(ZPP_OptionType.argument(options1),ZPP_OptionType.argument(options2),xevent,ZPP_Flags.id_ListenerType_INTERACTION);
        zpp_inner=zpp_inner_zn;
        zpp_inner.outer=this;
        zpp_inner_zn.outer_zni=this;
        zpp_inner.precedence=precedence;
        zpp_inner_zn.handleri=handler;
        this.interactionType=interactionType;
    }
}
