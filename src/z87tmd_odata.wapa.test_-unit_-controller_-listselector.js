sap.ui.define(["nm_z87_gw100/Project_Name_CrudTemp/controller/ListSelector"],function(t){"use strict";QUnit.module("Initialization",{beforeEach:function(){this.oListSelector=new t},afterEach:function(){this.oListSelector.destroy()}});QUnit.test("Should i+
nitialize the List loading promise",function(t){var e=t.async(),i=this.spy(),s=this.spy();this.oListSelector.oWhenListLoadingIsDone.then(s,i);setTimeout(function(){t.strictEqual(s.callCount,0,"Did not resolve the promise");t.strictEqual(i.callCount,0,"Di+
d not reject the promise");e()},0)});QUnit.module("List loading",{beforeEach:function(){this.oListSelector=new t},afterEach:function(){this.oListSelector.destroy()}});function e(t,e){var i=function(){return true},s={getParameter:i},n=function(t,e){e(s)},+
o=this.stub().returns({attachEventOnce:n}),h=function(t,e,i){e.apply(i)},r={getBindingContext:this.stub().returns({getPath:this.stub().returns(e)})},c=[];if(t){c.push(r)}return{attachEvent:h,attachEventOnce:n,getBinding:o,getItems:this.stub().returns(c)}+
}QUnit.test("Should resolve the list loading promise, if the list has items",function(t){var i=t.async(),s=this.spy(),n=function(e){t.strictEqual(e,e,"Did pass the binding path");t.strictEqual(s.callCount,0,"Did not reject the promise");i()};this.oListSe+
lector.oWhenListLoadingIsDone.then(n,s);this.oListSelector.setBoundMasterList(e.call(this,true,"anything"))});QUnit.test("Should reject the list loading promise, if the list has no items",function(t){var i=t.async(),s=this.spy(),n=function(){t.strictEqua+
l(s.callCount,0,"Did not resolve the promise");i()};this.oListSelector.oWhenListLoadingIsDone.then(s,n);this.oListSelector.setBoundMasterList(e.call(this,false))});QUnit.module("Selecting item in the list",{beforeEach:function(){this.oListSelector=new t;+
this.oListSelector.oWhenListLoadingIsDone={then:function(t){this.fnAct=t}.bind(this)}},afterEach:function(){this.oListSelector.destroy()}});function i(t){return{getBindingContext:this.stub().returns({getPath:this.stub().returns(t)})}}QUnit.test("Should s+
elect an Item of the list when it is loaded and the binding contexts match",function(t){var s="anything",n=i.call(this,s),o=i.call(this,"a different binding path");this.oListSelector._oList={getMode:this.stub().returns("SingleSelectMaster"),getSelectedIt+
em:this.stub().returns(o),getItems:this.stub().returns([o,n,e.call(this,"yet another list binding")]),setSelectedItem:function(e){t.strictEqual(e,n,"Did select the list item with a matching binding context")}};this.oListSelector.selectAListItem(s);this.f+
nAct()});QUnit.test("Should not select an Item of the list when it is already selected",function(t){var e="anything",s=i.call(this,e);this.oListSelector._oList={getMode:this.stub().returns("SingleSelectMaster"),getSelectedItem:this.stub().returns(s)};thi+
s.oListSelector.selectAListItem(e);this.fnAct();t.ok(true,"did not fail")});QUnit.test("Should not select an item of the list when the list has the selection mode none",function(t){var e="anything";this.oListSelector._oList={getMode:this.stub().returns("+
None")};this.oListSelector.selectAListItem(e);this.fnAct();t.ok(true,"did not fail")})});                                                                                                                                                                      