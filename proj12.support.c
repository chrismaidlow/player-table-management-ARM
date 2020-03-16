#include "/user/cse320/Projects/project12.support.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
    
unsigned update( unsigned PC, unsigned IR, unsigned CPSR){
    
    
    unsigned int condition;
    unsigned int opcode;
    unsigned int function;
    unsigned int immediate;
    unsigned int value;
    
    condition = IR >> 28;
    opcode = (IR << 4) >> 30;
    funcition = (IR << 6) >> 30;
    immediate = (IR << 8) >> 8;
    
    N_bit = CPSR >> 31;
    Z_bit = (CPSR << 1) >> 31;
    C_bit = (CPSR << 2) >> 31;
    V_bit = (CPSR << 3) >> 31;
    
    printf("%d", condition);
    printf("%d", opcode);
    printf("%d", function);
    printf("%d", immediate);

    //BRANCH
    if (opcode == 2):
    
        if (condition == 0):
        
            if (Z_bit == 1):
                value = PC + sign_extend(immediate << 2);
                return value;
            else:
                value = PC + 4
                return value
    
        if (condition == 1):
        
            if (Z_bit == 0):
                value = PC + sign_extend(immediate << 2);
                return value;
            else:
                value = PC + 4
                return value
    
    
        if (condition == 2):
    
            if (C_bit == 1):
                value = PC + sign_extend(immediate << 2);
                return value;
            else:
                value = PC + 4
                return value
    
    
        if (condition == 3):
    
            if (C_bit == 0):
                value = PC + sign_extend(immediate << 2);
                return value;
            else:
                value = PC + 4
                return value
    
    
        if (condition == 4):
    
    
            if (N_bit == 1):
                value = PC + sign_extend(immediate << 2);
                return value;
            else:
                value = PC + 4
                return value 
    
    
        if (condition == 5):
    
            if (N_bit == 0):
                value = PC + sign_extend(immediate << 2);
                return value;
            else:
                value = PC + 4
                return value 
    
    
        if (condition == 6):
    
            if (V_bit == 1):
                value = PC + sign_extend(immediate << 2);
                return value;
            else:
                value = PC + 4
                return value 
    
    
        if (condition == 7):
    
            if (V_bit == 0):
                value = PC + sign_extend(immediate << 2);
                return value;
            else:
                value = PC + 4
                return value 
    
    
        if (condition == 8):
    
            if (C_bit == 1 && Z_bit == 0):
                value = PC + sign_extend(immediate << 2);
                return value;
            else:
                value = PC + 4
                return value 
    
        
        if (condition == 9):
    
            if (C_bit == 0 && Z_bit == 1):
                value = PC + sign_extend(immediate << 2);
                return value;
            else:
                value = PC + 4
                return value 
  
        if (condition == 10):
    
            if (N_bit == V_bit):
                value = PC + sign_extend(immediate << 2);
                return value;
            else:
                value = PC + 4
                return value 
    
    
        if (condition == 11):
    
            if (N_bit != V_bit):
                value = PC + sign_extend(immediate << 2);
                return value;
            else:
                value = PC + 4
                return value 
    
    
        if (condition == 12):
    
            if ((N_bit == V_bit) && (Z_bit == 0)):
                value = PC + sign_extend(immediate << 2);
                return value;
            else:
                value = PC + 4
                return value 
    
        
        if (condition == 13):
    
            if ((N_bit != V_bit) || (Z_bit == 1)):
                value = PC + sign_extend(immediate << 2);
                return value;
            else:
                value = PC + 4
                return value 
    
        if (condition == 14):
    
            value = PC + sign_extend(immediate << 2);
            return value;
    
        if (condition == 15):
    
            return 0
      
    //DATA MOVEMENT
    if (opcode == 1):
    
		return 0 
       
    //DATA PROCESSING
    if (opcode == 0):
    
		return 0
    
    //ILLEGAL 
    if (opcode == 3):
    
        return 0
    
