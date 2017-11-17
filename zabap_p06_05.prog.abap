*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_05
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p06_05.

DATA: gs_voo TYPE sflight, var_acentos_livres TYPE sflight-seatsmax.
PARAMETERS: pa_cia TYPE sflight-carrid, pa_con TYPE sflight-connid, pa_fld TYPE sflight-fldate.

CALL FUNCTION 'Z_LER_UM_VOO'
  EXPORTING
    im_cia         = pa_cia
    im_num_voo     = pa_con
    im_dt_voo      = pa_fld
  IMPORTING
    ex_voo         = gs_voo
  EXCEPTIONS
    voo_nao_existe = 1
    OTHERS         = 2.
IF sy-subrc <> 0.
  CASE sy-subrc.
    WHEN '1'.
      MESSAGE i009(zmsg) WITH sy-subrc.
      EXIT.
    WHEN OTHERS.
      MESSAGE i010(zmsg) WITH sy-subrc.
      EXIT.
  ENDCASE.
ENDIF.

var_acentos_livres = gs_voo-seatsmax - gs_voo-seatsocc.

WRITE: 'CIA:', gs_voo-carrid,
    / 'Número:', gs_voo-connid,
    / 'Data:', gs_voo-fldate,
    / 'Num Acentos Máximo:', gs_voo-seatsmax,
    / 'Acentos Ocupados:', gs_voo-seatsocc,
    / 'Acentos livres:', var_acentos_livres.