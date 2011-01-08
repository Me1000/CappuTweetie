@STATIC;1.0;p;22;BKShowcaseController.jt;15395;@STATIC;1.0;I;16;AppKit/CPTheme.jI;15;AppKit/CPView.jt;15334;
objj_executeFile("AppKit/CPTheme.j",NO);
objj_executeFile("AppKit/CPView.j",NO);
var _1=176;
var _2="BKLearnMoreToolbarItemIdentifier",_3="BKStateToolbarItemIdentifier",_4="BKBackgroundColorToolbarItemIdentifier";
var _5=objj_allocateClassPair(CPObject,"BKShowcaseController"),_6=_5.isa;
class_addIvars(_5,[new objj_ivar("_themeDescriptorClasses"),new objj_ivar("_themesCollectionView"),new objj_ivar("_themedObjectsCollectionView"),new objj_ivar("theWindow")]);
objj_registerClassPair(_5);
class_addMethods(_5,[new objj_method(sel_getUid("applicationDidFinishLaunching:"),function(_7,_8,_9){
with(_7){
_themeDescriptorClasses=objj_msgSend(BKThemeDescriptor,"allThemeDescriptorClasses");
theWindow=objj_msgSend(objj_msgSend(CPWindow,"alloc"),"initWithContentRect:styleMask:",CGRectMakeZero(),CPBorderlessBridgeWindowMask);
var _a=objj_msgSend(objj_msgSend(CPToolbar,"alloc"),"initWithIdentifier:","Toolbar");
objj_msgSend(_a,"setDelegate:",_7);
objj_msgSend(theWindow,"setToolbar:",_a);
var _b=objj_msgSend(theWindow,"contentView"),_c=objj_msgSend(_b,"bounds"),_d=objj_msgSend(objj_msgSend(CPSplitView,"alloc"),"initWithFrame:",_c);
objj_msgSend(_d,"setIsPaneSplitter:",YES);
objj_msgSend(_d,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(_b,"addSubview:",_d);
var _e=objj_msgSend(CPTextField,"labelWithTitle:","THEMES");
objj_msgSend(_e,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",11));
objj_msgSend(_e,"setTextColor:",objj_msgSend(CPColor,"colorWithCalibratedRed:green:blue:alpha:",93/255,93/255,93/255,1));
objj_msgSend(_e,"setTextShadowColor:",objj_msgSend(CPColor,"colorWithCalibratedRed:green:blue:alpha:",225/255,255/255,255/255,0.7));
objj_msgSend(_e,"setTextShadowOffset:",CGSizeMake(0,1));
objj_msgSend(_e,"sizeToFit");
objj_msgSend(_e,"setFrameOrigin:",CGPointMake(5,4));
var _f=objj_msgSend(objj_msgSend(CPCollectionViewItem,"alloc"),"init");
objj_msgSend(_f,"setView:",objj_msgSend(objj_msgSend(BKThemeDescriptorCell,"alloc"),"init"));
_themesCollectionView=objj_msgSend(objj_msgSend(CPCollectionView,"alloc"),"initWithFrame:",CGRectMake(0,0,_1,CGRectGetHeight(_c)));
objj_msgSend(_themesCollectionView,"setDelegate:",_7);
objj_msgSend(_themesCollectionView,"setItemPrototype:",_f);
objj_msgSend(_themesCollectionView,"setMinItemSize:",CGSizeMake(20,36));
objj_msgSend(_themesCollectionView,"setMaxItemSize:",CGSizeMake(10000000,36));
objj_msgSend(_themesCollectionView,"setMaxNumberOfColumns:",1);
objj_msgSend(_themesCollectionView,"setContent:",_themeDescriptorClasses);
objj_msgSend(_themesCollectionView,"setAutoresizingMask:",CPViewWidthSizable);
objj_msgSend(_themesCollectionView,"setVerticalMargin:",0);
objj_msgSend(_themesCollectionView,"setSelectable:",YES);
objj_msgSend(_themesCollectionView,"setFrameOrigin:",CGPointMake(0,20));
objj_msgSend(_themesCollectionView,"setAutoresizingMask:",CPViewWidthSizable);
var _10=objj_msgSend(objj_msgSend(CPScrollView,"alloc"),"initWithFrame:",CGRectMake(0,0,_1,CGRectGetHeight(_c))),_b=objj_msgSend(_10,"contentView");
objj_msgSend(_10,"setAutohidesScrollers:",YES);
objj_msgSend(_10,"setDocumentView:",_themesCollectionView);
objj_msgSend(_b,"setBackgroundColor:",objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",212/255,221/255,230/255,1));
objj_msgSend(_b,"addSubview:",_e);
objj_msgSend(_d,"addSubview:",_10);
_themedObjectsCollectionView=objj_msgSend(objj_msgSend(CPCollectionView,"alloc"),"initWithFrame:",CGRectMake(0,0,CGRectGetWidth(_c)-_1-1,10));
var _11=objj_msgSend(objj_msgSend(CPCollectionViewItem,"alloc"),"init");
objj_msgSend(_11,"setView:",objj_msgSend(objj_msgSend(BKShowcaseCell,"alloc"),"init"));
objj_msgSend(_themedObjectsCollectionView,"setItemPrototype:",_11);
objj_msgSend(_themedObjectsCollectionView,"setVerticalMargin:",20);
objj_msgSend(_themedObjectsCollectionView,"setAutoresizingMask:",CPViewWidthSizable);
var _10=objj_msgSend(objj_msgSend(CPScrollView,"alloc"),"initWithFrame:",CGRectMake(_1+1,0,CGRectGetWidth(_c)-_1-1,CGRectGetHeight(_c)));
objj_msgSend(_10,"setHasHorizontalScroller:",NO);
objj_msgSend(_10,"setAutohidesScrollers:",YES);
objj_msgSend(_10,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(_10,"setDocumentView:",_themedObjectsCollectionView);
objj_msgSend(_d,"addSubview:",_10);
objj_msgSend(_themesCollectionView,"setSelectionIndexes:",objj_msgSend(CPIndexSet,"indexSetWithIndex:",0));
objj_msgSend(theWindow,"setFullPlatformWindow:",YES);
objj_msgSend(theWindow,"makeKeyAndOrderFront:",_7);
}
}),new objj_method(sel_getUid("collectionViewDidChangeSelection:"),function(_12,_13,_14){
with(_12){
var _15=_themeDescriptorClasses[objj_msgSend(objj_msgSend(_14,"selectionIndexes"),"firstIndex")],_16=objj_msgSend(_15,"itemSize");
_16.width=MAX(100,_16.width+20);
_16.height=MAX(100,_16.height+30);
objj_msgSend(_themedObjectsCollectionView,"setMinItemSize:",_16);
objj_msgSend(_themedObjectsCollectionView,"setMaxItemSize:",_16);
objj_msgSend(_themedObjectsCollectionView,"setContent:",objj_msgSend(_15,"themedShowcaseObjectTemplates"));
objj_msgSend(BKShowcaseCell,"setBackgroundColor:",objj_msgSend(_15,"showcaseBackgroundColor"));
}
}),new objj_method(sel_getUid("hasLearnMoreURL"),function(_17,_18){
with(_17){
return objj_msgSend(objj_msgSend(CPBundle,"mainBundle"),"objectForInfoDictionaryKey:","BKLearnMoreURL");
}
}),new objj_method(sel_getUid("toolbarAllowedItemIdentifiers:"),function(_19,_1a,_1b){
with(_19){
return [_2,CPToolbarSpaceItemIdentifier,CPToolbarFlexibleSpaceItemIdentifier,_4,_3];
}
}),new objj_method(sel_getUid("toolbarDefaultItemIdentifiers:"),function(_1c,_1d,_1e){
with(_1c){
var _1f=[CPToolbarFlexibleSpaceItemIdentifier,_4,_3];
if(objj_msgSend(_1c,"hasLearnMoreURL")){
_1f=[_2].concat(_1f);
}
return _1f;
}
}),new objj_method(sel_getUid("toolbar:itemForItemIdentifier:willBeInsertedIntoToolbar:"),function(_20,_21,_22,_23,_24){
with(_20){
var _25=objj_msgSend(objj_msgSend(CPToolbarItem,"alloc"),"initWithItemIdentifier:",_23);
objj_msgSend(_25,"setTarget:",_20);
if(_23===_3){
var _26=objj_msgSend(CPPopUpButton,"buttonWithTitle:","Enabled");
objj_msgSend(_26,"addItemWithTitle:","Disabled");
objj_msgSend(_25,"setView:",_26);
objj_msgSend(_25,"setTarget:",nil);
objj_msgSend(_25,"setAction:",sel_getUid("changeState:"));
objj_msgSend(_25,"setLabel:","State");
var _27=CGRectGetWidth(objj_msgSend(_26,"frame"));
objj_msgSend(_25,"setMinSize:",CGSizeMake(_27+20,24));
objj_msgSend(_25,"setMaxSize:",CGSizeMake(_27+20,24));
}else{
if(_23===_4){
var _26=objj_msgSend(CPPopUpButton,"buttonWithTitle:","Window Background");
objj_msgSend(_26,"addItemWithTitle:","Light Checkers");
objj_msgSend(_26,"addItemWithTitle:","Dark Checkers");
objj_msgSend(_26,"addItemWithTitle:","White");
objj_msgSend(_26,"addItemWithTitle:","Black");
objj_msgSend(_26,"addItemWithTitle:","More Choices...");
var _28=objj_msgSend(_26,"itemArray");
objj_msgSend(_28[0],"setRepresentedObject:",objj_msgSend(BKThemeDescriptor,"windowBackgroundColor"));
objj_msgSend(_28[1],"setRepresentedObject:",objj_msgSend(BKThemeDescriptor,"lightCheckersColor"));
objj_msgSend(_28[2],"setRepresentedObject:",objj_msgSend(BKThemeDescriptor,"darkCheckersColor"));
objj_msgSend(_28[3],"setRepresentedObject:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_28[4],"setRepresentedObject:",objj_msgSend(CPColor,"blackColor"));
objj_msgSend(_25,"setView:",_26);
objj_msgSend(_25,"setTarget:",nil);
objj_msgSend(_25,"setAction:",sel_getUid("changeColor:"));
objj_msgSend(_25,"setLabel:","Background Color");
var _27=CGRectGetWidth(objj_msgSend(_26,"frame"));
objj_msgSend(_25,"setMinSize:",CGSizeMake(_27,24));
objj_msgSend(_25,"setMaxSize:",CGSizeMake(_27,24));
}else{
if(_23===_2){
var _29=objj_msgSend(objj_msgSend(CPBundle,"mainBundle"),"objectForInfoDictionaryKey:","BKLearnMoreButtonTitle");
if(!_29){
_29=objj_msgSend(objj_msgSend(CPBundle,"mainBundle"),"objectForInfoDictionaryKey:","CPBundleName")||"Home Page";
}
var _2a=objj_msgSend(CPButton,"buttonWithTitle:",_29);
objj_msgSend(theWindow,"setDefaultButton:",_2a);
objj_msgSend(_25,"setView:",_2a);
objj_msgSend(_25,"setLabel:","Learn More");
objj_msgSend(_25,"setTarget:",nil);
objj_msgSend(_25,"setAction:",sel_getUid("learnMore:"));
var _27=CGRectGetWidth(objj_msgSend(_2a,"frame"));
objj_msgSend(_25,"setMinSize:",CGSizeMake(_27,24));
objj_msgSend(_25,"setMaxSize:",CGSizeMake(_27,24));
}
}
}
return _25;
}
}),new objj_method(sel_getUid("learnMore:"),function(_2b,_2c,_2d){
with(_2b){
window.location.href=objj_msgSend(objj_msgSend(CPBundle,"mainBundle"),"objectForInfoDictionaryKey:","BKLearnMoreURL");
}
}),new objj_method(sel_getUid("selectedThemeDescriptor"),function(_2e,_2f){
with(_2e){
return _themeDescriptorClasses[objj_msgSend(objj_msgSend(_themesCollectionView,"selectionIndexes"),"firstIndex")];
}
}),new objj_method(sel_getUid("changeState:"),function(_30,_31,_32){
with(_30){
var _33=objj_msgSend(objj_msgSend(_30,"selectedThemeDescriptor"),"themedShowcaseObjectTemplates"),_34=objj_msgSend(_33,"count");
while(_34--){
var _35=objj_msgSend(_33[_34],"valueForKey:","themedObject");
if(objj_msgSend(_35,"respondsToSelector:",sel_getUid("setEnabled:"))){
objj_msgSend(_35,"setEnabled:",objj_msgSend(_32,"title")==="Enabled"?YES:NO);
}
}
}
}),new objj_method(sel_getUid("changeColor:"),function(_36,_37,_38){
with(_36){
var _39=nil;
if(objj_msgSend(_38,"isKindOfClass:",objj_msgSend(CPColorPanel,"class"))){
_39=objj_msgSend(_38,"color");
}else{
if(objj_msgSend(_38,"titleOfSelectedItem")==="More Choices..."){
objj_msgSend(_38,"addItemWithTitle:","Other");
objj_msgSend(_38,"selectItemWithTitle:","Other");
objj_msgSend(CPApp,"orderFrontColorPanel:",_36);
}else{
_39=objj_msgSend(objj_msgSend(_38,"selectedItem"),"representedObject");
objj_msgSend(_38,"removeItemWithTitle:","Other");
}
}
if(_39){
objj_msgSend(objj_msgSend(_36,"selectedThemeDescriptor"),"setShowcaseBackgroundColor:",_39);
objj_msgSend(BKShowcaseCell,"setBackgroundColor:",_39);
}
}
})]);
var _3a=nil;
var _5=objj_allocateClassPair(CPView,"BKThemeDescriptorCell"),_6=_5.isa;
class_addIvars(_5,[new objj_ivar("_label")]);
objj_registerClassPair(_5);
class_addMethods(_5,[new objj_method(sel_getUid("setRepresentedObject:"),function(_3b,_3c,_3d){
with(_3b){
if(!_label){
_label=objj_msgSend(CPTextField,"labelWithTitle:","hello");
objj_msgSend(_label,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",11));
objj_msgSend(_label,"setFrame:",CGRectMake(10,0,CGRectGetWidth(objj_msgSend(_3b,"bounds"))-20,CGRectGetHeight(objj_msgSend(_3b,"bounds"))));
objj_msgSend(_label,"setVerticalAlignment:",CPCenterVerticalTextAlignment);
objj_msgSend(_label,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(_3b,"addSubview:",_label);
}
objj_msgSend(_label,"setStringValue:",objj_msgSend(_3d,"themeName")+" ("+objj_msgSend(objj_msgSend(_3d,"themedShowcaseObjectTemplates"),"count")+")");
}
}),new objj_method(sel_getUid("setSelected:"),function(_3e,_3f,_40){
with(_3e){
objj_msgSend(_3e,"setBackgroundColor:",_40?objj_msgSend(objj_msgSend(_3e,"class"),"selectionColor"):nil);
objj_msgSend(_label,"setTextShadowOffset:",_40?CGSizeMake(0,1):CGSizeMakeZero());
objj_msgSend(_label,"setTextShadowColor:",_40?objj_msgSend(CPColor,"blackColor"):nil);
objj_msgSend(_label,"setFont:",_40?objj_msgSend(CPFont,"boldSystemFontOfSize:",11):objj_msgSend(CPFont,"systemFontOfSize:",11));
objj_msgSend(_label,"setTextColor:",_40?objj_msgSend(CPColor,"whiteColor"):objj_msgSend(CPColor,"blackColor"));
}
})]);
class_addMethods(_6,[new objj_method(sel_getUid("selectionColor"),function(_41,_42){
with(_41){
if(!_3a){
_3a=objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",objj_msgSend(BKThemeDescriptorCell,"class")),"pathForResource:","selection.png"),CGSizeMake(1,36)));
}
return _3a;
}
})]);
var _43=nil;
var _44="BKShowcaseCellBackgroundColorDidChangeNotification";
var _5=objj_allocateClassPair(CPView,"BKShowcaseCell"),_6=_5.isa;
class_addIvars(_5,[new objj_ivar("_backgroundView"),new objj_ivar("_view"),new objj_ivar("_label")]);
objj_registerClassPair(_5);
class_addMethods(_5,[new objj_method(sel_getUid("init"),function(_45,_46){
with(_45){
_45=objj_msgSendSuper({receiver:_45,super_class:objj_getClass("BKShowcaseCell").super_class},"init");
if(_45){
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_45,sel_getUid("showcaseBackgroundDidChange:"),_44,nil);
}
return _45;
}
}),new objj_method(sel_getUid("initWithCoder:"),function(_47,_48,_49){
with(_47){
_47=objj_msgSendSuper({receiver:_47,super_class:objj_getClass("BKShowcaseCell").super_class},"initWithCoder:",_49);
if(_47){
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_47,sel_getUid("showcaseBackgroundDidChange:"),_44,nil);
}
return _47;
}
}),new objj_method(sel_getUid("showcaseBackgroundDidChange:"),function(_4a,_4b,_4c){
with(_4a){
objj_msgSend(_backgroundView,"setBackgroundColor:",objj_msgSend(BKShowcaseCell,"backgroundColor"));
}
}),new objj_method(sel_getUid("setSelected:"),function(_4d,_4e,_4f){
with(_4d){
}
}),new objj_method(sel_getUid("setRepresentedObject:"),function(_50,_51,_52){
with(_50){
if(!_label){
_label=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMakeZero());
objj_msgSend(_label,"setAlignment:",CPCenterTextAlignment);
objj_msgSend(_label,"setAutoresizingMask:",CPViewMinYMargin|CPViewWidthSizable);
objj_msgSend(_label,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",11));
objj_msgSend(_50,"addSubview:",_label);
}
objj_msgSend(_label,"setStringValue:",objj_msgSend(_52,"valueForKey:","label"));
objj_msgSend(_label,"sizeToFit");
objj_msgSend(_label,"setFrame:",CGRectMake(0,CGRectGetHeight(objj_msgSend(_50,"bounds"))-CGRectGetHeight(objj_msgSend(_label,"frame")),CGRectGetWidth(objj_msgSend(_50,"bounds")),CGRectGetHeight(objj_msgSend(_label,"frame"))));
if(!_backgroundView){
_backgroundView=objj_msgSend(objj_msgSend(CPView,"alloc"),"init");
objj_msgSend(_50,"addSubview:",_backgroundView);
}
objj_msgSend(_backgroundView,"setFrame:",CGRectMake(0,0,CGRectGetWidth(objj_msgSend(_50,"bounds")),CGRectGetMinY(objj_msgSend(_label,"frame"))));
objj_msgSend(_backgroundView,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
if(_view){
objj_msgSend(_view,"removeFromSuperview");
}
_view=objj_msgSend(_52,"valueForKey:","themedObject");
objj_msgSend(_view,"setTheme:",nil);
objj_msgSend(_view,"setAutoresizingMask:",CPViewMinXMargin|CPViewMaxXMargin|CPViewMinYMargin|CPViewMaxYMargin);
objj_msgSend(_view,"setFrameOrigin:",CGPointMake((CGRectGetWidth(objj_msgSend(_backgroundView,"bounds"))-CGRectGetWidth(objj_msgSend(_view,"frame")))/2,(CGRectGetHeight(objj_msgSend(_backgroundView,"bounds"))-CGRectGetHeight(objj_msgSend(_view,"frame")))/2));
objj_msgSend(_backgroundView,"addSubview:",_view);
objj_msgSend(_backgroundView,"setBackgroundColor:",objj_msgSend(BKShowcaseCell,"backgroundColor"));
}
})]);
class_addMethods(_6,[new objj_method(sel_getUid("setBackgroundColor:"),function(_53,_54,_55){
with(_53){
if(_43===_55){
return;
}
_43=_55;
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:",_44,nil);
}
}),new objj_method(sel_getUid("backgroundColor"),function(_56,_57){
with(_56){
return _43;
}
})]);
p;19;BKThemeDescriptor.jt;7386;@STATIC;1.0;I;21;Foundation/CPObject.jt;7341;
objj_executeFile("Foundation/CPObject.j",NO);
var _1={},_2={},_3={},_4={},_5=nil,_6=nil,_7=nil;
var _8=objj_allocateClassPair(CPObject,"BKThemeDescriptor"),_9=_8.isa;
objj_registerClassPair(_8);
class_addMethods(_9,[new objj_method(sel_getUid("allThemeDescriptorClasses"),function(_a,_b){
with(_a){
var _c=[];
for(candidate in global){
var _d=objj_getClass(candidate),_e=class_getName(_d);
if(_e==="BKThemeDescriptor"){
continue;
}
var _f=_e.indexOf("ThemeDescriptor");
if((_f>=0)&&(_f===_e.length-"ThemeDescriptor".length)){
_c.push(_d);
}
}
objj_msgSend(_c,"sortUsingSelector:",sel_getUid("compare:"));
return _c;
}
}),new objj_method(sel_getUid("lightCheckersColor"),function(_10,_11){
with(_10){
if(!_5){
_5=objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",objj_msgSend(BKThemeDescriptor,"class")),"pathForResource:","light-checkers.png"),CGSizeMake(12,12)));
}
return _5;
}
}),new objj_method(sel_getUid("darkCheckersColor"),function(_12,_13){
with(_12){
if(!_6){
_6=objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",objj_msgSend(BKThemeDescriptor,"class")),"pathForResource:","dark-checkers.png"),CGSizeMake(12,12)));
}
return _6;
}
}),new objj_method(sel_getUid("windowBackgroundColor"),function(_14,_15){
with(_14){
return objj_msgSend(_CPStandardWindowView,"bodyBackgroundColor");
}
}),new objj_method(sel_getUid("defaultShowcaseBackgroundColor"),function(_16,_17){
with(_16){
return objj_msgSend(_CPStandardWindowView,"bodyBackgroundColor");
}
}),new objj_method(sel_getUid("showcaseBackgroundColor"),function(_18,_19){
with(_18){
var _1a=objj_msgSend(_18,"className");
if(!_4[_1a]){
_4[_1a]=objj_msgSend(_18,"defaultShowcaseBackgroundColor");
}
return _4[_1a];
}
}),new objj_method(sel_getUid("setShowcaseBackgroundColor:"),function(_1b,_1c,_1d){
with(_1b){
_4[objj_msgSend(_1b,"className")]=_1d;
}
}),new objj_method(sel_getUid("itemSize"),function(_1e,_1f){
with(_1e){
var _20=objj_msgSend(_1e,"className");
if(!_1[_20]){
objj_msgSend(_1e,"calculateThemedObjectTemplates");
}
return CGSizeMakeCopy(_1[_20]);
}
}),new objj_method(sel_getUid("themedObjectTemplates"),function(_21,_22){
with(_21){
var _23=objj_msgSend(_21,"className");
if(!_2[_23]){
objj_msgSend(_21,"calculateThemedObjectTemplates");
}
return _2[_23];
}
}),new objj_method(sel_getUid("themedShowcaseObjectTemplates"),function(_24,_25){
with(_24){
var _26=objj_msgSend(_24,"className");
if(!_3[_26]){
objj_msgSend(_24,"calculateThemedObjectTemplates");
}
return _3[_26];
}
}),new objj_method(sel_getUid("calculateThemedObjectTemplates"),function(_27,_28){
with(_27){
var _29=[],_2a=[],_2b=CGSizeMake(0,0),_2c=class_copyMethodList(objj_msgSend(_27,"class").isa),_2d=0,_2e=objj_msgSend(_2c,"count"),_2f=[];
if(objj_msgSend(_27,"respondsToSelector:",sel_getUid("themeShowcaseExcludes"))){
_2f=objj_msgSend(_27,"themeShowcaseExcludes");
}
for(;_2d<_2f.length;++_2d){
var _30=_2f[_2d].toLowerCase();
if(_30&&_30.indexOf("themed")!==0){
_2f[_2d]="themed"+_30;
}else{
_2f[_2d]=_30;
}
}
for(_2d=0;_2d<_2e;++_2d){
var _31=_2c[_2d],_32=method_getName(_31);
if(_32.indexOf("themed")!==0){
continue;
}
var _33=method_getImplementation(_31),_34=_33(_27,_32);
if(!_34){
continue;
}
var _35=objj_msgSend(objj_msgSend(BKThemedObjectTemplate,"alloc"),"init"),_36=objj_msgSend(_2f,"containsObject:",_32.toLowerCase());
objj_msgSend(_35,"setValue:forKey:",_34,"themedObject");
objj_msgSend(_35,"setValue:forKey:",BKLabelFromIdentifier(_32),"label");
objj_msgSend(_29,"addObject:",_35);
if(!_36){
if(objj_msgSend(_34,"isKindOfClass:",objj_msgSend(CPView,"class"))){
var _37=objj_msgSend(_34,"frame").size,_38=objj_msgSend(objj_msgSend(_35,"valueForKey:","label"),"sizeWithFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",12)).width+20;
if(_37.width>_2b.width){
_2b.width=_37.width;
}
if(_38>_2b.width){
_2b.width=_38;
}
if(_37.height>_2b.height){
_2b.height=_37.height;
}
}
objj_msgSend(_2a,"addObject:",_35);
}
}
var _39=objj_msgSend(_27,"className");
_1[_39]=_2b;
_2[_39]=_29;
_3[_39]=_2a;
}
}),new objj_method(sel_getUid("compare:"),function(_3a,_3b,_3c){
with(_3a){
return objj_msgSend(objj_msgSend(_3a,"themeName"),"compare:",objj_msgSend(_3c,"themeName"));
}
}),new objj_method(sel_getUid("registerThemeValues:forView:"),function(_3d,_3e,_3f,_40){
with(_3d){
for(var i=0;i<_3f.length;++i){
var _41=_3f[i],_42=_41[0],_43=_41[1],_44=_41[2];
if(_44){
objj_msgSend(_40,"setValue:forThemeAttribute:inState:",_43,_42,_44);
}else{
objj_msgSend(_40,"setValue:forThemeAttribute:",_43,_42);
}
}
}
}),new objj_method(sel_getUid("registerThemeValues:forView:inherit:"),function(_45,_46,_47,_48,_49){
with(_45){
if(_49){
var _4a=objj_msgSend(_45,"themeName"),_4b=_4a.indexOf("-");
if(_4b<0){
objj_msgSend(_45,"registerThemeValues:forView:",_49,_48);
}else{
var _4c=_4a.substr(_4b+1)+"/";
for(var i=0;i<_49.length;++i){
var _4d=_49[i],_4e=_4d[0],_4f=_4d[1],_50=_4d[2],_51=nil;
if(typeof (_4f)==="object"&&_4f.hasOwnProperty("isa")&&objj_msgSend(_4f,"isKindOfClass:",CPColor)&&(_51=objj_msgSend(_4f,"patternImage"))){
if(objj_msgSend(_51,"isThreePartImage")||objj_msgSend(_51,"isNinePartImage")){
var _52=objj_msgSend(_51,"imageSlices"),_53=[];
for(var _54=0;_54<_52.length;++_54){
var _55=_52[_54],_56=_4c+objj_msgSend(objj_msgSend(_55,"filename"),"lastPathComponent"),_57=objj_msgSend(_55,"size");
_53.push([_56,_57.width,_57.height]);
}
if(objj_msgSend(_51,"isThreePartImage")){
_4f=PatternColor(_53,objj_msgSend(_51,"isVertical"));
}else{
_4f=PatternColor(_53);
}
}else{
var _56=_4c+objj_msgSend(objj_msgSend(_51,"filename"),"lastPathComponent"),_57=objj_msgSend(_51,"size");
_4f=PatternColor(_56,_57.width,_57.height);
}
}
if(_50){
objj_msgSend(_48,"setValue:forThemeAttribute:inState:",_4f,_4e,_50);
}else{
objj_msgSend(_48,"setValue:forThemeAttribute:",_4f,_4e);
}
}
}
}
if(_47){
objj_msgSend(_45,"registerThemeValues:forView:",_47,_48);
}
}
})]);
BKLabelFromIdentifier=function(_58){
var _59=_58.substr("themed".length),_5a=0,_5b=_59.length,_5c="",_5d=null,_5e=YES;
for(;_5a<_5b;++_5a){
var _5f=_59.charAt(_5a),_60=/^[A-Z]/.test(_5f);
if(_60){
if(!_5e){
if(_5d===null){
_5c+=" "+_5f.toLowerCase();
}else{
_5c+=_5f;
}
}
_5d=_5f;
}else{
if(_5e&&_5d!==null){
_5c+=_5d;
}
_5c+=_5f;
_5d=null;
_5e=NO;
}
}
return _5c;
};
PatternIsVertical=YES,PatternIsHorizontal=NO;
PatternColor=function(){
if(arguments.length<3){
var _61=arguments[0],_62=[];
for(var i=0;i<_61.length;++i){
var _63=_61[i];
_62.push(_63?objj_msgSend(_CPCibCustomResource,"imageResourceWithName:size:",_63[0],CGSizeMake(_63[1],_63[2])):nil);
}
if(arguments.length==2){
return objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPThreePartImage,"alloc"),"initWithImageSlices:isVertical:",_62,arguments[1]));
}else{
return objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPNinePartImage,"alloc"),"initWithImageSlices:",_62));
}
}else{
if(arguments.length==3){
return objj_msgSend(CPColor,"colorWithPatternImage:",PatternImage(arguments[0],arguments[1],arguments[2]));
}else{
return nil;
}
}
};
PatternImage=function(_64,_65,_66){
return objj_msgSend(_CPCibCustomResource,"imageResourceWithName:size:",_64,CGSizeMake(_65,_66));
};
p;24;BKThemedObjectTemplate.jt;911;@STATIC;1.0;I;15;AppKit/CPView.jt;873;
objj_executeFile("AppKit/CPView.j",NO);
var _1=objj_allocateClassPair(CPView,"BKThemedObjectTemplate"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_label"),new objj_ivar("_themedObject")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("BKThemedObjectTemplate").super_class},"init");
if(_3){
_label=objj_msgSend(_5,"decodeObjectForKey:","BKThemedObjectTemplateLabel");
_themedObject=objj_msgSend(_5,"decodeObjectForKey:","BKThemedObjectTemplateThemedObject");
}
return _3;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_6,_7,_8){
with(_6){
objj_msgSend(_8,"encodeObject:forKey:",_label,"BKThemedObjectTemplateLabel");
objj_msgSend(_8,"encodeObject:forKey:",_themedObject,"BKThemedObjectTemplateThemedObject");
}
})]);
p;17;BKThemeTemplate.jt;873;@STATIC;1.0;I;21;Foundation/CPObject.jt;829;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"BKThemeTemplate"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_name"),new objj_ivar("_description")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("BKThemeTemplate").super_class},"init");
if(_3){
_name=objj_msgSend(_5,"decodeObjectForKey:","BKThemeTemplateName");
_description=objj_msgSend(_5,"decodeObjectForKey:","BKThemeTemplateDescription");
}
return _3;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_6,_7,_8){
with(_6){
objj_msgSend(_8,"encodeObject:forKey:",_name,"BKThemeTemplateName");
objj_msgSend(_8,"encodeObject:forKey:",_description,"BKThemeTemplateDescription");
}
})]);
p;10;BlendKit.jt;307;@STATIC;1.0;i;22;BKShowcaseController.ji;19;BKThemeDescriptor.ji;17;BKThemeTemplate.ji;24;BKThemedObjectTemplate.jt;187;
objj_executeFile("BKShowcaseController.j",YES);
objj_executeFile("BKThemeDescriptor.j",YES);
objj_executeFile("BKThemeTemplate.j",YES);
objj_executeFile("BKThemedObjectTemplate.j",YES);
e;