*&---------------------------------------------------------------------*
*& Include MZABAP_T01_04TOP                                  Module Pool      SAPMZABAP_T01_04
*&
*&---------------------------------------------------------------------*

PROGRAM  sapmzabap_t01_04.

TABLES: zped_04, zview1_04.

DATA: ok_code TYPE sy-ucomm,
      flag,
      icone TYPE icons-text,
      flg,
      resp,
      tela TYPE sy-dynnr.

CONTROLS my_tab TYPE TABSTRIP.