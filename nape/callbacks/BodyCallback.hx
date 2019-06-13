package nape.callbacks;
import nape.callbacks.Callback;
import nape.phys.Body;
import zpp_nape.callbacks.Callback;
import zpp_nape.phys.Body;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Callback object for Body type events.
 * <br/><br/>
 * This, like all other callback objects are automatically reused
 * and you should not keep any reference to them.
 */
@:final#if nape_swc@:keep #end
class BodyCallback extends Callback{
    /**
     * @private
     */
    public function new(){
        super();
    }
    /**
     * Body involved in callback event.
     */
    #if nape_swc@:isVar #end
    public var body(get_body,never):Body;
    inline function get_body():Body{
        return zpp_inner.body.outer;
    }
    /**
     * @private
     */
    @:keep public override function toString(){
        var ret="Cb:";
        ret+=["WAKE","SLEEP"][zpp_inner.event-ZPP_Flags.id_CbEvent_WAKE];
        ret+=":"+body.toString();
        ret+=" : listener: "+listener;
        return ret;
    }
}
