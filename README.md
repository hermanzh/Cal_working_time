# Cal_working_time
##How to calculate your working time

1. 登录系统拉出自己想要计算的刷卡数据
2. 复制数据到2003版.xls格式excel文件
3. 执行 calTime.exe ./example.xls

##How to contribute code
1. install ruby
2. gem install ld
3. update main.rb, and run `main.rb example`

##How to pack .rb to .exe
1. gem install ocra
2. ocra .\main.rb --console --gem-full --output .\calTime.exe
