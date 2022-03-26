#include <stdio.h>


int asm_main( void );

void print_int_bin(int n) {
  int bin_num[32];
  // Generate the binary array
  for (int i = 32 - 1; i >= 0; --i) {
    if (n != 0) {
      bin_num[i] = n & 1;
      n >>= 1;
    } else {
      bin_num[i] = 0;
    }
  }
  // Print the result
  for (int i = 0; i < 32; ++i) {
    printf("%d", bin_num[i]);
  }
}


int main()
{
  int ret_status;
  ret_status = asm_main();
  return ret_status;
}
