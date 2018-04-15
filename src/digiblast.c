



lda #10
sta $320 ; cela envoie 10 sur les 8 bits du port //


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

