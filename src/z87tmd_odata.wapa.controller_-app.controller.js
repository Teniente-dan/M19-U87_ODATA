sap.ui.define(["./BaseController","sap/ui/model/json/JSONModel"],function(e,t){"use strict";return e.extend("nm_z87_gw100.Project_Name_CrudTemp.controller.App",{onInit:function(){var e,n,o=this.getView().getBusyIndicatorDelay();e=new t({busy:true,delay:0+
,layout:"OneColumn",previousLayout:"",actionButtonsInfo:{midColumn:{fullScreen:false}}});this.setModel(e,"appView");n=function(){e.setProperty("/busy",false);e.setProperty("/delay",o)};this.getOwnerComponent().getModel().metadataLoaded().then(n);this.get+
OwnerComponent().getModel().attachMetadataFailed(n);this.getView().addStyleClass(this.getOwnerComponent().getContentDensityClass())}})});                                                                                                                      