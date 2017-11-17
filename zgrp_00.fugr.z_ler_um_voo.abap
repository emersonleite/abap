FUNCTION z_ler_um_voo.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IM_CIA) TYPE  SFLIGHT-CARRID
*"     REFERENCE(IM_NUM_VOO) TYPE  SFLIGHT-CONNID
*"     REFERENCE(IM_DT_VOO) TYPE  SFLIGHT-FLDATE
*"  EXPORTING
*"     REFERENCE(EX_VOO) TYPE  SFLIGHT
*"  EXCEPTIONS
*"      VOO_NAO_EXISTE
*"----------------------------------------------------------------------

  SELECT SINGLE * FROM sflight INTO ex_voo WHERE carrid = im_cia
                                    AND   connid = im_num_voo
                                    AND   fldate = im_dt_voo.
  IF sy-subrc NE 0.
    RAISE  voo_nao_existe.
  ENDIF.



ENDFUNCTION.