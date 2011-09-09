' TEST_MODE : COMPILE_ONLY_OK

Type barFwd As bar

Type foo
As barFwd Ptr stuff_

Declare Property stuff As barFwd Const Ptr
End Type

Type bar
As Integer a = 4
End Type

Property foo.stuff As barFwd Const Ptr
Return stuff_
End Property
