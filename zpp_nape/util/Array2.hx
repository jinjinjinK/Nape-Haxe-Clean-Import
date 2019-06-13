package zpp_nape.util;
import nape.TArray;
import zpp_nape.geom.GeomPoly.ZPP_GeomVert;
import zpp_nape.geom.MarchingSquares.ZPP_MarchPair;

#if nape_swc@:keep #end
class ZNPArray2_Float{
    public var list:TArray<Float>=null;
    public var width:Int=0;
    #if NAPE_ASSERT public var height:Int=0;
    #end
    #if flash10 public var total:Int=0;
    #end
    public function new(width:Int,height:Int){
        this.width=width;
        #if NAPE_ASSERT this.height=height;
        #end
        #if flash10 total=width*height;
        list=new flash.Vector<Float>(total,true);
        #else list=new Array<Float>();
        #end
    }
    public function resize(width:Int,height:Int,def:Float){
        #if flash10 var total=width*height;
        if(total>this.total){
            for(i in 0...this.total){
                list[i]=def;
            }
            list=new flash.Vector<Float>(this.total=total,true);
        }
        #end
        this.width=width;
        #if NAPE_ASSERT this.height=height;
        #end
        for(i in 0...width*height){
            list[i]=def;
        }
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function get(x:Int,y:Int){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x>=0&&x<width&&y>=0&&y<height;
            };
            if(!res)throw "assert("+"x>=0&&x<width&&y>=0&&y<height"+") :: "+("out of bounds Array");
            #end
        };
        return list[y*width+x];
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function set(x:Int,y:Int,obj:Float){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x>=0&&x<width&&y>=0&&y<height;
            };
            if(!res)throw "assert("+"x>=0&&x<width&&y>=0&&y<height"+") :: "+("out of bounds Array");
            #end
        };
        return list[y*width+x]=obj;
    }
}
#if nape_swc@:keep #end
class ZNPArray2_ZPP_GeomVert{
    public var list:TArray<ZPP_GeomVert>=null;
    public var width:Int=0;
    #if NAPE_ASSERT public var height:Int=0;
    #end
    #if flash10 public var total:Int=0;
    #end
    public function new(width:Int,height:Int){
        this.width=width;
        #if NAPE_ASSERT this.height=height;
        #end
        #if flash10 total=width*height;
        list=new flash.Vector<ZPP_GeomVert>(total,true);
        #else list=new Array<ZPP_GeomVert>();
        #end
    }
    public function resize(width:Int,height:Int,def:ZPP_GeomVert){
        #if flash10 var total=width*height;
        if(total>this.total){
            for(i in 0...this.total){
                list[i]=def;
            }
            list=new flash.Vector<ZPP_GeomVert>(this.total=total,true);
        }
        #end
        this.width=width;
        #if NAPE_ASSERT this.height=height;
        #end
        for(i in 0...width*height){
            list[i]=def;
        }
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function get(x:Int,y:Int){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x>=0&&x<width&&y>=0&&y<height;
            };
            if(!res)throw "assert("+"x>=0&&x<width&&y>=0&&y<height"+") :: "+("out of bounds Array");
            #end
        };
        return list[y*width+x];
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function set(x:Int,y:Int,obj:ZPP_GeomVert){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x>=0&&x<width&&y>=0&&y<height;
            };
            if(!res)throw "assert("+"x>=0&&x<width&&y>=0&&y<height"+") :: "+("out of bounds Array");
            #end
        };
        return list[y*width+x]=obj;
    }
}
#if nape_swc@:keep #end
class ZNPArray2_ZPP_MarchPair{
    public var list:TArray<ZPP_MarchPair>=null;
    public var width:Int=0;
    #if NAPE_ASSERT public var height:Int=0;
    #end
    #if flash10 public var total:Int=0;
    #end
    public function new(width:Int,height:Int){
        this.width=width;
        #if NAPE_ASSERT this.height=height;
        #end
        #if flash10 total=width*height;
        list=new flash.Vector<ZPP_MarchPair>(total,true);
        #else list=new Array<ZPP_MarchPair>();
        #end
    }
    public function resize(width:Int,height:Int,def:ZPP_MarchPair){
        #if flash10 var total=width*height;
        if(total>this.total){
            for(i in 0...this.total){
                list[i]=def;
            }
            list=new flash.Vector<ZPP_MarchPair>(this.total=total,true);
        }
        #end
        this.width=width;
        #if NAPE_ASSERT this.height=height;
        #end
        for(i in 0...width*height){
            list[i]=def;
        }
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function get(x:Int,y:Int){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x>=0&&x<width&&y>=0&&y<height;
            };
            if(!res)throw "assert("+"x>=0&&x<width&&y>=0&&y<height"+") :: "+("out of bounds Array");
            #end
        };
        return list[y*width+x];
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function set(x:Int,y:Int,obj:ZPP_MarchPair){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                x>=0&&x<width&&y>=0&&y<height;
            };
            if(!res)throw "assert("+"x>=0&&x<width&&y>=0&&y<height"+") :: "+("out of bounds Array");
            #end
        };
        return list[y*width+x]=obj;
    }
}
