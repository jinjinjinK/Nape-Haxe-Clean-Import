package zpp_nape.callbacks;
import nape.callbacks.CbType;
import nape.callbacks.CbTypeList;
import nape.callbacks.OptionType;
import zpp_nape.callbacks.CbType;
import zpp_nape.util.Lists.ZNPList_ZPP_CbType;
import zpp_nape.util.Lists.ZPP_CbTypeList;
#if nape_swc@:keep #end
class ZPP_OptionType{
    public var outer:OptionType=null;
    public var handler:Null<ZPP_CbType->Bool->Bool->Void>=null;
    public var includes:ZNPList_ZPP_CbType=null;
    public var excludes:ZNPList_ZPP_CbType=null;
    public function new(){
        includes=new ZNPList_ZPP_CbType();
        excludes=new ZNPList_ZPP_CbType();
    }
    public var wrap_includes:CbTypeList=null;
    public var wrap_excludes:CbTypeList=null;
    public function setup_includes():Void{
        wrap_includes=ZPP_CbTypeList.get(includes,true);
    }
    public function setup_excludes():Void{
        wrap_excludes=ZPP_CbTypeList.get(excludes,true);
    }
    public#if NAPE_NO_INLINE#else inline #end
    function excluded(xs:ZNPList_ZPP_CbType):Bool{
        return nonemptyintersection(xs,excludes);
    }
    public#if NAPE_NO_INLINE#else inline #end
    function included(xs:ZNPList_ZPP_CbType):Bool{
        return nonemptyintersection(xs,includes);
    }
    public#if NAPE_NO_INLINE#else inline #end
    function compatible(xs:ZNPList_ZPP_CbType):Bool{
        return included(xs)&&!excluded(xs);
    }
    public function nonemptyintersection(xs:ZNPList_ZPP_CbType,ys:ZNPList_ZPP_CbType):Bool{
        var ret=false;
        var xite=xs.begin();
        var eite=ys.begin();
        while(eite!=null&&xite!=null){
            var ex=eite.elem();
            var xi=xite.elem();
            if(ex==xi){
                ret=true;
                break;
            }
            else if(ZPP_CbType.setlt(ex,xi)){
                eite=eite.next;
            }
            else{
                xite=xite.next;
            }
        }
        return ret;
    }
    #if NAPE_NO_INLINE#elseif(flash9&&flib)@:ns("flibdel")#end
    public#if NAPE_NO_INLINE#else inline #end
    function effect_change(val:ZPP_CbType,included:Bool,added:Bool):Void{
        if(included){
            if(added){
                var pre=null;
                {
                    var cx_ite=includes.begin();
                    while(cx_ite!=null){
                        var j=cx_ite.elem();
                        {
                            if(ZPP_CbType.setlt(val,j))break;
                            pre=cx_ite;
                        };
                        cx_ite=cx_ite.next;
                    }
                };
                includes.inlined_insert(pre,val);
            };
            else includes.remove(val);
        }
        else{
            if(added){
                var pre=null;
                {
                    var cx_ite=excludes.begin();
                    while(cx_ite!=null){
                        var j=cx_ite.elem();
                        {
                            if(ZPP_CbType.setlt(val,j))break;
                            pre=cx_ite;
                        };
                        cx_ite=cx_ite.next;
                    }
                };
                excludes.inlined_insert(pre,val);
            };
            else excludes.remove(val);
        }
    }
    function append_type(list:ZNPList_ZPP_CbType,val:ZPP_CbType){
        if(list==includes){
            if(!includes.has(val)){
                if(!excludes.has(val)){
                    if(handler!=null)handler(val,true,true);
                    else effect_change(val,true,true);
                }
                else{
                    if(handler!=null)handler(val,false,false);
                    else effect_change(val,false,false);
                }
            }
        }
        else{
            if(!excludes.has(val)){
                if(!includes.has(val)){
                    if(handler!=null)handler(val,false,true);
                    else effect_change(val,false,true);
                }
                else{
                    if(handler!=null)handler(val,true,false);
                    else effect_change(val,true,false);
                }
            }
        }
    }
    public function set(options:ZPP_OptionType){
        if(options!=this){
            while(!includes.empty())append_type(excludes,includes.front());
            while(!excludes.empty())append_type(includes,excludes.front());
            {
                var cx_ite=options.excludes.begin();
                while(cx_ite!=null){
                    var i=cx_ite.elem();
                    append_type(excludes,i);
                    cx_ite=cx_ite.next;
                }
            };
            {
                var cx_ite=options.includes.begin();
                while(cx_ite!=null){
                    var i=cx_ite.elem();
                    append_type(includes,i);
                    cx_ite=cx_ite.next;
                }
            };
        }
        return this;
    }
    public function append(list:ZNPList_ZPP_CbType,val:Dynamic){
        #if(!NAPE_RELEASE_BUILD)
        if(val==null){
            throw "Error: Cannot append null, only CbType and CbType list values";
        }
        #end
        if(#if flash untyped __is__(val,CbType)#else Std.is(val,CbType)#end){
            var cb:CbType=val;
            append_type(list,cb.zpp_inner);
        }
        else if(#if flash untyped __is__(val,CbTypeList)#else Std.is(val,CbTypeList)#end){
            var cbs:CbTypeList=val;
            for(cb in cbs)append_type(list,cb.zpp_inner);
        }
        else if(#if flash10#if flash untyped __is__(val,ZPP_Const.cbtypevector)#else Std.is(val,ZPP_Const.cbtypevector)#end
        #else false #end){
            #if flash10 var cbs:flash.Vector<CbType>=val;
            for(cb in cbs)append_type(list,cb.zpp_inner);
            #end
        }
        else if(#if flash untyped __is__(val,Array)#else Std.is(val,Array)#end){
            var cbs:Array<Dynamic>=val;
            for(cb in cbs){
                #if(!NAPE_RELEASE_BUILD)
                if(!#if flash untyped __is__(cb,CbType)#else Std.is(cb,CbType)#end){
                    throw "Error: Cannot append non-CbType or CbType list value";
                }
                #end
                var cbx:CbType=cb;
                append_type(list,cbx.zpp_inner);
            }
        }
        else{
            #if(!NAPE_RELEASE_BUILD)
            throw "Error: Cannot append non-CbType or CbType list value";
            #end
        }
    }
    public static function argument(val:Dynamic):OptionType{
        return if(val==null)new OptionType();
        else if(#if flash untyped __is__(val,OptionType)#else Std.is(val,OptionType)#end)val;
        else new OptionType().including(val);
    }
}
