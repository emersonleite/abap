*&---------------------------------------------------------------------*
*& Report  ZABAP_P08_04
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p08_04.

*DATA: gt_flights TYPE sflight,
DATA: gt_flights TYPE zty_meus_voos,
      gs_flights LIKE LINE OF gt_flights,
      assentos_livres TYPE sflight-seatsmax.

PARAMETERS :
pa_car TYPE sflight-carrid,
pa_con TYPE sflight-connid.

SELECT carrid connid fldate seatsmax seatsocc INTO gs_flights
*SELECT * INTO gs_flights
  FROM sflight
  WHERE carrid = pa_car
  AND connid = pa_con.

  assentos_livres = gs_flights-seatsmax - gs_flights-seatsocc.

  WRITE: / gs_flights-carrid,
           gs_flights-connid,
           gs_flights-fldate,
           gs_flights-seatsmax,
           gs_flights-seatsocc,
           assentos_livres.
ENDSELECT.