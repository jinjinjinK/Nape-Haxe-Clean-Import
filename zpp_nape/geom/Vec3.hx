package zpp_nape.geom;
import nape.geom.Vec3;
#if nape_swc@:keep #end
class ZPP_Vec3{
    public var outer:Vec3=null;
    public var x:Float=0.0;
    public var y:Float=0.0;
    public var z:Float=0.0;
    public var immutable:Bool=false;
    public var _validate:Null<Void->Void>=null;
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function validate():Void{
        if(_validate!=null){
            _validate();
        }
    }
    public function new(){
        immutable=false;
        _validate=null;
    }
}
