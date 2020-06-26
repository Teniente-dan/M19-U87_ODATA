sap.ui.define(["sap/ui/test/Opa5","sap/ui/test/actions/Press","./Common","sap/ui/test/matchers/AggregationLengthEquals","sap/ui/test/matchers/AggregationFilled","sap/ui/test/matchers/PropertyStrictEquals"],function(e,t,i,s,n,r){"use strict";var a="Detail+
";e.createPageObjects({onTheDetailPage:{baseClass:i,actions:{iPressTheHeaderActionButton:function(e){return this.waitFor({id:e,viewName:a,actions:new t,errorMessage:"Did not find the button with id"+e+" on detail page"})}},assertions:{iShouldSeeNoBusyInd+
icator:function(){return this.waitFor({id:"detailPage",viewName:a,matchers:function(e){return!e.getBusy()},success:function(t){e.assert.ok(!t.getBusy(),"The detail view is not busy")},errorMessage:"The detail view is busy."})},theObjectPageShowsTheFirstO+
bject:function(){return this.iShouldBeOnTheObjectNPage(0)},iShouldBeOnTheObjectNPage:function(t){return this.waitFor(this.createAWaitForAnEntitySet({entitySet:"SupTextSet",success:function(i){var s=i[t].Name;this.waitFor({controlType:"sap.m.ObjectHeader"+
,viewName:a,matchers:new r({name:"title",value:i[t].Name}),success:function(){e.assert.ok(true,"was on the first object page with the name "+s)},errorMessage:"First object is not shown"})}}))},iShouldSeeTheRememberedObject:function(){return this.waitFor(+
{success:function(){var e=this.getContext().currentItem.bindingPath;this._waitForPageBindingPath(e)}})},_waitForPageBindingPath:function(t){return this.waitFor({id:"detailPage",viewName:a,matchers:function(e){return e.getBindingContext()&&e.getBindingCon+
text().getPath()===t},success:function(i){e.assert.strictEqual(i.getBindingContext().getPath(),t,"was on the remembered detail page")},errorMessage:"Remembered object "+t+" is not shown"})},iShouldSeeTheObjectLineItemsList:function(){return this.waitFor(+
{id:"lineItemsList",viewName:a,success:function(t){e.assert.ok(t,"Found the line items list.")}})},theLineItemsListShouldHaveTheCorrectNumberOfItems:function(){return this.waitFor(this.createAWaitForAnEntitySet({entitySet:"Agencies",success:function(t){r+
eturn this.waitFor({id:"lineItemsList",viewName:a,matchers:new n({name:"items"}),check:function(e){var i=e.getBindingContext().getProperty("CountryId");var s=t.filter(function(e){return e.CountryId===i}).length;return e.getItems().length===s},success:fun+
ction(){e.assert.ok(true,"The list has the correct number of items")},errorMessage:"The list does not have the correct number of items.\nHint: This test needs suitable mock data in localService directory which can be generated via SAP Web IDE"})}}))},the+
LineItemsHeaderShouldDisplayTheAmountOfEntries:function(){return this.waitFor({id:"lineItemsList",viewName:a,matchers:new n({name:"items"}),success:function(t){var i=t.getItems().length;return this.waitFor({id:"lineItemsTitle",viewName:a,matchers:new r({+
name:"text",value:"<AgenciesPlural> ("+i+")"}),success:function(){e.assert.ok(true,"The line item list displays "+i+" items")},errorMessage:"The line item list does not display "+i+" items."})}})},iShouldSeeHeaderActionButtons:function(){return this.wait+
For({id:["closeColumn","enterFullScreen"],viewName:a,success:function(){e.assert.ok(true,"The action buttons are visible")},errorMessage:"The action buttons were not found"})},iShouldSeeTheFullScreenToggleButton:function(e){return this.waitFor({id:e,view+
Name:a,errorMessage:"The toggle button"+e+"was not found"})}}}})});                                                                                                                                                                                            