package zpp_nape.geom;
import nape.Config;
import zpp_nape.geom.GeomPoly.ZPP_GeomVert;
import zpp_nape.geom.VecMath.ZPP_VecMath;
import zpp_nape.util.Lists.ZNPList_ZPP_GeomVert;
import zpp_nape.util.Lists.ZNPList_ZPP_PartitionVertex;
import zpp_nape.util.Lists.ZNPList_ZPP_PartitionedPoly;
import zpp_nape.util.Lists.ZNPNode_ZPP_PartitionVertex;
import zpp_nape.util.RBTree.ZPP_Set_ZPP_PartitionVertex;
#if nape_swc@:keep #end
class ZPP_PartitionVertex{
    public var id:Int=0;
    static var nextId=0;
    public var mag:Float=0;
    public var x:Float=0.0;
    public var y:Float=0.0;
    public var forced:Bool=false;
    public var diagonals:ZNPList_ZPP_PartitionVertex=null;
    public var type:Int=0;
    public var helper:ZPP_PartitionVertex=null;
    public var rightchain:Bool=false;
    static public var zpp_pool:ZPP_PartitionVertex=null;
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
    
    public var next:ZPP_PartitionVertex=null;
    public var prev:ZPP_PartitionVertex=null;
    public function new(){
        id=nextId++;
        diagonals=new ZNPList_ZPP_PartitionVertex();
    }
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    public#if NAPE_NO_INLINE#else inline #end
    function free(){
        helper=null;
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                diagonals.empty();
            };
            if(!res)throw "assert("+"diagonals.empty()"+") :: "+("non-empty diagonals");
            #end
        };
    }
    public static#if NAPE_NO_INLINE#else inline #end
    function get(x:ZPP_GeomVert){
        var ret;
        {
            if(ZPP_PartitionVertex.zpp_pool==null){
                ret=new ZPP_PartitionVertex();
                #if NAPE_POOL_STATS ZPP_PartitionVertex.POOL_TOT++;
                ZPP_PartitionVertex.POOL_ADDNEW++;
                #end
            }
            else{
                ret=ZPP_PartitionVertex.zpp_pool;
                ZPP_PartitionVertex.zpp_pool=ret.next;
                ret.next=null;
                #if NAPE_POOL_STATS ZPP_PartitionVertex.POOL_CNT--;
                ZPP_PartitionVertex.POOL_ADD++;
                #end
            }
            ret.alloc();
        };
        {
            ret.x=x.x;
            ret.y=x.y;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((ret.x!=ret.x));
                };
                if(!res)throw "assert("+"!assert_isNaN(ret.x)"+") :: "+("vec_set(in n: "+"ret."+",in x: "+"x.x"+",in y: "+"x.y"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((ret.y!=ret.y));
                };
                if(!res)throw "assert("+"!assert_isNaN(ret.y)"+") :: "+("vec_set(in n: "+"ret."+",in x: "+"x.x"+",in y: "+"x.y"+")");
                #end
            };
        };
        return ret;
    }
    public#if NAPE_NO_INLINE#else inline #end
    function copy(){
        var ret;
        {
            if(ZPP_PartitionVertex.zpp_pool==null){
                ret=new ZPP_PartitionVertex();
                #if NAPE_POOL_STATS ZPP_PartitionVertex.POOL_TOT++;
                ZPP_PartitionVertex.POOL_ADDNEW++;
                #end
            }
            else{
                ret=ZPP_PartitionVertex.zpp_pool;
                ZPP_PartitionVertex.zpp_pool=ret.next;
                ret.next=null;
                #if NAPE_POOL_STATS ZPP_PartitionVertex.POOL_CNT--;
                ZPP_PartitionVertex.POOL_ADD++;
                #end
            }
            ret.alloc();
        };
        {
            ret.x=this.x;
            ret.y=this.y;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((ret.x!=ret.x));
                };
                if(!res)throw "assert("+"!assert_isNaN(ret.x)"+") :: "+("vec_set(in n: "+"ret."+",in x: "+"this.x"+",in y: "+"this.y"+")");
                #end
            };
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((ret.y!=ret.y));
                };
                if(!res)throw "assert("+"!assert_isNaN(ret.y)"+") :: "+("vec_set(in n: "+"ret."+",in x: "+"this.x"+",in y: "+"this.y"+")");
                #end
            };
        };
        ret.forced=forced;
        return ret;
    }
    public function sort(){
        var ux:Float=0.0;
        var uy:Float=0.0;
        var vx:Float=0.0;
        var vy:Float=0.0;
        var vorient=({
            {
                ux=prev.x-this.x;
                uy=prev.y-this.y;
            };
            {
                vx=next.x-this.x;
                vy=next.y-this.y;
            };
            var ret=(vy*ux-vx*uy);
            if(ret>0)-1 else if(ret==0)0 else 1;
        });
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                vorient!=0;
            };
            if(!res)throw "assert("+"vorient!=0"+") :: "+("collinear edge on boundary of partitioned poly?");
            #end
        };
        {
            var xxlist=diagonals;
            if(!xxlist.empty()&&xxlist.begin().next!=null){
                var head:ZNPNode_ZPP_PartitionVertex=xxlist.begin();
                var tail:ZNPNode_ZPP_PartitionVertex=null;
                var left:ZNPNode_ZPP_PartitionVertex=null;
                var right:ZNPNode_ZPP_PartitionVertex=null;
                var nxt:ZNPNode_ZPP_PartitionVertex=null;
                var listSize=1;
                var numMerges:Int,leftSize:Int,rightSize:Int;
                do{
                    numMerges=0;
                    left=head;
                    tail=head=null;
                    while(left!=null){
                        numMerges++;
                        right=left;
                        leftSize=0;
                        rightSize=listSize;
                        while(right!=null&&leftSize<listSize){
                            leftSize++;
                            right=right.next;
                        }
                        while(leftSize>0||(rightSize>0&&right!=null)){
                            if(leftSize==0){
                                nxt=right;
                                right=right.next;
                                rightSize--;
                            }
                            else if(rightSize==0||right==null){
                                nxt=left;
                                left=left.next;
                                leftSize--;
                            }
                            else if(({
                                if(vorient==1){
                                    ({
                                        {
                                            ux=left.elem().x-this.x;
                                            uy=left.elem().y-this.y;
                                        };
                                        {
                                            vx=right.elem().x-this.x;
                                            vy=right.elem().y-this.y;
                                        };
                                        var ret=(vy*ux-vx*uy);
                                        if(ret>0)-1 else if(ret==0)0 else 1;
                                    })==1;
                                }
                                else{
                                    var d1=({
                                        {
                                            ux=prev.x-this.x;
                                            uy=prev.y-this.y;
                                        };
                                        {
                                            vx=left.elem().x-this.x;
                                            vy=left.elem().y-this.y;
                                        };
                                        var ret=(vy*ux-vx*uy);
                                        if(ret>0)-1 else if(ret==0)0 else 1;
                                    });
                                    var d2=({
                                        {
                                            ux=prev.x-this.x;
                                            uy=prev.y-this.y;
                                        };
                                        {
                                            vx=right.elem().x-this.x;
                                            vy=right.elem().y-this.y;
                                        };
                                        var ret=(vy*ux-vx*uy);
                                        if(ret>0)-1 else if(ret==0)0 else 1;
                                    });
                                    if(d1*d2==1||(d1*d2==0&&(d1==1||d2==1))){
                                        ({
                                            {
                                                ux=left.elem().x-this.x;
                                                uy=left.elem().y-this.y;
                                            };
                                            {
                                                vx=right.elem().x-this.x;
                                                vy=right.elem().y-this.y;
                                            };
                                            var ret=(vy*ux-vx*uy);
                                            if(ret>0)-1 else if(ret==0)0 else 1;
                                        })==1;
                                    }
                                    else if(d1==-1||d2==-1){
                                        d2==-1;
                                    }
                                    else if(d1==0&&d2==0){
                                        {
                                            ux=this.x-prev.x;
                                            uy=this.y-prev.y;
                                        };
                                        {
                                            vx=left.elem().x-this.x;
                                            vy=left.elem().y-this.y;
                                        };
                                        var d1=(ux*vx+uy*vy);
                                        {
                                            vx=right.elem().x-this.x;
                                            vy=right.elem().y-this.y;
                                        };
                                        var d2=(ux*vx+uy*vy);
                                        if(d1<0&&d2>0)true else if(d2<0&&d1>0)false else{
                                            {
                                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                                var res={
                                                    false;
                                                };
                                                if(!res)throw "assert("+"false"+") :: "+("da fuquuuququ ... ");
                                                #end
                                            };
                                            true;
                                        }
                                    }
                                    else{
                                        {
                                            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                            var res={
                                                false;
                                            };
                                            if(!res)throw "assert("+"false"+") :: "+("da fuq....");
                                            #end
                                        };
                                        true;
                                    }
                                }
                            })){
                                nxt=left;
                                left=left.next;
                                leftSize--;
                            }
                            else{
                                nxt=right;
                                right=right.next;
                                rightSize--;
                            }
                            if(tail!=null)tail.next=nxt;
                            else head=nxt;
                            tail=nxt;
                        }
                        left=right;
                    }
                    tail.next=null;
                    listSize<<=1;
                }
                while(numMerges>1);
                xxlist.setbegin(head);
            }
        };
    }
    static function rightdistance(edge:ZPP_PartitionVertex,vert:ZPP_PartitionVertex){
        var flip=edge.next.y>edge.y;
        var ux:Float=0.0;
        var uy:Float=0.0;
        {
            ux=edge.next.x-edge.x;
            uy=edge.next.y-edge.y;
        };
        var vx:Float=0.0;
        var vy:Float=0.0;
        {
            vx=vert.x-edge.x;
            vy=vert.y-edge.y;
        };
        return(flip?-1.0:1.0)*(vy*ux-vx*uy);
    }
    public static function vert_lt(edge:ZPP_PartitionVertex,vert:ZPP_PartitionVertex){
        return if(vert==edge||vert==edge.next)true else if(edge.y==edge.next.y)({
            var x=edge.x;
            var y=edge.next.x;
            x<y?x:y;
        })<=vert.x;
        else rightdistance(edge,vert)<=0.0;
    }
    public var node:ZPP_Set_ZPP_PartitionVertex=null;
    public static function edge_swap(p:ZPP_PartitionVertex,q:ZPP_PartitionVertex){
        var t=p.node;
        p.node=q.node;
        q.node=t;
    }
    public static function edge_lt(p:ZPP_PartitionVertex,q:ZPP_PartitionVertex){
        if(p==q&&p.next==q.next){
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    false;
                };
                if(!res)throw "assert("+"false"+") :: "+("Attempting to sort an edge with itself");
                #end
            };
            return false;
        }
        if(p==q.next)return!vert_lt(p,q);
        else if(q==p.next)return vert_lt(q,p);
        else if(p.y==p.next.y){
            return if(q.y==q.next.y)({
                var x=p.x;
                var y=p.next.x;
                x>y?x:y;
            })>({
                var x=q.x;
                var y=q.next.x;
                x>y?x:y;
            })else(rightdistance(q,p)>0.0||rightdistance(q,p.next)>0.0);
        }
        else{
            var qRight=rightdistance(p,q);
            var qNextRight=rightdistance(p,q.next);
            if(qRight==0&&qNextRight==0){
                return({
                    var x=p.x;
                    var y=p.next.x;
                    x>y?x:y;
                })>({
                    var x=q.x;
                    var y=q.next.x;
                    x>y?x:y;
                });
            }
            if(qRight*qNextRight>=0)return(qRight<0||qNextRight<0);
            var pRight=rightdistance(q,p);
            var pNextRight=rightdistance(q,p.next);
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    pRight!=0||pNextRight!=0;
                };
                if(!res)throw "assert("+"pRight!=0||pNextRight!=0"+") :: "+("collinear edges comparison");
                #end
            };
            if(pRight*pNextRight>=0)return(pRight>0||pNextRight>0);
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    false;
                };
                if(!res)throw "assert("+"false"+") :: "+("faaaail");
                #end
            };
            return false;
        }
    }
}
#if nape_swc@:keep #end
class ZPP_PartitionedPoly{
    public var vertices:ZPP_PartitionVertex=null;
    function eq(a:ZPP_PartitionVertex,b:ZPP_PartitionVertex){
        return ZPP_VecMath.vec_dsq(a.x,a.y,b.x,b.y)<(Config.epsilon*Config.epsilon);
    }
    public function new(?P:ZPP_GeomVert){
        init(P);
    }
    public var next:ZPP_PartitionedPoly=null;
    static public var zpp_pool:ZPP_PartitionedPoly=null;
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
    
    public#if NAPE_NO_INLINE#else inline #end
    function alloc(){}
    public#if NAPE_NO_INLINE#else inline #end
    function free(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                vertices==null;
            };
            if(!res)throw "assert("+"vertices==null"+") :: "+("freed PartitionedPoly has vertices");
            #end
        };
    }
    public function init(?P:ZPP_GeomVert){
        if(P==null)return;
        var cw=({
            ({
                {
                    #if NAPE_ASSERT if(({
                        var ret=0;
                        {
                            var F=P;
                            var L=P;
                            if(F!=null){
                                var nite=F;
                                do{
                                    var i=nite;
                                    {
                                        ret++;
                                    }
                                    nite=nite.next;
                                }
                                while(nite!=L);
                            }
                        };
                        ret;
                    })<3){
                        throw "Error: Method requires that polygon has atleast 3 vertices";
                    }
                    #end
                };
                var area=0.0;
                {
                    var F=P;
                    var L=P;
                    if(F!=null){
                        var nite=F;
                        do{
                            var v=nite;
                            {
                                {
                                    area+=v.x*(v.next.y-v.prev.y);
                                };
                            }
                            nite=nite.next;
                        }
                        while(nite!=L);
                    }
                };
                area*0.5;
            })>0.0;
        });
        var p=P;
        do{
            vertices=if(cw){
                var obj=ZPP_PartitionVertex.get(p);
                if(vertices==null)vertices=obj.prev=obj.next=obj;
                else{
                    obj.prev=vertices;
                    obj.next=vertices.next;
                    vertices.next.prev=obj;
                    vertices.next=obj;
                }
                obj;
            }
            else{
                var obj=ZPP_PartitionVertex.get(p);
                if(vertices==null)vertices=obj.prev=obj.next=obj;
                else{
                    obj.next=vertices;
                    obj.prev=vertices.prev;
                    vertices.prev.next=obj;
                    vertices.prev=obj;
                }
                obj;
            }
            vertices.forced=p.forced;
            p=p.next;
        }
        while(p!=P);
        remove_collinear_vertices();
    }
    public function remove_collinear_vertices(){
        var p=vertices;
        var skip=true;
        while(skip||p!=vertices){
            skip=false;
            if(eq(p,p.next)){
                if(p==vertices){
                    vertices=p.next;
                    skip=true;
                }
                if(p.forced)p.next.forced=true;
                p={
                    {
                        #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                        var res={
                            !(p==null);
                        };
                        if(!res)throw "assert("+"!(p==null)"+") :: "+("can't pop from empty list herpaderp");
                        #end
                    };
                    if((p!=null&&p.prev==p)){
                        p.next=p.prev=null;
                        {
                            var o=p;
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    o!=null;
                                };
                                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_PartitionVertex"+", in obj: "+"p"+")");
                                #end
                            };
                            o.free();
                            o.next=ZPP_PartitionVertex.zpp_pool;
                            ZPP_PartitionVertex.zpp_pool=o;
                            #if NAPE_POOL_STATS ZPP_PartitionVertex.POOL_CNT++;
                            ZPP_PartitionVertex.POOL_SUB++;
                            #end
                        };
                        p=null;
                    }
                    else{
                        var retnodes=p.next;
                        p.prev.next=p.next;
                        p.next.prev=p.prev;
                        p.next=p.prev=null;
                        {
                            var o=p;
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    o!=null;
                                };
                                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_PartitionVertex"+", in obj: "+"p"+")");
                                #end
                            };
                            o.free();
                            o.next=ZPP_PartitionVertex.zpp_pool;
                            ZPP_PartitionVertex.zpp_pool=o;
                            #if NAPE_POOL_STATS ZPP_PartitionVertex.POOL_CNT++;
                            ZPP_PartitionVertex.POOL_SUB++;
                            #end
                        };
                        p=null;
                        retnodes;
                    }
                };
                if(p==null){
                    vertices=null;
                    break;
                }
            }
            else p=p.next;
        }
        if(vertices==null)return true;
        var removed;
        do{
            removed=false;
            p=vertices;
            skip=true;
            while(skip||p!=vertices){
                skip=false;
                var pre=p.prev;
                var ux:Float=0.0;
                var uy:Float=0.0;
                {
                    ux=p.x-pre.x;
                    uy=p.y-pre.y;
                };
                var vx:Float=0.0;
                var vy:Float=0.0;
                {
                    vx=p.next.x-p.x;
                    vy=p.next.y-p.y;
                };
                var crs=(vy*ux-vx*uy);
                if(crs*crs>=(Config.epsilon*Config.epsilon)){
                    p=p.next;
                }
                else{
                    if(p==vertices){
                        vertices=p.next;
                        skip=true;
                    }
                    p={
                        {
                            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                            var res={
                                !(p==null);
                            };
                            if(!res)throw "assert("+"!(p==null)"+") :: "+("can't pop from empty list herpaderp");
                            #end
                        };
                        if((p!=null&&p.prev==p)){
                            p.next=p.prev=null;
                            {
                                var o=p;
                                {
                                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                    var res={
                                        o!=null;
                                    };
                                    if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_PartitionVertex"+", in obj: "+"p"+")");
                                    #end
                                };
                                o.free();
                                o.next=ZPP_PartitionVertex.zpp_pool;
                                ZPP_PartitionVertex.zpp_pool=o;
                                #if NAPE_POOL_STATS ZPP_PartitionVertex.POOL_CNT++;
                                ZPP_PartitionVertex.POOL_SUB++;
                                #end
                            };
                            p=null;
                        }
                        else{
                            var retnodes=p.next;
                            p.prev.next=p.next;
                            p.next.prev=p.prev;
                            p.next=p.prev=null;
                            {
                                var o=p;
                                {
                                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                    var res={
                                        o!=null;
                                    };
                                    if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_PartitionVertex"+", in obj: "+"p"+")");
                                    #end
                                };
                                o.free();
                                o.next=ZPP_PartitionVertex.zpp_pool;
                                ZPP_PartitionVertex.zpp_pool=o;
                                #if NAPE_POOL_STATS ZPP_PartitionVertex.POOL_CNT++;
                                ZPP_PartitionVertex.POOL_SUB++;
                                #end
                            };
                            p=null;
                            retnodes;
                        }
                    };
                    removed=true;
                    if(p==null){
                        removed=false;
                        vertices=null;
                        break;
                    }
                }
            }
        }
        while(removed);
        return(vertices==null);
    }
    public function add_diagonal(p:ZPP_PartitionVertex,q:ZPP_PartitionVertex){
        p.diagonals.add(q);
        q.diagonals.add(p);
        p.forced=q.forced=true;
    }
    public static var sharedPPList:ZNPList_ZPP_PartitionedPoly;
    public static#if NAPE_NO_INLINE#else inline #end
    function getSharedPP(){
        if(sharedPPList==null)sharedPPList=new ZNPList_ZPP_PartitionedPoly();
        return sharedPPList;
    }
    public function extract_partitions(?ret:ZNPList_ZPP_PartitionedPoly){
        if(ret==null)ret=new ZNPList_ZPP_PartitionedPoly();
        if(vertices!=null){
            {
                var F=vertices;
                var L=vertices;
                if(F!=null){
                    var nite=F;
                    do{
                        var c=nite;
                        {
                            c.sort();
                        }
                        nite=nite.next;
                    }
                    while(nite!=L);
                }
            };
            pull_partitions(vertices,ret);
            {
                while(!(vertices==null))vertices={
                    {
                        #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                        var res={
                            !(vertices==null);
                        };
                        if(!res)throw "assert("+"!(vertices==null)"+") :: "+("can't pop from empty list herpaderp");
                        #end
                    };
                    if((vertices!=null&&vertices.prev==vertices)){
                        vertices.next=vertices.prev=null;
                        {
                            var o=vertices;
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    o!=null;
                                };
                                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_PartitionVertex"+", in obj: "+"vertices"+")");
                                #end
                            };
                            o.free();
                            o.next=ZPP_PartitionVertex.zpp_pool;
                            ZPP_PartitionVertex.zpp_pool=o;
                            #if NAPE_POOL_STATS ZPP_PartitionVertex.POOL_CNT++;
                            ZPP_PartitionVertex.POOL_SUB++;
                            #end
                        };
                        vertices=null;
                    }
                    else{
                        var retnodes=vertices.next;
                        vertices.prev.next=vertices.next;
                        vertices.next.prev=vertices.prev;
                        vertices.next=vertices.prev=null;
                        {
                            var o=vertices;
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    o!=null;
                                };
                                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_PartitionVertex"+", in obj: "+"vertices"+")");
                                #end
                            };
                            o.free();
                            o.next=ZPP_PartitionVertex.zpp_pool;
                            ZPP_PartitionVertex.zpp_pool=o;
                            #if NAPE_POOL_STATS ZPP_PartitionVertex.POOL_CNT++;
                            ZPP_PartitionVertex.POOL_SUB++;
                            #end
                        };
                        vertices=null;
                        retnodes;
                    }
                }
            };
            var pre=null;
            {
                var cx_ite=ret.begin();
                while(cx_ite!=null){
                    var p=cx_ite.elem();
                    {
                        if(p.remove_collinear_vertices()){
                            ret.erase(pre);
                            continue;
                        }
                        pre=cx_ite;
                    };
                    cx_ite=cx_ite.next;
                }
            }
        }
        return ret;
    }
    private function pull_partitions(start:ZPP_PartitionVertex,ret:ZNPList_ZPP_PartitionedPoly){
        var poly;
        {
            if(ZPP_PartitionedPoly.zpp_pool==null){
                poly=new ZPP_PartitionedPoly();
                #if NAPE_POOL_STATS ZPP_PartitionedPoly.POOL_TOT++;
                ZPP_PartitionedPoly.POOL_ADDNEW++;
                #end
            }
            else{
                poly=ZPP_PartitionedPoly.zpp_pool;
                ZPP_PartitionedPoly.zpp_pool=poly.next;
                poly.next=null;
                #if NAPE_POOL_STATS ZPP_PartitionedPoly.POOL_CNT--;
                ZPP_PartitionedPoly.POOL_ADD++;
                #end
            }
            poly.alloc();
        };
        var next=start;
        do{
            poly.vertices={
                var obj=next.copy();
                if(poly.vertices==null)poly.vertices=obj.prev=obj.next=obj;
                else{
                    obj.prev=poly.vertices;
                    obj.next=poly.vertices.next;
                    poly.vertices.next.prev=obj;
                    poly.vertices.next=obj;
                }
                obj;
            };
            poly.vertices.forced=next.forced;
            if(!next.diagonals.empty()){
                var diag=next.diagonals.inlined_pop_unsafe();
                if(diag==start)break;
                else next=pull_partitions(next,ret);
            }
            else next=next.next;
        }
        while(next!=start);
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                ({
                    ({
                        {
                            #if NAPE_ASSERT if(({
                                var ret=0;
                                {
                                    var F=poly.vertices;
                                    var L=poly.vertices;
                                    if(F!=null){
                                        var nite=F;
                                        do{
                                            var i=nite;
                                            {
                                                ret++;
                                            }
                                            nite=nite.next;
                                        }
                                        while(nite!=L);
                                    }
                                };
                                ret;
                            })<3){
                                throw "Error: Method requires that polygon has atleast 3 vertices";
                            }
                            #end
                        };
                        var area=0.0;
                        {
                            var F=poly.vertices;
                            var L=poly.vertices;
                            if(F!=null){
                                var nite=F;
                                do{
                                    var v=nite;
                                    {
                                        {
                                            area+=v.x*(v.next.y-v.prev.y);
                                        };
                                    }
                                    nite=nite.next;
                                }
                                while(nite!=L);
                            }
                        };
                        area*0.5;
                    })>0.0;
                });
            };
            if(!res)throw "assert("+"({({{#if NAPE_ASSERT if(({var ret=0;{var F=poly.vertices;var L=poly.vertices;if(F!=null){var nite=F;do{var i=nite;{ret++;}nite=nite.next;}while(nite!=L);}};ret;})<3){throw \"Error: Method requires that polygon has atleast 3 vertices\";}#end};var area=0.0;{var F=poly.vertices;var L=poly.vertices;if(F!=null){var nite=F;do{var v=nite;{{area+=v.x*(v.next.y-v.prev.y);};}nite=nite.next;}while(nite!=L);}};area*0.5;})>0.0;})"+") :: "+("out poly is not convex :(");
            #end
        };
        if(({
            {
                #if NAPE_ASSERT if(({
                    var ret=0;
                    {
                        var F=poly.vertices;
                        var L=poly.vertices;
                        if(F!=null){
                            var nite=F;
                            do{
                                var i=nite;
                                {
                                    ret++;
                                }
                                nite=nite.next;
                            }
                            while(nite!=L);
                        }
                    };
                    ret;
                })<3){
                    throw "Error: Method requires that polygon has atleast 3 vertices";
                }
                #end
            };
            var area=0.0;
            {
                var F=poly.vertices;
                var L=poly.vertices;
                if(F!=null){
                    var nite=F;
                    do{
                        var v=nite;
                        {
                            {
                                area+=v.x*(v.next.y-v.prev.y);
                            };
                        }
                        nite=nite.next;
                    }
                    while(nite!=L);
                }
            };
            area*0.5;
        })!=0)ret.add(poly);
        return next;
    }
    public static var sharedGVList:ZNPList_ZPP_GeomVert;
    public static#if NAPE_NO_INLINE#else inline #end
    function getShared(){
        if(sharedGVList==null)sharedGVList=new ZNPList_ZPP_GeomVert();
        return sharedGVList;
    }
    public function extract(?ret:ZNPList_ZPP_GeomVert){
        if(ret==null)ret=new ZNPList_ZPP_GeomVert();
        if(vertices!=null){
            {
                var F=vertices;
                var L=vertices;
                if(F!=null){
                    var nite=F;
                    do{
                        var c=nite;
                        {
                            c.sort();
                        }
                        nite=nite.next;
                    }
                    while(nite!=L);
                }
            };
            pull(vertices,ret);
            {
                while(!(vertices==null))vertices={
                    {
                        #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                        var res={
                            !(vertices==null);
                        };
                        if(!res)throw "assert("+"!(vertices==null)"+") :: "+("can't pop from empty list herpaderp");
                        #end
                    };
                    if((vertices!=null&&vertices.prev==vertices)){
                        vertices.next=vertices.prev=null;
                        {
                            var o=vertices;
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    o!=null;
                                };
                                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_PartitionVertex"+", in obj: "+"vertices"+")");
                                #end
                            };
                            o.free();
                            o.next=ZPP_PartitionVertex.zpp_pool;
                            ZPP_PartitionVertex.zpp_pool=o;
                            #if NAPE_POOL_STATS ZPP_PartitionVertex.POOL_CNT++;
                            ZPP_PartitionVertex.POOL_SUB++;
                            #end
                        };
                        vertices=null;
                    }
                    else{
                        var retnodes=vertices.next;
                        vertices.prev.next=vertices.next;
                        vertices.next.prev=vertices.prev;
                        vertices.next=vertices.prev=null;
                        {
                            var o=vertices;
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    o!=null;
                                };
                                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_PartitionVertex"+", in obj: "+"vertices"+")");
                                #end
                            };
                            o.free();
                            o.next=ZPP_PartitionVertex.zpp_pool;
                            ZPP_PartitionVertex.zpp_pool=o;
                            #if NAPE_POOL_STATS ZPP_PartitionVertex.POOL_CNT++;
                            ZPP_PartitionVertex.POOL_SUB++;
                            #end
                        };
                        vertices=null;
                        retnodes;
                    }
                }
            };
        }
        return ret;
    }
    private function pull(start:ZPP_PartitionVertex,ret:ZNPList_ZPP_GeomVert){
        var poly:ZPP_GeomVert=null;
        var next=start;
        do{
            poly={
                var obj=ZPP_GeomVert.get(next.x,next.y);
                if(poly==null)poly=obj.prev=obj.next=obj;
                else{
                    obj.prev=poly;
                    obj.next=poly.next;
                    poly.next.prev=obj;
                    poly.next=obj;
                }
                obj;
            };
            poly.forced=next.forced;
            if(!next.diagonals.empty()){
                var diag=next.diagonals.inlined_pop_unsafe();
                if(diag==start){
                    break;
                }
                else next=pull(next,ret);
            }
            else next=next.next;
        }
        while(next!=start);
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                ({
                    ({
                        {
                            #if NAPE_ASSERT if(({
                                var ret=0;
                                {
                                    var F=poly;
                                    var L=poly;
                                    if(F!=null){
                                        var nite=F;
                                        do{
                                            var i=nite;
                                            {
                                                ret++;
                                            }
                                            nite=nite.next;
                                        }
                                        while(nite!=L);
                                    }
                                };
                                ret;
                            })<3){
                                throw "Error: Method requires that polygon has atleast 3 vertices";
                            }
                            #end
                        };
                        var area=0.0;
                        {
                            var F=poly;
                            var L=poly;
                            if(F!=null){
                                var nite=F;
                                do{
                                    var v=nite;
                                    {
                                        {
                                            area+=v.x*(v.next.y-v.prev.y);
                                        };
                                    }
                                    nite=nite.next;
                                }
                                while(nite!=L);
                            }
                        };
                        area*0.5;
                    })>0.0;
                });
            };
            if(!res)throw "assert("+"({({{#if NAPE_ASSERT if(({var ret=0;{var F=poly;var L=poly;if(F!=null){var nite=F;do{var i=nite;{ret++;}nite=nite.next;}while(nite!=L);}};ret;})<3){throw \"Error: Method requires that polygon has atleast 3 vertices\";}#end};var area=0.0;{var F=poly;var L=poly;if(F!=null){var nite=F;do{var v=nite;{{area+=v.x*(v.next.y-v.prev.y);};}nite=nite.next;}while(nite!=L);}};area*0.5;})>0.0;})"+") :: "+("out poly is not convex :(");
            #end
        };
        var area=({
            {
                #if NAPE_ASSERT if(({
                    var ret=0;
                    {
                        var F=poly;
                        var L=poly;
                        if(F!=null){
                            var nite=F;
                            do{
                                var i=nite;
                                {
                                    ret++;
                                }
                                nite=nite.next;
                            }
                            while(nite!=L);
                        }
                    };
                    ret;
                })<3){
                    throw "Error: Method requires that polygon has atleast 3 vertices";
                }
                #end
            };
            var area=0.0;
            {
                var F=poly;
                var L=poly;
                if(F!=null){
                    var nite=F;
                    do{
                        var v=nite;
                        {
                            {
                                area+=v.x*(v.next.y-v.prev.y);
                            };
                        }
                        nite=nite.next;
                    }
                    while(nite!=L);
                }
            };
            area*0.5;
        });
        if(area*area>=(Config.epsilon*Config.epsilon)){
            if(!({
                var p=poly;
                var skip=true;
                while(skip||p!=poly){
                    skip=false;
                    if(ZPP_VecMath.vec_dsq(p.x,p.y,p.next.x,p.next.y)<(Config.epsilon*Config.epsilon)){
                        if(p==poly){
                            poly=p.next;
                            skip=true;
                        }
                        if(p.forced)p.next.forced=true;
                        p={
                            {
                                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                var res={
                                    !(p==null);
                                };
                                if(!res)throw "assert("+"!(p==null)"+") :: "+("can't pop from empty list herpaderp");
                                #end
                            };
                            if((p!=null&&p.prev==p)){
                                p.next=p.prev=null;
                                {};
                                p=null;
                            }
                            else{
                                var retnodes=p.next;
                                p.prev.next=p.next;
                                p.next.prev=p.prev;
                                p.next=p.prev=null;
                                {};
                                p=null;
                                retnodes;
                            }
                        };
                        if(p==null){
                            poly=null;
                            break;
                        }
                    }
                    else p=p.next;
                }
                if(poly!=null){
                    var removed;
                    do{
                        removed=false;
                        p=poly;
                        skip=true;
                        while(skip||p!=poly){
                            skip=false;
                            var pre=p.prev;
                            var ux:Float=0.0;
                            var uy:Float=0.0;
                            {
                                ux=p.x-pre.x;
                                uy=p.y-pre.y;
                            };
                            var vx:Float=0.0;
                            var vy:Float=0.0;
                            {
                                vx=p.next.x-p.x;
                                vy=p.next.y-p.y;
                            };
                            var crs=(vy*ux-vx*uy);
                            if(crs*crs>=(Config.epsilon*Config.epsilon)){
                                p=p.next;
                            }
                            else{
                                if(p==poly){
                                    poly=p.next;
                                    skip=true;
                                }
                                p={
                                    {
                                        #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                                        var res={
                                            !(p==null);
                                        };
                                        if(!res)throw "assert("+"!(p==null)"+") :: "+("can't pop from empty list herpaderp");
                                        #end
                                    };
                                    if((p!=null&&p.prev==p)){
                                        p.next=p.prev=null;
                                        {};
                                        p=null;
                                    }
                                    else{
                                        var retnodes=p.next;
                                        p.prev.next=p.next;
                                        p.next.prev=p.prev;
                                        p.next=p.prev=null;
                                        {};
                                        p=null;
                                        retnodes;
                                    }
                                };
                                removed=true;
                                if(p==null){
                                    removed=false;
                                    poly=null;
                                    break;
                                }
                            }
                        }
                    }
                    while(removed);
                }
                (poly==null);
            })){
                ret.add(poly);
            }
        }
        return next;
    }
}
