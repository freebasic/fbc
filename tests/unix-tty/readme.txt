This directory contains a tester program and various testee programs,
for testing some of the issues related to tty state handling of FB's unix rtlib.

The tester uses C++ (to avoid the test environment from being contaminated by an FB runtime),
captures the original TTY state, runs each testee FB program and checks the TTY state afterwards everytime.
Any changes in TTY state means that the testee FB program did not clean it up properly and is treated as test failure.

What does the FB runtime do that's visible externally (i.e. affecting system
state outside the FB program/process) and that could be tested this way?
- For the input/output ttys (if stdin/stdout are ttys): It adjusts tty settings,
  e.g. disables echoing, and some other settings. See fb_hInitConsole() and fb_hExitConsole().
  We can check this via tcgetattr().
- (Re-)Configures the terminal by sending escape codes on stdout (see SEQ_INIT_* and SEQ_EXIT_* in the rtlib).
  I don't know how we can check this - are there any terminal escape codes/control sequences to query the status
  of settings used by the FB runtime?
