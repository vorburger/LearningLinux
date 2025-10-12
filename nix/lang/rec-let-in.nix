let
  number = 23;
in
{
  foo = number + 1;
  inherit number; # number = number;
}
