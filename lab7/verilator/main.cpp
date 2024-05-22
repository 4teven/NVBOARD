#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "Vtop.h"  //因为创建的是our_OnOff.v 所以头文件要包含Vour_OnOff.h(把V放在前面)

#include "verilated.h"
#include "verilated_vcd_c.h"

#define CLOCK_PERIOD 10
int main(int argc, char** argv, char** env) {
 
  VerilatedContext* contextp = new VerilatedContext;
  contextp->commandArgs(argc, argv);
  Vtop* top = new Vtop{contextp};
  
 
  VerilatedVcdC* tfp = new VerilatedVcdC; //初始化VCD对象指针
  contextp->traceEverOn(true); //打开追踪功能
  top->trace(tfp, 0); //
  tfp->open("wave.vcd"); //设置输出的文件wave.vcd
  //initialize
  top->clk = 0;
  top->clrn = 1;
  top->ps2_clk = 0;
  top->ps2_data = 0;
  
  while (!contextp->time()<1000) {
    if (contextp->time() % (CLOCK_PERIOD / 2) == 0) {
	top->clk = !top->clk;
    }
    if (contextp->time() % (CLOCK_PERIOD / 2) == 0) {
	top->ps2_clk = !top->ps2_clk;
    }
    // 复位信号控制
    if (contextp->time() > 20) {
	top->clrn = 0; // 在时间 20 之后释放复位信号
    }
    int ps2_data = rand()&1;
    top->ps2_data = ps2_data;
    top->eval();
 
    tfp->dump(contextp->time()); //dump wave
    contextp->timeInc(1); //推动仿真时间
  }
  delete top;
  tfp->close();
  delete contextp;
  return 0;
}
