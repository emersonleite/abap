*----------------------------------------------------------------------*
***INCLUDE MZABAP_T01_02I01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  LER_PEDIDO_DE_COMPRAS  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE ler_pedido_de_compras INPUT.
  SELECT SINGLE * FROM zped_02 WHERE numped = zped_02-numped.
    if sy-subrc NE 0.
      message e013(zmsg) with zped_02-numped.
    endif.
ENDMODULE.                 " LER_PEDIDO_DE_COMPRAS  INPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK' OR '%EX' OR 'RW'.
      case sy-dynnr.
        when '0100'.
          SET SCREEN 0.
        when '0200'.
          set screen 100.
       endcase.
    WHEN 'DISP'.
      SET SCREEN 200.
    WHEN 'ALTE'.
      flag = 'X'.
      SET SCREEN 200.
  ENDCASE.
ENDMODULE.                 " USER_COMMAND_0100  INPUT
*&---------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  SET_FLAG_ALTERACAO  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module SET_FLAG_ALTERACAO input.
flg = 'X'.
endmodule.                 " SET_FLAG_ALTERACAO  INPUT