REPORT  zabap_p11_03.

DATA:  gt_flight TYPE zty_meus_voos,
       gs_flight LIKE LINE OF gt_flight. "connid

*********************************************************************
SELECTION-SCREEN BEGIN OF BLOCK limit3 WITH FRAME.

SELECTION-SCREEN BEGIN OF BLOCK limit WITH FRAME TITLE text-900.
PARAMETERS pa_cia TYPE sflight-carrid.
SELECT-OPTIONS pa_con FOR gs_flight-connid.
SELECTION-SCREEN END OF BLOCK limit.

SELECTION-SCREEN BEGIN OF BLOCK limit2 WITH FRAME TITLE text-901.
PARAMETERS: pa_lim_1 RADIOBUTTON GROUP lim,
            pa_lim_2 RADIOBUTTON GROUP lim DEFAULT 'X',
            pa_lim_3 RADIOBUTTON GROUP lim.
SELECTION-SCREEN END OF BLOCK limit2.
SELECTION-SCREEN END OF BLOCK limit3.

*********************************************************************
INITIALIZATION.

* Colocando variaveis default na tela de selecao

  MOVE: 'I' TO pa_con-sign,
  'BT' TO pa_con-option,
  '400' TO pa_con-low,
  '3577' TO pa_con-high.

  APPEND pa_con.
  CLEAR pa_con.

  MOVE: 'E' TO pa_con-sign,
  'BT' TO pa_con-option,
  '0454' TO pa_con-low,
  '0455' TO pa_con-high.

  APPEND pa_con.
  CLEAR pa_con.

  pa_cia = 'LH'.

*********************************************************************

AT SELECTION-SCREEN on BLOCK limit2.
  AUTHORITY-CHECK OBJECT 'S_CARRID'
           ID 'CARRID' FIELD pa_cia
           ID 'ACTVT' FIELD '03'.

*********************************************************************

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


  WRITE: / gs_flight-carrid, gs_flight-connid, gs_flight-fldate, gs_flight-seatsmax, gs_flight-seatsocc, gs_flight-percentage.


  LOOP AT gt_flight INTO gs_flight.

    IF pa_lim_1 = 'X'.
      PERFORM imprimir.
    ENDIF.

    IF pa_lim_2 = 'X' AND gs_flight-percentage > 50.
      PERFORM imprimir.
    ENDIF.

    IF pa_lim_3 = 'X' AND gs_flight-percentage <= 50.
      PERFORM imprimir.
    ENDIF.

  ENDLOOP.

*&---------------------------------------------------------------------*
*&      Form  imprimir
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM imprimir.
  WRITE: / gs_flight-carrid, gs_flight-connid, gs_flight-fldate, gs_flight-seatsmax, gs_flight-seatsocc, gs_flight-percentage.
ENDFORM.                    "imprimir