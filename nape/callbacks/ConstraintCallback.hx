package nape.callbacks;
import nape.callbacks.Callback;
import nape.constraint.Constraint;
import zpp_nape.callbacks.Callback;
import zpp_nape.constraint.Constraint;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Callback object for Constraint type events.
 * <br/><br/>
 * This, like all other callback objects are automatically reused
 * and you should not keep any reference to them.
 */
@:final#if nape_swc@:keep #end
class ConstraintCallback extends Callback{
    /**
     * @private
     */
    public function new(){
        super();
    }
    /**
     * Constraint involved in callback event.
     */
    #if nape_swc@:isVar #end
    public var constraint(get_constraint,never):Constraint;
    inline function get_constraint():Constraint{
        return zpp_inner.constraint.outer;
    }
    /**
     * @private
     */
    @:keep public override function toString(){
        var ret="Cb:";
        ret+=["WAKE","SLEEP","BREAK"][zpp_inner.event-ZPP_Flags.id_CbEvent_WAKE];
        ret+=":"+constraint.toString();
        ret+=" : listener: "+listener;
        return ret;
    }
}
