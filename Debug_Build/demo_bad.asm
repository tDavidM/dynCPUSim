;TEST Demo Loading from ASM File, shows a file that can successfully be parsed, it demonstrated by how much it can deviate while still being "valid" 
;Comment lines and blank lines are removed
;;Comment with a double semicolon are kept, adding a NOP instruction

                        SET   "0xFF",  $0                  ;But comment at the end of a line are kept after import
                        GETA  @"0xFF", $0                  ;The first 25 columns are for Labels only, then 5 columns for the instruction followed by 1 space
%TESTMACRO                                                 ;
[TESTMACRO                                                 ;
                        SETA  @"0b11111111" , $0           ;Each parameter is seperated by , and spaces are optional
:2ND_TEST   :TrdTest    IFNZ  $0,     goto#:SNDBLOCK:      ;Labels are not case sensitive, up to 2 per line, can be used for relative adresse with :
                        IFZ   $9,     #"255"               ;All characters used for readablity beside $ are optional (#@"=-<>?!|&) as well as "goto" tag
                        SIF   $0,  =  0xFF                 ;Labels can only use a-z 0-9 and _
                        ADD   $0,$1,   $2                  ;0b and 0x tags are required to indicate a binary or hexadecimal value
                        SUB   $0,   $1,$2                  ;
                        AND   $0,$1,$2                     ;Labels are always defined with a single : (left side) but when used (inside an instruction), a single : mean relative address
                        OR    ($C,   $1), ->  $2           ;  as opposed to double :: and :* used for absolute address
                        XOR   $0, ^ $1,   $2               ;  where :: provide the 4 most significant bits and :* the 4 least significant bits of an 8bits addr
                        WJMP  #::LBLTEST:                  ;WJMP is a special case as the data portion is 12 bits long, here ::LBLTEST outputs 0x002 as :LBLTEST is at 0x002A
                        SETV  @$0,    (0xFF)               ;When used (inside an instruction), Labels are also terminated by a :
                        GRT   $0, ? $2,  $1                ;
                        WJMPV #$0,       :*LBLTEST:        ;Here :*LBLTEST outputs 0x2A
:SNDBLOCK               NOT   $F,   $1                     ;
                        LSHT  ($A,   <    $1)              ;When Imported, the controls at the bottom of the ROM window are disabled
                        LROT  $0,        $1                ;Editing can only be done by pressing Clear and reimport the file
]
                        RSHT  $0,   >    $1         ;Comments at the end of a line don't have to be at a fixed position
                        RROT  $0,        $1                ;
                        SEQ   $0,        $1                ;
                        JMPA  #:SNDBLOCK_MACRO_0:          ;Labels inside a macro should not be called as they get renamed at import (for when the same macro is called multiple times)
                        GETR  @$0,       $1                ;
                        SETR  @$0,       $1                ;
                        SGRT  $0,        $1                ;
                        IFZR  $0,        #$1               ;
                        WJMPR #$0,       #$e               ;
                        LROTC $0,        $1                ;
                        RROTC $0,        $1                ;
%TESTMACRO 				                                   ;Macro can only be called outside it's own definition (no recursion)
                        RSHTA $0,        $1                ;Macro can be called before or after the definition
                        
                        JMPR  #$0                          ;The definition starts with [NAME and end with ]
                        CFLG  $0                           ;Calling a different Macro within a definition is valid
                        RSTC                               ;
                        SETC          ;ttt
                        INC   $D                           ;
                        DEC   $D                           ;
                        SIFZ  $D                           ;
                        RND   $D                           ;
:LAST_BLOCK    SIFNZ $D                           ;
                        SIFNC $D                           ;
                        DSINZ $D                           ;

:LBLTEST                        NOP                                                            ;fff