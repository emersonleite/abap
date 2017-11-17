*&---------------------------------------------------------------------*
*& Report  ZCASA_CRIANDO_TABELA_INTERNAS
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zcasa_criando_tabela_internas.

*PARAMETER texto TYPE string.

PARAMETERS: p_carrid TYPE sbook-carrid,
            "p_connid TYPE sbook-connid,
            p_datei TYPE sbook-fldate,
            p_datef TYPE sbook-fldate.

*----------------------------------------------------------------------------*
* DEFININDO TIPOS LOCAIS DE TABELAS (01)
TYPES: gty_minhas_reservas

  TYPE STANDARD TABLE OF sbook

  WITH NON-UNIQUE KEY carrid connid fldate.

*----------------------------------------------------------------------------*
* DEFININDO TIPOS LOCAIS DE TABELAS (02)
TYPES: BEGIN OF gty_minhas_reservas_02,
  carrid TYPE s_car_id,
  connid TYPE s_conn_id,
*... pode-se declarar mais...*
 END OF gty_minhas_reservas_02.

*----------------------------------------------------------------------------*
* CRIANDO A TABELA INTERNA A PARTIR DE TIPOS LOCAIS (01)
DATA gt_minhas_reservas TYPE gty_minhas_reservas.

*----------------------------------------------------------------------------*
* CRIANDO A TABELA INTERNA A PARTIR DE TIPOS LOCAIS (02)
DATA gt_minhas_reservas_4 TYPE STANDARD TABLE OF gty_minhas_reservas_02
      WITH NON-UNIQUE KEY carrid connid.

*----------------------------------------------------------------------------*
* CRIANDO A TABELA INTERNA A PARTIR DE MODELO DE TABELA DEFINIDO NO DICIONÁRIO
DATA gt_reservas TYPE zty_minhas_reservas_03.

*----------------------------------------------------------------------------*
* CRIANDO A TABELA INTERNA A PARTIR DE TABELA TRANSPARENTE
DATA gt_minhas_reservas_3 TYPE sbook.

*----------------------------------------------------------------------------*
* CRIANDO A TABELA INTERNA A PARTIR DE ESTRUTURA (BC400_S_FLIGHT) - FORMA CURTA 01 ********
*DATA gt_voos_01 LIKE STANDARD TABLE OF bc400_s_flight.

*----------------------------------------------------------------------------*
* CRIANDO A TABELA INTERNA A PARTIR DE ESTRUTURA (BC400_S_FLIGHT) - FORMA CURTA 02
DATA gt_voos_02 TYPE TABLE OF bc400_s_flight.

*----------------------------------------------------------------------------*
* CRIANDO A TABELA INTERNA A PARTIR DE ESTRUTURA (BC400_S_FLIGHT) - DECLARANDO
DATA gt_voos_03 TYPE STANDARD TABLE OF bc400_s_flight   "pode ser declarado sorted e hashed
      WITH NON-UNIQUE KEY carrid connid fldate.         "pode ser declarado unique

*----------------------------------------------------------------------------*
* CRIANDO UMA WORK AREA PARA A TABELA gty_minhas_reservas
DATA gs_minhas_reservas LIKE LINE OF gt_minhas_reservas.

IF
  p_datei IS INITIAL AND p_datef IS INITIAL.

  CALL FUNCTION 'Z_CASA_MODULO_INSERT_TABELAS'
    EXPORTING
      f_carrid             = p_carrid
      "f_connid             = p_connid
    IMPORTING
      f_gt_minhas_reservas = gt_reservas
    EXCEPTIONS
      voo_inexistente      = 1
      OTHERS               = 2.

  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  DATA gs_reservas LIKE LINE OF gt_reservas.

  LOOP AT gt_reservas INTO gs_reservas.

    WRITE:/ gs_reservas-carrid,
            gs_reservas-connid,
            gs_reservas-fldate,
            gs_reservas-bookid.
  ENDLOOP.

ELSE.
  DATA gt_reservas_date TYPE zty_minhas_reservas_03.
  DATA gt_reservas_date2 TYPE zty_minhas_reservas_03.
  data gs_reservas_date like LINE OF gt_reservas_date.

  SELECT * FROM sbook INTO TABLE gt_reservas_date WHERE fldate >= p_datei
                                                  AND fldate <= p_datef
                                                  AND carrid = p_carrid.

    LOOP AT gt_reservas_date INTO gs_reservas_date.

    WRITE:/ gs_reservas_date-carrid,
            gs_reservas_date-connid,
            gs_reservas_date-fldate,
            gs_reservas_date-bookid.
  ENDLOOP.

ENDIF.