FUNCTION z_casa_modulo_insert_tabelas.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(F_CARRID) TYPE  SBOOK-CARRID
*"  EXPORTING
*"     REFERENCE(F_GT_MINHAS_RESERVAS) TYPE  ZTY_MINHAS_RESERVAS_03
*"  EXCEPTIONS
*"      VOO_INEXISTENTE
*"----------------------------------------------------------------------

  SELECT * FROM sbook INTO TABLE f_gt_minhas_reservas WHERE carrid = f_carrid. "AND connid = f_connid.


  IF sy-subrc NE 0.
    RAISE voo_inexistente.
  ENDIF.





ENDFUNCTION.