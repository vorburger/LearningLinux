#!/usr/bin/expect -f
# NB: Using `autoexpect` helps write `expect` scripts!

set timeout 30

proc handle_timeout {} {
  puts "\n\nFAIL: Test timed out before completing succesfully :(\n"
  exit 1
}

proc handle_eof {} {
  puts "\n\nFAIL: Spawned command returned before expected text was seen :(\n"
  exit 2
}

spawn ./run-qemu
expect {
  # NO LONGER "end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)*"
  "hello, world" {
    # Ctrl-C
    send \x03
    expect eof
  }
  timeout { handle_timeout }
  eof { handle_eof }
}

spawn ./run-dev
expect {
  "tux@kernel-dev ~]$ " {
    send "exit\n"
    expect eof
  }
  timeout { handle_timeout }
  eof { handle_eof }
}

puts "./run-uml launched in background, because it messes up the console; output is in run-uml.log"
log_user 0
log_file -noappend -a run-uml.log
spawn ./run-uml
expect {
  "(core dumped) /tmp/linux" {
    puts "run-uml core dumped, as expected"
  }
  timeout { handle_timeout }
  eof { handle_eof }
}

puts "\n\nPASS: All tests successfully completed.\n"
exit 0
