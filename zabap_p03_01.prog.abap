*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_01
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p03_01.

PARAMETERS: pa_v1 TYPE i,
            pa_v2 TYPE i,
            pa_op TYPE c.

DATA gv_result TYPE p DECIMALS 2.

CASE pa_op.
  WHEN '+'.
    gv_result = pa_v1 + pa_v2.
  WHEN '-'.
    gv_result = pa_v1 - pa_v2.
  WHEN '/'.
    IF pa_v2 = 0.
      MESSAGE i002(zmsg) WITH sy-uname.
      EXIT.
    ENDIF.
    gv_result = pa_v1 / pa_v2.
  WHEN '*'.
    gv_result = pa_v1 * pa_v2.
  WHEN OTHERS.
    MESSAGE i001(zmsg) WITH pa_op.
    EXIT.
ENDCASE.

SKIP 2.

MESSAGE s003(zmsg) WITH gv_result.