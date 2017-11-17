*&---------------------------------------------------------------------*
*& Report  ZABAP_P07_04
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p07_04.

DATA: gt_flights TYPE zty_meus_voos,
      gs_flights LIKE LINE OF gt_flights.

PARAMETERS :
pa_cia TYPE sflight-carrid,
pa_con TYPE sflight-connid.

CALL FUNCTION 'Z_LER_VARIOS_VOO'
  EXPORTING
    im_cia          = pa_cia
    im_voo          = pa_con
  IMPORTING
    ex_voos         = gt_flights
  EXCEPTIONS
    voo_inexistente = 1
    OTHERS          = 2.

IF sy-subrc <> 0.
  CASE sy-subrc.
    WHEN '1'.
      MESSAGE i009(zmsg).

    WHEN '2'.
      MESSAGE i010(zmsg).
      EXIT.
    WHEN OTHERS.
  ENDCASE.
ENDIF.

LOOP AT gt_flights INTO gs_flights.
  gs_flights-percentage = gs_flights-seatsocc / gs_flights-seatsmax * 100.
  MODIFY TABLE gt_flights FROM gs_flights.
ENDLOOP.

SORT gt_flights BY percentage DESCENDING.

LOOP AT gt_flights INTO gs_flights.
  WRITE: /  gs_flights-carrid,
            gs_flights-connid,
            gs_flights-fldate,
            gs_flights-seatsmax,
            gs_flights-seatsocc,
            gs_flights-percentage.

ENDLOOP.