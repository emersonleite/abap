*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_01
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p11_05.

DATA:  var_opc TYPE c,
       gt_flight TYPE zty_meus_voos,
       gs_flight LIKE LINE OF gt_flight.

SELECTION-SCREEN BEGIN OF BLOCK pnl01 WITH FRAME.
SELECTION-SCREEN BEGIN OF BLOCK pnl02 WITH FRAME TITLE text-001.
PARAMETERS pa_cia TYPE sflight-carrid.

SELECT-OPTIONS
      so_con FOR gs_flight-connid.

SELECTION-SCREEN END OF BLOCK pnl02.
SELECTION-SCREEN BEGIN OF BLOCK pnl03 WITH FRAME TITLE text-002.

PARAMETERS:  pa_perc1 RADIOBUTTON GROUP opc,
             pa_perc2 RADIOBUTTON GROUP opc,
             pa_perc3 RADIOBUTTON GROUP opc.

SELECTION-SCREEN END OF BLOCK pnl03.
SELECTION-SCREEN END OF BLOCK pnl01.

INITIALIZATION.
  var_opc = 'X'.

  pa_cia = 'LH'.

  MOVE: '0400' TO so_con-low,
        '3577' TO so_con-high,
        'BT' TO so_con-option,
        'I' TO so_con-sign.
  APPEND so_con.

  CLEAR so_con.

  MOVE: '0454' TO so_con-low,
        '0455' TO so_con-high,
        'BT' TO so_con-option,
        'E' TO so_con-sign.
  APPEND so_con.


AT SELECTION-SCREEN on block pnl03.
* AUTHORITY-CHECK OBJECT
  AUTHORITY-CHECK OBJECT 'S_CARRID'
           ID 'CARRID' FIELD pa_cia
           ID 'ACTVT' FIELD '03'.


************************
  IF sy-subrc NE 0.
    MESSAGE e012(zmsg) WITH sy-uname pa_cia.
  ENDIF.

START-OF-SELECTION.


  SELECT carrid connid fldate seatsmax seatsocc
     FROM sflight INTO TABLE gt_flight
        WHERE carrid = pa_cia
        AND connid IN so_con ORDER BY connid ASCENDING.

*  CALL FUNCTION 'Z_LER_VARIOS_VOO'
*    EXPORTING
*      im_cia          = pa_cia
*      im_voo          = pa_con
*    IMPORTING
*      ex_voos         = gt_flight
*    EXCEPTIONS
*      voo_inexistente = 1
*      OTHERS          = 2.


  IF sy-subrc <> 0.
    IF sy-subrc EQ 1.
      MESSAGE i009(zmsg).
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
      WHEN pa_perc1.
        PERFORM imprimir.
      WHEN pa_perc2.
        IF gs_flight-percentage > 50.
          PERFORM imprimir.
        ENDIF.
      WHEN pa_perc3.
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