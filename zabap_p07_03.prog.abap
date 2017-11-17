*&---------------------------------------------------------------------*
*& Report  ZABAP_P07_03
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p07_03.

PARAMETERS: pa_car TYPE sflight-carrid,
            pa_con TYPE sflight-connid.

DATA: gt_voo TYPE zty_meus_voos,
      gs_voo LIKE LINE OF gt_voo.


CALL FUNCTION 'Z_LER_VARIOS_VOO'
  EXPORTING
    im_cia          = pa_car
    im_voo          = pa_con
  IMPORTING
    ex_voos         = gt_voo
  EXCEPTIONS
    voo_inexistente = 1
    OTHERS          = 2.

IF sy-subrc <> 0.
  message i011(zmsg).
ENDIF.

LOOP AT gt_voo INTO gs_voo.

 gs_voo-percentage = gs_voo-seatsocc / gs_voo-seatsmax * 100.

 MODIFY table gt_voo from gs_voo.

ENDLOOP.

sort gt_voo by percentage descending.

LOOP AT gt_voo INTO gs_voo.

 Write:/ gs_voo-carrid, gs_voo-connid, gs_voo-fldate, gs_voo-seatsmax, gs_voo-seatsocc, gs_voo-percentage.

ENDLOOP.





*DATA: gs_voo TYPE sflight, var_assentos_livres TYPE sflight-seatsmax.  " sflight é um tipo de dado. Tabela BAPI. gs_voo adquire propriedades de sflight
*
*PARAMETERS: pa_cia TYPE sflight-carrid, " Estão sendo definidos paramatros de entrada com o mesmo tipo de dado da tabela BAPI.
*            pa_con TYPE sflight-connid, "
*            pa_fld TYPE sflight-fldate. "
*
*CALL FUNCTION 'Z_LER_UM_VOO'
*  EXPORTING
*    im_cia         = pa_cia             " as variáveis do lado esquerdo da igualdade são da função chamada.
*    im_num_voo     = pa_con             " as do lado direito são do programa atual.
*    im_dt_voo      = pa_fld
*  IMPORTING
*    ex_voo         = gs_voo
*  EXCEPTIONS
*    voo_nao_existe = 1
*    OTHERS         = 2.
*
*IF sy-subrc <> 0.
*  CASE sy-subrc.
*    WHEN 1.
*      MESSAGE i009(zmsg).
*    WHEN 2.
*      MESSAGE i010(zmsg).
*  ENDCASE.
*ENDIF.
*
*var_assentos_livres = gs_voo-seatsmax - gs_voo-seatsocc.
*
*WRITE:/ 'Companhia:', gs_voo-carrid,
*/ 'Voo:', gs_voo-connid,
*/ 'Data:', gs_voo-fldate,
*/ 'Assentos totais', gs_voo-seatsmax,
*/ 'Assentos ocupados', gs_voo-seatsocc,
*/ 'Assentos livres', var_assentos_livres,
*/ 'Maxima capacidade na primeira classe', gs_voo-seatsmax_f.