*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_01
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p08_01.

DATA:  gt_flight TYPE zty_meus_voos,
       gs_flight LIKE LINE OF gt_flight,
       vl_livres TYPE i.

PARAMETERS: pa_cia TYPE sflight-carrid,
            pa_con TYPE sflight-connid.

SELECT carrid connid fldate seatsmax seatsocc FROM sflight INTO gs_flight WHERE carrid = pa_cia AND
                                                                                connid = pa_con.

  vl_livres = gs_flight-seatsmax - gs_flight-seatsocc.

  WRITE: /, gs_flight-carrid, gs_flight-connid, gs_flight-fldate, gs_flight-seatsmax, gs_flight-seatsocc, vl_livres.

ENDSELECT.

IF sy-subrc <> 0.
  IF sy-subrc EQ 1.
    MESSAGE i009(smsg).
  ELSE.
    MESSAGE i010(zmsg).
  ENDIF.
ENDIF.