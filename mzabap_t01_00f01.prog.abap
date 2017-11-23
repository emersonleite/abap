*----------------------------------------------------------------------*
***INCLUDE MZABAP_T01_00F01 .
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
      titlebar      = 'Sistema de Compras'
      text_question = 'Caro Usuário, você alterou o Pedido, não deseja salvar ?'
    IMPORTING
      answer        = resp.    " 1-sim, 2-Não ou A-Cancela, permaneça onde está
  IF resp = '1'.
    COMMIT WORK.
  ELSEIF resp = '2'.
    ROLLBACK WORK.
  ENDIF.

ENDFORM.                    " FAZER_PERGUNTA
*&---------------------------------------------------------------------*
*&      Form  UPDATE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM update .
  UPDATE zped_05 SET: totped = zped_05-totped,
                       statusped = zped_05-statusped,
                       codcomp = zped_05-codcomp WHERE numped = zped_05-numped.
  IF sy-subrc NE 0.
    MESSAGE a015(zmsg) WITH zped_05-numped.
  ENDIF.
ENDFORM.                    " UPDATE