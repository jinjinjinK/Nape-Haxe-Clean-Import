package zpp_nape.geom;
import zpp_nape.geom.PartitionedPoly.ZPP_PartitionVertex;
import zpp_nape.geom.PartitionedPoly.ZPP_PartitionedPoly;
#if nape_swc@:keep #end
class ZPP_Convex{
    static function isinner(a:ZPP_PartitionVertex,b:ZPP_PartitionVertex,c:ZPP_PartitionVertex){
        var ux:Float=0.0;
        var uy:Float=0.0;
        {
            ux=a.x-b.x;
            uy=a.y-b.y;
        };
        var vx:Float=0.0;
        var vy:Float=0.0;
        {
            vx=c.x-b.x;
            vy=c.y-b.y;
        };
        return(vy*ux-vx*uy)>=0;
    }
    public static function optimise(P:ZPP_PartitionedPoly){
        {
            var F=P.vertices;
            var L=P.vertices;
            if(F!=null){
                var nite=F;
                do{
                    var p=nite;
                    {
                        p.sort();
                    }
                    nite=nite.next;
                }
                while(nite!=L);
            }
        };
        {
            var F=P.vertices;
            var L=P.vertices;
            if(F!=null){
                var nite=F;
                do{
                    var p=nite;
                    {
                        {
                            var pright=p.prev;
                            var ppre=null;
                            {
                                var cx_ite=p.diagonals.begin();
                                while(cx_ite!=null){
                                    var pdiag=cx_ite.elem();
                                    {
                                        var pleft=if(cx_ite.next==null)p.next else cx_ite.next.elem();
                                        if(!isinner(pleft,p,pright)){
                                            ppre=cx_ite;
                                            pright=pdiag;
                                            {
                                                cx_ite=cx_ite.next;
                                                continue;
                                            };
                                        }
                                        var removable=true;
                                        var q=pdiag;
                                        var qright=q.prev;
                                        var qpre=null;
                                        {
                                            var cx_ite=q.diagonals.begin();
                                            while(cx_ite!=null){
                                                var qdiag=cx_ite.elem();
                                                {
                                                    if(qdiag==p){
                                                        var qleft=if(cx_ite.next==null)q.next else cx_ite.next.elem();
                                                        removable=isinner(qleft,q,qright);
                                                        break;
                                                    }
                                                    qright=qdiag;
                                                    qpre=cx_ite;
                                                };
                                                cx_ite=cx_ite.next;
                                            }
                                        };
                                        if(removable){
                                            cx_ite=p.diagonals.erase(ppre);
                                            q.diagonals.erase(qpre);
                                            continue;
                                        }
                                        pright=pdiag;
                                        ppre=cx_ite;
                                    };
                                    cx_ite=cx_ite.next;
                                }
                            };
                        };
                    }
                    nite=nite.next;
                }
                while(nite!=L);
            }
        };
    }
}
