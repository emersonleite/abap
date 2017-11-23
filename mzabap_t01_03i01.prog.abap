*----------------------------------------------------------------------*
***INCLUDE MZABAP_T01_03I01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  LER_PEDIDO_DE_COMPRA  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE ler_pedido_de_compra INPUT.

  SELECT SINGLE * FROM zped_03 WHERE numped = zped_03-numped.
  IF sy-subrc NE 0.
    MESSAGE e013(zmsg) WITH zped_03-numped.
  ENDIF.

ENDMODULE.                 " LER_PEDIDO_DE_COMPRA  INPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BOT1' OR 'BOT2' OR 'BOT3'.
      my_tab-activetab = ok_code.
    WHEN 'BACK'." OR '%EX' OR 'RW'.
      CASE sy-dynnr.
        WHEN '0100'.
          LEAVE TO SCREEN 0.
        WHEN '0200'.
          SET SCREEN 100.
          WHEN '0300'.
          SET SCREEN 200.
      ENDCASE.
    WHEN 'DISP'.
      SET SCREEN 200.
    WHEN 'ALTE'.
      flag = 'X'.
      SET SCREEN 200.
    WHEN 'DETA'.
      select single * from zview1_03 where codfor = zped_03-codfor.
      SET SCREEN 300.
  ENDCASE.
ENDMODULE.                 " USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*&      Module  SET_FLAG_ALTERACAO  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE set_flag_alteracao INPUT.
  flg = 'X'.
ENDMODULE.                 " SET_FLAG_ALTERACAO  INPUT
*&---------------------------------------------------------------------*
*&      Module  SAIDA_PELA_TANGENTE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE saida_pela_tangente INPUT.
  IF flg = 'X'.
    PERFORM fazer_pergunta.
  ENDIF.
  IF resp NE 'A'.
    CASE ok_code.
      WHEN '%EX'.
        LEAVE PROGRAM.
      WHEN 'RW'.
        LEAVE TO SCREEN 100.
    ENDCASE.
  ENDIF.
ENDMODULE.                 " SAIDA_PELA_TANGENTE  INPUT