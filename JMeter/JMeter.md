# **JMeter**

[one example](https://www.cnblogs.com/stulzq/p/8971531.html)

## **JMeter Elements: Thread Group, Samplers, Listeners, Configuration**

![Complete Element reference for Jmeter](/home/lemon/Workspace/myCheatSheet/JMeter/pic/Jmeter.png)

### Thread Group

- Each Thread simulates **one real user** request to the server.

### Samplers

- 一个独立的组件,用来控制JMeter用哪些protocol.
- ![Complete Element reference for Jmeter](/home/lemon/Workspace/myCheatSheet/JMeter/pic/Samplers.png)
    - FTP: file transfer
    - JDBC: This sampler lets you execute Database [Performance Testing](https://www.guru99.com/performance-testing.html). It sends a JDBC Request (an SQL query) to a database. (**What is database server?**)
    - [其他协议](https://www.guru99.com/jmeter-element-reference.html)

### Listeners

- Shows the **results** of the test execution. They can show results in a different format such as a tree, table, graph or log file.

### Configuration Elements

- Set up defaults and variables for later use by samplers.

- ![Complete Element reference for Jmeter](https://www.guru99.com/images/ConfigurationElements.png)
    - CSV Data Set Config:

        - Simulate **multiple** login with password and user name, input these info as a CSV.

        - This is an example of CSV Data. It's a text file which contains user and password to login your target website

            ![img](/home/lemon/Workspace/myCheatSheet/JMeter/pic/CSVData(2).png)

    - Login Config Element: 

        - Simulate **one** user login