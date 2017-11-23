*----------------------------------------------------------------------*
***INCLUDE MZVIGAS_03_USER_COMMAND_010I01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module USER_COMMAND_0100 input.
CASE ok_code.
    WHEN 'BACK' OR 'UP' OR 'CANCEL'.
      CASE sy-dynnr.
        WHEN '0100'.
          SET SCREEN 0.
        WHEN '0200'.
          SET SCREEN 100.
      ENDCASE.
    WHEN 'CAL_VOL'.
      SET SCREEN 200.
    WHEN 'CAL_TAXA'.
*      flag = 'X'.
      SET SCREEN 201.
  ENDCASE.
endmodule.                 " USER_COMMAND_0100  INPUT