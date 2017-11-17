*&---------------------------------------------------------------------*
*& Report  ZCASA_P06_03
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zcasa_p07_03.

DATA: gv_reserva TYPE sbook. "PASSNAME,ORDER_DATE

PARAMETERS:
            data_res TYPE sbook-order_date,
            id_voo TYPE sbook-connid.

CALL FUNCTION 'LER_UMA_RESERVA2'
  EXPORTING
    data_res_f            = data_res
    id_voo_f           = id_voo
  IMPORTING
    gv_reserva_f          = gv_reserva
  EXCEPTIONS
    passageiro_nao_existe = 1
    OTHERS                = 2.
IF sy-subrc <> 0.
  CASE sy-subrc.
    WHEN 1.
      MESSAGE i999(zmsg) WITH sy-subrc.
    WHEN 2.
      MESSAGE i998(zmsg) WITH sy-subrc.

  ENDCASE.
ENDIF.


WRITE: 'Passageiro', gv_reserva-mandt.