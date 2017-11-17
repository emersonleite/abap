FUNCTION z_calc_expo_01.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IM_V1) TYPE  I
*"     REFERENCE(IM_V2) TYPE  I
*"  EXPORTING
*"     REFERENCE(EX_RESU) TYPE  BC400_PERC
*"  EXCEPTIONS
*"      EXPO_MAIOR_QUE_QUATRO
*"      EXPONENCIAL_NAO_INFORMADO
*"      VALOR_NAO_INFORMADO
*"----------------------------------------------------------------------
  IF im_v2 > 4.
    RAISE expo_maior_que_quatro.
  ENDIF.

  IF im_v2 IS INITIAL.
    RAISE exponencial_nao_informado.
  ENDIF.

  IF im_v1 IS INITIAL.
    RAISE valor_nao_informado.
  ENDIF.

  ex_resu = im_v1 ** im_v2.

ENDFUNCTION.