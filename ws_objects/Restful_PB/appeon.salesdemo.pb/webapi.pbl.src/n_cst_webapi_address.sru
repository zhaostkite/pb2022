﻿$PBExportHeader$n_cst_webapi_address.sru
forward
global type n_cst_webapi_address from n_cst_webapi_base
end type
end forward

global type n_cst_webapi_address from n_cst_webapi_base autoinstantiate
end type

type variables

end variables

forward prototypes
public function integer of_winopen (ref u_dw adw_filter, ref u_dw adw_browser, ref u_dw adw_master)
public function integer of_deleteaddressbykey (long al_addressid)
public function integer of_savechanges (ref u_dw adw_master)
public function integer of_retrieveaddress (long al_stateprovinceid, string as_city, ref u_dw adw_browser, ref u_dw adw_master)
public function integer of_deleteaddress (ref u_dw adw_browser)
end prototypes

public function integer of_winopen (ref u_dw adw_filter, ref u_dw adw_browser, ref u_dw adw_master);str_arm lstr_am
jsonpackage ljs_pak
Integer li_ret
String ls_json
String ls_url

ls_url = of_get_url("winopen")
lstr_am.request_type = 'Get'
li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)
IF li_ret = -1 Then Return -1

ls_json = ljs_pak.GetValue("StateProvince")
adw_filter.of_importjson_dddw("stateprovinceid", ls_json, true)
adw_browser.of_importjson_dddw("stateprovinceid", ls_json)
adw_master.of_importjson_dddw("stateprovinceid", ls_json)

Return 1
end function

public function integer of_deleteaddressbykey (long al_addressid);String   ls_url
Integer li_ret

str_arm lstr_am
jsonpackage ljs_pak

lstr_am.s_arm[1] =  String(al_addressid)

ls_url = of_get_url("DeleteAddressByKey")
lstr_am.request_type = 'Delete'
li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)

IF li_ret = -1 Then Return -1
li_ret = of_get_servicestatus(ljs_pak, "Delete")

Destroy(ljs_pak)

Return li_ret
end function

public function integer of_savechanges (ref u_dw adw_master);String   ls_url
String   ls_json
Integer li_ret
Integer li_row
DwItemStatus ldws_status
str_arm lstr_am
JsonPackage ljs_pak

li_row = adw_master.GetRow()
ldws_status = adw_master.GetItemStatus(li_row, 0, Primary!)
lstr_am.dw_arm[1] =  adw_master
ls_url = of_get_url("SaveChanges")

// use Submit method
lstr_am.request_type = 'Submit'
li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)
IF li_ret = -1 Then Return -1

li_ret = of_get_servicestatus(ljs_pak, "Save")

adw_master.Setredraw(False)
IF li_ret = 1 And ldws_status = NewModified! Then
	adw_master.DeleteRow(li_row)
	ls_json = ljs_pak.GetValue("Address")
	If gi_service_type = 3 Then
		adw_master.ImportRowFromJson(ls_json, li_row + 1)
	Else
		adw_master.ImportJsonByKey(ls_json)
	End If
End IF 
adw_master.Setredraw(True)

adw_master.ResetUpdate()
Return li_ret
end function

public function integer of_retrieveaddress (long al_stateprovinceid, string as_city, ref u_dw adw_browser, ref u_dw adw_master);str_arm lstr_am
jsonpackage ljs_pak
Integer li_ret
String ls_json
String ls_url

//add auto be decompressed 
ls_url = of_get_url("RetrieveAddress")
ls_url = ls_url + "/" + String(al_stateprovinceid)
IF IsNull(as_city) OR as_city = "" Then as_city = "$"
ls_url = ls_url + "/" + as_city
lstr_am.request_type = 'Get'

li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)
IF li_ret = -1 Then 
	adw_browser.Reset()
	adw_master.Reset()
	Return -1
end if

ls_json = ljs_pak.GetValue("Address")

adw_browser.SetRedraw(False)
adw_master.SetRedraw(False)

adw_browser.ImportJsonByKey(ls_json)
adw_master.ImportJsonByKey(ls_json)
adw_browser.ResetUpdate()
adw_master.ResetUpdate()
adw_browser.SetRedraw(True)
adw_master.SetRedraw(True)

Return 1
end function

public function integer of_deleteaddress (ref u_dw adw_browser);Integer li_ret
String   ls_url
str_arm lstr_am
jsonpackage ljs_pak

lstr_am.dw_arm[1] = adw_browser
ls_url = of_get_url("DeleteAddress")

lstr_am.request_type = 'Delete'
li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)
IF li_ret = -1 Then Return -1

li_ret = of_get_servicestatus(ljs_pak, "Delete")

Destroy(ljs_pak)

Return li_ret
end function

on n_cst_webapi_address.create
call super::create
end on

on n_cst_webapi_address.destroy
call super::destroy
end on

event constructor;call super::constructor;is_controllername = "Address"
end event

