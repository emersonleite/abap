*----------------------------------------------------------------------*
***INCLUDE MZABAP_T01_020O01 .
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
  IF flag IS INITIAL.
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
  CLEAR: flag.

ENDMODULE.                 " LIMPAR_CAMPOS  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  ALTERAR_ATRIBUTOS  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE alterar_atributos OUTPUT.
  IF flag IS NOT INITIAL.
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
  IF flag IS NOT INITIAL.

    CALL FUNCTION 'ICON_CREATE'
      EXPORTING
        name       = 'ICON_GREEN_LIGHT'
        text       = ' '
*       INFO       = ' '
*       ADD_STDINF = 'X'
      IMPORTING
        result     = icone.

  ELSE.

    CALL FUNCTION 'ICON_CREATE'
      EXPORTING
        name       = 'ICON_RED_LIGHT'
        text       = ' '
*       INFO       = ' '
*       ADD_STDINF = 'X'
      IMPORTING
        result     = icone.

  ENDIF.

ENDMODULE.                 " DETERMINAR_ICONE  OUTPUT