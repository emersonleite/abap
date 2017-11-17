*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_05
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p05_02.

DATA var_res TYPE bc400_perc.
PARAMETERS: pa_v1 TYPE i,
            pa_v2 TYPE i,
            pa_op TYPE c.

CASE pa_op.
  WHEN '+'.
    var_res = pa_v1 + pa_v2.
  WHEN '-'.
    var_res = pa_v1 - pa_v2.
  WHEN '*'.
    var_res = pa_v1 * pa_v2.
  WHEN '/'.
    IF pa_v2 = 0.
      MESSAGE i002(zmsg) WITH sy-uname.
      EXIT.
    ELSE.
      var_res = pa_v1 / pa_v2.
    ENDIF.
  WHEN '%'.
    PERFORM perc
    USING
      pa_v1
      pa_v2
    CHANGING
      var_res.
  WHEN 'E'.
    CALL FUNCTION 'Z_CALC_EXPO_02'
      EXPORTING
        im_v1                     = pa_v1
        im_v2                     = pa_v2
      IMPORTING
        ex_resu                   = var_res
      EXCEPTIONS
        expo_maior_que_quatro     = 5
        exponencial_nao_informado = 6
        valor_nao_informado       = 7
        OTHERS                    = 8.

    IF sy-subrc <> 0.
      CASE sy-subrc.
        WHEN 5.
          MESSAGE i005(zmsg)." WITH sy-subrc.
        WHEN 6.
          MESSAGE i006(zmsg).
        WHEN 7.
          MESSAGE i007(zmsg).
        WHEN 4.
          MESSAGE i008(zmsg).
      ENDCASE.
      EXIT.
    ENDIF.

  WHEN OTHERS.
    MESSAGE i001(zmsg) WITH pa_op.
    EXIT.
ENDCASE.

MESSAGE s003(zmsg) WITH var_res.
*&---------------------------------------------------------------------*
*&      Form  PERC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_PA_V1  text
*      -->P_PA_V2  text
*      <--P_VAR_RES  text
*----------------------------------------------------------------------*
FORM perc  USING    p_pa_v1 LIKE pa_v1
                    p_pa_v2 LIKE pa_v2
           CHANGING p_var_res.
  p_var_res = p_pa_v2 * 100 / p_pa_v1.
ENDFORM.                    "perc