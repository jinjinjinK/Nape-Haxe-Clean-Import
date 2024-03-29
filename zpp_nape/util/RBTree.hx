package zpp_nape.util;
import zpp_nape.callbacks.CbSet.ZPP_CbSet;
import zpp_nape.callbacks.CbSetPair.ZPP_CbSetPair;
import zpp_nape.geom.PartitionedPoly.ZPP_PartitionVertex;
import zpp_nape.geom.Simple.ZPP_SimpleEvent;
import zpp_nape.geom.Simple.ZPP_SimpleSeg;
import zpp_nape.geom.Simple.ZPP_SimpleVert;
import zpp_nape.geom.Triangular.ZPP_PartitionPair;
import zpp_nape.phys.Body.ZPP_Body;

#if nape_swc@:keep #end
class ZPP_Set_ZPP_Body{
    static public var zpp_pool:ZPP_Set_ZPP_Body=null;
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
    function free(){
        data=null;
        lt=null;
        swapped=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    public var lt:ZPP_Body->ZPP_Body->Bool=null;
    public var swapped:ZPP_Body->ZPP_Body->Void=null;
    public var data:ZPP_Body=null;
    public var prev:ZPP_Set_ZPP_Body=null;
    public var next:ZPP_Set_ZPP_Body=null;
    public var parent:ZPP_Set_ZPP_Body=null;
    public var colour:Int=0;
    public function new(){}
    public function verify(){
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    this!=null;
                };
                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                #end
            };
            if(!this.empty()){
                var set_ite=this.parent;
                while(set_ite.prev!=null)set_ite=set_ite.prev;
                while(set_ite!=null){
                    var i=set_ite.data;
                    {
                        var prei=true;
                        {
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    this!=null;
                                };
                                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                                #end
                            };
                            if(!this.empty()){
                                var set_ite=this.parent;
                                while(set_ite.prev!=null)set_ite=set_ite.prev;
                                while(set_ite!=null){
                                    var j=set_ite.data;
                                    {
                                        if(!prei){
                                            if(!lt(i,j)&&lt(j,i))return false;
                                        }
                                        else if(i==j)prei=false;
                                        else{
                                            if(!lt(j,i)&&lt(i,j))return false;
                                        }
                                    };
                                    if(set_ite.next!=null){
                                        set_ite=set_ite.next;
                                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                                    }
                                    else{
                                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                                        set_ite=set_ite.parent;
                                    }
                                }
                            }
                        };
                    };
                    if(set_ite.next!=null){
                        set_ite=set_ite.next;
                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                    }
                    else{
                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                        set_ite=set_ite.parent;
                    }
                }
            }
        };
        return true;
    }
    public function empty(){
        return parent==null;
    }
    public function singular(){
        return parent!=null&&parent.prev==null&&parent.next==null;
    }
    public function size(){
        var ret=0;
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    this!=null;
                };
                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                #end
            };
            if(!this.empty()){
                var set_ite=this.parent;
                while(set_ite.prev!=null)set_ite=set_ite.prev;
                while(set_ite!=null){
                    var i=set_ite.data;
                    ret++;
                    if(set_ite.next!=null){
                        set_ite=set_ite.next;
                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                    }
                    else{
                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                        set_ite=set_ite.parent;
                    }
                }
            }
        };
        return ret;
    }
    public function has(obj:ZPP_Body){
        return find(obj)!=null;
    }
    public function find(obj:ZPP_Body){
        var cur=parent;
        while(cur!=null&&cur.data!=obj){
            if(lt(obj,cur.data))cur=cur.prev;
            else cur=cur.next;
        }
        return cur;
    }
    public function has_weak(obj:ZPP_Body){
        return find_weak(obj)!=null;
    }
    public function find_weak(obj:ZPP_Body){
        var cur=parent;
        while(cur!=null){
            if(lt(obj,cur.data))cur=cur.prev;
            else if(lt(cur.data,obj))cur=cur.next;
            else break;
        }
        return cur;
    }
    public function lower_bound(obj:ZPP_Body){
        return{
            var ret=null;
            {
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        this!=null;
                    };
                    if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                    #end
                };
                if(!this.empty()){
                    var set_ite=this.parent;
                    while(set_ite.prev!=null)set_ite=set_ite.prev;
                    while(set_ite!=null){
                        var elt=set_ite.data;
                        {
                            if(!lt(elt,obj)){
                                ret=elt;
                                break;
                            }
                        };
                        if(set_ite.next!=null){
                            set_ite=set_ite.next;
                            while(set_ite.prev!=null)set_ite=set_ite.prev;
                        }
                        else{
                            while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                            set_ite=set_ite.parent;
                        }
                    }
                }
            };
            ret;
        };
    }
    public function first(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("first in empty");
            #end
        };
        var cur=parent;
        while(cur.prev!=null)cur=cur.prev;
        return cur.data;
    }
    public function pop_front(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("pop_front in empty");
            #end
        };
        var cur=parent;
        while(cur.prev!=null)cur=cur.prev;
        var ret=cur.data;
        remove_node(cur);
        return ret;
    }
    public function remove(obj:ZPP_Body){
        var node=find(obj);
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                node!=null;
            };
            if(!res)throw "assert("+"node!=null"+") :: "+("object not in tree");
            #end
        };
        remove_node(node);
    }
    public function successor_node(cur:ZPP_Set_ZPP_Body){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.next!=null){
            cur=cur.next;
            while(cur.prev!=null)cur=cur.prev;
        }
        else{
            var pre=cur;
            cur=cur.parent;
            while(cur!=null&&cur.prev!=pre){
                pre=cur;
                cur=cur.parent;
            }
        }
        return cur;
    }
    public function predecessor_node(cur:ZPP_Set_ZPP_Body){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.prev!=null){
            cur=cur.prev;
            while(cur.next!=null)cur=cur.next;
        }
        else{
            var pre=cur;
            cur=cur.parent;
            while(cur!=null&&cur.next!=pre){
                pre=cur;
                cur=cur.parent;
            }
        }
        return cur;
    }
    public function successor(obj:ZPP_Body){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("not in tree!");
            #end
        };
        var node=successor_node(find(obj));
        return node==null?null:node.data;
    }
    public function predecessor(obj:ZPP_Body){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("not in tree!");
            #end
        };
        var node=predecessor_node(find(obj));
        return node==null?null:node.data;
    }
    public function remove_node(cur:ZPP_Set_ZPP_Body){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.next!=null&&cur.prev!=null){
            var sm=cur.next;
            while(sm.prev!=null)sm=sm.prev;
            {
                var t=cur.data;
                cur.data=sm.data;
                sm.data=t;
            };
            if(swapped!=null)swapped(cur.data,sm.data);
            cur=sm;
        }
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur.next==null||cur.prev==null;
            };
            if(!res)throw "assert("+"cur.next==null||cur.prev==null"+") :: "+("node still has two children??");
            #end
        };
        var child=if(cur.prev==null)cur.next else cur.prev;
        if(cur.colour==1){
            if(cur.prev!=null||cur.next!=null)child.colour=1;
            else if(cur.parent!=null){
                var parent=cur.parent;
                while(true){
                    parent.colour++;
                    parent.prev.colour--;
                    parent.next.colour--;
                    {
                        var child=parent.prev;
                        if(child.colour==(-1)){
                            __fix_neg_red(child);
                            break;
                        }
                        else if(child.colour==0){
                            {
                                if(child.prev!=null&&child.prev.colour==0){
                                    __fix_dbl_red(child.prev);
                                    break;
                                }
                            }
                            {
                                if(child.next!=null&&child.next.colour==0){
                                    __fix_dbl_red(child.next);
                                    break;
                                }
                            }
                        }
                    }
                    {
                        var child=parent.next;
                        if(child.colour==(-1)){
                            __fix_neg_red(child);
                            break;
                        }
                        else if(child.colour==0){
                            {
                                if(child.prev!=null&&child.prev.colour==0){
                                    __fix_dbl_red(child.prev);
                                    break;
                                }
                            }
                            {
                                if(child.next!=null&&child.next.colour==0){
                                    __fix_dbl_red(child.next);
                                    break;
                                }
                            }
                        }
                    }
                    if(parent.colour==2){
                        if(parent.parent==null){
                            parent.colour=1;
                        }
                        else{
                            parent=parent.parent;
                            continue;
                        }
                    }
                    break;
                }
            }
        }
        {
            var par=cur.parent;
            if(par==null){
                parent=child;
            }
            else if(par.prev==cur)par.prev=child;
            else par.next=child;
            if(child!=null)child.parent=par;
        };
        cur.parent=cur.prev=cur.next=null;
        {
            var o=cur;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_Body"+", in obj: "+"cur"+")");
                #end
            };
            o.free();
            o.next=ZPP_Set_ZPP_Body.zpp_pool;
            ZPP_Set_ZPP_Body.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Set_ZPP_Body.POOL_CNT++;
            ZPP_Set_ZPP_Body.POOL_SUB++;
            #end
        };
    }
    public function clear(){
        clear_with(function(_){});
    }
    public#if NAPE_NO_INLINE#else inline #end
    function clear_with(lambda:ZPP_Body->Void){
        if(parent==null)return;
        else{
            var cur=parent;
            while(cur!=null)cur=if(cur.prev!=null)cur.prev else if(cur.next!=null)cur.next else clear_node(cur,lambda);
            parent=null;
        }
    }
    #if NAPE_NO_INLINE#else inline #end
    function clear_node(node:ZPP_Set_ZPP_Body,lambda:ZPP_Body->Void){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                node.next==null&&node.prev==null;
            };
            if(!res)throw "assert("+"node.next==null&&node.prev==null"+") :: "+("clear_node :: node not a leaf");
            #end
        };
        lambda(node.data);
        var ret=node.parent;
        if(ret!=null){
            if(node==ret.prev)ret.prev=null;
            else ret.next=null;
            node.parent=null;
        }
        {
            var o=node;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_Body"+", in obj: "+"node"+")");
                #end
            };
            o.free();
            o.next=ZPP_Set_ZPP_Body.zpp_pool;
            ZPP_Set_ZPP_Body.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Set_ZPP_Body.POOL_CNT++;
            ZPP_Set_ZPP_Body.POOL_SUB++;
            #end
        };
        return ret;
    }
    public function __fix_neg_red(negred:ZPP_Set_ZPP_Body){
        var parent=negred.parent;
        var child=if(parent.prev==negred){
            var nl=negred.prev;
            var nr=negred.next;
            var trl=nr.prev;
            var trr=nr.next;
            nl.colour=0;
            negred.colour=parent.colour=1;
            {
                negred.next=trl;
                if(trl!=null)trl.parent=negred;
            };
            {
                var t=parent.data;
                parent.data=nr.data;
                nr.data=t;
            };
            if(swapped!=null)swapped(parent.data,nr.data);
            {
                nr.prev=trr;
                if(trr!=null)trr.parent=nr;
            };
            {
                nr.next=parent.next;
                if(parent.next!=null)parent.next.parent=nr;
            };
            {
                parent.next=nr;
                if(nr!=null)nr.parent=parent;
            };
            nl;
        };
        else{
            var nl=negred.next;
            var nr=negred.prev;
            var trl=nr.next;
            var trr=nr.prev;
            nl.colour=0;
            negred.colour=parent.colour=1;
            {
                negred.prev=trl;
                if(trl!=null)trl.parent=negred;
            };
            {
                var t=parent.data;
                parent.data=nr.data;
                nr.data=t;
            };
            if(swapped!=null)swapped(parent.data,nr.data);
            {
                nr.next=trr;
                if(trr!=null)trr.parent=nr;
            };
            {
                nr.prev=parent.prev;
                if(parent.prev!=null)parent.prev.parent=nr;
            };
            {
                parent.prev=nr;
                if(nr!=null)nr.parent=parent;
            };
            nl;
        };
        if(child.prev!=null&&child.prev.colour==0)__fix_dbl_red(child.prev);
        else if(child.next!=null&&child.next.colour==0)__fix_dbl_red(child.next);
    }
    public function __fix_dbl_red(x:ZPP_Set_ZPP_Body){
        while(true){
            var par=x.parent;
            var g=par.parent;
            if(g==null){
                par.colour=1;
                break;
            }
            var n1:ZPP_Set_ZPP_Body,n2:ZPP_Set_ZPP_Body,n3:ZPP_Set_ZPP_Body,t1:ZPP_Set_ZPP_Body,t2:ZPP_Set_ZPP_Body,t3:ZPP_Set_ZPP_Body,t4:ZPP_Set_ZPP_Body;
            if(par==g.prev){
                n3=g;
                t4=g.next;
                if(x==par.prev){
                    n1=x;
                    n2=par;
                    t1=x.prev;
                    t2=x.next;
                    t3=par.next;
                }
                else{
                    n1=par;
                    n2=x;
                    t1=par.prev;
                    t2=x.prev;
                    t3=x.next;
                }
            }
            else{
                n1=g;
                t1=g.prev;
                if(x==par.prev){
                    n2=x;
                    n3=par;
                    t2=x.prev;
                    t3=x.next;
                    t4=par.next;
                }
                else{
                    n2=par;
                    n3=x;
                    t2=par.prev;
                    t3=x.prev;
                    t4=x.next;
                }
            }
            {
                var par=g.parent;
                if(par==null){
                    parent=n2;
                }
                else if(par.prev==g)par.prev=n2;
                else par.next=n2;
                if(n2!=null)n2.parent=par;
            };
            {
                n1.prev=t1;
                if(t1!=null)t1.parent=n1;
            };
            {
                n1.next=t2;
                if(t2!=null)t2.parent=n1;
            };
            {
                n2.prev=n1;
                if(n1!=null)n1.parent=n2;
            };
            {
                n2.next=n3;
                if(n3!=null)n3.parent=n2;
            };
            {
                n3.prev=t3;
                if(t3!=null)t3.parent=n3;
            };
            {
                n3.next=t4;
                if(t4!=null)t4.parent=n3;
            };
            n2.colour=g.colour-1;
            n1.colour=1;
            n3.colour=1;
            if(n2==parent)parent.colour=1;
            else if(n2.colour==0&&n2.parent.colour==0){
                x=n2;
                continue;
            }
            break;
        }
    }
    public function try_insert_bool(obj:ZPP_Body){
        var x:ZPP_Set_ZPP_Body=null;
        var cur:ZPP_Set_ZPP_Body=null;
        if(parent==null){
            {
                if(ZPP_Set_ZPP_Body.zpp_pool==null){
                    x=new ZPP_Set_ZPP_Body();
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_Body.POOL_TOT++;
                    ZPP_Set_ZPP_Body.POOL_ADDNEW++;
                    #end
                }
                else{
                    x=ZPP_Set_ZPP_Body.zpp_pool;
                    ZPP_Set_ZPP_Body.zpp_pool=x.next;
                    x.next=null;
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_Body.POOL_CNT--;
                    ZPP_Set_ZPP_Body.POOL_ADD++;
                    #end
                }
                x.alloc();
            };
            x.data=obj;
            parent=x;
        }
        else{
            cur=parent;
            while(true){
                if(lt(obj,cur.data)){
                    if(cur.prev==null){
                        {
                            if(ZPP_Set_ZPP_Body.zpp_pool==null){
                                x=new ZPP_Set_ZPP_Body();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_Body.POOL_TOT++;
                                ZPP_Set_ZPP_Body.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_Body.zpp_pool;
                                ZPP_Set_ZPP_Body.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_Body.POOL_CNT--;
                                ZPP_Set_ZPP_Body.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else if(lt(cur.data,obj)){
                    if(cur.next==null){
                        {
                            if(ZPP_Set_ZPP_Body.zpp_pool==null){
                                x=new ZPP_Set_ZPP_Body();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_Body.POOL_TOT++;
                                ZPP_Set_ZPP_Body.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_Body.zpp_pool;
                                ZPP_Set_ZPP_Body.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_Body.POOL_CNT--;
                                ZPP_Set_ZPP_Body.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
                else break;
            }
        }
        if(x==null)return false;
        else{
            if(x.parent==null)x.colour=1;
            else{
                x.colour=0;
                if(x.parent.colour==0)__fix_dbl_red(x);
            }
            return true;
        }
    }
    public function try_insert(obj:ZPP_Body){
        var x:ZPP_Set_ZPP_Body=null;
        var cur:ZPP_Set_ZPP_Body=null;
        if(parent==null){
            {
                if(ZPP_Set_ZPP_Body.zpp_pool==null){
                    x=new ZPP_Set_ZPP_Body();
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_Body.POOL_TOT++;
                    ZPP_Set_ZPP_Body.POOL_ADDNEW++;
                    #end
                }
                else{
                    x=ZPP_Set_ZPP_Body.zpp_pool;
                    ZPP_Set_ZPP_Body.zpp_pool=x.next;
                    x.next=null;
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_Body.POOL_CNT--;
                    ZPP_Set_ZPP_Body.POOL_ADD++;
                    #end
                }
                x.alloc();
            };
            x.data=obj;
            parent=x;
        }
        else{
            cur=parent;
            while(true){
                if(lt(obj,cur.data)){
                    if(cur.prev==null){
                        {
                            if(ZPP_Set_ZPP_Body.zpp_pool==null){
                                x=new ZPP_Set_ZPP_Body();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_Body.POOL_TOT++;
                                ZPP_Set_ZPP_Body.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_Body.zpp_pool;
                                ZPP_Set_ZPP_Body.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_Body.POOL_CNT--;
                                ZPP_Set_ZPP_Body.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else if(lt(cur.data,obj)){
                    if(cur.next==null){
                        {
                            if(ZPP_Set_ZPP_Body.zpp_pool==null){
                                x=new ZPP_Set_ZPP_Body();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_Body.POOL_TOT++;
                                ZPP_Set_ZPP_Body.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_Body.zpp_pool;
                                ZPP_Set_ZPP_Body.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_Body.POOL_CNT--;
                                ZPP_Set_ZPP_Body.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
                else break;
            }
        }
        if(x==null)return cur;
        else{
            if(x.parent==null)x.colour=1;
            else{
                x.colour=0;
                if(x.parent.colour==0)__fix_dbl_red(x);
            }
            return x;
        }
    }
    public function insert(obj:ZPP_Body){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !has(obj);
            };
            if(!res)throw "assert("+"!has(obj)"+") :: "+("object already in set");
            #end
        };
        var x;
        {
            if(ZPP_Set_ZPP_Body.zpp_pool==null){
                x=new ZPP_Set_ZPP_Body();
                #if NAPE_POOL_STATS ZPP_Set_ZPP_Body.POOL_TOT++;
                ZPP_Set_ZPP_Body.POOL_ADDNEW++;
                #end
            }
            else{
                x=ZPP_Set_ZPP_Body.zpp_pool;
                ZPP_Set_ZPP_Body.zpp_pool=x.next;
                x.next=null;
                #if NAPE_POOL_STATS ZPP_Set_ZPP_Body.POOL_CNT--;
                ZPP_Set_ZPP_Body.POOL_ADD++;
                #end
            }
            x.alloc();
        };
        x.data=obj;
        if(parent==null)parent=x;
        else{
            var cur=parent;
            while(true){
                if(lt(x.data,cur.data)){
                    if(cur.prev==null){
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else{
                    if(cur.next==null){
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
            }
        }
        if(x.parent==null)x.colour=1;
        else{
            x.colour=0;
            if(x.parent.colour==0)__fix_dbl_red(x);
        }
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x.data==obj;
            };
            if(!res)throw "assert("+"x.data==obj"+") :: "+("...wtf?");
            #end
        };
        return x;
    }
}
#if nape_swc@:keep #end
class ZPP_Set_ZPP_CbSetPair{
    static public var zpp_pool:ZPP_Set_ZPP_CbSetPair=null;
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
    function free(){
        data=null;
        lt=null;
        swapped=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    public var lt:ZPP_CbSetPair->ZPP_CbSetPair->Bool=null;
    public var swapped:ZPP_CbSetPair->ZPP_CbSetPair->Void=null;
    public var data:ZPP_CbSetPair=null;
    public var prev:ZPP_Set_ZPP_CbSetPair=null;
    public var next:ZPP_Set_ZPP_CbSetPair=null;
    public var parent:ZPP_Set_ZPP_CbSetPair=null;
    public var colour:Int=0;
    public function new(){}
    public function verify(){
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    this!=null;
                };
                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                #end
            };
            if(!this.empty()){
                var set_ite=this.parent;
                while(set_ite.prev!=null)set_ite=set_ite.prev;
                while(set_ite!=null){
                    var i=set_ite.data;
                    {
                        var prei=true;
                        {
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    this!=null;
                                };
                                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                                #end
                            };
                            if(!this.empty()){
                                var set_ite=this.parent;
                                while(set_ite.prev!=null)set_ite=set_ite.prev;
                                while(set_ite!=null){
                                    var j=set_ite.data;
                                    {
                                        if(!prei){
                                            if(!lt(i,j)&&lt(j,i))return false;
                                        }
                                        else if(i==j)prei=false;
                                        else{
                                            if(!lt(j,i)&&lt(i,j))return false;
                                        }
                                    };
                                    if(set_ite.next!=null){
                                        set_ite=set_ite.next;
                                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                                    }
                                    else{
                                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                                        set_ite=set_ite.parent;
                                    }
                                }
                            }
                        };
                    };
                    if(set_ite.next!=null){
                        set_ite=set_ite.next;
                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                    }
                    else{
                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                        set_ite=set_ite.parent;
                    }
                }
            }
        };
        return true;
    }
    public function empty(){
        return parent==null;
    }
    public function singular(){
        return parent!=null&&parent.prev==null&&parent.next==null;
    }
    public function size(){
        var ret=0;
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    this!=null;
                };
                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                #end
            };
            if(!this.empty()){
                var set_ite=this.parent;
                while(set_ite.prev!=null)set_ite=set_ite.prev;
                while(set_ite!=null){
                    var i=set_ite.data;
                    ret++;
                    if(set_ite.next!=null){
                        set_ite=set_ite.next;
                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                    }
                    else{
                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                        set_ite=set_ite.parent;
                    }
                }
            }
        };
        return ret;
    }
    public function has(obj:ZPP_CbSetPair){
        return find(obj)!=null;
    }
    public function find(obj:ZPP_CbSetPair){
        var cur=parent;
        while(cur!=null&&cur.data!=obj){
            if(lt(obj,cur.data))cur=cur.prev;
            else cur=cur.next;
        }
        return cur;
    }
    public function has_weak(obj:ZPP_CbSetPair){
        return find_weak(obj)!=null;
    }
    public function find_weak(obj:ZPP_CbSetPair){
        var cur=parent;
        while(cur!=null){
            if(lt(obj,cur.data))cur=cur.prev;
            else if(lt(cur.data,obj))cur=cur.next;
            else break;
        }
        return cur;
    }
    public function lower_bound(obj:ZPP_CbSetPair){
        return{
            var ret=null;
            {
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        this!=null;
                    };
                    if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                    #end
                };
                if(!this.empty()){
                    var set_ite=this.parent;
                    while(set_ite.prev!=null)set_ite=set_ite.prev;
                    while(set_ite!=null){
                        var elt=set_ite.data;
                        {
                            if(!lt(elt,obj)){
                                ret=elt;
                                break;
                            }
                        };
                        if(set_ite.next!=null){
                            set_ite=set_ite.next;
                            while(set_ite.prev!=null)set_ite=set_ite.prev;
                        }
                        else{
                            while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                            set_ite=set_ite.parent;
                        }
                    }
                }
            };
            ret;
        };
    }
    public function first(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("first in empty");
            #end
        };
        var cur=parent;
        while(cur.prev!=null)cur=cur.prev;
        return cur.data;
    }
    public function pop_front(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("pop_front in empty");
            #end
        };
        var cur=parent;
        while(cur.prev!=null)cur=cur.prev;
        var ret=cur.data;
        remove_node(cur);
        return ret;
    }
    public function remove(obj:ZPP_CbSetPair){
        var node=find(obj);
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                node!=null;
            };
            if(!res)throw "assert("+"node!=null"+") :: "+("object not in tree");
            #end
        };
        remove_node(node);
    }
    public function successor_node(cur:ZPP_Set_ZPP_CbSetPair){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.next!=null){
            cur=cur.next;
            while(cur.prev!=null)cur=cur.prev;
        }
        else{
            var pre=cur;
            cur=cur.parent;
            while(cur!=null&&cur.prev!=pre){
                pre=cur;
                cur=cur.parent;
            }
        }
        return cur;
    }
    public function predecessor_node(cur:ZPP_Set_ZPP_CbSetPair){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.prev!=null){
            cur=cur.prev;
            while(cur.next!=null)cur=cur.next;
        }
        else{
            var pre=cur;
            cur=cur.parent;
            while(cur!=null&&cur.next!=pre){
                pre=cur;
                cur=cur.parent;
            }
        }
        return cur;
    }
    public function successor(obj:ZPP_CbSetPair){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("not in tree!");
            #end
        };
        var node=successor_node(find(obj));
        return node==null?null:node.data;
    }
    public function predecessor(obj:ZPP_CbSetPair){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("not in tree!");
            #end
        };
        var node=predecessor_node(find(obj));
        return node==null?null:node.data;
    }
    public function remove_node(cur:ZPP_Set_ZPP_CbSetPair){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.next!=null&&cur.prev!=null){
            var sm=cur.next;
            while(sm.prev!=null)sm=sm.prev;
            {
                var t=cur.data;
                cur.data=sm.data;
                sm.data=t;
            };
            if(swapped!=null)swapped(cur.data,sm.data);
            cur=sm;
        }
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur.next==null||cur.prev==null;
            };
            if(!res)throw "assert("+"cur.next==null||cur.prev==null"+") :: "+("node still has two children??");
            #end
        };
        var child=if(cur.prev==null)cur.next else cur.prev;
        if(cur.colour==1){
            if(cur.prev!=null||cur.next!=null)child.colour=1;
            else if(cur.parent!=null){
                var parent=cur.parent;
                while(true){
                    parent.colour++;
                    parent.prev.colour--;
                    parent.next.colour--;
                    {
                        var child=parent.prev;
                        if(child.colour==(-1)){
                            __fix_neg_red(child);
                            break;
                        }
                        else if(child.colour==0){
                            {
                                if(child.prev!=null&&child.prev.colour==0){
                                    __fix_dbl_red(child.prev);
                                    break;
                                }
                            }
                            {
                                if(child.next!=null&&child.next.colour==0){
                                    __fix_dbl_red(child.next);
                                    break;
                                }
                            }
                        }
                    }
                    {
                        var child=parent.next;
                        if(child.colour==(-1)){
                            __fix_neg_red(child);
                            break;
                        }
                        else if(child.colour==0){
                            {
                                if(child.prev!=null&&child.prev.colour==0){
                                    __fix_dbl_red(child.prev);
                                    break;
                                }
                            }
                            {
                                if(child.next!=null&&child.next.colour==0){
                                    __fix_dbl_red(child.next);
                                    break;
                                }
                            }
                        }
                    }
                    if(parent.colour==2){
                        if(parent.parent==null){
                            parent.colour=1;
                        }
                        else{
                            parent=parent.parent;
                            continue;
                        }
                    }
                    break;
                }
            }
        }
        {
            var par=cur.parent;
            if(par==null){
                parent=child;
            }
            else if(par.prev==cur)par.prev=child;
            else par.next=child;
            if(child!=null)child.parent=par;
        };
        cur.parent=cur.prev=cur.next=null;
        {
            var o=cur;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_CbSetPair"+", in obj: "+"cur"+")");
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
    public function clear(){
        clear_with(function(_){});
    }
    public#if NAPE_NO_INLINE#else inline #end
    function clear_with(lambda:ZPP_CbSetPair->Void){
        if(parent==null)return;
        else{
            var cur=parent;
            while(cur!=null)cur=if(cur.prev!=null)cur.prev else if(cur.next!=null)cur.next else clear_node(cur,lambda);
            parent=null;
        }
    }
    #if NAPE_NO_INLINE#else inline #end
    function clear_node(node:ZPP_Set_ZPP_CbSetPair,lambda:ZPP_CbSetPair->Void){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                node.next==null&&node.prev==null;
            };
            if(!res)throw "assert("+"node.next==null&&node.prev==null"+") :: "+("clear_node :: node not a leaf");
            #end
        };
        lambda(node.data);
        var ret=node.parent;
        if(ret!=null){
            if(node==ret.prev)ret.prev=null;
            else ret.next=null;
            node.parent=null;
        }
        {
            var o=node;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_CbSetPair"+", in obj: "+"node"+")");
                #end
            };
            o.free();
            o.next=ZPP_Set_ZPP_CbSetPair.zpp_pool;
            ZPP_Set_ZPP_CbSetPair.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_CNT++;
            ZPP_Set_ZPP_CbSetPair.POOL_SUB++;
            #end
        };
        return ret;
    }
    public function __fix_neg_red(negred:ZPP_Set_ZPP_CbSetPair){
        var parent=negred.parent;
        var child=if(parent.prev==negred){
            var nl=negred.prev;
            var nr=negred.next;
            var trl=nr.prev;
            var trr=nr.next;
            nl.colour=0;
            negred.colour=parent.colour=1;
            {
                negred.next=trl;
                if(trl!=null)trl.parent=negred;
            };
            {
                var t=parent.data;
                parent.data=nr.data;
                nr.data=t;
            };
            if(swapped!=null)swapped(parent.data,nr.data);
            {
                nr.prev=trr;
                if(trr!=null)trr.parent=nr;
            };
            {
                nr.next=parent.next;
                if(parent.next!=null)parent.next.parent=nr;
            };
            {
                parent.next=nr;
                if(nr!=null)nr.parent=parent;
            };
            nl;
        };
        else{
            var nl=negred.next;
            var nr=negred.prev;
            var trl=nr.next;
            var trr=nr.prev;
            nl.colour=0;
            negred.colour=parent.colour=1;
            {
                negred.prev=trl;
                if(trl!=null)trl.parent=negred;
            };
            {
                var t=parent.data;
                parent.data=nr.data;
                nr.data=t;
            };
            if(swapped!=null)swapped(parent.data,nr.data);
            {
                nr.next=trr;
                if(trr!=null)trr.parent=nr;
            };
            {
                nr.prev=parent.prev;
                if(parent.prev!=null)parent.prev.parent=nr;
            };
            {
                parent.prev=nr;
                if(nr!=null)nr.parent=parent;
            };
            nl;
        };
        if(child.prev!=null&&child.prev.colour==0)__fix_dbl_red(child.prev);
        else if(child.next!=null&&child.next.colour==0)__fix_dbl_red(child.next);
    }
    public function __fix_dbl_red(x:ZPP_Set_ZPP_CbSetPair){
        while(true){
            var par=x.parent;
            var g=par.parent;
            if(g==null){
                par.colour=1;
                break;
            }
            var n1:ZPP_Set_ZPP_CbSetPair,n2:ZPP_Set_ZPP_CbSetPair,n3:ZPP_Set_ZPP_CbSetPair,t1:ZPP_Set_ZPP_CbSetPair,t2:ZPP_Set_ZPP_CbSetPair,t3:ZPP_Set_ZPP_CbSetPair,t4:ZPP_Set_ZPP_CbSetPair;
            if(par==g.prev){
                n3=g;
                t4=g.next;
                if(x==par.prev){
                    n1=x;
                    n2=par;
                    t1=x.prev;
                    t2=x.next;
                    t3=par.next;
                }
                else{
                    n1=par;
                    n2=x;
                    t1=par.prev;
                    t2=x.prev;
                    t3=x.next;
                }
            }
            else{
                n1=g;
                t1=g.prev;
                if(x==par.prev){
                    n2=x;
                    n3=par;
                    t2=x.prev;
                    t3=x.next;
                    t4=par.next;
                }
                else{
                    n2=par;
                    n3=x;
                    t2=par.prev;
                    t3=x.prev;
                    t4=x.next;
                }
            }
            {
                var par=g.parent;
                if(par==null){
                    parent=n2;
                }
                else if(par.prev==g)par.prev=n2;
                else par.next=n2;
                if(n2!=null)n2.parent=par;
            };
            {
                n1.prev=t1;
                if(t1!=null)t1.parent=n1;
            };
            {
                n1.next=t2;
                if(t2!=null)t2.parent=n1;
            };
            {
                n2.prev=n1;
                if(n1!=null)n1.parent=n2;
            };
            {
                n2.next=n3;
                if(n3!=null)n3.parent=n2;
            };
            {
                n3.prev=t3;
                if(t3!=null)t3.parent=n3;
            };
            {
                n3.next=t4;
                if(t4!=null)t4.parent=n3;
            };
            n2.colour=g.colour-1;
            n1.colour=1;
            n3.colour=1;
            if(n2==parent)parent.colour=1;
            else if(n2.colour==0&&n2.parent.colour==0){
                x=n2;
                continue;
            }
            break;
        }
    }
    public function try_insert_bool(obj:ZPP_CbSetPair){
        var x:ZPP_Set_ZPP_CbSetPair=null;
        var cur:ZPP_Set_ZPP_CbSetPair=null;
        if(parent==null){
            {
                if(ZPP_Set_ZPP_CbSetPair.zpp_pool==null){
                    x=new ZPP_Set_ZPP_CbSetPair();
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_TOT++;
                    ZPP_Set_ZPP_CbSetPair.POOL_ADDNEW++;
                    #end
                }
                else{
                    x=ZPP_Set_ZPP_CbSetPair.zpp_pool;
                    ZPP_Set_ZPP_CbSetPair.zpp_pool=x.next;
                    x.next=null;
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_CNT--;
                    ZPP_Set_ZPP_CbSetPair.POOL_ADD++;
                    #end
                }
                x.alloc();
            };
            x.data=obj;
            parent=x;
        }
        else{
            cur=parent;
            while(true){
                if(lt(obj,cur.data)){
                    if(cur.prev==null){
                        {
                            if(ZPP_Set_ZPP_CbSetPair.zpp_pool==null){
                                x=new ZPP_Set_ZPP_CbSetPair();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_TOT++;
                                ZPP_Set_ZPP_CbSetPair.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_CbSetPair.zpp_pool;
                                ZPP_Set_ZPP_CbSetPair.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_CNT--;
                                ZPP_Set_ZPP_CbSetPair.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else if(lt(cur.data,obj)){
                    if(cur.next==null){
                        {
                            if(ZPP_Set_ZPP_CbSetPair.zpp_pool==null){
                                x=new ZPP_Set_ZPP_CbSetPair();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_TOT++;
                                ZPP_Set_ZPP_CbSetPair.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_CbSetPair.zpp_pool;
                                ZPP_Set_ZPP_CbSetPair.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_CNT--;
                                ZPP_Set_ZPP_CbSetPair.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
                else break;
            }
        }
        if(x==null)return false;
        else{
            if(x.parent==null)x.colour=1;
            else{
                x.colour=0;
                if(x.parent.colour==0)__fix_dbl_red(x);
            }
            return true;
        }
    }
    public function try_insert(obj:ZPP_CbSetPair){
        var x:ZPP_Set_ZPP_CbSetPair=null;
        var cur:ZPP_Set_ZPP_CbSetPair=null;
        if(parent==null){
            {
                if(ZPP_Set_ZPP_CbSetPair.zpp_pool==null){
                    x=new ZPP_Set_ZPP_CbSetPair();
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_TOT++;
                    ZPP_Set_ZPP_CbSetPair.POOL_ADDNEW++;
                    #end
                }
                else{
                    x=ZPP_Set_ZPP_CbSetPair.zpp_pool;
                    ZPP_Set_ZPP_CbSetPair.zpp_pool=x.next;
                    x.next=null;
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_CNT--;
                    ZPP_Set_ZPP_CbSetPair.POOL_ADD++;
                    #end
                }
                x.alloc();
            };
            x.data=obj;
            parent=x;
        }
        else{
            cur=parent;
            while(true){
                if(lt(obj,cur.data)){
                    if(cur.prev==null){
                        {
                            if(ZPP_Set_ZPP_CbSetPair.zpp_pool==null){
                                x=new ZPP_Set_ZPP_CbSetPair();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_TOT++;
                                ZPP_Set_ZPP_CbSetPair.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_CbSetPair.zpp_pool;
                                ZPP_Set_ZPP_CbSetPair.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_CNT--;
                                ZPP_Set_ZPP_CbSetPair.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else if(lt(cur.data,obj)){
                    if(cur.next==null){
                        {
                            if(ZPP_Set_ZPP_CbSetPair.zpp_pool==null){
                                x=new ZPP_Set_ZPP_CbSetPair();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_TOT++;
                                ZPP_Set_ZPP_CbSetPair.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_CbSetPair.zpp_pool;
                                ZPP_Set_ZPP_CbSetPair.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_CNT--;
                                ZPP_Set_ZPP_CbSetPair.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
                else break;
            }
        }
        if(x==null)return cur;
        else{
            if(x.parent==null)x.colour=1;
            else{
                x.colour=0;
                if(x.parent.colour==0)__fix_dbl_red(x);
            }
            return x;
        }
    }
    public function insert(obj:ZPP_CbSetPair){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !has(obj);
            };
            if(!res)throw "assert("+"!has(obj)"+") :: "+("object already in set");
            #end
        };
        var x;
        {
            if(ZPP_Set_ZPP_CbSetPair.zpp_pool==null){
                x=new ZPP_Set_ZPP_CbSetPair();
                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_TOT++;
                ZPP_Set_ZPP_CbSetPair.POOL_ADDNEW++;
                #end
            }
            else{
                x=ZPP_Set_ZPP_CbSetPair.zpp_pool;
                ZPP_Set_ZPP_CbSetPair.zpp_pool=x.next;
                x.next=null;
                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSetPair.POOL_CNT--;
                ZPP_Set_ZPP_CbSetPair.POOL_ADD++;
                #end
            }
            x.alloc();
        };
        x.data=obj;
        if(parent==null)parent=x;
        else{
            var cur=parent;
            while(true){
                if(lt(x.data,cur.data)){
                    if(cur.prev==null){
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else{
                    if(cur.next==null){
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
            }
        }
        if(x.parent==null)x.colour=1;
        else{
            x.colour=0;
            if(x.parent.colour==0)__fix_dbl_red(x);
        }
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x.data==obj;
            };
            if(!res)throw "assert("+"x.data==obj"+") :: "+("...wtf?");
            #end
        };
        return x;
    }
}
#if nape_swc@:keep #end
class ZPP_Set_ZPP_PartitionVertex{
    static public var zpp_pool:ZPP_Set_ZPP_PartitionVertex=null;
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
    function free(){
        data=null;
        lt=null;
        swapped=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    public var lt:ZPP_PartitionVertex->ZPP_PartitionVertex->Bool=null;
    public var swapped:ZPP_PartitionVertex->ZPP_PartitionVertex->Void=null;
    public var data:ZPP_PartitionVertex=null;
    public var prev:ZPP_Set_ZPP_PartitionVertex=null;
    public var next:ZPP_Set_ZPP_PartitionVertex=null;
    public var parent:ZPP_Set_ZPP_PartitionVertex=null;
    public var colour:Int=0;
    public function new(){}
    public function verify(){
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    this!=null;
                };
                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                #end
            };
            if(!this.empty()){
                var set_ite=this.parent;
                while(set_ite.prev!=null)set_ite=set_ite.prev;
                while(set_ite!=null){
                    var i=set_ite.data;
                    {
                        var prei=true;
                        {
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    this!=null;
                                };
                                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                                #end
                            };
                            if(!this.empty()){
                                var set_ite=this.parent;
                                while(set_ite.prev!=null)set_ite=set_ite.prev;
                                while(set_ite!=null){
                                    var j=set_ite.data;
                                    {
                                        if(!prei){
                                            if(!lt(i,j)&&lt(j,i))return false;
                                        }
                                        else if(i==j)prei=false;
                                        else{
                                            if(!lt(j,i)&&lt(i,j))return false;
                                        }
                                    };
                                    if(set_ite.next!=null){
                                        set_ite=set_ite.next;
                                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                                    }
                                    else{
                                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                                        set_ite=set_ite.parent;
                                    }
                                }
                            }
                        };
                    };
                    if(set_ite.next!=null){
                        set_ite=set_ite.next;
                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                    }
                    else{
                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                        set_ite=set_ite.parent;
                    }
                }
            }
        };
        return true;
    }
    public function empty(){
        return parent==null;
    }
    public function singular(){
        return parent!=null&&parent.prev==null&&parent.next==null;
    }
    public function size(){
        var ret=0;
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    this!=null;
                };
                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                #end
            };
            if(!this.empty()){
                var set_ite=this.parent;
                while(set_ite.prev!=null)set_ite=set_ite.prev;
                while(set_ite!=null){
                    var i=set_ite.data;
                    ret++;
                    if(set_ite.next!=null){
                        set_ite=set_ite.next;
                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                    }
                    else{
                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                        set_ite=set_ite.parent;
                    }
                }
            }
        };
        return ret;
    }
    public function has(obj:ZPP_PartitionVertex){
        return find(obj)!=null;
    }
    public function find(obj:ZPP_PartitionVertex){
        var cur=parent;
        while(cur!=null&&cur.data!=obj){
            if(lt(obj,cur.data))cur=cur.prev;
            else cur=cur.next;
        }
        return cur;
    }
    public function has_weak(obj:ZPP_PartitionVertex){
        return find_weak(obj)!=null;
    }
    public function find_weak(obj:ZPP_PartitionVertex){
        var cur=parent;
        while(cur!=null){
            if(lt(obj,cur.data))cur=cur.prev;
            else if(lt(cur.data,obj))cur=cur.next;
            else break;
        }
        return cur;
    }
    public function lower_bound(obj:ZPP_PartitionVertex){
        return{
            var ret=null;
            {
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        this!=null;
                    };
                    if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                    #end
                };
                if(!this.empty()){
                    var set_ite=this.parent;
                    while(set_ite.prev!=null)set_ite=set_ite.prev;
                    while(set_ite!=null){
                        var elt=set_ite.data;
                        {
                            if(!lt(elt,obj)){
                                ret=elt;
                                break;
                            }
                        };
                        if(set_ite.next!=null){
                            set_ite=set_ite.next;
                            while(set_ite.prev!=null)set_ite=set_ite.prev;
                        }
                        else{
                            while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                            set_ite=set_ite.parent;
                        }
                    }
                }
            };
            ret;
        };
    }
    public function first(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("first in empty");
            #end
        };
        var cur=parent;
        while(cur.prev!=null)cur=cur.prev;
        return cur.data;
    }
    public function pop_front(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("pop_front in empty");
            #end
        };
        var cur=parent;
        while(cur.prev!=null)cur=cur.prev;
        var ret=cur.data;
        remove_node(cur);
        return ret;
    }
    public function remove(obj:ZPP_PartitionVertex){
        var node=find(obj);
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                node!=null;
            };
            if(!res)throw "assert("+"node!=null"+") :: "+("object not in tree");
            #end
        };
        remove_node(node);
    }
    public function successor_node(cur:ZPP_Set_ZPP_PartitionVertex){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.next!=null){
            cur=cur.next;
            while(cur.prev!=null)cur=cur.prev;
        }
        else{
            var pre=cur;
            cur=cur.parent;
            while(cur!=null&&cur.prev!=pre){
                pre=cur;
                cur=cur.parent;
            }
        }
        return cur;
    }
    public function predecessor_node(cur:ZPP_Set_ZPP_PartitionVertex){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.prev!=null){
            cur=cur.prev;
            while(cur.next!=null)cur=cur.next;
        }
        else{
            var pre=cur;
            cur=cur.parent;
            while(cur!=null&&cur.next!=pre){
                pre=cur;
                cur=cur.parent;
            }
        }
        return cur;
    }
    public function successor(obj:ZPP_PartitionVertex){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("not in tree!");
            #end
        };
        var node=successor_node(find(obj));
        return node==null?null:node.data;
    }
    public function predecessor(obj:ZPP_PartitionVertex){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("not in tree!");
            #end
        };
        var node=predecessor_node(find(obj));
        return node==null?null:node.data;
    }
    public function remove_node(cur:ZPP_Set_ZPP_PartitionVertex){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.next!=null&&cur.prev!=null){
            var sm=cur.next;
            while(sm.prev!=null)sm=sm.prev;
            {
                var t=cur.data;
                cur.data=sm.data;
                sm.data=t;
            };
            if(swapped!=null)swapped(cur.data,sm.data);
            cur=sm;
        }
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur.next==null||cur.prev==null;
            };
            if(!res)throw "assert("+"cur.next==null||cur.prev==null"+") :: "+("node still has two children??");
            #end
        };
        var child=if(cur.prev==null)cur.next else cur.prev;
        if(cur.colour==1){
            if(cur.prev!=null||cur.next!=null)child.colour=1;
            else if(cur.parent!=null){
                var parent=cur.parent;
                while(true){
                    parent.colour++;
                    parent.prev.colour--;
                    parent.next.colour--;
                    {
                        var child=parent.prev;
                        if(child.colour==(-1)){
                            __fix_neg_red(child);
                            break;
                        }
                        else if(child.colour==0){
                            {
                                if(child.prev!=null&&child.prev.colour==0){
                                    __fix_dbl_red(child.prev);
                                    break;
                                }
                            }
                            {
                                if(child.next!=null&&child.next.colour==0){
                                    __fix_dbl_red(child.next);
                                    break;
                                }
                            }
                        }
                    }
                    {
                        var child=parent.next;
                        if(child.colour==(-1)){
                            __fix_neg_red(child);
                            break;
                        }
                        else if(child.colour==0){
                            {
                                if(child.prev!=null&&child.prev.colour==0){
                                    __fix_dbl_red(child.prev);
                                    break;
                                }
                            }
                            {
                                if(child.next!=null&&child.next.colour==0){
                                    __fix_dbl_red(child.next);
                                    break;
                                }
                            }
                        }
                    }
                    if(parent.colour==2){
                        if(parent.parent==null){
                            parent.colour=1;
                        }
                        else{
                            parent=parent.parent;
                            continue;
                        }
                    }
                    break;
                }
            }
        }
        {
            var par=cur.parent;
            if(par==null){
                parent=child;
            }
            else if(par.prev==cur)par.prev=child;
            else par.next=child;
            if(child!=null)child.parent=par;
        };
        cur.parent=cur.prev=cur.next=null;
        {
            var o=cur;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_PartitionVertex"+", in obj: "+"cur"+")");
                #end
            };
            o.free();
            o.next=ZPP_Set_ZPP_PartitionVertex.zpp_pool;
            ZPP_Set_ZPP_PartitionVertex.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionVertex.POOL_CNT++;
            ZPP_Set_ZPP_PartitionVertex.POOL_SUB++;
            #end
        };
    }
    public function clear(){
        clear_with(function(_){});
    }
    public#if NAPE_NO_INLINE#else inline #end
    function clear_with(lambda:ZPP_PartitionVertex->Void){
        if(parent==null)return;
        else{
            var cur=parent;
            while(cur!=null)cur=if(cur.prev!=null)cur.prev else if(cur.next!=null)cur.next else clear_node(cur,lambda);
            parent=null;
        }
    }
    #if NAPE_NO_INLINE#else inline #end
    function clear_node(node:ZPP_Set_ZPP_PartitionVertex,lambda:ZPP_PartitionVertex->Void){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                node.next==null&&node.prev==null;
            };
            if(!res)throw "assert("+"node.next==null&&node.prev==null"+") :: "+("clear_node :: node not a leaf");
            #end
        };
        lambda(node.data);
        var ret=node.parent;
        if(ret!=null){
            if(node==ret.prev)ret.prev=null;
            else ret.next=null;
            node.parent=null;
        }
        {
            var o=node;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_PartitionVertex"+", in obj: "+"node"+")");
                #end
            };
            o.free();
            o.next=ZPP_Set_ZPP_PartitionVertex.zpp_pool;
            ZPP_Set_ZPP_PartitionVertex.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionVertex.POOL_CNT++;
            ZPP_Set_ZPP_PartitionVertex.POOL_SUB++;
            #end
        };
        return ret;
    }
    public function __fix_neg_red(negred:ZPP_Set_ZPP_PartitionVertex){
        var parent=negred.parent;
        var child=if(parent.prev==negred){
            var nl=negred.prev;
            var nr=negred.next;
            var trl=nr.prev;
            var trr=nr.next;
            nl.colour=0;
            negred.colour=parent.colour=1;
            {
                negred.next=trl;
                if(trl!=null)trl.parent=negred;
            };
            {
                var t=parent.data;
                parent.data=nr.data;
                nr.data=t;
            };
            if(swapped!=null)swapped(parent.data,nr.data);
            {
                nr.prev=trr;
                if(trr!=null)trr.parent=nr;
            };
            {
                nr.next=parent.next;
                if(parent.next!=null)parent.next.parent=nr;
            };
            {
                parent.next=nr;
                if(nr!=null)nr.parent=parent;
            };
            nl;
        };
        else{
            var nl=negred.next;
            var nr=negred.prev;
            var trl=nr.next;
            var trr=nr.prev;
            nl.colour=0;
            negred.colour=parent.colour=1;
            {
                negred.prev=trl;
                if(trl!=null)trl.parent=negred;
            };
            {
                var t=parent.data;
                parent.data=nr.data;
                nr.data=t;
            };
            if(swapped!=null)swapped(parent.data,nr.data);
            {
                nr.next=trr;
                if(trr!=null)trr.parent=nr;
            };
            {
                nr.prev=parent.prev;
                if(parent.prev!=null)parent.prev.parent=nr;
            };
            {
                parent.prev=nr;
                if(nr!=null)nr.parent=parent;
            };
            nl;
        };
        if(child.prev!=null&&child.prev.colour==0)__fix_dbl_red(child.prev);
        else if(child.next!=null&&child.next.colour==0)__fix_dbl_red(child.next);
    }
    public function __fix_dbl_red(x:ZPP_Set_ZPP_PartitionVertex){
        while(true){
            var par=x.parent;
            var g=par.parent;
            if(g==null){
                par.colour=1;
                break;
            }
            var n1:ZPP_Set_ZPP_PartitionVertex,n2:ZPP_Set_ZPP_PartitionVertex,n3:ZPP_Set_ZPP_PartitionVertex,t1:ZPP_Set_ZPP_PartitionVertex,t2:ZPP_Set_ZPP_PartitionVertex,t3:ZPP_Set_ZPP_PartitionVertex,t4:ZPP_Set_ZPP_PartitionVertex;
            if(par==g.prev){
                n3=g;
                t4=g.next;
                if(x==par.prev){
                    n1=x;
                    n2=par;
                    t1=x.prev;
                    t2=x.next;
                    t3=par.next;
                }
                else{
                    n1=par;
                    n2=x;
                    t1=par.prev;
                    t2=x.prev;
                    t3=x.next;
                }
            }
            else{
                n1=g;
                t1=g.prev;
                if(x==par.prev){
                    n2=x;
                    n3=par;
                    t2=x.prev;
                    t3=x.next;
                    t4=par.next;
                }
                else{
                    n2=par;
                    n3=x;
                    t2=par.prev;
                    t3=x.prev;
                    t4=x.next;
                }
            }
            {
                var par=g.parent;
                if(par==null){
                    parent=n2;
                }
                else if(par.prev==g)par.prev=n2;
                else par.next=n2;
                if(n2!=null)n2.parent=par;
            };
            {
                n1.prev=t1;
                if(t1!=null)t1.parent=n1;
            };
            {
                n1.next=t2;
                if(t2!=null)t2.parent=n1;
            };
            {
                n2.prev=n1;
                if(n1!=null)n1.parent=n2;
            };
            {
                n2.next=n3;
                if(n3!=null)n3.parent=n2;
            };
            {
                n3.prev=t3;
                if(t3!=null)t3.parent=n3;
            };
            {
                n3.next=t4;
                if(t4!=null)t4.parent=n3;
            };
            n2.colour=g.colour-1;
            n1.colour=1;
            n3.colour=1;
            if(n2==parent)parent.colour=1;
            else if(n2.colour==0&&n2.parent.colour==0){
                x=n2;
                continue;
            }
            break;
        }
    }
    public function try_insert_bool(obj:ZPP_PartitionVertex){
        var x:ZPP_Set_ZPP_PartitionVertex=null;
        var cur:ZPP_Set_ZPP_PartitionVertex=null;
        if(parent==null){
            {
                if(ZPP_Set_ZPP_PartitionVertex.zpp_pool==null){
                    x=new ZPP_Set_ZPP_PartitionVertex();
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionVertex.POOL_TOT++;
                    ZPP_Set_ZPP_PartitionVertex.POOL_ADDNEW++;
                    #end
                }
                else{
                    x=ZPP_Set_ZPP_PartitionVertex.zpp_pool;
                    ZPP_Set_ZPP_PartitionVertex.zpp_pool=x.next;
                    x.next=null;
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionVertex.POOL_CNT--;
                    ZPP_Set_ZPP_PartitionVertex.POOL_ADD++;
                    #end
                }
                x.alloc();
            };
            x.data=obj;
            parent=x;
        }
        else{
            cur=parent;
            while(true){
                if(lt(obj,cur.data)){
                    if(cur.prev==null){
                        {
                            if(ZPP_Set_ZPP_PartitionVertex.zpp_pool==null){
                                x=new ZPP_Set_ZPP_PartitionVertex();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionVertex.POOL_TOT++;
                                ZPP_Set_ZPP_PartitionVertex.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_PartitionVertex.zpp_pool;
                                ZPP_Set_ZPP_PartitionVertex.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionVertex.POOL_CNT--;
                                ZPP_Set_ZPP_PartitionVertex.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else if(lt(cur.data,obj)){
                    if(cur.next==null){
                        {
                            if(ZPP_Set_ZPP_PartitionVertex.zpp_pool==null){
                                x=new ZPP_Set_ZPP_PartitionVertex();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionVertex.POOL_TOT++;
                                ZPP_Set_ZPP_PartitionVertex.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_PartitionVertex.zpp_pool;
                                ZPP_Set_ZPP_PartitionVertex.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionVertex.POOL_CNT--;
                                ZPP_Set_ZPP_PartitionVertex.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
                else break;
            }
        }
        if(x==null)return false;
        else{
            if(x.parent==null)x.colour=1;
            else{
                x.colour=0;
                if(x.parent.colour==0)__fix_dbl_red(x);
            }
            return true;
        }
    }
    public function try_insert(obj:ZPP_PartitionVertex){
        var x:ZPP_Set_ZPP_PartitionVertex=null;
        var cur:ZPP_Set_ZPP_PartitionVertex=null;
        if(parent==null){
            {
                if(ZPP_Set_ZPP_PartitionVertex.zpp_pool==null){
                    x=new ZPP_Set_ZPP_PartitionVertex();
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionVertex.POOL_TOT++;
                    ZPP_Set_ZPP_PartitionVertex.POOL_ADDNEW++;
                    #end
                }
                else{
                    x=ZPP_Set_ZPP_PartitionVertex.zpp_pool;
                    ZPP_Set_ZPP_PartitionVertex.zpp_pool=x.next;
                    x.next=null;
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionVertex.POOL_CNT--;
                    ZPP_Set_ZPP_PartitionVertex.POOL_ADD++;
                    #end
                }
                x.alloc();
            };
            x.data=obj;
            parent=x;
        }
        else{
            cur=parent;
            while(true){
                if(lt(obj,cur.data)){
                    if(cur.prev==null){
                        {
                            if(ZPP_Set_ZPP_PartitionVertex.zpp_pool==null){
                                x=new ZPP_Set_ZPP_PartitionVertex();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionVertex.POOL_TOT++;
                                ZPP_Set_ZPP_PartitionVertex.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_PartitionVertex.zpp_pool;
                                ZPP_Set_ZPP_PartitionVertex.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionVertex.POOL_CNT--;
                                ZPP_Set_ZPP_PartitionVertex.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else if(lt(cur.data,obj)){
                    if(cur.next==null){
                        {
                            if(ZPP_Set_ZPP_PartitionVertex.zpp_pool==null){
                                x=new ZPP_Set_ZPP_PartitionVertex();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionVertex.POOL_TOT++;
                                ZPP_Set_ZPP_PartitionVertex.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_PartitionVertex.zpp_pool;
                                ZPP_Set_ZPP_PartitionVertex.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionVertex.POOL_CNT--;
                                ZPP_Set_ZPP_PartitionVertex.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
                else break;
            }
        }
        if(x==null)return cur;
        else{
            if(x.parent==null)x.colour=1;
            else{
                x.colour=0;
                if(x.parent.colour==0)__fix_dbl_red(x);
            }
            return x;
        }
    }
    public function insert(obj:ZPP_PartitionVertex){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !has(obj);
            };
            if(!res)throw "assert("+"!has(obj)"+") :: "+("object already in set");
            #end
        };
        var x;
        {
            if(ZPP_Set_ZPP_PartitionVertex.zpp_pool==null){
                x=new ZPP_Set_ZPP_PartitionVertex();
                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionVertex.POOL_TOT++;
                ZPP_Set_ZPP_PartitionVertex.POOL_ADDNEW++;
                #end
            }
            else{
                x=ZPP_Set_ZPP_PartitionVertex.zpp_pool;
                ZPP_Set_ZPP_PartitionVertex.zpp_pool=x.next;
                x.next=null;
                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionVertex.POOL_CNT--;
                ZPP_Set_ZPP_PartitionVertex.POOL_ADD++;
                #end
            }
            x.alloc();
        };
        x.data=obj;
        if(parent==null)parent=x;
        else{
            var cur=parent;
            while(true){
                if(lt(x.data,cur.data)){
                    if(cur.prev==null){
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else{
                    if(cur.next==null){
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
            }
        }
        if(x.parent==null)x.colour=1;
        else{
            x.colour=0;
            if(x.parent.colour==0)__fix_dbl_red(x);
        }
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x.data==obj;
            };
            if(!res)throw "assert("+"x.data==obj"+") :: "+("...wtf?");
            #end
        };
        return x;
    }
}
#if nape_swc@:keep #end
class ZPP_Set_ZPP_PartitionPair{
    static public var zpp_pool:ZPP_Set_ZPP_PartitionPair=null;
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
    function free(){
        data=null;
        lt=null;
        swapped=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    public var lt:ZPP_PartitionPair->ZPP_PartitionPair->Bool=null;
    public var swapped:ZPP_PartitionPair->ZPP_PartitionPair->Void=null;
    public var data:ZPP_PartitionPair=null;
    public var prev:ZPP_Set_ZPP_PartitionPair=null;
    public var next:ZPP_Set_ZPP_PartitionPair=null;
    public var parent:ZPP_Set_ZPP_PartitionPair=null;
    public var colour:Int=0;
    public function new(){}
    public function verify(){
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    this!=null;
                };
                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                #end
            };
            if(!this.empty()){
                var set_ite=this.parent;
                while(set_ite.prev!=null)set_ite=set_ite.prev;
                while(set_ite!=null){
                    var i=set_ite.data;
                    {
                        var prei=true;
                        {
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    this!=null;
                                };
                                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                                #end
                            };
                            if(!this.empty()){
                                var set_ite=this.parent;
                                while(set_ite.prev!=null)set_ite=set_ite.prev;
                                while(set_ite!=null){
                                    var j=set_ite.data;
                                    {
                                        if(!prei){
                                            if(!lt(i,j)&&lt(j,i))return false;
                                        }
                                        else if(i==j)prei=false;
                                        else{
                                            if(!lt(j,i)&&lt(i,j))return false;
                                        }
                                    };
                                    if(set_ite.next!=null){
                                        set_ite=set_ite.next;
                                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                                    }
                                    else{
                                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                                        set_ite=set_ite.parent;
                                    }
                                }
                            }
                        };
                    };
                    if(set_ite.next!=null){
                        set_ite=set_ite.next;
                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                    }
                    else{
                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                        set_ite=set_ite.parent;
                    }
                }
            }
        };
        return true;
    }
    public function empty(){
        return parent==null;
    }
    public function singular(){
        return parent!=null&&parent.prev==null&&parent.next==null;
    }
    public function size(){
        var ret=0;
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    this!=null;
                };
                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                #end
            };
            if(!this.empty()){
                var set_ite=this.parent;
                while(set_ite.prev!=null)set_ite=set_ite.prev;
                while(set_ite!=null){
                    var i=set_ite.data;
                    ret++;
                    if(set_ite.next!=null){
                        set_ite=set_ite.next;
                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                    }
                    else{
                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                        set_ite=set_ite.parent;
                    }
                }
            }
        };
        return ret;
    }
    public function has(obj:ZPP_PartitionPair){
        return find(obj)!=null;
    }
    public function find(obj:ZPP_PartitionPair){
        var cur=parent;
        while(cur!=null&&cur.data!=obj){
            if(lt(obj,cur.data))cur=cur.prev;
            else cur=cur.next;
        }
        return cur;
    }
    public function has_weak(obj:ZPP_PartitionPair){
        return find_weak(obj)!=null;
    }
    public function find_weak(obj:ZPP_PartitionPair){
        var cur=parent;
        while(cur!=null){
            if(lt(obj,cur.data))cur=cur.prev;
            else if(lt(cur.data,obj))cur=cur.next;
            else break;
        }
        return cur;
    }
    public function lower_bound(obj:ZPP_PartitionPair){
        return{
            var ret=null;
            {
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        this!=null;
                    };
                    if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                    #end
                };
                if(!this.empty()){
                    var set_ite=this.parent;
                    while(set_ite.prev!=null)set_ite=set_ite.prev;
                    while(set_ite!=null){
                        var elt=set_ite.data;
                        {
                            if(!lt(elt,obj)){
                                ret=elt;
                                break;
                            }
                        };
                        if(set_ite.next!=null){
                            set_ite=set_ite.next;
                            while(set_ite.prev!=null)set_ite=set_ite.prev;
                        }
                        else{
                            while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                            set_ite=set_ite.parent;
                        }
                    }
                }
            };
            ret;
        };
    }
    public function first(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("first in empty");
            #end
        };
        var cur=parent;
        while(cur.prev!=null)cur=cur.prev;
        return cur.data;
    }
    public function pop_front(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("pop_front in empty");
            #end
        };
        var cur=parent;
        while(cur.prev!=null)cur=cur.prev;
        var ret=cur.data;
        remove_node(cur);
        return ret;
    }
    public function remove(obj:ZPP_PartitionPair){
        var node=find(obj);
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                node!=null;
            };
            if(!res)throw "assert("+"node!=null"+") :: "+("object not in tree");
            #end
        };
        remove_node(node);
    }
    public function successor_node(cur:ZPP_Set_ZPP_PartitionPair){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.next!=null){
            cur=cur.next;
            while(cur.prev!=null)cur=cur.prev;
        }
        else{
            var pre=cur;
            cur=cur.parent;
            while(cur!=null&&cur.prev!=pre){
                pre=cur;
                cur=cur.parent;
            }
        }
        return cur;
    }
    public function predecessor_node(cur:ZPP_Set_ZPP_PartitionPair){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.prev!=null){
            cur=cur.prev;
            while(cur.next!=null)cur=cur.next;
        }
        else{
            var pre=cur;
            cur=cur.parent;
            while(cur!=null&&cur.next!=pre){
                pre=cur;
                cur=cur.parent;
            }
        }
        return cur;
    }
    public function successor(obj:ZPP_PartitionPair){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("not in tree!");
            #end
        };
        var node=successor_node(find(obj));
        return node==null?null:node.data;
    }
    public function predecessor(obj:ZPP_PartitionPair){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("not in tree!");
            #end
        };
        var node=predecessor_node(find(obj));
        return node==null?null:node.data;
    }
    public function remove_node(cur:ZPP_Set_ZPP_PartitionPair){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.next!=null&&cur.prev!=null){
            var sm=cur.next;
            while(sm.prev!=null)sm=sm.prev;
            {
                var t=cur.data;
                cur.data=sm.data;
                sm.data=t;
            };
            if(swapped!=null)swapped(cur.data,sm.data);
            cur=sm;
        }
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur.next==null||cur.prev==null;
            };
            if(!res)throw "assert("+"cur.next==null||cur.prev==null"+") :: "+("node still has two children??");
            #end
        };
        var child=if(cur.prev==null)cur.next else cur.prev;
        if(cur.colour==1){
            if(cur.prev!=null||cur.next!=null)child.colour=1;
            else if(cur.parent!=null){
                var parent=cur.parent;
                while(true){
                    parent.colour++;
                    parent.prev.colour--;
                    parent.next.colour--;
                    {
                        var child=parent.prev;
                        if(child.colour==(-1)){
                            __fix_neg_red(child);
                            break;
                        }
                        else if(child.colour==0){
                            {
                                if(child.prev!=null&&child.prev.colour==0){
                                    __fix_dbl_red(child.prev);
                                    break;
                                }
                            }
                            {
                                if(child.next!=null&&child.next.colour==0){
                                    __fix_dbl_red(child.next);
                                    break;
                                }
                            }
                        }
                    }
                    {
                        var child=parent.next;
                        if(child.colour==(-1)){
                            __fix_neg_red(child);
                            break;
                        }
                        else if(child.colour==0){
                            {
                                if(child.prev!=null&&child.prev.colour==0){
                                    __fix_dbl_red(child.prev);
                                    break;
                                }
                            }
                            {
                                if(child.next!=null&&child.next.colour==0){
                                    __fix_dbl_red(child.next);
                                    break;
                                }
                            }
                        }
                    }
                    if(parent.colour==2){
                        if(parent.parent==null){
                            parent.colour=1;
                        }
                        else{
                            parent=parent.parent;
                            continue;
                        }
                    }
                    break;
                }
            }
        }
        {
            var par=cur.parent;
            if(par==null){
                parent=child;
            }
            else if(par.prev==cur)par.prev=child;
            else par.next=child;
            if(child!=null)child.parent=par;
        };
        cur.parent=cur.prev=cur.next=null;
        {
            var o=cur;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_PartitionPair"+", in obj: "+"cur"+")");
                #end
            };
            o.free();
            o.next=ZPP_Set_ZPP_PartitionPair.zpp_pool;
            ZPP_Set_ZPP_PartitionPair.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionPair.POOL_CNT++;
            ZPP_Set_ZPP_PartitionPair.POOL_SUB++;
            #end
        };
    }
    public function clear(){
        clear_with(function(_){});
    }
    public#if NAPE_NO_INLINE#else inline #end
    function clear_with(lambda:ZPP_PartitionPair->Void){
        if(parent==null)return;
        else{
            var cur=parent;
            while(cur!=null)cur=if(cur.prev!=null)cur.prev else if(cur.next!=null)cur.next else clear_node(cur,lambda);
            parent=null;
        }
    }
    #if NAPE_NO_INLINE#else inline #end
    function clear_node(node:ZPP_Set_ZPP_PartitionPair,lambda:ZPP_PartitionPair->Void){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                node.next==null&&node.prev==null;
            };
            if(!res)throw "assert("+"node.next==null&&node.prev==null"+") :: "+("clear_node :: node not a leaf");
            #end
        };
        lambda(node.data);
        var ret=node.parent;
        if(ret!=null){
            if(node==ret.prev)ret.prev=null;
            else ret.next=null;
            node.parent=null;
        }
        {
            var o=node;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_PartitionPair"+", in obj: "+"node"+")");
                #end
            };
            o.free();
            o.next=ZPP_Set_ZPP_PartitionPair.zpp_pool;
            ZPP_Set_ZPP_PartitionPair.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionPair.POOL_CNT++;
            ZPP_Set_ZPP_PartitionPair.POOL_SUB++;
            #end
        };
        return ret;
    }
    public function __fix_neg_red(negred:ZPP_Set_ZPP_PartitionPair){
        var parent=negred.parent;
        var child=if(parent.prev==negred){
            var nl=negred.prev;
            var nr=negred.next;
            var trl=nr.prev;
            var trr=nr.next;
            nl.colour=0;
            negred.colour=parent.colour=1;
            {
                negred.next=trl;
                if(trl!=null)trl.parent=negred;
            };
            {
                var t=parent.data;
                parent.data=nr.data;
                nr.data=t;
            };
            if(swapped!=null)swapped(parent.data,nr.data);
            {
                nr.prev=trr;
                if(trr!=null)trr.parent=nr;
            };
            {
                nr.next=parent.next;
                if(parent.next!=null)parent.next.parent=nr;
            };
            {
                parent.next=nr;
                if(nr!=null)nr.parent=parent;
            };
            nl;
        };
        else{
            var nl=negred.next;
            var nr=negred.prev;
            var trl=nr.next;
            var trr=nr.prev;
            nl.colour=0;
            negred.colour=parent.colour=1;
            {
                negred.prev=trl;
                if(trl!=null)trl.parent=negred;
            };
            {
                var t=parent.data;
                parent.data=nr.data;
                nr.data=t;
            };
            if(swapped!=null)swapped(parent.data,nr.data);
            {
                nr.next=trr;
                if(trr!=null)trr.parent=nr;
            };
            {
                nr.prev=parent.prev;
                if(parent.prev!=null)parent.prev.parent=nr;
            };
            {
                parent.prev=nr;
                if(nr!=null)nr.parent=parent;
            };
            nl;
        };
        if(child.prev!=null&&child.prev.colour==0)__fix_dbl_red(child.prev);
        else if(child.next!=null&&child.next.colour==0)__fix_dbl_red(child.next);
    }
    public function __fix_dbl_red(x:ZPP_Set_ZPP_PartitionPair){
        while(true){
            var par=x.parent;
            var g=par.parent;
            if(g==null){
                par.colour=1;
                break;
            }
            var n1:ZPP_Set_ZPP_PartitionPair,n2:ZPP_Set_ZPP_PartitionPair,n3:ZPP_Set_ZPP_PartitionPair,t1:ZPP_Set_ZPP_PartitionPair,t2:ZPP_Set_ZPP_PartitionPair,t3:ZPP_Set_ZPP_PartitionPair,t4:ZPP_Set_ZPP_PartitionPair;
            if(par==g.prev){
                n3=g;
                t4=g.next;
                if(x==par.prev){
                    n1=x;
                    n2=par;
                    t1=x.prev;
                    t2=x.next;
                    t3=par.next;
                }
                else{
                    n1=par;
                    n2=x;
                    t1=par.prev;
                    t2=x.prev;
                    t3=x.next;
                }
            }
            else{
                n1=g;
                t1=g.prev;
                if(x==par.prev){
                    n2=x;
                    n3=par;
                    t2=x.prev;
                    t3=x.next;
                    t4=par.next;
                }
                else{
                    n2=par;
                    n3=x;
                    t2=par.prev;
                    t3=x.prev;
                    t4=x.next;
                }
            }
            {
                var par=g.parent;
                if(par==null){
                    parent=n2;
                }
                else if(par.prev==g)par.prev=n2;
                else par.next=n2;
                if(n2!=null)n2.parent=par;
            };
            {
                n1.prev=t1;
                if(t1!=null)t1.parent=n1;
            };
            {
                n1.next=t2;
                if(t2!=null)t2.parent=n1;
            };
            {
                n2.prev=n1;
                if(n1!=null)n1.parent=n2;
            };
            {
                n2.next=n3;
                if(n3!=null)n3.parent=n2;
            };
            {
                n3.prev=t3;
                if(t3!=null)t3.parent=n3;
            };
            {
                n3.next=t4;
                if(t4!=null)t4.parent=n3;
            };
            n2.colour=g.colour-1;
            n1.colour=1;
            n3.colour=1;
            if(n2==parent)parent.colour=1;
            else if(n2.colour==0&&n2.parent.colour==0){
                x=n2;
                continue;
            }
            break;
        }
    }
    public function try_insert_bool(obj:ZPP_PartitionPair){
        var x:ZPP_Set_ZPP_PartitionPair=null;
        var cur:ZPP_Set_ZPP_PartitionPair=null;
        if(parent==null){
            {
                if(ZPP_Set_ZPP_PartitionPair.zpp_pool==null){
                    x=new ZPP_Set_ZPP_PartitionPair();
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionPair.POOL_TOT++;
                    ZPP_Set_ZPP_PartitionPair.POOL_ADDNEW++;
                    #end
                }
                else{
                    x=ZPP_Set_ZPP_PartitionPair.zpp_pool;
                    ZPP_Set_ZPP_PartitionPair.zpp_pool=x.next;
                    x.next=null;
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionPair.POOL_CNT--;
                    ZPP_Set_ZPP_PartitionPair.POOL_ADD++;
                    #end
                }
                x.alloc();
            };
            x.data=obj;
            parent=x;
        }
        else{
            cur=parent;
            while(true){
                if(lt(obj,cur.data)){
                    if(cur.prev==null){
                        {
                            if(ZPP_Set_ZPP_PartitionPair.zpp_pool==null){
                                x=new ZPP_Set_ZPP_PartitionPair();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionPair.POOL_TOT++;
                                ZPP_Set_ZPP_PartitionPair.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_PartitionPair.zpp_pool;
                                ZPP_Set_ZPP_PartitionPair.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionPair.POOL_CNT--;
                                ZPP_Set_ZPP_PartitionPair.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else if(lt(cur.data,obj)){
                    if(cur.next==null){
                        {
                            if(ZPP_Set_ZPP_PartitionPair.zpp_pool==null){
                                x=new ZPP_Set_ZPP_PartitionPair();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionPair.POOL_TOT++;
                                ZPP_Set_ZPP_PartitionPair.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_PartitionPair.zpp_pool;
                                ZPP_Set_ZPP_PartitionPair.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionPair.POOL_CNT--;
                                ZPP_Set_ZPP_PartitionPair.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
                else break;
            }
        }
        if(x==null)return false;
        else{
            if(x.parent==null)x.colour=1;
            else{
                x.colour=0;
                if(x.parent.colour==0)__fix_dbl_red(x);
            }
            return true;
        }
    }
    public function try_insert(obj:ZPP_PartitionPair){
        var x:ZPP_Set_ZPP_PartitionPair=null;
        var cur:ZPP_Set_ZPP_PartitionPair=null;
        if(parent==null){
            {
                if(ZPP_Set_ZPP_PartitionPair.zpp_pool==null){
                    x=new ZPP_Set_ZPP_PartitionPair();
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionPair.POOL_TOT++;
                    ZPP_Set_ZPP_PartitionPair.POOL_ADDNEW++;
                    #end
                }
                else{
                    x=ZPP_Set_ZPP_PartitionPair.zpp_pool;
                    ZPP_Set_ZPP_PartitionPair.zpp_pool=x.next;
                    x.next=null;
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionPair.POOL_CNT--;
                    ZPP_Set_ZPP_PartitionPair.POOL_ADD++;
                    #end
                }
                x.alloc();
            };
            x.data=obj;
            parent=x;
        }
        else{
            cur=parent;
            while(true){
                if(lt(obj,cur.data)){
                    if(cur.prev==null){
                        {
                            if(ZPP_Set_ZPP_PartitionPair.zpp_pool==null){
                                x=new ZPP_Set_ZPP_PartitionPair();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionPair.POOL_TOT++;
                                ZPP_Set_ZPP_PartitionPair.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_PartitionPair.zpp_pool;
                                ZPP_Set_ZPP_PartitionPair.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionPair.POOL_CNT--;
                                ZPP_Set_ZPP_PartitionPair.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else if(lt(cur.data,obj)){
                    if(cur.next==null){
                        {
                            if(ZPP_Set_ZPP_PartitionPair.zpp_pool==null){
                                x=new ZPP_Set_ZPP_PartitionPair();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionPair.POOL_TOT++;
                                ZPP_Set_ZPP_PartitionPair.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_PartitionPair.zpp_pool;
                                ZPP_Set_ZPP_PartitionPair.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionPair.POOL_CNT--;
                                ZPP_Set_ZPP_PartitionPair.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
                else break;
            }
        }
        if(x==null)return cur;
        else{
            if(x.parent==null)x.colour=1;
            else{
                x.colour=0;
                if(x.parent.colour==0)__fix_dbl_red(x);
            }
            return x;
        }
    }
    public function insert(obj:ZPP_PartitionPair){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !has(obj);
            };
            if(!res)throw "assert("+"!has(obj)"+") :: "+("object already in set");
            #end
        };
        var x;
        {
            if(ZPP_Set_ZPP_PartitionPair.zpp_pool==null){
                x=new ZPP_Set_ZPP_PartitionPair();
                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionPair.POOL_TOT++;
                ZPP_Set_ZPP_PartitionPair.POOL_ADDNEW++;
                #end
            }
            else{
                x=ZPP_Set_ZPP_PartitionPair.zpp_pool;
                ZPP_Set_ZPP_PartitionPair.zpp_pool=x.next;
                x.next=null;
                #if NAPE_POOL_STATS ZPP_Set_ZPP_PartitionPair.POOL_CNT--;
                ZPP_Set_ZPP_PartitionPair.POOL_ADD++;
                #end
            }
            x.alloc();
        };
        x.data=obj;
        if(parent==null)parent=x;
        else{
            var cur=parent;
            while(true){
                if(lt(x.data,cur.data)){
                    if(cur.prev==null){
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else{
                    if(cur.next==null){
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
            }
        }
        if(x.parent==null)x.colour=1;
        else{
            x.colour=0;
            if(x.parent.colour==0)__fix_dbl_red(x);
        }
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x.data==obj;
            };
            if(!res)throw "assert("+"x.data==obj"+") :: "+("...wtf?");
            #end
        };
        return x;
    }
}
#if nape_swc@:keep #end
class ZPP_Set_ZPP_SimpleVert{
    static public var zpp_pool:ZPP_Set_ZPP_SimpleVert=null;
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
    function free(){
        data=null;
        lt=null;
        swapped=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    public var lt:ZPP_SimpleVert->ZPP_SimpleVert->Bool=null;
    public var swapped:ZPP_SimpleVert->ZPP_SimpleVert->Void=null;
    public var data:ZPP_SimpleVert=null;
    public var prev:ZPP_Set_ZPP_SimpleVert=null;
    public var next:ZPP_Set_ZPP_SimpleVert=null;
    public var parent:ZPP_Set_ZPP_SimpleVert=null;
    public var colour:Int=0;
    public function new(){}
    public function verify(){
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    this!=null;
                };
                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                #end
            };
            if(!this.empty()){
                var set_ite=this.parent;
                while(set_ite.prev!=null)set_ite=set_ite.prev;
                while(set_ite!=null){
                    var i=set_ite.data;
                    {
                        var prei=true;
                        {
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    this!=null;
                                };
                                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                                #end
                            };
                            if(!this.empty()){
                                var set_ite=this.parent;
                                while(set_ite.prev!=null)set_ite=set_ite.prev;
                                while(set_ite!=null){
                                    var j=set_ite.data;
                                    {
                                        if(!prei){
                                            if(!lt(i,j)&&lt(j,i))return false;
                                        }
                                        else if(i==j)prei=false;
                                        else{
                                            if(!lt(j,i)&&lt(i,j))return false;
                                        }
                                    };
                                    if(set_ite.next!=null){
                                        set_ite=set_ite.next;
                                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                                    }
                                    else{
                                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                                        set_ite=set_ite.parent;
                                    }
                                }
                            }
                        };
                    };
                    if(set_ite.next!=null){
                        set_ite=set_ite.next;
                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                    }
                    else{
                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                        set_ite=set_ite.parent;
                    }
                }
            }
        };
        return true;
    }
    public function empty(){
        return parent==null;
    }
    public function singular(){
        return parent!=null&&parent.prev==null&&parent.next==null;
    }
    public function size(){
        var ret=0;
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    this!=null;
                };
                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                #end
            };
            if(!this.empty()){
                var set_ite=this.parent;
                while(set_ite.prev!=null)set_ite=set_ite.prev;
                while(set_ite!=null){
                    var i=set_ite.data;
                    ret++;
                    if(set_ite.next!=null){
                        set_ite=set_ite.next;
                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                    }
                    else{
                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                        set_ite=set_ite.parent;
                    }
                }
            }
        };
        return ret;
    }
    public function has(obj:ZPP_SimpleVert){
        return find(obj)!=null;
    }
    public function find(obj:ZPP_SimpleVert){
        var cur=parent;
        while(cur!=null&&cur.data!=obj){
            if(lt(obj,cur.data))cur=cur.prev;
            else cur=cur.next;
        }
        return cur;
    }
    public function has_weak(obj:ZPP_SimpleVert){
        return find_weak(obj)!=null;
    }
    public function find_weak(obj:ZPP_SimpleVert){
        var cur=parent;
        while(cur!=null){
            if(lt(obj,cur.data))cur=cur.prev;
            else if(lt(cur.data,obj))cur=cur.next;
            else break;
        }
        return cur;
    }
    public function lower_bound(obj:ZPP_SimpleVert){
        return{
            var ret=null;
            {
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        this!=null;
                    };
                    if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                    #end
                };
                if(!this.empty()){
                    var set_ite=this.parent;
                    while(set_ite.prev!=null)set_ite=set_ite.prev;
                    while(set_ite!=null){
                        var elt=set_ite.data;
                        {
                            if(!lt(elt,obj)){
                                ret=elt;
                                break;
                            }
                        };
                        if(set_ite.next!=null){
                            set_ite=set_ite.next;
                            while(set_ite.prev!=null)set_ite=set_ite.prev;
                        }
                        else{
                            while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                            set_ite=set_ite.parent;
                        }
                    }
                }
            };
            ret;
        };
    }
    public function first(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("first in empty");
            #end
        };
        var cur=parent;
        while(cur.prev!=null)cur=cur.prev;
        return cur.data;
    }
    public function pop_front(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("pop_front in empty");
            #end
        };
        var cur=parent;
        while(cur.prev!=null)cur=cur.prev;
        var ret=cur.data;
        remove_node(cur);
        return ret;
    }
    public function remove(obj:ZPP_SimpleVert){
        var node=find(obj);
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                node!=null;
            };
            if(!res)throw "assert("+"node!=null"+") :: "+("object not in tree");
            #end
        };
        remove_node(node);
    }
    public function successor_node(cur:ZPP_Set_ZPP_SimpleVert){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.next!=null){
            cur=cur.next;
            while(cur.prev!=null)cur=cur.prev;
        }
        else{
            var pre=cur;
            cur=cur.parent;
            while(cur!=null&&cur.prev!=pre){
                pre=cur;
                cur=cur.parent;
            }
        }
        return cur;
    }
    public function predecessor_node(cur:ZPP_Set_ZPP_SimpleVert){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.prev!=null){
            cur=cur.prev;
            while(cur.next!=null)cur=cur.next;
        }
        else{
            var pre=cur;
            cur=cur.parent;
            while(cur!=null&&cur.next!=pre){
                pre=cur;
                cur=cur.parent;
            }
        }
        return cur;
    }
    public function successor(obj:ZPP_SimpleVert){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("not in tree!");
            #end
        };
        var node=successor_node(find(obj));
        return node==null?null:node.data;
    }
    public function predecessor(obj:ZPP_SimpleVert){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("not in tree!");
            #end
        };
        var node=predecessor_node(find(obj));
        return node==null?null:node.data;
    }
    public function remove_node(cur:ZPP_Set_ZPP_SimpleVert){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.next!=null&&cur.prev!=null){
            var sm=cur.next;
            while(sm.prev!=null)sm=sm.prev;
            {
                var t=cur.data;
                cur.data=sm.data;
                sm.data=t;
            };
            if(swapped!=null)swapped(cur.data,sm.data);
            cur=sm;
        }
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur.next==null||cur.prev==null;
            };
            if(!res)throw "assert("+"cur.next==null||cur.prev==null"+") :: "+("node still has two children??");
            #end
        };
        var child=if(cur.prev==null)cur.next else cur.prev;
        if(cur.colour==1){
            if(cur.prev!=null||cur.next!=null)child.colour=1;
            else if(cur.parent!=null){
                var parent=cur.parent;
                while(true){
                    parent.colour++;
                    parent.prev.colour--;
                    parent.next.colour--;
                    {
                        var child=parent.prev;
                        if(child.colour==(-1)){
                            __fix_neg_red(child);
                            break;
                        }
                        else if(child.colour==0){
                            {
                                if(child.prev!=null&&child.prev.colour==0){
                                    __fix_dbl_red(child.prev);
                                    break;
                                }
                            }
                            {
                                if(child.next!=null&&child.next.colour==0){
                                    __fix_dbl_red(child.next);
                                    break;
                                }
                            }
                        }
                    }
                    {
                        var child=parent.next;
                        if(child.colour==(-1)){
                            __fix_neg_red(child);
                            break;
                        }
                        else if(child.colour==0){
                            {
                                if(child.prev!=null&&child.prev.colour==0){
                                    __fix_dbl_red(child.prev);
                                    break;
                                }
                            }
                            {
                                if(child.next!=null&&child.next.colour==0){
                                    __fix_dbl_red(child.next);
                                    break;
                                }
                            }
                        }
                    }
                    if(parent.colour==2){
                        if(parent.parent==null){
                            parent.colour=1;
                        }
                        else{
                            parent=parent.parent;
                            continue;
                        }
                    }
                    break;
                }
            }
        }
        {
            var par=cur.parent;
            if(par==null){
                parent=child;
            }
            else if(par.prev==cur)par.prev=child;
            else par.next=child;
            if(child!=null)child.parent=par;
        };
        cur.parent=cur.prev=cur.next=null;
        {
            var o=cur;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_SimpleVert"+", in obj: "+"cur"+")");
                #end
            };
            o.free();
            o.next=ZPP_Set_ZPP_SimpleVert.zpp_pool;
            ZPP_Set_ZPP_SimpleVert.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleVert.POOL_CNT++;
            ZPP_Set_ZPP_SimpleVert.POOL_SUB++;
            #end
        };
    }
    public function clear(){
        clear_with(function(_){});
    }
    public#if NAPE_NO_INLINE#else inline #end
    function clear_with(lambda:ZPP_SimpleVert->Void){
        if(parent==null)return;
        else{
            var cur=parent;
            while(cur!=null)cur=if(cur.prev!=null)cur.prev else if(cur.next!=null)cur.next else clear_node(cur,lambda);
            parent=null;
        }
    }
    #if NAPE_NO_INLINE#else inline #end
    function clear_node(node:ZPP_Set_ZPP_SimpleVert,lambda:ZPP_SimpleVert->Void){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                node.next==null&&node.prev==null;
            };
            if(!res)throw "assert("+"node.next==null&&node.prev==null"+") :: "+("clear_node :: node not a leaf");
            #end
        };
        lambda(node.data);
        var ret=node.parent;
        if(ret!=null){
            if(node==ret.prev)ret.prev=null;
            else ret.next=null;
            node.parent=null;
        }
        {
            var o=node;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_SimpleVert"+", in obj: "+"node"+")");
                #end
            };
            o.free();
            o.next=ZPP_Set_ZPP_SimpleVert.zpp_pool;
            ZPP_Set_ZPP_SimpleVert.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleVert.POOL_CNT++;
            ZPP_Set_ZPP_SimpleVert.POOL_SUB++;
            #end
        };
        return ret;
    }
    public function __fix_neg_red(negred:ZPP_Set_ZPP_SimpleVert){
        var parent=negred.parent;
        var child=if(parent.prev==negred){
            var nl=negred.prev;
            var nr=negred.next;
            var trl=nr.prev;
            var trr=nr.next;
            nl.colour=0;
            negred.colour=parent.colour=1;
            {
                negred.next=trl;
                if(trl!=null)trl.parent=negred;
            };
            {
                var t=parent.data;
                parent.data=nr.data;
                nr.data=t;
            };
            if(swapped!=null)swapped(parent.data,nr.data);
            {
                nr.prev=trr;
                if(trr!=null)trr.parent=nr;
            };
            {
                nr.next=parent.next;
                if(parent.next!=null)parent.next.parent=nr;
            };
            {
                parent.next=nr;
                if(nr!=null)nr.parent=parent;
            };
            nl;
        };
        else{
            var nl=negred.next;
            var nr=negred.prev;
            var trl=nr.next;
            var trr=nr.prev;
            nl.colour=0;
            negred.colour=parent.colour=1;
            {
                negred.prev=trl;
                if(trl!=null)trl.parent=negred;
            };
            {
                var t=parent.data;
                parent.data=nr.data;
                nr.data=t;
            };
            if(swapped!=null)swapped(parent.data,nr.data);
            {
                nr.next=trr;
                if(trr!=null)trr.parent=nr;
            };
            {
                nr.prev=parent.prev;
                if(parent.prev!=null)parent.prev.parent=nr;
            };
            {
                parent.prev=nr;
                if(nr!=null)nr.parent=parent;
            };
            nl;
        };
        if(child.prev!=null&&child.prev.colour==0)__fix_dbl_red(child.prev);
        else if(child.next!=null&&child.next.colour==0)__fix_dbl_red(child.next);
    }
    public function __fix_dbl_red(x:ZPP_Set_ZPP_SimpleVert){
        while(true){
            var par=x.parent;
            var g=par.parent;
            if(g==null){
                par.colour=1;
                break;
            }
            var n1:ZPP_Set_ZPP_SimpleVert,n2:ZPP_Set_ZPP_SimpleVert,n3:ZPP_Set_ZPP_SimpleVert,t1:ZPP_Set_ZPP_SimpleVert,t2:ZPP_Set_ZPP_SimpleVert,t3:ZPP_Set_ZPP_SimpleVert,t4:ZPP_Set_ZPP_SimpleVert;
            if(par==g.prev){
                n3=g;
                t4=g.next;
                if(x==par.prev){
                    n1=x;
                    n2=par;
                    t1=x.prev;
                    t2=x.next;
                    t3=par.next;
                }
                else{
                    n1=par;
                    n2=x;
                    t1=par.prev;
                    t2=x.prev;
                    t3=x.next;
                }
            }
            else{
                n1=g;
                t1=g.prev;
                if(x==par.prev){
                    n2=x;
                    n3=par;
                    t2=x.prev;
                    t3=x.next;
                    t4=par.next;
                }
                else{
                    n2=par;
                    n3=x;
                    t2=par.prev;
                    t3=x.prev;
                    t4=x.next;
                }
            }
            {
                var par=g.parent;
                if(par==null){
                    parent=n2;
                }
                else if(par.prev==g)par.prev=n2;
                else par.next=n2;
                if(n2!=null)n2.parent=par;
            };
            {
                n1.prev=t1;
                if(t1!=null)t1.parent=n1;
            };
            {
                n1.next=t2;
                if(t2!=null)t2.parent=n1;
            };
            {
                n2.prev=n1;
                if(n1!=null)n1.parent=n2;
            };
            {
                n2.next=n3;
                if(n3!=null)n3.parent=n2;
            };
            {
                n3.prev=t3;
                if(t3!=null)t3.parent=n3;
            };
            {
                n3.next=t4;
                if(t4!=null)t4.parent=n3;
            };
            n2.colour=g.colour-1;
            n1.colour=1;
            n3.colour=1;
            if(n2==parent)parent.colour=1;
            else if(n2.colour==0&&n2.parent.colour==0){
                x=n2;
                continue;
            }
            break;
        }
    }
    public function try_insert_bool(obj:ZPP_SimpleVert){
        var x:ZPP_Set_ZPP_SimpleVert=null;
        var cur:ZPP_Set_ZPP_SimpleVert=null;
        if(parent==null){
            {
                if(ZPP_Set_ZPP_SimpleVert.zpp_pool==null){
                    x=new ZPP_Set_ZPP_SimpleVert();
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleVert.POOL_TOT++;
                    ZPP_Set_ZPP_SimpleVert.POOL_ADDNEW++;
                    #end
                }
                else{
                    x=ZPP_Set_ZPP_SimpleVert.zpp_pool;
                    ZPP_Set_ZPP_SimpleVert.zpp_pool=x.next;
                    x.next=null;
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleVert.POOL_CNT--;
                    ZPP_Set_ZPP_SimpleVert.POOL_ADD++;
                    #end
                }
                x.alloc();
            };
            x.data=obj;
            parent=x;
        }
        else{
            cur=parent;
            while(true){
                if(lt(obj,cur.data)){
                    if(cur.prev==null){
                        {
                            if(ZPP_Set_ZPP_SimpleVert.zpp_pool==null){
                                x=new ZPP_Set_ZPP_SimpleVert();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleVert.POOL_TOT++;
                                ZPP_Set_ZPP_SimpleVert.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_SimpleVert.zpp_pool;
                                ZPP_Set_ZPP_SimpleVert.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleVert.POOL_CNT--;
                                ZPP_Set_ZPP_SimpleVert.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else if(lt(cur.data,obj)){
                    if(cur.next==null){
                        {
                            if(ZPP_Set_ZPP_SimpleVert.zpp_pool==null){
                                x=new ZPP_Set_ZPP_SimpleVert();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleVert.POOL_TOT++;
                                ZPP_Set_ZPP_SimpleVert.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_SimpleVert.zpp_pool;
                                ZPP_Set_ZPP_SimpleVert.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleVert.POOL_CNT--;
                                ZPP_Set_ZPP_SimpleVert.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
                else break;
            }
        }
        if(x==null)return false;
        else{
            if(x.parent==null)x.colour=1;
            else{
                x.colour=0;
                if(x.parent.colour==0)__fix_dbl_red(x);
            }
            return true;
        }
    }
    public function try_insert(obj:ZPP_SimpleVert){
        var x:ZPP_Set_ZPP_SimpleVert=null;
        var cur:ZPP_Set_ZPP_SimpleVert=null;
        if(parent==null){
            {
                if(ZPP_Set_ZPP_SimpleVert.zpp_pool==null){
                    x=new ZPP_Set_ZPP_SimpleVert();
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleVert.POOL_TOT++;
                    ZPP_Set_ZPP_SimpleVert.POOL_ADDNEW++;
                    #end
                }
                else{
                    x=ZPP_Set_ZPP_SimpleVert.zpp_pool;
                    ZPP_Set_ZPP_SimpleVert.zpp_pool=x.next;
                    x.next=null;
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleVert.POOL_CNT--;
                    ZPP_Set_ZPP_SimpleVert.POOL_ADD++;
                    #end
                }
                x.alloc();
            };
            x.data=obj;
            parent=x;
        }
        else{
            cur=parent;
            while(true){
                if(lt(obj,cur.data)){
                    if(cur.prev==null){
                        {
                            if(ZPP_Set_ZPP_SimpleVert.zpp_pool==null){
                                x=new ZPP_Set_ZPP_SimpleVert();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleVert.POOL_TOT++;
                                ZPP_Set_ZPP_SimpleVert.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_SimpleVert.zpp_pool;
                                ZPP_Set_ZPP_SimpleVert.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleVert.POOL_CNT--;
                                ZPP_Set_ZPP_SimpleVert.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else if(lt(cur.data,obj)){
                    if(cur.next==null){
                        {
                            if(ZPP_Set_ZPP_SimpleVert.zpp_pool==null){
                                x=new ZPP_Set_ZPP_SimpleVert();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleVert.POOL_TOT++;
                                ZPP_Set_ZPP_SimpleVert.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_SimpleVert.zpp_pool;
                                ZPP_Set_ZPP_SimpleVert.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleVert.POOL_CNT--;
                                ZPP_Set_ZPP_SimpleVert.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
                else break;
            }
        }
        if(x==null)return cur;
        else{
            if(x.parent==null)x.colour=1;
            else{
                x.colour=0;
                if(x.parent.colour==0)__fix_dbl_red(x);
            }
            return x;
        }
    }
    public function insert(obj:ZPP_SimpleVert){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !has(obj);
            };
            if(!res)throw "assert("+"!has(obj)"+") :: "+("object already in set");
            #end
        };
        var x;
        {
            if(ZPP_Set_ZPP_SimpleVert.zpp_pool==null){
                x=new ZPP_Set_ZPP_SimpleVert();
                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleVert.POOL_TOT++;
                ZPP_Set_ZPP_SimpleVert.POOL_ADDNEW++;
                #end
            }
            else{
                x=ZPP_Set_ZPP_SimpleVert.zpp_pool;
                ZPP_Set_ZPP_SimpleVert.zpp_pool=x.next;
                x.next=null;
                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleVert.POOL_CNT--;
                ZPP_Set_ZPP_SimpleVert.POOL_ADD++;
                #end
            }
            x.alloc();
        };
        x.data=obj;
        if(parent==null)parent=x;
        else{
            var cur=parent;
            while(true){
                if(lt(x.data,cur.data)){
                    if(cur.prev==null){
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else{
                    if(cur.next==null){
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
            }
        }
        if(x.parent==null)x.colour=1;
        else{
            x.colour=0;
            if(x.parent.colour==0)__fix_dbl_red(x);
        }
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x.data==obj;
            };
            if(!res)throw "assert("+"x.data==obj"+") :: "+("...wtf?");
            #end
        };
        return x;
    }
}
#if nape_swc@:keep #end
class ZPP_Set_ZPP_SimpleSeg{
    static public var zpp_pool:ZPP_Set_ZPP_SimpleSeg=null;
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
    function free(){
        data=null;
        lt=null;
        swapped=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    public var lt:ZPP_SimpleSeg->ZPP_SimpleSeg->Bool=null;
    public var swapped:ZPP_SimpleSeg->ZPP_SimpleSeg->Void=null;
    public var data:ZPP_SimpleSeg=null;
    public var prev:ZPP_Set_ZPP_SimpleSeg=null;
    public var next:ZPP_Set_ZPP_SimpleSeg=null;
    public var parent:ZPP_Set_ZPP_SimpleSeg=null;
    public var colour:Int=0;
    public function new(){}
    public function verify(){
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    this!=null;
                };
                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                #end
            };
            if(!this.empty()){
                var set_ite=this.parent;
                while(set_ite.prev!=null)set_ite=set_ite.prev;
                while(set_ite!=null){
                    var i=set_ite.data;
                    {
                        var prei=true;
                        {
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    this!=null;
                                };
                                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                                #end
                            };
                            if(!this.empty()){
                                var set_ite=this.parent;
                                while(set_ite.prev!=null)set_ite=set_ite.prev;
                                while(set_ite!=null){
                                    var j=set_ite.data;
                                    {
                                        if(!prei){
                                            if(!lt(i,j)&&lt(j,i))return false;
                                        }
                                        else if(i==j)prei=false;
                                        else{
                                            if(!lt(j,i)&&lt(i,j))return false;
                                        }
                                    };
                                    if(set_ite.next!=null){
                                        set_ite=set_ite.next;
                                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                                    }
                                    else{
                                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                                        set_ite=set_ite.parent;
                                    }
                                }
                            }
                        };
                    };
                    if(set_ite.next!=null){
                        set_ite=set_ite.next;
                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                    }
                    else{
                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                        set_ite=set_ite.parent;
                    }
                }
            }
        };
        return true;
    }
    public function empty(){
        return parent==null;
    }
    public function singular(){
        return parent!=null&&parent.prev==null&&parent.next==null;
    }
    public function size(){
        var ret=0;
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    this!=null;
                };
                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                #end
            };
            if(!this.empty()){
                var set_ite=this.parent;
                while(set_ite.prev!=null)set_ite=set_ite.prev;
                while(set_ite!=null){
                    var i=set_ite.data;
                    ret++;
                    if(set_ite.next!=null){
                        set_ite=set_ite.next;
                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                    }
                    else{
                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                        set_ite=set_ite.parent;
                    }
                }
            }
        };
        return ret;
    }
    public function has(obj:ZPP_SimpleSeg){
        return find(obj)!=null;
    }
    public function find(obj:ZPP_SimpleSeg){
        var cur=parent;
        while(cur!=null&&cur.data!=obj){
            if(lt(obj,cur.data))cur=cur.prev;
            else cur=cur.next;
        }
        return cur;
    }
    public function has_weak(obj:ZPP_SimpleSeg){
        return find_weak(obj)!=null;
    }
    public function find_weak(obj:ZPP_SimpleSeg){
        var cur=parent;
        while(cur!=null){
            if(lt(obj,cur.data))cur=cur.prev;
            else if(lt(cur.data,obj))cur=cur.next;
            else break;
        }
        return cur;
    }
    public function lower_bound(obj:ZPP_SimpleSeg){
        return{
            var ret=null;
            {
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        this!=null;
                    };
                    if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                    #end
                };
                if(!this.empty()){
                    var set_ite=this.parent;
                    while(set_ite.prev!=null)set_ite=set_ite.prev;
                    while(set_ite!=null){
                        var elt=set_ite.data;
                        {
                            if(!lt(elt,obj)){
                                ret=elt;
                                break;
                            }
                        };
                        if(set_ite.next!=null){
                            set_ite=set_ite.next;
                            while(set_ite.prev!=null)set_ite=set_ite.prev;
                        }
                        else{
                            while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                            set_ite=set_ite.parent;
                        }
                    }
                }
            };
            ret;
        };
    }
    public function first(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("first in empty");
            #end
        };
        var cur=parent;
        while(cur.prev!=null)cur=cur.prev;
        return cur.data;
    }
    public function pop_front(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("pop_front in empty");
            #end
        };
        var cur=parent;
        while(cur.prev!=null)cur=cur.prev;
        var ret=cur.data;
        remove_node(cur);
        return ret;
    }
    public function remove(obj:ZPP_SimpleSeg){
        var node=find(obj);
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                node!=null;
            };
            if(!res)throw "assert("+"node!=null"+") :: "+("object not in tree");
            #end
        };
        remove_node(node);
    }
    public function successor_node(cur:ZPP_Set_ZPP_SimpleSeg){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.next!=null){
            cur=cur.next;
            while(cur.prev!=null)cur=cur.prev;
        }
        else{
            var pre=cur;
            cur=cur.parent;
            while(cur!=null&&cur.prev!=pre){
                pre=cur;
                cur=cur.parent;
            }
        }
        return cur;
    }
    public function predecessor_node(cur:ZPP_Set_ZPP_SimpleSeg){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.prev!=null){
            cur=cur.prev;
            while(cur.next!=null)cur=cur.next;
        }
        else{
            var pre=cur;
            cur=cur.parent;
            while(cur!=null&&cur.next!=pre){
                pre=cur;
                cur=cur.parent;
            }
        }
        return cur;
    }
    public function successor(obj:ZPP_SimpleSeg){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("not in tree!");
            #end
        };
        var node=successor_node(find(obj));
        return node==null?null:node.data;
    }
    public function predecessor(obj:ZPP_SimpleSeg){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("not in tree!");
            #end
        };
        var node=predecessor_node(find(obj));
        return node==null?null:node.data;
    }
    public function remove_node(cur:ZPP_Set_ZPP_SimpleSeg){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.next!=null&&cur.prev!=null){
            var sm=cur.next;
            while(sm.prev!=null)sm=sm.prev;
            {
                var t=cur.data;
                cur.data=sm.data;
                sm.data=t;
            };
            if(swapped!=null)swapped(cur.data,sm.data);
            cur=sm;
        }
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur.next==null||cur.prev==null;
            };
            if(!res)throw "assert("+"cur.next==null||cur.prev==null"+") :: "+("node still has two children??");
            #end
        };
        var child=if(cur.prev==null)cur.next else cur.prev;
        if(cur.colour==1){
            if(cur.prev!=null||cur.next!=null)child.colour=1;
            else if(cur.parent!=null){
                var parent=cur.parent;
                while(true){
                    parent.colour++;
                    parent.prev.colour--;
                    parent.next.colour--;
                    {
                        var child=parent.prev;
                        if(child.colour==(-1)){
                            __fix_neg_red(child);
                            break;
                        }
                        else if(child.colour==0){
                            {
                                if(child.prev!=null&&child.prev.colour==0){
                                    __fix_dbl_red(child.prev);
                                    break;
                                }
                            }
                            {
                                if(child.next!=null&&child.next.colour==0){
                                    __fix_dbl_red(child.next);
                                    break;
                                }
                            }
                        }
                    }
                    {
                        var child=parent.next;
                        if(child.colour==(-1)){
                            __fix_neg_red(child);
                            break;
                        }
                        else if(child.colour==0){
                            {
                                if(child.prev!=null&&child.prev.colour==0){
                                    __fix_dbl_red(child.prev);
                                    break;
                                }
                            }
                            {
                                if(child.next!=null&&child.next.colour==0){
                                    __fix_dbl_red(child.next);
                                    break;
                                }
                            }
                        }
                    }
                    if(parent.colour==2){
                        if(parent.parent==null){
                            parent.colour=1;
                        }
                        else{
                            parent=parent.parent;
                            continue;
                        }
                    }
                    break;
                }
            }
        }
        {
            var par=cur.parent;
            if(par==null){
                parent=child;
            }
            else if(par.prev==cur)par.prev=child;
            else par.next=child;
            if(child!=null)child.parent=par;
        };
        cur.parent=cur.prev=cur.next=null;
        {
            var o=cur;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_SimpleSeg"+", in obj: "+"cur"+")");
                #end
            };
            o.free();
            o.next=ZPP_Set_ZPP_SimpleSeg.zpp_pool;
            ZPP_Set_ZPP_SimpleSeg.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleSeg.POOL_CNT++;
            ZPP_Set_ZPP_SimpleSeg.POOL_SUB++;
            #end
        };
    }
    public function clear(){
        clear_with(function(_){});
    }
    public#if NAPE_NO_INLINE#else inline #end
    function clear_with(lambda:ZPP_SimpleSeg->Void){
        if(parent==null)return;
        else{
            var cur=parent;
            while(cur!=null)cur=if(cur.prev!=null)cur.prev else if(cur.next!=null)cur.next else clear_node(cur,lambda);
            parent=null;
        }
    }
    #if NAPE_NO_INLINE#else inline #end
    function clear_node(node:ZPP_Set_ZPP_SimpleSeg,lambda:ZPP_SimpleSeg->Void){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                node.next==null&&node.prev==null;
            };
            if(!res)throw "assert("+"node.next==null&&node.prev==null"+") :: "+("clear_node :: node not a leaf");
            #end
        };
        lambda(node.data);
        var ret=node.parent;
        if(ret!=null){
            if(node==ret.prev)ret.prev=null;
            else ret.next=null;
            node.parent=null;
        }
        {
            var o=node;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_SimpleSeg"+", in obj: "+"node"+")");
                #end
            };
            o.free();
            o.next=ZPP_Set_ZPP_SimpleSeg.zpp_pool;
            ZPP_Set_ZPP_SimpleSeg.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleSeg.POOL_CNT++;
            ZPP_Set_ZPP_SimpleSeg.POOL_SUB++;
            #end
        };
        return ret;
    }
    public function __fix_neg_red(negred:ZPP_Set_ZPP_SimpleSeg){
        var parent=negred.parent;
        var child=if(parent.prev==negred){
            var nl=negred.prev;
            var nr=negred.next;
            var trl=nr.prev;
            var trr=nr.next;
            nl.colour=0;
            negred.colour=parent.colour=1;
            {
                negred.next=trl;
                if(trl!=null)trl.parent=negred;
            };
            {
                var t=parent.data;
                parent.data=nr.data;
                nr.data=t;
            };
            if(swapped!=null)swapped(parent.data,nr.data);
            {
                nr.prev=trr;
                if(trr!=null)trr.parent=nr;
            };
            {
                nr.next=parent.next;
                if(parent.next!=null)parent.next.parent=nr;
            };
            {
                parent.next=nr;
                if(nr!=null)nr.parent=parent;
            };
            nl;
        };
        else{
            var nl=negred.next;
            var nr=negred.prev;
            var trl=nr.next;
            var trr=nr.prev;
            nl.colour=0;
            negred.colour=parent.colour=1;
            {
                negred.prev=trl;
                if(trl!=null)trl.parent=negred;
            };
            {
                var t=parent.data;
                parent.data=nr.data;
                nr.data=t;
            };
            if(swapped!=null)swapped(parent.data,nr.data);
            {
                nr.next=trr;
                if(trr!=null)trr.parent=nr;
            };
            {
                nr.prev=parent.prev;
                if(parent.prev!=null)parent.prev.parent=nr;
            };
            {
                parent.prev=nr;
                if(nr!=null)nr.parent=parent;
            };
            nl;
        };
        if(child.prev!=null&&child.prev.colour==0)__fix_dbl_red(child.prev);
        else if(child.next!=null&&child.next.colour==0)__fix_dbl_red(child.next);
    }
    public function __fix_dbl_red(x:ZPP_Set_ZPP_SimpleSeg){
        while(true){
            var par=x.parent;
            var g=par.parent;
            if(g==null){
                par.colour=1;
                break;
            }
            var n1:ZPP_Set_ZPP_SimpleSeg,n2:ZPP_Set_ZPP_SimpleSeg,n3:ZPP_Set_ZPP_SimpleSeg,t1:ZPP_Set_ZPP_SimpleSeg,t2:ZPP_Set_ZPP_SimpleSeg,t3:ZPP_Set_ZPP_SimpleSeg,t4:ZPP_Set_ZPP_SimpleSeg;
            if(par==g.prev){
                n3=g;
                t4=g.next;
                if(x==par.prev){
                    n1=x;
                    n2=par;
                    t1=x.prev;
                    t2=x.next;
                    t3=par.next;
                }
                else{
                    n1=par;
                    n2=x;
                    t1=par.prev;
                    t2=x.prev;
                    t3=x.next;
                }
            }
            else{
                n1=g;
                t1=g.prev;
                if(x==par.prev){
                    n2=x;
                    n3=par;
                    t2=x.prev;
                    t3=x.next;
                    t4=par.next;
                }
                else{
                    n2=par;
                    n3=x;
                    t2=par.prev;
                    t3=x.prev;
                    t4=x.next;
                }
            }
            {
                var par=g.parent;
                if(par==null){
                    parent=n2;
                }
                else if(par.prev==g)par.prev=n2;
                else par.next=n2;
                if(n2!=null)n2.parent=par;
            };
            {
                n1.prev=t1;
                if(t1!=null)t1.parent=n1;
            };
            {
                n1.next=t2;
                if(t2!=null)t2.parent=n1;
            };
            {
                n2.prev=n1;
                if(n1!=null)n1.parent=n2;
            };
            {
                n2.next=n3;
                if(n3!=null)n3.parent=n2;
            };
            {
                n3.prev=t3;
                if(t3!=null)t3.parent=n3;
            };
            {
                n3.next=t4;
                if(t4!=null)t4.parent=n3;
            };
            n2.colour=g.colour-1;
            n1.colour=1;
            n3.colour=1;
            if(n2==parent)parent.colour=1;
            else if(n2.colour==0&&n2.parent.colour==0){
                x=n2;
                continue;
            }
            break;
        }
    }
    public function try_insert_bool(obj:ZPP_SimpleSeg){
        var x:ZPP_Set_ZPP_SimpleSeg=null;
        var cur:ZPP_Set_ZPP_SimpleSeg=null;
        if(parent==null){
            {
                if(ZPP_Set_ZPP_SimpleSeg.zpp_pool==null){
                    x=new ZPP_Set_ZPP_SimpleSeg();
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleSeg.POOL_TOT++;
                    ZPP_Set_ZPP_SimpleSeg.POOL_ADDNEW++;
                    #end
                }
                else{
                    x=ZPP_Set_ZPP_SimpleSeg.zpp_pool;
                    ZPP_Set_ZPP_SimpleSeg.zpp_pool=x.next;
                    x.next=null;
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleSeg.POOL_CNT--;
                    ZPP_Set_ZPP_SimpleSeg.POOL_ADD++;
                    #end
                }
                x.alloc();
            };
            x.data=obj;
            parent=x;
        }
        else{
            cur=parent;
            while(true){
                if(lt(obj,cur.data)){
                    if(cur.prev==null){
                        {
                            if(ZPP_Set_ZPP_SimpleSeg.zpp_pool==null){
                                x=new ZPP_Set_ZPP_SimpleSeg();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleSeg.POOL_TOT++;
                                ZPP_Set_ZPP_SimpleSeg.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_SimpleSeg.zpp_pool;
                                ZPP_Set_ZPP_SimpleSeg.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleSeg.POOL_CNT--;
                                ZPP_Set_ZPP_SimpleSeg.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else if(lt(cur.data,obj)){
                    if(cur.next==null){
                        {
                            if(ZPP_Set_ZPP_SimpleSeg.zpp_pool==null){
                                x=new ZPP_Set_ZPP_SimpleSeg();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleSeg.POOL_TOT++;
                                ZPP_Set_ZPP_SimpleSeg.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_SimpleSeg.zpp_pool;
                                ZPP_Set_ZPP_SimpleSeg.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleSeg.POOL_CNT--;
                                ZPP_Set_ZPP_SimpleSeg.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
                else break;
            }
        }
        if(x==null)return false;
        else{
            if(x.parent==null)x.colour=1;
            else{
                x.colour=0;
                if(x.parent.colour==0)__fix_dbl_red(x);
            }
            return true;
        }
    }
    public function try_insert(obj:ZPP_SimpleSeg){
        var x:ZPP_Set_ZPP_SimpleSeg=null;
        var cur:ZPP_Set_ZPP_SimpleSeg=null;
        if(parent==null){
            {
                if(ZPP_Set_ZPP_SimpleSeg.zpp_pool==null){
                    x=new ZPP_Set_ZPP_SimpleSeg();
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleSeg.POOL_TOT++;
                    ZPP_Set_ZPP_SimpleSeg.POOL_ADDNEW++;
                    #end
                }
                else{
                    x=ZPP_Set_ZPP_SimpleSeg.zpp_pool;
                    ZPP_Set_ZPP_SimpleSeg.zpp_pool=x.next;
                    x.next=null;
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleSeg.POOL_CNT--;
                    ZPP_Set_ZPP_SimpleSeg.POOL_ADD++;
                    #end
                }
                x.alloc();
            };
            x.data=obj;
            parent=x;
        }
        else{
            cur=parent;
            while(true){
                if(lt(obj,cur.data)){
                    if(cur.prev==null){
                        {
                            if(ZPP_Set_ZPP_SimpleSeg.zpp_pool==null){
                                x=new ZPP_Set_ZPP_SimpleSeg();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleSeg.POOL_TOT++;
                                ZPP_Set_ZPP_SimpleSeg.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_SimpleSeg.zpp_pool;
                                ZPP_Set_ZPP_SimpleSeg.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleSeg.POOL_CNT--;
                                ZPP_Set_ZPP_SimpleSeg.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else if(lt(cur.data,obj)){
                    if(cur.next==null){
                        {
                            if(ZPP_Set_ZPP_SimpleSeg.zpp_pool==null){
                                x=new ZPP_Set_ZPP_SimpleSeg();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleSeg.POOL_TOT++;
                                ZPP_Set_ZPP_SimpleSeg.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_SimpleSeg.zpp_pool;
                                ZPP_Set_ZPP_SimpleSeg.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleSeg.POOL_CNT--;
                                ZPP_Set_ZPP_SimpleSeg.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
                else break;
            }
        }
        if(x==null)return cur;
        else{
            if(x.parent==null)x.colour=1;
            else{
                x.colour=0;
                if(x.parent.colour==0)__fix_dbl_red(x);
            }
            return x;
        }
    }
    public function insert(obj:ZPP_SimpleSeg){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !has(obj);
            };
            if(!res)throw "assert("+"!has(obj)"+") :: "+("object already in set");
            #end
        };
        var x;
        {
            if(ZPP_Set_ZPP_SimpleSeg.zpp_pool==null){
                x=new ZPP_Set_ZPP_SimpleSeg();
                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleSeg.POOL_TOT++;
                ZPP_Set_ZPP_SimpleSeg.POOL_ADDNEW++;
                #end
            }
            else{
                x=ZPP_Set_ZPP_SimpleSeg.zpp_pool;
                ZPP_Set_ZPP_SimpleSeg.zpp_pool=x.next;
                x.next=null;
                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleSeg.POOL_CNT--;
                ZPP_Set_ZPP_SimpleSeg.POOL_ADD++;
                #end
            }
            x.alloc();
        };
        x.data=obj;
        if(parent==null)parent=x;
        else{
            var cur=parent;
            while(true){
                if(lt(x.data,cur.data)){
                    if(cur.prev==null){
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else{
                    if(cur.next==null){
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
            }
        }
        if(x.parent==null)x.colour=1;
        else{
            x.colour=0;
            if(x.parent.colour==0)__fix_dbl_red(x);
        }
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x.data==obj;
            };
            if(!res)throw "assert("+"x.data==obj"+") :: "+("...wtf?");
            #end
        };
        return x;
    }
}
#if nape_swc@:keep #end
class ZPP_Set_ZPP_SimpleEvent{
    static public var zpp_pool:ZPP_Set_ZPP_SimpleEvent=null;
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
    function free(){
        data=null;
        lt=null;
        swapped=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    public var lt:ZPP_SimpleEvent->ZPP_SimpleEvent->Bool=null;
    public var swapped:ZPP_SimpleEvent->ZPP_SimpleEvent->Void=null;
    public var data:ZPP_SimpleEvent=null;
    public var prev:ZPP_Set_ZPP_SimpleEvent=null;
    public var next:ZPP_Set_ZPP_SimpleEvent=null;
    public var parent:ZPP_Set_ZPP_SimpleEvent=null;
    public var colour:Int=0;
    public function new(){}
    public function verify(){
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    this!=null;
                };
                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                #end
            };
            if(!this.empty()){
                var set_ite=this.parent;
                while(set_ite.prev!=null)set_ite=set_ite.prev;
                while(set_ite!=null){
                    var i=set_ite.data;
                    {
                        var prei=true;
                        {
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    this!=null;
                                };
                                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                                #end
                            };
                            if(!this.empty()){
                                var set_ite=this.parent;
                                while(set_ite.prev!=null)set_ite=set_ite.prev;
                                while(set_ite!=null){
                                    var j=set_ite.data;
                                    {
                                        if(!prei){
                                            if(!lt(i,j)&&lt(j,i))return false;
                                        }
                                        else if(i==j)prei=false;
                                        else{
                                            if(!lt(j,i)&&lt(i,j))return false;
                                        }
                                    };
                                    if(set_ite.next!=null){
                                        set_ite=set_ite.next;
                                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                                    }
                                    else{
                                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                                        set_ite=set_ite.parent;
                                    }
                                }
                            }
                        };
                    };
                    if(set_ite.next!=null){
                        set_ite=set_ite.next;
                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                    }
                    else{
                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                        set_ite=set_ite.parent;
                    }
                }
            }
        };
        return true;
    }
    public function empty(){
        return parent==null;
    }
    public function singular(){
        return parent!=null&&parent.prev==null&&parent.next==null;
    }
    public function size(){
        var ret=0;
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    this!=null;
                };
                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                #end
            };
            if(!this.empty()){
                var set_ite=this.parent;
                while(set_ite.prev!=null)set_ite=set_ite.prev;
                while(set_ite!=null){
                    var i=set_ite.data;
                    ret++;
                    if(set_ite.next!=null){
                        set_ite=set_ite.next;
                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                    }
                    else{
                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                        set_ite=set_ite.parent;
                    }
                }
            }
        };
        return ret;
    }
    public function has(obj:ZPP_SimpleEvent){
        return find(obj)!=null;
    }
    public function find(obj:ZPP_SimpleEvent){
        var cur=parent;
        while(cur!=null&&cur.data!=obj){
            if(lt(obj,cur.data))cur=cur.prev;
            else cur=cur.next;
        }
        return cur;
    }
    public function has_weak(obj:ZPP_SimpleEvent){
        return find_weak(obj)!=null;
    }
    public function find_weak(obj:ZPP_SimpleEvent){
        var cur=parent;
        while(cur!=null){
            if(lt(obj,cur.data))cur=cur.prev;
            else if(lt(cur.data,obj))cur=cur.next;
            else break;
        }
        return cur;
    }
    public function lower_bound(obj:ZPP_SimpleEvent){
        return{
            var ret=null;
            {
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        this!=null;
                    };
                    if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                    #end
                };
                if(!this.empty()){
                    var set_ite=this.parent;
                    while(set_ite.prev!=null)set_ite=set_ite.prev;
                    while(set_ite!=null){
                        var elt=set_ite.data;
                        {
                            if(!lt(elt,obj)){
                                ret=elt;
                                break;
                            }
                        };
                        if(set_ite.next!=null){
                            set_ite=set_ite.next;
                            while(set_ite.prev!=null)set_ite=set_ite.prev;
                        }
                        else{
                            while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                            set_ite=set_ite.parent;
                        }
                    }
                }
            };
            ret;
        };
    }
    public function first(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("first in empty");
            #end
        };
        var cur=parent;
        while(cur.prev!=null)cur=cur.prev;
        return cur.data;
    }
    public function pop_front(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("pop_front in empty");
            #end
        };
        var cur=parent;
        while(cur.prev!=null)cur=cur.prev;
        var ret=cur.data;
        remove_node(cur);
        return ret;
    }
    public function remove(obj:ZPP_SimpleEvent){
        var node=find(obj);
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                node!=null;
            };
            if(!res)throw "assert("+"node!=null"+") :: "+("object not in tree");
            #end
        };
        remove_node(node);
    }
    public function successor_node(cur:ZPP_Set_ZPP_SimpleEvent){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.next!=null){
            cur=cur.next;
            while(cur.prev!=null)cur=cur.prev;
        }
        else{
            var pre=cur;
            cur=cur.parent;
            while(cur!=null&&cur.prev!=pre){
                pre=cur;
                cur=cur.parent;
            }
        }
        return cur;
    }
    public function predecessor_node(cur:ZPP_Set_ZPP_SimpleEvent){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.prev!=null){
            cur=cur.prev;
            while(cur.next!=null)cur=cur.next;
        }
        else{
            var pre=cur;
            cur=cur.parent;
            while(cur!=null&&cur.next!=pre){
                pre=cur;
                cur=cur.parent;
            }
        }
        return cur;
    }
    public function successor(obj:ZPP_SimpleEvent){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("not in tree!");
            #end
        };
        var node=successor_node(find(obj));
        return node==null?null:node.data;
    }
    public function predecessor(obj:ZPP_SimpleEvent){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("not in tree!");
            #end
        };
        var node=predecessor_node(find(obj));
        return node==null?null:node.data;
    }
    public function remove_node(cur:ZPP_Set_ZPP_SimpleEvent){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.next!=null&&cur.prev!=null){
            var sm=cur.next;
            while(sm.prev!=null)sm=sm.prev;
            {
                var t=cur.data;
                cur.data=sm.data;
                sm.data=t;
            };
            if(swapped!=null)swapped(cur.data,sm.data);
            cur=sm;
        }
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur.next==null||cur.prev==null;
            };
            if(!res)throw "assert("+"cur.next==null||cur.prev==null"+") :: "+("node still has two children??");
            #end
        };
        var child=if(cur.prev==null)cur.next else cur.prev;
        if(cur.colour==1){
            if(cur.prev!=null||cur.next!=null)child.colour=1;
            else if(cur.parent!=null){
                var parent=cur.parent;
                while(true){
                    parent.colour++;
                    parent.prev.colour--;
                    parent.next.colour--;
                    {
                        var child=parent.prev;
                        if(child.colour==(-1)){
                            __fix_neg_red(child);
                            break;
                        }
                        else if(child.colour==0){
                            {
                                if(child.prev!=null&&child.prev.colour==0){
                                    __fix_dbl_red(child.prev);
                                    break;
                                }
                            }
                            {
                                if(child.next!=null&&child.next.colour==0){
                                    __fix_dbl_red(child.next);
                                    break;
                                }
                            }
                        }
                    }
                    {
                        var child=parent.next;
                        if(child.colour==(-1)){
                            __fix_neg_red(child);
                            break;
                        }
                        else if(child.colour==0){
                            {
                                if(child.prev!=null&&child.prev.colour==0){
                                    __fix_dbl_red(child.prev);
                                    break;
                                }
                            }
                            {
                                if(child.next!=null&&child.next.colour==0){
                                    __fix_dbl_red(child.next);
                                    break;
                                }
                            }
                        }
                    }
                    if(parent.colour==2){
                        if(parent.parent==null){
                            parent.colour=1;
                        }
                        else{
                            parent=parent.parent;
                            continue;
                        }
                    }
                    break;
                }
            }
        }
        {
            var par=cur.parent;
            if(par==null){
                parent=child;
            }
            else if(par.prev==cur)par.prev=child;
            else par.next=child;
            if(child!=null)child.parent=par;
        };
        cur.parent=cur.prev=cur.next=null;
        {
            var o=cur;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_SimpleEvent"+", in obj: "+"cur"+")");
                #end
            };
            o.free();
            o.next=ZPP_Set_ZPP_SimpleEvent.zpp_pool;
            ZPP_Set_ZPP_SimpleEvent.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleEvent.POOL_CNT++;
            ZPP_Set_ZPP_SimpleEvent.POOL_SUB++;
            #end
        };
    }
    public function clear(){
        clear_with(function(_){});
    }
    public#if NAPE_NO_INLINE#else inline #end
    function clear_with(lambda:ZPP_SimpleEvent->Void){
        if(parent==null)return;
        else{
            var cur=parent;
            while(cur!=null)cur=if(cur.prev!=null)cur.prev else if(cur.next!=null)cur.next else clear_node(cur,lambda);
            parent=null;
        }
    }
    #if NAPE_NO_INLINE#else inline #end
    function clear_node(node:ZPP_Set_ZPP_SimpleEvent,lambda:ZPP_SimpleEvent->Void){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                node.next==null&&node.prev==null;
            };
            if(!res)throw "assert("+"node.next==null&&node.prev==null"+") :: "+("clear_node :: node not a leaf");
            #end
        };
        lambda(node.data);
        var ret=node.parent;
        if(ret!=null){
            if(node==ret.prev)ret.prev=null;
            else ret.next=null;
            node.parent=null;
        }
        {
            var o=node;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_SimpleEvent"+", in obj: "+"node"+")");
                #end
            };
            o.free();
            o.next=ZPP_Set_ZPP_SimpleEvent.zpp_pool;
            ZPP_Set_ZPP_SimpleEvent.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleEvent.POOL_CNT++;
            ZPP_Set_ZPP_SimpleEvent.POOL_SUB++;
            #end
        };
        return ret;
    }
    public function __fix_neg_red(negred:ZPP_Set_ZPP_SimpleEvent){
        var parent=negred.parent;
        var child=if(parent.prev==negred){
            var nl=negred.prev;
            var nr=negred.next;
            var trl=nr.prev;
            var trr=nr.next;
            nl.colour=0;
            negred.colour=parent.colour=1;
            {
                negred.next=trl;
                if(trl!=null)trl.parent=negred;
            };
            {
                var t=parent.data;
                parent.data=nr.data;
                nr.data=t;
            };
            if(swapped!=null)swapped(parent.data,nr.data);
            {
                nr.prev=trr;
                if(trr!=null)trr.parent=nr;
            };
            {
                nr.next=parent.next;
                if(parent.next!=null)parent.next.parent=nr;
            };
            {
                parent.next=nr;
                if(nr!=null)nr.parent=parent;
            };
            nl;
        };
        else{
            var nl=negred.next;
            var nr=negred.prev;
            var trl=nr.next;
            var trr=nr.prev;
            nl.colour=0;
            negred.colour=parent.colour=1;
            {
                negred.prev=trl;
                if(trl!=null)trl.parent=negred;
            };
            {
                var t=parent.data;
                parent.data=nr.data;
                nr.data=t;
            };
            if(swapped!=null)swapped(parent.data,nr.data);
            {
                nr.next=trr;
                if(trr!=null)trr.parent=nr;
            };
            {
                nr.prev=parent.prev;
                if(parent.prev!=null)parent.prev.parent=nr;
            };
            {
                parent.prev=nr;
                if(nr!=null)nr.parent=parent;
            };
            nl;
        };
        if(child.prev!=null&&child.prev.colour==0)__fix_dbl_red(child.prev);
        else if(child.next!=null&&child.next.colour==0)__fix_dbl_red(child.next);
    }
    public function __fix_dbl_red(x:ZPP_Set_ZPP_SimpleEvent){
        while(true){
            var par=x.parent;
            var g=par.parent;
            if(g==null){
                par.colour=1;
                break;
            }
            var n1:ZPP_Set_ZPP_SimpleEvent,n2:ZPP_Set_ZPP_SimpleEvent,n3:ZPP_Set_ZPP_SimpleEvent,t1:ZPP_Set_ZPP_SimpleEvent,t2:ZPP_Set_ZPP_SimpleEvent,t3:ZPP_Set_ZPP_SimpleEvent,t4:ZPP_Set_ZPP_SimpleEvent;
            if(par==g.prev){
                n3=g;
                t4=g.next;
                if(x==par.prev){
                    n1=x;
                    n2=par;
                    t1=x.prev;
                    t2=x.next;
                    t3=par.next;
                }
                else{
                    n1=par;
                    n2=x;
                    t1=par.prev;
                    t2=x.prev;
                    t3=x.next;
                }
            }
            else{
                n1=g;
                t1=g.prev;
                if(x==par.prev){
                    n2=x;
                    n3=par;
                    t2=x.prev;
                    t3=x.next;
                    t4=par.next;
                }
                else{
                    n2=par;
                    n3=x;
                    t2=par.prev;
                    t3=x.prev;
                    t4=x.next;
                }
            }
            {
                var par=g.parent;
                if(par==null){
                    parent=n2;
                }
                else if(par.prev==g)par.prev=n2;
                else par.next=n2;
                if(n2!=null)n2.parent=par;
            };
            {
                n1.prev=t1;
                if(t1!=null)t1.parent=n1;
            };
            {
                n1.next=t2;
                if(t2!=null)t2.parent=n1;
            };
            {
                n2.prev=n1;
                if(n1!=null)n1.parent=n2;
            };
            {
                n2.next=n3;
                if(n3!=null)n3.parent=n2;
            };
            {
                n3.prev=t3;
                if(t3!=null)t3.parent=n3;
            };
            {
                n3.next=t4;
                if(t4!=null)t4.parent=n3;
            };
            n2.colour=g.colour-1;
            n1.colour=1;
            n3.colour=1;
            if(n2==parent)parent.colour=1;
            else if(n2.colour==0&&n2.parent.colour==0){
                x=n2;
                continue;
            }
            break;
        }
    }
    public function try_insert_bool(obj:ZPP_SimpleEvent){
        var x:ZPP_Set_ZPP_SimpleEvent=null;
        var cur:ZPP_Set_ZPP_SimpleEvent=null;
        if(parent==null){
            {
                if(ZPP_Set_ZPP_SimpleEvent.zpp_pool==null){
                    x=new ZPP_Set_ZPP_SimpleEvent();
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleEvent.POOL_TOT++;
                    ZPP_Set_ZPP_SimpleEvent.POOL_ADDNEW++;
                    #end
                }
                else{
                    x=ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                    ZPP_Set_ZPP_SimpleEvent.zpp_pool=x.next;
                    x.next=null;
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleEvent.POOL_CNT--;
                    ZPP_Set_ZPP_SimpleEvent.POOL_ADD++;
                    #end
                }
                x.alloc();
            };
            x.data=obj;
            parent=x;
        }
        else{
            cur=parent;
            while(true){
                if(lt(obj,cur.data)){
                    if(cur.prev==null){
                        {
                            if(ZPP_Set_ZPP_SimpleEvent.zpp_pool==null){
                                x=new ZPP_Set_ZPP_SimpleEvent();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleEvent.POOL_TOT++;
                                ZPP_Set_ZPP_SimpleEvent.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                                ZPP_Set_ZPP_SimpleEvent.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleEvent.POOL_CNT--;
                                ZPP_Set_ZPP_SimpleEvent.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else if(lt(cur.data,obj)){
                    if(cur.next==null){
                        {
                            if(ZPP_Set_ZPP_SimpleEvent.zpp_pool==null){
                                x=new ZPP_Set_ZPP_SimpleEvent();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleEvent.POOL_TOT++;
                                ZPP_Set_ZPP_SimpleEvent.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                                ZPP_Set_ZPP_SimpleEvent.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleEvent.POOL_CNT--;
                                ZPP_Set_ZPP_SimpleEvent.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
                else break;
            }
        }
        if(x==null)return false;
        else{
            if(x.parent==null)x.colour=1;
            else{
                x.colour=0;
                if(x.parent.colour==0)__fix_dbl_red(x);
            }
            return true;
        }
    }
    public function try_insert(obj:ZPP_SimpleEvent){
        var x:ZPP_Set_ZPP_SimpleEvent=null;
        var cur:ZPP_Set_ZPP_SimpleEvent=null;
        if(parent==null){
            {
                if(ZPP_Set_ZPP_SimpleEvent.zpp_pool==null){
                    x=new ZPP_Set_ZPP_SimpleEvent();
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleEvent.POOL_TOT++;
                    ZPP_Set_ZPP_SimpleEvent.POOL_ADDNEW++;
                    #end
                }
                else{
                    x=ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                    ZPP_Set_ZPP_SimpleEvent.zpp_pool=x.next;
                    x.next=null;
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleEvent.POOL_CNT--;
                    ZPP_Set_ZPP_SimpleEvent.POOL_ADD++;
                    #end
                }
                x.alloc();
            };
            x.data=obj;
            parent=x;
        }
        else{
            cur=parent;
            while(true){
                if(lt(obj,cur.data)){
                    if(cur.prev==null){
                        {
                            if(ZPP_Set_ZPP_SimpleEvent.zpp_pool==null){
                                x=new ZPP_Set_ZPP_SimpleEvent();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleEvent.POOL_TOT++;
                                ZPP_Set_ZPP_SimpleEvent.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                                ZPP_Set_ZPP_SimpleEvent.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleEvent.POOL_CNT--;
                                ZPP_Set_ZPP_SimpleEvent.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else if(lt(cur.data,obj)){
                    if(cur.next==null){
                        {
                            if(ZPP_Set_ZPP_SimpleEvent.zpp_pool==null){
                                x=new ZPP_Set_ZPP_SimpleEvent();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleEvent.POOL_TOT++;
                                ZPP_Set_ZPP_SimpleEvent.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                                ZPP_Set_ZPP_SimpleEvent.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleEvent.POOL_CNT--;
                                ZPP_Set_ZPP_SimpleEvent.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
                else break;
            }
        }
        if(x==null)return cur;
        else{
            if(x.parent==null)x.colour=1;
            else{
                x.colour=0;
                if(x.parent.colour==0)__fix_dbl_red(x);
            }
            return x;
        }
    }
    public function insert(obj:ZPP_SimpleEvent){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !has(obj);
            };
            if(!res)throw "assert("+"!has(obj)"+") :: "+("object already in set");
            #end
        };
        var x;
        {
            if(ZPP_Set_ZPP_SimpleEvent.zpp_pool==null){
                x=new ZPP_Set_ZPP_SimpleEvent();
                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleEvent.POOL_TOT++;
                ZPP_Set_ZPP_SimpleEvent.POOL_ADDNEW++;
                #end
            }
            else{
                x=ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                ZPP_Set_ZPP_SimpleEvent.zpp_pool=x.next;
                x.next=null;
                #if NAPE_POOL_STATS ZPP_Set_ZPP_SimpleEvent.POOL_CNT--;
                ZPP_Set_ZPP_SimpleEvent.POOL_ADD++;
                #end
            }
            x.alloc();
        };
        x.data=obj;
        if(parent==null)parent=x;
        else{
            var cur=parent;
            while(true){
                if(lt(x.data,cur.data)){
                    if(cur.prev==null){
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else{
                    if(cur.next==null){
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
            }
        }
        if(x.parent==null)x.colour=1;
        else{
            x.colour=0;
            if(x.parent.colour==0)__fix_dbl_red(x);
        }
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x.data==obj;
            };
            if(!res)throw "assert("+"x.data==obj"+") :: "+("...wtf?");
            #end
        };
        return x;
    }
}
#if nape_swc@:keep #end
class ZPP_Set_ZPP_CbSet{
    static public var zpp_pool:ZPP_Set_ZPP_CbSet=null;
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
    function free(){
        data=null;
        lt=null;
        swapped=null;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    public var lt:ZPP_CbSet->ZPP_CbSet->Bool=null;
    public var swapped:ZPP_CbSet->ZPP_CbSet->Void=null;
    public var data:ZPP_CbSet=null;
    public var prev:ZPP_Set_ZPP_CbSet=null;
    public var next:ZPP_Set_ZPP_CbSet=null;
    public var parent:ZPP_Set_ZPP_CbSet=null;
    public var colour:Int=0;
    public function new(){}
    public function verify(){
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    this!=null;
                };
                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                #end
            };
            if(!this.empty()){
                var set_ite=this.parent;
                while(set_ite.prev!=null)set_ite=set_ite.prev;
                while(set_ite!=null){
                    var i=set_ite.data;
                    {
                        var prei=true;
                        {
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    this!=null;
                                };
                                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                                #end
                            };
                            if(!this.empty()){
                                var set_ite=this.parent;
                                while(set_ite.prev!=null)set_ite=set_ite.prev;
                                while(set_ite!=null){
                                    var j=set_ite.data;
                                    {
                                        if(!prei){
                                            if(!lt(i,j)&&lt(j,i))return false;
                                        }
                                        else if(i==j)prei=false;
                                        else{
                                            if(!lt(j,i)&&lt(i,j))return false;
                                        }
                                    };
                                    if(set_ite.next!=null){
                                        set_ite=set_ite.next;
                                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                                    }
                                    else{
                                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                                        set_ite=set_ite.parent;
                                    }
                                }
                            }
                        };
                    };
                    if(set_ite.next!=null){
                        set_ite=set_ite.next;
                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                    }
                    else{
                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                        set_ite=set_ite.parent;
                    }
                }
            }
        };
        return true;
    }
    public function empty(){
        return parent==null;
    }
    public function singular(){
        return parent!=null&&parent.prev==null&&parent.next==null;
    }
    public function size(){
        var ret=0;
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    this!=null;
                };
                if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                #end
            };
            if(!this.empty()){
                var set_ite=this.parent;
                while(set_ite.prev!=null)set_ite=set_ite.prev;
                while(set_ite!=null){
                    var i=set_ite.data;
                    ret++;
                    if(set_ite.next!=null){
                        set_ite=set_ite.next;
                        while(set_ite.prev!=null)set_ite=set_ite.prev;
                    }
                    else{
                        while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                        set_ite=set_ite.parent;
                    }
                }
            }
        };
        return ret;
    }
    public function has(obj:ZPP_CbSet){
        return find(obj)!=null;
    }
    public function find(obj:ZPP_CbSet){
        var cur=parent;
        while(cur!=null&&cur.data!=obj){
            if(lt(obj,cur.data))cur=cur.prev;
            else cur=cur.next;
        }
        return cur;
    }
    public function has_weak(obj:ZPP_CbSet){
        return find_weak(obj)!=null;
    }
    public function find_weak(obj:ZPP_CbSet){
        var cur=parent;
        while(cur!=null){
            if(lt(obj,cur.data))cur=cur.prev;
            else if(lt(cur.data,obj))cur=cur.next;
            else break;
        }
        return cur;
    }
    public function lower_bound(obj:ZPP_CbSet){
        return{
            var ret=null;
            {
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        this!=null;
                    };
                    if(!res)throw "assert("+"this!=null"+") :: "+("Iterate  null set?");
                    #end
                };
                if(!this.empty()){
                    var set_ite=this.parent;
                    while(set_ite.prev!=null)set_ite=set_ite.prev;
                    while(set_ite!=null){
                        var elt=set_ite.data;
                        {
                            if(!lt(elt,obj)){
                                ret=elt;
                                break;
                            }
                        };
                        if(set_ite.next!=null){
                            set_ite=set_ite.next;
                            while(set_ite.prev!=null)set_ite=set_ite.prev;
                        }
                        else{
                            while(set_ite.parent!=null&&set_ite==set_ite.parent.next)set_ite=set_ite.parent;
                            set_ite=set_ite.parent;
                        }
                    }
                }
            };
            ret;
        };
    }
    public function first(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("first in empty");
            #end
        };
        var cur=parent;
        while(cur.prev!=null)cur=cur.prev;
        return cur.data;
    }
    public function pop_front(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !empty();
            };
            if(!res)throw "assert("+"!empty()"+") :: "+("pop_front in empty");
            #end
        };
        var cur=parent;
        while(cur.prev!=null)cur=cur.prev;
        var ret=cur.data;
        remove_node(cur);
        return ret;
    }
    public function remove(obj:ZPP_CbSet){
        var node=find(obj);
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                node!=null;
            };
            if(!res)throw "assert("+"node!=null"+") :: "+("object not in tree");
            #end
        };
        remove_node(node);
    }
    public function successor_node(cur:ZPP_Set_ZPP_CbSet){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.next!=null){
            cur=cur.next;
            while(cur.prev!=null)cur=cur.prev;
        }
        else{
            var pre=cur;
            cur=cur.parent;
            while(cur!=null&&cur.prev!=pre){
                pre=cur;
                cur=cur.parent;
            }
        }
        return cur;
    }
    public function predecessor_node(cur:ZPP_Set_ZPP_CbSet){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.prev!=null){
            cur=cur.prev;
            while(cur.next!=null)cur=cur.next;
        }
        else{
            var pre=cur;
            cur=cur.parent;
            while(cur!=null&&cur.next!=pre){
                pre=cur;
                cur=cur.parent;
            }
        }
        return cur;
    }
    public function successor(obj:ZPP_CbSet){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("not in tree!");
            #end
        };
        var node=successor_node(find(obj));
        return node==null?null:node.data;
    }
    public function predecessor(obj:ZPP_CbSet){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                has(obj);
            };
            if(!res)throw "assert("+"has(obj)"+") :: "+("not in tree!");
            #end
        };
        var node=predecessor_node(find(obj));
        return node==null?null:node.data;
    }
    public function remove_node(cur:ZPP_Set_ZPP_CbSet){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur!=null;
            };
            if(!res)throw "assert("+"cur!=null"+") :: "+("null node");
            #end
        };
        if(cur.next!=null&&cur.prev!=null){
            var sm=cur.next;
            while(sm.prev!=null)sm=sm.prev;
            {
                var t=cur.data;
                cur.data=sm.data;
                sm.data=t;
            };
            if(swapped!=null)swapped(cur.data,sm.data);
            cur=sm;
        }
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                cur.next==null||cur.prev==null;
            };
            if(!res)throw "assert("+"cur.next==null||cur.prev==null"+") :: "+("node still has two children??");
            #end
        };
        var child=if(cur.prev==null)cur.next else cur.prev;
        if(cur.colour==1){
            if(cur.prev!=null||cur.next!=null)child.colour=1;
            else if(cur.parent!=null){
                var parent=cur.parent;
                while(true){
                    parent.colour++;
                    parent.prev.colour--;
                    parent.next.colour--;
                    {
                        var child=parent.prev;
                        if(child.colour==(-1)){
                            __fix_neg_red(child);
                            break;
                        }
                        else if(child.colour==0){
                            {
                                if(child.prev!=null&&child.prev.colour==0){
                                    __fix_dbl_red(child.prev);
                                    break;
                                }
                            }
                            {
                                if(child.next!=null&&child.next.colour==0){
                                    __fix_dbl_red(child.next);
                                    break;
                                }
                            }
                        }
                    }
                    {
                        var child=parent.next;
                        if(child.colour==(-1)){
                            __fix_neg_red(child);
                            break;
                        }
                        else if(child.colour==0){
                            {
                                if(child.prev!=null&&child.prev.colour==0){
                                    __fix_dbl_red(child.prev);
                                    break;
                                }
                            }
                            {
                                if(child.next!=null&&child.next.colour==0){
                                    __fix_dbl_red(child.next);
                                    break;
                                }
                            }
                        }
                    }
                    if(parent.colour==2){
                        if(parent.parent==null){
                            parent.colour=1;
                        }
                        else{
                            parent=parent.parent;
                            continue;
                        }
                    }
                    break;
                }
            }
        }
        {
            var par=cur.parent;
            if(par==null){
                parent=child;
            }
            else if(par.prev==cur)par.prev=child;
            else par.next=child;
            if(child!=null)child.parent=par;
        };
        cur.parent=cur.prev=cur.next=null;
        {
            var o=cur;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_CbSet"+", in obj: "+"cur"+")");
                #end
            };
            o.free();
            o.next=ZPP_Set_ZPP_CbSet.zpp_pool;
            ZPP_Set_ZPP_CbSet.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSet.POOL_CNT++;
            ZPP_Set_ZPP_CbSet.POOL_SUB++;
            #end
        };
    }
    public function clear(){
        clear_with(function(_){});
    }
    public#if NAPE_NO_INLINE#else inline #end
    function clear_with(lambda:ZPP_CbSet->Void){
        if(parent==null)return;
        else{
            var cur=parent;
            while(cur!=null)cur=if(cur.prev!=null)cur.prev else if(cur.next!=null)cur.next else clear_node(cur,lambda);
            parent=null;
        }
    }
    #if NAPE_NO_INLINE#else inline #end
    function clear_node(node:ZPP_Set_ZPP_CbSet,lambda:ZPP_CbSet->Void){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                node.next==null&&node.prev==null;
            };
            if(!res)throw "assert("+"node.next==null&&node.prev==null"+") :: "+("clear_node :: node not a leaf");
            #end
        };
        lambda(node.data);
        var ret=node.parent;
        if(ret!=null){
            if(node==ret.prev)ret.prev=null;
            else ret.next=null;
            node.parent=null;
        }
        {
            var o=node;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Set_ZPP_CbSet"+", in obj: "+"node"+")");
                #end
            };
            o.free();
            o.next=ZPP_Set_ZPP_CbSet.zpp_pool;
            ZPP_Set_ZPP_CbSet.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSet.POOL_CNT++;
            ZPP_Set_ZPP_CbSet.POOL_SUB++;
            #end
        };
        return ret;
    }
    public function __fix_neg_red(negred:ZPP_Set_ZPP_CbSet){
        var parent=negred.parent;
        var child=if(parent.prev==negred){
            var nl=negred.prev;
            var nr=negred.next;
            var trl=nr.prev;
            var trr=nr.next;
            nl.colour=0;
            negred.colour=parent.colour=1;
            {
                negred.next=trl;
                if(trl!=null)trl.parent=negred;
            };
            {
                var t=parent.data;
                parent.data=nr.data;
                nr.data=t;
            };
            if(swapped!=null)swapped(parent.data,nr.data);
            {
                nr.prev=trr;
                if(trr!=null)trr.parent=nr;
            };
            {
                nr.next=parent.next;
                if(parent.next!=null)parent.next.parent=nr;
            };
            {
                parent.next=nr;
                if(nr!=null)nr.parent=parent;
            };
            nl;
        };
        else{
            var nl=negred.next;
            var nr=negred.prev;
            var trl=nr.next;
            var trr=nr.prev;
            nl.colour=0;
            negred.colour=parent.colour=1;
            {
                negred.prev=trl;
                if(trl!=null)trl.parent=negred;
            };
            {
                var t=parent.data;
                parent.data=nr.data;
                nr.data=t;
            };
            if(swapped!=null)swapped(parent.data,nr.data);
            {
                nr.next=trr;
                if(trr!=null)trr.parent=nr;
            };
            {
                nr.prev=parent.prev;
                if(parent.prev!=null)parent.prev.parent=nr;
            };
            {
                parent.prev=nr;
                if(nr!=null)nr.parent=parent;
            };
            nl;
        };
        if(child.prev!=null&&child.prev.colour==0)__fix_dbl_red(child.prev);
        else if(child.next!=null&&child.next.colour==0)__fix_dbl_red(child.next);
    }
    public function __fix_dbl_red(x:ZPP_Set_ZPP_CbSet){
        while(true){
            var par=x.parent;
            var g=par.parent;
            if(g==null){
                par.colour=1;
                break;
            }
            var n1:ZPP_Set_ZPP_CbSet,n2:ZPP_Set_ZPP_CbSet,n3:ZPP_Set_ZPP_CbSet,t1:ZPP_Set_ZPP_CbSet,t2:ZPP_Set_ZPP_CbSet,t3:ZPP_Set_ZPP_CbSet,t4:ZPP_Set_ZPP_CbSet;
            if(par==g.prev){
                n3=g;
                t4=g.next;
                if(x==par.prev){
                    n1=x;
                    n2=par;
                    t1=x.prev;
                    t2=x.next;
                    t3=par.next;
                }
                else{
                    n1=par;
                    n2=x;
                    t1=par.prev;
                    t2=x.prev;
                    t3=x.next;
                }
            }
            else{
                n1=g;
                t1=g.prev;
                if(x==par.prev){
                    n2=x;
                    n3=par;
                    t2=x.prev;
                    t3=x.next;
                    t4=par.next;
                }
                else{
                    n2=par;
                    n3=x;
                    t2=par.prev;
                    t3=x.prev;
                    t4=x.next;
                }
            }
            {
                var par=g.parent;
                if(par==null){
                    parent=n2;
                }
                else if(par.prev==g)par.prev=n2;
                else par.next=n2;
                if(n2!=null)n2.parent=par;
            };
            {
                n1.prev=t1;
                if(t1!=null)t1.parent=n1;
            };
            {
                n1.next=t2;
                if(t2!=null)t2.parent=n1;
            };
            {
                n2.prev=n1;
                if(n1!=null)n1.parent=n2;
            };
            {
                n2.next=n3;
                if(n3!=null)n3.parent=n2;
            };
            {
                n3.prev=t3;
                if(t3!=null)t3.parent=n3;
            };
            {
                n3.next=t4;
                if(t4!=null)t4.parent=n3;
            };
            n2.colour=g.colour-1;
            n1.colour=1;
            n3.colour=1;
            if(n2==parent)parent.colour=1;
            else if(n2.colour==0&&n2.parent.colour==0){
                x=n2;
                continue;
            }
            break;
        }
    }
    public function try_insert_bool(obj:ZPP_CbSet){
        var x:ZPP_Set_ZPP_CbSet=null;
        var cur:ZPP_Set_ZPP_CbSet=null;
        if(parent==null){
            {
                if(ZPP_Set_ZPP_CbSet.zpp_pool==null){
                    x=new ZPP_Set_ZPP_CbSet();
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSet.POOL_TOT++;
                    ZPP_Set_ZPP_CbSet.POOL_ADDNEW++;
                    #end
                }
                else{
                    x=ZPP_Set_ZPP_CbSet.zpp_pool;
                    ZPP_Set_ZPP_CbSet.zpp_pool=x.next;
                    x.next=null;
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSet.POOL_CNT--;
                    ZPP_Set_ZPP_CbSet.POOL_ADD++;
                    #end
                }
                x.alloc();
            };
            x.data=obj;
            parent=x;
        }
        else{
            cur=parent;
            while(true){
                if(lt(obj,cur.data)){
                    if(cur.prev==null){
                        {
                            if(ZPP_Set_ZPP_CbSet.zpp_pool==null){
                                x=new ZPP_Set_ZPP_CbSet();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSet.POOL_TOT++;
                                ZPP_Set_ZPP_CbSet.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_CbSet.zpp_pool;
                                ZPP_Set_ZPP_CbSet.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSet.POOL_CNT--;
                                ZPP_Set_ZPP_CbSet.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else if(lt(cur.data,obj)){
                    if(cur.next==null){
                        {
                            if(ZPP_Set_ZPP_CbSet.zpp_pool==null){
                                x=new ZPP_Set_ZPP_CbSet();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSet.POOL_TOT++;
                                ZPP_Set_ZPP_CbSet.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_CbSet.zpp_pool;
                                ZPP_Set_ZPP_CbSet.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSet.POOL_CNT--;
                                ZPP_Set_ZPP_CbSet.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
                else break;
            }
        }
        if(x==null)return false;
        else{
            if(x.parent==null)x.colour=1;
            else{
                x.colour=0;
                if(x.parent.colour==0)__fix_dbl_red(x);
            }
            return true;
        }
    }
    public function try_insert(obj:ZPP_CbSet){
        var x:ZPP_Set_ZPP_CbSet=null;
        var cur:ZPP_Set_ZPP_CbSet=null;
        if(parent==null){
            {
                if(ZPP_Set_ZPP_CbSet.zpp_pool==null){
                    x=new ZPP_Set_ZPP_CbSet();
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSet.POOL_TOT++;
                    ZPP_Set_ZPP_CbSet.POOL_ADDNEW++;
                    #end
                }
                else{
                    x=ZPP_Set_ZPP_CbSet.zpp_pool;
                    ZPP_Set_ZPP_CbSet.zpp_pool=x.next;
                    x.next=null;
                    #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSet.POOL_CNT--;
                    ZPP_Set_ZPP_CbSet.POOL_ADD++;
                    #end
                }
                x.alloc();
            };
            x.data=obj;
            parent=x;
        }
        else{
            cur=parent;
            while(true){
                if(lt(obj,cur.data)){
                    if(cur.prev==null){
                        {
                            if(ZPP_Set_ZPP_CbSet.zpp_pool==null){
                                x=new ZPP_Set_ZPP_CbSet();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSet.POOL_TOT++;
                                ZPP_Set_ZPP_CbSet.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_CbSet.zpp_pool;
                                ZPP_Set_ZPP_CbSet.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSet.POOL_CNT--;
                                ZPP_Set_ZPP_CbSet.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else if(lt(cur.data,obj)){
                    if(cur.next==null){
                        {
                            if(ZPP_Set_ZPP_CbSet.zpp_pool==null){
                                x=new ZPP_Set_ZPP_CbSet();
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSet.POOL_TOT++;
                                ZPP_Set_ZPP_CbSet.POOL_ADDNEW++;
                                #end
                            }
                            else{
                                x=ZPP_Set_ZPP_CbSet.zpp_pool;
                                ZPP_Set_ZPP_CbSet.zpp_pool=x.next;
                                x.next=null;
                                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSet.POOL_CNT--;
                                ZPP_Set_ZPP_CbSet.POOL_ADD++;
                                #end
                            }
                            x.alloc();
                        };
                        x.data=obj;
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
                else break;
            }
        }
        if(x==null)return cur;
        else{
            if(x.parent==null)x.colour=1;
            else{
                x.colour=0;
                if(x.parent.colour==0)__fix_dbl_red(x);
            }
            return x;
        }
    }
    public function insert(obj:ZPP_CbSet){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !has(obj);
            };
            if(!res)throw "assert("+"!has(obj)"+") :: "+("object already in set");
            #end
        };
        var x;
        {
            if(ZPP_Set_ZPP_CbSet.zpp_pool==null){
                x=new ZPP_Set_ZPP_CbSet();
                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSet.POOL_TOT++;
                ZPP_Set_ZPP_CbSet.POOL_ADDNEW++;
                #end
            }
            else{
                x=ZPP_Set_ZPP_CbSet.zpp_pool;
                ZPP_Set_ZPP_CbSet.zpp_pool=x.next;
                x.next=null;
                #if NAPE_POOL_STATS ZPP_Set_ZPP_CbSet.POOL_CNT--;
                ZPP_Set_ZPP_CbSet.POOL_ADD++;
                #end
            }
            x.alloc();
        };
        x.data=obj;
        if(parent==null)parent=x;
        else{
            var cur=parent;
            while(true){
                if(lt(x.data,cur.data)){
                    if(cur.prev==null){
                        cur.prev=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.prev;
                }
                else{
                    if(cur.next==null){
                        cur.next=x;
                        x.parent=cur;
                        break;
                    }
                    else cur=cur.next;
                }
            }
        }
        if(x.parent==null)x.colour=1;
        else{
            x.colour=0;
            if(x.parent.colour==0)__fix_dbl_red(x);
        }
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x.data==obj;
            };
            if(!res)throw "assert("+"x.data==obj"+") :: "+("...wtf?");
            #end
        };
        return x;
    }
}
