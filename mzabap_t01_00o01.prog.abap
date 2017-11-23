*----------------------------------------------------------------------*
***INCLUDE MZABAP_T01_00O01 .
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
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  SET PF-STATUS 'GUI-200'.
  IF flag IS INITIAL .
    SET TITLEBAR 'TIT-200D'.
  ELSE.
    SET TITLEBAR 'TIT-200A'.
  ENDIF.
ENDMODULE.                 " STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  LIMPAR_CAMPOS  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE limpar_campos OUTPUT.
  CLEAR: flag, flg, resp, zped_05, zview1_05.
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
*&      Module  STATUS_0300  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0300 OUTPUT.
  SET PF-STATUS 'GUI-300'.
  SET TITLEBAR 'TIT-300'.

ENDMODULE.                 " STATUS_0300  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  DETERMINAR_ABA  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE determinar_aba OUTPUT.
  CASE my_tab-activetab.
    WHEN 'BOT1'.
      tela = '0310'.
    WHEN 'BOT2'.
      tela = '0320'.
    WHEN 'BOT3'.
      tela = '0330'.
    WHEN OTHERS.
      my_tab-activetab = 'BOT1'.
      tela = '0310'.
  ENDCASE.
ENDMODULE.                 " DETERMINAR_ABA  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  DESBLOQUEAR_PEDIDO  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE desbloquear_pedido OUTPUT.
  CALL FUNCTION 'DEQUEUE_EZ_PEDIDO'
    EXPORTING
      numped = zped_05-numped.

ENDMODULE.                 " DESBLOQUEAR_PEDIDO  OUTPUT