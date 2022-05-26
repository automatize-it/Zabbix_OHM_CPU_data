# Zabbix OHM CPU data template

This repo contains Zabbix template and script for collecting CPU data (temperature in Celsius only) on workstations with OS Windows (7+).

V 0.1 alpha. Works.

Template has autodiscover and contains prototypes with CPUs (supports more than one physical CPU and multiple cores) and temperatures, along with temperature trigger prototype (>60 C by default).

Script uses Open Hardware Monitor https://openhardwaremonitor.org/ wich must run in background, normally or in service mode using NSSM https://nssm.cc or similiar. OHM posts data to WMIC, and script collects data from WMIC.


Usage:
+ import template and add template to your hosts ;
+ copy ohmGetCpuData.cmd script to your Zabbix client user scripts dir ;
+ add UserParameter from zabbix_agentd.conf.add to your zabbix_agentd.conf. Do not forget to restart Zabbix agent ;
+ Enjoy.

Average t can be achieved by creting calculated item with formula like:
(last("ohm.cpu[tc,intelcpu,0,0]",0) + 
last("ohm.cpu[tc,intelcpu,0,1]",0) + 
last("ohm.cpu[tc,intelcpu,0,2]",0) + 
last("ohm.cpu[tc,intelcpu,0,3]",0))/4

<img src="https://raw.githubusercontent.com/automatize-it/Zabbix_OHM_CPU_data/master/scrShts/scr1.png" />
