*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_05
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p06_02.

DATA gv_flight TYPE sflight.
DATA gv_livres TYPE sflight-seatsmax.

PARAMETERS: pa_cia TYPE sflight-carrid,
            pa_con TYPE sflight-connid,
            pa_fld TYPE sflight-fldate.

CALL FUNCTION 'Z_LER_UM_VOO'
  EXPORTING
    im_cia         = pa_cia
    im_num_voo     = pa_con
    im_dt_voo      = pa_fld
  IMPORTING
    ex_voo         = gv_flight
  EXCEPTIONS
    voo_nao_existe = 1
    OTHERS         = 2.

IF sy-subrc <> 0.
  CASE sy-subrc.
    WHEN 1.
      MESSAGE i009(zmsg)." WITH sy-subrc.
    WHEN 2.
      MESSAGE i008(zmsg).
  ENDCASE.
  EXIT.
ELSE.
  gv_livres = gv_flight-seatsmax - gv_flight-seatsocc.

  WRITE:/'Companhia:       ', gv_flight-carrid,
        /'Número vôo:      ',gv_flight-connid,
        /'Data vôo:        ', gv_flight-fldate,
        /'Assentos livres: ',gv_livres.
ENDIF.