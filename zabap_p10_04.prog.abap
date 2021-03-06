*&---------------------------------------------------------------------*
*& Report  ZABAP_P10_04
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p10_04.

DATA:  gt_flight TYPE zty_meus_voos,
       gs_flight LIKE LINE OF gt_flight.

PARAMETERS: pa_cia TYPE sflight-carrid.
SELECT-OPTIONS
  sa_con FOR gs_flight-connid.

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

*  CALL FUNCTION 'Z_LER_VARIOS_VOO'
*    EXPORTING
*      im_cia          = pa_cia
*      im_voo          = sa_con
*    IMPORTING
*      ex_voos         = gt_flight
*    EXCEPTIONS
*      voo_inexistente = 1
*      OTHERS          = 2.

  SELECT carrid connid fldate seatsmax seatsocc INTO TABLE gt_flight
   FROM sflight
   WHERE carrid = pa_cia
   AND  connid IN sa_con.

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

    WRITE: / gs_flight-carrid, gs_flight-connid, gs_flight-fldate, gs_flight-seatsmax, gs_flight-seatsocc, gs_flight-percentage.

  ENDLOOP.