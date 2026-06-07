#include <stdio.h>
void main(){
    
    
    // logical operators 
	int a=10;
	int b=3;
	printf("(a > 5 && b < 10)  :%B\n",(a < 5 && b < 10) );
	//logical AND operator
	printf("(a > 5 || b < 10)  :%B\n",(a < 5 || b < 10) );
	//logical or
	printf("!(a<b)  :%B\n",!(a<b));
	
	//assignment operators
	int p=10;
	printf("Initial value of p:%d\n",p);
// 	p+=1;
// 	printf("after value of p:%d\n",p);
//	p-=1;;
    //p/=2;
       // p*=2=;
     //  p%=3;
	printf("after value of p:%d\n",p);
	
	int q=2;
//	q++;
	q--;
	printf("%d",q);
	
	//bitwise operators
	int x=2;
	int y=3;
	printf("\nbitwise a&b: %d \n", a&b);
	printf("bitwise a|b: %d \n", a|b);
	printf("bitwise not ~:%d", ~a);
}