package zpp_nape.geom;
import nape.TArray;
import nape.geom.MatMN;
#if nape_swc@:keep #end
class ZPP_MatMN{
    public var outer:MatMN=null;
    public var m:Int=0;
    public var n:Int=0;
    public var x:TArray<Float>=null;
    public function new(m:Int,n:Int){
        this.m=m;
        this.n=n;
        #if flash10 x=new flash.Vector<Float>(m*n,true);
        #else x=new Array<Float>();
        for(i in 0...(m*n)){
            x.push(0.0);
        }
        #end
    }
}
