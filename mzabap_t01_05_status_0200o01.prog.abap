*----------------------------------------------------------------------*
***INCLUDE MZABAP_T01_05_STATUS_0200O01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
 SET PF-STATUS 'GUI-200'.

  IF flag = 'X'.
    SET TITLEBAR 'TIT-200A'.
  ELSE.
    SET TITLEBAR 'TIT-200'.
  ENDIF.
ENDMODULE.                 " STATUS_0200  OUTPUT