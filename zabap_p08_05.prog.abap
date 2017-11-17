*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_05
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p08_05.

DATA: gt_voos TYPE zty_meus_voos,  gs_voos LIKE LINE OF gt_voos.
PARAMETERS: pa_cia TYPE sflight-carrid, pa_con TYPE sflight-connid.

*SELECT carrid connid fldate seatsmax seatsocc
*   FROM sflight INTO TABLE gt_voos
*      WHERE carrid = pa_cia
*      AND connid = pa_con.


SELECT carrid connid fldate seatsmax seatsocc
   FROM sflight INTO gs_voos
      WHERE carrid = pa_cia
      AND connid = pa_con.

  gs_voos-percentage = gs_voos-seatsmax - gs_voos-seatsocc.
  WRITE: gs_voos-carrid, gs_voos-connid, gs_voos-fldate, gs_voos-seatsmax, gs_voos-seatsocc, gs_voos-percentage, /.
ENDSELECT.

IF sy-subrc NE 0.
  MESSAGE i010(zmsg).
ENDIF.



*LOOP AT gt_voos INTO gs_voos.
*  gs_voos-percentage = gs_voos-seatsmax - gs_voos-seatsocc.
*
*  WRITE: gs_voos-carrid, gs_voos-connid, gs_voos-fldate, gs_voos-seatsmax, gs_voos-seatsocc, gs_voos-percentage, /.
*ENDLOOP.