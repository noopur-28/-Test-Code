({
	 doInit : function(component, event, helper) {
         component.set("v.Spinner", true);
         helper.callApexAction(component, 'getAccounts', {})
         .then(function (result) {
             console.log('result--' + result);
             if (result.isSuccess) {
                 component.set('v.accountList', result.Data);                             
                 component.set("v.Spinner", false);
             }
             else {
                component.set("v.Spinner", false);
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": 'Error',
                    "type": 'Error',
                    "message": result.Message
                });
                toastEvent.fire();                            
             }
         });
     },
})