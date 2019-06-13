package nape.callbacks;
import nape.callbacks.CbEvent;
import nape.callbacks.ListenerType;
import nape.space.Space;
import zpp_nape.callbacks.Listener;
import zpp_nape.space.Space;
import zpp_nape.util.Flags.ZPP_Flags;
/**
 * Base type for all Nape callback listeners.
 */
#if nape_swc@:keep #end
class Listener{
    /**
     * @private
     */
    public var zpp_inner:ZPP_Listener=null;
    /**
     * The sub-type of this listener.
     */
    #if nape_swc@:isVar #end
    public var type(get_type,never):ListenerType;
    inline function get_type():ListenerType{
        return ZPP_Listener.types[zpp_inner.type];
    }
    /**
     * The CbEvent this listener responds to.
     */
    #if nape_swc@:isVar #end
    public var event(get_event,set_event):CbEvent;
    inline function get_event():CbEvent{
        return ZPP_Listener.events[zpp_inner.event];
    }
    inline function set_event(event:CbEvent):CbEvent{
        {
            #if(!NAPE_RELEASE_BUILD)
            if(event==null){
                throw "Error: Cannot set listener event type to null";
            }
            #end
            if(this.event!=event){
                var xevent=if(event==CbEvent.BEGIN)ZPP_Flags.id_CbEvent_BEGIN else if(event==CbEvent.ONGOING)ZPP_Flags.id_CbEvent_ONGOING else if(event==CbEvent.END)ZPP_Flags.id_CbEvent_END else if(event==CbEvent.SLEEP)ZPP_Flags.id_CbEvent_SLEEP else if(event==CbEvent.WAKE)ZPP_Flags.id_CbEvent_WAKE else if(event==CbEvent.PRE)ZPP_Flags.id_CbEvent_PRE else ZPP_Flags.id_CbEvent_BREAK;
                zpp_inner.swapEvent(xevent);
            }
        }
        return get_event();
    }
    /**
     * The precedence of this listener.
     * <br/><br/>
     * In any case that there is more than one suitable listener for a situation,
     * the listeners will be ordered by their precedence.
     *
     * @default 0
     */
    #if nape_swc@:isVar #end
    public var precedence(get_precedence,set_precedence):Int;
    inline function get_precedence():Int{
        return zpp_inner.precedence;
    }
    inline function set_precedence(precedence:Int):Int{
        {
            if(this.precedence!=precedence){
                zpp_inner.precedence=precedence;
                zpp_inner.invalidate_precedence();
            }
        }
        return get_precedence();
    }
    /**
     * @private
     */
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_Listener.internal){
            throw "Error: Cannot instantiate Listener derp!";
        }
        #end
    }
    /**
     * The Space this listener is assigned to.
     * <br/><br/>
     * This value can be set, with setting to null being equivalent to removing
     * the listener from whichever Space it is presently assigned to.
     *
     * @default null
     */
    #if nape_swc@:isVar #end
    public var space(get_space,set_space):Null<Space>;
    inline function get_space():Null<Space>{
        return if(zpp_inner.space==null)null else zpp_inner.space.outer;
    }
    inline function set_space(space:Null<Space>):Null<Space>{
        {
            if(this.space!=space){
                if(zpp_inner.space!=null){
                    zpp_inner.space.outer.listeners.remove(this);
                }
                if(space!=null){
                    space.listeners.add(this);
                }
                else{
                    zpp_inner.space=null;
                }
            }
        }
        return get_space();
    }
    /**
     * @private
     */
    @:keep public function toString(){
        var event=["BEGIN","END","WAKE","SLEEP","BREAK","PRE","ONGOING"][zpp_inner.event];
        if(zpp_inner.type==ZPP_Flags.id_ListenerType_BODY){
            var body=zpp_inner.body;
            return "BodyListener{"+event+"::"+body.outer_zn.options+"}";
        }
        else if(zpp_inner.type==ZPP_Flags.id_ListenerType_CONSTRAINT){
            var con=zpp_inner.constraint;
            return "ConstraintListener{"+event+"::"+con.outer_zn.options+"}";
        }
        else{
            var con=zpp_inner.interaction;
            var itype=switch(con.itype){
                case ZPP_Flags.id_InteractionType_COLLISION:"COLLISION";
                case ZPP_Flags.id_InteractionType_SENSOR:"SENSOR";
                case ZPP_Flags.id_InteractionType_FLUID:"FLUID";
                default:"ALL";
            }
            return(if(zpp_inner.type==ZPP_Flags.id_ListenerType_INTERACTION)"InteractionListener{"+event+"#"+itype+"::"+con.outer_zni.options1+":"+con.outer_zni.options2+"}" else "PreListener{"+itype+"::"+con.outer_znp.options1+":"+con.outer_znp.options2+"}")+" precedence="+zpp_inner.precedence;
        }
    }
}
