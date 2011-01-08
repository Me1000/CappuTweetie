var ObjectiveJ={};
(function(_1,_2){
if(!this.JSON){
JSON={};
}
(function(){
function f(n){
return n<10?"0"+n:n;
};
if(typeof Date.prototype.toJSON!=="function"){
Date.prototype.toJSON=function(_3){
return this.getUTCFullYear()+"-"+f(this.getUTCMonth()+1)+"-"+f(this.getUTCDate())+"T"+f(this.getUTCHours())+":"+f(this.getUTCMinutes())+":"+f(this.getUTCSeconds())+"Z";
};
String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(_4){
return this.valueOf();
};
}
var cx=new RegExp("[\\u0000\\u00ad\\u0600-\\u0604\\u070f\\u17b4\\u17b5\\u200c-\\u200f\\u2028-\\u202f\\u2060-\\u206f\\ufeff\\ufff0-\\uffff]","g");
var _5=new RegExp("[\\\\\\\"\\x00-\\x1f\\x7f-\\x9f\\u00ad\\u0600-\\u0604\\u070f\\u17b4\\u17b5\\u200c-\\u200f\\u2028-\\u202f\\u2060-\\u206f\\ufeff\\ufff0-\\uffff]","g");
var _6,_7,_8={"\b":"\\b","\t":"\\t","\n":"\\n","\f":"\\f","\r":"\\r","\"":"\\\"","\\":"\\\\"},_9;
function _a(_b){
_5.lastIndex=0;
return _5.test(_b)?"\""+_b.replace(_5,function(a){
var c=_8[a];
return typeof c==="string"?c:"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4);
})+"\"":"\""+_b+"\"";
};
function _c(_d,_e){
var i,k,v,_f,_10=_6,_11,_12=_e[_d];
if(_12&&typeof _12==="object"&&typeof _12.toJSON==="function"){
_12=_12.toJSON(_d);
}
if(typeof _9==="function"){
_12=_9.call(_e,_d,_12);
}
switch(typeof _12){
case "string":
return _a(_12);
case "number":
return isFinite(_12)?String(_12):"null";
case "boolean":
case "null":
return String(_12);
case "object":
if(!_12){
return "null";
}
_6+=_7;
_11=[];
if(Object.prototype.toString.apply(_12)==="[object Array]"){
_f=_12.length;
for(i=0;i<_f;i+=1){
_11[i]=_c(i,_12)||"null";
}
v=_11.length===0?"[]":_6?"[\n"+_6+_11.join(",\n"+_6)+"\n"+_10+"]":"["+_11.join(",")+"]";
_6=_10;
return v;
}
if(_9&&typeof _9==="object"){
_f=_9.length;
for(i=0;i<_f;i+=1){
k=_9[i];
if(typeof k==="string"){
v=_c(k,_12);
if(v){
_11.push(_a(k)+(_6?": ":":")+v);
}
}
}
}else{
for(k in _12){
if(Object.hasOwnProperty.call(_12,k)){
v=_c(k,_12);
if(v){
_11.push(_a(k)+(_6?": ":":")+v);
}
}
}
}
v=_11.length===0?"{}":_6?"{\n"+_6+_11.join(",\n"+_6)+"\n"+_10+"}":"{"+_11.join(",")+"}";
_6=_10;
return v;
}
};
if(typeof JSON.stringify!=="function"){
JSON.stringify=function(_13,_14,_15){
var i;
_6="";
_7="";
if(typeof _15==="number"){
for(i=0;i<_15;i+=1){
_7+=" ";
}
}else{
if(typeof _15==="string"){
_7=_15;
}
}
_9=_14;
if(_14&&typeof _14!=="function"&&(typeof _14!=="object"||typeof _14.length!=="number")){
throw new Error("JSON.stringify");
}
return _c("",{"":_13});
};
}
if(typeof JSON.parse!=="function"){
JSON.parse=function(_16,_17){
var j;
function _18(_19,key){
var k,v,_1a=_19[key];
if(_1a&&typeof _1a==="object"){
for(k in _1a){
if(Object.hasOwnProperty.call(_1a,k)){
v=_18(_1a,k);
if(v!==_29){
_1a[k]=v;
}else{
delete _1a[k];
}
}
}
}
return _17.call(_19,key,_1a);
};
cx.lastIndex=0;
if(cx.test(_16)){
_16=_16.replace(cx,function(a){
return "\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4);
});
}
if(/^[\],:{}\s]*$/.test(_16.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,"@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,"]").replace(/(?:^|:|,)(?:\s*\[)+/g,""))){
j=eval("("+_16+")");
return typeof _17==="function"?_18({"":j},""):j;
}
throw new SyntaxError("JSON.parse");
};
}
}());
var _1b=new RegExp("([^%]+|%(?:\\d+\\$)?[\\+\\-\\ \\#0]*[0-9\\*]*(.[0-9\\*]+)?[hlL]?[cbBdieEfgGosuxXpn%@])","g");
var _1c=new RegExp("(%)(?:(\\d+)\\$)?([\\+\\-\\ \\#0]*)([0-9\\*]*)((?:.[0-9\\*]+)?)([hlL]?)([cbBdieEfgGosuxXpn%@])");
_2.sprintf=function(_1d){
var _1d=arguments[0],_1e=_1d.match(_1b),_1f=0,_20="",arg=1;
for(var i=0;i<_1e.length;i++){
var t=_1e[i];
if(_1d.substring(_1f,_1f+t.length)!=t){
return _20;
}
_1f+=t.length;
if(t.charAt(0)!="%"){
_20+=t;
}else{
var _21=t.match(_1c);
if(_21.length!=8||_21[0]!=t){
return _20;
}
var _22=_21[1],_23=_21[2],_24=_21[3],_25=_21[4],_26=_21[5],_27=_21[6],_28=_21[7];
if(_23===_29||_23===null||_23===""){
_23=arg++;
}else{
_23=Number(_23);
}
var _2a=null;
if(_25=="*"){
_2a=arguments[_23];
}else{
if(_25!=""){
_2a=Number(_25);
}
}
var _2b=null;
if(_26==".*"){
_2b=arguments[_23];
}else{
if(_26!=""){
_2b=Number(_26.substring(1));
}
}
var _2c=(_24.indexOf("-")>=0);
var _2d=(_24.indexOf("0")>=0);
var _2e="";
if(RegExp("[bBdiufeExXo]").test(_28)){
var num=Number(arguments[_23]);
var _2f="";
if(num<0){
_2f="-";
}else{
if(_24.indexOf("+")>=0){
_2f="+";
}else{
if(_24.indexOf(" ")>=0){
_2f=" ";
}
}
}
if(_28=="d"||_28=="i"||_28=="u"){
var _30=String(Math.abs(Math.floor(num)));
_2e=_31(_2f,"",_30,"",_2a,_2c,_2d);
}
if(_28=="f"){
var _30=String((_2b!=null)?Math.abs(num).toFixed(_2b):Math.abs(num));
var _32=(_24.indexOf("#")>=0&&_30.indexOf(".")<0)?".":"";
_2e=_31(_2f,"",_30,_32,_2a,_2c,_2d);
}
if(_28=="e"||_28=="E"){
var _30=String(Math.abs(num).toExponential(_2b!=null?_2b:21));
var _32=(_24.indexOf("#")>=0&&_30.indexOf(".")<0)?".":"";
_2e=_31(_2f,"",_30,_32,_2a,_2c,_2d);
}
if(_28=="x"||_28=="X"){
var _30=String(Math.abs(num).toString(16));
var _33=(_24.indexOf("#")>=0&&num!=0)?"0x":"";
_2e=_31(_2f,_33,_30,"",_2a,_2c,_2d);
}
if(_28=="b"||_28=="B"){
var _30=String(Math.abs(num).toString(2));
var _33=(_24.indexOf("#")>=0&&num!=0)?"0b":"";
_2e=_31(_2f,_33,_30,"",_2a,_2c,_2d);
}
if(_28=="o"){
var _30=String(Math.abs(num).toString(8));
var _33=(_24.indexOf("#")>=0&&num!=0)?"0":"";
_2e=_31(_2f,_33,_30,"",_2a,_2c,_2d);
}
if(RegExp("[A-Z]").test(_28)){
_2e=_2e.toUpperCase();
}else{
_2e=_2e.toLowerCase();
}
}else{
var _2e="";
if(_28=="%"){
_2e="%";
}else{
if(_28=="c"){
_2e=String(arguments[_23]).charAt(0);
}else{
if(_28=="s"||_28=="@"){
_2e=String(arguments[_23]);
}else{
if(_28=="p"||_28=="n"){
_2e="";
}
}
}
}
_2e=_31("","",_2e,"",_2a,_2c,false);
}
_20+=_2e;
}
}
return _20;
};
function _31(_34,_35,_36,_37,_38,_39,_3a){
var _3b=(_34.length+_35.length+_36.length+_37.length);
if(_39){
return _34+_35+_36+_37+pad(_38-_3b," ");
}else{
if(_3a){
return _34+_35+pad(_38-_3b,"0")+_36+_37;
}else{
return pad(_38-_3b," ")+_34+_35+_36+_37;
}
}
};
function pad(n,ch){
return Array(MAX(0,n)+1).join(ch);
};
CPLogDisable=false;
var _3c="Cappuccino";
var _3d=["fatal","error","warn","info","debug","trace"];
var _3e=_3d[3];
var _3f={};
for(var i=0;i<_3d.length;i++){
_3f[_3d[i]]=i;
}
var _40={};
CPLogRegister=function(_41,_42,_43){
CPLogRegisterRange(_41,_3d[0],_42||_3d[_3d.length-1],_43);
};
CPLogRegisterRange=function(_44,_45,_46,_47){
var min=_3f[_45];
var max=_3f[_46];
if(min!==_29&&max!==_29&&min<=max){
for(var i=min;i<=max;i++){
CPLogRegisterSingle(_44,_3d[i],_47);
}
}
};
CPLogRegisterSingle=function(_48,_49,_4a){
if(!_40[_49]){
_40[_49]=[];
}
for(var i=0;i<_40[_49].length;i++){
if(_40[_49][i][0]===_48){
_40[_49][i][1]=_4a;
return;
}
}
_40[_49].push([_48,_4a]);
};
CPLogUnregister=function(_4b){
for(var _4c in _40){
for(var i=0;i<_40[_4c].length;i++){
if(_40[_4c][i][0]===_4b){
_40[_4c].splice(i--,1);
}
}
}
};
function _4d(_4e,_4f,_50){
if(_50==_29){
_50=_3c;
}
if(_4f==_29){
_4f=_3e;
}
var _51=(typeof _4e[0]=="string"&&_4e.length>1)?_2.sprintf.apply(null,_4e):String(_4e[0]);
if(_40[_4f]){
for(var i=0;i<_40[_4f].length;i++){
var _52=_40[_4f][i];
_52[0](_51,_4f,_50,_52[1]);
}
}
};
CPLog=function(){
_4d(arguments);
};
for(var i=0;i<_3d.length;i++){
CPLog[_3d[i]]=(function(_53){
return function(){
_4d(arguments,_53);
};
})(_3d[i]);
}
var _54=function(_55,_56,_57){
var now=new Date();
_56=(_56==null?"":" ["+CPLogColorize(_56,_56)+"]");
if(typeof _2.sprintf=="function"){
return _2.sprintf("%4d-%02d-%02d %02d:%02d:%02d.%03d %s%s: %s",now.getFullYear(),now.getMonth()+1,now.getDate(),now.getHours(),now.getMinutes(),now.getSeconds(),now.getMilliseconds(),_57,_56,_55);
}else{
return now+" "+_57+_56+": "+_55;
}
};
CPLogConsole=function(_58,_59,_5a,_5b){
if(typeof console!="undefined"){
var _5c=(_5b||_54)(_58,_59,_5a);
var _5d={"fatal":"error","error":"error","warn":"warn","info":"info","debug":"debug","trace":"debug"}[_59];
if(_5d&&console[_5d]){
console[_5d](_5c);
}else{
if(console.log){
console.log(_5c);
}
}
}
};
CPLogColorize=function(_5e,_5f){
return _5e;
};
CPLogAlert=function(_60,_61,_62,_63){
if(typeof alert!="undefined"&&!CPLogDisable){
var _64=(_63||_54)(_60,_61,_62);
CPLogDisable=!confirm(_64+"\n\n(Click cancel to stop log alerts)");
}
};
var _65=null;
CPLogPopup=function(_66,_67,_68,_69){
try{
if(CPLogDisable||window.open==_29){
return;
}
if(!_65||!_65.document){
_65=window.open("","_blank","width=600,height=400,status=no,resizable=yes,scrollbars=yes");
if(!_65){
CPLogDisable=!confirm(_66+"\n\n(Disable pop-up blocking for CPLog window; Click cancel to stop log alerts)");
return;
}
_6a(_65);
}
var _6b=_65.document.createElement("div");
_6b.setAttribute("class",_67||"fatal");
var _6c=(_69||_54)(_66,_69?_67:null,_68);
_6b.appendChild(_65.document.createTextNode(_6c));
_65.log.appendChild(_6b);
if(_65.focusEnabled.checked){
_65.focus();
}
if(_65.blockEnabled.checked){
_65.blockEnabled.checked=_65.confirm(_6c+"\nContinue blocking?");
}
if(_65.scrollEnabled.checked){
_65.scrollToBottom();
}
}
catch(e){
}
};
var _6d="<style type=\"text/css\" media=\"screen\"> body{font:10px Monaco,Courier,\"Courier New\",monospace,mono;padding-top:15px;} div > .fatal,div > .error,div > .warn,div > .info,div > .debug,div > .trace{display:none;overflow:hidden;white-space:pre;padding:0px 5px 0px 5px;margin-top:2px;-moz-border-radius:5px;-webkit-border-radius:5px;} div[wrap=\"yes\"] > div{white-space:normal;} .fatal{background-color:#ffb2b3;} .error{background-color:#ffe2b2;} .warn{background-color:#fdffb2;} .info{background-color:#e4ffb2;} .debug{background-color:#a0e5a0;} .trace{background-color:#99b9ff;} .enfatal .fatal,.enerror .error,.enwarn .warn,.eninfo .info,.endebug .debug,.entrace .trace{display:block;} div#header{background-color:rgba(240,240,240,0.82);position:fixed;top:0px;left:0px;width:100%;border-bottom:1px solid rgba(0,0,0,0.33);text-align:center;} ul#enablers{display:inline-block;margin:1px 15px 0 15px;padding:2px 0 2px 0;} ul#enablers li{display:inline;padding:0px 5px 0px 5px;margin-left:4px;-moz-border-radius:5px;-webkit-border-radius:5px;} [enabled=\"no\"]{opacity:0.25;} ul#options{display:inline-block;margin:0 15px 0px 15px;padding:0 0px;} ul#options li{margin:0 0 0 0;padding:0 0 0 0;display:inline;} </style>";
function _6a(_6e){
var doc=_6e.document;
doc.writeln("<html><head><title></title>"+_6d+"</head><body></body></html>");
doc.title=_3c+" Run Log";
var _6f=doc.getElementsByTagName("head")[0];
var _70=doc.getElementsByTagName("body")[0];
var _71=window.location.protocol+"//"+window.location.host+window.location.pathname;
_71=_71.substring(0,_71.lastIndexOf("/")+1);
var div=doc.createElement("div");
div.setAttribute("id","header");
_70.appendChild(div);
var ul=doc.createElement("ul");
ul.setAttribute("id","enablers");
div.appendChild(ul);
for(var i=0;i<_3d.length;i++){
var li=doc.createElement("li");
li.setAttribute("id","en"+_3d[i]);
li.setAttribute("class",_3d[i]);
li.setAttribute("onclick","toggle(this);");
li.setAttribute("enabled","yes");
li.appendChild(doc.createTextNode(_3d[i]));
ul.appendChild(li);
}
var ul=doc.createElement("ul");
ul.setAttribute("id","options");
div.appendChild(ul);
var _72={"focus":["Focus",false],"block":["Block",false],"wrap":["Wrap",false],"scroll":["Scroll",true],"close":["Close",true]};
for(o in _72){
var li=doc.createElement("li");
ul.appendChild(li);
_6e[o+"Enabled"]=doc.createElement("input");
_6e[o+"Enabled"].setAttribute("id",o);
_6e[o+"Enabled"].setAttribute("type","checkbox");
if(_72[o][1]){
_6e[o+"Enabled"].setAttribute("checked","checked");
}
li.appendChild(_6e[o+"Enabled"]);
var _73=doc.createElement("label");
_73.setAttribute("for",o);
_73.appendChild(doc.createTextNode(_72[o][0]));
li.appendChild(_73);
}
_6e.log=doc.createElement("div");
_6e.log.setAttribute("class","enerror endebug enwarn eninfo enfatal entrace");
_70.appendChild(_6e.log);
_6e.toggle=function(_74){
var _75=(_74.getAttribute("enabled")=="yes")?"no":"yes";
_74.setAttribute("enabled",_75);
if(_75=="yes"){
_6e.log.className+=" "+_74.id;
}else{
_6e.log.className=_6e.log.className.replace(new RegExp("[\\s]*"+_74.id,"g"),"");
}
};
_6e.scrollToBottom=function(){
_6e.scrollTo(0,_70.offsetHeight);
};
_6e.wrapEnabled.addEventListener("click",function(){
_6e.log.setAttribute("wrap",_6e.wrapEnabled.checked?"yes":"no");
},false);
_6e.addEventListener("keydown",function(e){
var e=e||_6e.event;
if(e.keyCode==75&&(e.ctrlKey||e.metaKey)){
while(_6e.log.firstChild){
_6e.log.removeChild(_6e.log.firstChild);
}
e.preventDefault();
}
},"false");
window.addEventListener("unload",function(){
if(_6e&&_6e.closeEnabled&&_6e.closeEnabled.checked){
CPLogDisable=true;
_6e.close();
}
},false);
_6e.addEventListener("unload",function(){
if(!CPLogDisable){
CPLogDisable=!confirm("Click cancel to stop logging");
}
},false);
};
CPLogDefault=(typeof window==="object"&&window.console)?CPLogConsole:CPLogPopup;
var _29;
if(typeof window!=="undefined"){
window.setNativeTimeout=window.setTimeout;
window.clearNativeTimeout=window.clearTimeout;
window.setNativeInterval=window.setInterval;
window.clearNativeInterval=window.clearInterval;
}
NO=false;
YES=true;
nil=null;
Nil=null;
NULL=null;
ABS=Math.abs;
ASIN=Math.asin;
ACOS=Math.acos;
ATAN=Math.atan;
ATAN2=Math.atan2;
SIN=Math.sin;
COS=Math.cos;
TAN=Math.tan;
EXP=Math.exp;
POW=Math.pow;
CEIL=Math.ceil;
FLOOR=Math.floor;
ROUND=Math.round;
MIN=Math.min;
MAX=Math.max;
RAND=Math.random;
SQRT=Math.sqrt;
E=Math.E;
LN2=Math.LN2;
LN10=Math.LN10;
LOG2E=Math.LOG2E;
LOG10E=Math.LOG10E;
PI=Math.PI;
PI2=Math.PI*2;
PI_2=Math.PI/2;
SQRT1_2=Math.SQRT1_2;
SQRT2=Math.SQRT2;
function _76(_77){
this._eventListenersForEventNames={};
this._owner=_77;
};
_76.prototype.addEventListener=function(_78,_79){
var _7a=this._eventListenersForEventNames;
if(!_7b.call(_7a,_78)){
var _7c=[];
_7a[_78]=_7c;
}else{
var _7c=_7a[_78];
}
var _7d=_7c.length;
while(_7d--){
if(_7c[_7d]===_79){
return;
}
}
_7c.push(_79);
};
_76.prototype.removeEventListener=function(_7e,_7f){
var _80=this._eventListenersForEventNames;
if(!_7b.call(_80,_7e)){
return;
}
var _81=_80[_7e],_82=_81.length;
while(_82--){
if(_81[_82]===_7f){
return _81.splice(_82,1);
}
}
};
_76.prototype.dispatchEvent=function(_83){
var _84=_83.type,_85=this._eventListenersForEventNames;
if(_7b.call(_85,_84)){
var _86=this._eventListenersForEventNames[_84],_87=0,_88=_86.length;
for(;_87<_88;++_87){
_86[_87](_83);
}
}
var _89=(this._owner||this)["on"+_84];
if(_89){
_89(_83);
}
};
var _8a=0,_8b=null,_8c=[];
function _8d(_8e){
var _8f=_8a;
if(_8b===null){
window.setNativeTimeout(function(){
var _90=_8c,_91=0,_92=_8c.length;
++_8a;
_8b=null;
_8c=[];
for(;_91<_92;++_91){
_90[_91]();
}
},0);
}
return function(){
var _93=arguments;
if(_8a>_8f){
_8e.apply(this,_93);
}else{
_8c.push(function(){
_8e.apply(this,_93);
});
}
};
};
var _94=null;
if(window.ActiveXObject!==_29){
var _95=["Msxml2.XMLHTTP.3.0","Msxml2.XMLHTTP.6.0"],_96=_95.length;
while(_96--){
try{
var _97=_95[_96];
new ActiveXObject(_97);
_94=function(){
return new ActiveXObject(_97);
};
break;
}
catch(anException){
}
}
}
if(!_94){
_94=window.XMLHttpRequest;
}
CFHTTPRequest=function(){
this._isOpen=false;
this._requestHeaders={};
this._mimeType=null;
this._eventDispatcher=new _76(this);
this._nativeRequest=new _94();
var _98=this;
this._stateChangeHandler=function(){
_ab(_98);
};
this._nativeRequest.onreadystatechange=this._stateChangeHandler;
if(CFHTTPRequest.AuthenticationDelegate!==nil){
this._eventDispatcher.addEventListener("HTTP403",function(){
CFHTTPRequest.AuthenticationDelegate(_98);
});
}
};
CFHTTPRequest.UninitializedState=0;
CFHTTPRequest.LoadingState=1;
CFHTTPRequest.LoadedState=2;
CFHTTPRequest.InteractiveState=3;
CFHTTPRequest.CompleteState=4;
CFHTTPRequest.AuthenticationDelegate=nil;
CFHTTPRequest.prototype.status=function(){
try{
return this._nativeRequest.status||0;
}
catch(anException){
return 0;
}
};
CFHTTPRequest.prototype.statusText=function(){
try{
return this._nativeRequest.statusText||"";
}
catch(anException){
return "";
}
};
CFHTTPRequest.prototype.readyState=function(){
return this._nativeRequest.readyState;
};
CFHTTPRequest.prototype.success=function(){
var _99=this.status();
if(_99>=200&&_99<300){
return YES;
}
return _99===0&&this.responseText()&&this.responseText().length;
};
CFHTTPRequest.prototype.responseXML=function(){
var _9a=this._nativeRequest.responseXML;
if(_9a&&(_94===window.XMLHttpRequest)){
return _9a;
}
return _9b(this.responseText());
};
CFHTTPRequest.prototype.responsePropertyList=function(){
var _9c=this.responseText();
if(CFPropertyList.sniffedFormatOfString(_9c)===CFPropertyList.FormatXML_v1_0){
return CFPropertyList.propertyListFromXML(this.responseXML());
}
return CFPropertyList.propertyListFromString(_9c);
};
CFHTTPRequest.prototype.responseText=function(){
return this._nativeRequest.responseText;
};
CFHTTPRequest.prototype.setRequestHeader=function(_9d,_9e){
this._requestHeaders[_9d]=_9e;
};
CFHTTPRequest.prototype.getResponseHeader=function(_9f){
return this._nativeRequest.getResponseHeader(_9f);
};
CFHTTPRequest.prototype.getAllResponseHeaders=function(){
return this._nativeRequest.getAllResponseHeaders();
};
CFHTTPRequest.prototype.overrideMimeType=function(_a0){
this._mimeType=_a0;
};
CFHTTPRequest.prototype.open=function(_a1,_a2,_a3,_a4,_a5){
this._isOpen=true;
this._URL=_a2;
this._async=_a3;
this._method=_a1;
this._user=_a4;
this._password=_a5;
return this._nativeRequest.open(_a1,_a2,_a3,_a4,_a5);
};
CFHTTPRequest.prototype.send=function(_a6){
if(!this._isOpen){
delete this._nativeRequest.onreadystatechange;
this._nativeRequest.open(this._method,this._URL,this._async,this._user,this._password);
this._nativeRequest.onreadystatechange=this._stateChangeHandler;
}
for(var i in this._requestHeaders){
if(this._requestHeaders.hasOwnProperty(i)){
this._nativeRequest.setRequestHeader(i,this._requestHeaders[i]);
}
}
if(this._mimeType&&"overrideMimeType" in this._nativeRequest){
this._nativeRequest.overrideMimeType(this._mimeType);
}
this._isOpen=false;
try{
return this._nativeRequest.send(_a6);
}
catch(anException){
this._eventDispatcher.dispatchEvent({type:"failure",request:this});
}
};
CFHTTPRequest.prototype.abort=function(){
this._isOpen=false;
return this._nativeRequest.abort();
};
CFHTTPRequest.prototype.addEventListener=function(_a7,_a8){
this._eventDispatcher.addEventListener(_a7,_a8);
};
CFHTTPRequest.prototype.removeEventListener=function(_a9,_aa){
this._eventDispatcher.removeEventListener(_a9,_aa);
};
function _ab(_ac){
var _ad=_ac._eventDispatcher;
_ad.dispatchEvent({type:"readystatechange",request:_ac});
var _ae=_ac._nativeRequest,_af=["uninitialized","loading","loaded","interactive","complete"];
if(_af[_ac.readyState()]==="complete"){
var _b0="HTTP"+_ac.status();
_ad.dispatchEvent({type:_b0,request:_ac});
var _b1=_ac.success()?"success":"failure";
_ad.dispatchEvent({type:_b1,request:_ac});
_ad.dispatchEvent({type:_af[_ac.readyState()],request:_ac});
}else{
_ad.dispatchEvent({type:_af[_ac.readyState()],request:_ac});
}
};
function _b2(_b3,_b4,_b5){
var _b6=new CFHTTPRequest();
if(_b3.pathExtension()==="plist"){
_b6.overrideMimeType("text/xml");
}
if(_2.asyncLoader){
_b6.onsuccess=_8d(_b4);
_b6.onfailure=_8d(_b5);
}else{
_b6.onsuccess=_b4;
_b6.onfailure=_b5;
}
_b6.open("GET",_b3.absoluteString(),_2.asyncLoader);
_b6.send("");
};
_2.asyncLoader=YES;
_2.Asynchronous=_8d;
_2.determineAndDispatchHTTPRequestEvents=_ab;
var _b7=0;
objj_generateObjectUID=function(){
return _b7++;
};
CFPropertyList=function(){
this._UID=objj_generateObjectUID();
};
CFPropertyList.DTDRE=/^\s*(?:<\?\s*xml\s+version\s*=\s*\"1.0\"[^>]*\?>\s*)?(?:<\!DOCTYPE[^>]*>\s*)?/i;
CFPropertyList.XMLRE=/^\s*(?:<\?\s*xml\s+version\s*=\s*\"1.0\"[^>]*\?>\s*)?(?:<\!DOCTYPE[^>]*>\s*)?<\s*plist[^>]*\>/i;
CFPropertyList.FormatXMLDTD="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">";
CFPropertyList.Format280NorthMagicNumber="280NPLIST";
CFPropertyList.FormatOpenStep=1,CFPropertyList.FormatXML_v1_0=100,CFPropertyList.FormatBinary_v1_0=200,CFPropertyList.Format280North_v1_0=-1000;
CFPropertyList.sniffedFormatOfString=function(_b8){
if(_b8.match(CFPropertyList.XMLRE)){
return CFPropertyList.FormatXML_v1_0;
}
if(_b8.substr(0,CFPropertyList.Format280NorthMagicNumber.length)===CFPropertyList.Format280NorthMagicNumber){
return CFPropertyList.Format280North_v1_0;
}
return NULL;
};
CFPropertyList.dataFromPropertyList=function(_b9,_ba){
var _bb=new CFMutableData();
_bb.setRawString(CFPropertyList.stringFromPropertyList(_b9,_ba));
return _bb;
};
CFPropertyList.stringFromPropertyList=function(_bc,_bd){
if(!_bd){
_bd=CFPropertyList.Format280North_v1_0;
}
var _be=_bf[_bd];
return _be["start"]()+_c0(_bc,_be)+_be["finish"]();
};
function _c0(_c1,_c2){
var _c3=typeof _c1,_c4=_c1.valueOf(),_c5=typeof _c4;
if(_c3!==_c5){
_c3=_c5;
_c1=_c4;
}
if(_c1===YES||_c1===NO){
_c3="boolean";
}else{
if(_c3==="number"){
if(FLOOR(_c1)===_c1){
_c3="integer";
}else{
_c3="real";
}
}else{
if(_c3!=="string"){
if(_c1.slice){
_c3="array";
}else{
_c3="dictionary";
}
}
}
}
return _c2[_c3](_c1,_c2);
};
var _bf={};
_bf[CFPropertyList.FormatXML_v1_0]={"start":function(){
return CFPropertyList.FormatXMLDTD+"<plist version = \"1.0\">";
},"finish":function(){
return "</plist>";
},"string":function(_c6){
return "<string>"+_c7(_c6)+"</string>";
},"boolean":function(_c8){
return _c8?"<true/>":"<false/>";
},"integer":function(_c9){
return "<integer>"+_c9+"</integer>";
},"real":function(_ca){
return "<real>"+_ca+"</real>";
},"array":function(_cb,_cc){
var _cd=0,_ce=_cb.length,_cf="<array>";
for(;_cd<_ce;++_cd){
_cf+=_c0(_cb[_cd],_cc);
}
return _cf+"</array>";
},"dictionary":function(_d0,_d1){
var _d2=_d0._keys,_96=0,_d3=_d2.length,_d4="<dict>";
for(;_96<_d3;++_96){
var key=_d2[_96];
_d4+="<key>"+key+"</key>";
_d4+=_c0(_d0.valueForKey(key),_d1);
}
return _d4+"</dict>";
}};
var _d5="A",_d6="D",_d7="f",_d8="d",_d9="S",_da="T",_db="F",_dc="K",_dd="E";
_bf[CFPropertyList.Format280North_v1_0]={"start":function(){
return CFPropertyList.Format280NorthMagicNumber+";1.0;";
},"finish":function(){
return "";
},"string":function(_de){
return _d9+";"+_de.length+";"+_de;
},"boolean":function(_df){
return (_df?_da:_db)+";";
},"integer":function(_e0){
var _e1=""+_e0;
return _d8+";"+_e1.length+";"+_e1;
},"real":function(_e2){
var _e3=""+_e2;
return _d7+";"+_e3.length+";"+_e3;
},"array":function(_e4,_e5){
var _e6=0,_e7=_e4.length,_e8=_d5+";";
for(;_e6<_e7;++_e6){
_e8+=_c0(_e4[_e6],_e5);
}
return _e8+_dd+";";
},"dictionary":function(_e9,_ea){
var _eb=_e9._keys,_96=0,_ec=_eb.length,_ed=_d6+";";
for(;_96<_ec;++_96){
var key=_eb[_96];
_ed+=_dc+";"+key.length+";"+key;
_ed+=_c0(_e9.valueForKey(key),_ea);
}
return _ed+_dd+";";
}};
var _ee="xml",_ef="#document",_f0="plist",_f1="key",_f2="dict",_f3="array",_f4="string",_f5="true",_f6="false",_f7="real",_f8="integer",_f9="data";
var _fa=function(_fb){
var _fc="",_96=0,_fd=_fb.length;
for(;_96<_fd;++_96){
var _fe=_fb[_96];
if(_fe.nodeType===3||_fe.nodeType===4){
_fc+=_fe.nodeValue;
}else{
if(_fe.nodeType!==8){
_fc+=_fa(_fe.childNodes);
}
}
}
return _fc;
};
var _ff=function(_100,_101,_102){
var node=_100;
node=(node.firstChild);
if(node!==NULL&&((node.nodeType)===8||(node.nodeType)===3)){
while((node=(node.nextSibling))&&((node.nodeType)===8||(node.nodeType)===3)){
}
}
if(node){
return node;
}
if((String(_100.nodeName))===_f3||(String(_100.nodeName))===_f2){
_102.pop();
}else{
if(node===_101){
return NULL;
}
node=_100;
while((node=(node.nextSibling))&&((node.nodeType)===8||(node.nodeType)===3)){
}
if(node){
return node;
}
}
node=_100;
while(node){
var next=node;
while((next=(next.nextSibling))&&((next.nodeType)===8||(next.nodeType)===3)){
}
if(next){
return next;
}
var node=(node.parentNode);
if(_101&&node===_101){
return NULL;
}
_102.pop();
}
return NULL;
};
CFPropertyList.propertyListFromData=function(_103,_104){
return CFPropertyList.propertyListFromString(_103.rawString(),_104);
};
CFPropertyList.propertyListFromString=function(_105,_106){
if(!_106){
_106=CFPropertyList.sniffedFormatOfString(_105);
}
if(_106===CFPropertyList.FormatXML_v1_0){
return CFPropertyList.propertyListFromXML(_105);
}
if(_106===CFPropertyList.Format280North_v1_0){
return _107(_105);
}
return NULL;
};
var _d5="A",_d6="D",_d7="f",_d8="d",_d9="S",_da="T",_db="F",_dc="K",_dd="E";
function _107(_108){
var _109=new _10a(_108),_10b=NULL,key="",_10c=NULL,_10d=NULL,_10e=[],_10f=NULL;
while(_10b=_109.getMarker()){
if(_10b===_dd){
_10e.pop();
continue;
}
var _110=_10e.length;
if(_110){
_10f=_10e[_110-1];
}
if(_10b===_dc){
key=_109.getString();
_10b=_109.getMarker();
}
switch(_10b){
case _d5:
_10c=[];
_10e.push(_10c);
break;
case _d6:
_10c=new CFMutableDictionary();
_10e.push(_10c);
break;
case _d7:
_10c=parseFloat(_109.getString());
break;
case _d8:
_10c=parseInt(_109.getString(),10);
break;
case _d9:
_10c=_109.getString();
break;
case _da:
_10c=YES;
break;
case _db:
_10c=NO;
break;
default:
throw new Error("*** "+_10b+" marker not recognized in Plist.");
}
if(!_10d){
_10d=_10c;
}else{
if(_10f){
if(_10f.slice){
_10f.push(_10c);
}else{
_10f.setValueForKey(key,_10c);
}
}
}
}
return _10d;
};
function _c7(_111){
return _111.replace(/&/g,"&amp;").replace(/"/g,"&quot;").replace(/'/g,"&apos;").replace(/</g,"&lt;").replace(/>/g,"&gt;");
};
function _112(_113){
return _113.replace(/&quot;/g,"\"").replace(/&apos;/g,"'").replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&amp;/g,"&");
};
function _9b(_114){
if(window.DOMParser){
return (new window.DOMParser().parseFromString(_114,"text/xml").documentElement);
}else{
if(window.ActiveXObject){
XMLNode=new ActiveXObject("Microsoft.XMLDOM");
var _115=_114.match(CFPropertyList.DTDRE);
if(_115){
_114=_114.substr(_115[0].length);
}
XMLNode.loadXML(_114);
return XMLNode;
}
}
return NULL;
};
CFPropertyList.propertyListFromXML=function(_116){
var _117=_116;
if(_116.valueOf&&typeof _116.valueOf()==="string"){
_117=_9b(_116);
}
while(((String(_117.nodeName))===_ef)||((String(_117.nodeName))===_ee)){
_117=(_117.firstChild);
}
if(_117!==NULL&&((_117.nodeType)===8||(_117.nodeType)===3)){
while((_117=(_117.nextSibling))&&((_117.nodeType)===8||(_117.nodeType)===3)){
}
}
if(((_117.nodeType)===10)){
while((_117=(_117.nextSibling))&&((_117.nodeType)===8||(_117.nodeType)===3)){
}
}
if(!((String(_117.nodeName))===_f0)){
return NULL;
}
var key="",_118=NULL,_119=NULL,_11a=_117,_11b=[],_11c=NULL;
while(_117=_ff(_117,_11a,_11b)){
var _11d=_11b.length;
if(_11d){
_11c=_11b[_11d-1];
}
if((String(_117.nodeName))===_f1){
key=(_117.textContent||(_117.textContent!==""&&_fa([_117])));
while((_117=(_117.nextSibling))&&((_117.nodeType)===8||(_117.nodeType)===3)){
}
}
switch(String((String(_117.nodeName)))){
case _f3:
_118=[];
_11b.push(_118);
break;
case _f2:
_118=new CFMutableDictionary();
_11b.push(_118);
break;
case _f7:
_118=parseFloat((_117.textContent||(_117.textContent!==""&&_fa([_117]))));
break;
case _f8:
_118=parseInt((_117.textContent||(_117.textContent!==""&&_fa([_117]))),10);
break;
case _f4:
if((_117.getAttribute("type")==="base64")){
_118=(_117.firstChild)?CFData.decodeBase64ToString((_117.textContent||(_117.textContent!==""&&_fa([_117])))):"";
}else{
_118=_112((_117.firstChild)?(_117.textContent||(_117.textContent!==""&&_fa([_117]))):"");
}
break;
case _f5:
_118=YES;
break;
case _f6:
_118=NO;
break;
case _f9:
_118=new CFMutableData();
_118.bytes=(_117.firstChild)?CFData.decodeBase64ToArray((_117.textContent||(_117.textContent!==""&&_fa([_117]))),YES):[];
break;
default:
throw new Error("*** "+(String(_117.nodeName))+" tag not recognized in Plist.");
}
if(!_119){
_119=_118;
}else{
if(_11c){
if(_11c.slice){
_11c.push(_118);
}else{
_11c.setValueForKey(key,_118);
}
}
}
}
return _119;
};
kCFPropertyListOpenStepFormat=CFPropertyList.FormatOpenStep;
kCFPropertyListXMLFormat_v1_0=CFPropertyList.FormatXML_v1_0;
kCFPropertyListBinaryFormat_v1_0=CFPropertyList.FormatBinary_v1_0;
kCFPropertyList280NorthFormat_v1_0=CFPropertyList.Format280North_v1_0;
CFPropertyListCreate=function(){
return new CFPropertyList();
};
CFPropertyListCreateFromXMLData=function(data){
return CFPropertyList.propertyListFromData(data,CFPropertyList.FormatXML_v1_0);
};
CFPropertyListCreateXMLData=function(_11e){
return CFPropertyList.dataFromPropertyList(_11e,CFPropertyList.FormatXML_v1_0);
};
CFPropertyListCreateFrom280NorthData=function(data){
return CFPropertyList.propertyListFromData(data,CFPropertyList.Format280North_v1_0);
};
CFPropertyListCreate280NorthData=function(_11f){
return CFPropertyList.dataFromPropertyList(_11f,CFPropertyList.Format280North_v1_0);
};
CPPropertyListCreateFromData=function(data,_120){
return CFPropertyList.propertyListFromData(data,_120);
};
CPPropertyListCreateData=function(_121,_122){
return CFPropertyList.dataFromPropertyList(_121,_122);
};
CFDictionary=function(_123){
this._keys=[];
this._count=0;
this._buckets={};
this._UID=objj_generateObjectUID();
};
var _124=Array.prototype.indexOf,_7b=Object.prototype.hasOwnProperty;
CFDictionary.prototype.copy=function(){
return this;
};
CFDictionary.prototype.mutableCopy=function(){
var _125=new CFMutableDictionary(),keys=this._keys,_126=this._count;
_125._keys=keys.slice();
_125._count=_126;
var _127=0,_128=this._buckets,_129=_125._buckets;
for(;_127<_126;++_127){
var key=keys[_127];
_129[key]=_128[key];
}
return _125;
};
CFDictionary.prototype.containsKey=function(aKey){
return _7b.apply(this._buckets,[aKey]);
};
CFDictionary.prototype.containsValue=function(_12a){
var keys=this._keys,_12b=this._buckets,_96=0,_12c=keys.length;
for(;_96<_12c;++_96){
if(_12b[keys[_96]]===_12a){
return YES;
}
}
return NO;
};
CFDictionary.prototype.count=function(){
return this._count;
};
CFDictionary.prototype.countOfKey=function(aKey){
return this.containsKey(aKey)?1:0;
};
CFDictionary.prototype.countOfValue=function(_12d){
var keys=this._keys,_12e=this._buckets,_96=0,_12f=keys.length,_130=0;
for(;_96<_12f;++_96){
if(_12e[keys[_96]]===_12d){
++_130;
}
}
return _130;
};
CFDictionary.prototype.keys=function(){
return this._keys.slice();
};
CFDictionary.prototype.valueForKey=function(aKey){
var _131=this._buckets;
if(!_7b.apply(_131,[aKey])){
return nil;
}
return _131[aKey];
};
CFDictionary.prototype.toString=function(){
var _132="{\n",keys=this._keys,_96=0,_133=this._count;
for(;_96<_133;++_96){
var key=keys[_96];
_132+="\t"+key+" = \""+String(this.valueForKey(key)).split("\n").join("\n\t")+"\"\n";
}
return _132+"}";
};
CFMutableDictionary=function(_134){
CFDictionary.apply(this,[]);
};
CFMutableDictionary.prototype=new CFDictionary();
CFMutableDictionary.prototype.copy=function(){
return this.mutableCopy();
};
CFMutableDictionary.prototype.addValueForKey=function(aKey,_135){
if(this.containsKey(aKey)){
return;
}
++this._count;
this._keys.push(aKey);
this._buckets[aKey]=_135;
};
CFMutableDictionary.prototype.removeValueForKey=function(aKey){
var _136=-1;
if(_124){
_136=_124.call(this._keys,aKey);
}else{
var keys=this._keys,_96=0,_137=keys.length;
for(;_96<_137;++_96){
if(keys[_96]===aKey){
_136=_96;
break;
}
}
}
if(_136===-1){
return;
}
--this._count;
this._keys.splice(_136,1);
delete this._buckets[aKey];
};
CFMutableDictionary.prototype.removeAllValues=function(){
this._count=0;
this._keys=[];
this._buckets={};
};
CFMutableDictionary.prototype.replaceValueForKey=function(aKey,_138){
if(!this.containsKey(aKey)){
return;
}
this._buckets[aKey]=_138;
};
CFMutableDictionary.prototype.setValueForKey=function(aKey,_139){
if(_139===nil||_139===_29){
this.removeValueForKey(aKey);
}else{
if(this.containsKey(aKey)){
this.replaceValueForKey(aKey,_139);
}else{
this.addValueForKey(aKey,_139);
}
}
};
CFData=function(){
this._rawString=NULL;
this._propertyList=NULL;
this._propertyListFormat=NULL;
this._JSONObject=NULL;
this._bytes=NULL;
this._base64=NULL;
};
CFData.prototype.propertyList=function(){
if(!this._propertyList){
this._propertyList=CFPropertyList.propertyListFromString(this.rawString());
}
return this._propertyList;
};
CFData.prototype.JSONObject=function(){
if(!this._JSONObject){
try{
this._JSONObject=JSON.parse(this.rawString());
}
catch(anException){
}
}
return this._JSONObject;
};
CFData.prototype.rawString=function(){
if(this._rawString===NULL){
if(this._propertyList){
this._rawString=CFPropertyList.stringFromPropertyList(this._propertyList,this._propertyListFormat);
}else{
if(this._JSONObject){
this._rawString=JSON.stringify(this._JSONObject);
}else{
throw new Error("Can't convert data to string.");
}
}
}
return this._rawString;
};
CFData.prototype.bytes=function(){
return this._bytes;
};
CFData.prototype.base64=function(){
return this._base64;
};
CFMutableData=function(){
CFData.call(this);
};
CFMutableData.prototype=new CFData();
function _13a(_13b){
this._rawString=NULL;
this._propertyList=NULL;
this._propertyListFormat=NULL;
this._JSONObject=NULL;
this._bytes=NULL;
this._base64=NULL;
};
CFMutableData.prototype.setPropertyList=function(_13c,_13d){
_13a(this);
this._propertyList=_13c;
this._propertyListFormat=_13d;
};
CFMutableData.prototype.setJSONObject=function(_13e){
_13a(this);
this._JSONObject=_13e;
};
CFMutableData.prototype.setRawString=function(_13f){
_13a(this);
this._rawString=_13f;
};
CFMutableData.prototype.setBytes=function(_140){
_13a(this);
this._bytes=_140;
};
CFMutableData.prototype.setBase64String=function(_141){
_13a(this);
this._base64=_141;
};
var _142=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9","+","/","="],_143=[];
for(var i=0;i<_142.length;i++){
_143[_142[i].charCodeAt(0)]=i;
}
CFData.decodeBase64ToArray=function(_144,_145){
if(_145){
_144=_144.replace(/[^A-Za-z0-9\+\/\=]/g,"");
}
var pad=(_144[_144.length-1]=="="?1:0)+(_144[_144.length-2]=="="?1:0),_146=_144.length,_147=[];
var i=0;
while(i<_146){
var bits=(_143[_144.charCodeAt(i++)]<<18)|(_143[_144.charCodeAt(i++)]<<12)|(_143[_144.charCodeAt(i++)]<<6)|(_143[_144.charCodeAt(i++)]);
_147.push((bits&16711680)>>16);
_147.push((bits&65280)>>8);
_147.push(bits&255);
}
if(pad>0){
return _147.slice(0,-1*pad);
}
return _147;
};
CFData.encodeBase64Array=function(_148){
var pad=(3-(_148.length%3))%3,_149=_148.length+pad,_14a=[];
if(pad>0){
_148.push(0);
}
if(pad>1){
_148.push(0);
}
var i=0;
while(i<_149){
var bits=(_148[i++]<<16)|(_148[i++]<<8)|(_148[i++]);
_14a.push(_142[(bits&16515072)>>18]);
_14a.push(_142[(bits&258048)>>12]);
_14a.push(_142[(bits&4032)>>6]);
_14a.push(_142[bits&63]);
}
if(pad>0){
_14a[_14a.length-1]="=";
_148.pop();
}
if(pad>1){
_14a[_14a.length-2]="=";
_148.pop();
}
return _14a.join("");
};
CFData.decodeBase64ToString=function(_14b,_14c){
return CFData.bytesToString(CFData.decodeBase64ToArray(_14b,_14c));
};
CFData.decodeBase64ToUtf16String=function(_14d,_14e){
return CFData.bytesToUtf16String(CFData.decodeBase64ToArray(_14d,_14e));
};
CFData.bytesToString=function(_14f){
return String.fromCharCode.apply(NULL,_14f);
};
CFData.encodeBase64String=function(_150){
var temp=[];
for(var i=0;i<_150.length;i++){
temp.push(_150.charCodeAt(i));
}
return CFData.encodeBase64Array(temp);
};
CFData.bytesToUtf16String=function(_151){
var temp=[];
for(var i=0;i<_151.length;i+=2){
temp.push(_151[i+1]<<8|_151[i]);
}
return String.fromCharCode.apply(NULL,temp);
};
CFData.encodeBase64Utf16String=function(_152){
var temp=[];
for(var i=0;i<_152.length;i++){
var c=_152.charCodeAt(i);
temp.push(_152.charCodeAt(i)&255);
temp.push((_152.charCodeAt(i)&65280)>>8);
}
return CFData.encodeBase64Array(temp);
};
var _153,_154,_155=0;
function _156(){
if(++_155!==1){
return;
}
_153={};
_154={};
};
function _157(){
_155=MAX(_155-1,0);
if(_155!==0){
return;
}
delete _153;
delete _154;
};
var _158=new RegExp("^"+"(?:"+"([^:/?#]+):"+")?"+"(?:"+"(//)"+"("+"(?:"+"("+"([^:@]*)"+":?"+"([^:@]*)"+")?"+"@"+")?"+"([^:/?#]*)"+"(?::(\\d*))?"+")"+")?"+"([^?#]*)"+"(?:\\?([^#]*))?"+"(?:#(.*))?");
var _159=["url","scheme","authorityRoot","authority","userInfo","user","password","domain","portNumber","path","queryString","fragment"];
function _15a(aURL){
if(aURL._parts){
return aURL._parts;
}
var _15b=aURL.string(),_15c=_15b.match(/^mhtml:/);
if(_15c){
_15b=_15b.substr("mhtml:".length);
}
if(_155>0&&_7b.call(_154,_15b)){
aURL._parts=_154[_15b];
return aURL._parts;
}
aURL._parts={};
var _15d=aURL._parts,_15e=_158.exec(_15b),_96=_15e.length;
while(_96--){
_15d[_159[_96]]=_15e[_96]||NULL;
}
_15d.portNumber=parseInt(_15d.portNumber,10);
if(isNaN(_15d.portNumber)){
_15d.portNumber=-1;
}
_15d.pathComponents=[];
if(_15d.path){
var _15f=_15d.path.split("/"),_160=_15d.pathComponents,_96=0,_161=_15f.length;
for(;_96<_161;++_96){
var _162=_15f[_96];
if(_162){
_160.push(_162);
}else{
if(_96===0){
_160.push("/");
}
}
}
_15d.pathComponents=_160;
}
if(_15c){
_15d.url="mhtml:"+_15d.url;
_15d.scheme="mhtml:"+_15d.scheme;
}
if(_155>0){
_154[_15b]=_15d;
}
return _15d;
};
CFURL=function(aURL,_163){
aURL=aURL||"";
if(aURL instanceof CFURL){
if(!_163){
return aURL;
}
var _164=aURL.baseURL();
if(_164){
_163=new CFURL(_164.absoluteURL(),_163);
}
aURL=aURL.string();
}
if(_155>0){
var _165=aURL+" "+(_163&&_163.UID()||"");
if(_7b.call(_153,_165)){
return _153[_165];
}
_153[_165]=this;
}
if(aURL.match(/^data:/)){
var _166={},_96=_159.length;
while(_96--){
_166[_159[_96]]="";
}
_166.url=aURL;
_166.scheme="data";
_166.pathComponents=[];
this._parts=_166;
this._standardizedURL=this;
this._absoluteURL=this;
}
this._UID=objj_generateObjectUID();
this._string=aURL;
this._baseURL=_163;
};
CFURL.prototype.UID=function(){
return this._UID;
};
var _167={};
CFURL.prototype.mappedURL=function(){
return _167[this.absoluteString()]||this;
};
CFURL.setMappedURLForURL=function(_168,_169){
_167[_168.absoluteString()]=_169;
};
CFURL.prototype.schemeAndAuthority=function(){
var _16a="",_16b=this.scheme();
if(_16b){
_16a+=_16b+":";
}
var _16c=this.authority();
if(_16c){
_16a+="//"+_16c;
}
return _16a;
};
CFURL.prototype.absoluteString=function(){
if(this._absoluteString===_29){
this._absoluteString=this.absoluteURL().string();
}
return this._absoluteString;
};
CFURL.prototype.toString=function(){
return this.absoluteString();
};
function _16d(aURL){
aURL=aURL.standardizedURL();
var _16e=aURL.baseURL();
if(!_16e){
return aURL;
}
var _16f=((aURL)._parts||_15a(aURL)),_170,_171=_16e.absoluteURL(),_172=((_171)._parts||_15a(_171));
if(_16f.scheme||_16f.authority){
_170=_16f;
}else{
_170={};
_170.scheme=_172.scheme;
_170.authority=_172.authority;
_170.userInfo=_172.userInfo;
_170.user=_172.user;
_170.password=_172.password;
_170.domain=_172.domain;
_170.portNumber=_172.portNumber;
_170.queryString=_16f.queryString;
_170.fragment=_16f.fragment;
var _173=_16f.pathComponents;
if(_173.length&&_173[0]==="/"){
_170.path=_16f.path;
_170.pathComponents=_173;
}else{
var _174=_172.pathComponents,_175=_174.concat(_173);
if(!_16e.hasDirectoryPath()&&_174.length){
_175.splice(_174.length-1,1);
}
if(_173.length&&(_173[0]===".."||_173[0]===".")){
_176(_175,YES);
}
_170.pathComponents=_175;
_170.path=_177(_175,_173.length<=0||aURL.hasDirectoryPath());
}
}
var _178=_179(_170),_17a=new CFURL(_178);
_17a._parts=_170;
_17a._standardizedURL=_17a;
_17a._standardizedString=_178;
_17a._absoluteURL=_17a;
_17a._absoluteString=_178;
return _17a;
};
function _177(_17b,_17c){
var path=_17b.join("/");
if(path.length&&path.charAt(0)==="/"){
path=path.substr(1);
}
if(_17c){
path+="/";
}
return path;
};
function _176(_17d,_17e){
var _17f=0,_180=0,_181=_17d.length,_182=_17e?_17d:[],_183=NO;
for(;_17f<_181;++_17f){
var _184=_17d[_17f];
if(_184===""){
continue;
}
if(_184==="."){
_183=_180===0;
continue;
}
if(_184!==".."||_180===0||_182[_180-1]===".."){
_182[_180]=_184;
_180++;
continue;
}
if(_180>0&&_182[_180-1]!=="/"){
--_180;
}
}
if(_183&&_180===0){
_182[_180++]=".";
}
_182.length=_180;
return _182;
};
function _179(_185){
var _186="",_187=_185.scheme;
if(_187){
_186+=_187+":";
}
var _188=_185.authority;
if(_188){
_186+="//"+_188;
}
_186+=_185.path;
var _189=_185.queryString;
if(_189){
_186+="?"+_189;
}
var _18a=_185.fragment;
if(_18a){
_186+="#"+_18a;
}
return _186;
};
CFURL.prototype.absoluteURL=function(){
if(this._absoluteURL===_29){
this._absoluteURL=_16d(this);
}
return this._absoluteURL;
};
CFURL.prototype.standardizedURL=function(){
if(this._standardizedURL===_29){
var _18b=((this)._parts||_15a(this)),_18c=_18b.pathComponents,_18d=_176(_18c,NO);
var _18e=_177(_18d,this.hasDirectoryPath());
if(_18b.path===_18e){
this._standardizedURL=this;
}else{
var _18f=_190(_18b);
_18f.pathComponents=_18d;
_18f.path=_18e;
var _191=new CFURL(_179(_18f),this.baseURL());
_191._parts=_18f;
_191._standardizedURL=_191;
this._standardizedURL=_191;
}
}
return this._standardizedURL;
};
function _190(_192){
var _193={},_194=_159.length;
while(_194--){
var _195=_159[_194];
_193[_195]=_192[_195];
}
return _193;
};
CFURL.prototype.string=function(){
return this._string;
};
CFURL.prototype.authority=function(){
var _196=((this)._parts||_15a(this)).authority;
if(_196){
return _196;
}
var _197=this.baseURL();
return _197&&_197.authority()||"";
};
CFURL.prototype.hasDirectoryPath=function(){
var _198=this._hasDirectoryPath;
if(_198===_29){
var path=this.path();
if(!path){
return NO;
}
if(path.charAt(path.length-1)==="/"){
return YES;
}
var _199=this.lastPathComponent();
_198=_199==="."||_199==="..";
this._hasDirectoryPath=_198;
}
return _198;
};
CFURL.prototype.hostName=function(){
return this.authority();
};
CFURL.prototype.fragment=function(){
return ((this)._parts||_15a(this)).fragment;
};
CFURL.prototype.lastPathComponent=function(){
if(this._lastPathComponent===_29){
var _19a=this.pathComponents(),_19b=_19a.length;
if(!_19b){
this._lastPathComponent="";
}else{
this._lastPathComponent=_19a[_19b-1];
}
}
return this._lastPathComponent;
};
CFURL.prototype.path=function(){
return ((this)._parts||_15a(this)).path;
};
CFURL.prototype.pathComponents=function(){
return ((this)._parts||_15a(this)).pathComponents;
};
CFURL.prototype.pathExtension=function(){
var _19c=this.lastPathComponent();
if(!_19c){
return NULL;
}
_19c=_19c.replace(/^\.*/,"");
var _19d=_19c.lastIndexOf(".");
return _19d<=0?"":_19c.substring(_19d+1);
};
CFURL.prototype.queryString=function(){
return ((this)._parts||_15a(this)).queryString;
};
CFURL.prototype.scheme=function(){
var _19e=this._scheme;
if(_19e===_29){
_19e=((this)._parts||_15a(this)).scheme;
if(!_19e){
var _19f=this.baseURL();
_19e=_19f&&_19f.scheme();
}
this._scheme=_19e;
}
return _19e;
};
CFURL.prototype.user=function(){
return ((this)._parts||_15a(this)).user;
};
CFURL.prototype.password=function(){
return ((this)._parts||_15a(this)).password;
};
CFURL.prototype.portNumber=function(){
return ((this)._parts||_15a(this)).portNumber;
};
CFURL.prototype.domain=function(){
return ((this)._parts||_15a(this)).domain;
};
CFURL.prototype.baseURL=function(){
return this._baseURL;
};
CFURL.prototype.asDirectoryPathURL=function(){
if(this.hasDirectoryPath()){
return this;
}
var _1a0=this.lastPathComponent();
if(_1a0!=="/"){
_1a0="./"+_1a0;
}
return new CFURL(_1a0+"/",this);
};
function _1a1(aURL){
if(!aURL._resourcePropertiesForKeys){
aURL._resourcePropertiesForKeys=new CFMutableDictionary();
}
return aURL._resourcePropertiesForKeys;
};
CFURL.prototype.resourcePropertyForKey=function(aKey){
return _1a1(this).valueForKey(aKey);
};
CFURL.prototype.setResourcePropertyForKey=function(aKey,_1a2){
_1a1(this).setValueForKey(aKey,_1a2);
};
CFURL.prototype.staticResourceData=function(){
var data=new CFMutableData();
data.setRawString(_1a3.resourceAtURL(this).contents());
return data;
};
function _10a(_1a4){
this._string=_1a4;
var _1a5=_1a4.indexOf(";");
this._magicNumber=_1a4.substr(0,_1a5);
this._location=_1a4.indexOf(";",++_1a5);
this._version=_1a4.substring(_1a5,this._location++);
};
_10a.prototype.magicNumber=function(){
return this._magicNumber;
};
_10a.prototype.version=function(){
return this._version;
};
_10a.prototype.getMarker=function(){
var _1a6=this._string,_1a7=this._location;
if(_1a7>=_1a6.length){
return null;
}
var next=_1a6.indexOf(";",_1a7);
if(next<0){
return null;
}
var _1a8=_1a6.substring(_1a7,next);
if(_1a8==="e"){
return null;
}
this._location=next+1;
return _1a8;
};
_10a.prototype.getString=function(){
var _1a9=this._string,_1aa=this._location;
if(_1aa>=_1a9.length){
return null;
}
var next=_1a9.indexOf(";",_1aa);
if(next<0){
return null;
}
var size=parseInt(_1a9.substring(_1aa,next),10),text=_1a9.substr(next+1,size);
this._location=next+1+size;
return text;
};
var _1ab=0,_1ac=1<<0,_1ad=1<<1,_1ae=1<<2,_1af=1<<3,_1b0=1<<4;
var _1b1={},_1b2={},_1b3=new Date().getTime(),_1b4=0,_1b5=0;
CFBundle=function(aURL){
aURL=_1b6(aURL).asDirectoryPathURL();
var _1b7=aURL.absoluteString(),_1b8=_1b1[_1b7];
if(_1b8){
return _1b8;
}
_1b1[_1b7]=this;
this._bundleURL=aURL;
this._resourcesDirectoryURL=new CFURL("Resources/",aURL);
this._staticResource=NULL;
this._isValid=NO;
this._loadStatus=_1ab;
this._loadRequests=[];
this._infoDictionary=new CFDictionary();
this._eventDispatcher=new _76(this);
};
CFBundle.environments=function(){
return ["Browser","ObjJ"];
};
CFBundle.bundleContainingURL=function(aURL){
aURL=new CFURL(".",_1b6(aURL));
var _1b9,_1ba=aURL.absoluteString();
while(!_1b9||_1b9!==_1ba){
var _1bb=_1b1[_1ba];
if(_1bb&&_1bb._isValid){
return _1bb;
}
aURL=new CFURL("..",aURL);
_1b9=_1ba;
_1ba=aURL.absoluteString();
}
return NULL;
};
CFBundle.mainBundle=function(){
return new CFBundle(_1bc);
};
function _1bd(_1be,_1bf){
if(_1bf){
_1b2[_1be.name]=_1bf;
}
};
CFBundle.bundleForClass=function(_1c0){
return _1b2[_1c0.name]||CFBundle.mainBundle();
};
CFBundle.prototype.bundleURL=function(){
return this._bundleURL;
};
CFBundle.prototype.resourcesDirectoryURL=function(){
return this._resourcesDirectoryURL;
};
CFBundle.prototype.resourceURL=function(_1c1,_1c2,_1c3){
if(_1c2){
_1c1=_1c1+"."+_1c2;
}
if(_1c3){
_1c1=_1c3+"/"+_1c1;
}
var _1c4=(new CFURL(_1c1,this.resourcesDirectoryURL())).mappedURL();
return _1c4.absoluteURL();
};
CFBundle.prototype.mostEligibleEnvironmentURL=function(){
if(this._mostEligibleEnvironmentURL===_29){
this._mostEligibleEnvironmentURL=new CFURL(this.mostEligibleEnvironment()+".environment/",this.bundleURL());
}
return this._mostEligibleEnvironmentURL;
};
CFBundle.prototype.executableURL=function(){
if(this._executableURL===_29){
var _1c5=this.valueForInfoDictionaryKey("CPBundleExecutable");
if(!_1c5){
this._executableURL=NULL;
}else{
this._executableURL=new CFURL(_1c5,this.mostEligibleEnvironmentURL());
}
}
return this._executableURL;
};
CFBundle.prototype.infoDictionary=function(){
return this._infoDictionary;
};
CFBundle.prototype.valueForInfoDictionaryKey=function(aKey){
return this._infoDictionary.valueForKey(aKey);
};
CFBundle.prototype.hasSpritedImages=function(){
var _1c6=this._infoDictionary.valueForKey("CPBundleEnvironmentsWithImageSprites")||[],_96=_1c6.length,_1c7=this.mostEligibleEnvironment();
while(_96--){
if(_1c6[_96]===_1c7){
return YES;
}
}
return NO;
};
CFBundle.prototype.environments=function(){
return this._infoDictionary.valueForKey("CPBundleEnvironments")||["ObjJ"];
};
CFBundle.prototype.mostEligibleEnvironment=function(_1c8){
_1c8=_1c8||this.environments();
var _1c9=CFBundle.environments(),_96=0,_1ca=_1c9.length,_1cb=_1c8.length;
for(;_96<_1ca;++_96){
var _1cc=0,_1cd=_1c9[_96];
for(;_1cc<_1cb;++_1cc){
if(_1cd===_1c8[_1cc]){
return _1cd;
}
}
}
return NULL;
};
CFBundle.prototype.isLoading=function(){
return this._loadStatus&_1ac;
};
CFBundle.prototype.isLoaded=function(){
return this._loadStatus&_1b0;
};
CFBundle.prototype.load=function(_1ce){
if(this._loadStatus!==_1ab){
return;
}
this._loadStatus=_1ac|_1ad;
var self=this,_1cf=this.bundleURL(),_1d0=new CFURL("..",_1cf);
if(_1d0.absoluteString()===_1cf.absoluteString()){
_1d0=_1d0.schemeAndAuthority();
}
_1a3.resolveResourceAtURL(_1d0,YES,function(_1d1){
var _1d2=_1cf.absoluteURL().lastPathComponent();
self._staticResource=_1d1._children[_1d2]||new _1a3(_1cf,_1d1,YES,NO);
function _1d3(_1d4){
self._loadStatus&=~_1ad;
var _1d5=_1d4.request.responsePropertyList();
self._isValid=!!_1d5||CFBundle.mainBundle()===self;
if(_1d5){
self._infoDictionary=_1d5;
}
if(!self._infoDictionary){
_1d7(self,new Error("Could not load bundle at \""+path+"\""));
return;
}
if(self===CFBundle.mainBundle()&&self.valueForInfoDictionaryKey("CPApplicationSize")){
_1b5=self.valueForInfoDictionaryKey("CPApplicationSize").valueForKey("executable")||0;
}
_1db(self,_1ce);
};
function _1d6(){
self._isValid=CFBundle.mainBundle()===self;
self._loadStatus=_1ab;
_1d7(self,new Error("Could not load bundle at \""+self.bundleURL()+"\""));
};
new _b2(new CFURL("Info.plist",self.bundleURL()),_1d3,_1d6);
});
};
function _1d7(_1d8,_1d9){
_1da(_1d8._staticResource);
_1d8._eventDispatcher.dispatchEvent({type:"error",error:_1d9,bundle:_1d8});
};
function _1db(_1dc,_1dd){
if(!_1dc.mostEligibleEnvironment()){
return _1de();
}
_1df(_1dc,_1e0,_1de);
_1e1(_1dc,_1e0,_1de);
if(_1dc._loadStatus===_1ac){
return _1e0();
}
function _1de(_1e2){
var _1e3=_1dc._loadRequests,_1e4=_1e3.length;
while(_1e4--){
_1e3[_1e4].abort();
}
this._loadRequests=[];
_1dc._loadStatus=_1ab;
_1d7(_1dc,_1e2||new Error("Could not recognize executable code format in Bundle "+_1dc));
};
function _1e0(){
if((typeof CPApp==="undefined"||!CPApp||!CPApp._finishedLaunching)&&typeof OBJJ_PROGRESS_CALLBACK==="function"&&_1b5){
OBJJ_PROGRESS_CALLBACK(MAX(MIN(1,_1b4/_1b5),0),_1b5,_1dc.bundlePath());
}
if(_1dc._loadStatus===_1ac){
_1dc._loadStatus=_1b0;
}else{
return;
}
_1da(_1dc._staticResource);
function _1e5(){
_1dc._eventDispatcher.dispatchEvent({type:"load",bundle:_1dc});
};
if(_1dd){
_1e6(_1dc,_1e5);
}else{
_1e5();
}
};
};
function _1df(_1e7,_1e8,_1e9){
var _1ea=_1e7.executableURL();
if(!_1ea){
return;
}
_1e7._loadStatus|=_1ae;
new _b2(_1ea,function(_1eb){
try{
_1b4+=_1eb.request.responseText().length;
_1ec(_1e7,_1eb.request.responseText(),_1ea);
_1e7._loadStatus&=~_1ae;
_1e8();
}
catch(anException){
_1e9(anException);
}
},_1e9);
};
function _1ed(_1ee){
return "mhtml:"+new CFURL("MHTMLTest.txt",_1ee.mostEligibleEnvironmentURL());
};
function _1ef(_1f0){
if(_1f1===_1f2){
return new CFURL("dataURLs.txt",_1f0.mostEligibleEnvironmentURL());
}
if(_1f1===_1f3||_1f1===_1f4){
return new CFURL("MHTMLPaths.txt",_1f0.mostEligibleEnvironmentURL());
}
return NULL;
};
function _1e1(_1f5,_1f6,_1f7){
if(!_1f5.hasSpritedImages()){
return;
}
_1f5._loadStatus|=_1af;
if(!_1f8()){
return _1f9(_1ed(_1f5),function(){
_1e1(_1f5,_1f6,_1f7);
});
}
var _1fa=_1ef(_1f5);
if(!_1fa){
_1f5._loadStatus&=~_1af;
return _1f6();
}
new _b2(_1fa,function(_1fb){
try{
_1b4+=_1fb.request.responseText().length;
_1ec(_1f5,_1fb.request.responseText(),_1fa);
_1f5._loadStatus&=~_1af;
}
catch(anException){
_1f7(anException);
}
_1f6();
},_1f7);
};
var _1fc=[],_1f1=-1,_1fd=0,_1f2=1,_1f3=2,_1f4=3;
function _1f8(){
return _1f1!==-1;
};
function _1f9(_1fe,_1ff){
if(_1f8()){
return;
}
_1fc.push(_1ff);
if(_1fc.length>1){
return;
}
_1fc.push(function(){
var size=0,_200=CFBundle.mainBundle().valueForInfoDictionaryKey("CPApplicationSize");
if(!_200){
return;
}
switch(_1f1){
case _1f2:
size=_200.valueForKey("data");
break;
case _1f3:
case _1f4:
size=_200.valueForKey("mhtml");
break;
}
_1b5+=size;
});
_201([_1f2,"data:image/gif;base64,R0lGODlhAQABAIAAAMc9BQAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==",_1f3,_1fe+"!test",_1f4,_1fe+"?"+_1b3+"!test"]);
};
function _202(){
var _203=_1fc.length;
while(_203--){
_1fc[_203]();
}
};
function _201(_204){
if(_204.length<2){
_1f1=_1fd;
_202();
return;
}
var _205=new Image();
_205.onload=function(){
if(_205.width===1&&_205.height===1){
_1f1=_204[0];
_202();
}else{
_205.onerror();
}
};
_205.onerror=function(){
_201(_204.slice(2));
};
_205.src=_204[1];
};
function _1e6(_206,_207){
var _208=[_206._staticResource];
function _209(_20a){
for(;_20a<_208.length;++_20a){
var _20b=_208[_20a];
if(_20b.isNotFound()){
continue;
}
if(_20b.isFile()){
var _20c=new _324(_20b.URL());
if(_20c.hasLoadedFileDependencies()){
_20c.execute();
}else{
_20c.loadFileDependencies(function(){
_209(_20a);
});
return;
}
}else{
if(_20b.URL().absoluteString()===_206.resourcesDirectoryURL().absoluteString()){
continue;
}
var _20d=_20b.children();
for(var name in _20d){
if(_7b.call(_20d,name)){
_208.push(_20d[name]);
}
}
}
}
_207();
};
_209(0);
};
var _20e="@STATIC",_20f="p",_210="u",_211="c",_212="t",_213="I",_214="i";
function _1ec(_215,_216,_217){
var _218=new _10a(_216);
if(_218.magicNumber()!==_20e){
throw new Error("Could not read static file: "+_217);
}
if(_218.version()!=="1.0"){
throw new Error("Could not read static file: "+_217);
}
var _219,_21a=_215.bundleURL(),file=NULL;
while(_219=_218.getMarker()){
var text=_218.getString();
if(_219===_20f){
var _21b=new CFURL(text,_21a),_21c=_1a3.resourceAtURL(new CFURL(".",_21b),YES);
file=new _1a3(_21b,_21c,NO,YES);
}else{
if(_219===_210){
var URL=new CFURL(text,_21a),_21d=_218.getString();
if(_21d.indexOf("mhtml:")===0){
_21d="mhtml:"+new CFURL(_21d.substr("mhtml:".length),_21a);
if(_1f1===_1f4){
var _21e=_21d.indexOf("!"),_21f=_21d.substring(0,_21e),_220=_21d.substring(_21e);
_21d=_21f+"?"+_1b3+_220;
}
}
CFURL.setMappedURLForURL(URL,new CFURL(_21d));
var _21c=_1a3.resourceAtURL(new CFURL(".",URL),YES);
new _1a3(URL,_21c,NO,YES);
}else{
if(_219===_212){
file.write(text);
}
}
}
}
};
CFBundle.prototype.addEventListener=function(_221,_222){
this._eventDispatcher.addEventListener(_221,_222);
};
CFBundle.prototype.removeEventListener=function(_223,_224){
this._eventDispatcher.removeEventListener(_223,_224);
};
CFBundle.prototype.onerror=function(_225){
throw _225.error;
};
CFBundle.prototype.bundlePath=function(){
return this._bundleURL.absoluteURL().path();
};
CFBundle.prototype.path=function(){
CPLog.warn("CFBundle.prototype.path is deprecated, use CFBundle.prototype.bundlePath instead.");
return this.bundlePath.apply(this,arguments);
};
CFBundle.prototype.pathForResource=function(_226){
return this.resourceURL(_226).absoluteString();
};
var _227={};
function _1a3(aURL,_228,_229,_22a){
this._parent=_228;
this._eventDispatcher=new _76(this);
var name=aURL.absoluteURL().lastPathComponent()||aURL.schemeAndAuthority();
this._name=name;
this._URL=aURL;
this._isResolved=!!_22a;
if(_229){
this._URL=this._URL.asDirectoryPathURL();
}
if(!_228){
_227[name]=this;
}
this._isDirectory=!!_229;
this._isNotFound=NO;
if(_228){
_228._children[name]=this;
}
if(_229){
this._children={};
}else{
this._contents="";
}
};
_1a3.rootResources=function(){
return _227;
};
_2.StaticResource=_1a3;
function _1da(_22b){
_22b._isResolved=YES;
_22b._eventDispatcher.dispatchEvent({type:"resolve",staticResource:_22b});
};
_1a3.prototype.resolve=function(){
if(this.isDirectory()){
var _22c=new CFBundle(this.URL());
_22c.onerror=function(){
};
_22c.load(NO);
}else{
var self=this;
function _22d(_22e){
self._contents=_22e.request.responseText();
_1da(self);
};
function _22f(){
self._isNotFound=YES;
_1da(self);
};
new _b2(this.URL(),_22d,_22f);
}
};
_1a3.prototype.name=function(){
return this._name;
};
_1a3.prototype.URL=function(){
return this._URL;
};
_1a3.prototype.contents=function(){
return this._contents;
};
_1a3.prototype.children=function(){
return this._children;
};
_1a3.prototype.parent=function(){
return this._parent;
};
_1a3.prototype.isResolved=function(){
return this._isResolved;
};
_1a3.prototype.write=function(_230){
this._contents+=_230;
};
function _231(_232){
var _233=_232.schemeAndAuthority(),_234=_227[_233];
if(!_234){
_234=new _1a3(new CFURL(_233),NULL,YES,YES);
}
return _234;
};
_1a3.resourceAtURL=function(aURL,_235){
aURL=_1b6(aURL).absoluteURL();
var _236=_231(aURL),_237=aURL.pathComponents(),_96=0,_238=_237.length;
for(;_96<_238;++_96){
var name=_237[_96];
if(_7b.call(_236._children,name)){
_236=_236._children[name];
}else{
if(_235){
if(name!=="/"){
name="./"+name;
}
_236=new _1a3(new CFURL(name,_236.URL()),_236,YES,YES);
}else{
throw new Error("Static Resource at "+aURL+" is not resolved (\""+name+"\")");
}
}
}
return _236;
};
_1a3.prototype.resourceAtURL=function(aURL,_239){
return _1a3.resourceAtURL(new CFURL(aURL,this.URL()),_239);
};
_1a3.resolveResourceAtURL=function(aURL,_23a,_23b){
aURL=_1b6(aURL).absoluteURL();
_23c(_231(aURL),_23a,aURL.pathComponents(),0,_23b);
};
_1a3.prototype.resolveResourceAtURL=function(aURL,_23d,_23e){
_1a3.resolveResourceAtURL(new CFURL(aURL,this.URL()).absoluteURL(),_23d,_23e);
};
function _23c(_23f,_240,_241,_242,_243){
var _244=_241.length;
for(;_242<_244;++_242){
var name=_241[_242],_245=_7b.call(_23f._children,name)&&_23f._children[name];
if(!_245){
_245=new _1a3(new CFURL(name,_23f.URL()),_23f,_242+1<_244||_240,NO);
_245.resolve();
}
if(!_245.isResolved()){
return _245.addEventListener("resolve",function(){
_23c(_23f,_240,_241,_242,_243);
});
}
if(_245.isNotFound()){
return _243(null,new Error("File not found: "+_241.join("/")));
}
if((_242+1<_244)&&_245.isFile()){
return _243(null,new Error("File is not a directory: "+_241.join("/")));
}
_23f=_245;
}
_243(_23f);
};
function _246(aURL,_247,_248){
var _249=_1a3.includeURLs(),_24a=new CFURL(aURL,_249[_247]).absoluteURL();
_1a3.resolveResourceAtURL(_24a,NO,function(_24b){
if(!_24b){
if(_247+1<_249.length){
_246(aURL,_247+1,_248);
}else{
_248(NULL);
}
return;
}
_248(_24b);
});
};
_1a3.resolveResourceAtURLSearchingIncludeURLs=function(aURL,_24c){
_246(aURL,0,_24c);
};
_1a3.prototype.addEventListener=function(_24d,_24e){
this._eventDispatcher.addEventListener(_24d,_24e);
};
_1a3.prototype.removeEventListener=function(_24f,_250){
this._eventDispatcher.removeEventListener(_24f,_250);
};
_1a3.prototype.isNotFound=function(){
return this._isNotFound;
};
_1a3.prototype.isFile=function(){
return !this._isDirectory;
};
_1a3.prototype.isDirectory=function(){
return this._isDirectory;
};
_1a3.prototype.toString=function(_251){
if(this.isNotFound()){
return "<file not found: "+this.name()+">";
}
var _252=this.name();
if(this.isDirectory()){
var _253=this._children;
for(var name in _253){
if(_253.hasOwnProperty(name)){
var _254=_253[name];
if(_251||!_254.isNotFound()){
_252+="\n\t"+_253[name].toString(_251).split("\n").join("\n\t");
}
}
}
}
return _252;
};
var _255=NULL;
_1a3.includeURLs=function(){
if(_256){
return _256;
}
var _256=[];
if(!_1.OBJJ_INCLUDE_PATHS&&!_1.OBJJ_INCLUDE_URLS){
_256=["Frameworks","Frameworks/Debug"];
}else{
_256=(_1.OBJJ_INCLUDE_PATHS||[]).concat(_1.OBJJ_INCLUDE_URLS||[]);
}
var _257=_256.length;
while(_257--){
_256[_257]=new CFURL(_256[_257]).asDirectoryPathURL();
}
return _256;
};
var _258="accessors",_259="class",_25a="end",_25b="function",_25c="implementation",_25d="import",_25e="each",_25f="outlet",_260="action",_261="new",_262="selector",_263="super",_264="var",_265="in",_266="pragma",_267="mark",_268="=",_269="+",_26a="-",_26b=":",_26c=",",_26d=".",_26e="*",_26f=";",_270="<",_271="{",_272="}",_273=">",_274="[",_275="\"",_276="@",_277="#",_278="]",_279="?",_27a="(",_27b=")",_27c=/^(?:(?:\s+$)|(?:\/(?:\/|\*)))/,_27d=/^[+-]?\d+(([.]\d+)*([eE][+-]?\d+))?$/,_27e=/^[a-zA-Z_$](\w|$)*$/;
function _27f(_280){
this._index=-1;
this._tokens=(_280+"\n").match(/\/\/.*(\r|\n)?|\/\*(?:.|\n|\r)*?\*\/|\w+\b|[+-]?\d+(([.]\d+)*([eE][+-]?\d+))?|"[^"\\]*(\\[\s\S][^"\\]*)*"|'[^'\\]*(\\[\s\S][^'\\]*)*'|\s+|./g);
this._context=[];
return this;
};
_27f.prototype.push=function(){
this._context.push(this._index);
};
_27f.prototype.pop=function(){
this._index=this._context.pop();
};
_27f.prototype.peek=function(_281){
if(_281){
this.push();
var _282=this.skip_whitespace();
this.pop();
return _282;
}
return this._tokens[this._index+1];
};
_27f.prototype.next=function(){
return this._tokens[++this._index];
};
_27f.prototype.previous=function(){
return this._tokens[--this._index];
};
_27f.prototype.last=function(){
if(this._index<0){
return NULL;
}
return this._tokens[this._index-1];
};
_27f.prototype.skip_whitespace=function(_283){
var _284;
if(_283){
while((_284=this.previous())&&_27c.test(_284)){
}
}else{
while((_284=this.next())&&_27c.test(_284)){
}
}
return _284;
};
_2.Lexer=_27f;
function _285(){
this.atoms=[];
};
_285.prototype.toString=function(){
return this.atoms.join("");
};
_2.preprocess=function(_286,aURL,_287){
return new _288(_286,aURL,_287).executable();
};
_2.eval=function(_289){
return eval(_2.preprocess(_289).code());
};
var _288=function(_28a,aURL,_28b){
this._URL=new CFURL(aURL);
_28a=_28a.replace(/^#[^\n]+\n/,"\n");
this._currentSelector="";
this._currentClass="";
this._currentSuperClass="";
this._currentSuperMetaClass="";
this._buffer=new _285();
this._preprocessed=NULL;
this._dependencies=[];
this._tokens=new _27f(_28a);
this._flags=_28b;
this._classMethod=false;
this._executable=NULL;
this._classLookupTable={};
this._classVars={};
var _28c=new objj_class();
for(var i in _28c){
this._classVars[i]=1;
}
this.preprocess(this._tokens,this._buffer);
};
_288.prototype.setClassInfo=function(_28d,_28e,_28f){
this._classLookupTable[_28d]={superClassName:_28e,ivars:_28f};
};
_288.prototype.getClassInfo=function(_290){
return this._classLookupTable[_290];
};
_288.prototype.allIvarNamesForClassName=function(_291){
var _292={},_293=this.getClassInfo(_291);
while(_293){
for(var i in _293.ivars){
_292[i]=1;
}
_293=this.getClassInfo(_293.superClassName);
}
return _292;
};
_2.Preprocessor=_288;
_288.Flags={};
_288.Flags.IncludeDebugSymbols=1<<0;
_288.Flags.IncludeTypeSignatures=1<<1;
_288.prototype.executable=function(){
if(!this._executable){
this._executable=new _294(this._buffer.toString(),this._dependencies,this._URL);
}
return this._executable;
};
_288.prototype.accessors=function(_295){
var _296=_295.skip_whitespace(),_297={};
if(_296!=_27a){
_295.previous();
return _297;
}
while((_296=_295.skip_whitespace())!=_27b){
var name=_296,_298=true;
if(!/^\w+$/.test(name)){
throw new SyntaxError(this.error_message("*** @accessors attribute name not valid."));
}
if((_296=_295.skip_whitespace())==_268){
_298=_295.skip_whitespace();
if(!/^\w+$/.test(_298)){
throw new SyntaxError(this.error_message("*** @accessors attribute value not valid."));
}
if(name=="setter"){
if((_296=_295.next())!=_26b){
throw new SyntaxError(this.error_message("*** @accessors setter attribute requires argument with \":\" at end of selector name."));
}
_298+=":";
}
_296=_295.skip_whitespace();
}
_297[name]=_298;
if(_296==_27b){
break;
}
if(_296!=_26c){
throw new SyntaxError(this.error_message("*** Expected ',' or ')' in @accessors attribute list."));
}
}
return _297;
};
_288.prototype.brackets=function(_299,_29a){
var _29b=[];
while(this.preprocess(_299,NULL,NULL,NULL,_29b[_29b.length]=[])){
}
if(_29b[0].length===1){
_29a.atoms[_29a.atoms.length]="[";
_29a.atoms[_29a.atoms.length]=_29b[0][0];
_29a.atoms[_29a.atoms.length]="]";
}else{
var _29c=new _285();
if(_29b[0][0].atoms[0]==_263){
_29a.atoms[_29a.atoms.length]="objj_msgSendSuper(";
_29a.atoms[_29a.atoms.length]="{ receiver:self, super_class:"+(this._classMethod?this._currentSuperMetaClass:this._currentSuperClass)+" }";
}else{
_29a.atoms[_29a.atoms.length]="objj_msgSend(";
_29a.atoms[_29a.atoms.length]=_29b[0][0];
}
_29c.atoms[_29c.atoms.length]=_29b[0][1];
var _29d=1,_29e=_29b.length,_29f=new _285();
for(;_29d<_29e;++_29d){
var pair=_29b[_29d];
_29c.atoms[_29c.atoms.length]=pair[1];
_29f.atoms[_29f.atoms.length]=", "+pair[0];
}
_29a.atoms[_29a.atoms.length]=", \"";
_29a.atoms[_29a.atoms.length]=_29c;
_29a.atoms[_29a.atoms.length]="\"";
_29a.atoms[_29a.atoms.length]=_29f;
_29a.atoms[_29a.atoms.length]=")";
}
};
_288.prototype.directive=function(_2a0,_2a1,_2a2){
var _2a3=_2a1?_2a1:new _285(),_2a4=_2a0.next();
if(_2a4.charAt(0)==_275){
_2a3.atoms[_2a3.atoms.length]=_2a4;
}else{
if(_2a4===_259){
_2a0.skip_whitespace();
return;
}else{
if(_2a4===_25c){
this.implementation(_2a0,_2a3);
}else{
if(_2a4===_25d){
this._import(_2a0);
}else{
if(_2a4===_262){
this.selector(_2a0,_2a3);
}
}
}
}
}
if(!_2a1){
return _2a3;
}
};
_288.prototype.hash=function(_2a5,_2a6){
var _2a7=_2a6?_2a6:new _285(),_2a8=_2a5.next();
if(_2a8===_266){
_2a8=_2a5.skip_whitespace();
if(_2a8===_267){
while((_2a8=_2a5.next()).indexOf("\n")<0){
}
}
}else{
throw new SyntaxError(this.error_message("*** Expected \"pragma\" to follow # but instead saw \""+_2a8+"\"."));
}
};
_288.prototype.implementation=function(_2a9,_2aa){
var _2ab=_2aa,_2ac="",_2ad=NO,_2ae=_2a9.skip_whitespace(),_2af="Nil",_2b0=new _285(),_2b1=new _285();
if(!(/^\w/).test(_2ae)){
throw new Error(this.error_message("*** Expected class name, found \""+_2ae+"\"."));
}
this._currentSuperClass="objj_getClass(\""+_2ae+"\").super_class";
this._currentSuperMetaClass="objj_getMetaClass(\""+_2ae+"\").super_class";
this._currentClass=_2ae;
this._currentSelector="";
if((_2ac=_2a9.skip_whitespace())==_27a){
_2ac=_2a9.skip_whitespace();
if(_2ac==_27b){
throw new SyntaxError(this.error_message("*** Can't Have Empty Category Name for class \""+_2ae+"\"."));
}
if(_2a9.skip_whitespace()!=_27b){
throw new SyntaxError(this.error_message("*** Improper Category Definition for class \""+_2ae+"\"."));
}
_2ab.atoms[_2ab.atoms.length]="{\nvar the_class = objj_getClass(\""+_2ae+"\")\n";
_2ab.atoms[_2ab.atoms.length]="if(!the_class) throw new SyntaxError(\"*** Could not find definition for class \\\""+_2ae+"\\\"\");\n";
_2ab.atoms[_2ab.atoms.length]="var meta_class = the_class.isa;";
}else{
if(_2ac==_26b){
_2ac=_2a9.skip_whitespace();
if(!_27e.test(_2ac)){
throw new SyntaxError(this.error_message("*** Expected class name, found \""+_2ac+"\"."));
}
_2af=_2ac;
_2ac=_2a9.skip_whitespace();
}
_2ab.atoms[_2ab.atoms.length]="{var the_class = objj_allocateClassPair("+_2af+", \""+_2ae+"\"),\nmeta_class = the_class.isa;";
if(_2ac==_271){
var _2b2={},_2b3=0,_2b4=[],_2b5,_2b6={};
while((_2ac=_2a9.skip_whitespace())&&_2ac!=_272){
if(_2ac===_276){
_2ac=_2a9.next();
if(_2ac===_258){
_2b5=this.accessors(_2a9);
}else{
if(_2ac!==_25f){
throw new SyntaxError(this.error_message("*** Unexpected '@' token in ivar declaration ('@"+_2ac+"')."));
}
}
}else{
if(_2ac==_26f){
if(_2b3++===0){
_2ab.atoms[_2ab.atoms.length]="class_addIvars(the_class, [";
}else{
_2ab.atoms[_2ab.atoms.length]=", ";
}
var name=_2b4[_2b4.length-1];
_2ab.atoms[_2ab.atoms.length]="new objj_ivar(\""+name+"\")";
_2b2[name]=1;
_2b4=[];
if(_2b5){
_2b6[name]=_2b5;
_2b5=NULL;
}
}else{
_2b4.push(_2ac);
}
}
}
if(_2b4.length){
throw new SyntaxError(this.error_message("*** Expected ';' in ivar declaration, found '}'."));
}
if(_2b3){
_2ab.atoms[_2ab.atoms.length]="]);\n";
}
if(!_2ac){
throw new SyntaxError(this.error_message("*** Expected '}'"));
}
this.setClassInfo(_2ae,_2af==="Nil"?null:_2af,_2b2);
var _2b2=this.allIvarNamesForClassName(_2ae);
for(ivar_name in _2b6){
var _2b7=_2b6[ivar_name],_2b8=_2b7["property"]||ivar_name;
var _2b9=_2b7["getter"]||_2b8,_2ba="(id)"+_2b9+"\n{\nreturn "+ivar_name+";\n}";
if(_2b0.atoms.length!==0){
_2b0.atoms[_2b0.atoms.length]=",\n";
}
_2b0.atoms[_2b0.atoms.length]=this.method(new _27f(_2ba),_2b2);
if(_2b7["readonly"]){
continue;
}
var _2bb=_2b7["setter"];
if(!_2bb){
var _2bc=_2b8.charAt(0)=="_"?1:0;
_2bb=(_2bc?"_":"")+"set"+_2b8.substr(_2bc,1).toUpperCase()+_2b8.substring(_2bc+1)+":";
}
var _2bd="(void)"+_2bb+"(id)newValue\n{\n";
if(_2b7["copy"]){
_2bd+="if ("+ivar_name+" !== newValue)\n"+ivar_name+" = [newValue copy];\n}";
}else{
_2bd+=ivar_name+" = newValue;\n}";
}
if(_2b0.atoms.length!==0){
_2b0.atoms[_2b0.atoms.length]=",\n";
}
_2b0.atoms[_2b0.atoms.length]=this.method(new _27f(_2bd),_2b2);
}
}else{
_2a9.previous();
}
_2ab.atoms[_2ab.atoms.length]="objj_registerClassPair(the_class);\n";
}
if(!_2b2){
var _2b2=this.allIvarNamesForClassName(_2ae);
}
while((_2ac=_2a9.skip_whitespace())){
if(_2ac==_269){
this._classMethod=true;
if(_2b1.atoms.length!==0){
_2b1.atoms[_2b1.atoms.length]=", ";
}
_2b1.atoms[_2b1.atoms.length]=this.method(_2a9,this._classVars);
}else{
if(_2ac==_26a){
this._classMethod=false;
if(_2b0.atoms.length!==0){
_2b0.atoms[_2b0.atoms.length]=", ";
}
_2b0.atoms[_2b0.atoms.length]=this.method(_2a9,_2b2);
}else{
if(_2ac==_277){
this.hash(_2a9,_2ab);
}else{
if(_2ac==_276){
if((_2ac=_2a9.next())==_25a){
break;
}else{
throw new SyntaxError(this.error_message("*** Expected \"@end\", found \"@"+_2ac+"\"."));
}
}
}
}
}
}
if(_2b0.atoms.length!==0){
_2ab.atoms[_2ab.atoms.length]="class_addMethods(the_class, [";
_2ab.atoms[_2ab.atoms.length]=_2b0;
_2ab.atoms[_2ab.atoms.length]="]);\n";
}
if(_2b1.atoms.length!==0){
_2ab.atoms[_2ab.atoms.length]="class_addMethods(meta_class, [";
_2ab.atoms[_2ab.atoms.length]=_2b1;
_2ab.atoms[_2ab.atoms.length]="]);\n";
}
_2ab.atoms[_2ab.atoms.length]="}";
this._currentClass="";
};
_288.prototype._import=function(_2be){
var _2bf="",_2c0=_2be.skip_whitespace(),_2c1=(_2c0!==_270);
if(_2c0===_270){
while((_2c0=_2be.next())&&_2c0!==_273){
_2bf+=_2c0;
}
if(!_2c0){
throw new SyntaxError(this.error_message("*** Unterminated import statement."));
}
}else{
if(_2c0.charAt(0)===_275){
_2bf=_2c0.substr(1,_2c0.length-2);
}else{
throw new SyntaxError(this.error_message("*** Expecting '<' or '\"', found \""+_2c0+"\"."));
}
}
this._buffer.atoms[this._buffer.atoms.length]="objj_executeFile(\"";
this._buffer.atoms[this._buffer.atoms.length]=_2bf;
this._buffer.atoms[this._buffer.atoms.length]=_2c1?"\", YES);":"\", NO);";
this._dependencies.push(new _2c2(new CFURL(_2bf),_2c1));
};
_288.prototype.method=function(_2c3,_2c4){
var _2c5=new _285(),_2c6,_2c7="",_2c8=[],_2c9=[null];
_2c4=_2c4||{};
while((_2c6=_2c3.skip_whitespace())&&_2c6!==_271&&_2c6!==_26f){
if(_2c6==_26b){
var type="";
_2c7+=_2c6;
_2c6=_2c3.skip_whitespace();
if(_2c6==_27a){
while((_2c6=_2c3.skip_whitespace())&&_2c6!=_27b){
type+=_2c6;
}
_2c6=_2c3.skip_whitespace();
}
_2c9[_2c8.length+1]=type||null;
_2c8[_2c8.length]=_2c6;
if(_2c6 in _2c4){
throw new SyntaxError(this.error_message("*** Method ( "+_2c7+" ) uses a parameter name that is already in use ( "+_2c6+" )"));
}
}else{
if(_2c6==_27a){
var type="";
while((_2c6=_2c3.skip_whitespace())&&_2c6!=_27b){
type+=_2c6;
}
_2c9[0]=type||null;
}else{
if(_2c6==_26c){
if((_2c6=_2c3.skip_whitespace())!=_26d||_2c3.next()!=_26d||_2c3.next()!=_26d){
throw new SyntaxError(this.error_message("*** Argument list expected after ','."));
}
}else{
_2c7+=_2c6;
}
}
}
}
if(_2c6===_26f){
_2c6=_2c3.skip_whitespace();
if(_2c6!==_271){
throw new SyntaxError(this.error_message("Invalid semi-colon in method declaration. "+"Semi-colons are allowed only to terminate the method signature, before the open brace."));
}
}
var _2ca=0,_2cb=_2c8.length;
_2c5.atoms[_2c5.atoms.length]="new objj_method(sel_getUid(\"";
_2c5.atoms[_2c5.atoms.length]=_2c7;
_2c5.atoms[_2c5.atoms.length]="\"), function";
this._currentSelector=_2c7;
if(this._flags&_288.Flags.IncludeDebugSymbols){
_2c5.atoms[_2c5.atoms.length]=" $"+this._currentClass+"__"+_2c7.replace(/:/g,"_");
}
_2c5.atoms[_2c5.atoms.length]="(self, _cmd";
for(;_2ca<_2cb;++_2ca){
_2c5.atoms[_2c5.atoms.length]=", ";
_2c5.atoms[_2c5.atoms.length]=_2c8[_2ca];
}
_2c5.atoms[_2c5.atoms.length]=")\n{ with(self)\n{";
_2c5.atoms[_2c5.atoms.length]=this.preprocess(_2c3,NULL,_272,_271);
_2c5.atoms[_2c5.atoms.length]="}\n}";
if(this._flags&_288.Flags.IncludeDebugSymbols){
_2c5.atoms[_2c5.atoms.length]=","+JSON.stringify(_2c9);
}
_2c5.atoms[_2c5.atoms.length]=")";
this._currentSelector="";
return _2c5;
};
_288.prototype.preprocess=function(_2cc,_2cd,_2ce,_2cf,_2d0){
var _2d1=_2cd?_2cd:new _285(),_2d2=0,_2d3="";
if(_2d0){
_2d0[0]=_2d1;
var _2d4=false,_2d5=[0,0,0];
}
while((_2d3=_2cc.next())&&((_2d3!==_2ce)||_2d2)){
if(_2d0){
if(_2d3===_279){
++_2d5[2];
}else{
if(_2d3===_271){
++_2d5[0];
}else{
if(_2d3===_272){
--_2d5[0];
}else{
if(_2d3===_27a){
++_2d5[1];
}else{
if(_2d3===_27b){
--_2d5[1];
}else{
if((_2d3===_26b&&_2d5[2]--===0||(_2d4=(_2d3===_278)))&&_2d5[0]===0&&_2d5[1]===0){
_2cc.push();
var _2d6=_2d4?_2cc.skip_whitespace(true):_2cc.previous(),_2d7=_27c.test(_2d6);
if(_2d7||_27e.test(_2d6)&&_27c.test(_2cc.previous())){
_2cc.push();
var last=_2cc.skip_whitespace(true),_2d8=true,_2d9=false;
if(last==="+"||last==="-"){
if(_2cc.previous()!==last){
_2d8=false;
}else{
last=_2cc.skip_whitespace(true);
_2d9=true;
}
}
_2cc.pop();
_2cc.pop();
if(_2d8&&((!_2d9&&(last===_272))||last===_27b||last===_278||last===_26d||_27d.test(last)||last.charAt(last.length-1)==="\""||last.charAt(last.length-1)==="'"||_27e.test(last)&&!/^(new|return|case|var)$/.test(last))){
if(_2d7){
_2d0[1]=":";
}else{
_2d0[1]=_2d6;
if(!_2d4){
_2d0[1]+=":";
}
var _2d2=_2d1.atoms.length;
while(_2d1.atoms[_2d2--]!==_2d6){
}
_2d1.atoms.length=_2d2;
}
return !_2d4;
}
if(_2d4){
return NO;
}
}
_2cc.pop();
if(_2d4){
return NO;
}
}
}
}
}
}
}
_2d5[2]=MAX(_2d5[2],0);
}
if(_2cf){
if(_2d3===_2cf){
++_2d2;
}else{
if(_2d3===_2ce){
--_2d2;
}
}
}
if(_2d3===_25b){
var _2da="";
while((_2d3=_2cc.next())&&_2d3!==_27a&&!(/^\w/).test(_2d3)){
_2da+=_2d3;
}
if(_2d3===_27a){
if(_2cf===_27a){
++_2d2;
}
_2d1.atoms[_2d1.atoms.length]="function"+_2da+"(";
if(_2d0){
++_2d5[1];
}
}else{
_2d1.atoms[_2d1.atoms.length]=_2d3+"= function";
}
}else{
if(_2d3==_276){
this.directive(_2cc,_2d1);
}else{
if(_2d3==_277){
this.hash(_2cc,_2d1);
}else{
if(_2d3==_274){
this.brackets(_2cc,_2d1);
}else{
_2d1.atoms[_2d1.atoms.length]=_2d3;
}
}
}
}
}
if(_2d0){
throw new SyntaxError(this.error_message("*** Expected ']' - Unterminated message send or array."));
}
if(!_2cd){
return _2d1;
}
};
_288.prototype.selector=function(_2db,_2dc){
var _2dd=_2dc?_2dc:new _285();
_2dd.atoms[_2dd.atoms.length]="sel_getUid(\"";
if(_2db.skip_whitespace()!=_27a){
throw new SyntaxError(this.error_message("*** Expected '('"));
}
var _2de=_2db.skip_whitespace();
if(_2de==_27b){
throw new SyntaxError(this.error_message("*** Unexpected ')', can't have empty @selector()"));
}
_2dc.atoms[_2dc.atoms.length]=_2de;
var _2df,_2e0=true;
while((_2df=_2db.next())&&_2df!=_27b){
if(_2e0&&/^\d+$/.test(_2df)||!(/^(\w|$|\:)/.test(_2df))){
if(!(/\S/).test(_2df)){
if(_2db.skip_whitespace()==_27b){
break;
}else{
throw new SyntaxError(this.error_message("*** Unexpected whitespace in @selector()."));
}
}else{
throw new SyntaxError(this.error_message("*** Illegal character '"+_2df+"' in @selector()."));
}
}
_2dd.atoms[_2dd.atoms.length]=_2df;
_2e0=(_2df==_26b);
}
_2dd.atoms[_2dd.atoms.length]="\")";
if(!_2dc){
return _2dd;
}
};
_288.prototype.error_message=function(_2e1){
return _2e1+" <Context File: "+this._URL+(this._currentClass?" Class: "+this._currentClass:"")+(this._currentSelector?" Method: "+this._currentSelector:"")+">";
};
function _2c2(aURL,_2e2){
this._URL=aURL;
this._isLocal=_2e2;
};
_2.FileDependency=_2c2;
_2c2.prototype.URL=function(){
return this._URL;
};
_2c2.prototype.isLocal=function(){
return this._isLocal;
};
_2c2.prototype.toMarkedString=function(){
var _2e3=this.URL().absoluteString();
return (this.isLocal()?_214:_213)+";"+_2e3.length+";"+_2e3;
};
_2c2.prototype.toString=function(){
return (this.isLocal()?"LOCAL: ":"STD: ")+this.URL();
};
var _2e4=0,_2e5=1,_2e6=2,_2e7=0;
function _294(_2e8,_2e9,aURL,_2ea){
if(arguments.length===0){
return this;
}
this._code=_2e8;
this._function=_2ea||NULL;
this._URL=_1b6(aURL||new CFURL("(Anonymous"+(_2e7++)+")"));
this._fileDependencies=_2e9;
if(_2e9.length){
this._fileDependencyStatus=_2e4;
this._fileDependencyCallbacks=[];
}else{
this._fileDependencyStatus=_2e6;
}
if(this._function){
return;
}
this.setCode(_2e8);
};
_2.Executable=_294;
_294.prototype.path=function(){
return this.URL().path();
};
_294.prototype.URL=function(){
return this._URL;
};
_294.prototype.functionParameters=function(){
var _2eb=["global","objj_executeFile","objj_importFile"];
return _2eb;
};
_294.prototype.functionArguments=function(){
var _2ec=[_1,this.fileExecuter(),this.fileImporter()];
return _2ec;
};
_294.prototype.execute=function(){
var _2ed=_2ee;
_2ee=CFBundle.bundleContainingURL(this.URL());
var _2ef=this._function.apply(_1,this.functionArguments());
_2ee=_2ed;
return _2ef;
};
_294.prototype.code=function(){
return this._code;
};
_294.prototype.setCode=function(code){
this._code=code;
var _2f0=this.functionParameters().join(",");
this._function=new Function(_2f0,code);
};
_294.prototype.fileDependencies=function(){
return this._fileDependencies;
};
_294.prototype.hasLoadedFileDependencies=function(){
return this._fileDependencyStatus===_2e6;
};
var _2f1=0,_2f2=[],_2f3={};
_294.prototype.loadFileDependencies=function(_2f4){
var _2f5=this._fileDependencyStatus;
if(_2f4){
if(_2f5===_2e6){
return _2f4();
}
this._fileDependencyCallbacks.push(_2f4);
}
if(_2f5===_2e4){
if(_2f1){
throw "Can't load";
}
_2f6(this);
}
};
function _2f6(_2f7){
_2f2.push(_2f7);
_2f7._fileDependencyStatus=_2e5;
var _2f8=_2f7.fileDependencies(),_96=0,_2f9=_2f8.length,_2fa=_2f7.referenceURL(),_2fb=_2fa.absoluteString(),_2fc=_2f7.fileExecutableSearcher();
_2f1+=_2f9;
for(;_96<_2f9;++_96){
var _2fd=_2f8[_96],_2fe=_2fd.isLocal(),URL=_2fd.URL(),_2ff=(_2fe&&(_2fb+" ")||"")+URL;
if(_2f3[_2ff]){
if(--_2f1===0){
_300();
}
continue;
}
_2f3[_2ff]=YES;
_2fc(URL,_2fe,_301);
}
};
function _301(_302){
--_2f1;
if(_302._fileDependencyStatus===_2e4){
_2f6(_302);
}else{
if(_2f1===0){
_300();
}
}
};
function _300(){
var _303=_2f2,_96=0,_304=_303.length;
_2f2=[];
for(;_96<_304;++_96){
_303[_96]._fileDependencyStatus=_2e6;
}
for(_96=0;_96<_304;++_96){
var _305=_303[_96],_306=_305._fileDependencyCallbacks,_307=0,_308=_306.length;
for(;_307<_308;++_307){
_306[_307]();
}
_305._fileDependencyCallbacks=[];
}
};
_294.prototype.referenceURL=function(){
if(this._referenceURL===_29){
this._referenceURL=new CFURL(".",this.URL());
}
return this._referenceURL;
};
_294.prototype.fileImporter=function(){
return _294.fileImporterForURL(this.referenceURL());
};
_294.prototype.fileExecuter=function(){
return _294.fileExecuterForURL(this.referenceURL());
};
_294.prototype.fileExecutableSearcher=function(){
return _294.fileExecutableSearcherForURL(this.referenceURL());
};
var _309={};
_294.fileExecuterForURL=function(aURL){
var _30a=_1b6(aURL),_30b=_30a.absoluteString(),_30c=_309[_30b];
if(!_30c){
_30c=function(aURL,_30d,_30e){
_294.fileExecutableSearcherForURL(_30a)(aURL,_30d,function(_30f){
if(!_30f.hasLoadedFileDependencies()){
throw "No executable loaded for file at URL "+aURL;
}
_30f.execute(_30e);
});
};
_309[_30b]=_30c;
}
return _30c;
};
var _310={};
_294.fileImporterForURL=function(aURL){
var _311=_1b6(aURL),_312=_311.absoluteString(),_313=_310[_312];
if(!_313){
_313=function(aURL,_314,_315){
_156();
_294.fileExecutableSearcherForURL(_311)(aURL,_314,function(_316){
_316.loadFileDependencies(function(){
_316.execute();
_157();
if(_315){
_315();
}
});
});
};
_310[_312]=_313;
}
return _313;
};
var _317={},_318={};
_294.fileExecutableSearcherForURL=function(_319){
var _31a=_319.absoluteString(),_31b=_317[_31a],_31c={};
if(!_31b){
_31b=function(aURL,_31d,_31e){
var _31f=(_31d&&_319||"")+aURL,_320=_318[_31f];
if(_320){
return _321(_320);
}
var _322=(aURL instanceof CFURL)&&aURL.scheme();
if(_31d||_322){
if(!_322){
aURL=new CFURL(aURL,_319);
}
_1a3.resolveResourceAtURL(aURL,NO,_321);
}else{
_1a3.resolveResourceAtURLSearchingIncludeURLs(aURL,_321);
}
function _321(_323){
if(!_323){
throw new Error("Could not load file at "+aURL);
}
_318[_31f]=_323;
_31e(new _324(_323.URL()));
};
};
_317[_31a]=_31b;
}
return _31b;
};
var _325={};
function _324(aURL){
aURL=_1b6(aURL);
var _326=aURL.absoluteString(),_327=_325[_326];
if(_327){
return _327;
}
_325[_326]=this;
var _328=_1a3.resourceAtURL(aURL).contents(),_329=NULL,_32a=aURL.pathExtension();
if(_328.match(/^@STATIC;/)){
_329=_32b(_328,aURL);
}else{
if(_32a==="j"||!_32a){
_329=_2.preprocess(_328,aURL,_288.Flags.IncludeDebugSymbols);
}else{
_329=new _294(_328,[],aURL);
}
}
_294.apply(this,[_329.code(),_329.fileDependencies(),aURL,_329._function]);
this._hasExecuted=NO;
};
_2.FileExecutable=_324;
_324.prototype=new _294();
_324.prototype.execute=function(_32c){
if(this._hasExecuted&&!_32c){
return;
}
this._hasExecuted=YES;
_294.prototype.execute.call(this);
};
_324.prototype.hasExecuted=function(){
return this._hasExecuted;
};
function _32b(_32d,aURL){
var _32e=new _10a(_32d);
var _32f=NULL,code="",_330=[];
while(_32f=_32e.getMarker()){
var text=_32e.getString();
if(_32f===_212){
code+=text;
}else{
if(_32f===_213){
_330.push(new _2c2(new CFURL(text),NO));
}else{
if(_32f===_214){
_330.push(new _2c2(new CFURL(text),YES));
}
}
}
}
var fn=_324._lookupCachedFunction(aURL);
if(fn){
return new _294(code,_330,aURL,fn);
}
return new _294(code,_330,aURL);
};
var _331={};
_324._cacheFunction=function(aURL,fn){
aURL=typeof aURL==="string"?aURL:aURL.absoluteString();
_331[aURL]=fn;
};
_324._lookupCachedFunction=function(aURL){
aURL=typeof aURL==="string"?aURL:aURL.absoluteString();
return _331[aURL];
};
var _332=1,_333=2,_334=4,_335=8;
objj_ivar=function(_336,_337){
this.name=_336;
this.type=_337;
};
objj_method=function(_338,_339,_33a){
this.name=_338;
this.method_imp=_339;
this.types=_33a;
};
objj_class=function(_33b){
this.isa=NULL;
this.version=0;
this.super_class=NULL;
this.sub_classes=[];
this.name=NULL;
this.info=0;
this.ivar_list=[];
this.ivar_store=function(){
};
this.ivar_dtable=this.ivar_store.prototype;
this.method_list=[];
this.method_store=function(){
};
this.method_dtable=this.method_store.prototype;
this.allocator=function(){
};
this._UID=-1;
};
objj_object=function(){
this.isa=NULL;
this._UID=-1;
};
class_getName=function(_33c){
if(_33c==Nil){
return "";
}
return _33c.name;
};
class_isMetaClass=function(_33d){
if(!_33d){
return NO;
}
return ((_33d.info&(_333)));
};
class_getSuperclass=function(_33e){
if(_33e==Nil){
return Nil;
}
return _33e.super_class;
};
class_setSuperclass=function(_33f,_340){
_33f.super_class=_340;
_33f.isa.super_class=_340.isa;
};
class_addIvar=function(_341,_342,_343){
var _344=_341.allocator.prototype;
if(typeof _344[_342]!="undefined"){
return NO;
}
var ivar=new objj_ivar(_342,_343);
_341.ivar_list.push(ivar);
_341.ivar_dtable[_342]=ivar;
_344[_342]=NULL;
return YES;
};
class_addIvars=function(_345,_346){
var _347=0,_348=_346.length,_349=_345.allocator.prototype;
for(;_347<_348;++_347){
var ivar=_346[_347],name=ivar.name;
if(typeof _349[name]==="undefined"){
_345.ivar_list.push(ivar);
_345.ivar_dtable[name]=ivar;
_349[name]=NULL;
}
}
};
class_copyIvarList=function(_34a){
return _34a.ivar_list.slice(0);
};
class_addMethod=function(_34b,_34c,_34d,_34e){
var _34f=new objj_method(_34c,_34d,_34e);
_34b.method_list.push(_34f);
_34b.method_dtable[_34c]=_34f;
if(!((_34b.info&(_333)))&&(((_34b.info&(_333)))?_34b:_34b.isa).isa===(((_34b.info&(_333)))?_34b:_34b.isa)){
class_addMethod((((_34b.info&(_333)))?_34b:_34b.isa),_34c,_34d,_34e);
}
return YES;
};
class_addMethods=function(_350,_351){
var _352=0,_353=_351.length,_354=_350.method_list,_355=_350.method_dtable;
for(;_352<_353;++_352){
var _356=_351[_352];
_354.push(_356);
_355[_356.name]=_356;
}
if(!((_350.info&(_333)))&&(((_350.info&(_333)))?_350:_350.isa).isa===(((_350.info&(_333)))?_350:_350.isa)){
class_addMethods((((_350.info&(_333)))?_350:_350.isa),_351);
}
};
class_getInstanceMethod=function(_357,_358){
if(!_357||!_358){
return NULL;
}
var _359=_357.method_dtable[_358];
return _359?_359:NULL;
};
class_getInstanceVariable=function(_35a,_35b){
if(!_35a||!_35b){
return NULL;
}
var _35c=_35a.ivar_dtable[_35b];
return _35c;
};
class_getClassMethod=function(_35d,_35e){
if(!_35d||!_35e){
return NULL;
}
var _35f=(((_35d.info&(_333)))?_35d:_35d.isa).method_dtable[_35e];
return _35f?_35f:NULL;
};
class_respondsToSelector=function(_360,_361){
return class_getClassMethod(_360,_361)!=NULL;
};
class_copyMethodList=function(_362){
return _362.method_list.slice(0);
};
class_getVersion=function(_363){
return _363.version;
};
class_setVersion=function(_364,_365){
_364.version=parseInt(_365,10);
};
class_replaceMethod=function(_366,_367,_368){
if(!_366||!_367){
return NULL;
}
var _369=_366.method_dtable[_367],_36a=NULL;
if(_369){
_36a=_369.method_imp;
}
_369.method_imp=_368;
return _36a;
};
var _36b=function(_36c){
var meta=(((_36c.info&(_333)))?_36c:_36c.isa);
if((_36c.info&(_333))){
_36c=objj_getClass(_36c.name);
}
if(_36c.super_class&&!((((_36c.super_class.info&(_333)))?_36c.super_class:_36c.super_class.isa).info&(_334))){
_36b(_36c.super_class);
}
if(!(meta.info&(_334))&&!(meta.info&(_335))){
meta.info=(meta.info|(_335))&~(0);
objj_msgSend(_36c,"initialize");
meta.info=(meta.info|(_334))&~(_335);
}
};
var _36d=new objj_method("forward",function(self,_36e){
return objj_msgSend(self,"forward::",_36e,arguments);
});
class_getMethodImplementation=function(_36f,_370){
if(!((((_36f.info&(_333)))?_36f:_36f.isa).info&(_334))){
_36b(_36f);
}
var _371=_36f.method_dtable[_370];
if(!_371){
_371=_36d;
}
var _372=_371.method_imp;
return _372;
};
var _373={};
objj_allocateClassPair=function(_374,_375){
var _376=new objj_class(_375),_377=new objj_class(_375),_378=_376;
if(_374){
_378=_374;
while(_378.superclass){
_378=_378.superclass;
}
_376.allocator.prototype=new _374.allocator;
_376.ivar_dtable=_376.ivar_store.prototype=new _374.ivar_store;
_376.method_dtable=_376.method_store.prototype=new _374.method_store;
_377.method_dtable=_377.method_store.prototype=new _374.isa.method_store;
_376.super_class=_374;
_377.super_class=_374.isa;
}else{
_376.allocator.prototype=new objj_object();
}
_376.isa=_377;
_376.name=_375;
_376.info=_332;
_376._UID=objj_generateObjectUID();
_377.isa=_378.isa;
_377.name=_375;
_377.info=_333;
_377._UID=objj_generateObjectUID();
return _376;
};
var _2ee=nil;
objj_registerClassPair=function(_379){
_1[_379.name]=_379;
_373[_379.name]=_379;
_1bd(_379,_2ee);
};
class_createInstance=function(_37a){
if(!_37a){
throw new Error("*** Attempting to create object with Nil class.");
}
var _37b=new _37a.allocator();
_37b.isa=_37a;
_37b._UID=objj_generateObjectUID();
return _37b;
};
var _37c=function(){
};
_37c.prototype.member=false;
with(new _37c()){
member=true;
}
if(new _37c().member){
var _37d=class_createInstance;
class_createInstance=function(_37e){
var _37f=_37d(_37e);
if(_37f){
var _380=_37f.isa,_381=_380;
while(_380){
var _382=_380.ivar_list,_383=_382.length;
while(_383--){
_37f[_382[_383].name]=NULL;
}
_380=_380.super_class;
}
_37f.isa=_381;
}
return _37f;
};
}
object_getClassName=function(_384){
if(!_384){
return "";
}
var _385=_384.isa;
return _385?class_getName(_385):"";
};
objj_lookUpClass=function(_386){
var _387=_373[_386];
return _387?_387:Nil;
};
objj_getClass=function(_388){
var _389=_373[_388];
if(!_389){
}
return _389?_389:Nil;
};
objj_getMetaClass=function(_38a){
var _38b=objj_getClass(_38a);
return (((_38b.info&(_333)))?_38b:_38b.isa);
};
ivar_getName=function(_38c){
return _38c.name;
};
ivar_getTypeEncoding=function(_38d){
return _38d.type;
};
objj_msgSend=function(_38e,_38f){
if(_38e==nil){
return nil;
}
var isa=_38e.isa;
if(!((((isa.info&(_333)))?isa:isa.isa).info&(_334))){
_36b(isa);
}
var _390=isa.method_dtable[_38f];
if(!_390){
_390=_36d;
}
var _391=_390.method_imp;
switch(arguments.length){
case 2:
return _391(_38e,_38f);
case 3:
return _391(_38e,_38f,arguments[2]);
case 4:
return _391(_38e,_38f,arguments[2],arguments[3]);
}
return _391.apply(_38e,arguments);
};
objj_msgSendSuper=function(_392,_393){
var _394=_392.super_class;
arguments[0]=_392.receiver;
if(!((((_394.info&(_333)))?_394:_394.isa).info&(_334))){
_36b(_394);
}
var _395=_394.method_dtable[_393];
if(!_395){
_395=_36d;
}
var _396=_395.method_imp;
return _396.apply(_392.receiver,arguments);
};
method_getName=function(_397){
return _397.name;
};
method_getImplementation=function(_398){
return _398.method_imp;
};
method_setImplementation=function(_399,_39a){
var _39b=_399.method_imp;
_399.method_imp=_39a;
return _39b;
};
method_exchangeImplementations=function(lhs,rhs){
var _39c=method_getImplementation(lhs),_39d=method_getImplementation(rhs);
method_setImplementation(lhs,_39d);
method_setImplementation(rhs,_39c);
};
sel_getName=function(_39e){
return _39e?_39e:"<null selector>";
};
sel_getUid=function(_39f){
return _39f;
};
sel_isEqual=function(lhs,rhs){
return lhs===rhs;
};
sel_registerName=function(_3a0){
return _3a0;
};
objj_eval=function(_3a1){
var url=_2.pageURL;
var _3a2=_2.asyncLoader;
_2.asyncLoader=NO;
var _3a3=_2.preprocess(_3a1,url,0);
if(!_3a3.hasLoadedFileDependencies()){
_3a3.loadFileDependencies();
}
_1._objj_eval_scope={};
_1._objj_eval_scope.objj_executeFile=_294.fileExecuterForURL(url);
_1._objj_eval_scope.objj_importFile=_294.fileImporterForURL(url);
var code="with(_objj_eval_scope){"+_3a3._code+"\n//*/\n}";
var _3a4;
_3a4=eval(code);
_2.asyncLoader=_3a2;
return _3a4;
};
_2.objj_eval=objj_eval;
_156();
var _3a5=new CFURL(window.location.href),_3a6=document.getElementsByTagName("base"),_3a7=_3a6.length;
if(_3a7>0){
var _3a8=_3a6[_3a7-1],_3a9=_3a8&&_3a8.getAttribute("href");
if(_3a9){
_3a5=new CFURL(_3a9,_3a5);
}
}
var _3aa=new CFURL(window.OBJJ_MAIN_FILE||"main.j"),_1bc=new CFURL(".",new CFURL(_3aa,_3a5)).absoluteURL(),_3ab=new CFURL("..",_1bc).absoluteURL();
if(_1bc===_3ab){
_3ab=new CFURL(_3ab.schemeAndAuthority());
}
_1a3.resourceAtURL(_3ab,YES);
_2.pageURL=_3a5;
_2.bootstrap=function(){
_3ac();
};
function _3ac(){
_1a3.resolveResourceAtURL(_1bc,YES,function(_3ad){
var _3ae=_1a3.includeURLs(),_96=0,_3af=_3ae.length;
for(;_96<_3af;++_96){
_3ad.resourceAtURL(_3ae[_96],YES);
}
_294.fileImporterForURL(_1bc)(_3aa.lastPathComponent(),YES,function(){
_157();
_3b5(function(){
var _3b0=window.location.hash.substring(1),args=[];
if(_3b0.length){
args=_3b0.split("/");
for(var i=0,_3af=args.length;i<_3af;i++){
args[i]=decodeURIComponent(args[i]);
}
}
var _3b1=window.location.search.substring(1).split("&"),_3b2=new CFMutableDictionary();
for(var i=0,_3af=_3b1.length;i<_3af;i++){
var _3b3=_3b1[i].split("=");
if(!_3b3[0]){
continue;
}
if(_3b3[1]==null){
_3b3[1]=true;
}
_3b2.setValueForKey(decodeURIComponent(_3b3[0]),decodeURIComponent(_3b3[1]));
}
main(args,_3b2);
});
});
});
};
var _3b4=NO;
function _3b5(_3b6){
if(_3b4){
return _3b6();
}
if(window.addEventListener){
window.addEventListener("load",_3b6,NO);
}else{
if(window.attachEvent){
window.attachEvent("onload",_3b6);
}
}
};
_3b5(function(){
_3b4=YES;
});
if(typeof OBJJ_AUTO_BOOTSTRAP==="undefined"||OBJJ_AUTO_BOOTSTRAP){
_2.bootstrap();
}
function _1b6(aURL){
if(aURL instanceof CFURL&&aURL.scheme()){
return aURL;
}
return new CFURL(aURL,_1bc);
};
objj_importFile=_294.fileImporterForURL(_1bc);
objj_executeFile=_294.fileExecuterForURL(_1bc);
objj_import=function(){
CPLog.warn("objj_import is deprecated, use objj_importFile instead");
objj_importFile.apply(this,arguments);
};
})(window,ObjectiveJ);
