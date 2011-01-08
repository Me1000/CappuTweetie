@STATIC;1.0;p;15;_NSCornerView.jt;994;@STATIC;1.0;I;26;AppKit/CPTableHeaderView.jt;945;
objj_executeFile("AppKit/CPTableHeaderView.j",NO);
var _1=objj_getClass("_CPCornerView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"_CPCornerView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
return _3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("_CPCornerView").super_class},"NS_initWithCoder:",_5);
}
})]);
var _1=objj_allocateClassPair(_CPCornerView,"_NSCornerView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_6,_7,_8){
with(_6){
_6=objj_msgSendSuper({receiver:_6,super_class:objj_getClass("_NSCornerView").super_class},"NS_initWithCoder:",_8);
if(_6){
_frame.size.height=23;
_bounds.size.height=23;
}
return _6;
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_9,_a){
with(_9){
return objj_msgSend(_CPCornerView,"class");
}
})]);
p;15;Converter+Mac.jt;1835;@STATIC;1.0;i;11;Converter.jt;1800;
objj_executeFile("Converter.j",YES);
var _1=objj_getClass("Converter");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"Converter\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("convertedDataFromMacData:resourcesPath:"),function(_3,_4,_5,_6){
with(_3){
var _7=objj_msgSend(objj_msgSend(Nib2CibKeyedUnarchiver,"alloc"),"initForReadingWithData:resourcesPath:",_5,_6),_8=objj_msgSend(_7,"decodeObjectForKey:","IB.objectdata");
var _9=objj_msgSend(_7,"allObjects"),_a=objj_msgSend(_9,"count");
while(_a--){
var _b=_9[_a];
if(!objj_msgSend(_b,"isKindOfClass:",objj_msgSend(CPView,"class"))){
continue;
}
var _c=objj_msgSend(_b,"superview");
if(!_c||objj_msgSend(_c,"NS_isFlipped")){
continue;
}
var _d=CGRectGetHeight(objj_msgSend(_c,"bounds")),_e=objj_msgSend(_b,"frame");
objj_msgSend(_b,"setFrameOrigin:",CGPointMake(CGRectGetMinX(_e),_d-CGRectGetMaxY(_e)));
var _f=objj_msgSend(_b,"autoresizingMask");
autoresizingMask=_f&~(CPViewMaxYMargin|CPViewMinYMargin);
if(!(_f&(CPViewMaxYMargin|CPViewMinYMargin|CPViewHeightSizable))){
autoresizingMask|=CPViewMinYMargin;
}else{
if(_f&CPViewMaxYMargin){
autoresizingMask|=CPViewMinYMargin;
}
if(_f&CPViewMinYMargin){
autoresizingMask|=CPViewMaxYMargin;
}
}
objj_msgSend(_b,"setAutoresizingMask:",autoresizingMask);
}
var _10=objj_msgSend(CPData,"data"),_11=objj_msgSend(objj_msgSend(CPKeyedArchiver,"alloc"),"initForWritingWithMutableData:",_10);
objj_msgSend(_11,"setDelegate:",_3);
objj_msgSend(_11,"encodeObject:forKey:",_8,"CPCibObjectDataKey");
objj_msgSend(_11,"finishEncoding");
return _10;
}
}),new objj_method(sel_getUid("archiver:willEncodeObject:"),function(_12,_13,_14,_15){
with(_12){
if(objj_msgSend(_15,"isKindOfClass:",objj_msgSend(NSMatrix,"class"))){
return nil;
}else{
return _15;
}
}
})]);
p;11;Converter.jt;4040;@STATIC;1.0;I;21;Foundation/CPObject.jI;19;Foundation/CPData.ji;15;Converter+Mac.jt;3951;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("Foundation/CPData.j",NO);
var _1=require("file"),OS=require("os");
NibFormatUndetermined=0,NibFormatMac=1,NibFormatIPhone=2;
ConverterConversionException="ConverterConversionException";
var _2=objj_allocateClassPair(CPObject,"Converter"),_3=_2.isa;
class_addIvars(_2,[new objj_ivar("format"),new objj_ivar("inputPath"),new objj_ivar("outputPath"),new objj_ivar("resourcesPath")]);
objj_registerClassPair(_2);
class_addMethods(_2,[new objj_method(sel_getUid("format"),function(_4,_5){
with(_4){
return format;
}
}),new objj_method(sel_getUid("setFormat:"),function(_6,_7,_8){
with(_6){
format=_8;
}
}),new objj_method(sel_getUid("inputPath"),function(_9,_a){
with(_9){
return inputPath;
}
}),new objj_method(sel_getUid("setInputPath:"),function(_b,_c,_d){
with(_b){
inputPath=_d;
}
}),new objj_method(sel_getUid("outputPath"),function(_e,_f){
with(_e){
return outputPath;
}
}),new objj_method(sel_getUid("setOutputPath:"),function(_10,_11,_12){
with(_10){
outputPath=_12;
}
}),new objj_method(sel_getUid("resourcesPath"),function(_13,_14){
with(_13){
return resourcesPath;
}
}),new objj_method(sel_getUid("setResourcesPath:"),function(_15,_16,_17){
with(_15){
resourcesPath=_17;
}
}),new objj_method(sel_getUid("init"),function(_18,_19){
with(_18){
_18=objj_msgSendSuper({receiver:_18,super_class:objj_getClass("Converter").super_class},"init");
if(_18){
objj_msgSend(_18,"setFormat:",NibFormatUndetermined);
}
return _18;
}
}),new objj_method(sel_getUid("convert"),function(_1a,_1b){
with(_1a){
try{
if(objj_msgSend(resourcesPath,"length")&&!_1.isReadable(resourcesPath)){
objj_msgSend(CPException,"raise:reason:",ConverterConversionException,"Could not read Resources at path \""+resourcesPath+"\"");
}
var _1c=format;
if(_1c===NibFormatUndetermined){
_1c=NibFormatMac;
if(_1.extension(inputPath)!==".nib"&&_1.isFile(inputPath)&&_1.read(inputPath,{charset:"UTF-8"}).indexOf("<archive type=\"com.apple.InterfaceBuilder3.CocoaTouch.XIB\"")!==-1){
_1c=NibFormatIPhone;
}
if(_1c===NibFormatMac){
CPLog.info("Auto-detected Cocoa Nib or Xib File");
}else{
CPLog.info("Auto-detected CocoaTouch Xib File");
}
}
var _1d=objj_msgSend(_1a,"CPCompliantNibDataAtFilePath:",inputPath);
if(_1c===NibFormatMac){
var _1e=objj_msgSend(_1a,"convertedDataFromMacData:resourcesPath:",_1d,resourcesPath);
}else{
objj_msgSend(CPException,"raise:reason:",ConverterConversionException,"nib2cib does not understand this nib format.");
}
if(!objj_msgSend(outputPath,"length")){
outputPath=inputPath.substr(0,inputPath.length-_1.extension(inputPath).length)+".cib";
}
_1.write(outputPath,objj_msgSend(_1e,"rawString"),{charset:"UTF-8"});
}
catch(anException){
CPLog.fatal(anException);
}
}
}),new objj_method(sel_getUid("CPCompliantNibDataAtFilePath:"),function(_1f,_20,_21){
with(_1f){
var _22=_1.join("/tmp",_1.basename(_21)+".tmp.nib");
if(OS.popen(["/usr/bin/ibtool",_21,"--compile",_22]).wait()===1){
throw "Could not compile file at "+_21;
}
var _23=_1.join("/tmp",_1.basename(_21)+".tmp.plist");
if(OS.popen(["/usr/bin/plutil","-convert","xml1",_22,"-o",_23]).wait()===1){
throw "Could not convert to xml plist for file at "+_21;
}
if(!_1.isReadable(_23)){
objj_msgSend(CPException,"raise:reason:",ConverterConversionException,"Unable to convert nib file.");
}
var _24=_1.read(_23,{charset:"UTF-8"});
if(system.engine==="rhino"){
_24=String(java.lang.String(_24).replaceAll("\\<key\\>\\s*CF\\$UID\\s*\\</key\\>","<key>CP\\$UID</key>"));
}else{
_24=_24.replace(/\<key\>\s*CF\$UID\s*\<\/key\>/g,"<key>CP$UID</key>");
}
_24=_24.replace(/<string>[\u0000-\u0008\u000B\u000C\u000E-\u001F]<\/string>/g,function(c){
CPLog.warn("Warning: Converting character 0x"+c.charCodeAt(8).toString(16)+" to base64 representation");
return "<string type=\"base64\">"+CFData.encodeBase64String(c.charAt(8))+"</string>";
});
return objj_msgSend(CPData,"dataWithRawString:",_24);
}
})]);
objj_executeFile("Converter+Mac.j",YES);
p;6;main.jt;2134;@STATIC;1.0;I;23;Foundation/Foundation.jI;14;AppKit/CPCib.ji;14;NSFoundation.ji;10;NSAppKit.ji;24;Nib2CibKeyedUnarchiver.ji;11;Converter.jt;1989;
objj_executeFile("Foundation/Foundation.j",NO);
objj_executeFile("AppKit/CPCib.j",NO);
objj_executeFile("NSFoundation.j",YES);
objj_executeFile("NSAppKit.j",YES);
objj_executeFile("Nib2CibKeyedUnarchiver.j",YES);
objj_executeFile("Converter.j",YES);
var _1=require("file");
var OS=require("os");
var _2=new (require("narwhal/args").Parser)();
_2.usage("INPUT_FILE [OUTPUT_FILE]");
_2.option("-F","framework","frameworks").push().help("Add a framework to load");
_2.option("-R","resources").set().help("Set the Resources directory");
_2.option("--mac","format").set(NibFormatMac).def(NibFormatUndetermined).help("Set format to Mac");
_2.option("-v","--verbose","verbose").inc().help("Increase verbosity level");
_2.option("-q","--quiet","quiet").set(true).help("No output");
_2.helpful();
loadFrameworks=function(_3,_4){
if(!_3||_3.length===0){
return _4();
}
_3.forEach(function(_5){
print("Loading "+_5);
var _6=objj_msgSend(objj_msgSend(CPBundle,"alloc"),"initWithPath:",_5);
objj_msgSend(_6,"loadWithDelegate:",nil);
require("browser/timeout").serviceTimeouts();
});
_4();
};
main=function(_7){
var _8=_2.parse(_7,null,null,true);
if(_8.args.length<1||_8.args.length>2){
_2.printUsage(_8);
OS.exit(1);
}
if(_8.quiet){
}else{
if(_8.verbose===0){
CPLogRegister(CPLogPrint,"warn");
}else{
if(_8.verbose===1){
CPLogRegister(CPLogPrint,"info");
}else{
CPLogRegister(CPLogPrint);
}
}
}
CPLog.debug("Input:      "+_8.args[0]);
CPLog.debug("Output:     "+(_8.args[1]||""));
CPLog.debug("Format:     "+["Auto","Mac","iPhone"][_8.format]);
CPLog.debug("Resources:  "+(_8.resources||""));
CPLog.debug("Frameworks: "+_8.frameworks);
var _9=objj_msgSend(objj_msgSend(Converter,"alloc"),"init");
if(_8.resources){
objj_msgSend(_9,"setResourcesPath:",_8.resources);
}
objj_msgSend(_9,"setFormat:",_8.format);
objj_msgSend(_9,"setInputPath:",_8.args[0]);
if(_8.args.length>1){
objj_msgSend(_9,"setOutputPath:",_8.args[1]);
}
loadFrameworks(_8.frameworks,function(){
objj_msgSend(_9,"convert");
});
};
p;24;Nib2CibKeyedUnarchiver.jt;1384;@STATIC;1.0;I;30;Foundation/CPKeyedUnarchiver.jt;1330;
objj_executeFile("Foundation/CPKeyedUnarchiver.j",NO);
var _1=require("file");
var _2=objj_allocateClassPair(CPKeyedUnarchiver,"Nib2CibKeyedUnarchiver"),_3=_2.isa;
class_addIvars(_2,[new objj_ivar("resourcesPath")]);
objj_registerClassPair(_2);
class_addMethods(_2,[new objj_method(sel_getUid("resourcesPath"),function(_4,_5){
with(_4){
return resourcesPath;
}
}),new objj_method(sel_getUid("initForReadingWithData:resourcesPath:"),function(_6,_7,_8,_9){
with(_6){
_6=objj_msgSendSuper({receiver:_6,super_class:objj_getClass("Nib2CibKeyedUnarchiver").super_class},"initForReadingWithData:",_8);
if(_6){
resourcesPath=_9;
}
return _6;
}
}),new objj_method(sel_getUid("allObjects"),function(_a,_b){
with(_a){
return _objects;
}
}),new objj_method(sel_getUid("resourcePathForName:"),function(_c,_d,_e){
with(_c){
if(!resourcesPath){
return NULL;
}
var _f=[_1.listPaths(resourcesPath)];
while(_f.length>0){
var _10=_f.shift(),_11=0,_12=_10.length;
for(;_11<_12;++_11){
var _13=_10[_11];
if(_1.basename(_13)===_e){
return _13;
}else{
if(_1.isDirectory(_13)){
_f.push(_1.listPaths(_13));
}else{
if(!_1.extension(_e)&&_1.basename(_13).replace(/\.[^.]*$/,"")===_e){
return _13;
}
}
}
}
}
return NULL;
}
})]);
_1.listPaths=function(_14){
var _15=_1.list(_14),_16=_15.length;
while(_16--){
_15[_16]=_1.join(_14,_15[_16]);
}
return _15;
};
p;10;NSAppKit.jt;3363;@STATIC;1.0;i;15;_NSCornerView.ji;19;NSArrayController.ji;7;NSBox.ji;10;NSButton.ji;8;NSCell.ji;16;NSClassSwapper.ji;12;NSClipView.ji;9;NSColor.ji;13;NSColorWell.ji;18;NSCollectionView.ji;22;NSCollectionViewItem.ji;11;NSControl.ji;16;NSCustomObject.ji;18;NSCustomResource.ji;14;NSCustomView.ji;9;NSEvent.ji;8;NSFont.ji;13;NSFormatter.ji;16;NSIBObjectData.ji;13;NSImageView.ji;10;NSMatrix.ji;8;NSMenu.ji;12;NSMenuItem.ji;16;NSNibConnector.ji;20;NSObjectController.ji;15;NSOutlineView.ji;15;NSPopUpButton.ji;13;NSResponder.ji;14;NSScrollView.ji;12;NSScroller.ji;15;NSSearchField.ji;7;NSSet.ji;19;NSSecureTextField.ji;20;NSSegmentedControl.ji;10;NSSlider.ji;13;NSSplitView.ji;15;NSTableColumn.ji;19;NSTableHeaderView.ji;13;NSTableView.ji;11;NSTabView.ji;15;NSTabViewItem.ji;13;NSTextField.ji;11;NSToolbar.ji;28;NSToolbarFlexibleSpaceItem.ji;15;NSToolbarItem.ji;25;NSToolbarShowColorsItem.ji;24;NSToolbarSeparatorItem.ji;20;NSToolbarSpaceItem.ji;8;NSView.ji;18;NSViewController.ji;18;NSWindowTemplate.ji;9;WebView.ji;18;NSSortDescriptor.jt;2322;
objj_executeFile("_NSCornerView.j",YES);
objj_executeFile("NSArrayController.j",YES);
objj_executeFile("NSBox.j",YES);
objj_executeFile("NSButton.j",YES);
objj_executeFile("NSCell.j",YES);
objj_executeFile("NSClassSwapper.j",YES);
objj_executeFile("NSClipView.j",YES);
objj_executeFile("NSColor.j",YES);
objj_executeFile("NSColorWell.j",YES);
objj_executeFile("NSCollectionView.j",YES);
objj_executeFile("NSCollectionViewItem.j",YES);
objj_executeFile("NSControl.j",YES);
objj_executeFile("NSCustomObject.j",YES);
objj_executeFile("NSCustomResource.j",YES);
objj_executeFile("NSCustomView.j",YES);
objj_executeFile("NSEvent.j",YES);
objj_executeFile("NSFont.j",YES);
objj_executeFile("NSFormatter.j",YES);
objj_executeFile("NSIBObjectData.j",YES);
objj_executeFile("NSImageView.j",YES);
objj_executeFile("NSMatrix.j",YES);
objj_executeFile("NSMenu.j",YES);
objj_executeFile("NSMenuItem.j",YES);
objj_executeFile("NSNibConnector.j",YES);
objj_executeFile("NSObjectController.j",YES);
objj_executeFile("NSOutlineView.j",YES);
objj_executeFile("NSPopUpButton.j",YES);
objj_executeFile("NSResponder.j",YES);
objj_executeFile("NSScrollView.j",YES);
objj_executeFile("NSScroller.j",YES);
objj_executeFile("NSSearchField.j",YES);
objj_executeFile("NSSet.j",YES);
objj_executeFile("NSSecureTextField.j",YES);
objj_executeFile("NSSegmentedControl.j",YES);
objj_executeFile("NSSlider.j",YES);
objj_executeFile("NSSplitView.j",YES);
objj_executeFile("NSTableColumn.j",YES);
objj_executeFile("NSTableHeaderView.j",YES);
objj_executeFile("NSTableView.j",YES);
objj_executeFile("NSTabView.j",YES);
objj_executeFile("NSTabViewItem.j",YES);
objj_executeFile("NSTextField.j",YES);
objj_executeFile("NSToolbar.j",YES);
objj_executeFile("NSToolbarFlexibleSpaceItem.j",YES);
objj_executeFile("NSToolbarItem.j",YES);
objj_executeFile("NSToolbarShowColorsItem.j",YES);
objj_executeFile("NSToolbarSeparatorItem.j",YES);
objj_executeFile("NSToolbarSpaceItem.j",YES);
objj_executeFile("NSView.j",YES);
objj_executeFile("NSViewController.j",YES);
objj_executeFile("NSWindowTemplate.j",YES);
objj_executeFile("WebView.j",YES);
objj_executeFile("NSSortDescriptor.j",YES);
CP_NSMapClassName=function(_1){
if(_1.indexOf("NS")===0){
var _2="CP"+_1.substr(2);
if(CPClassFromString(_2)){
CPLog.info("Mapping "+_1+" to "+_2);
return _2;
}
}
return _1;
};
p;9;NSArray.jt;439;@STATIC;1.0;I;21;Foundation/CPObject.jt;395;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"NSArray"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_3,_4,_5){
with(_3){
return objj_msgSend(_5,"decodeObjectForKey:","NS.objects");
}
})]);
var _1=objj_allocateClassPair(NSArray,"NSMutableArray"),_2=_1.isa;
objj_registerClassPair(_1);
p;19;NSArrayController.jt;1460;@STATIC;1.0;I;26;AppKit/CPArrayController.jt;1410;
objj_executeFile("AppKit/CPArrayController.j",NO);
var _1=objj_getClass("CPArrayController");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPArrayController\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPArrayController").super_class},"NS_initWithCoder:",_5);
if(_3){
_avoidsEmptySelection=objj_msgSend(_5,"decodeBoolForKey:","NSAvoidsEmptySelection");
_clearsFilterPredicateOnInsertion=objj_msgSend(_5,"decodeBoolForKey:","NSClearsFilterPredicateOnInsertion");
_filterRestrictsInsertion=objj_msgSend(_5,"decodeBoolForKey:","NSFilterRestrictsInsertion");
_preservesSelection=objj_msgSend(_5,"decodeBoolForKey:","NSPreservesSelection");
_selectsInsertedObjects=objj_msgSend(_5,"decodeBoolForKey:","NSSelectsInsertedObjects");
_alwaysUsesMultipleValuesMarker=objj_msgSend(_5,"decodeBoolForKey:","NSAlwaysUsesMultipleValuesMarker");
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPArrayController,"NSArrayController"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_6,_7,_8){
with(_6){
return objj_msgSend(_6,"NS_initWithCoder:",_8);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_9,_a){
with(_9){
return objj_msgSend(CPArrayController,"class");
}
})]);
p;7;NSBox.jt;1374;@STATIC;1.0;I;14;AppKit/CPBox.jt;1336;
objj_executeFile("AppKit/CPBox.j",NO);
var _1=objj_getClass("CPBox");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPBox\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPBox").super_class},"NS_initWithCoder:",_5);
if(_3){
_boxType=objj_msgSend(_5,"decodeIntForKey:","NSBoxType");
_borderType=objj_msgSend(_5,"decodeIntForKey:","NSBorderType");
_borderColor=objj_msgSend(_5,"decodeObjectForKey:","NSBorderColor2")||objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0,0,0,0.42);
_fillColor=objj_msgSend(_5,"decodeObjectForKey:","NSFillColor2")||objj_msgSend(CPColor,"clearColor");
_cornerRadius=objj_msgSend(_5,"decodeFloatForKey:","NSCornerRadius2")||0;
_borderWidth=objj_msgSend(_5,"decodeFloatForKey:","NSBorderWidth2")||1;
_contentMargin=objj_msgSend(_5,"decodeSizeForKey:","NSOffsets");
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPBox,"NSBox"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_6,_7,_8){
with(_6){
return objj_msgSend(_6,"NS_initWithCoder:",_8);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_9,_a){
with(_9){
return objj_msgSend(CPBox,"class");
}
})]);
p;10;NSButton.jt;8002;@STATIC;1.0;I;17;AppKit/CPButton.jI;19;AppKit/CPCheckBox.jI;16;AppKit/CPRadio.ji;8;NSCell.ji;11;NSControl.jt;7888;
objj_executeFile("AppKit/CPButton.j",NO);
objj_executeFile("AppKit/CPCheckBox.j",NO);
objj_executeFile("AppKit/CPRadio.j",NO);
objj_executeFile("NSCell.j",YES);
objj_executeFile("NSControl.j",YES);
var _1={};
_1[CPRoundedBezelStyle]=18;
_1[CPTexturedRoundedBezelStyle]=20;
_1[CPHUDBezelStyle]=20;
var _2=8388608,_3=16777216,_4=16711680,_5=16,_6=4,_7=12,_8=28,_9=44,_a=60,_b=68,_c=108;
var _d=objj_getClass("CPButton");
if(!_d){
throw new SyntaxError("*** Could not find definition for class \"CPButton\"");
}
var _e=_d.isa;
class_addMethods(_d,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_f,_10,_11){
with(_f){
_f=objj_msgSendSuper({receiver:_f,super_class:objj_getClass("CPButton").super_class},"NS_initWithCoder:",_11);
if(_f){
var _12=objj_msgSend(_11,"decodeObjectForKey:","NSCell");
NIB_CONNECTION_EQUIVALENCY_TABLE[objj_msgSend(_12,"UID")]=_f;
_title=objj_msgSend(_12,"title");
if(!objj_msgSend(_f,"NS_isCheckBox")&&!objj_msgSend(_f,"NS_isRadio")){
_controlSize=CPRegularControlSize;
objj_msgSend(_f,"setBordered:",objj_msgSend(_12,"isBordered"));
_bezelStyle=objj_msgSend(_12,"bezelStyle");
switch(_bezelStyle){
case CPRoundedBezelStyle:
case CPTexturedRoundedBezelStyle:
case CPHUDBezelStyle:
break;
case CPRoundRectBezelStyle:
_bezelStyle=CPRoundedBezelStyle;
break;
case CPSmallSquareBezelStyle:
case CPThickSquareBezelStyle:
case CPThickerSquareBezelStyle:
case CPRegularSquareBezelStyle:
case CPTexturedSquareBezelStyle:
case CPShadowlessSquareBezelStyle:
_bezelStyle=CPTexturedRoundedBezelStyle;
break;
case CPRecessedBezelStyle:
_bezelStyle=CPHUDBezelStyle;
break;
case CPRoundedDisclosureBezelStyle:
case CPHelpButtonBezelStyle:
case CPCircularBezelStyle:
case CPDisclosureBezelStyle:
CPLog.warn("Unsupported bezel style: "+_bezelStyle);
_bezelStyle=CPHUDBezelStyle;
break;
default:
CPLog.error("Unknown bezel style: "+_bezelStyle);
_bezelStyle=CPHUDBezelStyle;
}
if(objj_msgSend(_12,"isBordered")){
CPLog.info("Adjusting CPButton height from "+_frame.size.height+" / "+_bounds.size.height+" to "+CPButtonDefaultHeight);
_frame.size.height=CPButtonDefaultHeight;
_frame.origin.y+=4;
_bounds.size.height=CPButtonDefaultHeight;
}
}else{
if(!objj_msgSend(_f,"isKindOfClass:",CPCheckBox)&&!objj_msgSend(_f,"isKindOfClass:",CPRadio)){
if(objj_msgSend(_f,"NS_isCheckBox")){
return objj_msgSend(objj_msgSend(CPCheckBox,"alloc"),"NS_initWithCoder:",_11);
}else{
return objj_msgSend(objj_msgSend(CPRadio,"alloc"),"NS_initWithCoder:",_11);
}
}
objj_msgSend(_f,"setBordered:",YES);
}
}
return _f;
}
}),new objj_method(sel_getUid("NS_isCheckBox"),function(_13,_14){
with(_13){
return NO;
}
}),new objj_method(sel_getUid("NS_isRadio"),function(_15,_16){
with(_15){
return NO;
}
})]);
var _d=objj_getClass("CPRadio");
if(!_d){
throw new SyntaxError("*** Could not find definition for class \"CPRadio\"");
}
var _e=_d.isa;
class_addMethods(_d,[new objj_method(sel_getUid("NS_isRadio"),function(_17,_18){
with(_17){
return YES;
}
}),new objj_method(sel_getUid("NS_initWithCoder:"),function(_19,_1a,_1b){
with(_19){
if(_19=objj_msgSendSuper({receiver:_19,super_class:objj_getClass("CPRadio").super_class},"NS_initWithCoder:",_1b)){
_radioGroup=objj_msgSend(CPRadioGroup,"new");
}
return _19;
}
})]);
var _d=objj_getClass("CPCheckBox");
if(!_d){
throw new SyntaxError("*** Could not find definition for class \"CPCheckBox\"");
}
var _e=_d.isa;
class_addMethods(_d,[new objj_method(sel_getUid("NS_isCheckBox"),function(_1c,_1d){
with(_1c){
return YES;
}
})]);
var _d=objj_allocateClassPair(CPButton,"NSButton"),_e=_d.isa;
class_addIvars(_d,[new objj_ivar("_isCheckBox"),new objj_ivar("_isRadio")]);
objj_registerClassPair(_d);
class_addMethods(_d,[new objj_method(sel_getUid("NS_isCheckBox"),function(_1e,_1f){
with(_1e){
return _isCheckBox;
}
}),new objj_method(sel_getUid("NS_isRadio"),function(_20,_21){
with(_20){
return _isRadio;
}
}),new objj_method(sel_getUid("initWithCoder:"),function(_22,_23,_24){
with(_22){
var _25=objj_msgSend(_24,"decodeObjectForKey:","NSCell"),_26=objj_msgSend(_25,"alternateImage");
if(objj_msgSend(_26,"isKindOfClass:",objj_msgSend(NSButtonImageSource,"class"))){
if(objj_msgSend(_26,"imageName")==="NSSwitch"){
_isCheckBox=YES;
}else{
if(objj_msgSend(_26,"imageName")==="NSRadioButton"){
_isRadio=YES;
_radioGroup=objj_msgSend(CPRadioGroup,"new");
}
}
}
_22=objj_msgSend(_22,"NS_initWithCoder:",_24);
_22._allowsMixedState=objj_msgSend(_25,"allowsMixedState");
objj_msgSend(_22,"setImagePosition:",objj_msgSend(_25,"imagePosition"));
objj_msgSend(_22,"setKeyEquivalent:",objj_msgSend(_25,"keyEquivalent"));
_22._keyEquivalentModifierMask=objj_msgSend(_25,"keyEquivalentModifierMask");
return _22;
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_27,_28){
with(_27){
if(objj_msgSend(_27,"NS_isCheckBox")){
return objj_msgSend(CPCheckBox,"class");
}
if(objj_msgSend(_27,"NS_isRadio")){
return objj_msgSend(CPRadio,"class");
}
return objj_msgSend(CPButton,"class");
}
})]);
var _d=objj_allocateClassPair(NSActionCell,"NSButtonCell"),_e=_d.isa;
class_addIvars(_d,[new objj_ivar("_isBordered"),new objj_ivar("_bezelStyle"),new objj_ivar("_title"),new objj_ivar("_alternateImage"),new objj_ivar("_allowsMixedState"),new objj_ivar("_imagePosition"),new objj_ivar("_keyEquivalent"),new objj_ivar("_keyEquivalentModifierMask")]);
objj_registerClassPair(_d);
class_addMethods(_d,[new objj_method(sel_getUid("isBordered"),function(_29,_2a){
with(_29){
return _isBordered;
}
}),new objj_method(sel_getUid("bezelStyle"),function(_2b,_2c){
with(_2b){
return _bezelStyle;
}
}),new objj_method(sel_getUid("title"),function(_2d,_2e){
with(_2d){
return _title;
}
}),new objj_method(sel_getUid("alternateImage"),function(_2f,_30){
with(_2f){
return _alternateImage;
}
}),new objj_method(sel_getUid("allowsMixedState"),function(_31,_32){
with(_31){
return _allowsMixedState;
}
}),new objj_method(sel_getUid("imagePosition"),function(_33,_34){
with(_33){
return _imagePosition;
}
}),new objj_method(sel_getUid("keyEquivalent"),function(_35,_36){
with(_35){
return _keyEquivalent;
}
}),new objj_method(sel_getUid("keyEquivalentModifierMask"),function(_37,_38){
with(_37){
return _keyEquivalentModifierMask;
}
}),new objj_method(sel_getUid("initWithCoder:"),function(_39,_3a,_3b){
with(_39){
_39=objj_msgSendSuper({receiver:_39,super_class:objj_getClass("NSButtonCell").super_class},"initWithCoder:",_3b);
if(_39){
var _3c=objj_msgSend(_3b,"decodeIntForKey:","NSButtonFlags"),_3d=objj_msgSend(_3b,"decodeIntForKey:","NSButtonFlags2"),_3e=objj_msgSend(_3b,"decodeIntForKey:","NSCellFlags2"),_3f=(_3c&_4)>>_5;
_isBordered=(_3c&_2)?YES:NO;
_bezelStyle=(_3d&7)|((_3d&32)>>2);
_title=objj_msgSend(_3b,"decodeObjectForKey:","NSContents");
_objectValue=objj_msgSend(_39,"state");
_alternateImage=objj_msgSend(_3b,"decodeObjectForKey:","NSAlternateImage");
_allowsMixedState=(_3e&_3)?YES:NO;
if((_3f&_c)==_c){
_imagePosition=CPImageOverlaps;
}else{
if((_3f&_b)==_b){
_imagePosition=CPImageOnly;
}else{
if((_3f&_a)==_a){
_imagePosition=CPImageLeft;
}else{
if((_3f&_9)==_9){
_imagePosition=CPImageRight;
}else{
if((_3f&_8)==_8){
_imagePosition=CPImageBelow;
}else{
if((_3f&_7)==_7){
_imagePosition=CPImageAbove;
}else{
if((_3f&_6)==_6){
_imagePosition=CPNoImage;
}
}
}
}
}
}
}
_keyEquivalent=objj_msgSend(_3b,"decodeObjectForKey:","NSKeyEquivalent");
_keyEquivalentModifierMask=_3d>>8;
}
return _39;
}
})]);
var _d=objj_allocateClassPair(CPObject,"NSButtonImageSource"),_e=_d.isa;
class_addIvars(_d,[new objj_ivar("_imageName")]);
objj_registerClassPair(_d);
class_addMethods(_d,[new objj_method(sel_getUid("imageName"),function(_40,_41){
with(_40){
return _imageName;
}
}),new objj_method(sel_getUid("initWithCoder:"),function(_42,_43,_44){
with(_42){
_42=objj_msgSendSuper({receiver:_42,super_class:objj_getClass("NSButtonImageSource").super_class},"init");
if(_42){
_imageName=objj_msgSend(_44,"decodeObjectForKey:","NSImageName");
}
return _42;
}
})]);
p;8;NSCell.jt;3870;@STATIC;1.0;I;21;Foundation/CPObject.ji;8;NSFont.jt;3813;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("NSFont.j",YES);
var _1=objj_allocateClassPair(CPObject,"NSCell"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_state"),new objj_ivar("_isHighlighted"),new objj_ivar("_isEnabled"),new objj_ivar("_isEditable"),new objj_ivar("_isBordered"),new objj_ivar("_isBezeled"),new objj_ivar("_isSelectable"),new objj_ivar("_isScrollable"),new objj_ivar("_isContinuous"),new objj_ivar("_scrolls"),new objj_ivar("_wraps"),new objj_ivar("_truncates"),new objj_ivar("_alignment"),new objj_ivar("_controlSize"),new objj_ivar("_objectValue"),new objj_ivar("_font"),new objj_ivar("_lineBreakMode")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("state"),function(_3,_4){
with(_3){
return _state;
}
}),new objj_method(sel_getUid("isHighlighted"),function(_5,_6){
with(_5){
return _isHighlighted;
}
}),new objj_method(sel_getUid("isEnabled"),function(_7,_8){
with(_7){
return _isEnabled;
}
}),new objj_method(sel_getUid("isEditable"),function(_9,_a){
with(_9){
return _isEditable;
}
}),new objj_method(sel_getUid("isBordered"),function(_b,_c){
with(_b){
return _isBordered;
}
}),new objj_method(sel_getUid("isBezeled"),function(_d,_e){
with(_d){
return _isBezeled;
}
}),new objj_method(sel_getUid("isSelectable"),function(_f,_10){
with(_f){
return _isSelectable;
}
}),new objj_method(sel_getUid("isScrollable"),function(_11,_12){
with(_11){
return _isScrollable;
}
}),new objj_method(sel_getUid("isContinuous"),function(_13,_14){
with(_13){
return _isContinuous;
}
}),new objj_method(sel_getUid("scrolls"),function(_15,_16){
with(_15){
return _scrolls;
}
}),new objj_method(sel_getUid("wraps"),function(_17,_18){
with(_17){
return _wraps;
}
}),new objj_method(sel_getUid("truncates"),function(_19,_1a){
with(_19){
return _truncates;
}
}),new objj_method(sel_getUid("alignment"),function(_1b,_1c){
with(_1b){
return _alignment;
}
}),new objj_method(sel_getUid("controlSize"),function(_1d,_1e){
with(_1d){
return _controlSize;
}
}),new objj_method(sel_getUid("objectValue"),function(_1f,_20){
with(_1f){
return _objectValue;
}
}),new objj_method(sel_getUid("font"),function(_21,_22){
with(_21){
return _font;
}
}),new objj_method(sel_getUid("lineBreakMode"),function(_23,_24){
with(_23){
return _lineBreakMode;
}
}),new objj_method(sel_getUid("initWithCoder:"),function(_25,_26,_27){
with(_25){
_25=objj_msgSendSuper({receiver:_25,super_class:objj_getClass("NSCell").super_class},"init");
if(_25){
var _28=objj_msgSend(_27,"decodeIntForKey:","NSCellFlags"),_29=objj_msgSend(_27,"decodeIntForKey:","NSCellFlags2");
_state=(_28&2147483648)?CPOnState:CPOffState;
_isHighlighted=(_28&1073741824)?YES:NO;
_isEnabled=(_28&536870912)?NO:YES;
_isEditable=(_28&268435456)?YES:NO;
_isBordered=(_28&8388608)?YES:NO;
_isBezeled=(_28&4194304)?YES:NO;
_isSelectable=(_28&2097152)?YES:NO;
_isScrollable=(_28&1048576)?YES:NO;
_isContinuous=(_28&524544)?YES:NO;
_scrolls=(_28&1048576)&&(_28&64);
_wraps=(_28&1048576===0)&&(_28&64===0);
_truncates=!(_28&1048576)&&(_28&64);
_alignment=(_29&469762048)>>26;
_lineBreakMode=(_29&3584)>>9;
_controlSize=(_29&917504)>>17;
_objectValue=objj_msgSend(_27,"decodeObjectForKey:","NSContents");
_font=objj_msgSend(_27,"decodeObjectForKey:","NSSupport");
}
return _25;
}
}),new objj_method(sel_getUid("replacementObjectForCoder:"),function(_2a,_2b,_2c){
with(_2a){
return nil;
}
}),new objj_method(sel_getUid("stringValue"),function(_2d,_2e){
with(_2d){
if(objj_msgSend(_objectValue,"isKindOfClass:",objj_msgSend(CPString,"class"))){
return _objectValue;
}
if(objj_msgSend(_objectValue,"respondsToSelector:",sel_getUid("attributedStringValue"))){
return objj_msgSend(_objectValue,"attributedStringValue");
}
return "";
}
})]);
var _1=objj_allocateClassPair(NSCell,"NSActionCell"),_2=_1.isa;
objj_registerClassPair(_1);
p;16;NSClassSwapper.jt;1449;@STATIC;1.0;t;1430;
var _1={},_2={};
var _3="_CPCibClassSwapperClassNameKey",_4="_CPCibClassSwapperOriginalClassNameKey";
var _5=objj_allocateClassPair(_CPCibClassSwapper,"NSClassSwapper"),_6=_5.isa;
objj_registerClassPair(_5);
class_addMethods(_6,[new objj_method(sel_getUid("swapperClassForClassName:originalClassName:"),function(_7,_8,_9,_a){
with(_7){
var _b="$NSClassSwapper_"+_9+"_"+_a,_c=objj_lookUpClass(_b);
if(!_c){
var _d=objj_lookUpClass(_a);
_c=objj_allocateClassPair(_d,_b);
objj_registerClassPair(_c);
class_addMethod(_c,sel_getUid("initWithCoder:"),function(_e,_f,_10){
_e=objj_msgSendSuper({super_class:_d,receiver:_e},_f,_10);
if(_e){
var UID=objj_msgSend(_e,"UID");
_1[UID]=_9;
_2[UID]=_a;
}
return _e;
},"");
class_addMethod(_c,sel_getUid("classForKeyedArchiver"),function(_11,_12){
return objj_msgSend(_CPCibClassSwapper,"class");
},"");
class_addMethod(_c,sel_getUid("encodeWithCoder:"),function(_13,_14,_15){
objj_msgSendSuper({super_class:_d,receiver:_13},_14,_15);
objj_msgSend(_15,"encodeObject:forKey:",_9,_3);
objj_msgSend(_15,"encodeObject:forKey:",CP_NSMapClassName(_a),_4);
},"");
}
return _c;
}
}),new objj_method(sel_getUid("allocWithCoder:"),function(_16,_17,_18){
with(_16){
var _19=objj_msgSend(_18,"decodeObjectForKey:","NSClassName"),_1a=objj_msgSend(_18,"decodeObjectForKey:","NSOriginalClassName");
return objj_msgSend(objj_msgSend(_16,"swapperClassForClassName:originalClassName:",_19,_1a),"alloc");
}
})]);
p;12;NSClipView.jt;1141;@STATIC;1.0;I;19;AppKit/CPClipView.jt;1098;
objj_executeFile("AppKit/CPClipView.j",NO);
var _1=objj_getClass("CPClipView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPClipView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPClipView").super_class},"NS_initWithCoder:",_5)){
_documentView=objj_msgSend(_5,"decodeObjectForKey:","NSDocView");
if(objj_msgSend(_5,"containsValueForKey:","NSBGColor")){
objj_msgSend(_3,"setBackgroundColor:",objj_msgSend(_5,"decodeObjectForKey:","NSBGColor"));
}
}
return _3;
}
}),new objj_method(sel_getUid("NS_isFlipped"),function(_6,_7){
with(_6){
return YES;
}
})]);
var _1=objj_allocateClassPair(CPClipView,"NSClipView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_8,_9,_a){
with(_8){
return objj_msgSend(_8,"NS_initWithCoder:",_a);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_b,_c){
with(_b){
return objj_msgSend(CPClipView,"class");
}
})]);
p;18;NSCollectionView.jt;1532;@STATIC;1.0;I;25;AppKit/CPCollectionView.jt;1483;
objj_executeFile("AppKit/CPCollectionView.j",NO);
var _1=objj_getClass("CPCollectionView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPCollectionView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_items=[];
_content=[];
_cachedItems=[];
_itemSize=CGSizeMakeZero();
_minItemSize=CGSizeMakeZero();
_maxItemSize=CGSizeMakeZero();
_verticalMargin=5;
_tileWidth=-1;
_selectionIndexes=objj_msgSend(CPIndexSet,"indexSet");
_allowsEmptySelection=YES;
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPCollectionView").super_class},"NS_initWithCoder:",_5)){
_backgroundColors=objj_msgSend(_5,"decodeObjectForKey:","NSBackgroundColors");
_maxNumberOfRows=objj_msgSend(_5,"decodeIntForKey:","NSMaxNumberOfGridRows");
_maxNumberOfColumns=objj_msgSend(_5,"decodeIntForKey:","NSMaxNumberOfGridColumns");
_isSelectable=objj_msgSend(_5,"decodeBoolForKey:","NSSelectable");
_allowsMultipleSelection=objj_msgSend(_5,"decodeBoolForKey:","NSAllowsMultipleSelection");
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPCollectionView,"NSCollectionView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_6,_7,_8){
with(_6){
return objj_msgSend(_6,"NS_initWithCoder:",_8);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_9,_a){
with(_9){
return objj_msgSend(CPCollectionView,"class");
}
})]);
p;22;NSCollectionViewItem.jt;904;@STATIC;1.0;I;29;AppKit/CPCollectionViewItem.jt;852;
objj_executeFile("AppKit/CPCollectionViewItem.j",NO);
var _1=objj_getClass("CPCollectionViewItem");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPCollectionViewItem\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
return objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPCollectionViewItem").super_class},"NS_initWithCoder:",_5);
}
})]);
var _1=objj_allocateClassPair(CPCollectionViewItem,"NSCollectionViewItem"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_6,_7,_8){
with(_6){
return objj_msgSend(_6,"NS_initWithCoder:",_8);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_9,_a){
with(_9){
return objj_msgSend(CPCollectionViewItem,"class");
}
})]);
p;9;NSColor.jt;2097;@STATIC;1.0;I;19;Foundation/CPData.jI;16;AppKit/CPColor.jt;2033;
objj_executeFile("Foundation/CPData.j",NO);
objj_executeFile("AppKit/CPColor.j",NO);
var _1=-1,_2=0,_3=1,_4=2,_5=3,_6=4,_7=5,_8=6;
var _9=objj_getClass("CPColor");
if(!_9){
throw new SyntaxError("*** Could not find definition for class \"CPColor\"");
}
var _a=_9.isa;
class_addMethods(_9,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_b,_c,_d){
with(_b){
var _e=objj_msgSend(_d,"decodeIntForKey:","NSColorSpace"),_f;
switch(_e){
case 1:
case 2:
var rgb=objj_msgSend(_d,"decodeBytesForKey:","NSRGB"),_10=CFData.bytesToString(rgb),_11=objj_msgSend(_10,"componentsSeparatedByString:"," "),_12=[0,0,0,1];
for(var i=0;i<_11.length&&i<4;i++){
_12[i]=objj_msgSend(_11[i],"floatValue");
}
_f=objj_msgSend(CPColor,"colorWithCalibratedRed:green:blue:alpha:",_12[0],_12[1],_12[2],_12[3]);
break;
case 3:
case 4:
var _13=objj_msgSend(_d,"decodeBytesForKey:","NSWhite"),_10=CFData.bytesToString(_13),_11=objj_msgSend(_10,"componentsSeparatedByString:"," "),_12=[0,1];
for(var i=0;i<_11.length&&i<2;i++){
_12[i]=objj_msgSend(_11[i],"floatValue");
}
_f=objj_msgSend(CPColor,"colorWithCalibratedWhite:alpha:",_12[0],_12[1]);
break;
case 6:
var _14=objj_msgSend(_d,"decodeObjectForKey:","NSCatalogName"),_15=objj_msgSend(_d,"decodeObjectForKey:","NSColorName"),_16=objj_msgSend(_d,"decodeObjectForKey:","NSColor");
if(_14==="System"){
var _f=null;
if(_15==="controlColor"){
_f=nil;
}else{
if(_15==="controlBackgroundColor"){
_f=objj_msgSend(CPColor,"whiteColor");
}else{
if(!_f){
_f=_16;
}
}
}
}else{
_f=null;
if(!_f){
_f=_16;
}
}
break;
default:
CPLog("-[%@ %s] unknown color space %d",isa,_c,_e);
_f=objj_msgSend(CPColor,"blackColor");
break;
}
return _f;
}
})]);
var _9=objj_allocateClassPair(CPColor,"NSColor"),_a=_9.isa;
objj_registerClassPair(_9);
class_addMethods(_9,[new objj_method(sel_getUid("initWithCoder:"),function(_17,_18,_19){
with(_17){
return objj_msgSend(_17,"NS_initWithCoder:",_19);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_1a,_1b){
with(_1a){
return objj_msgSend(CPColor,"class");
}
})]);
p;13;NSColorWell.jt;1113;@STATIC;1.0;I;20;AppKit/CPColorWell.ji;8;NSCell.ji;11;NSControl.jt;1041;
objj_executeFile("AppKit/CPColorWell.j",NO);
objj_executeFile("NSCell.j",YES);
objj_executeFile("NSControl.j",YES);
var _1=objj_getClass("CPColorWell");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPColorWell\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPColorWell").super_class},"NS_initWithCoder:",_5);
if(_3){
objj_msgSend(_3,"setBordered:",objj_msgSend(_5,"decodeBoolForKey:","NSIsBordered"));
objj_msgSend(_3,"setColor:",objj_msgSend(_5,"decodeObjectForKey:","NSColor"));
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPColorWell,"NSColorWell"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_6,_7,_8){
with(_6){
return objj_msgSend(_6,"NS_initWithCoder:",_8);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_9,_a){
with(_9){
return objj_msgSend(CPColorWell,"class");
}
})]);
p;11;NSControl.jt;1600;@STATIC;1.0;I;18;AppKit/CPControl.ji;8;NSCell.ji;8;NSView.jt;1534;
objj_executeFile("AppKit/CPControl.j",NO);
objj_executeFile("NSCell.j",YES);
objj_executeFile("NSView.j",YES);
var _1=objj_getClass("CPControl");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPControl\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPControl").super_class},"NS_initWithCoder:",_5);
if(_3){
objj_msgSend(_3,"sendActionOn:",CPLeftMouseUpMask);
var _6=objj_msgSend(_5,"decodeObjectForKey:","NSCell");
objj_msgSend(_3,"setObjectValue:",objj_msgSend(_6,"objectValue"));
objj_msgSend(_3,"setFont:",objj_msgSend(_6,"font"));
objj_msgSend(_3,"setAlignment:",objj_msgSend(_6,"alignment"));
objj_msgSend(_3,"setEnabled:",objj_msgSend(_5,"decodeObjectForKey:","NSEnabled"));
objj_msgSend(_3,"setContinuous:",objj_msgSend(_6,"isContinuous"));
objj_msgSend(_3,"setTarget:",objj_msgSend(_5,"decodeObjectForKey:","NSTarget"));
objj_msgSend(_3,"setAction:",objj_msgSend(_5,"decodeObjectForKey:","NSAction"));
objj_msgSend(_3,"setLineBreakMode:",objj_msgSend(_6,"lineBreakMode"));
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPControl,"NSControl"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_7,_8,_9){
with(_7){
return objj_msgSend(_7,"NS_initWithCoder:",_9);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_a,_b){
with(_a){
return objj_msgSend(CPControl,"class");
}
})]);
p;16;NSCustomObject.jt;969;@STATIC;1.0;I;27;AppKit/_CPCibCustomObject.jt;919;
objj_executeFile("AppKit/_CPCibCustomObject.j",NO);
var _1=objj_getClass("_CPCibCustomObject");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"_CPCibCustomObject\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("_CPCibCustomObject").super_class},"init");
if(_3){
_className=CP_NSMapClassName(objj_msgSend(_5,"decodeObjectForKey:","NSClassName"));
}
return _3;
}
})]);
var _1=objj_allocateClassPair(_CPCibCustomObject,"NSCustomObject"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_6,_7,_8){
with(_6){
return objj_msgSend(_6,"NS_initWithCoder:",_8);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_9,_a){
with(_9){
return objj_msgSend(_CPCibCustomObject,"class");
}
})]);
p;18;NSCustomResource.jt;1725;@STATIC;1.0;I;29;AppKit/_CPCibCustomResource.jt;1672;
objj_executeFile("AppKit/_CPCibCustomResource.j",NO);
var _1=require("file");
var _2=objj_getClass("_CPCibCustomResource");
if(!_2){
throw new SyntaxError("*** Could not find definition for class \"_CPCibCustomResource\"");
}
var _3=_2.isa;
class_addMethods(_2,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_4,_5,_6){
with(_4){
_4=objj_msgSendSuper({receiver:_4,super_class:objj_getClass("_CPCibCustomResource").super_class},"init");
if(_4){
_className=CP_NSMapClassName(objj_msgSend(_6,"decodeObjectForKey:","NSClassName"));
_resourceName=objj_msgSend(_6,"decodeObjectForKey:","NSResourceName");
var _7=CGSizeMakeZero();
if(!objj_msgSend(objj_msgSend(_6,"resourcesPath"),"length")){
CPLog.warn("*** WARNING: Resources found in nib, but no resources path specified with -R option.");
}else{
var _8=objj_msgSend(_6,"resourcePathForName:",_resourceName);
if(!_8){
CPLog.warn("*** WARNING: Resource named "+_resourceName+" not found in supplied resources path.");
}else{
_7=_9(_1.join(_1.cwd(),_8));
}
if(_8&&_1.extension(_8)!==_1.extension(_resourceName)){
_resourceName+=_1.extension(_8);
}
}
_properties=objj_msgSend(CPDictionary,"dictionaryWithObject:forKey:",_7,"size");
}
return _4;
}
})]);
var _a=require("cappuccino/image-utility"),_9=_a.sizeOfImageAtPath;
var _2=objj_allocateClassPair(_CPCibCustomResource,"NSCustomResource"),_3=_2.isa;
objj_registerClassPair(_2);
class_addMethods(_2,[new objj_method(sel_getUid("initWithCoder:"),function(_b,_c,_d){
with(_b){
return objj_msgSend(_b,"NS_initWithCoder:",_d);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_e,_f){
with(_e){
return objj_msgSend(_CPCibCustomResource,"class");
}
})]);
p;14;NSCustomView.jt;1027;@STATIC;1.0;I;25;AppKit/_CPCibCustomView.ji;8;NSView.jt;967;
objj_executeFile("AppKit/_CPCibCustomView.j",NO);
objj_executeFile("NSView.j",YES);
var _1="_CPCibCustomViewClassNameKey";
var _2=objj_allocateClassPair(CPView,"NSCustomView"),_3=_2.isa;
class_addIvars(_2,[new objj_ivar("_className")]);
objj_registerClassPair(_2);
class_addMethods(_2,[new objj_method(sel_getUid("initWithCoder:"),function(_4,_5,_6){
with(_4){
_4=objj_msgSendSuper({receiver:_4,super_class:objj_getClass("NSCustomView").super_class},"NS_initWithCoder:",_6);
if(_4){
_className=objj_msgSend(_6,"decodeObjectForKey:","NSClassName");
}
return _4;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_7,_8,_9){
with(_7){
objj_msgSendSuper({receiver:_7,super_class:objj_getClass("NSCustomView").super_class},"encodeWithCoder:",_9);
objj_msgSend(_9,"encodeObject:forKey:",CP_NSMapClassName(_className),_1);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_a,_b){
with(_a){
return objj_msgSend(_CPCibCustomView,"class");
}
})]);
p;14;NSDictionary.jt;491;@STATIC;1.0;t;473;
var _1=objj_allocateClassPair(CPObject,"NSDictionary"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_3,_4,_5){
with(_3){
return objj_msgSend(CPDictionary,"dictionaryWithObjects:forKeys:",objj_msgSend(_5,"decodeObjectForKey:","NS.objects"),objj_msgSend(_5,"decodeObjectForKey:","NS.keys"));
}
})]);
var _1=objj_allocateClassPair(NSDictionary,"NSMutableDictionary"),_2=_1.isa;
objj_registerClassPair(_1);
p;9;NSEvent.jt;718;@STATIC;1.0;t;700;
NSAlphaShiftKeyMask=1<<16;
NSShiftKeyMask=1<<17;
NSControlKeyMask=1<<18;
NSAlternateKeyMask=1<<19;
NSCommandKeyMask=1<<20;
NSNumericPadKeyMask=1<<21;
NSHelpKeyMask=1<<22;
NSFunctionKeyMask=1<<23;
NSDeviceIndependentModifierFlagsMask=4294901760;
CP_NSMapKeyMask=function(_1){
var _2=0;
if(_1&NSAlphaShiftKeyMask){
_2|=CPAlphaShiftKeyMask;
}
if(_1&NSShiftKeyMask){
_2|=CPShiftKeyMask;
}
if(_1&NSControlKeyMask){
_2|=CPControlKeyMask;
}
if(_1&NSAlternateKeyMask){
_2|=CPAlternateKeyMask;
}
if(_1&NSCommandKeyMask){
_2|=CPCommandKeyMask;
}
if(_1&NSNumericPadKeyMask){
_2|=CPNumericPadKeyMask;
}
if(_1&NSHelpKeyMask){
_2|=CPHelpKeyMask;
}
if(_1&NSFunctionKeyMask){
_2|=CPFunctionKeyMask;
}
return _2;
};
p;8;NSFont.jt;1113;@STATIC;1.0;I;15;AppKit/CPFont.jt;1074;
objj_executeFile("AppKit/CPFont.j",NO);
var _1=objj_getClass("CPFont");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPFont\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
var _6=NO,_7=objj_msgSend(_5,"decodeObjectForKey:","NSName"),_8=objj_msgSend(_5,"decodeDoubleForKey:","NSSize");
if(_7==="LucidaGrande"&&_8===13){
CPLog.debug("Removing default IB font: <"+_7+", "+_8+"> for theme default font.");
return nil;
}
if(_7.indexOf("-Bold")===_7.length-"-Bold".length){
_6=YES;
}
if(_7==="LucidaGrande"||_7==="LucidaGrande-Bold"){
_7="Arial";
}
return objj_msgSend(_3,"_initWithName:size:bold:",_7,_8,_6);
}
})]);
var _1=objj_allocateClassPair(CPFont,"NSFont"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_9,_a,_b){
with(_9){
return objj_msgSend(_9,"NS_initWithCoder:",_b);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_c,_d){
with(_c){
return objj_msgSend(CPFont,"class");
}
})]);
p;13;NSFormatter.jt;211;@STATIC;1.0;t;193;
var _1=objj_allocateClassPair(CPObject,"NSFormatter"),_2=_1.isa;
objj_registerClassPair(_1);
var _1=objj_allocateClassPair(CPObject,"NSNumberFormatter"),_2=_1.isa;
objj_registerClassPair(_1);
p;14;NSFoundation.jt;235;@STATIC;1.0;i;9;NSArray.ji;14;NSDictionary.ji;17;NSMutableString.ji;7;NSSet.jt;152;
objj_executeFile("NSArray.j",YES);
objj_executeFile("NSDictionary.j",YES);
objj_executeFile("NSMutableString.j",YES);
objj_executeFile("NSSet.j",YES);
p;16;NSIBObjectData.jt;2533;@STATIC;1.0;I;25;AppKit/_CPCibObjectData.ji;8;NSCell.jt;2472;
objj_executeFile("AppKit/_CPCibObjectData.j",NO);
objj_executeFile("NSCell.j",YES);
var _1=objj_getClass("_CPCibObjectData");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"_CPCibObjectData\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSend(_3,"init");
if(_3){
_namesKeys=objj_msgSend(_5,"decodeObjectForKey:","NSNamesKeys");
_namesValues=objj_msgSend(_5,"decodeObjectForKey:","NSNamesValues");
_classesKeys=objj_msgSend(_5,"decodeObjectForKey:","NSClassesKeys");
_classesValues=objj_msgSend(_5,"decodeObjectForKey:","NSClassesValues");
_connections=objj_msgSend(_5,"decodeObjectForKey:","NSConnections");
_framework=objj_msgSend(_5,"decodeObjectForKey:","NSFramework");
_objectsKeys=objj_msgSend(_5,"decodeObjectForKey:","NSObjectsKeys");
_objectsValues=objj_msgSend(_5,"decodeObjectForKey:","NSObjectsValues");
objj_msgSend(_3,"removeCellsFromObjectGraph");
_fileOwner=objj_msgSend(_5,"decodeObjectForKey:","NSRoot");
_visibleWindows=objj_msgSend(_5,"decodeObjectForKey:","NSVisibleWindows");
}
return _3;
}
}),new objj_method(sel_getUid("removeCellsFromObjectGraph"),function(_6,_7){
with(_6){
var _8=_objectsKeys.length,_9={},_a={};
while(_8--){
var _b=_objectsKeys[_8];
if(!_b){
continue;
}
var _c=_objectsValues[_8];
if(objj_msgSend(_b,"isKindOfClass:",objj_msgSend(NSCell,"class"))){
_9[objj_msgSend(_b,"UID")]=_c;
continue;
}
if(!objj_msgSend(_c,"isKindOfClass:",objj_msgSend(NSCell,"class"))){
continue;
}
var _d=objj_msgSend(_c,"UID"),_e=_a[_d];
if(!_e){
_e=[];
_a[_d]=_e;
}
_e.push(_b);
_objectsKeys.splice(_8,1);
_objectsValues.splice(_8,1);
}
for(var _f in _a){
if(_a.hasOwnProperty(_f)){
var _e=_a[_f],_c=_9[_f];
_e.forEach(function(_10){
CPLog.info("Promoted "+_10+" to child of "+_c);
_objectsKeys.push(_10);
_objectsValues.push(_c);
});
}
}
var _8=_objectsKeys.length;
while(_8--){
var _11=_objectsKeys[_8];
if(objj_msgSend(_11,"respondsToSelector:",sel_getUid("swapCellsForParents:"))){
objj_msgSend(_11,"swapCellsForParents:",_9);
}
}
}
})]);
var _1=objj_allocateClassPair(_CPCibObjectData,"NSIBObjectData"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_12,_13,_14){
with(_12){
return objj_msgSend(_12,"NS_initWithCoder:",_14);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_15,_16){
with(_15){
return objj_msgSend(_CPCibObjectData,"class");
}
})]);
p;13;NSImageView.jt;3130;@STATIC;1.0;I;20;AppKit/CPImageView.jt;3086;
objj_executeFile("AppKit/CPImageView.j",NO);
var _1=objj_getClass("CPImageView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPImageView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPImageView").super_class},"NS_initWithCoder:",_5);
if(_3){
var _6=objj_msgSend(_5,"decodeObjectForKey:","NSCell");
objj_msgSend(_3,"setImageScaling:",objj_msgSend(_6,"imageScaling"));
objj_msgSend(_3,"setImageAlignment:",objj_msgSend(_6,"imageAlignment"));
_isEditable=objj_msgSend(_6,"isEditable");
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPImageView,"NSImageView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_7,_8,_9){
with(_7){
return objj_msgSendSuper({receiver:_7,super_class:objj_getClass("NSImageView").super_class},"NS_initWithCoder:",_9);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_a,_b){
with(_a){
return objj_msgSend(CPImageView,"class");
}
})]);
NSImageAlignCenter=0;
NSImageAlignTop=1;
NSImageAlignTopLeft=2;
NSImageAlignTopRight=3;
NSImageAlignLeft=4;
NSImageAlignBottom=5;
NSImageAlignBottomLeft=6;
NSImageAlignBottomRight=7;
NSImageAlignRight=8;
NSImageScaleProportionallyDown=0;
NSImageScaleAxesIndependently=1;
NSImageScaleNone=2;
NSImageScaleProportionallyUpOrDown=3;
NSImageFrameNone=0;
NSImageFramePhoto=1;
NSImageFrameGrayBezel=2;
NSImageFrameGroove=3;
NSImageFrameButton=4;
var _c={};
_c[NSImageScaleProportionallyDown]=CPScaleProportionally;
_c[NSImageScaleAxesIndependently]=CPScaleToFit;
_c[NSImageScaleNone]=CPScaleNone;
_c[NSImageScaleProportionallyUpOrDown]=CPScaleProportionally;
var _1=objj_allocateClassPair(NSCell,"NSImageCell"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_animates"),new objj_ivar("_imageAlignment"),new objj_ivar("_imageScaling"),new objj_ivar("_frameStyle")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("_animates"),function(_d,_e){
with(_d){
return _animates;
}
}),new objj_method(sel_getUid("_setAnimates:"),function(_f,_10,_11){
with(_f){
_animates=_11;
}
}),new objj_method(sel_getUid("imageAlignment"),function(_12,_13){
with(_12){
return _imageAlignment;
}
}),new objj_method(sel_getUid("imageScaling"),function(_14,_15){
with(_14){
return _imageScaling;
}
}),new objj_method(sel_getUid("_frameStyle"),function(_16,_17){
with(_16){
return _frameStyle;
}
}),new objj_method(sel_getUid("_setFrameStyle:"),function(_18,_19,_1a){
with(_18){
_frameStyle=_1a;
}
}),new objj_method(sel_getUid("initWithCoder:"),function(_1b,_1c,_1d){
with(_1b){
_1b=objj_msgSendSuper({receiver:_1b,super_class:objj_getClass("NSImageCell").super_class},"initWithCoder:",_1d);
if(_1b){
_animates=objj_msgSend(_1d,"decodeBoolForKey:","NSAnimates");
_imageAlignment=objj_msgSend(_1d,"decodeIntForKey:","NSAlign");
_imageScaling=_c[objj_msgSend(_1d,"decodeIntForKey:","NSScale")];
_frameStyle=objj_msgSend(_1d,"decodeIntForKey:","NSStyle");
}
return _1b;
}
})]);
p;10;NSMatrix.jt;1838;@STATIC;1.0;I;21;Foundation/CPObject.jI;15;AppKit/CPView.ji;8;NSView.jt;1761;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("AppKit/CPView.j",NO);
objj_executeFile("NSView.j",YES);
var _1=1073741824,_2=16777216;
var _3=objj_allocateClassPair(CPObject,"NSMatrix"),_4=_3.isa;
objj_registerClassPair(_3);
class_addMethods(_3,[new objj_method(sel_getUid("initWithCoder:"),function(_5,_6,_7){
with(_5){
var _8=objj_msgSend(objj_msgSend(CPView,"alloc"),"NS_initWithCoder:",_7);
var _9=objj_msgSend(_7,"decodeIntForKey:","NSNumRows"),_a=objj_msgSend(_7,"decodeIntForKey:","NSNumCols"),_b=objj_msgSend(_7,"decodeSizeForKey:","NSCellSize"),_c=objj_msgSend(_7,"decodeSizeForKey:","NSIntercellSpacing"),_d=objj_msgSend(_7,"decodeIntForKey:","NSMatrixFlags"),_e=_d&_1,_f=_d&_2,_10=objj_msgSend(_7,"decodeObjectForKey:","NSBackgroundColor"),_11=objj_msgSend(_7,"decodeObjectForKey:","NSCells"),_12=objj_msgSend(_7,"decodeObjectForKey:","NSSelectedCell");
if(_e){
var _13=objj_msgSend(CPRadioGroup,"new"),_14=CGRectMake(0,0,_b.width,_b.height);
for(var _15=0;_15<_9;++_15){
_14.origin.x=0;
for(var _16=0;_16<_a;++_16){
var _17=_11[_15*_a+_16],_18=objj_msgSend(objj_msgSend(CPRadio,"alloc"),"initWithFrame:radioGroup:",_14,_13);
objj_msgSend(_18,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(_18,"setTitle:",objj_msgSend(_17,"title"));
objj_msgSend(_18,"setBackgroundColor:",objj_msgSend(CPColor,"clearColor"));
objj_msgSend(_18,"setObjectValue:",objj_msgSend(_17,"objectValue"));
objj_msgSend(_8,"addSubview:",_18);
NIB_CONNECTION_EQUIVALENCY_TABLE[objj_msgSend(_17,"UID")]=_18;
_14.origin.x=CGRectGetMaxX(_14)+_c.width;
}
_14.origin.y=CGRectGetMaxY(_14)+_c.height;
}
if(_f){
objj_msgSend(_8,"setBackgroundColor:",_10);
}
NIB_CONNECTION_EQUIVALENCY_TABLE[objj_msgSend(_5,"UID")]=_8;
}
return _8;
}
})]);
p;8;NSMenu.jt;1489;@STATIC;1.0;I;15;AppKit/CPMenu.ji;12;NSMenuItem.jt;1433;
objj_executeFile("AppKit/CPMenu.j",NO);
objj_executeFile("NSMenuItem.j",YES);
NS_CPMenuNameMap={_NSMainMenu:"_CPMainMenu",_NSAppleMenu:"_CPApplicationMenu",_NSServicesMenu:"_CPServicesMenu",_NSWindowsMenu:"_CPWindowsMenu",_NSFontMenu:"_CPFontMenu",_NSRecentDocumentsMenu:"_CPRecentDocumentsMenu",_NSOpenDocumentsMenu:"_CPOpenDocumentsMenu"};
var _1=objj_getClass("CPMenu");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPMenu\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPMenu").super_class},"init");
if(_3){
_title=objj_msgSend(_5,"decodeObjectForKey:","NSTitle");
_items=objj_msgSend(_5,"decodeObjectForKey:","NSMenuItems");
_name=objj_msgSend(_5,"decodeObjectForKey:","NSName");
var _6=NS_CPMenuNameMap[_name];
if(_6){
_name=_6;
}
_showsStateColumn=!objj_msgSend(_5,"containsValueForKey:","NSMenuExcludeMarkColumn")||!objj_msgSend(_5,"decodeBoolForKey:","NSMenuExcludeMarkColumn");
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPMenu,"NSMenu"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_7,_8,_9){
with(_7){
return objj_msgSend(_7,"NS_initWithCoder:",_9);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_a,_b){
with(_a){
return objj_msgSend(CPMenu,"class");
}
})]);
p;12;NSMenuItem.jt;2093;@STATIC;1.0;I;19;AppKit/CPMenuItem.ji;9;NSEvent.ji;8;NSMenu.jt;2025;
objj_executeFile("AppKit/CPMenuItem.j",NO);
objj_executeFile("NSEvent.j",YES);
objj_executeFile("NSMenu.j",YES);
var _1=objj_getClass("CPMenuItem");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPMenuItem\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPMenuItem").super_class},"init");
if(_3){
_isSeparator=objj_msgSend(_5,"decodeObjectForKey:","NSIsSeparator")||NO;
_title=objj_msgSend(_5,"decodeObjectForKey:","NSTitle");
_target=objj_msgSend(_5,"decodeObjectForKey:","NSTarget");
_action=objj_msgSend(_5,"decodeObjectForKey:","NSAction");
_isEnabled=!objj_msgSend(_5,"decodeBoolForKey:","NSIsDisabled");
_isHidden=objj_msgSend(_5,"decodeBoolForKey:","NSIsHidden");
_tag=objj_msgSend(_5,"decodeIntForKey:","NSTag");
_state=objj_msgSend(_5,"decodeIntForKey:","NSState");
_submenu=objj_msgSend(_5,"decodeObjectForKey:","NSSubmenu");
_menu=objj_msgSend(_5,"decodeObjectForKey:","NSMenu");
_keyEquivalent=objj_msgSend(_5,"decodeObjectForKey:","NSKeyEquiv");
_keyEquivalentModifierMask=CP_NSMapKeyMask(objj_msgSend(_5,"decodeObjectForKey:","NSKeyEquivModMask"));
_indentationLevel=objj_msgSend(_5,"decodeIntForKey:","NSIndent");
}
return _3;
}
}),new objj_method(sel_getUid("swapCellsForParents:"),function(_6,_7,_8){
with(_6){
var _9=objj_msgSend(_6,"target");
if(!_9){
return;
}
var _a=_8[objj_msgSend(objj_msgSend(_6,"target"),"UID")];
if(_a){
objj_msgSend(_6,"setTarget:",_a);
}
}
})]);
var _1=objj_allocateClassPair(CPMenuItem,"NSMenuItem"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_b,_c,_d){
with(_b){
return objj_msgSend(_b,"NS_initWithCoder:",_d);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_e,_f){
with(_e){
return objj_msgSend(CPMenuItem,"class");
}
})]);
var _1=objj_allocateClassPair(NSButtonCell,"NSMenuItemCell"),_2=_1.isa;
objj_registerClassPair(_1);
p;17;NSMutableString.jt;279;@STATIC;1.0;t;261;
var _1=objj_allocateClassPair(CPObject,"NSMutableString"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_3,_4,_5){
with(_3){
return objj_msgSend(_5,"decodeObjectForKey:","NS.string");
}
})]);
p;16;NSNibConnector.jt;4365;@STATIC;1.0;I;23;AppKit/CPCibConnector.jI;30;AppKit/CPCibControlConnector.jI;29;AppKit/CPCibOutletConnector.jt;4249;
objj_executeFile("AppKit/CPCibConnector.j",NO);
objj_executeFile("AppKit/CPCibControlConnector.j",NO);
objj_executeFile("AppKit/CPCibOutletConnector.j",NO);
NIB_CONNECTION_EQUIVALENCY_TABLE={};
var _1=objj_getClass("CPCibConnector");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPCibConnector\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPCibConnector").super_class},"init");
if(_3){
_source=objj_msgSend(_5,"decodeObjectForKey:","NSSource");
_destination=objj_msgSend(_5,"decodeObjectForKey:","NSDestination");
_label=objj_msgSend(_5,"decodeObjectForKey:","NSLabel");
var _6=objj_msgSend(_source,"UID"),_7=objj_msgSend(_destination,"UID");
if(_6 in NIB_CONNECTION_EQUIVALENCY_TABLE){
CPLog.trace("Swapped object: "+_source+" for object: "+NIB_CONNECTION_EQUIVALENCY_TABLE[_6]);
_source=NIB_CONNECTION_EQUIVALENCY_TABLE[_6];
}
if(_7 in NIB_CONNECTION_EQUIVALENCY_TABLE){
CPLog.trace("Swapped object: "+_destination+" for object: "+NIB_CONNECTION_EQUIVALENCY_TABLE[_7]);
_destination=NIB_CONNECTION_EQUIVALENCY_TABLE[_7];
}
CPLog.debug("Connection: "+objj_msgSend(_source,"description")+" "+objj_msgSend(_destination,"description")+" "+_label);
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPCibConnector,"NSNibConnector"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_8,_9,_a){
with(_8){
return objj_msgSend(_8,"NS_initWithCoder:",_a);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_b,_c){
with(_b){
return objj_msgSend(CPCibConnector,"class");
}
})]);
var _1=objj_allocateClassPair(CPCibControlConnector,"NSNibControlConnector"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_d,_e,_f){
with(_d){
return objj_msgSend(_d,"NS_initWithCoder:",_f);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_10,_11){
with(_10){
return objj_msgSend(CPCibControlConnector,"class");
}
})]);
var _1=objj_allocateClassPair(CPCibOutletConnector,"NSNibOutletConnector"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_12,_13,_14){
with(_12){
return objj_msgSend(_12,"NS_initWithCoder:",_14);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_15,_16){
with(_15){
return objj_msgSend(CPCibOutletConnector,"class");
}
})]);
var _17=objj_msgSend(CPSet,"setWithObjects:","NSNegateBoolean","NSIsNil","NSIsNotNil","NSUnarchiveFromData","NSKeyedUnarchiveFromData");
var _1=objj_getClass("CPCibBindingConnector");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPCibBindingConnector\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_18,_19,_1a){
with(_18){
_18=objj_msgSendSuper({receiver:_18,super_class:objj_getClass("CPCibBindingConnector").super_class},"NS_initWithCoder:",_1a);
if(_18){
_binding=objj_msgSend(_1a,"decodeObjectForKey:","NSBinding");
_keyPath=objj_msgSend(_1a,"decodeObjectForKey:","NSKeyPath");
_options=objj_msgSend(CPDictionary,"dictionary");
var _1b=objj_msgSend(_1a,"decodeObjectForKey:","NSOptions"),_1c=objj_msgSend(_1b,"keyEnumerator"),key;
while(key=objj_msgSend(_1c,"nextObject")){
var _1d="CP"+key.substring(2),_1e=objj_msgSend(_1b,"objectForKey:",key);
if(_1d===CPValueTransformerNameBindingOption&&objj_msgSend(_17,"containsObject:",_1e)){
_1e="CP"+_1e.substring(2);
}
objj_msgSend(_options,"setObject:forKey:",_1e,_1d);
}
CPLog.debug("Binding Connector: "+objj_msgSend(_binding,"description")+" to: "+_destination+" "+objj_msgSend(_keyPath,"description")+" "+objj_msgSend(_options,"description"));
}
return _18;
}
})]);
var _1=objj_allocateClassPair(CPCibBindingConnector,"NSNibBindingConnector"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_1f,_20,_21){
with(_1f){
return objj_msgSend(_1f,"NS_initWithCoder:",_21);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_22,_23){
with(_22){
return objj_msgSend(CPCibBindingConnector,"class");
}
})]);
p;20;NSObjectController.jt;1305;@STATIC;1.0;I;27;AppKit/CPObjectController.jt;1254;
objj_executeFile("AppKit/CPObjectController.j",NO);
var _1=objj_getClass("CPObjectController");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPObjectController\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPObjectController").super_class},"init");
if(_3){
_declaredKeys=objj_msgSend(_5,"decodeObjectForKey:","NSDeclaredKeys");
var _6=objj_msgSend(_5,"decodeObjectForKey:","NSObjectClassName");
if(_6){
_objectClassName=CP_NSMapClassName(_6);
}else{
_objectClass=objj_msgSend(CPMutableDictionary,"class");
}
_isEditable=objj_msgSend(_5,"decodeBoolForKey:","NSEditable");
_automaticallyPreparesContent=objj_msgSend(_5,"decodeBoolForKey:","NSAutomaticallyPreparesContent");
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPObjectController,"NSObjectController"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_7,_8,_9){
with(_7){
return objj_msgSend(_7,"NS_initWithCoder:",_9);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_a,_b){
with(_a){
return objj_msgSend(CPObjectController,"class");
}
})]);
p;15;NSOutlineView.jt;1390;@STATIC;1.0;I;22;AppKit/CPOutlineView.jt;1344;
objj_executeFile("AppKit/CPOutlineView.j",NO);
var _1=objj_getClass("CPOutlineView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPOutlineView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPOutlineView").super_class},"NS_initWithCoder:",_5);
if(_3){
if(objj_msgSend(_5,"containsValueForKey:","NSOutlineViewOutlineTableColumnKey")){
_outlineTableColumn=objj_msgSend(_5,"decodeObjectForKey:","NSOutlineViewOutlineTableColumnKey");
}else{
_outlineTableColumn=objj_msgSend(objj_msgSend(_3,"tableColumns"),"objectAtIndex:",0);
}
_indentationPerLevel=objj_msgSend(_5,"decodeFloatForKey:","NSOutlineViewIndentationPerLevelKey");
_outlineViewDataSource=objj_msgSend(_5,"decodeObjectForKey:","NSDataSource");
_outlineViewDelegate=objj_msgSend(_5,"decodeObjectForKey:","NSDelegate");
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPOutlineView,"NSOutlineView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_6,_7,_8){
with(_6){
return objj_msgSend(_6,"NS_initWithCoder:",_8);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_9,_a){
with(_9){
return objj_msgSend(CPOutlineView,"class");
}
})]);
p;15;NSPopUpButton.jt;2276;@STATIC;1.0;I;22;AppKit/CPPopUpButton.ji;8;NSMenu.jt;2218;
objj_executeFile("AppKit/CPPopUpButton.j",NO);
objj_executeFile("NSMenu.j",YES);
var _1=objj_getClass("CPPopUpButton");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPPopUpButton\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPPopUpButton").super_class},"NS_initWithCoder:",_5)){
var _6=objj_msgSend(_5,"decodeObjectForKey:","NSCell");
_menu=objj_msgSend(_6,"menu");
_selectedIndex=objj_msgSend(_6,"selectedIndex")||0;
objj_msgSend(_3,"setPullsDown:",objj_msgSend(_6,"pullsDown"));
_preferredEdge=objj_msgSend(_6,"preferredEdge");
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPPopUpButton,"NSPopUpButton"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_7,_8,_9){
with(_7){
return objj_msgSend(_7,"NS_initWithCoder:",_9);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_a,_b){
with(_a){
return objj_msgSend(CPPopUpButton,"class");
}
})]);
var _1=objj_allocateClassPair(NSMenuItemCell,"NSPopUpButtonCell"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("pullsDown"),new objj_ivar("selectedIndex"),new objj_ivar("preferredEdge"),new objj_ivar("menu")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("pullsDown"),function(_c,_d){
with(_c){
return pullsDown;
}
}),new objj_method(sel_getUid("selectedIndex"),function(_e,_f){
with(_e){
return selectedIndex;
}
}),new objj_method(sel_getUid("preferredEdge"),function(_10,_11){
with(_10){
return preferredEdge;
}
}),new objj_method(sel_getUid("menu"),function(_12,_13){
with(_12){
return menu;
}
}),new objj_method(sel_getUid("initWithCoder:"),function(_14,_15,_16){
with(_14){
_14=objj_msgSendSuper({receiver:_14,super_class:objj_getClass("NSPopUpButtonCell").super_class},"initWithCoder:",_16);
if(_14){
pullsDown=objj_msgSend(_16,"decodeBoolForKey:","NSPullDown");
selectedIndex=objj_msgSend(_16,"decodeIntForKey:","NSSelectedIndex");
preferredEdge=objj_msgSend(_16,"decodeIntForKey:","NSPreferredEdge");
menu=objj_msgSend(_16,"decodeObjectForKey:","NSMenu");
}
return _14;
}
})]);
p;13;NSResponder.jt;928;@STATIC;1.0;I;20;AppKit/CPResponder.jt;885;
objj_executeFile("AppKit/CPResponder.j",NO);
var _1=objj_getClass("CPResponder");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPResponder\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPResponder").super_class},"init");
if(_3){
objj_msgSend(_3,"setNextResponder:",objj_msgSend(_5,"decodeObjectForKey:","NSNextResponder"));
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPResponder,"NSResponder"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_6,_7,_8){
with(_6){
return objj_msgSend(_6,"NS_initWithCoder:",_8);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_9,_a){
with(_9){
return objj_msgSend(CPResponder,"class");
}
})]);
p;12;NSScroller.jt;1676;@STATIC;1.0;I;19;AppKit/CPScroller.jt;1633;
objj_executeFile("AppKit/CPScroller.j",NO);
var _1=objj_getClass("CPScroller");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPScroller\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPScroller").super_class},"NS_initWithCoder:",_5)){
_controlSize=CPRegularControlSize;
_knobProportion=1;
if(objj_msgSend(_5,"containsValueForKey:","NSPercent")){
_knobProportion=objj_msgSend(_5,"decodeFloatForKey:","NSPercent");
}
_value=0;
if(objj_msgSend(_5,"containsValueForKey:","NSCurValue")){
_value=objj_msgSend(_5,"decodeFloatForKey:","NSCurValue");
}
objj_msgSend(_3,"_calculateIsVertical");
var _6=objj_msgSend(_3,"isVertical");
if(CPStringFromSelector(objj_msgSend(_3,"action"))==="_doScroller:"){
if(_6){
objj_msgSend(_3,"setAction:",sel_getUid("_verticalScrollerDidScroll:"));
}else{
objj_msgSend(_3,"setAction:",sel_getUid("_horizontalScrollerDidScroll:"));
}
}
_partRects=[];
if(_6){
objj_msgSend(_3,"setFrameSize:",CGSizeMake(15,CGRectGetHeight(objj_msgSend(_3,"frame"))));
}else{
objj_msgSend(_3,"setFrameSize:",CGSizeMake(CGRectGetWidth(objj_msgSend(_3,"frame")),15));
}
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPScroller,"NSScroller"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_7,_8,_9){
with(_7){
return objj_msgSend(_7,"NS_initWithCoder:",_9);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_a,_b){
with(_a){
return objj_msgSend(CPScroller,"class");
}
})]);
p;14;NSScrollView.jt;1612;@STATIC;1.0;I;21;AppKit/CPScrollView.jt;1567;
objj_executeFile("AppKit/CPScrollView.j",NO);
var _1=objj_getClass("CPScrollView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPScrollView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPScrollView").super_class},"NS_initWithCoder:",_5)){
var _6=objj_msgSend(_5,"decodeIntForKey:","NSsFlags");
_verticalScroller=objj_msgSend(_5,"decodeObjectForKey:","NSVScroller");
_horizontalScroller=objj_msgSend(_5,"decodeObjectForKey:","NSHScroller");
_contentView=objj_msgSend(_5,"decodeObjectForKey:","NSContentView");
_headerClipView=objj_msgSend(_5,"decodeObjectForKey:","NSHeaderClipView");
_cornerView=objj_msgSend(_5,"decodeObjectForKey:","NSCornerView");
_bottomCornerView=objj_msgSend(objj_msgSend(CPView,"alloc"),"init");
objj_msgSend(_3,"addSubview:",_bottomCornerView);
_hasVerticalScroller=!!(_6&(1<<4));
_hasHorizontalScroller=!!(_6&(1<<5));
_autohidesScrollers=!!(_6&(1<<9));
_borderType=_6&3;
_verticalLineScroll=10;
_verticalPageScroll=10;
_horizontalLineScroll=10;
_horizontalPageScroll=10;
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPScrollView,"NSScrollView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_7,_8,_9){
with(_7){
return objj_msgSend(_7,"NS_initWithCoder:",_9);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_a,_b){
with(_a){
return objj_msgSend(CPScrollView,"class");
}
})]);
p;15;NSSearchField.jt;3172;@STATIC;1.0;I;22;AppKit/CPSearchField.ji;13;NSTextField.jt;3108;
objj_executeFile("AppKit/CPSearchField.j",NO);
objj_executeFile("NSTextField.j",YES);
var _1=objj_getClass("CPSearchField");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPSearchField\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPSearchField").super_class},"NS_initWithCoder:",_5);
if(_3){
var _6=objj_msgSend(_5,"decodeObjectForKey:","NSCell");
objj_msgSend(_3,"setRecentsAutosaveName:",objj_msgSend(_6,"recentsAutosaveName"));
objj_msgSend(_3,"setMaximumRecents:",objj_msgSend(_6,"maximumRecents"));
objj_msgSend(_3,"setSendsWholeSearchString:",objj_msgSend(_6,"sendsWholeSearchString"));
objj_msgSend(_3,"setSendsSearchStringImmediately:",objj_msgSend(_6,"sendsSearchStringImmediately"));
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPSearchField,"NSSearchField"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_7,_8,_9){
with(_7){
_7=objj_msgSend(_7,"NS_initWithCoder:",_9);
return _7;
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_a,_b){
with(_a){
return objj_msgSend(CPSearchField,"class");
}
})]);
var _1=objj_allocateClassPair(NSTextFieldCell,"NSSearchFieldCell"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_recentsAutosaveName"),new objj_ivar("_maximumRecents"),new objj_ivar("_sendsWholeSearchString"),new objj_ivar("_sendsSearchStringImmediately")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("recentsAutosaveName"),function(_c,_d){
with(_c){
return _recentsAutosaveName;
}
}),new objj_method(sel_getUid("setRecentsAutosaveName:"),function(_e,_f,_10){
with(_e){
_recentsAutosaveName=_10;
}
}),new objj_method(sel_getUid("maximumRecents"),function(_11,_12){
with(_11){
return _maximumRecents;
}
}),new objj_method(sel_getUid("setMaximumRecents:"),function(_13,_14,_15){
with(_13){
_maximumRecents=_15;
}
}),new objj_method(sel_getUid("sendsWholeSearchString"),function(_16,_17){
with(_16){
return _sendsWholeSearchString;
}
}),new objj_method(sel_getUid("setSendsWholeSearchString:"),function(_18,_19,_1a){
with(_18){
_sendsWholeSearchString=_1a;
}
}),new objj_method(sel_getUid("sendsSearchStringImmediately"),function(_1b,_1c){
with(_1b){
return _sendsSearchStringImmediately;
}
}),new objj_method(sel_getUid("setSendsSearchStringImmediately:"),function(_1d,_1e,_1f){
with(_1d){
_sendsSearchStringImmediately=_1f;
}
}),new objj_method(sel_getUid("initWithCoder:"),function(_20,_21,_22){
with(_20){
if(_20=objj_msgSendSuper({receiver:_20,super_class:objj_getClass("NSSearchFieldCell").super_class},"initWithCoder:",_22)){
_recentsAutosaveName=objj_msgSend(_22,"decodeObjectForKey:","NSRecentsAutosaveName");
_maximumRecents=objj_msgSend(_22,"decodeIntForKey:","NSMaximumRecents");
_sendsWholeSearchString=objj_msgSend(_22,"decodeBoolForKey:","NSSendsWholeSearchString")?YES:NO;
_sendsSearchStringImmediately=objj_msgSend(_22,"decodeBytesForKey:","NSSearchFieldFlags")?YES:NO;
}
return _20;
}
})]);
p;19;NSSecureTextField.jt;660;@STATIC;1.0;I;26;AppKit/CPSecureTextField.ji;13;NSTextField.jt;593;
objj_executeFile("AppKit/CPSecureTextField.j",NO);
objj_executeFile("NSTextField.j",YES);
var _1=objj_allocateClassPair(CPSecureTextField,"NSSecureTextField"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_3,_4,_5){
with(_3){
return objj_msgSend(_3,"NS_initWithCoder:",_5);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_6,_7){
with(_6){
return objj_msgSend(CPSecureTextField,"class");
}
})]);
var _1=objj_allocateClassPair(NSTextFieldCell,"NSSecureTextFieldCell"),_2=_1.isa;
objj_registerClassPair(_1);
p;20;NSSegmentedControl.jt;4176;@STATIC;1.0;I;27;AppKit/CPSegmentedControl.jt;4125;
objj_executeFile("AppKit/CPSegmentedControl.j",NO);
var _1=objj_getClass("CPSegmentedControl");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPSegmentedControl\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_segments=[];
_themeStates=[];
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPSegmentedControl").super_class},"NS_initWithCoder:",_5)){
var _6=objj_msgSend(_3,"frame"),_7=_6.size.width;
_6.size.width=0;
_6.origin.x=MAX(_6.origin.x-4,0);
objj_msgSend(_3,"setFrame:",_6);
var _8=objj_msgSend(_5,"decodeObjectForKey:","NSCell");
_segments=objj_msgSend(_8,"segments");
_selectedSegment=objj_msgSend(_8,"selectedSegment");
_segmentStyle=objj_msgSend(_8,"segmentStyle");
_trackingMode=objj_msgSend(_8,"trackingMode");
objj_msgSend(_3,"setValue:forThemeAttribute:",CPCenterTextAlignment,"alignment");
for(var i=0;i<_segments.length;i++){
_themeStates[i]=_segments[i].selected?CPThemeStateSelected:CPThemeStateNormal;
objj_msgSend(_3,"tileWithChangedSegment:",i);
}
_6.size.width=_7;
objj_msgSend(_3,"setFrame:",_6);
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPSegmentedControl,"NSSegmentedControl"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_9,_a,_b){
with(_9){
return objj_msgSend(_9,"NS_initWithCoder:",_b);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_c,_d){
with(_c){
return objj_msgSend(CPSegmentedControl,"class");
}
})]);
var _1=objj_allocateClassPair(NSActionCell,"NSSegmentedCell"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_segments"),new objj_ivar("_selectedSegment"),new objj_ivar("_segmentStyle"),new objj_ivar("_trackingMode")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("segments"),function(_e,_f){
with(_e){
return _segments;
}
}),new objj_method(sel_getUid("selectedSegment"),function(_10,_11){
with(_10){
return _selectedSegment;
}
}),new objj_method(sel_getUid("segmentStyle"),function(_12,_13){
with(_12){
return _segmentStyle;
}
}),new objj_method(sel_getUid("trackingMode"),function(_14,_15){
with(_14){
return _trackingMode;
}
}),new objj_method(sel_getUid("initWithCoder:"),function(_16,_17,_18){
with(_16){
if(_16=objj_msgSendSuper({receiver:_16,super_class:objj_getClass("NSSegmentedCell").super_class},"initWithCoder:",_18)){
_segments=objj_msgSend(_18,"decodeObjectForKey:","NSSegmentImages");
_selectedSegment=objj_msgSend(_18,"decodeIntForKey:","NSSelectedSegment")||-1;
_segmentStyle=objj_msgSend(_18,"decodeIntForKey:","NSSegmentStyle");
_trackingMode=objj_msgSend(_18,"decodeIntForKey:","NSTrackingMode")||CPSegmentSwitchTrackingSelectOne;
if(_trackingMode==CPSegmentSwitchTrackingSelectOne&&_selectedSegment==-1){
_selectedSegment=0;
}
}
return _16;
}
})]);
var _1=objj_getClass("_CPSegmentItem");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"_CPSegmentItem\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_19,_1a,_1b){
with(_19){
if(_19=objj_msgSendSuper({receiver:_19,super_class:objj_getClass("_CPSegmentItem").super_class},"init")){
image=objj_msgSend(_1b,"decodeObjectForKey:","NSSegmentItemImage");
label=objj_msgSend(_1b,"decodeObjectForKey:","NSSegmentItemLabel");
menu=objj_msgSend(_1b,"decodeObjectForKey:","NSSegmentItemMenu");
selected=objj_msgSend(_1b,"decodeBoolForKey:","NSSegmentItemSelected");
enabled=!objj_msgSend(_1b,"decodeBoolForKey:","NSSegmentItemDisabled");
tag=objj_msgSend(_1b,"decodeIntForKey:","NSSegmentItemTag");
width=objj_msgSend(_1b,"decodeIntForKey:","NSSegmentItemWidth");
frame=CGRectMakeZero();
}
return _19;
}
})]);
var _1=objj_allocateClassPair(_CPSegmentItem,"NSSegmentItem"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_1c,_1d,_1e){
with(_1c){
return objj_msgSend(_1c,"NS_initWithCoder:",_1e);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_1f,_20){
with(_1f){
return objj_msgSend(_CPSegmentItem,"class");
}
})]);
p;7;NSSet.jt;558;@STATIC;1.0;I;21;Foundation/CPObject.jI;18;Foundation/CPSet.jt;491;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("Foundation/CPSet.j",NO);
var _1=objj_allocateClassPair(CPObject,"NSSet"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_3,_4,_5){
with(_3){
return objj_msgSend(objj_msgSend(CPSet,"alloc"),"initWithArray:",objj_msgSend(_5,"decodeObjectForKey:","NS.objects"));
}
})]);
var _1=objj_allocateClassPair(NSSet,"NSMutableSet"),_2=_1.isa;
objj_registerClassPair(_1);
p;10;NSSlider.jt;2685;@STATIC;1.0;I;17;AppKit/CPSlider.ji;10;NSSlider.jt;2629;
objj_executeFile("AppKit/CPSlider.j",NO);
objj_executeFile("NSSlider.j",YES);
var _1=objj_getClass("CPSlider");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPSlider\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
var _6=objj_msgSend(_5,"decodeObjectForKey:","NSCell");
_minValue=objj_msgSend(_6,"minValue");
_maxValue=objj_msgSend(_6,"maxValue");
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPSlider").super_class},"NS_initWithCoder:",_5);
if(_3){
_altIncrementValue=objj_msgSend(_6,"altIncrementValue");
objj_msgSend(_3,"setSliderType:",objj_msgSend(_6,"sliderType"));
if(objj_msgSend(_3,"sliderType")===CPCircularSlider){
var _7=objj_msgSend(_3,"frame");
objj_msgSend(_3,"setFrameSize:",CGSizeMake(_7.size.width+4,_7.size.height+2));
}
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPSlider,"NSSlider"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_8,_9,_a){
with(_8){
return objj_msgSend(_8,"NS_initWithCoder:",_a);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_b,_c){
with(_b){
return objj_msgSend(CPSlider,"class");
}
})]);
var _1=objj_allocateClassPair(NSCell,"NSSliderCell"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_minValue"),new objj_ivar("_maxValue"),new objj_ivar("_altIncrementValue"),new objj_ivar("_vertical"),new objj_ivar("_sliderType")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("minValue"),function(_d,_e){
with(_d){
return _minValue;
}
}),new objj_method(sel_getUid("maxValue"),function(_f,_10){
with(_f){
return _maxValue;
}
}),new objj_method(sel_getUid("altIncrementValue"),function(_11,_12){
with(_11){
return _altIncrementValue;
}
}),new objj_method(sel_getUid("isVertical"),function(_13,_14){
with(_13){
return _vertical;
}
}),new objj_method(sel_getUid("sliderType"),function(_15,_16){
with(_15){
return _sliderType;
}
}),new objj_method(sel_getUid("initWithCoder:"),function(_17,_18,_19){
with(_17){
_17=objj_msgSendSuper({receiver:_17,super_class:objj_getClass("NSSliderCell").super_class},"initWithCoder:",_19);
if(_17){
_objectValue=objj_msgSend(_19,"decodeDoubleForKey:","NSValue");
_minValue=objj_msgSend(_19,"decodeDoubleForKey:","NSMinValue");
_maxValue=objj_msgSend(_19,"decodeDoubleForKey:","NSMaxValue");
_altIncrementValue=objj_msgSend(_19,"decodeDoubleForKey:","NSAltIncValue");
_isVertical=objj_msgSend(_19,"decodeBoolForKey:","NSVertical");
_sliderType=objj_msgSend(_19,"decodeIntForKey:","NSSliderType")||0;
}
return _17;
}
})]);
p;18;NSSortDescriptor.jt;1079;@STATIC;1.0;I;29;Foundation/CPSortDescriptor.jt;1026;
objj_executeFile("Foundation/CPSortDescriptor.j",NO);
var _1=objj_getClass("CPSortDescriptor");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPSortDescriptor\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPSortDescriptor").super_class},"init")){
_key=objj_msgSend(_5,"decodeObjectForKey:","NSKey");
_selector=CPSelectorFromString(objj_msgSend(_5,"decodeObjectForKey:","NSSelector"));
_ascending=objj_msgSend(_5,"decodeBoolForKey:","NSAscending");
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPSortDescriptor,"NSSortDescriptor"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_6,_7,_8){
with(_6){
return objj_msgSend(_6,"NS_initWithCoder:",_8);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_9,_a){
with(_9){
return objj_msgSend(CPSortDescriptor,"class");
}
})]);
p;13;NSSplitView.jt;990;@STATIC;1.0;I;20;AppKit/CPSplitView.jt;947;
objj_executeFile("AppKit/CPSplitView.j",NO);
var _1=objj_getClass("CPSplitView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPSplitView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPSplitView").super_class},"NS_initWithCoder:",_5)){
_isVertical=objj_msgSend(_5,"decodeBoolForKey:","NSIsVertical");
_isPaneSplitter=objj_msgSend(_5,"decodeIntForKey:","NSDividerStyle")==2?YES:NO;
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPSplitView,"NSSplitView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_6,_7,_8){
with(_6){
return objj_msgSend(_6,"NS_initWithCoder:",_8);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_9,_a){
with(_9){
return objj_msgSend(CPSplitView,"class");
}
})]);
p;15;NSTableColumn.jt;2944;@STATIC;1.0;I;22;AppKit/CPTableColumn.jI;26;AppKit/CPTableHeaderView.jt;2867;
objj_executeFile("AppKit/CPTableColumn.j",NO);
objj_executeFile("AppKit/CPTableHeaderView.j",NO);
var _1=objj_getClass("CPTableColumn");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPTableColumn\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSend(_3,"init");
if(_3){
_identifier=objj_msgSend(_5,"decodeObjectForKey:","NSIdentifier");
var _6=objj_msgSend(_5,"decodeObjectForKey:","NSDataCell");
_dataView=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CPRectMakeZero());
var _7=objj_msgSend(_6,"font"),_8=nil;
if(!_7){
_7=objj_msgSend(CPFont,"systemFontOfSize:",12);
}
var _8=objj_msgSend(CPFont,"boldFontWithName:size:",objj_msgSend(_7,"familyName"),objj_msgSend(_7,"size"));
objj_msgSend(_dataView,"setFont:",_7);
objj_msgSend(_dataView,"setValue:forThemeAttribute:inState:",_8,"font",CPThemeStateSelectedDataView);
objj_msgSend(_dataView,"setLineBreakMode:",CPLineBreakByTruncatingTail);
objj_msgSend(_dataView,"setValue:forThemeAttribute:",objj_msgSend(_6,"alignment"),"alignment");
objj_msgSend(_dataView,"setValue:forThemeAttribute:",CPCenterVerticalTextAlignment,"vertical-alignment");
objj_msgSend(_dataView,"setValue:forThemeAttribute:",CGInsetMake(0,5,0,5),"content-inset");
var _9=objj_msgSend(_6,"textColor"),_a=objj_msgSend(_dataView,"currentValueForThemeAttribute:","text-color");
if(!objj_msgSend(_9,"isEqual:",_a)){
objj_msgSend(_dataView,"setTextColor:",objj_msgSend(_6,"textColor"));
}
var _b=objj_msgSend(_5,"decodeObjectForKey:","NSHeaderCell"),_c=objj_msgSend(objj_msgSend(_CPTableColumnHeaderView,"alloc"),"initWithFrame:",CPRectMakeZero());
objj_msgSend(_c,"setStringValue:",objj_msgSend(_b,"objectValue"));
objj_msgSend(_c,"setValue:forThemeAttribute:",objj_msgSend(_6,"alignment"),"text-alignment");
objj_msgSend(_3,"setHeaderView:",_c);
_width=objj_msgSend(_5,"decodeFloatForKey:","NSWidth");
_minWidth=objj_msgSend(_5,"decodeFloatForKey:","NSMinWidth");
_maxWidth=objj_msgSend(_5,"decodeFloatForKey:","NSMaxWidth");
_resizingMask=objj_msgSend(_5,"decodeIntForKey:","NSResizingMask");
_isHidden=objj_msgSend(_5,"decodeBoolForKey:","NSHidden");
_isEditable=objj_msgSend(_5,"decodeBoolForKey:","NSIsEditable");
_sortDescriptorPrototype=objj_msgSend(_5,"decodeObjectForKey:","NSSortDescriptorPrototype");
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPTableColumn,"NSTableColumn"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_d,_e,_f){
with(_d){
return objj_msgSend(_d,"NS_initWithCoder:",_f);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_10,_11){
with(_10){
return objj_msgSend(CPTableColumn,"class");
}
})]);
var _1=objj_allocateClassPair(NSActionCell,"NSTableHeaderCell"),_2=_1.isa;
objj_registerClassPair(_1);
p;19;NSTableHeaderView.jt;1061;@STATIC;1.0;I;26;AppKit/CPTableHeaderView.jt;1011;
objj_executeFile("AppKit/CPTableHeaderView.j",NO);
var _1=objj_getClass("CPTableHeaderView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPTableHeaderView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPTableHeaderView").super_class},"NS_initWithCoder:",_5)){
_tableView=objj_msgSend(_5,"decodeObjectForKey:","NSTableView");
if(_bounds.size.height===17){
_bounds.size.height=23;
_frame.size.height=23;
}
_drawsColumnLines=YES;
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPTableHeaderView,"NSTableHeaderView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_6,_7,_8){
with(_6){
return objj_msgSend(_6,"NS_initWithCoder:",_8);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_9,_a){
with(_9){
return objj_msgSend(CPTableHeaderView,"class");
}
})]);
p;13;NSTableView.jt;2500;@STATIC;1.0;I;20;AppKit/CPTableView.jt;2456;
objj_executeFile("AppKit/CPTableView.j",NO);
var _1=objj_getClass("CPTableView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPTableView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPTableView").super_class},"NS_initWithCoder:",_5);
if(_3){
var _6=objj_msgSend(_5,"decodeIntForKey:","NSTvFlags");
_rowHeight=objj_msgSend(_5,"decodeFloatForKey:","NSRowHeight");
if(_rowHeight==17){
_rowHeight=23;
}
_headerView=objj_msgSend(_5,"decodeObjectForKey:","NSHeaderView");
_cornerView=objj_msgSend(_5,"decodeObjectForKey:","NSCornerView");
_autosaveName=objj_msgSend(_5,"decodeObjectForKey:","NSAutosaveName");
_tableColumns=objj_msgSend(_5,"decodeObjectForKey:","NSTableColumns");
objj_msgSend(_tableColumns,"makeObjectsPerformSelector:withObject:",sel_getUid("setTableView:"),_3);
_intercellSpacing=CGSizeMake(objj_msgSend(_5,"decodeFloatForKey:","NSIntercellSpacingWidth"),objj_msgSend(_5,"decodeFloatForKey:","NSIntercellSpacingHeight"));
var _7=objj_msgSend(_5,"decodeObjectForKey:","NSGridColor");
if(!objj_msgSend(_7,"isEqual:",objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",127/255,127/255,127/255,1))){
objj_msgSend(_3,"setValue:forThemeAttribute:",_7,"grid-color");
}
_gridStyleMask=objj_msgSend(_5,"decodeIntForKey:","NSGridStyleMask");
_usesAlternatingRowBackgroundColors=(_6&8388608)?YES:NO;
_alternatingRowBackgroundColors=[objj_msgSend(CPColor,"whiteColor"),objj_msgSend(CPColor,"colorWithHexString:","e4e7ff")];
_selectionHighlightStyle=objj_msgSend(_5,"decodeIntForKey:","NSTableViewSelectionHighlightStyle")||CPTableViewSelectionHighlightStyleRegular;
_columnAutoResizingStyle=objj_msgSend(_5,"decodeIntForKey:","NSColumnAutoresizingStyle");
_allowsMultipleSelection=(_6&134217728)?YES:NO;
_allowsEmptySelection=(_6&268435456)?YES:NO;
_allowsColumnSelection=(_6&67108864)?YES:NO;
_allowsColumnResizing=(_6&1073741824)?YES:NO;
_allowsColumnReordering=(_6&2147483648)?YES:NO;
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPTableView,"NSTableView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_8,_9,_a){
with(_8){
return objj_msgSend(_8,"NS_initWithCoder:",_a);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_b,_c){
with(_b){
return objj_msgSend(CPTableView,"class");
}
})]);
p;11;NSTabView.jt;1143;@STATIC;1.0;I;18;AppKit/CPTabView.ji;15;NSTabViewItem.jt;1081;
objj_executeFile("AppKit/CPTabView.j",NO);
objj_executeFile("NSTabViewItem.j",YES);
var _1=objj_getClass("CPTabView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPTabView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPTabView").super_class},"NS_initWithCoder:",_5)){
var _6=objj_msgSend(_5,"decodeObjectForKey:","NSTvFlags");
_type=_6&7;
_items=objj_msgSend(_5,"decodeObjectForKey:","NSTabViewItems");
_selectedIndex=objj_msgSend(_items,"indexOfObject:",objj_msgSend(_5,"decodeObjectForKey:","NSSelectedTabViewItem"));
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPTabView,"NSTabView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_7,_8,_9){
with(_7){
return objj_msgSend(_7,"NS_initWithCoder:",_9);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_a,_b){
with(_a){
return objj_msgSend(CPTabView,"class");
}
})]);
p;15;NSTabViewItem.jt;1024;@STATIC;1.0;I;22;AppKit/CPTabViewItem.jt;979;
objj_executeFile("AppKit/CPTabViewItem.j",NO);
var _1=objj_getClass("CPTabViewItem");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPTabViewItem\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPTabViewItem").super_class},"init")){
_identifier=objj_msgSend(_5,"decodeObjectForKey:","NSIdentifier");
_label=objj_msgSend(_5,"decodeObjectForKey:","NSLabel");
_view=objj_msgSend(_5,"decodeObjectForKey:","NSView");
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPTabViewItem,"NSTabViewItem"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_6,_7,_8){
with(_6){
return objj_msgSend(_6,"NS_initWithCoder:",_8);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_9,_a){
with(_9){
return objj_msgSend(CPTabViewItem,"class");
}
})]);
p;13;NSTextField.jt;4152;@STATIC;1.0;I;20;AppKit/CPTextField.ji;11;NSControl.ji;8;NSCell.jI;15;AppKit/CPFont.jt;4060;
objj_executeFile("AppKit/CPTextField.j",NO);
objj_executeFile("NSControl.j",YES);
objj_executeFile("NSCell.j",YES);
objj_executeFile("AppKit/CPFont.j",NO);
var _1=objj_getClass("CPTextField");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPTextField\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPTextField").super_class},"NS_initWithCoder:",_5);
if(_3){
var _6=objj_msgSend(_5,"decodeObjectForKey:","NSCell");
if(objj_msgSend(_6,"isEditable")&&objj_msgSend(objj_msgSend(_6,"font"),"isEqual:",objj_msgSend(CPFont,"boldSystemFontOfSize:",12))){
objj_msgSend(_3,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",12));
}
objj_msgSend(_3,"sendActionOn:",CPKeyUpMask|CPKeyDownMask);
objj_msgSend(_3,"setEditable:",objj_msgSend(_6,"isEditable"));
objj_msgSend(_3,"setSelectable:",objj_msgSend(_6,"isSelectable"));
objj_msgSend(_3,"setBordered:",objj_msgSend(_6,"isBordered"));
objj_msgSend(_3,"setBezeled:",objj_msgSend(_6,"isBezeled"));
objj_msgSend(_3,"setBezelStyle:",objj_msgSend(_6,"bezelStyle"));
objj_msgSend(_3,"setDrawsBackground:",objj_msgSend(_6,"drawsBackground"));
objj_msgSend(_3,"setLineBreakMode:",objj_msgSend(_6,"lineBreakMode"));
objj_msgSend(_3,"setAlignment:",objj_msgSend(_6,"alignment"));
objj_msgSend(_3,"setTextFieldBackgroundColor:",objj_msgSend(_6,"backgroundColor"));
objj_msgSend(_3,"setPlaceholderString:",objj_msgSend(_6,"placeholderString"));
var _7=objj_msgSend(_6,"textColor"),_8=objj_msgSend(_3,"currentValueForThemeAttribute:","text-color");
if(!objj_msgSend(_7,"isEqual:",_8)){
objj_msgSend(_3,"setTextColor:",objj_msgSend(_6,"textColor"));
}
if(objj_msgSend(_3,"isBezeled")){
var _9=objj_msgSend(_3,"frame");
objj_msgSend(_3,"setFrameOrigin:",CGPointMake(_9.origin.x-4,_9.origin.y-4));
objj_msgSend(_3,"setFrameSize:",CGSizeMake(_9.size.width+8,_9.size.height+8));
}
CPLog.debug(objj_msgSend(_3,"stringValue")+" => isBordered="+objj_msgSend(_3,"isBordered")+", isBezeled="+objj_msgSend(_3,"isBezeled")+", bezelStyle="+objj_msgSend(_3,"bezelStyle")+"("+objj_msgSend(_6,"stringValue")+", "+objj_msgSend(_6,"placeholderString")+")");
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPTextField,"NSTextField"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_a,_b,_c){
with(_a){
return objj_msgSend(_a,"NS_initWithCoder:",_c);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_d,_e){
with(_d){
return objj_msgSend(CPTextField,"class");
}
})]);
var _1=objj_allocateClassPair(NSCell,"NSTextFieldCell"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_bezelStyle"),new objj_ivar("_drawsBackground"),new objj_ivar("_backgroundColor"),new objj_ivar("_textColor"),new objj_ivar("_placeholderString")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("bezelStyle"),function(_f,_10){
with(_f){
return _bezelStyle;
}
}),new objj_method(sel_getUid("drawsBackground"),function(_11,_12){
with(_11){
return _drawsBackground;
}
}),new objj_method(sel_getUid("backgroundColor"),function(_13,_14){
with(_13){
return _backgroundColor;
}
}),new objj_method(sel_getUid("textColor"),function(_15,_16){
with(_15){
return _textColor;
}
}),new objj_method(sel_getUid("placeholderString"),function(_17,_18){
with(_17){
return _placeholderString;
}
}),new objj_method(sel_getUid("initWithCoder:"),function(_19,_1a,_1b){
with(_19){
_19=objj_msgSendSuper({receiver:_19,super_class:objj_getClass("NSTextFieldCell").super_class},"initWithCoder:",_1b);
if(_19){
_bezelStyle=objj_msgSend(_1b,"decodeObjectForKey:","NSTextBezelStyle")||CPTextFieldSquareBezel;
_drawsBackground=objj_msgSend(_1b,"decodeBoolForKey:","NSDrawsBackground");
_backgroundColor=objj_msgSend(_1b,"decodeObjectForKey:","NSBackgroundColor");
_textColor=objj_msgSend(_1b,"decodeObjectForKey:","NSTextColor");
_placeholderString=objj_msgSend(_1b,"decodeObjectForKey:","NSPlaceholderString");
}
return _19;
}
})]);
p;11;NSToolbar.jt;1543;@STATIC;1.0;I;18;AppKit/CPToolbar.jt;1501;
objj_executeFile("AppKit/CPToolbar.j",NO);
var _1=objj_getClass("CPToolbar");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPToolbar\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
if(_3){
_identifier=objj_msgSend(_5,"decodeObjectForKey:","NSToolbarIdentifier");
_displayMode=objj_msgSend(_5,"decodeIntForKey:","NSToolbarDisplayMode");
_showsBaselineSeparator=objj_msgSend(_5,"decodeBoolForKey:","NSToolbarShowsBaselineSeparator");
_allowsUserCustomization=objj_msgSend(_5,"decodeBoolForKey:","NSToolbarAllowsUserCustomization");
_isVisible=objj_msgSend(_5,"decodeBoolForKey:","NSToolbarPrefersToBeShown");
_identifiedItems=objj_msgSend(_5,"decodeObjectForKey:","NSToolbarIBIdentifiedItems");
_defaultItems=objj_msgSend(_5,"decodeObjectForKey:","NSToolbarIBDefaultItems");
_allowedItems=objj_msgSend(_5,"decodeObjectForKey:","NSToolbarIBAllowedItems");
_selectableItems=objj_msgSend(_5,"decodeObjectForKey:","NSToolbarIBSelectableItems");
_delegate=objj_msgSend(_5,"decodeObjectForKey:","NSToolbarDelegate");
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPToolbar,"NSToolbar"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_6,_7,_8){
with(_6){
return objj_msgSend(_6,"NS_initWithCoder:",_8);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_9,_a){
with(_9){
return objj_msgSend(CPToolbar,"class");
}
})]);
p;28;NSToolbarFlexibleSpaceItem.jt;414;@STATIC;1.0;I;36;AppKit/_CPToolbarFlexibleSpaceItem.jt;355;
objj_executeFile("AppKit/_CPToolbarFlexibleSpaceItem.j",NO);
var _1=objj_allocateClassPair(_CPToolbarFlexibleSpaceItem,"NSToolbarFlexibleSpaceItem"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("classForKeyedArchiver"),function(_3,_4){
with(_3){
return objj_msgSend(_CPToolbarFlexibleSpaceItem,"class");
}
})]);
p;15;NSToolbarItem.jt;2800;@STATIC;1.0;I;22;AppKit/CPToolbarItem.jt;2754;
objj_executeFile("AppKit/CPToolbarItem.j",NO);
NS_CPToolbarItemIdentifierMap={"NSToolbarSeparatorItem":CPToolbarSeparatorItemIdentifier,"NSToolbarSpaceItem":CPToolbarSpaceItemIdentifier,"NSToolbarFlexibleSpaceItem":CPToolbarFlexibleSpaceItemIdentifier,"NSToolbarShowColorsItem":CPToolbarShowColorsItemIdentifier,"NSToolbarShowFontsItem":CPToolbarShowFontsItemIdentifier,"NSToolbarCustomizeToolbarItem":CPToolbarCustomizeToolbarItemIdentifier,"NSToolbarPrintItem":CPToolbarPrintItemIdentifier};
var _1=objj_getClass("CPToolbarItem");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPToolbarItem\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPToolbarItem").super_class},"init");
if(_3){
var _6=objj_msgSend(_5,"decodeObjectForKey:","NSToolbarItemIdentifier");
_itemIdentifier=NS_CPToolbarItemIdentifierMap[_6]||_6;
_minSize=objj_msgSend(_5,"decodeSizeForKey:","NSToolbarItemMinSize")||CGSizeMakeZero();
_maxSize=objj_msgSend(_5,"decodeSizeForKey:","NSToolbarItemMaxSize")||CGSizeMakeZero();
objj_msgSend(_3,"setLabel:",objj_msgSend(_5,"decodeObjectForKey:","NSToolbarItemLabel"));
objj_msgSend(_3,"setPaletteLabel:",objj_msgSend(_5,"decodeObjectForKey:","NSToolbarItemPaletteLabel"));
objj_msgSend(_3,"setToolTip:",objj_msgSend(_5,"decodeObjectForKey:","NSToolbarItemToolTip"));
objj_msgSend(_3,"setTag:",objj_msgSend(_5,"decodeObjectForKey:","NSToolbarItemTag"));
objj_msgSend(_3,"setTarget:",objj_msgSend(_5,"decodeObjectForKey:","NSToolbarItemTarget"));
objj_msgSend(_3,"setAction:",CPSelectorFromString(objj_msgSend(_5,"decodeObjectForKey:","NSToolbarItemAction")));
objj_msgSend(_3,"setEnabled:",objj_msgSend(_5,"decodeBoolForKey:","NSToolbarItemEnabled"));
objj_msgSend(_3,"setImage:",objj_msgSend(_5,"decodeObjectForKey:","NSToolbarItemImage"));
if(_maxSize.height>0){
_maxSize.height=MIN(_maxSize.height,32);
}
if(_minSize.height>0){
_minSize.height=MIN(_minSize.height,32);
}
objj_msgSend(_3,"setView:",objj_msgSend(_5,"decodeObjectForKey:","NSToolbarItemView"));
objj_msgSend(_3,"setVisibilityPriority:",objj_msgSend(_5,"decodeIntForKey:","NSToolbarItemVisibilityPriority"));
objj_msgSend(_3,"setAutovalidates:",objj_msgSend(_5,"decodeBoolForKey:","NSToolbarItemAutovalidates"));
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPToolbarItem,"NSToolbarItem"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_7,_8,_9){
with(_7){
return objj_msgSend(_7,"NS_initWithCoder:",_9);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_a,_b){
with(_a){
return objj_msgSend(CPToolbarItem,"class");
}
})]);
p;24;NSToolbarSeparatorItem.jt;394;@STATIC;1.0;I;32;AppKit/_CPToolbarSeparatorItem.jt;339;
objj_executeFile("AppKit/_CPToolbarSeparatorItem.j",NO);
var _1=objj_allocateClassPair(_CPToolbarSeparatorItem,"NSToolbarSeparatorItem"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("classForKeyedArchiver"),function(_3,_4){
with(_3){
return objj_msgSend(_CPToolbarSeparatorItem,"class");
}
})]);
p;25;NSToolbarShowColorsItem.jt;399;@STATIC;1.0;I;33;AppKit/_CPToolbarShowColorsItem.jt;343;
objj_executeFile("AppKit/_CPToolbarShowColorsItem.j",NO);
var _1=objj_allocateClassPair(_CPToolbarShowColorsItem,"NSToolbarShowColorsItem"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("classForKeyedArchiver"),function(_3,_4){
with(_3){
return objj_msgSend(_CPToolbarShowColorsItem,"class");
}
})]);
p;20;NSToolbarSpaceItem.jt;374;@STATIC;1.0;I;28;AppKit/_CPToolbarSpaceItem.jt;323;
objj_executeFile("AppKit/_CPToolbarSpaceItem.j",NO);
var _1=objj_allocateClassPair(_CPToolbarSpaceItem,"NSToolbarSpaceItem"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("classForKeyedArchiver"),function(_3,_4){
with(_3){
return objj_msgSend(_CPToolbarSpaceItem,"class");
}
})]);
p;8;NSView.jt;1844;@STATIC;1.0;I;15;AppKit/CPView.jt;1805;
objj_executeFile("AppKit/CPView.j",NO);
var _1=63,_2=1<<8,_3=1<<31;
var _4=objj_getClass("CPView");
if(!_4){
throw new SyntaxError("*** Could not find definition for class \"CPView\"");
}
var _5=_4.isa;
class_addMethods(_4,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_6,_7,_8){
with(_6){
_frame=CGRectMakeZero();
if(objj_msgSend(_8,"containsValueForKey:","NSFrame")){
_frame=objj_msgSend(_8,"decodeRectForKey:","NSFrame");
}else{
if(objj_msgSend(_8,"containsValueForKey:","NSFrameSize")){
_frame.size=objj_msgSend(_8,"decodeSizeForKey:","NSFrameSize");
}
}
_6=objj_msgSendSuper({receiver:_6,super_class:objj_getClass("CPView").super_class},"NS_initWithCoder:",_8);
if(_6){
_tag=0;
if(objj_msgSend(_8,"containsValueForKey:","NSTag")){
_tag=objj_msgSend(_8,"decodeIntForKey:","NSTag");
}
_bounds=CGRectMake(0,0,CGRectGetWidth(_frame),CGRectGetHeight(_frame));
_window=objj_msgSend(_8,"decodeObjectForKey:","NSWindow");
_superview=objj_msgSend(_8,"decodeObjectForKey:","NSSuperview");
_subviews=objj_msgSend(_8,"decodeObjectForKey:","NSSubviews");
if(!_subviews){
_subviews=[];
}
var _9=objj_msgSend(_8,"decodeIntForKey:","NSvFlags");
_autoresizingMask=_9&_1;
_autoresizesSubviews=_9&_2;
_hitTests=YES;
_isHidden=_9&_3;
_opacity=1;
_themeAttributes={};
_themeState=CPThemeStateNormal;
objj_msgSend(_6,"_loadThemeAttributes");
}
return _6;
}
}),new objj_method(sel_getUid("NS_isFlipped"),function(_a,_b){
with(_a){
return NO;
}
})]);
var _4=objj_allocateClassPair(CPView,"NSView"),_5=_4.isa;
objj_registerClassPair(_4);
class_addMethods(_4,[new objj_method(sel_getUid("initWithCoder:"),function(_c,_d,_e){
with(_c){
return objj_msgSend(_c,"NS_initWithCoder:",_e);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_f,_10){
with(_f){
return objj_msgSend(CPView,"class");
}
})]);
p;18;NSViewController.jt;1145;@STATIC;1.0;I;25;AppKit/CPViewController.jt;1096;
objj_executeFile("AppKit/CPViewController.j",NO);
var _1=objj_getClass("CPViewController");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPViewController\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPViewController").super_class},"NS_initWithCoder:",_5);
if(_3){
_title=objj_msgSend(_5,"decodeObjectForKey:","NSTitle");
_cibName=objj_msgSend(_5,"decodeObjectForKey:","NSNibName");
var _6=objj_msgSend(_5,"decodeObjectForKey:","NSNibBundleIdentifier");
if(_6){
_cibBundle=objj_msgSend(CPBundle,"bundleWithPath:",_6);
}
}
return _3;
}
})]);
var _1=objj_allocateClassPair(CPViewController,"NSViewController"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_7,_8,_9){
with(_7){
return objj_msgSend(_7,"NS_initWithCoder:",_9);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_a,_b){
with(_a){
return objj_msgSend(CPViewController,"class");
}
})]);
p;18;NSWindowTemplate.jt;2430;@STATIC;1.0;I;29;AppKit/_CPCibWindowTemplate.jt;2377;
objj_executeFile("AppKit/_CPCibWindowTemplate.j",NO);
var _1=0,_2=1,_3=2,_4=4,_5=8,_6=16,_7=64,_8=256,_9=8192;
var _a=objj_getClass("_CPCibWindowTemplate");
if(!_a){
throw new SyntaxError("*** Could not find definition for class \"_CPCibWindowTemplate\"");
}
var _b=_a.isa;
class_addMethods(_a,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_c,_d,_e){
with(_c){
_c=objj_msgSendSuper({receiver:_c,super_class:objj_getClass("_CPCibWindowTemplate").super_class},"init");
if(_c){
if(objj_msgSend(_e,"containsValueForKey:","NSMinSize")){
_minSize=objj_msgSend(_e,"decodeSizeForKey:","NSMinSize");
}
if(objj_msgSend(_e,"containsValueForKey:","NSMaxSize")){
_maxSize=objj_msgSend(_e,"decodeSizeForKey:","NSMaxSize");
}
_screenRect=objj_msgSend(_e,"decodeRectForKey:","NSScreenRect");
_viewClass=objj_msgSend(_e,"decodeObjectForKey:","NSViewClass");
_wtFlags=objj_msgSend(_e,"decodeIntForKey:","NSWTFlags");
_windowBacking=objj_msgSend(_e,"decodeIntForKey:","NSWindowBacking");
_windowClass=CP_NSMapClassName(objj_msgSend(_e,"decodeObjectForKey:","NSWindowClass"));
_windowRect=objj_msgSend(_e,"decodeRectForKey:","NSWindowRect");
_windowStyleMask=objj_msgSend(_e,"decodeIntForKey:","NSWindowStyleMask");
_windowTitle=objj_msgSend(_e,"decodeObjectForKey:","NSWindowTitle");
_windowView=objj_msgSend(_e,"decodeObjectForKey:","NSWindowView");
_windowRect.origin.y=_screenRect.size.height-_windowRect.origin.y-_windowRect.size.height;
if(_windowStyleMask===_1){
_windowStyleMask=CPBorderlessWindowMask;
}else{
_windowStyleMask=(_windowStyleMask&_2?CPTitledWindowMask:0)|(_windowStyleMask&_3?CPClosableWindowMask:0)|(_windowStyleMask&_4?CPMiniaturizableWindowMask:0)|(_windowStyleMask&_5?CPResizableWindowMask:0)|(_windowStyleMask&_8?_8:0)|(_windowStyleMask&_7?CPDocModalWindowMask:0)|(_windowStyleMask&_9?CPHUDBackgroundWindowMask:0);
}
_windowIsFullBridge=objj_msgSend(_e,"decodeObjectForKey:","NSFrameAutosaveName")==="CPBorderlessBridgeWindowMask";
}
return _c;
}
})]);
var _a=objj_allocateClassPair(_CPCibWindowTemplate,"NSWindowTemplate"),_b=_a.isa;
objj_registerClassPair(_a);
class_addMethods(_a,[new objj_method(sel_getUid("initWithCoder:"),function(_f,_10,_11){
with(_f){
return objj_msgSend(_f,"NS_initWithCoder:",_11);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_12,_13){
with(_12){
return objj_msgSend(_CPCibWindowTemplate,"class");
}
})]);
p;9;WebView.jt;814;@STATIC;1.0;I;18;AppKit/CPWebView.jt;773;
objj_executeFile("AppKit/CPWebView.j",NO);
var _1=objj_getClass("CPWebView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPWebView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("NS_initWithCoder:"),function(_3,_4,_5){
with(_3){
return objj_msgSendSuper({receiver:_3,super_class:objj_getClass("CPWebView").super_class},"NS_initWithCoder:",_5);
}
})]);
var _1=objj_allocateClassPair(CPWebView,"WebView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_6,_7,_8){
with(_6){
return objj_msgSend(_6,"NS_initWithCoder:",_8);
}
}),new objj_method(sel_getUid("classForKeyedArchiver"),function(_9,_a){
with(_9){
return objj_msgSend(CPWebView,"class");
}
})]);
e;