278Program5
===========
1. Managing frame stacks and frame pointers
2. Recursive functions
3. Printing
4. Function calls

Equivalent program written in C
-------------------------
    void main()  {
      int x = 5;
      int y = 10;
      int z = 15;
      int w = 20;
      int v = 25;`
    }
    
    int sum (int x, int y, int w, int v, int z)  {
      int total = x + y + z + w + v;
      total += fact(total/5);
    }
    
    int fact (int n) {
      if (n < 1)  {
        return 1;
      }
      else
        return (n * fact(n - 1));
    }
