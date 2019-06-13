package nape.callbacks;
import nape.callbacks.Callback;
import nape.dynamics.ArbiterList;
import nape.phys.Interactor;
import zpp_nape.callbacks.Callback;
import zpp_nape.phys.Interactor;
/**
 * Callback object for Interaction type events.
 * <br/><br/>
 * This, like all other callback objects are automatically reused
 * and you should not keep any reference to them.
 */
@:final#if nape_swc@:keep #end
class InteractionCallback extends Callback{
    /**
     * @private
     */
    public function new(){
        super();
    }
    /**
     * First Interactor involved in callback event.
     * <br/><br/>
     * This interactor will have CbType set matched by the first
     * OptionType in InteractionListener
     */
    #if nape_swc@:isVar #end
    public var int1(get_int1,never):Interactor;
    inline function get_int1():Interactor{
        return zpp_inner.int1.outer_i;
    }
    /**
     * Second Interactor involved in callback event.
     * <br/><br/>
     * This interactor will have CbType set matched by the second
     * OptionType in InteractionListener
     */
    #if nape_swc@:isVar #end
    public var int2(get_int2,never):Interactor;
    inline function get_int2():Interactor{
        return zpp_inner.int2.outer_i;
    }
    /**
     * Existing arbiters between interactors.
     * <br/><br/>
     * This list will at present contain 'all' arbiters, not just those matching the
     * interactionType in the InteractionListener. (This may be subject to change).
     */
    #if nape_swc@:isVar #end
    public var arbiters(get_arbiters,never):ArbiterList;
    inline function get_arbiters():ArbiterList{
        return zpp_inner.wrap_arbiters;
    }
    /**
     * @private
     */
    @:keep public override function toString(){
        var ret="Cb:";
        ret+=["BEGIN","END","","","","","ONGOING"][zpp_inner.event];
        ret+=":"+int1.toString()+"/"+int2.toString();
        ret+=" : "+arbiters.toString();
        ret+=" : listener: "+listener;
        return ret;
    }
}
