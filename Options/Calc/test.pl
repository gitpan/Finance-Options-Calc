# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..1\n"; }
END {print "not ok 1\n" unless $loaded;}
use Finance::Options::Calc;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

print (b_s_call(80,80,20,30,5) eq "2.34170" ? "ok 2\n" : "not ok 2\n");

print (b_s_put(80,80,20,30,4.5) eq "2.13375" ? "ok 3\n" : "not ok 3\n");
