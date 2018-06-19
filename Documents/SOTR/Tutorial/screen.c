//#include "monitor.h"
#include "types.h"
#include "user.h"
#include "monitor.h"

int main(int argc,char *argv[])
{
  monitor_clear();
  monitor_write("Hello world!");
  exit();
}
