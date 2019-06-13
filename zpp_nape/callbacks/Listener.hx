package zpp_nape.callbacks;
import nape.callbacks.BodyCallback;
import nape.callbacks.BodyListener;
import nape.callbacks.CbEvent;
import nape.callbacks.ConstraintCallback;
import nape.callbacks.ConstraintListener;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.Listener;
import nape.callbacks.ListenerType;
import nape.callbacks.OptionType;
import nape.callbacks.PreCallback;
import nape.callbacks.PreFlag;
import nape.callbacks.PreListener;
import zpp_nape.ID.ZPP_ID;
import zpp_nape.callbacks.CbSet.ZPP_CbSet;
import zpp_nape.callbacks.CbSetPair.ZPP_CbSetPair;
import zpp_nape.callbacks.CbType.ZPP_CbType;
import zpp_nape.callbacks.OptionType;
import zpp_nape.space.Space.ZPP_Space;
import zpp_nape.util.Flags.ZPP_Flags;
import zpp_nape.util.Lists.ZNPList_ZPP_CbSet;
import zpp_nape.util.Lists.ZNPList_ZPP_CbType;
import zpp_nape.util.RBTree.ZPP_Set_ZPP_CbSetPair;
#if nape_swc@:keep #end
class ZPP_Listener{
    public var outer:Listener=null;
    #if(!NAPE_RELEASE_BUILD)
    public static var internal:Bool=false;
    #end
    public var id:Int=0;
    public var type:Int=0;
    public var event:Int=0;
    public static var types:Array<ListenerType>=[ListenerType.BODY,ListenerType.CONSTRAINT,ListenerType.INTERACTION,ListenerType.PRE];
    public static var events:Array<CbEvent>=[CbEvent.BEGIN,CbEvent.END,CbEvent.WAKE,CbEvent.SLEEP,CbEvent.BREAK,CbEvent.PRE,CbEvent.ONGOING];
    public var precedence:Int=0;
    public var body:Null<ZPP_BodyListener>=null;
    public var constraint:Null<ZPP_ConstraintListener>=null;
    public var interaction:Null<ZPP_InteractionListener>=null;
    public var space:Null<ZPP_Space>=null;
    function new(){
        id=ZPP_ID.Listener();
    }
    public#if NAPE_NO_INLINE#else inline #end
    static function setlt(a:ZPP_Listener,b:ZPP_Listener):Bool{
        return(a.precedence>b.precedence)||(a.precedence==b.precedence&&a.id>b.id);
    }
    public function swapEvent(event:Int):Void{}
    public function invalidate_precedence():Void{}
    public function addedToSpace():Void{}
    public function removedFromSpace():Void{}
}
#if nape_swc@:keep #end
class ZPP_BodyListener extends ZPP_Listener{
    public var outer_zn:BodyListener=null;
    public var options:ZPP_OptionType=null;
    public var handler:BodyCallback->Void=null;
    #if(!NAPE_RELEASE_BUILD)
    function immutable_options(){
        if(space!=null&&space.midstep){
            throw "Error: Cannot change listener type options during space.step()";
        }
    }
    #end
    public function new(options:OptionType,event:Int,handler:BodyCallback->Void){
        super();
        this.event=event;
        this.handler=handler;
        body=this;
        type=ZPP_Flags.id_ListenerType_BODY;
        this.options=options.zpp_inner;
    }
    public override function addedToSpace():Void{
        options.handler=cbtype_change;
        {
            var cx_ite=options.includes.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                {
                    cb.addbody(this);
                };
                cx_ite=cx_ite.next;
            }
        };
    }
    public override function removedFromSpace():Void{
        {
            var cx_ite=options.includes.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                {
                    cb.removebody(this);
                };
                cx_ite=cx_ite.next;
            }
        };
        options.handler=null;
    }
    function cbtype_change(cb:ZPP_CbType,included:Bool,added:Bool):Void{
        removedFromSpace();
        options.effect_change(cb,included,added);
        addedToSpace();
    }
    public override function invalidate_precedence():Void{
        if(space!=null){
            removedFromSpace();
            addedToSpace();
        }
    }
    public override function swapEvent(newev:Int):Void{
        #if(!NAPE_RELEASE_BUILD)
        if(newev!=ZPP_Flags.id_CbEvent_WAKE&&newev!=ZPP_Flags.id_CbEvent_SLEEP){
            throw "Error: BodyListener event must be either WAKE or SLEEP only";
        }
        #end
        removedFromSpace();
        event=newev;
        addedToSpace();
    }
}
#if nape_swc@:keep #end
class ZPP_ConstraintListener extends ZPP_Listener{
    public var outer_zn:ConstraintListener=null;
    public var options:ZPP_OptionType=null;
    public var handler:ConstraintCallback->Void=null;
    #if(!NAPE_RELEASE_BUILD)
    function immutable_options(){
        if(space!=null&&space.midstep){
            throw "Error: Cannot change listener type options during space.step()";
        }
    }
    #end
    public function new(options:OptionType,event:Int,handler:ConstraintCallback->Void){
        super();
        this.event=event;
        this.handler=handler;
        constraint=this;
        type=ZPP_Flags.id_ListenerType_CONSTRAINT;
        this.options=options.zpp_inner;
    }
    public override function addedToSpace():Void{
        options.handler=cbtype_change;
        {
            var cx_ite=options.includes.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                {
                    cb.addconstraint(this);
                };
                cx_ite=cx_ite.next;
            }
        };
    }
    public override function removedFromSpace():Void{
        {
            var cx_ite=options.includes.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                {
                    cb.removeconstraint(this);
                };
                cx_ite=cx_ite.next;
            }
        };
        options.handler=null;
    }
    function cbtype_change(cb:ZPP_CbType,included:Bool,added:Bool):Void{
        removedFromSpace();
        options.effect_change(cb,included,added);
        addedToSpace();
    }
    public override function invalidate_precedence():Void{
        if(space!=null){
            removedFromSpace();
            addedToSpace();
        }
    }
    public override function swapEvent(newev:Int){
        #if(!NAPE_RELEASE_BUILD)
        if(newev!=ZPP_Flags.id_CbEvent_WAKE&&newev!=ZPP_Flags.id_CbEvent_SLEEP&&newev!=ZPP_Flags.id_CbEvent_BREAK){
            throw "Error: ConstraintListener event must be either WAKE or SLEEP only";
        }
        #end
        removedFromSpace();
        event=newev;
        addedToSpace();
    }
}
#if nape_swc@:keep #end
class ZPP_InteractionListener extends ZPP_Listener{
    public var outer_zni:Null<InteractionListener>=null;
    public var outer_znp:Null<PreListener>=null;
    public var itype:Int=0;
    public var options1:ZPP_OptionType=null;
    public var options2:ZPP_OptionType=null;
    public var handleri:Null<InteractionCallback->Void>=null;
    public var allowSleepingCallbacks:Bool=false;
    public var pure:Bool=false;
    public var handlerp:Null<PreCallback->Null<PreFlag>>=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function setInteractionType(itype:Int){
        this.itype=itype;
    }
    public function new(options1:OptionType,options2:OptionType,event:Int,type:Int){
        super();
        this.type=type;
        interaction=this;
        this.event=event;
        this.options1=options1.zpp_inner;
        this.options2=options2.zpp_inner;
        allowSleepingCallbacks=false;
    }
    public function wake(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                type==ZPP_Flags.id_ListenerType_PRE;
            };
            if(!res)throw "assert("+"type==ZPP_Flags.id_ListenerType_PRE"+") :: "+("waking non-pre?");
            #end
        };
        with_union(function(cb:ZPP_CbType):Void{
            {
                var cx_ite=cb.interactors.begin();
                while(cx_ite!=null){
                    var i=cx_ite.elem();
                    {
                        i.wake();
                    };
                    cx_ite=cx_ite.next;
                }
            };
        });
    }
    
    static var UCbSet=new ZNPList_ZPP_CbSet();
    static var VCbSet=new ZNPList_ZPP_CbSet();
    static var WCbSet=new ZNPList_ZPP_CbSet();
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    #if NAPE_NO_INLINE#else inline #end
    function CbSetset(A:ZNPList_ZPP_CbSet,B:ZNPList_ZPP_CbSet,lambda:ZPP_CbSet->ZPP_CbSet->Void):Void{
        var U=UCbSet;
        var V=VCbSet;
        var W=WCbSet;
        var aite=A.begin();
        var bite=B.begin();
        while(aite!=null&&bite!=null){
            var a=aite.elem();
            var b=bite.elem();
            if(a==b){
                W.inlined_add(a);
                aite=aite.next;
                bite=bite.next;
            }
            else if(ZPP_CbSet.setlt(a,b)){
                U.inlined_add(a);
                aite=aite.next;
            }
            else{
                V.inlined_add(b);
                bite=bite.next;
            }
        }
        while(aite!=null){
            U.inlined_add(aite.elem());
            aite=aite.next;
        }
        while(bite!=null){
            V.inlined_add(bite.elem());
            bite=bite.next;
        }
        {
            while(!U.empty()){
                var x=U.pop_unsafe();
                {
                    var cx_ite=B.begin();
                    while(cx_ite!=null){
                        var y=cx_ite.elem();
                        lambda(x,y);
                        cx_ite=cx_ite.next;
                    }
                };
            }
        };
        {
            while(!V.empty()){
                var x=V.pop_unsafe();
                {
                    var cx_ite=W.begin();
                    while(cx_ite!=null){
                        var y=cx_ite.elem();
                        lambda(x,y);
                        cx_ite=cx_ite.next;
                    }
                };
            }
        };
        {
            while(!W.empty()){
                var x=W.pop_unsafe();
                {
                    lambda(x,x);
                    {
                        var cx_ite=W.begin();
                        while(cx_ite!=null){
                            var y=cx_ite.elem();
                            lambda(x,y);
                            cx_ite=cx_ite.next;
                        }
                    };
                };
            }
        };
    }
    static var UCbType=new ZNPList_ZPP_CbType();
    static var VCbType=new ZNPList_ZPP_CbType();
    static var WCbType=new ZNPList_ZPP_CbType();
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    #if NAPE_NO_INLINE#else inline #end
    function CbTypeset(A:ZNPList_ZPP_CbType,B:ZNPList_ZPP_CbType,lambda:ZPP_CbType->ZPP_CbType->Void):Void{
        var U=UCbType;
        var V=VCbType;
        var W=WCbType;
        var aite=A.begin();
        var bite=B.begin();
        while(aite!=null&&bite!=null){
            var a=aite.elem();
            var b=bite.elem();
            if(a==b){
                W.inlined_add(a);
                aite=aite.next;
                bite=bite.next;
            }
            else if(ZPP_CbType.setlt(a,b)){
                U.inlined_add(a);
                aite=aite.next;
            }
            else{
                V.inlined_add(b);
                bite=bite.next;
            }
        }
        while(aite!=null){
            U.inlined_add(aite.elem());
            aite=aite.next;
        }
        while(bite!=null){
            V.inlined_add(bite.elem());
            bite=bite.next;
        }
        {
            while(!U.empty()){
                var x=U.pop_unsafe();
                {
                    var cx_ite=B.begin();
                    while(cx_ite!=null){
                        var y=cx_ite.elem();
                        lambda(x,y);
                        cx_ite=cx_ite.next;
                    }
                };
            }
        };
        {
            while(!V.empty()){
                var x=V.pop_unsafe();
                {
                    var cx_ite=W.begin();
                    while(cx_ite!=null){
                        var y=cx_ite.elem();
                        lambda(x,y);
                        cx_ite=cx_ite.next;
                    }
                };
            }
        };
        {
            while(!W.empty()){
                var x=W.pop_unsafe();
                {
                    lambda(x,x);
                    {
                        var cx_ite=W.begin();
                        while(cx_ite!=null){
                            var y=cx_ite.elem();
                            lambda(x,y);
                            cx_ite=cx_ite.next;
                        }
                    };
                };
            }
        };
    }
    function with_uniquesets(fresh:Bool){
        var set;
        {
            if(ZPP_Set_ZPP_CbSetPair.zpp_pool==null){
                set=new ZPP_Set_ZPP_CbSetPair();
                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_TOT++;
                ZPP_Set_ZPP_CbSetPair.POOL_ADDNEW++;
                #end
            }
            else{
                set=ZPP_Set_ZPP_CbSetPair.zpp_pool;
                ZPP_Set_ZPP_CbSetPair.zpp_pool=set.next;
                set.next=null;
                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_CNT--;
                ZPP_Set_ZPP_CbSetPair.POOL_ADD++;
                #end
            }
            set.alloc();
        };
        set.lt=ZPP_CbSetPair.setlt;
        CbTypeset(options1.includes,options2.includes,function(a:ZPP_CbType,b:ZPP_CbType):Void{
            CbSetset(a.cbsets,b.cbsets,function(a:ZPP_CbSet,b:ZPP_CbSet):Void{
                a.validate();
                b.validate();
                if(ZPP_CbSet.single_intersection(a,b,this)){
                    set.try_insert(ZPP_CbSetPair.get(a,b));
                }
            });
        });
        set.clear_with(function(pair:ZPP_CbSetPair):Void{
            if(fresh)space.freshListenerType(pair.a,pair.b);
            else space.nullListenerType(pair.a,pair.b);
            {
                var o=pair;
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        o!=null;
                    };
                    if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_CbSetPair"+", in obj: "+"pair"+")");
                    #end
                };
                o.free();
                o.next=ZPP_CbSetPair.zpp_pool;
                ZPP_CbSetPair.zpp_pool=o;
                #if NAPE_POOL_STATS ZPP_CbSetPair.POOL_CNT++;
                ZPP_CbSetPair.POOL_SUB++;
                #end
            };
        });
        {
            var o=set;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_CbSetPair"+", in obj: "+"set"+")");
                #end
            };
            o.free();
            o.next=ZPP_Set_ZPP_CbSetPair.zpp_pool;
            ZPP_Set_ZPP_CbSetPair.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_CNT++;
            ZPP_Set_ZPP_CbSetPair.POOL_SUB++;
            #end
        };
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    #if NAPE_NO_INLINE#else inline #end
    function with_union(lambda:ZPP_CbType->Void):Void{
        var ite1=options1.includes.begin();
        var ite2=options2.includes.begin();
        while(ite1!=null&&ite2!=null){
            var cb1=ite1.elem();
            var cb2=ite2.elem();
            if(cb1==cb2){
                lambda(cb1);
                ite1=ite1.next;
                ite2=ite2.next;
            }
            else if(ZPP_CbType.setlt(cb1,cb2)){
                lambda(cb1);
                ite1=ite1.next;
            }
            else{
                lambda(cb2);
                ite2=ite2.next;
            }
        }
        while(ite1!=null){
            lambda(ite1.elem());
            ite1=ite1.next;
        }
        while(ite2!=null){
            lambda(ite2.elem());
            ite2=ite2.next;
        }
    }
    public override function addedToSpace():Void{
        var pre=type==ZPP_Flags.id_ListenerType_PRE;
        with_union(function(cb:ZPP_CbType):Void{
            cb.addint(this);
            if(pre){
                {
                    var cx_ite=cb.interactors.begin();
                    while(cx_ite!=null){
                        var i=cx_ite.elem();
                        i.wake();
                        cx_ite=cx_ite.next;
                    }
                };
            }
        });
        options1.handler=cbtype_change1;
        options2.handler=cbtype_change2;
        with_uniquesets(true);
    }
    public override function removedFromSpace():Void{
        with_uniquesets(false);
        var pre=type==ZPP_Flags.id_ListenerType_PRE;
        with_union(function(cb:ZPP_CbType):Void{
            cb.removeint(this);
            if(pre){
                {
                    var cx_ite=cb.interactors.begin();
                    while(cx_ite!=null){
                        var i=cx_ite.elem();
                        i.wake();
                        cx_ite=cx_ite.next;
                    }
                };
            }
        });
        options1.handler=null;
        options2.handler=null;
    }
    public override function invalidate_precedence(){
        if(space!=null){
            var pre=type==ZPP_Flags.id_ListenerType_PRE;
            with_union(function(cb:ZPP_CbType):Void{
                cb.removeint(this);
                cb.addint(this);
                if(pre){
                    {
                        var cx_ite=cb.interactors.begin();
                        while(cx_ite!=null){
                            var i=cx_ite.elem();
                            i.wake();
                            cx_ite=cx_ite.next;
                        }
                    };
                }
            });
        }
    }
    function cbtype_change1(cb:ZPP_CbType,included:Bool,added:Bool):Void{
        cbtype_change(options1,cb,included,added);
    }
    function cbtype_change2(cb:ZPP_CbType,included:Bool,added:Bool):Void{
        cbtype_change(options2,cb,included,added);
    }
    function cbtype_change(options:ZPP_OptionType,cb:ZPP_CbType,included:Bool,added:Bool):Void{
        space.revoke_listener(this);
        removedFromSpace();
        options.effect_change(cb,included,added);
        addedToSpace();
        space.unrevoke_listener(this);
    }
    public override function swapEvent(newev:Int){
        #if(!NAPE_RELEASE_BUILD)
        if(type==ZPP_Flags.id_ListenerType_PRE){
            throw "Error: PreListener event can only be PRE";
        }
        else if(newev!=ZPP_Flags.id_CbEvent_BEGIN&&newev!=ZPP_Flags.id_CbEvent_END&&newev!=ZPP_Flags.id_CbEvent_ONGOING){
            throw "Error: InteractionListener event must be either BEGIN, END, ONGOING";
        }
        #end
        removedFromSpace();
        event=newev;
        addedToSpace();
    }
}
