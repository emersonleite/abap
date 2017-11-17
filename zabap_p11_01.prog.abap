*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_01
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p11_01.

DATA:  gt_flight TYPE zty_meus_voos,
       gs_flight LIKE LINE OF gt_flight. "connid

CONSTANTS var_opc VALUE 'X'.

SELECTION-SCREEN BEGIN OF BLOCK carr0 WITH FRAME.

SELECTION-SCREEN BEGIN OF BLOCK carr1 WITH FRAME TITLE text-001.
PARAMETERS pa_cia TYPE sflight-carrid.
SELECT-OPTIONS pa_con FOR gs_flight-connid.
SELECTION-SCREEN END OF BLOCK carr1.

SELECTION-SCREEN BEGIN OF BLOCK carr2 WITH FRAME TITLE text-002.
PARAMETERS:
pa_sl_1 RADIOBUTTON GROUP lim,
pa_sl_2 RADIOBUTTON GROUP lim,
pa_sl_3 RADIOBUTTON GROUP lim.
SELECTION-SCREEN END OF BLOCK carr2.

SELECTION-SCREEN END OF BLOCK carr0.

INITIALIZATION.

  MOVE 'LH' TO pa_cia.

  MOVE: 'I' TO pa_con-sign,
  'EQ' TO pa_con-option,
  '0400' TO pa_con-low,
  '3577' TO pa_con-high.
  APPEND pa_con.
  CLEAR pa_con.

  MOVE: 'E' TO pa_con-sign,
  'EQ' TO pa_con-option,
  '0454' TO pa_con-low.
  APPEND pa_con.

* Nao vou limpar a WA para aproveitas as outras informações do registro
  MOVE '0455' TO pa_con-high.
  APPEND pa_con.

AT SELECTION-SCREEN.
  AUTHORITY-CHECK OBJECT 'S_CARRID'
           ID 'CARRID' FIELD pa_cia
           ID 'ACTVT' FIELD '03'.

************************

  IF sy-subrc NE 0.
    MESSAGE e012(zmsg) WITH sy-uname pa_cia.
*   MESSAGE w012(zmsg) WITH sy-uname pa_cia. mensagem não impeditiva
  ENDIF.

START-OF-SELECTION.

  SELECT carrid connid fldate seatsmax seatsocc
   FROM sflight INTO TABLE gt_flight WHERE carrid = pa_cia
                                     AND connid IN pa_con.

*  CALL FUNCTION 'Z_LER_VARIOS_VOO'
*    EXPORTING
*      im_cia          = pa_cia
*      im_voo          = pa_con
*    IMPORTING
*      ex_voos         = gt_flight
*    EXCEPTIONS
*      voo_inexistente = 1
*      OTHERS          = 2.
*
  IF sy-subrc <> 0.
    IF sy-subrc EQ 1.
      MESSAGE i009(smsg).
    ELSE.
      MESSAGE i010(zmsg).
    ENDIF.
  ENDIF.

  SKIP 2.

  LOOP AT gt_flight INTO gs_flight.

    gs_flight-percentage = ( gs_flight-seatsocc * 100 ) / gs_flight-seatsmax.

    MODIFY TABLE gt_flight FROM gs_flight.

  ENDLOOP.

  SORT gt_flight BY percentage DESCENDING.
*                  carrid     ASCENDING.

* write: /, 5


  LOOP AT gt_flight INTO gs_flight.

    CASE var_opc.
      WHEN pa_sl_1.
        WRITE: / gs_flight-carrid, gs_flight-connid, gs_flight-fldate, gs_flight-seatsmax, gs_flight-seatsocc, gs_flight-percentage.
*        PERFORM imprimir.
      WHEN pa_sl_2.
        IF gs_flight-percentage > 50.
          WRITE: / gs_flight-carrid, gs_flight-connid, gs_flight-fldate, gs_flight-seatsmax, gs_flight-seatsocc, gs_flight-percentage.
*        PERFORM imprimir.
        ENDIF.
      WHEN pa_sl_3.
        IF gs_flight-percentage <= 50.
          WRITE: / gs_flight-carrid, gs_flight-connid, gs_flight-fldate, gs_flight-seatsmax, gs_flight-seatsocc, gs_flight-percentage.
*        PERFORM imprimir.
        ENDIF.
    ENDCASE.

  ENDLOOP.

*----------------------------------------------------------------------*
***INCLUDE ZABAP_P11_01_IMPRIMIRF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  IMPRIMIR
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM imprimir .
  WRITE: / gs_flight-carrid, gs_flight-connid, gs_flight-fldate, gs_flight-seatsmax, gs_flight-seatsocc, gs_flight-percentage.
ENDFORM.                    " IMPRIMIR