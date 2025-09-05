{
  three = let
    sum = arg1: arg2: arg1 + arg2;
      add1 = sum 1;
    in
      add1 2;
}
