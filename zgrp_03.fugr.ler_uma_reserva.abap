FUNCTION ler_uma_reserva.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(ID_RESERVA_F) TYPE  SBOOK-BOOKID
*"     REFERENCE(NUM_VOO_F) TYPE  SBOOK-CONNID
*"     REFERENCE(DATA_VOO_F) TYPE  SBOOK-FLDATE
*"     REFERENCE(COD_CIA_F) TYPE  SBOOK-CARRID
*"  EXPORTING
*"     REFERENCE(GV_RESERVA_F) TYPE  SBOOK
*"  EXCEPTIONS
*"      RESERVA_INEXISTENTE
*"----------------------------------------------------------------------

  SELECT SINGLE * FROM sbook INTO gv_reserva_f WHERE bookid = id_reserva_f
    AND connid = num_voo_f
      AND fldate = data_voo_f
      AND carrid = cod_cia_f.

  IF sy-subrc Ne 0.
    RAISE reserva_inexistente.
  ENDIF.









ENDFUNCTION.