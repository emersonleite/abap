*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_03
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p06_03.

DATA: gs_voo TYPE sflight, var_assentos_livres TYPE sflight-seatsmax.  " sflight é um tipo de dado. Tabela BAPI. gs_voo adquire propriedades de sflight

PARAMETERS: pa_cia TYPE sflight-carrid, " Estão sendo definidos paramatros de entrada com o mesmo tipo de dado da tabela BAPI.
            pa_con TYPE sflight-connid, "
            pa_fld TYPE sflight-fldate. "

CALL FUNCTION 'Z_LER_UM_VOO'
  EXPORTING
    im_cia         = pa_cia             " as variáveis do lado esquerdo da igualdade são da função chamada.
    im_num_voo     = pa_con             " as do lado direito são do programa atual.
    im_dt_voo      = pa_fld
  IMPORTING
    ex_voo         = gs_voo
  EXCEPTIONS
    voo_nao_existe = 1
    OTHERS         = 2.

IF sy-subrc <> 0.
  CASE sy-subrc.
    WHEN 1.
      MESSAGE i009(zmsg).
    WHEN 2.
      MESSAGE i010(zmsg).
  ENDCASE.
ENDIF.

var_assentos_livres = gs_voo-seatsmax - gs_voo-seatsocc.

WRITE:/ 'Companhia:', gs_voo-carrid,
/ 'Voo:', gs_voo-connid,
/ 'Data:', gs_voo-fldate,
/ 'Assentos totais', gs_voo-seatsmax,
/ 'Assentos ocupados', gs_voo-seatsocc,
/ 'Assentos livres', var_assentos_livres,
/ 'Maxima capacidade na primeira classe', gs_voo-seatsmax_f.