/*
Project 11
Chris Maidlow
11/29/18
Search function to find hockey player in struct
Insert function to insert player in order
Delete function delete player if found in table
*/

         .global delete
         .global search
         .global insert
        
         .data
address: 	.word     0
temp:	 	.skip	  8
temp2:   	.skip    32
new_player: .skip    80
X: 			.single  0r0.0

         .text
         .balign 4

@SEARCH FUNCTION
search:

        push {r4, r5, r6, r7, r8, r9, lr}
        
        
        ldrh	r4, [r0, #2]       				@load count into r4
        ldr		r5, [r0, #4]        			@load address of player table into r5
        
        mov 	r6, #0              			@initalize index to 0
        mov 	r7, #0			    			@initialize offset to 0 
        ldrb 	r9, [r5]           				@load jersey number
loop:

		cmp  	r9, r1							@while jersey lte to key
												@while index is not count
        bgt 	nomatch
        
        add 	r8, r5, r7          			@player base + offset
        ldrb 	r9, [r8] 
        cmp 	r9, r1              			@compare current key to provided key
        beq 	match
        
        cmp 	r6, r4
        beq 	nomatch
        
        add 	r7, r7, #0x28
        add 	r6, r6, #1          			@increment index
        
        b 		loop

match:

        mov 	r0, #1              			@return 1 for match
        str 	r8, [r2]            			@store player found address in r2
        b 		close

nomatch:
	
        mov 	r0, #0              			@return 0 for no match
        str 	r8, [r2]            			@store player found address in r2
							
        
close:
      
        pop {r4, r5, r6, r7, r8, r9, lr}
        bx lr  

@DELETE FUNCTION
delete:
        push {r4, r5, r6, r7, r8, r9, r10, r11, lr}

		mov  	r11, r0							@move start address
        ldrh 	r10, [r0]          				@load capacitiy into r10
        ldrh 	r4, [r0, #2]       				@load count into r4
        ldr 	r5, [r0, #4]        			@load address of player table into r5
        
        ldr     r2, =address   
        bl      search        					@call search function r0 = table, r1 = jersey number, r2 = pointer to pointer of player
												@if player is found the address to be deleted will be stored in r2
        
        ldr		r2, [r2]
        
        cmp 	r0, #0            				 @if player not found then exit function - "search returns 0 to r0 if not found"                  
        beq 	no_player   
        
		sub 	r4, r4, #1						@decrement count here
		strh 	r4, [r11, #2]					@store back in count
		
        mov 	r0, r2             				@move into r0   first player stored in r0
        add 	r1, r2, #0x28      				@player two
        mov 	r2, #0x28          				@40 byte move
        
loop_del:      
        
        mov 	r2, #0x28
        ldrb 	r9, [r0]          				@load jersey number
        ldrb 	r8, [r1]           
          
        bl 		memmove
        
        cmp 	r9, r8              			@compare current key to provided key
        bge 	close2
                
        add 	r0, r0, #0x28
       
        b loop_del
        b close2                            
        
no_player:
        
        mov 	r0, #0  
        pop 	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
        bx 		lr
        
close2:  
        mov 	r0, #1
        pop 	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
        bx 		lr  

@INSERT FUNCTION     
insert:

		push 	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
		
		ldr 	r6, =new_player

		strh 	r1, [r6]						@INSERT JERSEY
												@BEGIN INSERTION OF NAME
		ldr 	r7, [r2]
		str 	r7, [r6, #2]
		
		ldr 	r7, [r2, #4]
		str 	r7, [r6, #6]
		ldr 	r7, [r2, #8]
		str 	r7, [r6, #10]
		ldr 	r7, [r2, #12]
		str 	r7, [r6, #14]
		ldr 	r7, [r2, #16]
		str 	r7, [r6, #18]
		ldr 	r7, [r2, #20]
		str 	r7, [r6, #22]
		
		cmp 	r3, #0x0						@if no games played
		beq 	no_games

												@STATS INSERTION
		strh 	r3, [r6, #28]  					@ GAMES
			
		ldr 	r7, [sp, #36]
		ldr 	r8, [sp, #40]
		
	    strh 	r7, [r6, #30]
		strh 	r8, [r6, #32]
		
		add 	r8, r8, r7
		strh 	r8, [r6, #34]	 				@POINTS		
												@PPG CALCULATION
		fmsr 	s0, r8
		fsitos 	s1, s0
		fmsr 	s2, r3
		fsitos 	s3, s2
		
		fdivs 	s4, s1, s3
		ldr 	r7, =X
		fsts 	s4, [r7]
		
		ldr 	r7, =X
		ldr 	r8, [r7]
		
		str 	r8, [r6, #36]
		b 		continue
		
no_games:

		mov 	r8, #0x00
		str 	r8, [r6, #28]
		str 	r8, [r6, #30]
		str 	r8, [r6, #32]
		str 	r8, [r6, #34]
		str 	r8, [r6, #36]
		
continue:
		
		mov  	r11, r0							@move start address
        ldrh 	r10, [r0]          				@load capacitiy into r10
        ldrh 	r4, [r0, #2]       				@load count into r4
        ldr 	r5, [r0, #4]        			@load address of player table into r5
        
        cmp 	r10, r4
        beq 	no_insert
        
        ldr     r2, =address   
        bl      search    
		
		ldr		r2, [r2]
		
        cmp 	r0, #1             				@player already in table quit function
        beq 	no_insert   
        
        add 	r4, r4, #1						@increment count here
        strh 	r4, [r11, #2]
        
        @NEW
        ldrb r7, [r5]		
        cmp r1, r7 								@cmp jersey with first jersey
        blt less_than
        b not_first
        
less_than:
		
	    mov r2, r5								@protocal for appending to front

not_first:
        mov 	r4, r2
        
        mov 	r1, r2             				@move into r0 second player stored in r0
        add 	r0, r2, #0x28      				@player two
        mov 	r2, #0x28          				@40 byte move
        
loop_ins:

		mov 	r2, #0x28
        ldrb 	r9, [r1]           				@load jersey number
        ldrb 	r8, [r0]     

        mov 	r7, r0
        ldr 	r6, =temp						@create temp variable of entire player
        
        ldr 	r5, [r7]			
        str 	r5, [r6]
        
        ldr 	r5, [r7, #4]			
        str 	r5, [r6, #4]
        
        ldr 	r11, =temp2
        
        ldr 	r10, [r7, #8]			
        str 	r10, [r11]
        
        ldr 	r10, [r7, #12]			
        str 	r10, [r11, #4]
        
        ldr 	r10, [r7, #16]			
        str 	r10, [r11, #8]
        
        ldr 	r10, [r7, #20]			
        str 	r10, [r11, #12]
        
        ldr 	r10, [r7, #24]			
        str 	r10, [r11, #16]

		ldr 	r10, [r7, #28]			
        str 	r10, [r11, #20]
        
        ldr 	r10, [r7, #32]			
        str 	r10, [r11, #24]
        
        ldr 	r10, [r7, #36]			
        str 	r10, [r11, #28]
        
        bl 		memmove
        
        cmp 	r9, r8              			@compare current key to provided key
        bge 	close3
                
        add 	r0, r0, #0x28					@advance one player
        ldr 	r5, =temp
        ldr 	r6, [r5]
		str 	r6, [r1] 
		
		ldr 	r6, [r5, #4]
		str 	r6, [r1, #4]
		
		ldr 	r5, =temp2
		
		ldr 	r6, [r5]
		str 	r6, [r1, #8] 
		
		ldr 	r6, [r5, #4]
		str 	r6, [r1, #12] 
		
		ldr 	r6, [r5, #8]
		str 	r6, [r1, #16]

		ldr 	r6, [r5, #12]
		str 	r6, [r1, #20]
		
		ldr 	r6, [r5, #16]
		str 	r6, [r1, #24]
		
		ldr 	r6, [r5, #20]
		str 	r6, [r1, #28]
		
		ldr 	r6, [r5, #24]
		str 	r6, [r1, #32]
		
		ldr 	r6, [r5, #28]
		str 	r6, [r1, #36]
       
        b 		loop_ins
        b 		close3  


no_insert:
        
        mov 	r0, #0  
        pop 	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
        bx 		lr	
		
close3:  
		ldr 	r5, =new_player 				@find search address 
												@transfer from new_player to table
		ldr 	r6, [r5]
		str 	r6, [r4]
		
		ldr 	r6, [r5, #4]
		str 	r6, [r4, #4]
		
		ldr 	r6, [r5, #8]
		str 	r6, [r4, #8]
		
		ldr 	r6, [r5, #12]
		str 	r6, [r4, #12]
		
		ldr 	r6, [r5, #16]
		str 	r6, [r4, #16]
		
		ldr 	r6, [r5, #20]
		str 	r6, [r4, #20]
			
		ldr 	r6, [r5, #24]
		str 	r6, [r4, #24]
		
		ldrh 	r6, [r5, #28]
		strh 	r6, [r4, #28]
		
		ldrh 	r6, [r5, #30]
		strh 	r6, [r4, #30]
		
		ldrh 	r6, [r5, #32]
		strh 	r6, [r4, #32]
		
		ldrh 	r6, [r5, #34]
		strh 	r6, [r4, #34]

		@PPG BYTES
		ldr 	r6, [r5, #36]
		str 	r6, [r4, #36]
		
        mov 	r0, #1
        pop 	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
        bx 		lr 	
