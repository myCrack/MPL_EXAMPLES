"control.Int32"     use
"control.Int64"     use
"control.Nat64"     use
"control.REF_SIZE"  use
"control.Ref"       use
"control.drop"      use
"control.ensure"    use
"control.keep"      use
"conventions.cdecl" use

monotonicTimeStamp: [
  tp: timespec;
  @tp CLOCK_BOOTTIME clock_gettime drop

  tp.tv_sec Nat64 cast 1000000000n64 * tp.tv_nsec Nat64 cast +
];

monotonicTimeStampFrequency: [mtsFreq new];

CLOCK_BOOTTIME: [7];

timespec: [{
  tv_sec: REF_SIZE 8 = [Int64] [Int32] if;
  tv_nsec: tv_sec new;
}];

{
  clk_id: Int32;
  res:    timespec Ref;
} Int32 {convention: cdecl;} "clock_getres" importFunction

{
  clk_id: Int32;
  tp:     timespec Ref;
} Int32 {convention: cdecl;} "clock_gettime" importFunction

mtsFreq:
  [
    1000000000n64 timespec [
      CLOCK_BOOTTIME clock_getres [0 =] "[Posix.clock_getres] filed" ensure
    ] keep .tv_nsec Nat64 cast / # We expect nanoseconds only to be presented.
  ] call
;
