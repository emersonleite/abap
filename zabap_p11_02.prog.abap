*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_01
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p11_02.

DATA: opcoes TYPE c,
      gt_flight TYPE zty_meus_voos,
       gs_flight LIKE LINE OF gt_flight.

SELECTION-SCREEN BEGIN OF BLOCK limit.
SELECTION-SCREEN BEGIN OF BLOCK info WITH FRAME TITLE text-001.

PARAMETERS: pa_cia TYPE sflight-carrid.

SELECT-OPTIONS so_con FOR gs_flight-connid.

SELECTION-SCREEN END OF BLOCK info.

SELECTION-SCREEN BEGIN OF BLOCK opcoes WITH FRAME TITLE text-002.
PARAMETERS: pa_lim_1 RADIOBUTTON GROUP lim DEFAULT 'X',
            pa_lim_2 RADIOBUTTON GROUP lim,
            pa_lim_3 RADIOBUTTON GROUP lim.
SELECTION-SCREEN END OF BLOCK opcoes.

SELECTION-SCREEN END OF BLOCK limit.

INITIALIZATION.
  opcoes = 'X'.
  pa_cia = 'LH'.
  MOVE: 'I' TO so_con-sign,
        'BT' TO so_con-option,
        '0400' TO so_con-low,
        '3577' TO so_con-high.
  APPEND so_con.

  CLEAR so_con.

  MOVE: 'E' TO so_con-sign,
        'BT' TO so_con-option,
        '0454' TO so_con-low,
        '0455' TO so_con-high.
  APPEND so_con.


AT SELECTION-SCREEN ON BLOCK info.
* AUTHORITY-CHECK OBJECT

  AUTHORITY-CHECK OBJECT 'S_CARRID'
           ID 'CARRID' FIELD pa_cia
           ID 'ACTVT' FIELD '03'.

************************
  IF sy-subrc NE 0.
    MESSAGE e012(zmsg) WITH sy-uname pa_cia.
  ENDIF.

START-OF-SELECTION.

  "  CALL FUNCTION 'Z_LER_VARIOS_VOO'
  "    EXPORTING
  "      im_cia          = pa_cia
  "      im_voo          = so_con
  "    IMPORTING
  "      ex_voos         = gt_flight
  "    EXCEPTIONS
  "      voo_inexistente = 1
  "      OTHERS          = 2.

  "  IF sy-subrc <> 0.
  "    IF sy-subrc EQ 1.
  "      MESSAGE i009(zmsg).
  "    ELSE.
  "      MESSAGE i010(zmsg).
  "    ENDIF.
  "  ENDIF.

  "  SKIP 2.

  SELECT carrid connid fldate seatsmax seatsocc
  FROM sflight INTO TABLE gt_flight
  WHERE carrid = pa_cia AND   connid IN so_con.

  LOOP AT gt_flight INTO gs_flight.

    gs_flight-percentage = ( gs_flight-seatsocc * 100 ) / gs_flight-seatsmax.

    MODIFY TABLE gt_flight FROM gs_flight.

  ENDLOOP.

  SORT gt_flight BY percentage DESCENDING.
*                  carrid     ASCENDING.

* write: /, 5


  LOOP AT gt_flight INTO gs_flight.
    CASE opcoes.
      WHEN pa_lim_1.
        WRITE: / gs_flight-carrid, gs_flight-connid, gs_flight-fldate, gs_flight-seatsmax, gs_flight-seatsocc, gs_flight-percentage.
      WHEN pa_lim_2.
        IF gs_flight-percentage > 50.
          WRITE: / gs_flight-carrid, gs_flight-connid, gs_flight-fldate, gs_flight-seatsmax, gs_flight-seatsocc, gs_flight-percentage.
        ENDIF.
      WHEN pa_lim_3.
        IF gs_flight-percentage <= 50.
          WRITE: / gs_flight-carrid, gs_flight-connid, gs_flight-fldate, gs_flight-seatsmax, gs_flight-seatsocc, gs_flight-percentage.
        ENDIF.
    ENDCASE.

    "  WRITE: / gs_flight-carrid, gs_flight-connid, gs_flight-fldate, gs_flight-seatsmax, gs_flight-seatsocc, gs_flight-percentage.

  ENDLOOP.