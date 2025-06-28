{ arg1, arg2 ? "default" }:
    if arg1 == arg2
      then "same"
      else "notsame"
