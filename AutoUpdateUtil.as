package
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.DownloadErrorEvent;
	import air.update.events.StatusUpdateErrorEvent;
	import air.update.events.UpdateEvent;
	
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	
	import flashx.textLayout.events.StatusChangeEvent;

	public class AutoUpdateUtil extends EventDispatcher
	{
		private var _updateURL:String=""
		public function AutoUpdateUtil(_url:String=null)
		{
			//Update  
			updateURL=_url;
			
			var appUpdate:ApplicationUpdaterUI = new ApplicationUpdaterUI();  
			appUpdate.updateURL = _updateURL;  
			appUpdate.isCheckForUpdateVisible = false;  
			appUpdate.isFileUpdateVisible     = false;  
			appUpdate.isInstallUpdateVisible  = false;  
			
			appUpdate.addEventListener(UpdateEvent.INITIALIZED, onUpdateHandler);  
			appUpdate.addEventListener(ErrorEvent.ERROR, onErrorHandler);  
			appUpdate.addEventListener(StatusUpdateErrorEvent.UPDATE_ERROR,onStatusUpdateError); 
			appUpdate.addEventListener(DownloadErrorEvent.DOWNLOAD_ERROR,onDownloadError);
			function onStatusUpdateError(evt:StatusUpdateErrorEvent):void {
				trace(evt.toString());
			}
			function onDownloadError(evt:DownloadErrorEvent):void {
				trace(evt.toString());
			}
			
			appUpdate.initialize(); 
			
		}
		private function onUpdateHandler(evt:UpdateEvent):void{
			var target:ApplicationUpdaterUI = evt.currentTarget as ApplicationUpdaterUI;  
			target.removeEventListener(UpdateEvent.INITIALIZED, onUpdateHandler);  
			target.removeEventListener(ErrorEvent.ERROR, onErrorHandler);  
			target.checkNow();  
		}
		private function onErrorHandler(evt:ErrorEvent):void{
			var target:ApplicationUpdaterUI = evt.currentTarget as ApplicationUpdaterUI;  
			target.removeEventListener(UpdateEvent.INITIALIZED, onUpdateHandler);  
			target.removeEventListener(ErrorEvent.ERROR, onErrorHandler);   
		}
/*GET  SET*/
		public function get updateURL():String
		{
			return _updateURL;
		}

		public function set updateURL(value:String):void
		{
			_updateURL = value;
		}

	}
}
/* version XML
<?xml version="1.0" encoding="utf-8"?>
<update xmlns="http://ns.adobe.com/air/framework/update/description/2.5">
<versionNumber>0.5</versionNumber>
<versionLabel>Version for 0.5</versionLabel>
<url>http://your url/your app.air</url>
<description><![CDATA[
]]></description>
</update>
*/  