*----------------------------------------------------------------------*
***INCLUDE MZABAP_T01_03F01 .
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
      titlebar      = 'Sistema de compras'
      text_question = 'Caro usuário, você alterou o pedido. Não deseja salvar?'
    IMPORTING
      answer        = resp.  "1-sim, 2-Não ou A-Cancela, permaneça onde está
endform.
                   " FAZER_PERGUNTA