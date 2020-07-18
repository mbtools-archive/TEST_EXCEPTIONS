*&---------------------------------------------------------------------*
*& Report ZTEST_EXCEPTIONS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_exceptions_enh.

CLASS lcl_test DEFINITION.

  PUBLIC SECTION.
    CLASS-METHODS test
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS test_2
      RAISING
        zcx_abapgit_exception.

ENDCLASS.
CLASS lcl_test IMPLEMENTATION.

  METHOD test.
    DATA: lx_enh_root TYPE REF TO cx_enh_root.

    TRY.
        RAISE EXCEPTION TYPE cx_enh_io_error
          EXPORTING
            object = 'ENHO'
            objname = 'Z_ENH_1'.
      CATCH cx_enh_root INTO lx_enh_root.
        zcx_abapgit_exception=>raise( iv_text = lx_enh_root->get_text( )
                                      ix_previous = lx_enh_root ).
    ENDTRY.

  ENDMETHOD.

  METHOD test_2.
    DATA: lx_enh_root TYPE REF TO cx_enh_root.

    TRY.
        RAISE EXCEPTION TYPE cx_enh_permission_denied
          EXPORTING
            object = 'ENHO'
            objname = 'Z_ENH_2'.
      CATCH cx_enh_root INTO lx_enh_root.
        zcx_abapgit_exception=>raise( iv_text = lx_enh_root->get_text( )
                                      ix_previous = lx_enh_root ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: lx_error TYPE REF TO zcx_abapgit_exception.

  TRY.
      CALL METHOD lcl_test=>test( ).
    CATCH zcx_abapgit_exception INTO lx_error.
      WRITE: / lx_error->get_text( ).
  ENDTRY.

  TRY.
      CALL METHOD lcl_test=>test_2( ).
    CATCH zcx_abapgit_exception INTO lx_error.
      WRITE: / lx_error->get_text( ).
  ENDTRY.
