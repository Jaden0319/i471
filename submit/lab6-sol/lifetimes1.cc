#include <iostream>

class C {
public:
  //constructor
  C(const char *addrType, int val) : addrType(addrType), val(val) {
    std::cerr << "alloc (" << addrType << ", " << val << ")\n";
  }
  //destructor
  ~C() { std::cerr << "free (" << addrType << ", " << val << ")\n"; }

private:
  const char *addrType;
  int val;  
};


//recursive function: allocs a stack C; recurses with n-1 if n > 0;
//destroys c and returns new C if n == 0.
static C *f2(C *c, int n) {
  static C c0("static", -120);
  C c1("stack", 100);
  if (n > 0) {
    return f2(c, n - 1);
  }
  else {
    delete c;
    return new C("heap", -100);
  }
}

//create static C, stack C and heap C.  The latter is passed onto f2().
static C *f1(int n) { 
  static C c0("static", -20);
  C c1("stack", 10*n + 1);
  C *c2 = new C("heap", 10*n + 3);
  return f2(c2, n);
}


int main() {
  C *c = f1(1);
  delete c;
}
  
  
