*&---------------------------------------------------------------------*
*& Report  ZABAP_P01_03
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZABAP_P01_03.

*Data declarations

PARAMETERS pa_num Type i. " input via selection screen
DATA gv_result Type i. " variable for internal use

* Processing
MOVE pa_num "One statement
  TO gv_result.  "over more than one line

DO 10 TIMES.
  ADD 1 TO gv_result.
ENDDO.

*output
write:'your input:',
  pa_num.

NEW-LINE.

WRITE: 'Result:', gv_result.