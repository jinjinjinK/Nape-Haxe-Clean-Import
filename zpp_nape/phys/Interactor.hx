package zpp_nape.phys;
import nape.callbacks.CbType;
import nape.callbacks.CbTypeList;
import nape.phys.Interactor;
import zpp_nape.ID.ZPP_ID;
import zpp_nape.callbacks.Callback.ZPP_Callback;
import zpp_nape.callbacks.CbSet.ZPP_CbSet;
import zpp_nape.callbacks.CbType;
import zpp_nape.callbacks.Listener.ZPP_InteractionListener;
import zpp_nape.dynamics.InteractionGroup.ZPP_InteractionGroup;
import zpp_nape.phys.Body.ZPP_Body;
import zpp_nape.phys.Compound.ZPP_Compound;
import zpp_nape.shape.Shape.ZPP_Shape;
import zpp_nape.space.Space.ZPP_CallbackSet;
import zpp_nape.util.Lists.ZNPList_ZPP_CallbackSet;
import zpp_nape.util.Lists.ZNPList_ZPP_CbType;
import zpp_nape.util.Lists.ZPP_CbTypeList;
#if nape_swc@:keep #end
class ZPP_Interactor{
    public var outer_i:Interactor=null;
    public var id:Int=0;
    public var userData:Dynamic<Dynamic>=null;
    public var ishape:ZPP_Shape=null;
    public var ibody:ZPP_Body=null;
    public var icompound:ZPP_Compound=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function isShape(){
        return ishape!=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function isBody(){
        return ibody!=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function isCompound(){
        return icompound!=null;
    }
    public function __iaddedToSpace(){
        if(group!=null)group.addInteractor(this);
        {
            var cx_ite=cbTypes.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                cb.addInteractor(this);
                cx_ite=cx_ite.next;
            }
        };
        alloc_cbSet();
    }
    public function __iremovedFromSpace(){
        if(group!=null)group.remInteractor(this);
        {
            var cx_ite=cbTypes.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                cb.remInteractor(this);
                cx_ite=cx_ite.next;
            }
        };
        dealloc_cbSet();
    }
    public function wake(){
        if(isShape()){
            var body=ishape.body;
            if(body!=null&&body.space!=null)body.space.non_inlined_wake(body);
            true;
        }
        else if(isBody()){
            if(ibody.space!=null)ibody.space.non_inlined_wake(ibody)else false;
        }
        else{
            if(icompound.space!=null)icompound.space.wakeCompound(icompound);
            true;
        }
    }
    public var cbsets:ZNPList_ZPP_CallbackSet=null;
    public static function get(i1:ZPP_Interactor,i2:ZPP_Interactor){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                i1!=i2;
            };
            if(!res)throw "assert("+"i1!=i2"+") :: "+("trying to get cbset between interactor and itself?");
            #end
        };
        var id=if(i1.id<i2.id)i1.id else i2.id;
        var di=if(i1.id<i2.id)i2.id else i1.id;
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                id<di;
            };
            if(!res)throw "assert("+"id<di"+") :: "+("interactor id's not ordered well when getting cbset");
            #end
        };
        var xs=if(i1.cbsets.length<i2.cbsets.length)i1.cbsets else i2.cbsets;
        var ret:ZPP_CallbackSet=null;
        {
            var cx_ite=xs.begin();
            while(cx_ite!=null){
                var x=cx_ite.elem();
                {
                    {
                        #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                        var res={
                            !(x.id==di&&x.di==id);
                        };
                        if(!res)throw "assert("+"!(x.id==di&&x.di==id)"+") :: "+("cbset order doesn't match interactor order getting cbset?");
                        #end
                    };
                    if(x.id==id&&x.di==di){
                        ret=x;
                        break;
                    }
                };
                cx_ite=cx_ite.next;
            }
        };
        return ret;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function getSpace(){
        return if(isShape())ishape.body==null?null:ishape.body.space else if(isBody())ibody.space else icompound.space;
    }
    public var group:ZPP_InteractionGroup=null;
    public var cbTypes:ZNPList_ZPP_CbType=null;
    public var cbSet:ZPP_CbSet=null;
    public var wrap_cbTypes:CbTypeList=null;
    public function setupcbTypes(){
        wrap_cbTypes=ZPP_CbTypeList.get(cbTypes);
        wrap_cbTypes.zpp_inner.adder=wrap_cbTypes_adder;
        wrap_cbTypes.zpp_inner.subber=wrap_cbTypes_subber;
        wrap_cbTypes.zpp_inner.dontremove=true;
        #if(!NAPE_RELEASE_BUILD)
        wrap_cbTypes.zpp_inner._modifiable=immutable_cbTypes;
        #end
    }
    #if(!NAPE_RELEASE_BUILD)
    function immutable_cbTypes(){
        immutable_midstep("Interactor::cbTypes");
    }
    #end
    function wrap_cbTypes_subber(pcb:CbType):Void{
        var cb=pcb.zpp_inner;
        if(cbTypes.has(cb)){
            var space=getSpace();
            if(space!=null){
                dealloc_cbSet();
                cb.remInteractor(this);
            }
            cbTypes.remove(cb);
            if(space!=null){
                alloc_cbSet();
                wake();
            }
        }
    }
    function wrap_cbTypes_adder(cb:CbType):Bool{
        insert_cbtype(cb.zpp_inner);
        return false;
    }
    public function insert_cbtype(cb:ZPP_CbType){
        if(!cbTypes.has(cb)){
            var space=getSpace();
            if(space!=null){
                dealloc_cbSet();
                cb.addInteractor(this);
            }
            {
                var pre=null;
                {
                    var cx_ite=cbTypes.begin();
                    while(cx_ite!=null){
                        var j=cx_ite.elem();
                        {
                            if(ZPP_CbType.setlt(cb,j))break;
                            pre=cx_ite;
                        };
                        cx_ite=cx_ite.next;
                    }
                };
                cbTypes.inlined_insert(pre,cb);
            };
            if(space!=null){
                alloc_cbSet();
                wake();
            }
        }
    }
    public function alloc_cbSet(){
        var space=getSpace();
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                space!=null;
            };
            if(!res)throw "assert("+"space!=null"+") :: "+("space null in alloc_cbSet");
            #end
        };
        if((cbSet=space.cbsets.get(cbTypes))!=null){
            cbSet.increment();
            cbSet.addInteractor(this);
            cbSet.validate();
            space.freshInteractorType(this);
        }
    }
    public function dealloc_cbSet(){
        var space=getSpace();
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                space!=null;
            };
            if(!res)throw "assert("+"space!=null"+") :: "+("space null in dealloc_cbSet");
            #end
        };
        if(cbSet!=null){
            cbSet.remInteractor(this);
            space.nullInteractorType(this);
            if(cbSet.decrement()){
                space.cbsets.remove(cbSet);
                {
                    var o=cbSet;
                    {
                        #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                        var res={
                            o!=null;
                        };
                        if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_CbSet"+", in obj: "+"cbSet"+")");
                        #end
                    };
                    o.free();
                    o.next=ZPP_CbSet.zpp_pool;
                    ZPP_CbSet.zpp_pool=o;
                    #if NAPE_POOL_STATS ZPP_CbSet.POOL_CNT++;
                    ZPP_CbSet.POOL_SUB++;
                    #end
                };
            }
            cbSet=null;
        }
    }
    public function setGroup(group:ZPP_InteractionGroup){
        if(this.group!=group){
            var inspace=getSpace()!=null;
            if(inspace&&this.group!=null)this.group.remInteractor(this);
            this.group=group;
            if(inspace&&group!=null)group.addInteractor(this);
            if(inspace){
                if(isShape())ishape.body.wake();
                else if(isBody())ibody.wake();
                else icompound.wake();
            }
        }
    }
    public function immutable_midstep(n:String){
        if(isBody())ibody.__immutable_midstep(n);
        else if(isShape())ishape.__immutable_midstep(n);
        else icompound.__imutable_midstep(n);
    }
    public function new(){
        id=ZPP_ID.Interactor();
        cbsets=new ZNPList_ZPP_CallbackSet();
        cbTypes=new ZNPList_ZPP_CbType();
    }
    public#if NAPE_NO_INLINE#else inline #end
    static function int_callback(set:ZPP_CallbackSet,x:ZPP_InteractionListener,cb:ZPP_Callback){
        var o1=set.int1;
        var o2=set.int2;
        if(x.options1.compatible(o1.cbTypes)&&x.options2.compatible(o2.cbTypes)){
            cb.int1=o1;
            cb.int2=o2;
        }
        else{
            cb.int1=o2;
            cb.int2=o1;
        }
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function lookup_group(){
        var cur:ZPP_Interactor=this;
        while(cur!=null&&cur.group==null){
            if(cur.isShape())cur=cur.ishape.body;
            else if(cur.isCompound())cur=cur.icompound.compound;
            else cur=cur.ibody.compound;
        }
        return if(cur==null)null else cur.group;
    }
    public function copyto(ret:Interactor){
        ret.zpp_inner_i.group=group;
        for(cb in outer_i.cbTypes)ret.cbTypes.add(cb);
        if(userData!=null)ret.zpp_inner_i.userData=Reflect.copy(userData);
    }
}
