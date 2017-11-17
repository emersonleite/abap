*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_05
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p07_02.

DATA gt_voos TYPE zty_meus_voos.
DATA gs_voos LIKE LINE OF gt_voos.

PARAMETERS: pa_car TYPE sflight-carrid,
            pa_con TYPE sflight-connid.

CALL FUNCTION 'Z_LER_VARIOS_VOO'
  EXPORTING
    im_cia          = pa_car
    im_voo          = pa_con
  IMPORTING
    ex_voos         = gt_voos
  EXCEPTIONS
    voo_inexistente = 1
    OTHERS          = 2.

IF sy-subrc <> 0.
  CASE sy-subrc.
    WHEN 1.
      MESSAGE i009(zmsg)." WITH sy-subrc.
    WHEN 2.
      MESSAGE i008(zmsg).
  ENDCASE.
  EXIT.
ELSE.

  LOOP AT gt_voos INTO gs_voos.
    gs_voos-percentage = ( ( gs_voos-seatsocc ) * 100 ) / gs_voos-seatsmax.
    MODIFY TABLE gt_voos FROM gs_voos.
  ENDLOOP.

  SORT gt_voos BY percentage DESCENDING.

  LOOP AT gt_voos INTO gs_voos.
    WRITE: /'',gs_voos-carrid,'      ',
               gs_voos-connid,'   ',
               gs_voos-fldate,' ',
               gs_voos-seatsmax,'   ',
               gs_voos-seatsocc,'   ',
               gs_voos-percentage.
  ENDLOOP.

ENDIF.