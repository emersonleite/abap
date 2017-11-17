FUNCTION ler_uma_reserva2.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(DATA_RES_F) TYPE  SBOOK-ORDER_DATE
*"     REFERENCE(ID_VOO_F) TYPE  SBOOK-CONNID
*"  EXPORTING
*"     REFERENCE(GV_RESERVA_F) TYPE  SBOOK
*"  EXCEPTIONS
*"      PASSAGEIRO_NAO_EXISTE
*"----------------------------------------------------------------------

  SELECT SINGLE * FROM sbook INTO gv_reserva_f WHERE order_date = data_res_f
      AND connid = ID_voo_F.

  IF sy-subrc NE 0.
    RAISE passageiro_nao_existe.
  ENDIF.

ENDFUNCTION.