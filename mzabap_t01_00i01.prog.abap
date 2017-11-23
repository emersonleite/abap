*----------------------------------------------------------------------*
***INCLUDE MZABAP_T01_00I01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  LER_PEDIDO_DE_COMPRAS  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE ler_pedido_de_compras INPUT.

  SELECT SINGLE * FROM zped_05 WHERE numped = zped_05-numped.
  IF sy-subrc NE 0.
    MESSAGE e013(zmsg) WITH zped_05-numped.
  ENDIF.

ENDMODULE.                 " LER_PEDIDO_DE_COMPRAS  INPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    when 'SAVE'.
      COMMIT WORK AND WAIT.
      set screen 100.
    WHEN 'BOT1' OR 'BOT2' OR 'BOT3'.
      my_tab-activetab = ok_code.
    WHEN 'BACK'. " or '%EX' or 'RW'.
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
      SELECT SINGLE * FROM zview1_05 WHERE codfor = zped_05-codfor.
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
  CALL FUNCTION 'Z_UPD_PEDIDO' IN UPDATE TASK
    EXPORTING
      zped          = zped_05 .

*  perform update on COMMIT.
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
*&---------------------------------------------------------------------*
*&      Module  BLOQUEAR_PEDIDO  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE bloquear_pedido INPUT.
  CALL FUNCTION 'ENQUEUE_EZ_PEDIDO'
    EXPORTING
*     MODE_ZPED_05   = 'E'
*     MANDT          = SY-MANDT
      numped         = zped_05-numped
    EXCEPTIONS
      foreign_lock   = 1
      system_failure = 2
      OTHERS         = 3.
  IF sy-subrc <> 0.
    MESSAGE e014(zmsg) WITH zped_05-numped.
  ENDIF.

ENDMODULE.                 " BLOQUEAR_PEDIDO  INPUT