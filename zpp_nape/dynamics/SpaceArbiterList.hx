package zpp_nape.dynamics;
import nape.dynamics.Arbiter;
import nape.dynamics.ArbiterList;
import zpp_nape.dynamics.Arbiter;
import zpp_nape.space.Space.ZPP_Space;
import zpp_nape.util.Lists.ZNPNode_ZPP_ColArbiter;
import zpp_nape.util.Lists.ZNPNode_ZPP_FluidArbiter;
import zpp_nape.util.Lists.ZNPNode_ZPP_SensorArbiter;
#if nape_swc@:keep #end
class ZPP_SpaceArbiterList extends ArbiterList{
    public var space:ZPP_Space=null;
    public var _length:Int=0;
    public var zip_length:Bool=false;
    public function new(){
        super();
        at_index_0=0;
        at_index_1=0;
        at_index_2=0;
        at_index_3=0;
        zip_length=true;
        _length=0;
        lengths=new Array<Int>();
        for(i in 0...4)lengths.push(0);
    }
    public override function zpp_gl(){
        zpp_vm();
        if(zip_length){
            _length=0;
            var ind=0;
            {
                {
                    var len=0;
                    {
                        var cx_ite=space.c_arbiters_true.begin();
                        while(cx_ite!=null){
                            var i=cx_ite.elem();
                            if(i.active)len++;
                            cx_ite=cx_ite.next;
                        }
                    };
                    lengths[ind++]=len;
                    _length+=len;
                };
                {
                    var len=0;
                    {
                        var cx_ite=space.c_arbiters_false.begin();
                        while(cx_ite!=null){
                            var i=cx_ite.elem();
                            if(i.active)len++;
                            cx_ite=cx_ite.next;
                        }
                    };
                    lengths[ind++]=len;
                    _length+=len;
                };
                {
                    var len=0;
                    {
                        var cx_ite=space.f_arbiters.begin();
                        while(cx_ite!=null){
                            var i=cx_ite.elem();
                            if(i.active)len++;
                            cx_ite=cx_ite.next;
                        }
                    };
                    lengths[ind++]=len;
                    _length+=len;
                };
                {
                    var len=0;
                    {
                        var cx_ite=space.s_arbiters.begin();
                        while(cx_ite!=null){
                            var i=cx_ite.elem();
                            if(i.active)len++;
                            cx_ite=cx_ite.next;
                        }
                    };
                    lengths[ind++]=len;
                    _length+=len;
                };
            };
            zip_length=false;
        }
        return _length;
    }
    public var lengths:Array<Int>=null;
    public var ite_0:ZNPNode_ZPP_ColArbiter=null;
    public var ite_1:ZNPNode_ZPP_ColArbiter=null;
    public var ite_2:ZNPNode_ZPP_FluidArbiter=null;
    public var ite_3:ZNPNode_ZPP_SensorArbiter=null;
    public var at_index_0:Int=0;
    public var at_index_1:Int=0;
    public var at_index_2:Int=0;
    public var at_index_3:Int=0;
    public override function zpp_vm(){
        var modified=false;
        {
            if(space.c_arbiters_true.modified){
                modified=true;
                space.c_arbiters_true.modified=false;
            };
            if(space.c_arbiters_false.modified){
                modified=true;
                space.c_arbiters_false.modified=false;
            };
            if(space.f_arbiters.modified){
                modified=true;
                space.f_arbiters.modified=false;
            };
            if(space.s_arbiters.modified){
                modified=true;
                space.s_arbiters.modified=false;
            };
        };
        if(modified){
            zip_length=true;
            _length=0;
            ite_0=null;
            ite_1=null;
            ite_2=null;
            ite_3=null;
        }
    }
    public override function push(obj:Arbiter):Bool{
        #if(!NAPE_RELEASE_BUILD)
        throw "Error: ArbiterList is immutable";
        #end
        return false;
    }
    public override function pop():Arbiter{
        #if(!NAPE_RELEASE_BUILD)
        throw "Error: ArbiterList is immutable";
        #end
        return null;
    }
    public override function unshift(obj:Arbiter):Bool{
        #if(!NAPE_RELEASE_BUILD)
        throw "Error: ArbiterList is immutable";
        #end
        return false;
    }
    public override function shift():Arbiter{
        #if(!NAPE_RELEASE_BUILD)
        throw "Error: ArbiterList is immutable";
        #end
        return null;
    }
    public override function remove(obj:Arbiter):Bool{
        #if(!NAPE_RELEASE_BUILD)
        throw "Error: ArbiterList is immutable";
        #end
        return false;
    }
    public override function clear(){
        #if(!NAPE_RELEASE_BUILD)
        throw "Error: ArbiterList is immutable";
        #end
    }
    public override function at(index:Int):Arbiter{
        zpp_vm();
        #if(!NAPE_RELEASE_BUILD)
        if(index<0||index>=length)throw "Error: Index out of bounds";
        #end
        var ret:Arbiter=null;
        var accum_length=0;
        
        if(ret==null){
            if(index<accum_length+lengths[0]){
                var offset=index-accum_length;
                if(offset<at_index_0||ite_0==null){
                    at_index_0=0;
                    ite_0=space.c_arbiters_true.begin();
                    while(true){
                        var x=ite_0.elem();
                        if(x.active)break;
                        ite_0=ite_0.next;
                    }
                }
                while(at_index_0!=offset){
                    at_index_0++;
                    ite_0=ite_0.next;
                    while(true){
                        var x=ite_0.elem();
                        if(x.active)break;
                        ite_0=ite_0.next;
                    }
                }
                ret=ite_0.elem().wrapper();
            }
            else accum_length+=lengths[0];
        }
        if(ret==null){
            if(index<accum_length+lengths[1]){
                var offset=index-accum_length;
                if(offset<at_index_1||ite_1==null){
                    at_index_1=0;
                    ite_1=space.c_arbiters_false.begin();
                    while(true){
                        var x=ite_1.elem();
                        if(x.active)break;
                        ite_1=ite_1.next;
                    }
                }
                while(at_index_1!=offset){
                    at_index_1++;
                    ite_1=ite_1.next;
                    while(true){
                        var x=ite_1.elem();
                        if(x.active)break;
                        ite_1=ite_1.next;
                    }
                }
                ret=ite_1.elem().wrapper();
            }
            else accum_length+=lengths[1];
        }
        if(ret==null){
            if(index<accum_length+lengths[2]){
                var offset=index-accum_length;
                if(offset<at_index_2||ite_2==null){
                    at_index_2=0;
                    ite_2=space.f_arbiters.begin();
                    while(true){
                        var x=ite_2.elem();
                        if(x.active)break;
                        ite_2=ite_2.next;
                    }
                }
                while(at_index_2!=offset){
                    at_index_2++;
                    ite_2=ite_2.next;
                    while(true){
                        var x=ite_2.elem();
                        if(x.active)break;
                        ite_2=ite_2.next;
                    }
                }
                ret=ite_2.elem().wrapper();
            }
            else accum_length+=lengths[2];
        }
        if(ret==null){
            if(index<accum_length+lengths[3]){
                var offset=index-accum_length;
                if(offset<at_index_3||ite_3==null){
                    at_index_3=0;
                    ite_3=space.s_arbiters.begin();
                    while(true){
                        var x=ite_3.elem();
                        if(x.active)break;
                        ite_3=ite_3.next;
                    }
                }
                while(at_index_3!=offset){
                    at_index_3++;
                    ite_3=ite_3.next;
                    while(true){
                        var x=ite_3.elem();
                        if(x.active)break;
                        ite_3=ite_3.next;
                    }
                }
                ret=ite_3.elem().wrapper();
            }
            else accum_length+=lengths[3];
        }
        return ret;
    }
}
