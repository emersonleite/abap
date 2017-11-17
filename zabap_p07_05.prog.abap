*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_05
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p07_05.

DATA: gt_voos TYPE zty_meus_voos,  gs_voos LIKE LINE OF gt_voos.
PARAMETERS: pa_cia TYPE sflight-carrid, pa_con TYPE sflight-connid.

CALL FUNCTION 'Z_LER_VARIOS_VOO'
  EXPORTING
    im_cia          = pa_cia
    im_voo          = pa_con
  IMPORTING
    ex_voos         = gt_voos
  EXCEPTIONS
    voo_inexistente = 1
    OTHERS          = 2.
IF sy-subrc <> 0.
  CASE sy-subrc.
    WHEN '1'.
      MESSAGE i011(zmsg) WITH sy-subrc.
      EXIT.
    WHEN OTHERS.
      MESSAGE i010(zmsg) WITH sy-subrc.
      EXIT.
  ENDCASE.
ENDIF.
*
*LOOP AT gt_voos INTO gs_voos.
*
*  WRITE: 'CIA:', gs_voos-carrid,
*      / 'Número:', gs_voos-connid,
*      / 'Data:', gs_voos-fldate,
*      / 'Num Acentos Máximo:', gs_voos-seatsmax,
*      / 'Acentos Ocupados:', gs_voos-seatsocc,
*      / '%:', gs_voos-percentage,
*      /,
*      /.
*ENDLOOP.

LOOP AT gt_voos INTO gs_voos.

  gs_voos-percentage = gs_voos-seatsocc / gs_voos-seatsmax * 100.

  MODIFY TABLE gt_voos FROM gs_voos.

ENDLOOP.

SORT gt_voos BY percentage DESCENDING.

* WRITE :10 'CIA', 10 'Número', 10 'Data', 10 'Acentos Máx', 10 'Acentos Ocupados', 10 '% de Ocupação'.

LOOP AT gt_voos INTO gs_voos.

  WRITE: gs_voos-carrid, gs_voos-connid, gs_voos-fldate, gs_voos-seatsmax, gs_voos-seatsocc, gs_voos-percentage, '%', /.
ENDLOOP.