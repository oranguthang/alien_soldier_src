; Macros for AS assembler
; Based on Sonic 1 disassembly MacroSetup.asm

; define the cnop pseudo-instruction (alignment with offset)
cnop macro offset,alignment
	org (*-1+(alignment)-((*-1+(-(offset)))#(alignment)))
    endm

; define an alternate cnop that fills the extra space with 0s instead of FFs
cnop0 macro offset,alignment
	org0 (*-1+(alignment)-((*-1+(-(offset)))#(alignment)))
    endm

; redefine align in terms of cnop, because the built-in align can be stupid sometimes
align macro alignment
	cnop 0,alignment
    endm

; define an alternate org that fills the extra space with 0s instead of FFs
org0 macro address
.diff := address - *
	if .diff < 0
		error "too much stuff before org0 $\{address} ($\{(-.diff)} bytes)"
	else
		while .diff > 1024
			; AS can only generate 1 kb of code on a single line
			dc.b [1024]0
.diff := .diff - 1024
		endm
		dc.b [.diff]0
	endif
    endm

; define an alternate align that fills the extra space with 0s instead of FFs
align0 macro alignment
	cnop0 0,alignment
    endm
