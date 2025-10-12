{
  three =
    let
      sum =
        {
          arg1,
          arg2 ? 2,
        }:
        arg1 + arg2;
    in
    sum { arg1 = 1; };
}
