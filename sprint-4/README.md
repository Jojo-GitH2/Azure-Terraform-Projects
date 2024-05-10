[Home](../README.md) | [Sprint 1](README.md)

---

<p align="right">
    <img src="../.assets/logo-02.png" width="140x" />
</p>

# Knixat Cloud DevOps - Sprint 4

## Deploy a virtual machine in Azure (Linux or Windows) and outline the necessary configurations
- [Terraform Configuration](../.assets/sprint-4/terraform%20configurations/Deploy%20A%20VM/)

## Document the process of configuring high availability for a virtual machine
Configuring high availability (HA) for a virtual machine (VM) in Azure involves creating redundancy and failover mechanisms to ensure the VM remains available even in the event of hardware or software failures. Here's a step-by-step guide to configuring high availability for a VM in Azure:

**Step 1:** **Choose an Availability Option**

Azure offers several options for achieving high availability:

- **Availability Sets:** These are used when you want to distribute VMs across multiple fault domains and update domains within a datacenter. Availability Sets ensure that VMs are placed in separate racks to minimize the impact of hardware failures or planned maintenance.

- **Availability Zones:** These are used when you require even higher availability. Availability Zones are physically separate datacenters within an Azure region. VMs placed in different Availability Zones provide better protection against datacenter-level outages.

- **Azure Virtual Machine Scale Sets:** These are used for stateless applications that can horizontally scale. VM instances are automatically added or removed based on demand, ensuring high availability.

Choose the availability option that best suits your application's requirements.

**Step 2: Create or Move VM to an Availability Set, Availability Zone, or Scale Set**

If you are creating a new VM:

1. In the Azure portal, click on "Create a resource."
2. Choose "Compute" and then select "Virtual machine."
3. Follow the VM creation wizard, specifying the desired availability option (Availability Set, Availability Zone, or Scale Set) during the VM creation process.

If you have an existing VM that you want to make highly available:

1. Create an Availability Set, Availability Zone, or Scale Set if you haven't already.
2. Deallocate the VM by stopping it to prepare for the move.
3. Use the "Change configuration" option in the Azure portal to move the VM to the desired availability option.

**Step 3: Load Balancing (Optional)**

To distribute traffic across multiple VMs for better high availability, you can configure a load balancer:

1. In the Azure portal, navigate to "Create a resource" > "Networking" > "Load Balancer."
2. Follow the load balancer creation wizard to configure load balancing rules, health probes, and backend pools. Associate your VM instances with the load balancer.

**Step 4: Configure Monitoring and Alerts**

Set up monitoring and alerts to proactively identify issues and take action in case of failures. Azure provides services like Azure Monitor, Azure Application Insights, and Azure Alerts for this purpose.

**Step 5: Backup and Disaster Recovery**

Implement a backup and disaster recovery strategy to protect your data and applications. Azure offers services like Azure Backup and Azure Site Recovery for this purpose. Configure regular backups and replication to a secondary region for disaster recovery.

**Step 6: Regular Testing and Maintenance**

Regularly test your high availability configurations to ensure they work as expected. Perform maintenance tasks like patching and updating during planned maintenance windows to minimize disruption.

## Create and configure a virtual machine scale set (VMSS) using terraform

- [Terraform Configuration](../.assets/sprint-4/terraform%20configurations/Create%20VMSS/)

## Create a windows VM using Terraform and add a custom script extension to install IIS and Implement availability for the 2 VMs created

- [Terraform Configuration](../.assets/sprint-4/terraform%20configurations/Linux%20and%20Windows%20Availability/)

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
