package zpp_nape.callbacks;
import nape.callbacks.BodyCallback;
import nape.callbacks.ConstraintCallback;
import nape.callbacks.InteractionCallback;
import nape.dynamics.ArbiterList;
import zpp_nape.callbacks.Listener.ZPP_Listener;
import zpp_nape.constraint.Constraint.ZPP_Constraint;
import zpp_nape.dynamics.Arbiter.ZPP_Arbiter;
import zpp_nape.phys.Body.ZPP_Body;
import zpp_nape.phys.Interactor.ZPP_Interactor;
import zpp_nape.space.Space.ZPP_CallbackSet;
import zpp_nape.space.Space.ZPP_Space;
import zpp_nape.util.Lists.ZPP_ArbiterList;
#if nape_swc@:keep #end
class ZPP_Callback{
    public var outer_body:Null<BodyCallback>=null;
    public var outer_con:Null<ConstraintCallback>=null;
    public var outer_int:Null<InteractionCallback>=null;
    #if(!NAPE_RELEASE_BUILD)
    public static var internal=false;
    #end
    public function wrapper_body(){
        if(outer_body==null){
            #if(!NAPE_RELEASE_BUILD)
            internal=true;
            #end
            outer_body=new BodyCallback();
            #if(!NAPE_RELEASE_BUILD)
            internal=false;
            #end
            outer_body.zpp_inner=this;
        }
        return outer_body;
    }
    public function wrapper_con(){
        if(outer_con==null){
            #if(!NAPE_RELEASE_BUILD)
            internal=true;
            #end
            outer_con=new ConstraintCallback();
            #if(!NAPE_RELEASE_BUILD)
            internal=false;
            #end
            outer_con.zpp_inner=this;
        }
        return outer_con;
    }
    public function wrapper_int(){
        if(outer_int==null){
            #if(!NAPE_RELEASE_BUILD)
            internal=true;
            #end
            outer_int=new InteractionCallback();
            #if(!NAPE_RELEASE_BUILD)
            internal=false;
            #end
            outer_int.zpp_inner=this;
        }
        genarbs();
        return outer_int;
    }
    public var event:Int=0;
    public var listener:ZPP_Listener=null;
    public var space:ZPP_Space=null;
    public var index:Int=0;
    public var next:ZPP_Callback=null;
    public var prev:ZPP_Callback=null;
    public var length:Int=0;
    public function push(obj:ZPP_Callback){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                obj!=null;
            };
            if(!res)throw "assert("+"obj!=null"+") :: "+("push null?");
            #end
        };
        if(prev!=null)prev.next=obj;
        else next=obj;
        obj.prev=prev;
        obj.next=null;
        prev=obj;
        length++;
    }
    public function push_rev(obj:ZPP_Callback){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                obj!=null;
            };
            if(!res)throw "assert("+"obj!=null"+") :: "+("push_rev null?");
            #end
        };
        if(next!=null)next.prev=obj;
        else prev=obj;
        obj.next=next;
        obj.prev=null;
        next=obj;
        length++;
    }
    public function pop():ZPP_Callback{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                next!=null;
            };
            if(!res)throw "assert("+"next!=null"+") :: "+("empty queue");
            #end
        };
        var ret=next;
        next=ret.next;
        if(next==null)prev=null;
        else next.prev=null;
        length--;
        return ret;
    }
    public function pop_rev():ZPP_Callback{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                prev!=null;
            };
            if(!res)throw "assert("+"prev!=null"+") :: "+("empty queue");
            #end
        };
        var ret=prev;
        prev=ret.prev;
        if(prev==null)next=null;
        else prev.next=null;
        length--;
        return ret;
    }
    public function empty(){
        return next==null;
    }
    public function clear(){
        while(!empty())pop();
    }
    public function splice(o:ZPP_Callback){
        var ret=o.next;
        if(o.prev==null){
            next=o.next;
            if(next!=null)next.prev=null;
            else prev=null;
        }
        else{
            o.prev.next=o.next;
            if(o.next!=null)o.next.prev=o.prev;
            else prev=o.prev;
        }
        length--;
        return ret;
    }
    public function rotateL(){
        push(pop());
    }
    public function rotateR(){
        push_rev(pop_rev());
    }
    public function cycleNext(o:ZPP_Callback){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                o!=null;
            };
            if(!res)throw "assert("+"o!=null"+") :: "+("cyclNext null?");
            #end
        };
        if(o.next==null)return next;
        else return o.next;
    }
    public function cyclePrev(o:ZPP_Callback){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                o!=null;
            };
            if(!res)throw "assert("+"o!=null"+") :: "+("cyclPrev null?");
            #end
        };
        if(o.prev==null)return prev;
        else return o.prev;
    }
    public function at(i:Int){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                i>=0&&i<length;
            };
            if(!res)throw "assert("+"i>=0&&i<length"+") :: "+("at index bounds");
            #end
        };
        var ret=next;
        while(i--!=0)ret=ret.next;
        return ret;
    }
    public function rev_at(i:Int){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                i>=0&&i<length;
            };
            if(!res)throw "assert("+"i>=0&&i<length"+") :: "+("rev_at index bounds");
            #end
        };
        var ret=prev;
        while(i--!=0)ret=ret.prev;
        return ret;
    }
    static public var zpp_pool:ZPP_Callback=null;
    #if NAPE_POOL_STATS 
    /**
     * @private
     */
    static public var POOL_CNT:Int=0;
    /**
     * @private
     */
    static public var POOL_TOT:Int=0;
    /**
     * @private
     */
    static public var POOL_ADD:Int=0;
    /**
     * @private
     */
    static public var POOL_ADDNEW:Int=0;
    /**
     * @private
     */
    static public var POOL_SUB:Int=0;
    #end
    
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function free():Void{
        int1=int2=null;
        body=null;
        constraint=null;
        listener=null;
        if(wrap_arbiters!=null){
            wrap_arbiters.zpp_inner.inner=null;
        }
        set=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc():Void{}
    public var int1:ZPP_Interactor=null;
    public var int2:ZPP_Interactor=null;
    public var set:ZPP_CallbackSet=null;
    public var wrap_arbiters:ArbiterList=null;
    public var pre_arbiter:ZPP_Arbiter=null;
    public var pre_swapped:Bool=false;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function genarbs(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                set!=null;
            };
            if(!res)throw "assert("+"set!=null"+") :: "+("after ongoing event was added, this should never be the case");
            #end
        };
        if(wrap_arbiters==null){
            wrap_arbiters=ZPP_ArbiterList.get(set.arbiters,true);
        }
        else{
            wrap_arbiters.zpp_inner.inner=set.arbiters;
        }
        wrap_arbiters.zpp_inner.zip_length=true;
        wrap_arbiters.zpp_inner.at_ite=null;
    }
    public var body:ZPP_Body=null;
    public var constraint:ZPP_Constraint=null;
    public function new(){
        length=0;
    }
}
