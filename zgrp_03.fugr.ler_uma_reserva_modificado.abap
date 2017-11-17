FUNCTION LER_UMA_RESERVA_MODIFICADO.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(ID_RESERVA_F) TYPE  SBOOK-BOOKID
*"  EXPORTING
*"     REFERENCE(GV_RESERVA_F) TYPE  SBOOK
*"  EXCEPTIONS
*"      RESERVA_INEXISTENTE
*"----------------------------------------------------------------------

  SELECT SINGLE * FROM sbook INTO gv_reserva_f WHERE bookid = id_reserva_f.

  IF sy-subrc Ne 0.
    RAISE reserva_inexistente.
  ENDIF.









ENDFUNCTION.