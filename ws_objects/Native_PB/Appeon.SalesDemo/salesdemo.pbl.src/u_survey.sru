$PBExportHeader$u_survey.sru
forward
global type u_survey from userobject
end type
type cb_1 from commandbutton within u_survey
end type
type rte_1 from richtextedit within u_survey
end type
end forward

global type u_survey from userobject
integer width = 4425
integer height = 3328
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_1 cb_1
rte_1 rte_1
end type
global u_survey u_survey

forward prototypes
public subroutine of_survey (string as_company)
end prototypes

public subroutine of_survey (string as_company);Integer 			li_rtn, li_fieldid, i 
Date				ld_date, ld_date1
Boolean 			lbn_flag, lb_rtn
String			ls_data, ls_item[], ls_table1[], ls_table2[], ls_commboitem[], ls_itemText
Long				ll_fieldID, ll_inputPos, ll_ItemLen

SetPointer(Hourglass!)
openwithparm(w_progressbar,"Creating/Loading survey data...")

//Title [Company Name]
ls_data = '\pard\ltrpar\s16\itap0\widctlpar\qc\li0\ri0\lin0\rin0\brdrt\brdrs\brdrw30\brsp100\brdrcf2\brdrb\brdrs\brdrw30\brsp100\brdrcf2\brdrbtw\brdrs\brdrw30\brsp100\brdrcf2\cbpat3\plain\rtlch\af3\afs32\ab\ltrch\f3\fs32\b ['+as_company+']'
rte_1.pastertf("{\rtf1"+ls_data+"\par}", Detail!)
//How Are We Doing? 
ls_data ='\ltrpar\s1\itap0\outlinelevel0\keep\keepn\widctlpar\ql\li0\ri0\lin0\rin0\sb360\sa180\plain\rtlch\af3\afs22\ab\ai\acf4\ltrch\f3\fs22\b\i\cf4 How Are We Doing?'
rte_1.pastertf("{\rtf1"+ls_data+"\par}", Detail!)
//We are committed to providing you with the best dining experience possible, so we welcome your comments. Please fill out this questionnaire and send it to us by replying to the email. Thank you.
ls_data ='\fs24\ We are committed to providing you with the best experience possible, so we welcome your comments. Please fill out this questionnaire and send it to us by replying to the email . Thank you.'
rte_1.pastertf("{\rtf1"+ls_data+"\par}", Detail!)

//Insert textfield
ll_fieldID = rte_1.formtextfieldinsert( "", 11600)	
rte_1.ReplaceText("~r~n")

//Please rate the quality of the products you received:
ls_data ='\pard\brdrt\brdrs\brdrw10\brsp20\brdrcf0\brdrbtw\brdrs\brdrw10\brsp20\brdrcf0\fs24 Please rate the quality of the products you received:'
rte_1.pastertf("{\rtf1"+ls_data+"\par}", Detail!)

ls_data =space(60) 
rte_1.pastertf("{\rtf1\fs24\ "+ls_data+"}", Detail!)
For i = 1 To 5
	li_fieldid = rte_1.FormCheckBoxInsert( False)
	ls_data = String(i) +space(12) 
	rte_1.pastertf("{\rtf1\fs24\  "+ls_data+"}", Detail!)
Next 

ll_fieldID = rte_1.TableInsert(1,2,-1)
ls_item={"Disappointing","Exceptional"}
For i = 1 To 2 Step 1
	lb_rtn = rte_1.TableSetCellText(ll_fieldID,1,i,ls_item[i])
Next

rte_1.TableCellSelect(ll_fieldID, 1, 2)
rte_1.SetAlignment(Right!)

ll_ItemLen = rte_1.TableGetCellLength(ll_fieldID, 1, 2)      		
ll_inputPos = rte_1.TableCellStart(ll_fieldID, 1, 2)            	
rte_1.SelectedStartPos = ll_inputPos +  ll_ItemLen          		
rte_1.SelectedTextLength = 0   												

rte_1.ReplaceText("~r~n")

ls_data ='\pard\brdrt\brdrs\brdrw10\brsp20\brdrcf0\brdrbtw\brdrs\brdrw10\brsp20\brdrcf0\fs24 Please rate the quality of the support service you received:'
rte_1.pastertf("{\rtf1\ "+ls_data+"\par}", Detail!)

ls_data =space(60) 
rte_1.pastertf("{\rtf1\fs24\ "+ls_data+"}", Detail!)
For i = 1 To 5
	If i <> 5 Then
		li_fieldid = rte_1.FormCheckBoxInsert( False)
	Else
		li_fieldid = rte_1.FormCheckBoxInsert( True)
	End If	
	ls_data = String(i) +space(12) 
	rte_1.pastertf("{\rtf1\fs24\  "+ls_data+"}", Detail!)
Next 

ll_fieldID = rte_1.TableInsert(1,2,-1)
ls_item={"Disappointing","Exceptional"}
For i = 1 To 2 Step 1
	lb_rtn = rte_1.TableSetCellText(ll_fieldID,1,i,ls_item[i])
Next

rte_1.TableCellSelect(ll_fieldID, 1, 2)
rte_1.SetAlignment(Right!)

ll_ItemLen = rte_1.TableGetCellLength(ll_fieldID, 1, 2)      		
ll_inputPos = rte_1.TableCellStart(ll_fieldID, 1, 2)            	
rte_1.SelectedStartPos = ll_inputPos +  ll_ItemLen          	
rte_1.SelectedTextLength = 0   												
rte_1.ReplaceText("~r~n")

ls_data ='\pard\brdrt\brdrs\brdrw10\brsp20\brdrcf0\brdrbtw\brdrs\brdrw10\brsp20\brdrcf0\fs24 How frequently do you use our product or support service?'
rte_1.pastertf("{\rtf1"+ls_data+"\par}", Detail!)	
rte_1.ReplaceText("~r~n")

//Insert Table and set cell text
ll_fieldID = rte_1.TableInsert(5,4,-1)
lb_rtn = rte_1.TableSetCellBorderWidth(ll_fieldID,0,0,1)

ls_table2={"","Product A","Product B","Support Service"}
For i = 1 To 4 Step 1
	lb_rtn = rte_1.TableSetCellText(ll_fieldID,1,i,ls_table2[i])
	lb_rtn = rte_1.TableSetCellBackColor(ll_fieldID,1,i,RGB(224, 234, 225))
	lb_rtn = rte_1.TableSetCellBorderColor(ll_fieldID,1,i,rgb(75,126,241))	
Next

ls_item={"","3-5 times per month","1-2 times per month","Once every 2 months","Other"}
For i = 2 To 5 Step 1
	lb_rtn = rte_1.TableSetCellText(ll_fieldID,i,1,ls_item[i])
Next

ls_data =''
rte_1.pastertf("{\rtf1\fs24\ "+ls_data+"\par}", Detail!)

//Was your server
ls_data ='\pard\brdrt\brdrs\brdrw10\brsp20\brdrcf0\brdrbtw\brdrs\brdrw10\brsp20\brdrcf0\fs24 Was our support service:'
rte_1.pastertf("{\rtf1\ "+ls_data+"\par}", Detail!)
ls_data =''
rte_1.pastertf("{\rtf1\fs24\ "+ls_data+"\par}", Detail!)

//Insert Combobox
ls_data ='Choose an item.'
ls_commboitem={"Choose an item.","Courteous","Informative","Prompt and efficient"}
li_rtn = rte_1.formcomboboxinsert( ls_data, ls_commboitem, False, 9000)

ls_data =''
rte_1.pastertf("{\rtf1\fs24\ "+ls_data+"\par\par}", Detail!)

//Would you recommend our restaurant to a friend?
ls_data ='\pard\brdrt\brdrs\brdrw10\brsp20\brdrcf0\brdrbtw\brdrs\brdrw10\brsp20\brdrcf0\fs24 Would you recommend our products to a friend?'
rte_1.pastertf("{\rtf1"+ls_data+"\par}", Detail!)	

//Insert CheckBox
li_fieldid = rte_1.FormCheckBoxInsert( False)
ls_data='Yes | '
rte_1.pastertf("{\rtf1\fs24\ "+ls_data+"}", Detail!)
li_fieldid = rte_1.FormCheckBoxInsert( False)
ls_data='No '
rte_1.pastertf("{\rtf1\fs24\ "+ls_data+"\par\par}", Detail!)

//Why, or why not?
ls_data ='\pard\brdrt\brdrs\brdrw10\brsp20\brdrcf0\brdrbtw\brdrs\brdrw10\brsp20\brdrcf0\fs24 Why, or why not?'
rte_1.pastertf("{\rtf1"+ls_data+"\par}", Detail!)	

//Insert TextFrame
li_fieldid = rte_1.TextFrameInsertAsChar(-1, 11600, 600)
rte_1.TextFrameSetText(li_fieldid, "Please explain.")
rte_1.TextFrameSetBackColor(li_fieldid, RGB(224, 234, 225))
rte_1.ReplaceText("~r~n")

//Insert DateField
ls_data =' Date:  '
rte_1.pastertf("{\rtf1\fs24\ "+ls_data+"}", Detail!)

ld_date= Today ( )
lbn_flag= False
li_fieldid = rte_1.FormDateFieldInsert(ld_date, lbn_flag, "MM/dd/yyyy", 10000)


close(w_progressbar)
SetPointer(Arrow!)
end subroutine

on u_survey.create
this.cb_1=create cb_1
this.rte_1=create rte_1
this.Control[]={this.cb_1,&
this.rte_1}
end on

on u_survey.destroy
destroy(this.cb_1)
destroy(this.rte_1)
end on

type cb_1 from commandbutton within u_survey
integer y = 4
integer width = 480
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Export and Send"
end type

event clicked;String 	ls_Pdffile, ls_newfile
Integer 	li_rtn
Boolean 	lb_exist
PDFdocument lpdf_doc


lpdf_doc = create PDFdocument

//Import the richtextedit content
lpdf_doc.importrichtextedit( rte_1)

lpdf_doc.watermark.image.filename=".\image\watermark2.png"
lpdf_doc.watermark.Transparency = 20
lpdf_doc.watermark.scale = 1


ls_Pdffile = ".\pdf\survey.pdf"
li_rtn = lpdf_doc.save( ls_Pdffile)
Destroy lpdf_doc

If li_rtn = 1 Then
	
	openwithparm(w_sendemail,'Survey')
Else
	Messagebox("Info","Failed to export the PDF file!")	
End IF


end event

type rte_1 from richtextedit within u_survey
integer y = 108
integer width = 4416
integer height = 3204
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean init_hscrollbar = true
boolean init_vscrollbar = true
boolean init_rulerbar = true
boolean init_tabbar = true
boolean init_toolbar = true
boolean init_headerfooter = true
long init_leftmargin = 100
long init_rightmargin = 100
end type

