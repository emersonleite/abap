*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_05
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p08_02.

DATA gt_voos TYPE zty_meus_voos.
DATA gs_voos LIKE LINE OF gt_voos.

DATA livres TYPE i.

PARAMETERS: pa_car TYPE sflight-carrid,
            pa_con TYPE sflight-connid.

SELECT carrid connid fldate seatsmax seatsocc
  FROM sflight
  INTO gs_voos
 WHERE carrid = pa_car AND
       connid = pa_con.

  livres = gs_voos-seatsmax - gs_voos-seatsocc.

  WRITE: /'',gs_voos-carrid,'      ',
               gs_voos-connid,'   ',
               gs_voos-fldate,' ',
               gs_voos-seatsmax,'   ',
               gs_voos-seatsocc,'   ',
               livres.

ENDSELECT.