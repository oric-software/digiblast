
#include "../orix/src/include/orix.h"
#include "../orix/src/include/ch376.h"
#include "../orix/src/include/macro.h"
#include "../orix/src/include/6551.h"
#include "../orix/src/include/keyboard.h"
#include "../orix/src/include/orix_vars.inc.asm"

#define Printerport $30F

#define DIGIBLST_SAVE_FP  ZP_APP_PTR1
.text
#ifdef WITH_ORIX

    *=$1000-20
; include header
  .byt $01,$00	      	; non-C64 marker like o65 format
  .byt "o", "r", "i"      ; "ori" MAGIC number :$6f, $36, $35 like o65 format
  .byt $01                ; version of this header
cpu_mode
  .byt $00                ; CPU see below for description
language_type
  .byt $00	             ; reserved in the future, it will define if it's a Hyperbasic file, teleass file, forth file 
  .byt $00                ; reserved
  .byt $00		            ; reserved
  .byt $00	              ; operating system id for telemon $00 means telemon 3.0 version
  .byt $00	              ; reserved
	.byt $00                ; reserved
type_of_file
	.byt %01001001                   ; Auto, direct, data for stratsed, sedoric, ftdos compatibility
	.byt <start_adress,>start_adress ; loading adress
	.byt <EndOfMemory,>EndOfMemory   ; end of loading adress
	.byt <start_adress,>start_adress ; starting adress
 
start_adress

	*=$1000
#endif

  ;sei

.(
  FOPEN(myfile,O_RDONLY)
  cpx #$ff
  bne next
  cmp #$ff
  bne next
  beq not_found
next
  sei
  lda #$ff
  sta $303
  lda #%0000100
  sta $302
  sta $300
  
.)

; [IN] AY contains the length to read
; [IN] PTR_READ_DEST must be set because it's the ptr_dest
; [IN] TR0 contains the fd id 


MegaLoop
lda #<Printerport
sta PTR_READ_DEST

lda #>Printerport
sta PTR_READ_DEST+1
lda #$00
ldy #$80

;FREAD($a000,8000,1,VIEWHRS_SAVE_FP)
;  FREAD(Printerport,100,1,DIGIBLST_SAVE_FP)
#include "../orix/src/functions/xread.asm"


/*
  LDA #$ff
  TAY 
  JSR _ch376_set_bytes_read

  LDA #CH376_RD_USB_DATA0
  STA CH376_COMMAND
  CMP #$1d ; Data buffer is valid
  BEQ ReadMusic
  CMP #$14 ; No data end file or error
  BEQ EndMusic

 
 
ReadMusic
  LDA CH376_DATA ; premier octet taille du buffer CH376 à lire
  TAY
MiniLoop
  LDA CH376_DATA ; read the data
  STA Printerport
  DEY
  BNE MiniLoop
 
 
  LDA #CH376_BYTE_RD_GO
  STA CH376_COMMAND
  ;JSR _ch376_wait_response
   */
  JMP MegaLoop

not_found
EndMusic
  LDA $00
  STA Printerport
  cli
  rts
  
  
#include "../orix/src/include/libs/xa65/ch376.s"
myfile
.asc "/usr/share/digibst/bigguns8.wav",0
fp
.dsb 100
/*
MegaLoop
LDA #$ff
TAY 
JSR _ch376_set_bytes_read

 
LDA #CH376_RD_USB_DATA0
STA CH376_COMMAND
CMP #$1d ; Data buffer is valid
BEQ ReadMusic
CMP #$14 ; No data end file or error
BEQ EndMusic

 
 
ReadMusic
LDA CH376_DATA ; premier octet taille du buffer CH376 à lire
TAY
MiniLoop
LDA CH376_DATA ; read the data
STA Printerport
DEY
BNE MiniLoop
 
 
LDA #CH376_BYTE_RD_GO
STA CH376_COMMAND
;JSR _ch376_wait_response
JMP MegaLoop
 

EndMusic
LDA $00
STA Printerport
*/

EndOfMemory
