*&---------------------------------------------------------------------*
*& Report  ZABAP_P01_01
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZABAP_P01_01.

PARAMETERS pa_num    TYPE i.
DATA       gv_result TYPE i.

MOVE pa_num TO gv_result.

DO 10 TIMES.
   ADD 1 to gv_result.
ENDDO.

WRITE: 'Your input:' ,pa_num.

NEW-LINE.

WRITE: 'Result:     ',gv_result.