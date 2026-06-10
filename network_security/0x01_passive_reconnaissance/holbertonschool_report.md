# Report: Shodan Reconnaissance on `holbertonschool.com`

**Date:** December 24, 2025
**Target Domain:** `holbertonschool.com`

## 1. Executive Summary

This report presents the results of a passive reconnaissance assessment of the `holbertonschool.com` domain using Shodan and other OSINT techniques. The objective was to identify the network infrastructure, associated IP ranges, known subdomains, and technologies exposed by the target. Findings indicate that the domain primarily relies on Amazon Web Services (AWS), with AWS Load Balancers providing a scalable and resilient hosting environment.

---

## 2. Network Infrastructure and IP Ranges

The infrastructure behind `holbertonschool.com` is cloud-hosted and does not appear to use a dedicated static IP block. Instead, it utilizes Amazon's public cloud services.

### Infrastructure Details

* **Hosting Provider:** Amazon Web Services (AWS)
* **Organization:** Amazon.com
* **ASN:** AS16509 (AMAZON-02)

### IP Allocation

The domain resolves to IP addresses associated with AWS Elastic Load Balancers (ELB), meaning the addresses can change over time.

Common AWS ranges associated with the service include:

* `3.0.0.0/8`
* `52.0.0.0/8`
* `54.0.0.0/8`

**Note:** Since AWS load balancing is used, the exact IP addresses may vary depending on the time of the query.

### Verification Command

```bash
shodan search hostname:holbertonschool.com --fields ip_str,port,org,hostnames
```

---

## 3. Identified Subdomains

DNS enumeration and certificate transparency logs revealed several publicly accessible subdomains.

| Subdomain | Purpose            | Description                             |
| --------- | ------------------ | --------------------------------------- |
| www       | Main Website       | Public-facing information and marketing |
| apply     | Admissions Portal  | Student application management          |
| intranet  | Student Portal     | Curriculum and internal resources       |
| api       | API Services       | Backend application endpoints           |
| tools     | Internal Utilities | Staff and educational support tools     |

### Subdomain Enumeration

```bash
shodan domain holbertonschool.com
```

---

## 4. Technologies and Frameworks

Technology identification was performed through HTTP headers, service fingerprints, and Shodan component detection.

### Web Infrastructure

* **Nginx**

  * Commonly deployed as a reverse proxy for web services.

* **AWS Elastic Load Balancer (ELB)**

  * Distributes incoming traffic across backend resources.

### SSL/TLS

* Amazon-issued SSL certificates.
* Let's Encrypt certificates observed on selected subdomains.

### Frameworks and Development Stack

* **Ruby on Rails**

  * Historical indicators suggest Rails is used for portions of the platform.

* **React / Webpack**

  * Frontend assets indicate the use of modern JavaScript tooling.

### Cloud Services

* Amazon CloudFront for content delivery.
* Amazon Route 53 for DNS management.

### Technology Detection Command

```bash
shodan count hostname:holbertonschool.com --facets http.component,product,version
```

---

## 5. Methodology

The following Shodan CLI commands can be used to reproduce and validate the findings presented in this report.

### Domain Overview

```bash
shodan domain holbertonschool.com
```

Displays DNS records, associated subdomains, and related IP addresses.

### IP Address Discovery

```bash
shodan search hostname:holbertonschool.com --fields ip_str
```

Returns IP addresses currently indexed for the target domain.

### Technology Enumeration

```bash
shodan stats hostname:holbertonschool.com --facets http.component
```

Provides aggregated information about technologies and software components identified on the domain's infrastructure.

---

## Conclusion

The passive reconnaissance of `holbertonschool.com` indicates that the domain is hosted on AWS infrastructure and makes use of cloud-native services such as Elastic Load Balancing, CloudFront, and Route 53. Multiple subdomains support different organizational functions, while the observed technology stack includes Nginx, Ruby on Rails, React, and modern AWS networking services. Shodan provides an efficient method for monitoring these assets and identifying changes in the exposed infrastructure over time.
