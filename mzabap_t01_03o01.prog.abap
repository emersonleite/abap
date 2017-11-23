*----------------------------------------------------------------------*
***INCLUDE MZABAP_T01_03O01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  SET PF-STATUS 'GUI-100'.
  SET TITLEBAR 'TIT-100'.

ENDMODULE.                 " STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  LIMPAR_CAMPOS  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE limpar_campos OUTPUT.
  CLEAR:
  flag.
ENDMODULE.                 " LIMPAR_CAMPOS  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  ALTERAR_ATRIBUTOS  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE alterar_atributos OUTPUT.
  IF flag = 'X'.
    LOOP AT SCREEN.
      IF screen-group1 = 'ACD'.
        screen-input = '1'.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.
ENDMODULE.                 " ALTERAR_ATRIBUTOS  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  DETERMINAR_ICONE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE determinar_icone OUTPUT.
  IF flag = 'X'.
    CALL FUNCTION 'ICON_CREATE'
      EXPORTING
        name   = 'ICON_GREEN_LIGHT'
        text   = ' '
      IMPORTING
        result = icone.

  ELSE.
    CALL FUNCTION 'ICON_CREATE'
      EXPORTING
        name   = 'ICON_RED_LIGHT'
        text   = ' '
      IMPORTING
        result = icone.

  ENDIF.

ENDMODULE.                 " DETERMINAR_ICONE  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  DETERMINAR_ABA  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module DETERMINAR_ABA output.
case my_tab-activetab.
  when 'BOT1'.
    tela = '0310'.
    when 'BOT2'.
    tela = '0320'.
    when 'BOT3'.
    tela = '0330'.
    when OTHERS.
      my_tab-activetab = 'BOT1'.
      tela = '310'.
  endcase.
endmodule.                 " DETERMINAR_ABA  OUTPU