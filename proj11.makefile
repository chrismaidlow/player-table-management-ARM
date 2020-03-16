proj11:   proj11.support.o
	gcc -Wall proj11.support.o /user/cse320/Projects/project11.driver.o -o proj11
	
	
proj11.support.o: proj11.support.s
	gcc -march=native -c proj11.support.s
