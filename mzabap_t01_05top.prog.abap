*&---------------------------------------------------------------------*
*& Include MZABAP_T01_05TOP                                  Module Pool      SAPMZABAP_T01_05
*&
*&---------------------------------------------------------------------*

PROGRAM  sapmzabap_t01_05.

TABLES: zped_05,
        zview1_05.

DATA: ok_code TYPE sy-ucomm,
      flag,
      icone TYPE icons-text,
      flg,
      resp,
      tela TYPE sy-dynnr.

CONTROLS my_tab TYPE TABSTRIP.