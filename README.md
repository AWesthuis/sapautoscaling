# Auto scaling of SAP app servers in Azure
This terraform template sets up components required to achieve auto scaling of SAP application servers in Azure based on SAP performance metrics. 

[Solution Overview](#solution-overview)

[Setup Instructions](#setup-instructions)



# Solution Overview 

## SAP Application Server Scale out Architecture

![scaleout image](images/scaleout.PNG)

SAP work process utilization data is collected from /sdf/mon table using logic app and dumped to log analytics workspace. Azure monitor is then used to query the table and alert based on set thresholds. The alert triggers an automation runbook which creates new app servers using ARM templates and uses logic app to add the new SAP application server to logon groups. All config related to scaling is maintained in a table (called scalingconfig) within storage account. This includes properties of the new VM to be created, logon/server groups to be added to, max/min count for application servers etc. 

## SAP Application Server Scale down Architecture

![scaledown image](images/scaledown.PNG)

Scaledown is achieved by means of 2 automation runbooks.  The first runbook removes the application servers from the logon/server groups using logic app and schedules the second runbook based on a delay configurable using the scalingconfig table. This helps in existing user sessions to be drained out of SAP application server to be removed. The second runbook does a soft shutdown of the application server (shutdown timeout can also be configured using the config table) and then deletes the application servers.  Trigger for the scale down would depend on customer scenarios. It can be configured using one of the following methods

 - Schedule based - Schedule scale down runbook to be executed at the end of business day everyday. 
 - Utilization based
 - Alert status

##  :bulb: Solution Highlights

- Modular – Auto scaling solution can be plugged into customer’s existing monitoring and alerting infrastructure (including solution manager) by using webhooks to trigger the automation runbook.

- Runbooks can be used to schedule scaling for seasonal elasticity (month-end, peak trading period etc.). Increment size for scaling is configurable (i.e. add 'n' app servers for month-end)

- Configurable – Parameters for scaling can be customized per SID as required.

- Work process utilization dashboards (with longer retention) can be created from the custom logs table in log analytics workspace. 

# Setup Instructions

## Pre-requisites

- On-prem data gateway for logic app SAP connector to connect to SAP system using RFC. See here for details on how to set this up. [https://docs.microsoft.com/en-us/azure/logic-apps/logic-apps-gateway-connection] https://docs.microsoft.com/en-us/azure/logic-apps/logic-apps-gateway-connection
- ODATA service url on the SAP system for accessing data from /sdf/mon table. Please see sample instructions here for creating the ODATA service.
- Scripts in this repo uses custom VM images for building new application servers. Create a custom VM image of an existing application server VM by running ``sudo waaagent -deprovision`` (use without the user option to preseve sidadm user) as shown here[https://docs.microsoft.com/en-us/azure/virtual-machines/linux/capture-image] https://docs.microsoft.com/en-us/azure/virtual-machines/linux/capture-image .  Once the image is created note down the image id.  For ongoing image maintenance save the image in **Shared Image Gallery** and use **Azure Image Builder** to keep the image upto date.  If you want to use standard marketplace images, customize the ARM template and shell script appserver_setup.sh accordingly.

## Installation

-  Clone this github repo and populate terraform.tfvars. Sample file with parameters is availble in this repo.
-  Run ``terraform init`` followed by ``terraform apply`` to deploy the required resources.
