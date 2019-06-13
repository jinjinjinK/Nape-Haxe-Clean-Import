package zpp_nape.callbacks;
import nape.constraint.ConstraintList;
import nape.phys.InteractorList;
import zpp_nape.ID.ZPP_ID;
import zpp_nape.callbacks.CbType.ZPP_CbType;
import zpp_nape.callbacks.Listener.ZPP_InteractionListener;
import zpp_nape.callbacks.Listener.ZPP_Listener;
import zpp_nape.constraint.Constraint.ZPP_Constraint;
import zpp_nape.phys.Interactor.ZPP_Interactor;
import zpp_nape.space.Space.ZPP_CbSetManager;
import zpp_nape.util.Lists.ZNPList_ZPP_BodyListener;
import zpp_nape.util.Lists.ZNPList_ZPP_CbSetPair;
import zpp_nape.util.Lists.ZNPList_ZPP_CbType;
import zpp_nape.util.Lists.ZNPList_ZPP_Constraint;
import zpp_nape.util.Lists.ZNPList_ZPP_ConstraintListener;
import zpp_nape.util.Lists.ZNPList_ZPP_InteractionListener;
import zpp_nape.util.Lists.ZNPList_ZPP_Interactor;
#if nape_swc@:keep #end
class ZPP_CbSet{
    public var cbTypes:ZNPList_ZPP_CbType=null;
    public var count:Int=0;
    public var next:ZPP_CbSet=null;
    static public var zpp_pool:ZPP_CbSet=null;
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
    
    public var id:Int=0;
    public var manager:ZPP_CbSetManager=null;
    public var cbpairs:ZNPList_ZPP_CbSetPair=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function increment():Void{
        count++;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function decrement():Bool{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                count>0;
            };
            if(!res)throw "assert("+"count>0"+") :: "+("decrementing ref.count into negatives??");
            #end
        };
        return(--count)==0;
    }
    public function invalidate_pairs():Void{
        {
            var cx_ite=cbpairs.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                cb.invalidate();
                cx_ite=cx_ite.next;
            }
        };
    }
    public var listeners:ZNPList_ZPP_InteractionListener=null;
    public var zip_listeners:Bool=false;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function invalidate_listeners():Void{
        zip_listeners=true;
        #if true invalidate_pairs();
        #end
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function validate_listeners():Void{
        if(zip_listeners){
            zip_listeners=false;
            realvalidate_listeners();
        }
    }
    public function realvalidate_listeners(){
        listeners.clear();
        {
            var cx_ite=cbTypes.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                {
                    var npre=null;
                    var nite=listeners.begin();
                    var cite=cb.listeners.begin();
                    while(cite!=null){
                        var cx=cite.elem();
                        if(nite!=null&&nite.elem()==cx){
                            cite=cite.next;
                            npre=nite;
                            nite=nite.next;
                        }
                        else if(nite==null||ZPP_Listener.setlt(cx,nite.elem())){
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    !listeners.has(cx);
                                };
                                if(!res)throw "assert("+"!listeners.has(cx)"+") :: "+("merged list already contains listener");
                                #end
                            };
                            if(#if true true#else!cx.options.excluded(cbTypes)#end
                            &&manager.valid_listener(cx)){
                                npre=listeners.inlined_insert(npre,cx);
                            }
                            cite=cite.next;
                        }
                        else{
                            npre=nite;
                            nite=nite.next;
                        }
                    }
                };
                cx_ite=cx_ite.next;
            }
        };
    }
    public var bodylisteners:ZNPList_ZPP_BodyListener=null;
    public var zip_bodylisteners:Bool=false;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function invalidate_bodylisteners():Void{
        zip_bodylisteners=true;
        #if false invalidate_pairs();
        #end
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function validate_bodylisteners():Void{
        if(zip_bodylisteners){
            zip_bodylisteners=false;
            realvalidate_bodylisteners();
        }
    }
    public function realvalidate_bodylisteners(){
        bodylisteners.clear();
        {
            var cx_ite=cbTypes.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                {
                    var npre=null;
                    var nite=bodylisteners.begin();
                    var cite=cb.bodylisteners.begin();
                    while(cite!=null){
                        var cx=cite.elem();
                        if(nite!=null&&nite.elem()==cx){
                            cite=cite.next;
                            npre=nite;
                            nite=nite.next;
                        }
                        else if(nite==null||ZPP_Listener.setlt(cx,nite.elem())){
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    !bodylisteners.has(cx);
                                };
                                if(!res)throw "assert("+"!bodylisteners.has(cx)"+") :: "+("merged list already contains listener");
                                #end
                            };
                            if(#if false true#else!cx.options.excluded(cbTypes)#end
                            &&manager.valid_listener(cx)){
                                npre=bodylisteners.inlined_insert(npre,cx);
                            }
                            cite=cite.next;
                        }
                        else{
                            npre=nite;
                            nite=nite.next;
                        }
                    }
                };
                cx_ite=cx_ite.next;
            }
        };
    }
    public var conlisteners:ZNPList_ZPP_ConstraintListener=null;
    public var zip_conlisteners:Bool=false;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function invalidate_conlisteners():Void{
        zip_conlisteners=true;
        #if false invalidate_pairs();
        #end
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function validate_conlisteners():Void{
        if(zip_conlisteners){
            zip_conlisteners=false;
            realvalidate_conlisteners();
        }
    }
    public function realvalidate_conlisteners(){
        conlisteners.clear();
        {
            var cx_ite=cbTypes.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                {
                    var npre=null;
                    var nite=conlisteners.begin();
                    var cite=cb.conlisteners.begin();
                    while(cite!=null){
                        var cx=cite.elem();
                        if(nite!=null&&nite.elem()==cx){
                            cite=cite.next;
                            npre=nite;
                            nite=nite.next;
                        }
                        else if(nite==null||ZPP_Listener.setlt(cx,nite.elem())){
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    !conlisteners.has(cx);
                                };
                                if(!res)throw "assert("+"!conlisteners.has(cx)"+") :: "+("merged list already contains listener");
                                #end
                            };
                            if(#if false true#else!cx.options.excluded(cbTypes)#end
                            &&manager.valid_listener(cx)){
                                npre=conlisteners.inlined_insert(npre,cx);
                            }
                            cite=cite.next;
                        }
                        else{
                            npre=nite;
                            nite=nite.next;
                        }
                    }
                };
                cx_ite=cx_ite.next;
            }
        };
    }
    public function validate(){
        
        validate_listeners();
        validate_bodylisteners();
        validate_conlisteners();
    }
    public var interactors:ZNPList_ZPP_Interactor=null;
    public var wrap_interactors:InteractorList=null;
    public var constraints:ZNPList_ZPP_Constraint=null;
    public var wrap_constraints:ConstraintList=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function addConstraint(con:ZPP_Constraint){
        constraints.add(con);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function addInteractor(intx:ZPP_Interactor){
        interactors.add(intx);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function remConstraint(con:ZPP_Constraint){
        constraints.remove(con);
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function remInteractor(intx:ZPP_Interactor){
        interactors.remove(intx);
    }
    public static function setlt(a:ZPP_CbSet,b:ZPP_CbSet):Bool{
        var i=a.cbTypes.begin();
        var j=b.cbTypes.begin();
        while(i!=null&&j!=null){
            var ca=i.elem();
            var cb=j.elem();
            if(ZPP_CbType.setlt(ca,cb))return true;
            if(ZPP_CbType.setlt(cb,ca))return false;
            else{
                i=i.next;
                j=j.next;
            }
        }
        return j!=null&&i==null;
    }
    public function new(){
        cbTypes=new ZNPList_ZPP_CbType();
        
        listeners=new ZNPList_ZPP_InteractionListener();
        zip_listeners=true;
        bodylisteners=new ZNPList_ZPP_BodyListener();
        zip_bodylisteners=true;
        conlisteners=new ZNPList_ZPP_ConstraintListener();
        zip_conlisteners=true;
        constraints=new ZNPList_ZPP_Constraint();
        interactors=new ZNPList_ZPP_Interactor();
        id=ZPP_ID.CbSet();
        cbpairs=new ZNPList_ZPP_CbSetPair();
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function free():Void{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                constraints.empty();
            };
            if(!res)throw "assert("+"constraints.empty()"+") :: "+("non-empty constraints");
            #end
        };
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                interactors.empty();
            };
            if(!res)throw "assert("+"interactors.empty()"+") :: "+("non-empty interactors");
            #end
        };
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                count==0;
            };
            if(!res)throw "assert("+"count==0"+") :: "+("deallocating with count!=0?");
            #end
        };
        
        listeners.clear();
        zip_listeners=true;
        bodylisteners.clear();
        zip_bodylisteners=true;
        conlisteners.clear();
        zip_conlisteners=true;
        {
            while(!cbTypes.empty()){
                var cb=cbTypes.pop_unsafe();
                cb.cbsets.remove(this);
            }
        };
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cbpairs.empty();
            };
            if(!res)throw "assert("+"cbpairs.empty()"+") :: "+("non-empty cbpairs");
            #end
        };
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc():Void{}
    #if NAPE_ASSERT public static function assert_cbTypes(cbTypes:ZNPList_ZPP_CbType):Void{
        var pre=null;
        {
            var cx_ite=cbTypes.begin();
            while(cx_ite!=null){
                var cur=cx_ite.elem();
                {
                    if(pre!=null){
                        {
                            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                            var res={
                                ZPP_CbType.setlt(pre,cur);
                            };
                            if(!res)throw "assert("+"ZPP_CbType.setlt(pre,cur)"+") :: "+("cbTypes of CbSet not well-ordered!");
                            #end
                        };
                    }
                    pre=cur;
                };
                cx_ite=cx_ite.next;
            }
        };
    }
    #end
    public static function get(cbTypes:ZNPList_ZPP_CbType){
        var ret;
        {
            if(ZPP_CbSet.zpp_pool==null){
                ret=new ZPP_CbSet();
                #if NAPE_POOL_STATS ZPP_CbSet.POOL_TOT++;
                ZPP_CbSet.POOL_ADDNEW++;
                #end
            }
            else{
                ret=ZPP_CbSet.zpp_pool;
                ZPP_CbSet.zpp_pool=ret.next;
                ret.next=null;
                #if NAPE_POOL_STATS ZPP_CbSet.POOL_CNT--;
                ZPP_CbSet.POOL_ADD++;
                #end
            }
            ret.alloc();
        };
        var ite=null;
        #if NAPE_ASSERT assert_cbTypes(cbTypes);
        #end
        {
            var cx_ite=cbTypes.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                {
                    ite=ret.cbTypes.insert(ite,cb);
                    cb.cbsets.add(ret);
                };
                cx_ite=cx_ite.next;
            }
        };
        return ret;
    }
    #if NAPE_NO_INLINE#else inline #end
    static function compatible(i:ZPP_InteractionListener,a:ZPP_CbSet,b:ZPP_CbSet):Bool{
        return(i.options1.compatible(a.cbTypes)&&i.options2.compatible(b.cbTypes))||(i.options2.compatible(a.cbTypes)&&i.options1.compatible(b.cbTypes));
    }
    public static#if NAPE_NO_INLINE#else inline #end
    function empty_intersection(a:ZPP_CbSet,b:ZPP_CbSet):Bool{
        return a.manager.pair(a,b).empty_intersection();
    }
    public static function single_intersection(a:ZPP_CbSet,b:ZPP_CbSet,i:ZPP_InteractionListener):Bool{
        return a.manager.pair(a,b).single_intersection(i);
    }
    #if NAPE_NO_INLINE#else inline #end
    public static function find_all(a:ZPP_CbSet,b:ZPP_CbSet,event:Int,cb:ZPP_InteractionListener->Void):Void{
        a.manager.pair(a,b).forall(event,cb);
    }
}
