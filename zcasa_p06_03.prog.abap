*&---------------------------------------------------------------------*
*& Report  ZCASA_P06_03
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zcasa_p06_03.

DATA: gv_reserva TYPE sbook. "bookid, mandt .

PARAMETERS:
            cod_cia TYPE sbook-carrid,
           num_voo TYPE sbook-connid ,
            data_voo TYPE sbook-fldate.

PARAMETER id_rese TYPE sbook-BOOKID.

"nome_cliente TYPE sbook-mandt,
"cod_cia TYPE sbook-carrid,


CALL FUNCTION 'LER_UMA_RESERVA'
  EXPORTING
    id_reserva_f        = id_rese
    num_voo_f           = num_voo
    data_voo_f          = data_voo
    cod_cia_f           = cod_cia
  IMPORTING
    gv_reserva_f        = gv_reserva
  EXCEPTIONS
    reserva_inexistente = 1
    voo_nao_informado   = 2
    OTHERS              = 3.
IF sy-subrc <> 0.
  CASE sy-subrc.
    WHEN 1.
      MESSAGE i999(zmsg) WITH  id_rese .
  ENDCASE.
ENDIF.

WRITE: /'Passageiro', gv_reserva-bookid.