[Home](../README.md) | [Sprint 1](README.md)

---

<p align="right">
    <img src="../.assets/logo-02.png" width="140x" />
</p>

# Knixat Cloud DevOps - Sprint 1
<h1>Cloud providers comparisons </h1>
<h3> comparison of some of the top cloud providers - AWS, Azure, GCP, and Alibaba Cloud: </h3>

<h3>Services Offered:</h3>

- AWS has the most comprehensive set of over 200 cloud services including compute, storage, networking, databases, analytics, machine learning, IoT, security etc. Leads in IaaS and PaaS.

- Azure has over 600 services for enterprises focused on Windows workloads, .NET, Office 365 integration, hybrid cloud, and management tools. Strong in PaaS and SaaS. 

- Google Cloud has services around compute, storage, networking, big data, machine learning but fewer peripheral services compared to AWS and Azure. Strong in containers, serverless and analytics.

- Alibaba Cloud has over 100 cloud services and is expanding quickly. Competitive in IaaS, PaaS. Also has database, security and enterprise solutions.

<h3>Infrastructure and geographic coverage:</h3>

- AWS has 24 geographic regions worldwide with 77 availability zones globally. Offers the most extensive data center footprint.

- Microsoft Azure is available in over 60 regions and continues expanding. Azure has a big presence in India. 

- Google Cloud has 24 regions available globally and is expanding to more countries.

- Alibaba Cloud has deployed 22 availability zones globally and has a big presence in Asia Pacific.

<h3>Pricing and Billing:</h3> 

- AWS offers pay-as-you-go billing with per second metering of resources. Savings plans and reserved instances help lower costs.

- Azure has per-second billing. Has cost management tools and offers discounts for long-term use.

- Google Cloud offers sustained use discounts for long-running workloads. Committed use discounts also available.

- Alibaba Cloud offers hourly and monthly billing. Provides resource packs for additional savings on services.

Overall, AWS leads in adoption and maturity of services. Azure is popular for Windows environments and hybrid cloud. Google provides expertise in containers, ML and analytics. Alibaba Cloud caters well to startups with lower costs.

## Compare Cloud Service Providers and Present Findings

## Group Members

- [Jonah Uka](https://www.github.com/jojo-gith2)
- [Gabriel Adesanya](https://www.github.com/Adesanya07)

## Create an Azure Storage Account in Resource Group.

### Prerequisites

- An Azure Account
- Azure CLI Installed
- Already logged in to Azure CLI

### Steps

1. **Create a resource group**

   ```bash
   az group create --name <resource-group-name> --location <location>
   ```

   Or

   ```bash
   az group create -l <location> -n <resource-group-name>
   ```

   ```bash
   az group create -l uksouth -n Uranus
   ```

   <p align="left">
       <img src="../.assets/sprint-1%20images/create%20resource%20group.png" width="600x" />
   </p>

2. **Create a storage account**

   ```bash
   az storage account create --name <storage-account-name> --resource-group <resource-group-name> --location <location> --sku <sku> --kind StorageV2
   ```

   Or

   ```bash
   az storage account create -n <storage-account-name> -g <resource-group-name> -l <location> --sku <sku> --kind StorageV2
   ```

   ```bash
   az storage account create --name sprint1 --resource-group Uranus --location uksouth --sku Standard_LRS --kind StorageV2
   ```

**Note:** The following parameters are used in the above command:

> - **--name**: Set the name for your storage account
> - **--resource-group**: Specify the name of the resource group where the storage account will be created.
> - **--location uksouth**: According to this [tool](https://gyxi.com/which-azure-region-is-closest-to-me/), one of the closest regions to us is UK South. So we selected UK South as the location for our storage account to reduce latency.
> - **--sku Standard_LRS**: We selected the Standard_LRS SKU, which is the standard storage account type for Azure Storage. It provides the lowest storage cost and is used for applications with non-critical data and lower availability requirements. Since we are not sure what we will be storing in the storage account, we selected the standard storage account type.
> - **--kind StorageV2**: We selected the StorageV2 kind because it is the standard storage account type for blobs, file shares, queues, and tables. Recommended for most scenarios using Azure Storage.

<div align="center">
    <img src="../.assets/sprint-1 images/create%20storage%20account.png" width="400px" style="display: inline-block; margin-right: 20px;" />
    <img src="../.assets/sprint-1 images/storage account on portal.png" width="400px" style="display: inline-block;" />
</div>

## Group Name

### Team Uranus

- _Source: Greek Mythology_

---

<p align="left">
    <img src="../.assets/logo-03.png" width="50x" />
</p>

**Contact Us:**  
Email: [admissions@knixat.com](mailto:admissions@email.com)  
Website: [www.knixat.com](https://www.knixat.com)

&copy; 2023 Knixat. All Rights Reserved.

---

[Home](../README.md) | [Sprint 1](README.md)
