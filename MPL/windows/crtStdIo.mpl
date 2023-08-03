"control.Nat32"     use
"control.Natx"      use
"conventions.cdecl" use

(Nat32) Natx {convention: cdecl;} "__acrt_iob_func" importFunction

stderr: [2n32 __acrt_iob_func];
