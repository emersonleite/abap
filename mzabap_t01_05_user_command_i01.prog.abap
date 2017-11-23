*----------------------------------------------------------------------*
***INCLUDE MZABAP_T01_05_USER_COMMAND_I01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
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
      select single * from zview1_05 where codfor = zped_05-codfor.
      SET SCREEN 300.
  ENDCASE.
ENDMODULE.                 " USER_COMMAND_0100  INPUT