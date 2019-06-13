package zpp_nape.constraint;
import nape.callbacks.CbType;
import nape.callbacks.CbTypeList;
import nape.constraint.Constraint;
import nape.phys.Body;
import nape.util.Debug;
import zpp_nape.Const.ZPP_Const;
import zpp_nape.ID.ZPP_ID;
import zpp_nape.callbacks.CbSet.ZPP_CbSet;
import zpp_nape.callbacks.CbType;
import zpp_nape.phys.Body;
import zpp_nape.phys.Compound.ZPP_Compound;
import zpp_nape.space.Space.ZPP_Component;
import zpp_nape.space.Space.ZPP_Space;
import zpp_nape.util.Debug;
import zpp_nape.util.Lists.ZNPList_ZPP_CbType;
import zpp_nape.util.Lists.ZPP_CbTypeList;
#if nape_swc@:keep #end
class ZPP_Constraint{
    public var outer:Constraint=null;
    public function clear(){}
    public var id:Int=0;
    public var userData:Dynamic<Dynamic>=null;
    public var compound:ZPP_Compound=null;
    public var space:ZPP_Space=null;
    public var active:Bool=false;
    public var stiff:Bool=false;
    public var frequency:Float=0.0;
    public var damping:Float=0.0;
    public var maxForce:Float=0.0;
    public var maxError:Float=0.0;
    public var breakUnderForce:Bool=false;
    public var breakUnderError:Bool=false;
    public var removeOnBreak:Bool=false;
    public var component:ZPP_Component=null;
    public var ignore:Bool=false;
    public var __velocity:Bool=false;
    public function new(){
        __velocity=false;
        id=ZPP_ID.Constraint();
        stiff=true;
        active=true;
        ignore=false;
        frequency=10;
        damping=1;
        maxForce=ZPP_Const.POSINF();
        maxError=ZPP_Const.POSINF();
        breakUnderForce=false;
        removeOnBreak=true;
        pre_dt=-1.0;
        cbTypes=new ZNPList_ZPP_CbType();
    }
    public function immutable_midstep(name:String){
        #if(!NAPE_RELEASE_BUILD)
        if(space!=null&&space.midstep)throw "Error: Constraint::"+name+" cannot be set during space step()";
        #end
    }
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
        immutable_midstep("Constraint::cbTypes");
    }
    #end
    function wrap_cbTypes_subber(pcb:CbType):Void{
        var cb=pcb.zpp_inner;
        if(cbTypes.has(cb)){
            if(space!=null){
                dealloc_cbSet();
                cb.remConstraint(this);
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
            if(space!=null){
                dealloc_cbSet();
                cb.addConstraint(this);
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
            cbSet.addConstraint(this);
        }
    }
    public function dealloc_cbSet(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                space!=null;
            };
            if(!res)throw "assert("+"space!=null"+") :: "+("space null in dealloc_cbSet");
            #end
        };
        if(cbSet!=null){
            cbSet.remConstraint(this);
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
    public function activate(){
        if(space!=null)activeInSpace();
    }
    public function deactivate(){
        if(space!=null)inactiveOrOutSpace();
    }
    public function addedToSpace(){
        if(active)activeInSpace();
        activeBodies();
        {
            var cx_ite=cbTypes.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                cb.addConstraint(this);
                cx_ite=cx_ite.next;
            }
        };
    }
    public function removedFromSpace(){
        if(active)inactiveOrOutSpace();
        inactiveBodies();
        {
            var cx_ite=cbTypes.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                cb.remConstraint(this);
                cx_ite=cx_ite.next;
            }
        };
    }
    public function activeInSpace(){
        alloc_cbSet();
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                component==null;
            };
            if(!res)throw "assert("+"component==null"+") :: "+("already has a component?");
            #end
        };
        {
            if(ZPP_Component.zpp_pool==null){
                component=new ZPP_Component();
                #if NAPE_POOL_STATS ZPP_Component.POOL_TOT++;
                ZPP_Component.POOL_ADDNEW++;
                #end
            }
            else{
                component=ZPP_Component.zpp_pool;
                ZPP_Component.zpp_pool=component.next;
                component.next=null;
                #if NAPE_POOL_STATS ZPP_Component.POOL_CNT--;
                ZPP_Component.POOL_ADD++;
                #end
            }
            component.alloc();
        };
        component.isBody=false;
        component.constraint=this;
    }
    public function inactiveOrOutSpace(){
        dealloc_cbSet();
        {
            var o=component;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Component"+", in obj: "+"component"+")");
                #end
            };
            o.free();
            o.next=ZPP_Component.zpp_pool;
            ZPP_Component.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Component.POOL_CNT++;
            ZPP_Component.POOL_SUB++;
            #end
        };
        component=null;
    }
    #if nape_swc@:keep #end
    public function activeBodies(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("activeBodies not overriden");
            #end
        };
    }
    #if nape_swc@:keep #end
    public function inactiveBodies(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("inactiveBodies not overriden");
            #end
        };
    }
    #if nape_swc@:keep #end
    public function clearcache(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("clearcache not overriden");
            #end
        };
    }
    #if nape_swc@:keep #end
    public function validate(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("validate not overriden");
            #end
        };
    }
    #if nape_swc@:keep #end
    public function wake_connected(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("wake_connected not overriden");
            #end
        };
    }
    #if nape_swc@:keep #end
    public function forest(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("forest not overriden");
            #end
        };
    }
    #if nape_swc@:keep #end
    public function pair_exists(id:Int,di:Int){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("pair_exists not overriden");
            #end
        };
        return false;
    }
    #if nape_swc@:keep #end
    public function broken(){}
    #if nape_swc@:keep #end
    public function warmStart(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("warmStart not overriden");
            #end
        };
    }
    public var pre_dt:Float=0.0;
    #if nape_swc@:keep #end
    public function preStep(dt:Float):Bool{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("preStep not overriden");
            #end
        };
        return false;
    }
    #if nape_swc@:keep #end
    public function applyImpulseVel(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("applyImpulseVel not overriden");
            #end
        };
        return false;
    }
    #if nape_swc@:keep #end
    public function applyImpulsePos(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("applyImpulsePos not overriden");
            #end
        };
        return false;
    }
    public function wake(){
        if(space!=null)space.wake_constraint(this);
    }
    public function draw(g:Debug){}
    public function copy(dict:Array<ZPP_CopyHelper>=null,todo:Array<ZPP_CopyHelper>=null):Constraint{
        return null;
    }
    public function copyto(ret:Constraint){
        var me=outer;
        for(cb in me.cbTypes)ret.cbTypes.add(cb);
        ret.removeOnBreak=me.removeOnBreak;
        ret.breakUnderError=me.breakUnderError;
        ret.breakUnderForce=me.breakUnderForce;
        ret.maxError=me.maxError;
        ret.maxForce=me.maxForce;
        ret.damping=me.damping;
        ret.frequency=me.frequency;
        ret.stiff=me.stiff;
        ret.ignore=me.ignore;
        ret.active=me.active;
    }
}
#if nape_swc@:keep #end
class ZPP_CopyHelper{
    public var id:Int=0;
    public var bc:Body=null;
    public var cb:Body->Void=null;
    function new(){}
    public static function dict(id:Int,bc:Body){
        var ret=new ZPP_CopyHelper();
        ret.id=id;
        ret.bc=bc;
        return ret;
    }
    public static function todo(id:Int,cb:Body->Void){
        var ret=new ZPP_CopyHelper();
        ret.id=id;
        ret.cb=cb;
        return ret;
    }
}
