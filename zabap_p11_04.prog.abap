*&---------------------------------------------------------------------*
*& Report  ZABAP_P11_04
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p11_04.

DATA:  opc TYPE c,
       gt_flight TYPE zty_meus_voos,
       gs_flight LIKE LINE OF gt_flight.

SELECTION-SCREEN BEGIN OF BLOCK painel01 WITH FRAME.

SELECTION-SCREEN BEGIN OF BLOCK painel02 WITH FRAME TITLE text-001.

PARAMETERS: pa_cia TYPE sflight-carrid.

SELECT-OPTIONS
  so_con FOR gs_flight-connid.

SELECTION-SCREEN END OF BLOCK painel02.

SELECTION-SCREEN BEGIN OF BLOCK painel03 WITH FRAME TITLE text-002.

PARAMETERS:  pa_prc1 RADIOBUTTON GROUP opc,
             pa_prc2 RADIOBUTTON GROUP opc,
             pa_prc3 RADIOBUTTON GROUP opc.

SELECTION-SCREEN END OF BLOCK painel03.
SELECTION-SCREEN END OF BLOCK painel01.

INITIALIZATION.

  opc = 'X'.
  MOVE 'LH' TO pa_cia.
  MOVE: '0400' TO so_con-low.
  MOVE: '3577' TO so_con-high,
          'BT' TO so_con-option,
          'I'  TO so_con-sign.
  APPEND so_con.
  CLEAR so_con.

  MOVE: '0454' TO so_con-low,
        '0455' TO so_con-high,
        'BT'   TO so_con-option,
        'E'    TO so_con-sign.
  APPEND so_con.

*AT SELECTION-SCREEN on pa_cia.
AT SELECTION-SCREEN on block painel02.
  AUTHORITY-CHECK OBJECT 'S_CARRID'
  ID 'CARRID' FIELD pa_cia
  ID 'ACTVT' FIELD '03'.
************************
  IF sy-subrc NE 0.
    MESSAGE e012(zmsg) WITH sy-uname pa_cia.
  ENDIF.

START-OF-SELECTION.

  SELECT carrid connid fldate seatsmax seatsocc INTO TABLE gt_flight
   FROM sflight
   WHERE carrid = pa_cia
   AND  connid IN so_con.

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

  LOOP AT gt_flight INTO gs_flight.
    CASE opc.
      WHEN pa_prc1.
        PERFORM imprimir.
      WHEN pa_prc2.
        IF gs_flight-percentage > 50.
          PERFORM imprimir.
        ENDIF.
      WHEN pa_prc3.
        IF gs_flight-percentage <= 50.
          PERFORM imprimir.
        ENDIF.
    ENDCASE.
  ENDLOOP.

*&---------------------------------------------------------------------*
*&      Form  imprimir
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM imprimir.
  WRITE: / gs_flight-carrid, gs_flight-connid, gs_flight-fldate, gs_flight-seatsmax, gs_flight-seatsocc, gs_flight-percentage.
ENDFORM.                    "imprimir