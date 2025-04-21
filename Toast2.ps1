[xml]$ToastTemplate = @"
<toast launch="chatLaunchArg">
  <visual>
    <binding template="ToastGeneric">
      <text>Emily</text>
      <text>Coming tonight for the tea party?</text>
    </binding>
  </visual>
  <actions>
    <input id="idTextBox1" type="text" placeHolderContent="reply" />
    <action content="Send" hint-inputId="idTextBox1" activationType="background" arguments="argSendPress" />
  </actions>
</toast>
"@

    #Load the ToastTemplate into the required format
    $ToastXml = New-Object Windows.Data.Xml.Dom.XmlDocument
    $ToastXml.LoadXml($ToastTemplate.OuterXml)

    #Display the toast notification
    $AppID = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
    $Notification = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppID)
    $Notification.Show($ToastXml)