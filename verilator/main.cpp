#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "Vour_OnOff.h"  //因为创建的是our_OnOff.v 所以头文件要包含Vour_OnOff.h(把V放在前面)
#include "verilated.h"
#include "verilated_vcd_c.h"
 
int main(int argc, char** argv, char** env) {
 
  VerilatedContext* contextp = new VerilatedContext;
  contextp->commandArgs(argc, argv);
  Vour_OnOff* top = new Vour_OnOff{contextp};
  
 
  VerilatedVcdC* tfp = new VerilatedVcdC; //初始化VCD对象指针
  contextp->traceEverOn(true); //打开追踪功能
  top->trace(tfp, 0); //
  tfp->open("wave.vcd"); //设置输出的文件wave.vcd
 
 
  while (!contextp->gotFinish()) {
    int a = rand() & 1;
    int b = rand() & 1;
    top->a = a;
    top->b = b;
    top->eval();
    printf("a = %d, b = %d, f = %d\n", a, b, top->f);
 
    tfp->dump(contextp->time()); //dump wave
    contextp->timeInc(1); //推动仿真时间
 
    assert(top->f == a ^ b);
  }
  delete top;
  tfp->close();
  delete contextp;
  return 0;
