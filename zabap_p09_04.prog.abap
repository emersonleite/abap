*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_01
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p09_04.

DATA:  gt_flight TYPE zty_meus_voos,
       gs_flight LIKE LINE OF gt_flight.

PARAMETERS: pa_cia TYPE sflight-carrid,
            pa_con TYPE sflight-connid.

AT SELECTION-SCREEN.
* AUTHORITY-CHECK OBJECT
  AUTHORITY-CHECK OBJECT 'S_CARRID'
  ID 'CARRID' FIELD pa_cia
  ID 'ACTVT' FIELD '03'.
************************
  IF sy-subrc NE 0.
    MESSAGE e012(zmsg) WITH sy-uname pa_cia.
  ENDIF.

START-OF-SELECTION.

  CALL FUNCTION 'Z_LER_VARIOS_VOO'
    EXPORTING
      im_cia          = pa_cia
      im_voo          = pa_con
    IMPORTING
      ex_voos         = gt_flight
    EXCEPTIONS
      voo_inexistente = 1
      OTHERS          = 2.

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

    WRITE: / gs_flight-carrid, gs_flight-connid, gs_flight-fldate, gs_flight-seatsmax, gs_flight-seatsocc, gs_flight-percentage.

  ENDLOOP.