*----------------------------------------------------------------------*
***INCLUDE MZABAP_T01_05F01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  FAZER_PERGUNTA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM fazer_pergunta .
  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
     titlebar                    = 'Sistema de Compras'
      text_question               = 'Caro usuário, você alterou o Pedido, não deseja salvar?'
    IMPORTING
     answer                      = resp. "1 - sim   2 - não ou A - Cancela, permaneça onde está
  endform.                    " FAZER_PERGUNTA