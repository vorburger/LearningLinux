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

spawn ./build
expect {
  "podman run --name hello --rm hello" { }
  "hello, world" { }
  timeout { handle_timeout }
  eof { handle_eof }
}
puts "\n\n"

spawn ./run-qemu hello
expect {
  "hello, world" {
    # Ctrl-C (`send \x03`) not required here, since hello.c does a clean ACPI Shutdown.
    expect eof
  }
  timeout { handle_timeout }
  eof { handle_eof }
}
puts "\n\n"

spawn ./run-qemu busybox-init
expect {
  # TODO Needed? "[-Please press Enter to activate this console-]"
  "/ # " {
    send "ping -c 1 8.8.8.8\r"
    expect "1 packets transmitted, 1 packets received, 0% packet loss"
    exp_continue
  }
  "/ # " {
    send "ping -c 1 google.com\r"
    exp_continue
  }
  "1 packets transmitted, 1 packets received, 0% packet loss" {
    send "poweroff\r"
    #TODO expect "...VM exited?"
  }
  timeout { handle_timeout }
  eof { handle_eof }
}
puts "\n\n"

# TODO re-enable when ./run-qemu-syslinux does nto require sudo anymore..
if 0 {
spawn ./run-qemu-syslinux /tmp/bzImage hello
expect {
  "hello, world" {
    # Ctrl-C (`send \x03`) not required here, since hello.c does a clean ACPI Shutdown.
    expect eof
  }
  timeout { handle_timeout }
  eof { handle_eof }
}
puts "\n\n"
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
puts "\n\n"

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
