*&---------------------------------------------------------------------*
*& Report  ZCASA_P06_03
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zcasa_p06_03_modificado.

" ** DECLARANDO VARIÁVEIS "**

DATA: gv_reserva TYPE sbook. "bookid, mandt .

*PARAMETERS:
*            cod_cia TYPE sbook-carrid,
*           num_voo TYPE sbook-connid ,
*            data_voo TYPE sbook-fldate.

PARAMETER id_rese TYPE sbook-BOOKID.

" ** lENDO FUNÇÃO PARA RETORMO DE VALORES DA TABELA SBOOK "**

CALL FUNCTION 'LER_UMA_RESERVA_MODIFICADO'
  EXPORTING
    id_reserva_f        = id_rese

  IMPORTING
    gv_reserva_f        = gv_reserva
  EXCEPTIONS
    reserva_inexistente = 1
    OTHERS              = 3.

  " ** TRATANDO EXCEÇÃO "**

IF sy-subrc <> 0.
  CASE sy-subrc.
    WHEN 1.
      MESSAGE i999(zmsg) WITH  id_rese .
  ENDCASE.
ENDIF.

" ** GERANDO RELATÓRIO "**

WRITE: / 'Data da reserva' , 30 gv_reserva-order_date,
       / 'Passageiro', 30 gv_reserva-bookid,
       / 'Companhia' , 30 gv_reserva-carrid,
       / 'Conexão', 30 gv_reserva-connid,
       / 'Data do voo' , 30 gv_reserva-fldate,
       / 'Preço da reserva' , 30 gv_reserva-forcuram.