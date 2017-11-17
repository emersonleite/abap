*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_01
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p04_01.

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
  WHEN '%'.
    PERFORM calc_perc
    USING pa_v1
          pa_v2
    CHANGING gv_result.
  WHEN OTHERS.
    MESSAGE i001(zmsg) WITH pa_op.
    EXIT.
ENDCASE.

SKIP 2.

MESSAGE s003(zmsg) WITH gv_result.
*&---------------------------------------------------------------------*
*&      Form  CALC_PERC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_PA_V1  text
*      -->P_PA_V2  text
*      <--P_GV_RESULT  text
*----------------------------------------------------------------------*
FORM calc_perc  USING    p_pa_v1 LIKE pa_v1
                         p_pa_v2 LIKE pa_v2
                CHANGING p_gv_result LIKE gv_result.

  p_gv_result = p_pa_v1 * ( p_pa_v2 / 100 ).

ENDFORM.                    " CALC_PERC