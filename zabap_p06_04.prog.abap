*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_04
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p06_04.

PARAMETERS :
pa_cia TYPE sflight-carrid,
pa_con TYPE sflight-connid,
pa_fld TYPE sflight-fldate.

DATA gv_sflight TYPE sflight.
DATA assentos_livres TYPE sflight-seatsmax.

CALL FUNCTION 'Z_LER_UM_VOO'
  EXPORTING
    im_cia         = pa_cia
    im_num_voo     = pa_con
    im_dt_voo      = pa_fld
  IMPORTING
    ex_voo         = gv_sflight
  EXCEPTIONS
    voo_nao_existe = 1
    OTHERS         = 2.
IF sy-subrc <> 0.
  CASE sy-subrc.
    WHEN '1'.
      MESSAGE i009(zmsg).
      EXIT.
    WHEN '2'.
      MESSAGE i010(zmsg).
      EXIT.
    WHEN OTHERS.

  ENDCASE.
ELSE.
  assentos_livres = gv_sflight-seatsmax - gv_sflight-seatsocc.
  WRITE:/  'Companhia        : ', gv_sflight-carrid,
         / 'Vôo              : ', gv_sflight-connid,
         / 'Data             : ', gv_sflight-fldate,
         / 'Máx. Assentos    : ', gv_sflight-seatsmax,
         / 'Assentos ocupados: ', gv_sflight-seatsocc,
         / 'Assentos livres  : ', assentos_livres.
ENDIF.