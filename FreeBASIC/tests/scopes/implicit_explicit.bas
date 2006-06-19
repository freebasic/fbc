a = 1 
scope 
  dim a 
  b = 7 
  scope 
    dim b 
    scope 
      c = 11 
      scope 
        a = 5 
        b = 3 
        assert(a = 5) 
        assert(b = 3) 
        assert(c = 11) 
      end scope 
      assert(a = 5) 
      assert(b = 3) 
      assert(c = 11) 
    end scope 
    assert(a = 5) 
    assert(b = 3) 
    '' c = c '' quiet implicit var warning 
    assert(c = 0) 
  end scope 
  assert(a = 5) 
  assert(b = 7) 
  '' c = c '' quiet implicit var warning 
  assert(c = 0) 
end scope 
assert( a = 1) 
'' b = b '' quiet implicit var warning 
assert(b = 0) 
'' c = c '' quiet implicit var warning 
assert(c = 0) 
