*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_01
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p06_01.

PARAMETERS: pa_cia TYPE sflight-carrid,
            pa_con TYPE sflight-connid,
            pa_fld TYPE sflight-fldate.

DATA:
       rs_voo TYPE sflight,
       vl_voos_livres TYPE sflight-seatsmax.

CALL FUNCTION 'Z_LER_UM_VOO'
  EXPORTING
    im_cia         = pa_cia
    im_num_voo     = pa_con
    im_dt_voo      = pa_fld
  IMPORTING
    ex_voo         = rs_voo
  EXCEPTIONS
    voo_nao_existe = 1
    OTHERS         = 2.

IF sy-subrc <> 0.
  IF sy-subrc EQ 1.
    MESSAGE i009(smsg).
  ELSE.
    MESSAGE i010(zmsg).
  ENDIF.
ENDIF.

vl_voos_livres = rs_voo-seatsmax - rs_voo-seatsocc.

SKIP 2.

WRITE: / rs_voo-carrid,
/ rs_voo-connid,
/ rs_voo-fldate,
/ rs_voo-seatsmax,
/ rs_voo-seatsocc,
/ vl_voos_livres.