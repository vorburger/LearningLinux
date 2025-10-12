let
  fix =
    f:
    let
      x = f x;
    in
    x;
in
fix (self: {
  number = 23;
  foo = self.number + 1;
})
