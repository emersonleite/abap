FUNCTION z_calc_expo_05.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IM_V1) TYPE  I
*"     REFERENCE(IM_V2) TYPE  I
*"  EXPORTING
*"     REFERENCE(EX_RESU) TYPE  BC400_PERC
*"  EXCEPTIONS
*"      EXP_MAIOR_QUE_QUATRO
*"      EXP_NAO_INFORMADO
*"      VLR_NAO_INFORMADO
*"----------------------------------------------------------------------
  IF im_v2 > 4.
    RAISE exp_maior_que_quatro.
  ENDIF.

  IF im_v2 IS INITIAL.
    RAISE exp_nao_informado.
  ENDIF.

  IF im_v1 IS INITIAL.
    RAISE vlr_nao_informado.
  ENDIF.

  ex_resu =  im_v1 **  im_v2.

ENDFUNCTION.