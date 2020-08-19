variable "rgname" {
    description = "Resource group to deploy artifacts for SAP autoscaling solution"
}
variable "location" {
    description = "Specify Azure region to deploy the solution"
}
variable "storageaccount" {
    description = "Name of the storage account to be used for SAP autoscaling config"
}
variable "automationaccount" {
    description = "Name of the Azure Automation account to be used for SAP autoscaling runbooks"
}
variable "logicapp-datacoll" {
    description = "Name of the Logic app to be used for data collection"
}
variable "logicapp-sapregister" {
    description = "Name of the Logic App to be used for SAP logon group registration"
}
variable "sapsid" {
    description = "SAP SystemID"
}
variable "loganalyticsworkspace" {
    description = "Log Analytics workspace to be used for SAP metrics collection"
}
variable "alertrecepient" { 
    description = "Email recepient for alerts generated and Logic app notification"
}
variable "datagateway" { 
    description = "On-prem datagateway to be used for SAP Connectivity"
}
variable "datacollectioninterval" {
    description = "SAP performance Data collection interval in minutes"
}
variable "sapodatauri" {
    description = "SAP Odata Url to be used for data collection by logic app"
}
variable "sapinstnacenr" {
    description = "SAP Instance number"
}
variable "sapodatauser" {
    description = "SAP Username to be used for Odata calls"
}
variable "sapregisteruser" {
    description = "SAP Username to be used for logon group registration"
}
variable "keyvault" {
    description = "Keyvault to retreive passwords of SAP users"
}

variable "sapclient" {
    description = "Client number of SAP system"
}

variable "sapmshost" {
    description = "SAP message server host to be used for creating connection from Logic app via ODG"
}

variable "sapmsport" {
    description = "SAP message server port to be used for creating connection from Logic app via ODG"
}

variable "saplogongroup" {
    description = "SAP Logon group to be used for creating connection from Logic app via ODG"
}