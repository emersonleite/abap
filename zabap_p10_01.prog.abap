*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_01
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p10_01.

DATA:  gt_flight TYPE zty_meus_voos,
       gs_flight LIKE LINE OF gt_flight.

PARAMETERS     pa_cia TYPE sflight-carrid.
SELECT-OPTIONS so_con FOR  gs_flight-connid.

AT SELECTION-SCREEN.

  AUTHORITY-CHECK OBJECT 'S_CARRID'
           ID 'CARRID' FIELD pa_cia
           ID 'ACTVT'  FIELD '03'.

  IF sy-subrc NE 0.
    MESSAGE w012(zmsg) WITH sy-uname pa_cia.
  ENDIF.

START-OF-SELECTION.

  SELECT carrid connid fldate seatsmax seatsocc
    FROM sflight INTO TABLE gt_flight WHERE carrid = pa_cia
                                      AND   connid IN so_con.

  IF sy-subrc <> 0.
    MESSAGE i009(zmsg).
  ENDIF.

  SKIP 2.