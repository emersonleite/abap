*&---------------------------------------------------------------------*
*
*&---------------------------------------------------------------------*


REPORT  zabap_oo_rtti_00.

DATA:
  gr_wa   TYPE REF TO data,
  descompactar(10) TYPE n,

  go_descr TYPE REF TO cl_abap_structdescr,
  gs_component TYPE LINE OF abap_compdescr_tab.
FIELD-SYMBOLS: <gs_any> TYPE any.

PARAMETERS pa_tab TYPE dd02t-tabname VALUE CHECK
  OBLIGATORY DEFAULT 'SPFLI'.


START-OF-SELECTION.

  CREATE DATA gr_wa TYPE (pa_tab).
  ASSIGN gr_wa->* TO <gs_any>.

* get reference to type descripion object by downcast:
  go_descr ?= cl_abap_typedescr=>describe_by_data( <gs_any> ).

  LOOP AT go_descr->components INTO gs_component.
*    UNPACK gs_component-length TO descompactar .
    WRITE: AT /(20) gs_component-name, gs_component-length.
  ENDLOOP.
