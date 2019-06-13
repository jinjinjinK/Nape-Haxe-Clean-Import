package zpp_nape.constraint;
import nape.constraint.Constraint;
import nape.constraint.MotorJoint;
import nape.geom.Vec3;
import nape.phys.Body;
import zpp_nape.constraint.Constraint;
import zpp_nape.geom.Vec3;
import zpp_nape.phys.Body;
#if nape_swc@:keep #end
class ZPP_MotorJoint extends ZPP_Constraint{
    public var outer_zn:MotorJoint=null;
    public var ratio:Float=0.0;
    public var rate:Float=0.0;
    public function bodyImpulse(b:ZPP_Body){
        if(stepped){
            if(b==b1)return Vec3.get(0,0,-jAcc);
            else return Vec3.get(0,0,ratio*jAcc);
        }
        else return Vec3.get(0,0,0);
    }
    public override function activeBodies(){
        {
            if(b1!=null)b1.constraints.add(this);
        };
        if(b2!=b1){
            if(b2!=null)b2.constraints.add(this);
        };
    }
    public override function inactiveBodies(){
        {
            if(b1!=null)b1.constraints.remove(this);
        };
        if(b2!=b1){
            if(b2!=null)b2.constraints.remove(this);
        };
    }
    public var b1:ZPP_Body=null;
    public var b2:ZPP_Body=null;
    public var kMass:Float=0.0;
    public var jAcc:Float=0.0;
    public var jMax:Float=0.0;
    public var stepped:Bool=false;
    public override function copy(dict:Array<ZPP_CopyHelper>=null,todo:Array<ZPP_CopyHelper>=null):Constraint{
        var ret=new MotorJoint(null,null,rate,ratio);
        copyto(ret);
        {
            if(dict!=null&&b1!=null){
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        todo!=null;
                    };
                    if(!res)throw "assert("+"todo!=null"+") :: "+("dict non-null,but todo is in constraint copy?");
                    #end
                };
                var b:Body=null;
                for(idc in dict){
                    if(idc.id==b1.id){
                        b=idc.bc;
                        break;
                    }
                }
                if(b!=null)ret.zpp_inner_zn.b1=b.zpp_inner;
                else todo.push(ZPP_CopyHelper.todo(b1.id,function(b:Body)ret.zpp_inner_zn.b1=b.zpp_inner));
            }
        };
        {
            if(dict!=null&&b2!=null){
                {
                    #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                    var res={
                        todo!=null;
                    };
                    if(!res)throw "assert("+"todo!=null"+") :: "+("dict non-null,but todo is in constraint copy?");
                    #end
                };
                var b:Body=null;
                for(idc in dict){
                    if(idc.id==b2.id){
                        b=idc.bc;
                        break;
                    }
                }
                if(b!=null)ret.zpp_inner_zn.b2=b.zpp_inner;
                else todo.push(ZPP_CopyHelper.todo(b2.id,function(b:Body)ret.zpp_inner_zn.b2=b.zpp_inner));
            }
        };
        return ret;
    }
    public function new(){
        super();
        jAcc=0;
        stepped=false;
        __velocity=true;
    }
    public override function validate(){
        if(b1==null||b2==null)throw "Error: AngleJoint cannot be simulated null bodies";
        if(b1==b2)throw "Error: MotorJoint cannot be simulated with body1 == body2";
        if(b1.space!=space||b2.space!=space)throw "Error: Constraints must have each body within the same space to which the constraint has been assigned";
        if(!b1.isDynamic()&&!b2.isDynamic())throw "Error: Constraints cannot have both bodies non-dynamic";
    }
    public override function wake_connected(){
        if(b1!=null&&b1.isDynamic())b1.wake();
        if(b2!=null&&b2.isDynamic())b2.wake();
    }
    public override function forest(){
        if(b1.isDynamic()){
            var xr=({
                if(b1.component==b1.component.parent)b1.component;
                else{
                    var obj=b1.component;
                    var stack=null;
                    while(obj!=obj.parent){
                        var nxt=obj.parent;
                        obj.parent=stack;
                        stack=obj;
                        obj=nxt;
                    }
                    while(stack!=null){
                        var nxt=stack.parent;
                        stack.parent=obj;
                        stack=nxt;
                    }
                    obj;
                }
            });
            var yr=({
                if(component==component.parent)component;
                else{
                    var obj=component;
                    var stack=null;
                    while(obj!=obj.parent){
                        var nxt=obj.parent;
                        obj.parent=stack;
                        stack=obj;
                        obj=nxt;
                    }
                    while(stack!=null){
                        var nxt=stack.parent;
                        stack.parent=obj;
                        stack=nxt;
                    }
                    obj;
                }
            });
            if(xr!=yr){
                if(xr.rank<yr.rank)xr.parent=yr;
                else if(xr.rank>yr.rank)yr.parent=xr;
                else{
                    yr.parent=xr;
                    xr.rank++;
                }
            }
        };
        if(b2.isDynamic()){
            var xr=({
                if(b2.component==b2.component.parent)b2.component;
                else{
                    var obj=b2.component;
                    var stack=null;
                    while(obj!=obj.parent){
                        var nxt=obj.parent;
                        obj.parent=stack;
                        stack=obj;
                        obj=nxt;
                    }
                    while(stack!=null){
                        var nxt=stack.parent;
                        stack.parent=obj;
                        stack=nxt;
                    }
                    obj;
                }
            });
            var yr=({
                if(component==component.parent)component;
                else{
                    var obj=component;
                    var stack=null;
                    while(obj!=obj.parent){
                        var nxt=obj.parent;
                        obj.parent=stack;
                        stack=obj;
                        obj=nxt;
                    }
                    while(stack!=null){
                        var nxt=stack.parent;
                        stack.parent=obj;
                        stack=nxt;
                    }
                    obj;
                }
            });
            if(xr!=yr){
                if(xr.rank<yr.rank)xr.parent=yr;
                else if(xr.rank>yr.rank)yr.parent=xr;
                else{
                    yr.parent=xr;
                    xr.rank++;
                }
            }
        };
    }
    public override function pair_exists(id:Int,di:Int){
        return(b1.id==id&&b2.id==di)||(b1.id==di&&b2.id==id);
    }
    public override function clearcache(){
        jAcc=0;
        pre_dt=-1.0;
    }
    public override function preStep(dt:Float){
        if(pre_dt==-1.0)pre_dt=dt;
        var dtratio=dt/pre_dt;
        pre_dt=dt;
        stepped=true;
        kMass={
            b1.sinertia+ratio*ratio*b2.sinertia;
        };
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                kMass>0.0;
            };
            if(!res)throw "assert("+"kMass>0.0"+") :: "+("kmass motorjoint");
            #end
        };
        kMass=1.0/kMass;
        jAcc*=dtratio;
        jMax=maxForce*dt;
        return false;
    }
    public override function warmStart(){
        {
            b1.angvel-=b1.iinertia*jAcc;
            b2.angvel+=ratio*b2.iinertia*jAcc;
        };
    }
    public override function applyImpulseVel(){
        var E={
            ratio*(b2.angvel+b2.kinangvel)-b1.angvel-b1.kinangvel-rate;
        };
        var j=-kMass*E;
        {
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    !((j!=j));
                };
                if(!res)throw "assert("+"!assert_isNaN(j)"+") :: "+("accum nan");
                #end
            };
            var jOld=jAcc;
            jAcc+=j;
            {
                if(breakUnderForce){
                    if(jAcc>jMax||jAcc<-jMax)return true;
                }
                else{
                    if(jAcc<-jMax)jAcc=-jMax;
                    else if(jAcc>jMax)jAcc=jMax;
                };
            };
            j=jAcc-jOld;
        };
        {
            b1.angvel-=b1.iinertia*j;
            b2.angvel+=ratio*b2.iinertia*j;
        };
        return false;
    }
    public override function applyImpulsePos(){
        return false;
    }
}
