$PBExportHeader$salesdemo.sra
$PBExportComments$Generated Application Object
forward
global type salesdemo from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
String gs_host = "http://localhost:16561"
Int gi_service_type = 1  //DataStore: 1, ModelStore: 2, SqlModelMapper: 3

//Service Type
Constant Int WEBAPI_DATASTORE = 1
Constant Int WEBAPI_MODELSTORE = 2
Constant Int WEBAPI_SQLMODELMAPPER = 3
Boolean gb_expand = True

String gs_msg_title = "Sales CRM Demo"


end variables

global type salesdemo from application
string appname = "salesdemo"
string displayname = "SalesDemo"
string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 22.0\IDE\theme"
string themename = "Flat Design Blue"
boolean nativepdfvalid = true
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 5
long richtexteditx64type = 5
long richtexteditversion = 3
string richtexteditkey = ""
string appicon = ".\image\CRM.ico"
string appruntimeversion = "22.2.0.3289"
boolean manualsession = false
boolean unsupportedapierror = false
boolean bignoreservercertificate = false
uint ignoreservercertificate = 0
long webview2distribution = 0
boolean webview2checkx86 = false
boolean webview2checkx64 = false
string webview2url = "https://developer.microsoft.com/en-us/microsoft-edge/webview2/"
end type
global salesdemo salesdemo

forward prototypes
public function integer of_getserviceurl ()
end prototypes

public function integer of_getserviceurl ();String ls_file

ls_file = "apisetup.ini"

IF Not FileExists(ls_file) Then
	MessageBox("Error", "Apisetup.ini does not exist.")
Else
	gs_host = "http://" + Trim(ProfileString(ls_file, "Setup", "URL", ""))
	gi_service_type = ProfileInt(ls_file, "Setup", "ModelType", 3)
End IF

IF Isnull(gs_host) OR gs_host = '' Then Return -1
Return 1
end function

on salesdemo.create
appname="salesdemo"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on salesdemo.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;String  ls_theme

//Check Evergreen WebView2 Runtime Installed
If f_chk_webview_installed() = -1 Then
              Return
End If

ls_theme = ProfileString("apisetup.ini", "Setup", "Theme", "Flat Design Blue")
IF ls_theme <> "Do Not Use Themes" THEN
	applytheme(GetCurrentDirectory( ) + "\Theme\" + ls_theme)
END IF

IF of_getserviceurl() = 1 Then
	open(w_main)
Else
	open(w_setup)
End IF
end event

event systemerror;Choose Case error.Number
        Case 220  to 229 //Session Error
                 MessageBox ("Session Error", "Number:" + String(error.Number) + "~r~nText:" + error.Text )
        Case 230  to 239 //License Error
                 MessageBox ("License Error", "Number:" + String(error.Number) + "~r~nText:" + error.Text )
        Case 240  to 249 //Token Error
                 MessageBox ("Token Error", "Number:" + String(error.Number) + "~r~nText:" + error.Text )
        Case Else
                 MessageBox ("SystemError", "Number:" + String(error.Number) + "~r~nText:" + error.Text )
End Choose


end event

