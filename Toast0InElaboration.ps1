[xml]$ToastTemplate = @"
    <toast launch="action=viewDownload&amp;downloadId=9438108" scenario="reminder">
    	<visual>
	    	<binding template="ToastGeneric">
			    <image placement="hero" src="C:\Windows\Web\Screen\img102.jpg"/>
			    <text>Conversion Jpg to Pdf</text>
			    <text>Converting Jpg in NOME CARTELLA</text>
			    <text placement="attribution">Riga attributo</text>
			    <progress
				    title="{progressTitle}"
				    value="{progressValue}"
				    valueStringOverride="{progressValueString}"
				    status="{progressStatus}"/>
			    <image placement="appLogoOverride" src="C:\Windows\IdentityCRL\WLive48x48.png" hint-crop="circle"/>
		    </binding>
	    </visual>
        <actions>
        <action activationType="system" arguments="dismiss" content="Dismiss"/>
        </actions>
    	<audio src="ms-winsoundevent:Notification.Reminder"/>
    </toast>
"@

    #Load the ToastTemplate into the required format
    $ToastXml = New-Object Windows.Data.Xml.Dom.XmlDocument
    $ToastXml.LoadXml($ToastTemplate.OuterXml)

    $ToastNotification = [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime]::New($ToastXml)
    $ToastNotification.Tag = 'my_tag'
    $Dictionary = [System.Collections.Generic.Dictionary[String, String]]::New()
    $Dictionary.Add('progressTitle', 'YouTube')
    $Dictionary.Add('progressValue', '0')
    $Dictionary.Add('progressValueString', '0/2 images')
    $Dictionary.Add('progressStatus', 'Converting...')
    $ToastNotification.Data = [Windows.UI.Notifications.NotificationData]::New($Dictionary)
    $ToastNotification.Data.SequenceNumber = 1

    #Display the toast notification
    $AppID = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
    $Notification = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppID)
    $Notification.Show($ToastNotification)

    for ($index = 1; $index -le 2; $index++) {
	    Start-Sleep 1
	    $Dictionary = [System.Collections.Generic.Dictionary[String, String]]::New()
	    $Dictionary.Add('progressValue', $index / 2)
	    $Dictionary.Add('progressValueString', "$index/2 images")
	    $NotificationData = [Windows.UI.Notifications.NotificationData]::New($Dictionary)
	    $NotificationData.SequenceNumber = 2
	    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Update($NotificationData, 'my_tag')
    }
    $Dictionary = [System.Collections.Generic.Dictionary[String, String]]::New()
    $Dictionary.Add('progressStatus', 'Completed!')
    $NotificationData = [Windows.UI.Notifications.NotificationData]::New($Dictionary)
    $NotificationData.SequenceNumber = 2
    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Update($NotificationData, 'my_tag')