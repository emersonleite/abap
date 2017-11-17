*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_01
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p05_01.

PARAMETERS: pa_v1 TYPE i,
            pa_v2 TYPE i,
            pa_op TYPE c.

DATA gv_result TYPE BC400_PERC.

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
  WHEN 'E'.
    CALL FUNCTION 'Z_CALC_EXPO_01'
      EXPORTING
        im_v1                     = pa_v1
        im_v2                     = pa_v2
      IMPORTING
        ex_resu                   = gv_result
      EXCEPTIONS
        expo_maior_que_quatro     = 1
        exponencial_nao_informado = 2
        valor_nao_informado       = 3
        OTHERS                    = 4.

    IF sy-subrc <> 0.
      CASE sy-subrc.
        WHEN '1'.
          MESSAGE i005(zmsg).
        WHEN '2'.
          MESSAGE i006(zmsg).
        WHEN '3'.
          MESSAGE i007(zmsg).
        WHEN OTHERS.
          MESSAGE i008(zmsg).
      ENDCASE.
      EXIT.
    ENDIF.

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