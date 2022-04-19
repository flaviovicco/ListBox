#INCLUDE "TOTVS.CH"

User Function DragDrop()

Local aList1 := {"banana","laranja","maça"}
Local aList2 := {}

DEFINE DIALOG oDlg TITLE ("Arraste e Solte") FROM 0,0 TO 250,600 PIXEL //COLOR CLR_WHITE, CLR_BROWN
    oPanel:=TPaintPanel():new(0,0,0,0,oDlg,.f.)
    oPanel:Align := CONTROL_ALIGN_ALLCLIENT
    oPanel:SetTransparent(.T.)
    //
    nList1:= 1
	oList1:= TListBox():New(0,0,{|u|if(Pcount()>0,nList1:=u,nList1)},aList1,140,5,/*{||Alert("Mudou de linha")}*/,oPanel,,,,.T.)
    oList1:Align := CONTROL_ALIGN_LEFT
    //
    nList2:= 1
	oList2:= TListBox():New(0,0,{|u|if(Pcount()>0,nList2:=u,nList2)},aList2,140,50,/*{||Alert("Mudou de linha")}*/,oPanel,,,,.T.)
    oList2:Align := CONTROL_ALIGN_RIGHT
    //
    oBtn1:= TButton():new(10,140,">",oPanel,{||Move(oList1,oList2,oList1:nAt)},20,20,,,,.T.,,,,,,)
    oBtn2:= TButton():new(30,140,"<",oPanel,{||Move(oList2,oList1,oList2:nAt)},20,20,,,,.T.,,,,,,)
    oBtn3:= TButton():new(50,140,">>",oPanel,{||MoveAll(oList1,oList2)},20,20,,,,.T.,,,,,,)
    oBtn4:= TButton():new(70,140,"<<",oPanel,{||MoveAll(oList2,oList1)},20,20,,,,.T.,,,,,,)
    oBtn1:lCanGotFocus := .F.
    oBtn2:lCanGotFocus := .F.
    oBtn3:lCanGotFocus := .F.
    oBtn4:lCanGotFocus := .F.
ACTIVATE DIALOG oDlg CENTER

Return

Static Function Move(oListOri,oListDes,nItemOri)
Local cItemOri := ""
Local aListOri := oListOri:aItems
Local aListDes := oListDes:aItems

If nItemOri > 0
    cItemOri := aListOri[nItemOri]
    aDel(aListOri,nItemOri)
    aSize(aListOri,Len(aListOri)-1)
    oListOri:SetArray(aListOri)
    //
    aAdd(aListDes,cItemOri)
    aSort(aListDes,,,{|x,y|x<y})
    oListDes:SetArray(aListDes)
    //
    oListOri:Select(Iif(nItemOri>1,nItemOri-1,1))
    oListDes:Select(Len(aListDes))
    //
    oListOri:Refresh()
    oListDes:Refresh()
EndIf

Return

Static Function MoveAll(oListOri,oListDes)
Local nX   := 0
Local nMax := Len(oListOri:aItems)

For nX := 1 To nMax
    Move(oListOri,oListDes,oListOri:nAt)
Next nX

Return
