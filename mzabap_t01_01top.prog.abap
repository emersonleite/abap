*&---------------------------------------------------------------------*
*& Include MZABAP_T01_01TOP                                  Module Pool      SAPMZABAP_T01_01
*&
*&---------------------------------------------------------------------*

PROGRAM  sapmzabap_t01_01.

TABLES: zped_01, zview1_01.


DATA: ok_code TYPE sy-ucomm,
      flag,
      icone TYPE icons-text,
      flg,
      resp,
      tela TYPE sy-dynnr.

CONTROLS my_tab TYPE TABSTRIP.