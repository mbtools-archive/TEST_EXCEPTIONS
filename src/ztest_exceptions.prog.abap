*&---------------------------------------------------------------------*
*& Report ZTEST_EXCEPTIONS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_exceptions.

CLASS lcl_test DEFINITION.

  PUBLIC SECTION.
    CLASS-METHODS test.

ENDCLASS.
CLASS lcl_test IMPLEMENTATION.

  METHOD test.
    DATA: lx_static TYPE REF TO cx_static_check.

    TRY.
        RAISE EXCEPTION TYPE zcx_test.
      CATCH cx_static_check INTO lx_static.
        WRITE: / lx_static->get_text( ).
    ENDTRY.

    TRY.
        RAISE EXCEPTION TYPE zcx_test2.
      CATCH cx_static_check INTO lx_static.
        WRITE: / lx_static->get_text( ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  CALL METHOD lcl_test=>test( ).
