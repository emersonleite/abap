FUNCTION z_ler_varios_voo.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IM_CIA) TYPE  SFLIGHT-CARRID
*"     REFERENCE(IM_VOO) TYPE  SFLIGHT-CONNID
*"  EXPORTING
*"     REFERENCE(EX_VOOS) TYPE  ZTY_MEUS_VOOS
*"  EXCEPTIONS
*"      VOO_INEXISTENTE
*"----------------------------------------------------------------------
  SELECT *
  FROM sflight INTO CORRESPONDING FIELDS OF TABLE ex_voos WHERE carrid = im_cia
                                                          AND   connid = im_voo.

  IF sy-subrc NE 0.
    RAISE voo_inexistente.
  ENDIF.


ENDFUNCTION.