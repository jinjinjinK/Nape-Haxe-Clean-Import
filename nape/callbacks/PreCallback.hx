package nape.callbacks;
import nape.callbacks.Callback;
import nape.dynamics.Arbiter;
import nape.phys.Interactor;
import zpp_nape.callbacks.Callback;
import zpp_nape.dynamics.Arbiter;
import zpp_nape.phys.Interactor;
/**
 * Callback object for Pre-Interaction type events.
 * <br/><br/>
 * This, like all other callback objects are automatically reused
 * and you should not keep any reference to them.
 */
@:final#if nape_swc@:keep #end
class PreCallback extends Callback{
    /**
     * @private
     */
    public function new(){
        super();
    }
    /**
     * Arbiter related to callback event.
     * <br/><br/>
     * In the case that this pre-event occurs between two non-Shape's
     * then this is the first arbiter to be created for the related
     * interactionType
     */
    #if nape_swc@:isVar #end
    public var arbiter(get_arbiter,never):Arbiter;
    inline function get_arbiter():Arbiter{
        return zpp_inner.pre_arbiter.wrapper();
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
     * Describes how Arbiter's objects are related to int1/int2 properties
     * <br/><br/>
     * If true, then arbiter.shape1 will belong to callback.int2, and
     * arbiter.shape2 will belong to callback.int1.
     * <br/><br/>
     * If you take the arbiter's normal, then if swapped is true, the normal
     * will point from int2 towards int1 instead of from int1 towards int2.
     */
    #if nape_swc@:isVar #end
    public var swapped(get_swapped,never):Bool;
    inline function get_swapped():Bool{
        return zpp_inner.pre_swapped;
    }
    /**
     * @private
     */
    @:keep public override function toString(){
        var ret="Cb:PRE:";
        ret+=":"+int1.toString()+"/"+int2.toString();
        ret+=" : "+arbiter.toString();
        ret+=" : listnener: "+listener;
        return ret;
    }
}
