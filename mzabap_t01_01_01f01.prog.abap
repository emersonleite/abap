*----------------------------------------------------------------------*
***INCLUDE MZABAP_T01_01_01F01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  FAZER_PERGUNTA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form FAZER_PERGUNTA.
CALL FUNCTION 'POPUP_TO_CONFIRM'
  EXPORTING
 TITLEBAR                    = 'Sistema de Compras'
    text_question               = 'Caro Usuário, você alterou o Pedido, não deseja Salvar ?'
 IMPORTING
  ANSWER                      = resp. "1-Sim ou 2-Não ou A-Cancela, permaneça onde está


endform.                    " FAZER_PERGUNTA