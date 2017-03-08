application-dev.yml    	开发环境
application-pro.yml    	生产环境
application-test.yml	测试环境
application.yml			主配置
logback.xml				内嵌tomcat日志配置文件

nohup java -jar *.jar -server -XX:-UseGCOverheadLimit -Xmx1024m -verbose:gc -XX:+PrintGCDetails -XX:+HeapDumpOnOutOfMemoryError -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSCnly -XX:CMSInitiatingOccupancyFraction=70  --logging.config=./logback.xml > /dev/null 2>&1