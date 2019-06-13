package zpp_nape.util;
#if flash10 import flash.Memory;
import flash.utils.ByteArray;
#end
#if nape_swc@:keep #end
class ZPP_Math{
     public static#if NAPE_NO_INLINE#else inline #end
    function sqrt(x:Float){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !((x!=x));
            };
            if(!res)throw "assert("+"!assert_isNaN(x)"+") :: "+("PR(Math).sqrt");
            #end
        };
        #if flash10 return if(x==0.0)0.0 else 1/invsqrt(x);
        #else return Math.sqrt(x);
        #end
    }
     public static#if NAPE_NO_INLINE#else inline #end
    function invsqrt(x:Float){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !((x!=x))&&x!=0.0;
            };
            if(!res)throw "assert("+"!assert_isNaN(x)&&x!=0.0"+") :: "+("PR(Math).invsqrt");
            #end
        };
        #if flash10 Memory.setFloat(0,x);
        Memory.setI32(0,0x5f3759df-(Memory.getI32(0)>>1));
        var x2=Memory.getFloat(0);
        return x2*(1.5-0.5*x*x2*x2);
        #else return 1.0/sqrt(x);
        #end
    }
     public#if NAPE_NO_INLINE#else inline #end
    static function sqr(x:Float){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !((x!=x));
            };
            if(!res)throw "assert("+"!assert_isNaN(x)"+") :: "+("PR(Math).sqr");
            #end
        };
        return x*x;
    }
     public#if NAPE_NO_INLINE#else inline #end
    static function clamp2(x:Float,a:Float){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !((x!=x))&&!((a!=a));
            };
            if(!res)throw "assert("+"!assert_isNaN(x)&&!assert_isNaN(a)"+") :: "+("PR(Math).clamp2 -> "+x+" -> "+a);
            #end
        };
        return clamp(x,-a,a);
    }
     public static#if NAPE_NO_INLINE#else inline #end
    function clamp(x:Float,a:Float,b:Float){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                !((x!=x))&&!((a!=a))&&!((b!=b));
            };
            if(!res)throw "assert("+"!assert_isNaN(x)&&!assert_isNaN(a)&&!assert_isNaN(b)"+") :: "+("PR(Math).clamp2 -> "+x+" -> "+a+" -> "+b);
            #end
        };
        return if(x<a)a else if(x>b)b else x;
    }
}
