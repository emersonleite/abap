*&---------------------------------------------------------------------*
*& Include MZABAP_T01_00TOP                                  Module Pool      SAPMZABAP_T01_00
*&
*&---------------------------------------------------------------------*

PROGRAM  SAPMZABAP_T01_00.

tables: zped_05, zview1_05.

data: ok_code type sy-ucomm,
      flag,
      icone type icons-text,
      flg,
      resp,
      tela type sy-dynnr.

CONTROLS my_tab type TABSTRIP.