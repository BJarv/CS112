//Brandon Jarvinen
//Pair Programming with: Logan Collingwood


#include <stdio.h>
#include <string.h>
 
//list of all number names to 19
const char *ones[] = { 0, "One", "Two", "Three", "Four",
	"Five", "Six", "Seven", "Eight", "Nine", 
	"Ten", "Eleven", "Twelve", "Thirteen", "Fourteen",
	"Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen" };

//list of ten multiples names
const char *tens[] = { 0, "Ten", "Twenty", "Thirty", "Forty",
	"Fifty", "Sixty", "Seventy", "Eighty", "Ninety" };

//list of all -illion number names including thousand
const char *illions[] = { 0, "Thousand", "Million", "Billion", "Trillion",
	"Quadrillion", "Quintillion", "Sextillion", "Septillion",
	"Octillion", "Nonillion", "Decillion", "Undecillion", "Duodecillion", 		"Tredecillion", "Quattourdecillion", "Quindecillion", "Sexdecillion",
	"Septendecillion", "Octodecillion", "Novemdecillion", "Vigintillion"
	};

//
const int umptillion = sizeof(illions) / sizeof(illions[0]) * 3 - 3;
 
int say_hundred(const char *s, int len, int depth, int has_lead)
{
	int c[3], i;
	for (i = -3; i < 0; i++) {
		if (len + i >= 0) c[i + 3] = s[len + i] - '0';
		else c[i + 3] = 0;
	}
	if (!(c[0] + c[1] + c[2])) return 0;
 
	if (c[0]) { //
		printf("%s Hundred", ones[c[0]]);
		has_lead = 1;
	}
	if (has_lead && (c[1] || c[2]))
		printf((!depth || c[0]) && (!c[0] || !c[1]) ? "and " :
			c[0] ? " " : "");
 
	if (c[1] < 2) {
		if (c[1] || c[2]) printf("%s", ones[c[1] * 10 + c[2]]);
	} else {
		if (c[1]) {
			printf("%s", tens[c[1]]);
			if (c[2]) putchar('-');
		}
		if (c[2]) printf("%s", ones[c[2]]);
	}
 
	return 1;
}
 
int say_umptillion(const char *s, int len, int depth, int has_lead)
{
	int n = len / 3, r = len % 3;
	if (!r) {
		n--;
		r = 3;
	}
	const char *e = s + r;
	do {
		if (say_hundred(s, r, n, has_lead) && n) {
			has_lead = 1;
			printf(" %s", illions[n]);
			if (!depth) printf(", ");
			else printf(" ");
		}
		s = e; e += 3;
	} while (r = 3, n--);
 
	return 1;
}

void say_number(const char *s)
{
	int len = 0;
	int i = 0;
	int posneg = 0;
 
	while (*s == ' ') s++; //skip any initial spaces preceding number string
	if (*s < '0' || *s > '9') { //check for bad input and negative numbers.
		if (*s == '-') posneg = -1;
		else if (*s == '+') posneg = 1;
		else goto nan;
		s++;
	} else
		posneg = 1; 
 
	while (*s == '0') { //get rid of leading zeros
		s++;
		if (*s == '\0') {
			printf("Zero\n");
			return;
		}
	}
 
	len = strlen(s);
	if (!len) goto nan;

	for (i = 0; i < len; i++) {
		if (s[i] < '0' || s[i] > '9') {
			printf("(Not a Number)");
			return;
		}
	}
	if (posneg == -1) printf("Negative "); //print negative if sign is minus
 
	int n = len / umptillion;
	int r = len % umptillion;
	if (!r) { 
		r = umptillion;
		n--;
	}
 
	const char *end = s + len - n * umptillion;
	int has_lead = 0;
	do {
		if ((has_lead = say_umptillion(s, r, n, has_lead))) {
			for (i = 0; i < n; i++)
				printf(" %s", illions[umptillion / 3]);
			if (n) printf(", ");
		}
		n--;
		r = umptillion;
		s = end;
		end += r;
	} while (n >= 0);

	printf("\n");
	return;
 
	nan:	printf("not a number\n");
	return;
}
 
int main(int argc, char** argv)
{
	say_number(argv[1]); 
	//says name of number string supplied to program at runtime
	return 0;
}
